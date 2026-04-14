Return-Path: <stable+bounces-237795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCyICMEe3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:02:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD103F912F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 064273012CEC
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BAF399356;
	Tue, 14 Apr 2026 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Evvp346P"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8A3D6685
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164511; cv=none; b=Dx9zQRjhUUICmlHCIeG0EsYJEJ7YAOLzgV8a4IVwwBFH4CLGirGmvGlHNcl03qrD7nPXAKu/nsmBlvBmcIFspnNuyZWiaWBMMaf64v3nwEzvzY5QuktQxnk0QQT+3qUAsvXbgcsgpry4tjwhCyEQEp/82b3I301OveaUGEWwmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164511; c=relaxed/simple;
	bh=09CSSN7RXTHbVTooPnkKL8N42ACW4WU8ALZckPLvQfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqG11Re7CW0bU6s7b+dDwrmY6NRYHJnpPdCDoJxPQAbxDvk9zNuRbK6AJewRpg5+neAD949Nj3RK8VHQ1qIlqHlkNfftfrQdZec2ktq8wRY8qhXeKDw4SNs193Hy1GK9etL4fJydzGq9qVsbME0rmliAKjk7KT8wJzxOk0mCqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Evvp346P; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso39510171fa.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776164506; x=1776769306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOGZ5PgT7bKnm42QHRpfyT3u/Mi5orJjibUzxYtv58g=;
        b=Evvp346PzwEbv9DKkkjItM6l5qJMCffa6hDPSpTUIA5DpexhtfNEe1NDQtO4Uk2pbu
         aY7pRamPzJSq7fiDhwMwXfSTg1HRe5rZV9ftFjCCji9JXKM2Z64todeswd8E4en5KOd1
         G0KlHl+Zwulndqy9C9uMjsNcajUL/G9byf2es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164506; x=1776769306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOGZ5PgT7bKnm42QHRpfyT3u/Mi5orJjibUzxYtv58g=;
        b=EspC6ART1JtsaN6wt1gHOsxJqqY/OkbsqT2M3h2q/3cMgjk8YbxH3ArwZ/SESB8W39
         t63zn9BVGGjquCrB3KI3T05co+gaSk/fPAlg70iH8K+LrXNirq7SuyCcLg2IYjauTjV1
         ZSLIJJqZdS3vVk8K4c7E8hxoiPBW9OrPEwBp52+fUCbM+vFYY5UVKlZ4u2u2AADK52C6
         KvPaEf1CxlwhEGsiP2XeKm67joJq5kyqmAG0HlHyRHPhdvy8OqQQm8DyoLbo9JlUM1sO
         jhwUjLwV3nePQw3/3Uw/LKQdlNeT0aKG9y2tTJ/GjatFWjPHq4haIfCIJWwY/NnLcGM+
         d5BQ==
X-Gm-Message-State: AOJu0YyFcnDDzaE/jdqFkFhvnKFiCrkkePa2nA0bVTv1c/zZaNENLFuB
	Zy9evBMnWtjwrESXYjy/BgYkl0P+/HuOKQR+ROyRJnIFZdslhhRt7OzCppUV/UA6lbaTwy5KTNK
	3RrQFZA==
X-Gm-Gg: AeBDiesb5Syq3ZAPKDWzr8N7O9+M3ehlQJpjIKVf7uwhPUHTNLLZtEKBWJCrfMwud7a
	AzCsCfXaVvjNzkzCk2LLUlCI3cZh/ZonlXw/jp2CTIDOnWH64Npp52QRSvDMjaRo6A8DgNiIy4m
	29gXwoHyrdT4FecIyjNFUBroYuv4ZKGFCHymdG/HzvDkkmIehPqteDEfJeCzKhuhytHptlkZWzb
	aLkdc051VnyWUIWHlE8VeWQXO+9J59iSDS53BNEeJhL3Mb7kG4xJRFAL47JIFKdLdw4DjGoJO5q
	AzCA23G6646lhguxKBd4cGsFWBjEQNxT/HrPTP/tAWxKC33R/eUOBTv0WnP7Y9FJ1EJXIFqEbWk
	a7/Y3POXczlldiNVC/8HJIlHif44aGDXjmj1Y8wfylanp+UUAlDm1ZSCjNIpZ/pEfaOLTcC1VSK
	+rHlUNUKsEKxRBsXjZKsiP03gqjm9fC3FTgwxNsz5M8cY7TBlT8QKKJTAUkplzsjl5ucHNzxjtK
	lGv74INXPK/wRZB4fMnyIY=
X-Received: by 2002:a05:651c:420e:b0:38e:b6:f335 with SMTP id 38308e7fff4ca-38e4bdca9fcmr47536101fa.3.1776164506479;
        Tue, 14 Apr 2026 04:01:46 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495ae96fsm28055261fa.39.2026.04.14.04.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:01:45 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.10.y 1/3] media: uvcvideo: Allow extra entities
Date: Tue, 14 Apr 2026 11:01:11 +0000
Message-ID: <20260414110113.319219-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
In-Reply-To: <20260413223308.3760836-1-sashal@kernel.org>
References: <20260413223308.3760836-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237795-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[chromium.org:+];
	TAGGED_RCPT(0.00)[stable,huawei];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email,chromium.org:mid]
X-Rspamd-Queue-Id: ACD103F912F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit cae79e50d1222010fde8c522410c315f74d35c40 ]

Increase the size of the id, to avoid collisions with entities
implemented by the driver that are not part of the UVC device.

Entities exposed by the UVC device use IDs 0-255, extra entities
implemented by the driver (such as the GPIO entity) use IDs 256 and
up.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 drivers/media/usb/uvc/uvcvideo.h   | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 419fbdbb7a3b..c2adc6854c54 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1032,7 +1032,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 	return ret;
 }
 
-static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
+static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 		unsigned int num_pads, unsigned int extra_size)
 {
 	struct uvc_entity *entity;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 60a8749c97a9..a83995276170 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -302,7 +302,12 @@ struct uvc_entity {
 					 * chain. */
 	unsigned int flags;
 
-	u8 id;
+	/*
+	 * Entities exposed by the UVC device use IDs 0-255, extra entities
+	 * implemented by the driver (such as the GPIO entity) use IDs 256 and
+	 * up.
+	 */
+	u16 id;
 	u16 type;
 	char name[64];
 
-- 
2.54.0.rc0.605.g598a273b03-goog


