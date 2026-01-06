Return-Path: <stable+bounces-205578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B72DCFABC9
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40DAF3017E76
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380002C21C4;
	Tue,  6 Jan 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaWxIiW/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56D224B04;
	Tue,  6 Jan 2026 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721159; cv=none; b=Vfm7S4C4OwB5Y/T1yAoN9r9zKb3eC2ciBDw1AhyLcJYrfydCMF7g5sjokDqiR07Ph2Y2domKYLI0Au8RyCo2WIUWkw2qYf48esh6sFZV+EUGlgREcIrO+mMMfuKp3Yl+WKJqLvet3rcyhkdyQz9n7OOF4zoCqxs6Gut6SxvkJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721159; c=relaxed/simple;
	bh=5UthNTyx2izj2QVmLPUR2h1fsL2SeRoJZn+DsSqGzv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJ/owdgc2tG+czRM5lklR11wq9l12JiCriMWBXZwVlLuCui9fvVWHhbZk/H5+gJSIAR7jAwBO0bZZP0R/7ryejeYfwnh2VVVTGo+C60hd90MRvrqdNnT6zwHqRVZjZ1Vu+tKwkQQ4fWzbctzhsMDOBEEZZhWMpQbFn4WboKpaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaWxIiW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51532C116C6;
	Tue,  6 Jan 2026 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721158;
	bh=5UthNTyx2izj2QVmLPUR2h1fsL2SeRoJZn+DsSqGzv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaWxIiW/TqYdGT5jFlKrIuchSy6NRe2kDo4A8ZYKWF387xjzILRGyfi4fiOxWIO8Q
	 rbkcFKULnli+NFx+OxAhccT3+cw60xItgYFcBOh+2hBKZJuHwYeXdVk6TeA/gwsPJ8
	 6AOkbE/AkBKzARoBabeVtQuMQbemPTe+YAPhpPzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.12 452/567] nfsd: Drop the client reference in client_states_open()
Date: Tue,  6 Jan 2026 18:03:54 +0100
Message-ID: <20260106170508.067665016@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit 1f941b2c23fd34c6f3b76d36f9d0a2528fa92b8f upstream.

In error path, call drop_client() to drop the reference
obtained by get_nfsdfs_clp().

Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's opens")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2989,8 +2989,10 @@ static int client_states_open(struct ino
 		return -ENXIO;
 
 	ret = seq_open(file, &states_seq_ops);
-	if (ret)
+	if (ret) {
+		drop_client(clp);
 		return ret;
+	}
 	s = file->private_data;
 	s->private = clp;
 	return 0;



