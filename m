Return-Path: <stable+bounces-4100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D39804602
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24B2B20B8F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4279F2;
	Tue,  5 Dec 2023 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Af1fDDir"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737FF4437;
	Tue,  5 Dec 2023 03:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0712C433C8;
	Tue,  5 Dec 2023 03:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746617;
	bh=SLm7pcU6EdPO6m1L3aRhoWGClHiMdMdAj2ay1hDqGCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Af1fDDirSDgYieE6edqLnie4PSR/J9fu/Gk2U3rSXKpoPumKOTZgCuGCY459DtbPI
	 2DjpUcWZ2u8SwuWPYTW3Rexi3EKcf7mcZT7LLhfc2dPVB2gHAwMOtJtqhTC6d8DEBI
	 swtnP3WIu4bCsGaAJJNxzUpRGGFW6FmITCwNJwGU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 093/134] selftests/net: unix: fix unused variable compiler warning
Date: Tue,  5 Dec 2023 12:16:05 +0900
Message-ID: <20231205031541.367919490@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 59fef379d453781f0dabfa1f1a1e86e78aee919a ]

Remove an unused variable.

    diag_uid.c:151:24:
    error: unused variable 'udr'
    [-Werror,-Wunused-variable]

Fixes: ac011361bd4f ("af_unix: Add test for sock_diag and UDIAG_SHOW_UID.")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20231124171645.1011043-4-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/af_unix/diag_uid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/diag_uid.c b/tools/testing/selftests/net/af_unix/diag_uid.c
index 5b88f7129fea4..79a3dd75590e8 100644
--- a/tools/testing/selftests/net/af_unix/diag_uid.c
+++ b/tools/testing/selftests/net/af_unix/diag_uid.c
@@ -148,7 +148,6 @@ void receive_response(struct __test_metadata *_metadata,
 		.msg_iov = &iov,
 		.msg_iovlen = 1
 	};
-	struct unix_diag_req *udr;
 	struct nlmsghdr *nlh;
 	int ret;
 
-- 
2.42.0




