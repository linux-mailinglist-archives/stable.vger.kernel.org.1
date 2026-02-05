Return-Path: <stable+bounces-214479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPSzLKCrhGk14QMAu9opvQ
	(envelope-from <stable+bounces-214479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:39:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1422AF4244
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98363011773
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E354A3EFD30;
	Thu,  5 Feb 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4RTBlPh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31440757A
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302311; cv=none; b=FHrzTeeyBRnNxh0HTpity51D/QhLucTLH050M0G/gwlae06LGRe6oJ62dGRZAiFv2+WANGD1NicJyDeSUV0xakGrZbEIJlPvETQcTaI2+qOrzGp/DSLG/0T3d+zXUYjXfxM4Tz8vw5gLvp403iDsdVxHYFWoyMI4yjJj0wjW1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302311; c=relaxed/simple;
	bh=HBwCSMa8if6z/4ucL3pbjfD3ljkfv2s7i8XeoeIkgFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+z5LyNP+vV49ulk2eI+abKzY0Sco0h7HBjMAy7r98zuWxQKo/DWdLEAHGgX+GoP7AeUBdEWk/NBuNx9gglsGxzL8Gi93mB6xq+R7THiHIH4FdpZmn1ORZm6/LHNbuDfw0NHBAWfC8Kn6gH5mD3LSSS0uZF1lDZvdJcuqwa6Yu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4RTBlPh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso10867785e9.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770302309; x=1770907109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkPGmWie3M5DDV8H2ORowVvVz6V9drsPadZ5hF7WW4A=;
        b=A4RTBlPhggGYLwIZpXHhDUCKfuc41a0V7jouFQbU0YX72DBKduSeKBD4KgAlEZ8olD
         1VgyxdTYhr6ENIqYc7lb1PCbhXR5AdnrvBglxAYkSSf0gW8ZvDeMl+sRgyTQt9MYSBuk
         OAPA/wGLBUT1sAom5wZzgtrm4ygqdltcMPonHHc5sxQxfH93f7nFwOVSJiKI+d3r/baq
         /7YC1IwyPjrO6wvsoqDk3JS1uI4dbqV9JhIbXkCr1gRBpFGxvm3CMqR8SUE5ntRZrx6x
         IUU2d2+VlgTruwbc2rle4djz3T4+YDUXG9/RWuR3sNaupq+UIdxnw7xafvKV7yC5bncO
         Pz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302309; x=1770907109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkPGmWie3M5DDV8H2ORowVvVz6V9drsPadZ5hF7WW4A=;
        b=FWTnb8MMfNk4pAMeKNzzyBzGQfLGgktbRLuOrIQ5NY02kCax7L4/26vY/9VJvjuxqG
         lRMVCSluSTFPbUe5iGEsnxXkslVGqREZ0KfYiv4xQuWEZppBFZtVSjT60IyKoX2VNCrN
         AYRub2tO+HXsznRqpAmc+E1FkbI3+0KqMXM166YY8bIMxijIw51TXmQVh7E0fRUdGWyg
         UbRrQxlSkwON1jusCqB+jyTVREv64RoTQfI0p/mVWrhRjrovDxFsUVMNzY2iC/Wad9I9
         NDfXH0mA+38yxmRP4DrG3BNT1KSJjcbMtD/U7yQ+FSLxhaDg4tMAXj6a8IJxEggdEnNr
         44FA==
X-Gm-Message-State: AOJu0YxB4ZsUgkMMuiYxuFsLJnzmud+apDqxwv6UyBQtEdVmqStzru3/
	HbQ9BRzE0kz8pfndi9N6GN6n4lUdfeN6k7UjRe9gc9hntAOdRoPCuTrf/vhSQw==
X-Gm-Gg: AZuq6aKyg9jaVlaCUYH807trf4q35cr+3lBiMwDMslzuRSwiIq9YVICdmgluhALu338
	ZaV/ACiUlR4Z8vuYFYwBoLxWTCbQLA/ydGmro7lHk3w9KsHV5/CDwYAU22W4SEZFTyFV2ajOrse
	LLbMZRakhTl6yiKYol1k9rknB++x5AW3B6y+RCak1QpVe6Qif8aUT9rf8TWwGlBpEOReoHL3BxN
	7Hpv8zJsV0G029Dj8AzTHHgEhG9vsTVW3C39tMJvMkGI4VjmDslZBojd54jxV03Tlm91udJZi/Z
	CpIBKXeAlek3A+5kwOaFU+Dfz2wA71ZNAjev0ZM0+7voKhMxzVtf6p0YRe7D2IYurcg5PWYzmn9
	RFFfoxbsX65+Hg5RhR4id9nUKr5PFHdPHPBS/Tv0UMlp0Q9xl/1Xs6uDeaIsW9lM5BAuBfxygJx
	P4pCFgdk8o+Le/kAEmLufv5BbS+gWXHC53TXZxBSvzAOx1X0sZCLkSs/scQlr8FfsLdFtI97w5X
	HAj0ONTXu9EomA+BRrobgfjWQ5yE5I=
X-Received: by 2002:a05:600c:19cc:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-483179dbd52mr47095965e9.17.1770302308950;
        Thu, 05 Feb 2026 06:38:28 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179d7346sm74904255e9.0.2026.02.05.06.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:38:27 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: stable@vger.kernel.org
Cc: Daniele Palmas <dnlplm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH 6.18] bus: mhi: host: pci_generic: Add Telit FE990B40 modem support
Date: Thu,  5 Feb 2026 15:38:14 +0100
Message-ID: <20260205143814.1047550-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-214479-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabioporcedda@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1422AF4244
X-Rspamd-Action: no action

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit 6eaee77923ddf04beedb832c06f983679586361c ]

Add SDX72 based modem Telit FE990B40, reusing FN920C04 configuration.

01:00.0 Unassigned class [ff00]: Qualcomm Device 0309
        Subsystem: Device 1c5d:2025

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://patch.msgid.link/20251015102059.1781001-1-dnlplm@gmail.com
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index b188bbf7de04..3d8c9729fcfc 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -877,6 +877,16 @@ static const struct mhi_pci_dev_info mhi_telit_fn990b40_info = {
 	.edl_trigger = true,
 };
 
+static const struct mhi_pci_dev_info mhi_telit_fe990b40_info = {
+	.name = "telit-fe990b40",
+	.config = &modem_telit_fn920c04_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = false,
+	.mru_default = 32768,
+	.edl_trigger = true,
+};
+
 static const struct mhi_pci_dev_info mhi_netprisma_lcur57_info = {
 	.name = "netprisma-lcur57",
 	.edl = "qcom/prog_firehose_sdx24.mbn",
@@ -933,6 +943,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* Telit FN990B40 (sdx72) */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x201a),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990b40_info },
+	/* Telit FE990B40 (sdx72) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x2025),
+		.driver_data = (kernel_ulong_t) &mhi_telit_fe990b40_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
 	/* QDU100, x100-DU */
-- 
2.52.0


