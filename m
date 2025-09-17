Return-Path: <stable+bounces-180053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC6B7E796
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39177B0B90
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA153233E0;
	Wed, 17 Sep 2025 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YMWOEv6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB342F5A2E;
	Wed, 17 Sep 2025 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113231; cv=none; b=HVAOKFTp4F4lkwZ9CUj5NIzLc2O9xcbLr6Xio2+V0kEnSKgOmC89wDXlhxSDOXY4WxxfVLLZDEK2Be5d88pnuDKODqJOpyiFlxPRamN7PDYTcCMK0eVCk9RE4WySmn1PnfH4pQEWk2onsFUpQFMRuAW//zYlNUmXEbRYeS4KEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113231; c=relaxed/simple;
	bh=Saa++o0umdAssohr4Zp3B11JF318BTVSSuvmrYya124=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JntIaUpdcOiuaD+XceMHZxR34ehp137U43nKcSOmRSJdiPXb+r8o0JM/UuHzlY2WB7T86h7ycrl2A1pLjBVTdaozPtA1rQQCjBcmL4L1AKtoD4kJnJcOxaRYJaSP4GTjHxyfKkDvtq47UVK8KGpK5oZwtA4BAbnqJZY9TsKjllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YMWOEv6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F256C4CEF0;
	Wed, 17 Sep 2025 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113230;
	bh=Saa++o0umdAssohr4Zp3B11JF318BTVSSuvmrYya124=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMWOEv6MEPRskBKn5xWavp/7Xt6zh6UyAMmbOJnd3V5tkT8NqQ6uWZPw9qDNVOtME
	 ohM19WS0u9IDaLnhSC8TGPNAW1CMI9I5Ltgec5YpFdpmZmDFWPt7uDMp307yDbyZ+Q
	 NU2OW7ewpMf598+psF9qrhfQjvX8+ugrODJcwQC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Haiden <scott.b.haiden@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 022/140] NFSv4: Dont clear capabilities that wont be reset
Date: Wed, 17 Sep 2025 14:33:14 +0200
Message-ID: <20250917123344.849455957@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 31f1a960ad1a14def94fa0b8c25d62b4c032813f ]

Don't clear the capabilities that are not going to get reset by the call
to _nfs4_server_capabilities().

Reported-by: Scott Haiden <scott.b.haiden@gmail.com>
Fixes: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6b7cbc06c9c8..3ac8ecad2e53a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4064,7 +4064,6 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.51.0




