Return-Path: <stable+bounces-107540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E356A02C52
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52E9188758D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02038634A;
	Mon,  6 Jan 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JZifFKhs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A713AD20;
	Mon,  6 Jan 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178779; cv=none; b=til5e3ZMuQbzLKn71nkaP5SYEklzD8nhr6t+fU0hLirmrQyHoCixKPHjl3Dlb5pPn2QyUgtzMCMfBxIbscKgUs+evoTvGBBssKWTVyor0SwFnijCPuzOsUefrRvgB1aeCPKzKCt7e7H3y+D6lD22ffKpiVei0gew1BJ2HWofGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178779; c=relaxed/simple;
	bh=BINIQNPwtgDQs1ZgzFm7TwbXByOHTK2Qr1oNLWRB4HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uus9whdiF4V/KR7PkdhzpXvx5PpCFWmxm54p/NJzMHv2QkyTj9r3aCmPi7W3BnwPsxCeZyVc5mpIv6mPKfMB4Ji5K8tToKXL9NnbiCMRqntuj4+YBn4TEUDZ4oE29vV8KqN/O2nZAVBP9QAfpp39tlPM/OlSJAP8fZkLUuko5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JZifFKhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169E7C4CED2;
	Mon,  6 Jan 2025 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178779;
	bh=BINIQNPwtgDQs1ZgzFm7TwbXByOHTK2Qr1oNLWRB4HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZifFKhsuJuu+JiJ0gSbhLS5YDCHi2hIlU089YXZ16PPGRWsRyipojvg2+DmVmqjo
	 HNzH31npKZQQ7rAeha1J+5uyVGlw8gW+vhbCLZEZuGI+cBcwuLTqbGuQf2XFqlZLC3
	 dDhRc9sGms0CbeOqlV2jip1dugoUfNpnjnubFy4s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jordy Zomer <jordyzomer@google.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 089/168] ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read
Date: Mon,  6 Jan 2025 16:16:37 +0100
Message-ID: <20250106151141.824132104@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jordy Zomer <jordyzomer@google.com>

[ Upstream commit fc342cf86e2dc4d2edb0fc2ff5e28b6c7845adb9 ]

An offset from client could be a negative value, It could lead
to an out-of-bounds read from the stream_buf.
Note that this issue is coming when setting
'vfs objects = streams_xattr parameter' in ksmbd.conf.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 54f7cf7a98b2..35914c9809aa 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6350,6 +6350,10 @@ int smb2_read(struct ksmbd_work *work)
 	}
 
 	offset = le64_to_cpu(req->Offset);
+	if (offset < 0) {
+		err = -EINVAL;
+		goto out;
+	}
 	length = le32_to_cpu(req->Length);
 	mincount = le32_to_cpu(req->MinimumCount);
 
-- 
2.39.5




