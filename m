Return-Path: <stable+bounces-7351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A198817229
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86FC28344A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179A5A86C;
	Mon, 18 Dec 2023 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z3Mrn+4x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35C3788B;
	Mon, 18 Dec 2023 14:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506C2C433C8;
	Mon, 18 Dec 2023 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908234;
	bh=sF4u/+tDUzeE7lIvcW0E9Ra+DNyO9TYgZuNTqHsQuGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3Mrn+4xRIvaPPo1/rhgOstVaPE7N0AGvgtha0GvnJElCK5d+h2mZQ/4USKFUZTO6
	 BtqvOyD6ZqQAtnVJqBmZ7gx7pJYmk6tr+5ONClk/PZ31f6qSFVRgCqIp0twfH4Ag3O
	 oa0br901asUfQuUBt/UTeFD9GUrD54BVoAUAumyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 103/166] LoongArch: Silence the boot warning about nokaslr
Date: Mon, 18 Dec 2023 14:51:09 +0100
Message-ID: <20231218135109.611112589@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 902d75cdf0cf0a3fb58550089ee519abf12566f5 ]

The kernel parameter 'nokaslr' is handled before start_kernel(), so we
don't need early_param() to mark it technically. But it can cause a boot
warning as follows:

Unknown kernel command line parameters "nokaslr", will be passed to user space.

When we use 'init=/bin/bash', 'nokaslr' which passed to user space will
even cause a kernel panic. So we use early_param() to mark 'nokaslr',
simply print a notice and silence the boot warning (also fix a potential
panic). This logic is similar to RISC-V.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/relocate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 288b739ca88dd..1acfa704c8d09 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -102,6 +102,14 @@ static inline __init unsigned long get_random_boot(void)
 	return hash;
 }
 
+static int __init nokaslr(char *p)
+{
+	pr_info("KASLR is disabled.\n");
+
+	return 0; /* Print a notice and silence the boot warning */
+}
+early_param("nokaslr", nokaslr);
+
 static inline __init bool kaslr_disabled(void)
 {
 	char *str;
-- 
2.43.0




