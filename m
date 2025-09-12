Return-Path: <stable+bounces-179399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72534B557D3
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00380AC404E
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C412D3EDD;
	Fri, 12 Sep 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRkAZYZC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBCC2868B4
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709960; cv=none; b=MRxDPH05FmaR/2x6UBbSaZYxMnBu3Ysi4JuJKeu4rXKsG/f2sy+aKV/Dn2S/m/d3xZt9wzwgfTGN+S82v5zspSVz9tPL1xUfX7qFDhaAyBfNEJAP0UEb9nwptc9vhoZm6gAOaWfTVcrU8wikj1xG8YkJXmMOgyHjSgupY0wNIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709960; c=relaxed/simple;
	bh=pRQDPtc98XZXPyJsfYq1WEyLesiYNBiwIFGSQ2eZrTo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=boiXhqvUST0BLlrKC4vohdXi1BJt6NBtYd+xs2+mDVsWXk3gVg3GgNLrLcyHpXIZ0CbuOs2ryE5jVOCP4syjzQ/Oj3a6/0OPFesz3QUJJ+qkmlPFA9b792/STLr6elk3mosAJlZu1cpmoCfBWBrsweOjZpIJ4gmLZw0Jj3tlbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRkAZYZC; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7459d088020so1208862a34.3
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757709958; x=1758314758; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bZDPRfL8I496CAzITwBcmgDccZDsjO0kPZ35dZpbKU=;
        b=ZRkAZYZC/Go9YHv5iYKS3dGwb2UAoKKjnKbYfRL9uEKVag6jwpKxRYPkWH5CpnhMjv
         TvUW3HasVTCtdvgLPZPGsu+o7yXYKs02iH7hmTBSFUnQ4A48yK7VXI/PpI9OePlF4adQ
         vOcJwMvLicOswhMjrFUPQCjGzyPB9bIXgPGyBVYitUpc6f0MykAKhWrv64hJ+6Ps+V1V
         bvY76grQjD5847esOVFX+yb3W1bS0OIRz67JVRn7UYAIYzphgSdrBQyeXCoKkcHruaSV
         Ef+ymRAArnH0EVGzFvrrZNuk3rz43SjaqP+J27F3wXRZtTZrBrWC1Or5nK5W49BiUH8x
         BhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757709958; x=1758314758;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9bZDPRfL8I496CAzITwBcmgDccZDsjO0kPZ35dZpbKU=;
        b=kkMTBH7QDOfLCq/Oyy83MkqcB5oZ7Uf6BRJ4Ot/NDZrTMfiWZQ6h/X8J0qEPaf32uw
         guGpwlb5BmPpOZpPGXZpCJbB90PwUptbWdEe97Z7l+SGd7S0OWc5tnv8GpF7ENIBlq9w
         hj5XxprfN5lBqU2YtaepVLPxO41rGZax2SVM+2jEF6cI2koBsTkqoaCuZMClfCKxkd8Q
         StKhdEAiXY5nk3iH9OgiTpVof8SoPPXsWhSYjneQ0+cKO+tajXIdMXO/QHgN29f4lIwu
         Pfaj6+GPA1vukHuDlXPUbR1Zc5dDcSTgh5KI34ru6fRf6ySTYSP3G163QrT6hbUFR32c
         xqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIHkwJkyfd0oBB2JJSJdGsB/40p1eKY3XXcIWmRE4g9DpqUIfRzvyXBaftm8BNn1YECMZPgyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYdVVh+3WGveHJLdmFaZvEiFfbnlHN5ze9/HWua0f9Wfob7g2
	1GEU6Cn2BcU0Vdopiw2ShmOMBs/jioN8GWvBs4qSWLQoQoMQBdMFLS0=
X-Gm-Gg: ASbGnctGultYV4lNretDWVAu1hFsX/xiZEObFD7kSAFbGjoxG742o38FatBPKKalDHu
	K4dSlFi9FZ/JxIskHrRnGLYVOoRpdvStxEmu2w8UXCwKKUwaN0Zy5Z7IvRJq2S11NRcMX04iCZb
	QbmS032csHUVZCH3Trdq7rwHIe8cugJlx/2+ex5XKWeKX4IpUTu5+KseNPgzdHDVg8YVxwQxesk
	ZvCvyXWGqWrPTxkW+VzaiJ8WiV/IS2XP4ew08bpnDppK9B5tezKz0qdaYxVv3EMolhUxXYAXV9b
	pgIpU0mFievhVvT067G4LSReIt9OMFnOQkvG6JqZ7ozuz9JH2WRlrMS+riUnd4tw29rd5xCKGFu
	ur7h3oSLjrSf3CRFw46oYeyzOUDs95bKdYph8u9tJazM2Z1fwwBJQM1rOE/Al+5aC3YDFBYYVDz
	8=
X-Google-Smtp-Source: AGHT+IEm1gTbQxjO8LE+RY3w2iaAsCuuqbHiw9gMqHoXCsgjRZ47DUQ8KukdsPyjfgulgrRK1ZU78Q==
X-Received: by 2002:a05:6830:490a:b0:748:8b42:779e with SMTP id 46e09a7af769-75355ac0c4bmr2565621a34.27.1757709957857;
        Fri, 12 Sep 2025 13:45:57 -0700 (PDT)
Received: from ?IPV6:2600:8804:8c40:ef:8da2:cce2:d418:6b9d? ([2600:8804:8c40:ef:8da2:cce2:d418:6b9d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1221296a34.23.2025.09.12.13.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 13:45:57 -0700 (PDT)
Message-ID: <80bacfd6-6073-4ce5-be32-ae9580832337@gmail.com>
Date: Fri, 12 Sep 2025 15:45:56 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Autumn Dececco <autumndececco@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 linux-wireless <linux-wireless@vger.kernel.org>, stable@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>
From: Nick Morrow <morrownr@gmail.com>
Subject: [PATCH wireless-next v2] wifi: mt76: mt7921u: Add VID/PID for Netgear
 A7500
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Add VID/PID 0846/9065 for Netgear A7500.

Reported-by: Autumn Dececco <autumndececco@gmail.com>
Tested-by: Autumn Dececco <autumndececco@gmail.com>
Signed-off-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
 - added missing tab in patch

---
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index fe9751851ff7..100bdba32ba5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -21,6 +21,9 @@ static const struct usb_device_id mt7921u_device_table[] = {
     /* Netgear, Inc. [A8000,AXE3000] */
     { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
         .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+    /* Netgear, Inc. A7500 */
+    { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9065, 0xff, 0xff, 0xff),
+        .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
     /* TP-Link TXE50UH */
     { USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0107, 0xff, 0xff, 0xff),
         .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
-- 
2.47.3


