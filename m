Return-Path: <stable+bounces-235810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PJzGLSN22lODQkAu9opvQ
	(envelope-from <stable+bounces-235810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:19:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D37733E3C30
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A6C43012CED
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD9379ED2;
	Sun, 12 Apr 2026 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjkZ/LSZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AC3115B8
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775996334; cv=none; b=sLj2mL9BannXWunLiikpl4R4+mBXPk3nt/+zZY5aJvn3Q2fUVfolfCDI/icvezzkGM7SgRjYc017uTIEGiyfrGAyngOAVsv0cyEncwKQLgxplV57xRTzfoRlVsQ/8r0sK3Vp4s+1OcZOpIOqCFlXmcctbfhU4noWm9pSlIJcPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775996334; c=relaxed/simple;
	bh=msJfBYh+DCzMkSQsoFZg3hlhI5JX+2yB1zp+8QLYXEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqzjMwmD8KH33s25zzB5fZ45LEAlaa87xEbRvnO1UKWrgZPAAwW6FAKiUbB3MQFdrw0g8pdzl16zbox5nrgKEj9lQXbqqkWI2CmaITGODHiZlR1KzZflf5WMAk02hjMvryu/pN2vMoKRNf9CqyhASfu+wIETmOsteZG8QP9zDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjkZ/LSZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad4d639db3so16234915ad.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775996333; x=1776601133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgcJT6YPrQrJvW780ISmc/kCiCj7OaF09LinK7ADVkQ=;
        b=JjkZ/LSZbShI/nN1+PDnIvcVkl8zibeSm5QiGNfeAjlmFWrz9YoCggRrQp5l9nxBhk
         a5ceL1W3hMA/ubVUdzrrbaHDqucWjeqVf3XmTOTSbvxUDDWKbdQfTHB7p877G44k9Gd/
         y5rPAGYhglbamNYl0ItLXxBvh+MlxhUce45nr37fYe6DpzdvvfnLET66XaRdLZ1WSOC5
         JT9laGTazTygZRkORdWXpXWTrZ8cm4tlW89VMH2QGJhzar7W9njJbpzqF4eZi0syEHxw
         196rhIeOc59tqI37T0Ttk87/dM/kb2W93a+BPxDK145JERAbR00CgaE/DnUKrijk3HY9
         6Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775996333; x=1776601133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgcJT6YPrQrJvW780ISmc/kCiCj7OaF09LinK7ADVkQ=;
        b=ZZdGJGSqOYQ64M7sreIew9XWvtJCTBx40/DwU7SporGWMdtw7QL1/K/vdIgPgcWegE
         om/vVaDjBcHRoQkwt6F50XYc030bUYNQlU3vohucuxBLPyg0GtB07TZx0y7zkoszBCLl
         jGU57FtWpAPlHE4fgKRiXOdx+CSedtPO1KYz6akHHg8UnTJA0mX20WaCtC3KtWfNMqAV
         dJN9d3RTkbdeppS8NBpezkQqkokXcSRQTXNdh6zKJ7xxWKRopGMHV3a34N04WelknwJB
         65RZkaAPr5wMFxXTcliTRyv2vOOP2/LS+M41M1j/jdivyzP7NACK/OLLB6KrwDaM32Of
         U7jg==
X-Forwarded-Encrypted: i=1; AFNElJ/NtZCzFWjkIJFg/+1DQL3fldtjQPwj3OMbOTLam6OHuGmgq9XCSdgZFK2wJNMm5qkctZRx2SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaScJFCoqk1XcZHIm7IbqVICOIsbXK4AF7BkbW1P0Xy2Cq4fo
	jZ+bSDssW5f2U5URcPW8VuFg1xLGfRtPFSgS8nGTTJ5BysgWNF7esc21
X-Gm-Gg: AeBDietMA/Tzf8skq0vnnWydbsHJpbCeDoknSlqEJqALKE3cPDGcaqUTwsctw+qaDTg
	O4vj0gBns/XlVx8KiI6GXyEE0Zhv045puZcvpPWxQbzunL/qSk3DzUbctx32NsBBtUY+8pUss77
	pPv19WxhC0JOPJGeTHKl3m9/UQeJNjQJhPsZR4IDbBb+2QGc7zQWtbE3PPsDIV/rEXXBwsMpesq
	pQExbUfyiXq6ime8wJO2tu9ee+1uCzfdvd90Q6oInGlip5/wJp7q8XRJ0EiUZt8pVKVT8gyVWWj
	QcvWBISw0bPoDhdC7nqjkCCO6dLOudPFBpTMcmSGL208AjLB1gN+IJGNCdfrL9scwIkS+lIzxgT
	2R70Y8+8WBN4QyowqIkstDrCXs93AiRnmAUB5hy56O6SZYZUzhKKapfSClGMfbPeo2ATLEauxa+
	bnlQs8UrfVvr0xUw==
X-Received: by 2002:a17:903:144e:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b2d5a7773emr97707585ad.36.1775996332835;
        Sun, 12 Apr 2026 05:18:52 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2eae817fcsm28965705ad.44.2026.04.12.05.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 05:18:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Vamsee Vardhan Thummala <vthummala@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpu: host1x: Fix device reference leak in device_add() error path
Date: Sun, 12 Apr 2026 20:18:36 +0800
Message-ID: <20260412121836.2461556-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235810-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D37733E3C30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), the empty-subdevice path calls
device_add(&device->dev), but if that fails it only logs the error and
continues without dropping the device reference. That leaks the
reference held on the embedded struct device.

Fix this by removing the device from host1x->devices and calling
put_device() when device_add() fails.

Fixes: fab823d82ee50 ("gpu: host1x: Allow loading tegra-drm without enabled engines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/host1x/bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index f97567e6ae87..e3ac85848aec 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -477,8 +477,12 @@ static int host1x_device_add(struct host1x *host1x,
 	 */
 	if (list_empty(&device->subdevs)) {
 		err = device_add(&device->dev);
-		if (err < 0)
+		if (err < 0) {
 			dev_err(&device->dev, "failed to add device: %d\n", err);
+			list_del(&device->list);
+			put_device(&device->dev);
+			return err;
+		}
 		else
 			device->registered = true;
 	}
-- 
2.43.0


