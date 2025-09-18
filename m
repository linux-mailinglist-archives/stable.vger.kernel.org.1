Return-Path: <stable+bounces-176202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E3B36CFE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D52A00FD0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192A35691C;
	Tue, 26 Aug 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QXgEjWMP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2F352FED;
	Tue, 26 Aug 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219045; cv=none; b=jFdJIAi4GUSBFB/OPfgLGKWaSmwFfB3ERZhhibCoX6cPOJSAe6ZPJ1Ym8IP0YxDEIrVfYzCHyrGg+PlrUi/eXTU6xaRA9NgX7Ih0s33kCPoC+xP4I2BAZvxh/9aV2bWI9FELzyBzWaskhnjaXYL2dF5+cAZl1D0Aj/+VaxAWYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219045; c=relaxed/simple;
	bh=OlM1OL458ZpoDOWDF44VLDUXCEpz7G3s63fApU9fGfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KH/wR30JXoqvJkCUn1LAhRar3IzX3nrVk9NrlDxL6iDg0mDfYXA64CRZMZIQR2XzkYOMYmC0zGmV5eA6matzUuZwnuWQFnXZeT+yeLkfPXchg2tqbQRBPaj5ApAQE6Dz2EoRudV0Bm4o1liSLj39oC9EgaHXdpg/6GGb3+D9GdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QXgEjWMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFE0C4CEF1;
	Tue, 26 Aug 2025 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219045;
	bh=OlM1OL458ZpoDOWDF44VLDUXCEpz7G3s63fApU9fGfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXgEjWMPWPdmlYXZjvPNvIUohpkERiPR6kn2vZGJFdgyCy7k7kr5ECYT/nM3SHoeK
	 FZ+w/ZUjcz4h7ciRosU46pgdqIlImNq4GclyLCmKZOtSpS1Z87CtW9nfuK98AbAB6m
	 l3xbFC/3St8QRz1xFBLjdIWCZSi0ACTLeMqxNtuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 232/403] cifs: Fix calling CIFSFindFirst() for root path without msearch
Date: Tue, 26 Aug 2025 13:09:18 +0200
Message-ID: <20250826110913.239684413@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit b460249b9a1dab7a9f58483e5349d045ad6d585c ]

To query root path (without msearch wildcard) it is needed to
send pattern '\' instead of '' (empty string).

This allows to use CIFSFindFirst() to query information about root path
which is being used in followup changes.

This change fixes the stat() syscall called on the root path on the mount.
It is because stat() syscall uses the cifs_query_path_info() function and
it can fallback to the CIFSFindFirst() usage with msearch=false.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index f924f05b1829..ea444c8d0c40 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4544,6 +4544,12 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 			pSMB->FileName[name_len] = 0;
 			pSMB->FileName[name_len+1] = 0;
 			name_len += 2;
+		} else if (!searchName[0]) {
+			pSMB->FileName[0] = CIFS_DIR_SEP(cifs_sb);
+			pSMB->FileName[1] = 0;
+			pSMB->FileName[2] = 0;
+			pSMB->FileName[3] = 0;
+			name_len = 4;
 		}
 	} else {
 		name_len = copy_path_name(pSMB->FileName, searchName);
@@ -4555,6 +4561,10 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 			pSMB->FileName[name_len] = '*';
 			pSMB->FileName[name_len+1] = 0;
 			name_len += 2;
+		} else if (!searchName[0]) {
+			pSMB->FileName[0] = CIFS_DIR_SEP(cifs_sb);
+			pSMB->FileName[1] = 0;
+			name_len = 2;
 		}
 	}
 
-- 
2.39.5




