Return-Path: <stable+bounces-254198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FTvGPavFGqWPQcAu9opvQ
	(envelope-from <stable+bounces-254198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:24:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19B5CE4F2
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82A8E301ABB2
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC638D40F;
	Mon, 25 May 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPenaiao"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B629D29F
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740659; cv=none; b=CdxjM0njR+5Obrd3mqhhk2R6hyqoNoEz90ZuN7XNuYIInotboy3EU52loJ4bQ/uuXWkFwiAQT+6t/++Uk/4ohl8rCo2nIqHPXRfS1oqaET96+z2L4KmizPg3mj9DYSaR6HI6NiNy4iv0yA7tSbUsgmm1OCOSfhaNXL5Yuir5tuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740659; c=relaxed/simple;
	bh=mQzf0udB9WF5zu5/FBlJF1x0afDQDwFSq0CE/SAXcyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fb7smg8lELAwD/7XGNtxHrdCm4PJWCKja5s1Kc6oPgq+pTaSM6sVVn8dzA4zGGi+PpOI1IVg/6Cv7/ziBwMfR8fZ1emDzOvQzctnrEWa5dPZQbgJKlLW1fH3gmZwFxxthzbQjLPNpYRjtUrfHVdkvMNikTFKQDRirDwilQCISY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPenaiao; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-47c7b282e21so3852358b6e.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740657; x=1780345457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3w98fzDAZ74VeWHLLU7AbRT+oeZljBSAiHlsaRVO9E=;
        b=gPenaiaoDuuOzGo1e621mFM+6om/7Qe853eoAtGh1P+B+u2xSI3WV42UUp23UBz/Gb
         FPBfZlnypj5tiBiQ6MVWcve8E5tFZa6AziWm3iyzf/o+nfKErI+M7s08Rri38CDm/ns8
         SUhI/Ib5DzioG5Gh2wtvKW7tvO1L+P6EaRD40WHSt/E0KiRUuZV74x5Z4EYslgA3Vt8G
         n4GgcZXV52mQGOVZDhcuzCwrojzv2CfZuRgRJOPV/1jNP14hFDDyrRdhwcMqaToZjgur
         ERVAghEmFFtv8OWhtJSnvhPgwHzRUzE9VsjTHrsgCCS/rgH5Taj1vILvfl5cr07X/AQC
         2xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740657; x=1780345457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3w98fzDAZ74VeWHLLU7AbRT+oeZljBSAiHlsaRVO9E=;
        b=TFiJNTcBVSFvuwrf2RbPg7UIgaMI0yTCw1cwp3zAhD/b3uOmbJD3a/dvbNTfLvMwPO
         ySai1E0pcu4XH6gCMsxHdU/YA8SHzzyaUNkeHfRhPYXUQQvguGm6lE6M5EWUunifCPi+
         vDXzeksvrpuKJ4IkGbBLQ9ZT2+Pdrp2y26i8r9Aeefgk4a0pawqyEc98OX2PuafBp8u5
         HO9y6awOrfggJN3F4AavfDyh7kLCkDAEXfw3cw9XG8sbfzNIUPUUyxOGjLWk10pxocxe
         VtdSPhX1o07IdCzx1QxDMIfN6Jj2Gxcfr/OdnRerZo0InNXNHaaAfCh9WE5XpmxMo5Ix
         qIkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MsEjspKeYkjdyyp7+QuHTKMqIHMhPKlm0sPJEYA5HYq4PKYy0mKfMJF7shjy1W21DyASZveY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznY+1kTaFmZIYnvmCbTZlOwejv2CUiDZp33OiEiD8ik2cTQcWK
	OE2hx/OPqN+85h/8KHsknoyxn08+Ykg/pkS8zn195VGo1m7DOMt7EE/P
X-Gm-Gg: Acq92OGOr6t+JAlJjE2C0W1RVDdk4EdPreCCKZDIgtUvLuDsvIG7n4lNbX9gxcdWjPN
	LJHkFlT75fj/yezgTWNTMXVkZ1lqzGylPdGEhnHwmyRi00QHzIZG/QLERLeuW612Hej+febKSD8
	0AIoqyR3ylvL5zrVRpMct5bF0BPHGa1oob/fJRUMtUNj9dnyQflzeiTlFs6QUyhQOJ0URuOlvnG
	82ilbTWfyZv2oy3DmejwlVmS20B5OpsVVyuLadREze/o2xGhmyk7yr2kBwkv1vs/X1odhd3ZppJ
	5PEp3EQ9XysabRtrc+dU7AzLQvwjOEsnNba7l0+kKHXEZUqoKiw7RNayj06o4Noz6wrn54uElVy
	sqcBHLvUfst+vIDvRazQL5nsu1BWkyYUMx8QblPkzRM0/GiZ+wtRodDkKu6hzXm6HUT2eFF7124
	fiwIep0bmzD65C56JV9ucENHPtPGQ+YW0PGS7Fdazx3+HmGl155znvCy6JsanR0MB1/knm8IPho
	40lcSgPjNwxw0/PYKn+qQa1E55AMMYQFjF2pA7g/XdvEUw=
X-Received: by 2002:a05:6808:a59c:20b0:485:5997:d38d with SMTP id 5614622812f47-4855997d8a9mr5340008b6e.29.1779740657485;
        Mon, 25 May 2026 13:24:17 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554757d5dsm5204305b6e.15.2026.05.25.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:24:17 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 1/4] USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
Date: Mon, 25 May 2026 15:24:07 -0500
Message-ID: <20260525202414.602-1-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026052517-undergrad-reformat-44bc@gregkh>
References: <2026052517-undergrad-reformat-44bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254198-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD19B5CE4F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

build_i2c_fw_hdr() allocates a fixed-size buffer of
(16*1024 - 512) + sizeof(struct ti_i2c_firmware_rec) bytes, then
copies le16_to_cpu(img_header->Length) bytes into it without
validating that Length fits within the available space after the
firmware record header.

img_header->Length is a __le16 from the firmware file and can be
up to 65535. check_fw_sanity() validates the total firmware size
but not img_header->Length specifically.

Fix by rejecting images where img_header->Length exceeds the
available destination space.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/serial/io_ti.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index a35409bd766c..afe29fdf9536 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -844,6 +844,11 @@ static int build_i2c_fw_hdr(u8 *header, const struct firmware *fw)
 	/* Pointer to fw_down memory image */
 	img_header = (struct ti_i2c_image_header *)&fw->data[4];
 
+	if (le16_to_cpu(img_header->Length) >
+			buffer_size - sizeof(struct ti_i2c_firmware_rec)) {
+		kfree(buffer);
+		return -EINVAL;
+	}
 	memcpy(buffer + sizeof(struct ti_i2c_firmware_rec),
 		&fw->data[4 + sizeof(struct ti_i2c_image_header)],
 		le16_to_cpu(img_header->Length));
-- 
2.43.0


