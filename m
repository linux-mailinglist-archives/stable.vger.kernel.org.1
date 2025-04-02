Return-Path: <stable+bounces-127386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79966A78943
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F365C18935D9
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05823370F;
	Wed,  2 Apr 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZmKMwCJT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6D20E6E3
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580613; cv=none; b=dOKIgjF+cHuqO/Pcwqo8kCZv4KxzDx/lJdxkL59T4w2Nj5bi6EtY0lEEyy4sCGjtMV7q0/ILZcan6NFn3Hg06QsTmMbjwRLjPASk+sg4snHlnmvG/Sy+A+mcQfQm1caO3ojIViES41oGygxzyjDhKSgSrjkvqr6E+Zn6RMmERB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580613; c=relaxed/simple;
	bh=H3OGg0kIMQeP8qdswAbf7cM6Ad/dIbr73ph7rC/fcCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwMWZaJclGB3oK95fU779RCwJILoju+i8JGNJI+xetCVL5vmLq5I/PuNkBNFiXxtCdNvHHNqaE3NK3aAobREPMr1PX3rYOGnQsX0Zb6XlHDLXCvEjqlKUnFA9M62WNkY1oWK9BsVyp7cXfamd4H5sTC0kVyvhw7S4S/lu5paMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZmKMwCJT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso46437495e9.1
        for <stable@vger.kernel.org>; Wed, 02 Apr 2025 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743580608; x=1744185408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+jxuGPpn8UhWBOA8tKb7Urwo73VrCOpJOvnus8QvT0=;
        b=ZmKMwCJT/LgmNU0R+H2loe3AlMHOZUHKagqjn2Kvwg2QdIv7vcDS91z/VJm5hGg4JG
         2ehtPcS5OiaHIfjBQ9E5L237EImcMTKEbA6G4hSOuAKpKhpAmDhcZcH/kvHEA6Q/UaZ6
         soRJxoLQOKYFsMdEEWs0nuv9iWIij2xu+9ALGJm33TL58nZ2D4O7BwUnXVllBApgfMqx
         L5s/3r1nI05kY/ik+brWgPv8PBVK0qlAC43xcN3phm0ta8QdJMu1DCWJew8rpbhW9KBZ
         xfPonZ/aJp8E1D663qYw9+WyfCFyCrXCfPhy21ddrRx66HcKJnJgV8jMhNXXJ3TOe3cv
         09oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580608; x=1744185408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+jxuGPpn8UhWBOA8tKb7Urwo73VrCOpJOvnus8QvT0=;
        b=dv6PBTuFnSzykquRJZeYKHZMpAvqpxgdlFpwv2KEHcJiPugOUbaC1Esxx7ZL+DzvZD
         Y/Z4h69JGbbp/dP9pg4YOaP6kwnvHdDTNbEKDyr5v6D9jUxVI6GGToo06Rj0dZCEdWHz
         VUxo7emm6t5/dlDazpBIaCivnhzsiJwtMPhDKIwlmZlVDN/m9sUWHM9CtaMD+HiG4e++
         g6hRohBlGE+rYx+lmUz5h37ZNI3dqq1Q21emFXPv+0E7kz1wKz17ejFeDgZyjCnZewUM
         04RzXTi4MMRR85gjidKdVrPvgBJSDm2UMdqCaxZ/OAdwf8aC2+RRbn+cP1pXbdmLOvdu
         L9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt+ZKvhP/p+1fQfJ6fnvifqtUHff1BrlOIC8VFA84K6IB3MKofgM6dpubMQyOiAZqXbuKDxnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQeG8VOEJF6SceZXCXAEM+gIOmgarCtNTm85crAPTiL11m08HM
	SErmWFmCKgslKDJqw96lQpmqAurK2uVS3rGhboddGHgBR9xsZkq+vIDB5X1K5ggSZciM0RoL+Vo
	WTe8=
X-Gm-Gg: ASbGncsUqu+nCSdNb4KMbXMjVbVVWKE10xE5Sj3wTW3ARs4tOhn1EsR97Uq1r1V1LGm
	G3xmBxdT57VKT0f0fprMD+r+uD+rXyqt/IUK03S4k6hAgJeQUsuJHfI0jw2X/h9co83GLaghgHR
	q+ElpHcUtQ2cUYxXSRyeX3bRFJr5Pc1E1Sb8UjaNp5rMhuCzeLbRpRAu1fKHRG1J1Bx7sohIUZ8
	GElTN5UkQtM2Ye2vGMzqO8eRfffg8DDG8t/wmiMthR3Sck1B6epbz8uxAwILI3HuzKxoh8soKv+
	xDB6bLtPEz5Y40zQ5aeSXpH6yh8NdHPqfDP8I9iPfMj4HgJcU7afiqcdz0NH6g==
X-Google-Smtp-Source: AGHT+IHvTxuEMCGhj1rQb/thcgAqbETdIYWBUjTq1KzR8rsfmgOFTJotr6HWFaZUMQBRcG3NuehSow==
X-Received: by 2002:a05:600c:190b:b0:43d:224:86b5 with SMTP id 5b1f17b1804b1-43db61d75c8mr143982905e9.4.1743580607807;
        Wed, 02 Apr 2025 00:56:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:355:6b90:e24f:43ff:fee6:750f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb6103a07sm12336445e9.29.2025.04.02.00.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:56:46 -0700 (PDT)
From: Frode Isaksen <fisaksen@baylibre.com>
To: linux-usb@vger.kernel.org,
	Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	krishna.kurapati@oss.qualcomm.com,
	Frode Isaksen <frode@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] usb: dwc3: gadget: check that event count does not exceed event buffer length
Date: Wed,  2 Apr 2025 09:53:27 +0200
Message-ID: <20250402075640.307866-1-fisaksen@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frode Isaksen <frode@meta.com>

The event count is read from register DWC3_GEVNTCOUNT.
There is a check for the count being zero, but not for exceeding the
event buffer length.
Check that event count does not exceed event buffer length,
avoiding an out-of-bounds access when memcpy'ing the event.
Crash log:
Unable to handle kernel paging request at virtual address ffffffc0129be000
pc : __memcpy+0x114/0x180
lr : dwc3_check_event_buf+0xec/0x348
x3 : 0000000000000030 x2 : 000000000000dfc4
x1 : ffffffc0129be000 x0 : ffffff87aad60080
Call trace:
__memcpy+0x114/0x180
dwc3_interrupt+0x24/0x34

Signed-off-by: Frode Isaksen <frode@meta.com>
Fixes: ebbb2d59398f ("usb: dwc3: gadget: use evt->cache for processing events")
Cc: stable@vger.kernel.org
---
v1 -> v2: Added Fixes and Cc tag.
v2 -> v3: Added error log
v3 -> v4: Rate limit error log

 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89a4dc8ebf94..b75b4c5ca7fc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4564,6 +4564,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
-- 
2.49.0


