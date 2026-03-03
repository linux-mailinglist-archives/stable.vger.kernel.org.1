Return-Path: <stable+bounces-222779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J3xGRJhpmlVOwAAu9opvQ
	(envelope-from <stable+bounces-222779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 05:18:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51431E8C2F
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 05:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E8D33088600
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 04:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA020A5C4;
	Tue,  3 Mar 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="kjfyWSgB"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05035285C8B;
	Tue,  3 Mar 2026 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772511428; cv=none; b=XDGGPlfivi1iHp9S/WXkAODCoMV09U0VLf4GlFgCPiPEMUW88X7GR1pB48xEi3P5GWxVRoGYkIfMqAT+KDZmZjn5kqG1rphVGKwP2n5UMm7GUdhp2yvmZZKp4punGR6Ka1eJlIGXYsqVa/IoHoITEtPU/ci3iiPBahwu2M6IXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772511428; c=relaxed/simple;
	bh=x+FVWCFIpjwZcSSeF0CUQV49/v1WQZUrWYeYAltQ7R0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=F1oMviS33gc9EJr+kbke/Or5oEsUg05baXSlRsgUFE2mFQlJdexAFdwEUneZFd7RskJA45sMn8Tu1lfdJAihNmZSoEqaplGgtyffMbBcs1sYqkm7QvscBIqr0W8diBqoFETW0hTdIfmHbpqO8+fqP0EzmTtqRUecUFthe96ncL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=kjfyWSgB; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772511416;
	bh=17Ep+msmgW0mBiuu2dXvT0CWKdlWYqOSs5QdbmomErA=;
	h=From:To:Cc:Subject:Date;
	b=kjfyWSgBspDh6MpxmyJfoZejSgxUc/UHgBZ1XOC2g7UGFnzuSKi46HBrbke9UWj4o
	 R5e/M7qSB9T4VEH/FrrrmRjH7rz8Jsf2iZSFgr9KfyLU9LbICZX04Oqp6uUCi61mOT
	 WNplBcrEAA9a30Wu7DoSS5XW1SFN+OVVf/x/w98M=
Received: from China-team ([60.247.85.88])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 3DA0221A; Tue, 03 Mar 2026 12:15:26 +0800
X-QQ-mid: xmsmtpt1772511326tmk512nfu
Message-ID: <tencent_08A00654DA8F9A900F204940EB5B1C0F9807@qq.com>
X-QQ-XMAILINFO: MLINc68tus9/BDdjNnQlqvJ2c+lrxEEn4gDfyknKjv8REv83rVWJwXESi1x42X
	 xXHitUB1J/QeJq5QFN2YxjmXAbdhISm1UYL1xIrESPN/UXVINU8CQoHL1QLzXs4DwxiuTtS2OkNt
	 wM+9lqd0saS6S/tAaA/2uxuIYec0J9SY3iIzcujgcfpdY8NhaN4xaQLitT2Rjflowm7YkqZvaUVT
	 3jX+wrH23B6J+yUHl5sEOz6hhnIQxi//w6FOj42sIKE61SEZeIhFRBnKxtJApix+w6F3hVXyotjm
	 XEr83DL3Af+tYK/e9AKoMovQtdq4K7l5ZxYRMTkqO1ea1TG1OOXcWo+lDQ6wUiuVkFrbnEvh7L8Y
	 7CfctnzlV3N0UGDCif47YAGiFUdMXpDsD9yaM7/0zVvzz6OwaWFKoYwVNB4Tc5j2+QDDGLwmIcNL
	 iRVYUwJ8+vbTtAI3JFCmo9IhSblhGIzQNItFzTfZazRbkQ++zvNoMw4EwZfTIXCM5BDE7BKStt7E
	 /1VPOwu09YBy/VsZrWU0ez6bChjKNdfa8OHUIYg8IZG+Y4A4jHOR1qrqqAImlh92u2dh0mThoVxc
	 tAVYXL+cHLaUWCmtv00pYtkvfpcMRYvJJxzx21ZPaijL1HKsfLpOjQajQdRuPNYQQhffNdD9BedP
	 lkP6rSns/mNKFo8+xsPzBExEHxDmHo/APspEOzXEo1TG0+zli/nKYI7/rcJOl4yDtkfJRc20YtXB
	 ZQ6c+HyTTJtFaUZFkXofTgtj1M6/DvA4qVQe3XrwgRwZ464aWmkqpMiFIKR+JM0XT+Wyc2+W4x57
	 l39rSB5fzRKRJ0eO+/fSwEH4vFpqOPu7BkeIY2VaBkILA7Cfn7phkXNuSZvdDNhB2TqBqn9GiWT8
	 mIw4pR64Bw/IUiMsdGbkbrolp906UIEMTcO1nSMICaQ0EzDwVEd+JKnM/y8kwF0B18y28CHcvUaz
	 il5t7jKv8ksjHOLGQ3kMVnB9OtuKOC0Y14IAH0p2feJ4Jgzdw+jkSkPr41HidTWbM5AGsSP0Kph3
	 SwYpgiKxRnfLw7h1H+SKAMbHtMCT6qThZvp9cQOcQEAqGspFCgnEhmX5SuP0NtJSVkCkrf5D0M5M
	 KMH86K1lf1Yy5haMRhR32aSDHBsB4aaqpMyUFg
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Mario Limonciello <superm1@kernel.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12.y] platform/x86/amd/pmc: Add support for Van Gogh SoC
Date: Tue,  3 Mar 2026 12:15:12 +0800
X-OQ-MSGID: <20260303041512.2666366-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E51431E8C2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222779-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,antheas.dev:email,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
index 357a46fdffed..6e8eedb8d521 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -347,6 +347,7 @@ static void amd_pmc_get_ip_info(struct amd_pmc_dev *dev)
 	switch (dev->cpu_id) {
 	case AMD_CPU_ID_PCO:
 	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_VG:
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 		dev->num_ips = 12;
@@ -765,6 +766,7 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 	case AMD_CPU_ID_PCO:
 		return MSG_OS_HINT_PCO;
 	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_VG:
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 	case AMD_CPU_ID_PS:
@@ -977,6 +979,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_PCO) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
 	{ }
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index f1166d15c856..17bc0994f376 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -62,6 +62,7 @@ void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
 #define AMD_CPU_ID_RN			0x1630
 #define AMD_CPU_ID_PCO			AMD_CPU_ID_RV
 #define AMD_CPU_ID_CZN			AMD_CPU_ID_RN
+#define AMD_CPU_ID_VG			0x1645
 #define AMD_CPU_ID_YC			0x14B5
 #define AMD_CPU_ID_CB			0x14D8
 #define AMD_CPU_ID_PS			0x14E8
-- 
2.43.0


