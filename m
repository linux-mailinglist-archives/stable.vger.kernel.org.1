Return-Path: <stable+bounces-8057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDDA81A456
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DC71C209B5
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8104B13B;
	Wed, 20 Dec 2023 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIIQE2yL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354E4AF9C;
	Wed, 20 Dec 2023 16:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D53C433C9;
	Wed, 20 Dec 2023 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088790;
	bh=JKz7683rrsdB51qMqIm5f9GvEKXKW0FOXNKIsydQOEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIIQE2yLhXl2CYJEc6l5HpdsjoY9KzgB7p6zfgKJ7WUs5tsa4C6XW9pQY0l3YVFUe
	 vwRy0WWGO8Zpqttgvmts/fF5d2N7uRX5jx8OwYZLnzamXITQo3ag4VXFS2OjcCgaum
	 kdb1Q9Xmb3MA7HEAj2CXa0w/DO5oFK1guFy5Y6Vc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 058/159] ksmbd: decrease the number of SMB3 smbdirect server SGEs
Date: Wed, 20 Dec 2023 17:08:43 +0100
Message-ID: <20231220160934.043288348@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Tom Talpey <tom@talpey.com>

[ Upstream commit 2b4eeeaa90617c5e37da7c804c422b4e833b87b2 ]

The server-side SMBDirect layer requires no more than 6 send SGEs
The previous default of 8 causes ksmbd to fail on the SoftiWARP
(siw) provider, and possibly others. Additionally, large numbers
of SGEs reduces performance significantly on adapter implementations.

Signed-off-by: Tom Talpey <tom@talpey.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/transport_rdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -32,7 +32,7 @@
 /* SMB_DIRECT negotiation timeout in seconds */
 #define SMB_DIRECT_NEGOTIATE_TIMEOUT		120
 
-#define SMB_DIRECT_MAX_SEND_SGES		8
+#define SMB_DIRECT_MAX_SEND_SGES		6
 #define SMB_DIRECT_MAX_RECV_SGES		1
 
 /*



