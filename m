Return-Path: <stable+bounces-235700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLZWIREU2mmAyQgAu9opvQ
	(envelope-from <stable+bounces-235700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:27:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8075F3DF258
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94C7E300D57A
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E6333441;
	Sat, 11 Apr 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jschaer.ch header.i=@jschaer.ch header.b="RZeVBz0V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pZnZkYIA"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0C28504D;
	Sat, 11 Apr 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775899658; cv=none; b=B4k8mewxF3KGyB0CCEiu5h+x1D7q+my/eubTPawtQCbeaqnjaQiI+Ov5iirtB59K4r23JKnknWNyxl8tbQoA0mov1FKz+2v3F5P0N1pzd6W2ds0NCvPCda9B5haCcO2ujENbaApnnv4xeieAgTjgqkwt5/IDGHypBNbFFYb9/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775899658; c=relaxed/simple;
	bh=WGO85Fdp0tqLa26nqiI4ibDLGEdkYhnwXmRIDSzXfRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+zITtHRed0R5QkDtkEfIFUdQgEa0UTOLTqz0ObZjBhXJz727kZlk85F/H1afRjy0ZTpNHfGBf01u5sihAQgjdtJ7q63YCmTPB+Z8YL746QfrACWRW4buP2xmYTIJS6hcTHLod8F0ZT+yrOAsMci9GbHgcIqG4N1fyvg4k1f7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jschaer.ch; spf=pass smtp.mailfrom=jschaer.ch; dkim=pass (2048-bit key) header.d=jschaer.ch header.i=@jschaer.ch header.b=RZeVBz0V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pZnZkYIA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jschaer.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jschaer.ch
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A5FC7EC0426;
	Sat, 11 Apr 2026 05:27:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 11 Apr 2026 05:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jschaer.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1775899654; x=1775986054; bh=KD
	6ob3Wr4yj8Spjk63OAbmr6Ll4y0ZZjEiaGbgQWnSE=; b=RZeVBz0VOAcOo/ovK/
	UnYGJ83McfaNRKNhievz8qnWiG9qZS+D0r6ud8utEIO9Pa+nUjxSNEW5Zy4UtzIG
	YhxEG1NvDa9hZmIpZflZa3+Dy6/dko+5NmNJhXxyrcxmIvdpiH15ETPBL4thL3dj
	xRIaqPTANzcClt+mg922pvBTUc3prvGLxLO58rJqH0rP6/vST5reID+MwRGfvffh
	qpidqqEcTQzGTmmGd5y4x5tjeDU68lh5tEDjO+pDqrFe7/nUoVpSR2JKojWRZQgu
	m9EHNbiMtOaiLCRmsjXkmYjz9VonDKzQbHBlGwjyZYq2jgCq95aZiNTCroptgjJm
	+B0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775899654; x=1775986054; bh=KD6ob3Wr4yj8Spjk63OAbmr6Ll4y
	0ZZjEiaGbgQWnSE=; b=pZnZkYIAOXp9a5h71mqvaqmBvVf+vPcGQoL3QNX5zuAM
	ZWCl2O7c0aWci4Lqo0nZjvqMbwigJwHD2MXSxcRaqXwM2eE51X80qFrcIZFBZRg/
	o3IXX0NJSO3dFFkOnoTFFS8nWaecnaC0r9Yw31HQm413EoIMeKS7OB4V1vm6jwzl
	2DSJ1EkUU/CdEL7KDxb6LjtJt4KpZ1PMF4aQPnqOtkjrm+E46QVyci3Yj5DxxbEX
	gcq6LArCOCs3q3WW+tlhoGES7FFu7iWcyqNPidI5XQv0QdaAG80CvVAIECQXL/Tt
	DslRjTqHa2HhHaTT3KaIConi+bO04DUBBM1jaDVI2Q==
X-ME-Sender: <xms:BhTaaVEWsQGk75BML5va45gmvhYBWY2uVq3qLNNMNC1md6mQ6tY48w>
    <xme:BhTaaTq2DIdRC3Vba63XOdnlCS9cwNbfTRl59NouCgbMMIf_ETwlLh7wU68xrLKuq
    mljRGuArshM451xknsLky4A_2z4LMy5b4q3QFa7K9tvu9JJ2gyhvA>
X-ME-Received: <xmr:BhTaaeaBD5yUpibMI5IOfOGmWjuiqdgpZ4QL5zBASMjZORdBsRvGiX2Z_cVq9Q3Duj_ziQ4ARdPKPXHTKVbD5FPT0OEdMxWciPpuD588>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefudelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfgrnhcuufgthhom
    rhcuoehjrghnsehjshgthhgrvghrrdgthheqnecuggftrfgrthhtvghrnhepheeifeegff
    fghfffueejueeljeefvedvleefieffhfejleeggeeiffffffffteelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrnhesjhhstghhrggvrh
    drtghhpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjrghnsehjshgthhgrvghrrdgthhdprhgtphhtthhopehsthgrsghlvgesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BhTaacURhySgtQeW88fX46TY1C0E5n7HKgYU-DCo9Fe6Pd4sB9gmBg>
    <xmx:BhTaaX8FHi30UoZO6hkHtYl6l39SLUIdEzbZho6E763S9BasnjfHpQ>
    <xmx:BhTaaV91mmCw8WA-peQnbPhnU2FOnKRMp6v5q3wqyWXRav9yrcBoqw>
    <xmx:BhTaaXQvD2itAzreTwmiCwesTTQw1WS1D1TNCdQxVltkoQFB4dHQYA>
    <xmx:BhTaaeoq6Lp_gj9hWoo5JLQQHz2hP-3e-WoVeGipIPPiPasuup2R6oRA>
Feedback-ID: ie67446dc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 05:27:33 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sch=C3=A4r?= <jan@jschaer.ch>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	=?UTF-8?q?Jan=20Sch=C3=A4r?= <jan@jschaer.ch>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: video: Add backlight=native quirk for Dell OptiPlex 7770 AIO
Date: Sat, 11 Apr 2026 11:26:06 +0200
Message-ID: <20260411092606.47925-1-jan@jschaer.ch>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jschaer.ch,reject];
	R_DKIM_ALLOW(-0.20)[jschaer.ch:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235700-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jschaer.ch:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@jschaer.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim]
X-Rspamd-Queue-Id: 8075F3DF258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Dell OptiPlex 7770 AIO needs the same quirk as the 7760 AIO. The
backlight can be controlled with the native controller, intel_backlight,
but not with dell_uart_backlight.

I dumped the DSDT using acpidump, acpixtract and iasl, and confirmed
that it contains the DELL0501 device. When loading the
dell_uart_backlight driver with `rmmod dell_uart_backlight`, `modprobe
dell_uart_backlight dyndbg`, it reports "Firmware version: GL_Re_V18".

Fixes: cd8e468efb4f ("ACPI: video: Add Dell UART backlight controller detection")
Cc: stable@vger.kernel.org
Signed-off-by: Jan Schär <jan@jschaer.ch>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 4cf74f173c78..4a2132ae28b4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -878,6 +878,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7760 AIO"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell OptiPlex 7770 AIO */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
+		},
+	},
 
 	/*
 	 * Models which have nvidia-ec-wmi support, but should not use it.

base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
-- 
2.51.0


