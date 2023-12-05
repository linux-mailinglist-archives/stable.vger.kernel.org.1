Return-Path: <stable+bounces-4416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911B804764
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37E11F2145E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437E18BF7;
	Tue,  5 Dec 2023 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oo2zqgtn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2FA59;
	Tue,  5 Dec 2023 03:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB57C433C7;
	Tue,  5 Dec 2023 03:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747485;
	bh=zH/dD0zjz+ohnw+2XgeDhlJpxDIetRnbr26J2sVW5FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oo2zqgtn7tHQ7dgCftP5OBNv6yQDfulVVPSDsHVy6Alj19yT6hUuVUNvvmRebNuz8
	 9wvbM7qVIw6vxE7a1ojViAe/ANCg1AGEMjoH5nKJlnpRN8q8dJLxtoRrZcCs/mVHue
	 EZaU7dVNhdLu23qXMZSGJjcSOtPVbZ5R3xqFB0lo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 094/135] selftests/net: ipsec: fix constant out of range
Date: Tue,  5 Dec 2023 12:16:55 +0900
Message-ID: <20231205031536.571764951@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 088559815477c6f623a5db5993491ddd7facbec7 ]

Fix a small compiler warning.

nr_process must be a signed long: it is assigned a signed long by
strtol() and is compared against LONG_MIN and LONG_MAX.

ipsec.c:2280:65:
    error: result of comparison of constant -9223372036854775808
    with expression of type 'unsigned int' is always false
    [-Werror,-Wtautological-constant-out-of-range-compare]

  if ((errno == ERANGE && (nr_process == LONG_MAX || nr_process == LONG_MIN))

Fixes: bc2652b7ae1e ("selftest/net/xfrm: Add test for ipsec tunnel")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
Link: https://lore.kernel.org/r/20231124171645.1011043-2-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/ipsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 17ced7d6ce259..03b048b668315 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -2117,7 +2117,7 @@ static int check_results(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int nr_process = 1;
+	long nr_process = 1;
 	int route_sock = -1, ret = KSFT_SKIP;
 	int test_desc_fd[2];
 	uint32_t route_seq;
@@ -2138,7 +2138,7 @@ int main(int argc, char **argv)
 			exit_usage(argv);
 		}
 
-		if (nr_process > MAX_PROCESSES || !nr_process) {
+		if (nr_process > MAX_PROCESSES || nr_process < 1) {
 			printk("nr_process should be between [1; %u]",
 					MAX_PROCESSES);
 			exit_usage(argv);
-- 
2.42.0




