Return-Path: <stable+bounces-195762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2431BC796BE
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6ED0033824
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5F2765FF;
	Fri, 21 Nov 2025 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwseR29b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D6190477;
	Fri, 21 Nov 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731589; cv=none; b=B2tLUpEF1BokhkiSseXH2d9RpQLHbE4RBl/r4a5J5LH49TWkZNMTuy7QCK41SSp0Qn8GA68UayGQcJ0CZvcVWcmFlGDyRkjdnzRRjBZ8t8kc55QQZ8p+26IEY+vxzmhW/Qv5vQRqIz/ShSGJRdECEOUOyoDgKuJr9fxfEkpuLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731589; c=relaxed/simple;
	bh=/2/nYg1l6QlFrvB5qXtNTfCQgRvcgihI12QEKUuBWIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlrhR5l6J9DnuXTu2vdUjjqQhjrg+WDTs89+7hj/pr3mCJ9qBZ8IrGAa7fi1aTb3NcfseLKUBPfmWCn70qY/nNnA1gjndFsw/WFvGE5CpFyCC/ZIHjyJuwDzUnTuzA0QtFUDnsox5IrymR7CJpJw9KkJC/4LRn7+GiQUQ0+qZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwseR29b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13544C4CEF1;
	Fri, 21 Nov 2025 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763731589;
	bh=/2/nYg1l6QlFrvB5qXtNTfCQgRvcgihI12QEKUuBWIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwseR29bRD0CGDreiuZCAEICY/M8Eu+J3JLxcoPiQLr4amFQIg1cnQAPz2kNK8SgR
	 fibfirW+p+LfIkFhIwF/Vz2+3IRcUqUQ0qyRvgs/KKo8fUT1ZxdS8lLNEXiD89m2+D
	 KNuHToaT6CRRghFWMmHL0d7/MVTNd7AmrLz4Gz7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Shuhao Fu <sfual@cse.ust.hk>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 004/185] smb: client: fix refcount leak in smb2_set_path_attr
Date: Fri, 21 Nov 2025 14:10:31 +0100
Message-ID: <20251121130144.026399590@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
References: <20251121130143.857798067@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuhao Fu <sfual@cse.ust.hk>

[ Upstream commit b540de9e3b4fab3b9e10f30714a6f5c1b2a50ec3 ]

Fix refcount leak in `smb2_set_path_attr` when path conversion fails.

Function `cifs_get_writable_path` returns `cfile` with its reference
counter `cfile->count` increased on success. Function `smb2_compound_op`
would decrease the reference counter for `cfile`, as stated in its
comment. By calling `smb2_rename_path`, the reference counter of `cfile`
would leak if `cifs_convert_path_to_utf16` fails in `smb2_set_path_attr`.

Fixes: 8de9e86c67ba ("cifs: create a helper to find a writeable handle by path name")
Acked-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index cb049bc70e0cb..1c65787657ddc 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1132,6 +1132,8 @@ static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 	smb2_to_name = cifs_convert_path_to_utf16(to_name, cifs_sb);
 	if (smb2_to_name == NULL) {
 		rc = -ENOMEM;
+		if (cfile)
+			cifsFileInfo_put(cfile);
 		goto smb2_rename_path;
 	}
 	in_iov.iov_base = smb2_to_name;
-- 
2.51.0




