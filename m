Return-Path: <stable+bounces-222799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGbdHZCApmmIQgAAu9opvQ
	(envelope-from <stable+bounces-222799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 07:32:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 725661E9A55
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 07:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CB05300E4AD
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 06:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475237CD54;
	Tue,  3 Mar 2026 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ch5LfaMv"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F22FBDE0;
	Tue,  3 Mar 2026 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519563; cv=none; b=hrm9Quc+F49MjXQwJ1dtCW1OyOpKiHPJgiam5tsvy3UK0tf3nDeDJ4d6qhtFruJhknH79LfAvDC4gfjePABwxh3bsEo9mI6GCkpg6fg6z6xNJQHYFNUo9yHwsflH6RHqC4jDHselDUjrqAu7vLkVueqZe5GO7fai1pizKPeLYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519563; c=relaxed/simple;
	bh=OlwkTy8mDgS8zVjZlxJeMw7YBXXoV/wVe7vFTZWY6DE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=otzW6GYGH5r61wwarNDljFUJvlliAs/KZgMRdANl80f+8tVPPilMFN0vIhZ98cDdmo70uA07zSuFYKLWIYEw+wI0lfoQ8I4cezqI5SS7rPC7hGX26mHrOYKYz4HVtEE+zToINB06CtYS0s67aLGkQP6HzOuh8vHiuS6B73NDUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ch5LfaMv; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772519553;
	bh=aKvCzqlj+MiaJ1r5wT8u+m/ITsChfbuYGTLOSqRX1OY=;
	h=From:To:Cc:Subject:Date;
	b=ch5LfaMv19fIbe8tUeph5wpELF+LzRzEOs5PLUi8ofWOwANm/s1mVgEQCctcVG63/
	 +gPes2P5GfJNrOy8ePUO/58QRAd29W4ZqZ7qVo5juuQwVQvi7fqAryOm97je02KZTB
	 4bkhrIrYSoiciBSKdrKrIGi9xu1gyaqopJ37N69o=
Received: from China-team ([60.247.85.88])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 813B1214; Tue, 03 Mar 2026 14:32:19 +0800
X-QQ-mid: xmsmtpt1772519539tksc3zgii
Message-ID: <tencent_9AB419354F1F619209D63A382030610D4208@qq.com>
X-QQ-XMAILINFO: NtEY5COp+2lZkhSxPhfxa6d3oi8xnzNq2SsjQwz1dpWkRdqGTr2rLZ4griqYmE
	 aWlQkH2ib38BUDetHiYZrTglFfTh9S+EFjoY3XBdO4vhwmLfokCkbsqJ2qnSuRV9lzlAaTo0E0VW
	 oslfCFd675j4cQcGFD+6G1wbH1f2xBuvXtk/IEti6cCQR7/RacpSnngLrQNX8NiniR+cs97377sg
	 kXVNQesEunXbAd7nnh+4l9maczG6BoxTl6M1jcAP34D7/E7UGAYZOIU50pdFGWWgYD44alX2vMc/
	 m+xQETfllbPxytHQI3yTuzL+lGfH7/6CMdNsBIo41h3E2w1NQ7pf5IquLstR8tFePgY3M4jbFzuz
	 kFmLLiNhzlJHezIjcD/ixwYtcZkbHF1AMk1LcEGP39dJa4EG41NgNqHbAdaKZQZ0GS31N+/Zy4I8
	 0I94k+Lh6dGg6pjXE5/4mxkVcNZC4idpwTAr5pXbirIFbjzA1A5fOh5VwTyAHgMQYQKTdDgByjiy
	 PktprdXp22cyuFs0GM6xApE6Uewn03AMCAoUpQzzkTlW2NgJjH4XFqDgZmJt2npIKn65MjsUNjKS
	 0aR7js0Y6Bxjo9DUWph+f9a6+ibnkdCq7Fi0EGJlepJCZ1Yj8hwXIxoZW2VnRss7mmwBfmdVQUbL
	 OwyM3sZwLj2QQ/CtOo8GwdkSrDX8Sn5RE+P96MktH0fb6jWSq/ToZGF/bjb4rWfU9DdkjerFriH6
	 oJg/iiubNm6jL8WMJGpJHFPwDCMkGiDNoXbJdWtIkVQ9LJVcbnnIHGRvpC7I0iUnyI2QEqEhc9Xp
	 WPujNrPWgkeR9ZcGGDNvj8yDeGOKX6Z0wnSiHPmcS5rwh6wLfS83evWUFS/grzdqSfsxR7iR9alZ
	 w3wBRTds8sKBLu2hevlozh7MOWCEqJyk4JzOqtKbVY5tQcZ40O0ZzhTxMBukuMUpWTl5L+NkBtoe
	 sCWUtz+crrlG4aA2IKCn9sUvh1DhxnxckbZt+8tRufjuWYa+SEoowpdEUvKxwz9pbwHsGU89W/uD
	 VpCuOEfK8U7+1Lm3KdMaDVp4sgKsozm+EFoumDHFt7Zc1RVCLF1b/ij/1fF2931AlJQ9iRNtBxmG
	 x5jUY2JyvLWGIzetY8mUaZ8z3saIwG56n15zjW
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Mario Limonciello <superm1@kernel.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] platform/x86/amd/pmc: Add support for Van Gogh SoC
Date: Tue,  3 Mar 2026 14:31:51 +0800
X-OQ-MSGID: <20260303063151.397931-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 725661E9A55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222799-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,antheas.dev,kernel.org,amd.com,linux.intel.com,foxmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,antheas.dev:email,amd.com:email,intel.com:email,foxmail.com:dkim,foxmail.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Antheas Kapenekakis <lkml@antheas.dev>

[ Upstream commit db4a3f0fbedb0398f77b9047e8b8bb2b49f355bb ]

The ROG Xbox Ally (non-X) SoC features a similar architecture to the
Steam Deck. While the Steam Deck supports S3 (s2idle causes a crash),
this support was dropped by the Xbox Ally which only S0ix suspend.

Since the handler is missing here, this causes the device to not suspend
and the AMD GPU driver to crash while trying to resume afterwards due to
a power hang.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://patch.msgid.link/20251024152152.3981721-2-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ Adjust context ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 3 +++
 drivers/platform/x86/amd/pmc/pmc.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index af5cc8aa7988..259bac3744d4 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -294,6 +294,7 @@ static void amd_pmc_get_ip_info(struct amd_pmc_dev *dev)
 	switch (dev->cpu_id) {
 	case AMD_CPU_ID_PCO:
 	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_VG:
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 		dev->num_ips = 12;
@@ -698,6 +699,7 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 	case AMD_CPU_ID_PCO:
 		return MSG_OS_HINT_PCO;
 	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_VG:
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 	case AMD_CPU_ID_PS:
@@ -908,6 +910,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_PCO) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ }
 };
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index b4794f118739..88e0232592dc 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -47,6 +47,7 @@ void amd_pmc_quirks_init(struct amd_pmc_dev *dev);
 #define AMD_CPU_ID_RN			0x1630
 #define AMD_CPU_ID_PCO			AMD_CPU_ID_RV
 #define AMD_CPU_ID_CZN			AMD_CPU_ID_RN
+#define AMD_CPU_ID_VG			0x1645
 #define AMD_CPU_ID_YC			0x14B5
 #define AMD_CPU_ID_CB			0x14D8
 #define AMD_CPU_ID_PS			0x14E8
-- 
2.43.0


