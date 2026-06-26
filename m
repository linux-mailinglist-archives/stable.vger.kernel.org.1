Return-Path: <stable+bounces-268747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8AscNd8LPmpS/AgAu9opvQ
	(envelope-from <stable+bounces-268747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 07:19:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FD46CA44B
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 07:19:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rg5epz9C;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268747-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268747-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43ED83028452
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 05:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08F9395AF8;
	Fri, 26 Jun 2026 05:18:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC43A1A55
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:18:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451095; cv=none; b=DIBpXKfEN9e74QqP2F27TqTVCFCOey8Pj3+GsGMy4xVtnhfUcuz5H+sScO48V5poyD8j3RIacKw1aBkQqOAuwlcaRFHySfvkTHcTH//v1Z1CxftJbCMH3b1g34MO2CxkTxt10h0Zw3e5xv7QQXaVoBXXP+zHu6j4DjdhntUFu/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451095; c=relaxed/simple;
	bh=oI305MqoOf4OcBFfWfvo2q/rW61nNlADLsX9gv75Y20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRaY1bedIUmJ1yGGG28Gvd+y7mdVOQpfNCV2iEESHSfNkN7Oa60g8SsVWKEKBJ9jeUQ/aaotrR/KgCXaB4+4KWoTKaPkIrkHbtsOFJjuoR9HHDoJYYsvIiUCNl3JZxwl8zphXCMXmv/cTMz9Cm00gTVxwPp12+r+LAiNzSQkOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rg5epz9C; arc=none smtp.client-ip=74.125.82.172
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30ca1b4b278so268708eec.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451092; x=1783055892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9f5K0F89CIVZXgY481pC2XHEuVEtLfkjz9FoRFy/os=;
        b=rg5epz9ClOHBKynSxajNKm8CtwuG9za0SM4YheYjsiHpY94kFPBOb7q96mQMl28Tdg
         yFcln44B5px8dKDFKF9eBhPiwazL6xlzcY/HzZQ+62tEtO+AMDdG7Omv7q5O0EO4Lg8a
         3+LATSJC+CLg7eebTwp43fkeeOw5cKX2BxWcq7K4izKzbyz8Lnvtkglw+iOsWaCMfjyi
         /w/KoFwlYA5dH1MlvOdLKmIBqNZwbla6twUKaHy8pLzYEPQSh7A4GNUwkFLuZYDMI9pd
         R9vi4gCKpX2Pd5KTHtEq5bdQdwVzeSNoe/4Qg2xvdoDgNPuvrXCXhbDD4aMCfB/uFWbp
         PHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451092; x=1783055892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9f5K0F89CIVZXgY481pC2XHEuVEtLfkjz9FoRFy/os=;
        b=Y5GW2JeF5a9hUQQYsfwigp7WvC0CX8nINjJ6cGqxQHURN2XU6C5ASVFbtufbkf8WMT
         kWvLv7M/0hEXIo1auNvgrXojrUUAFuBf0pnuxrLQi/OYMTRgfmSuQT2/iDoCoP0hi0Hm
         52Y6huK3D16FrHQ0uLN9UM719eWgKzLf27YlRF/SqhfjgotYVfj1cNrIYUjj0LyU2Xyc
         3znYCvmK278TDSa9vttiCVAhAuc8QX658HygdXijdgNWi5i/8kgFYdwt8PMlfaNe1gdW
         oW1dYErZxKioMk6zaFF65KeRqyk3xKzJuDa+o2MA6BsgYYfCnaOZgt+/IuSWmyVm7v1k
         L7hQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAboBn5EJ+5d1fN/XRIhQ/GPssM3FfDq36INXNWMfwvZeGLxgYc417m9Ve53j5jrF99WhiifM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRRak7hMxnWC124aRW1Iw/q5CId2rIsSyBYRgPbYXboECsbev
	MEMVKPw1NXWIATtzSsV7T/cU8eXHI1Rp0pPv0HR3zWKw2tk8v0M7LD0F
X-Gm-Gg: AfdE7clmReLOIypWEXLVgra76iWdkI2HnQkumFw3ObBl/0WGdZYDA8jijgcDj1I2jNv
	pcXqPP1WQVOprpbUdcxo1uY+YeQ3UpjcZKWWF6jBfos/SbIl0NAogK0rM9PKumA7YOOad7hrOJt
	4Ut56MIxshKvezfQFzQTUuW2f61hlkwytunJQfKJxOW+1YOhOuLb2BmFPeGDlmTHb2FJ5ciPSKo
	e0fL/me0HwQFhF3I5ZONVv6VSeZoBAtg0k+L6JYCC1A23e41e1eQ/20562pDldJ/WeBZA0EIWEE
	cxCJzVBW90ENiMiZNowZ7/MatJZkPFCCwuGxgCXGNCzj6dYjc5h4K7vRRP5BmAptsf38XCJlYNs
	Qrqw3T2cAW6fBk5DuMxTLkj7wMLQylHgALryDMa2jgP2fN2+itY83rX9vV0IwaZNkHgBaVrk8nc
	n7XgL1Ljql2JWJVcoI9ktHwOKGLwzlu1NJbP9S2RGeA+axC41bEk6I6iqkVtjhsCK/hQF0XAHzQ
	30a
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id 5a478bee46e88-30c84a265a1mr5890749eec.0.1782451092285;
        Thu, 25 Jun 2026 22:18:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:11 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 05/10] Input: synaptics-rmi4 - block s_input when F54 queue is busy
Date: Thu, 25 Jun 2026 22:17:54 -0700
Message-ID: <20260626051802.4033172-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:hverkuil@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268747-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1FD46CA44B

Changing the input (diagnostic report type) mid-stream changes the
report size. Since V4L2 buffers are allocated based on the size at
stream start, changing the input while streaming could lead to a
heap buffer overflow if the new size is larger than the allocated
buffers.

Prevent this by blocking VIDIOC_S_INPUT with -EBUSY if the V4L2 queue
is busy (streaming).

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index aebe74d2032c..e86dfc9ce7d9 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -445,7 +445,12 @@ static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
 
 static int rmi_f54_vidioc_s_input(struct file *file, void *priv, unsigned int i)
 {
-	return rmi_f54_set_input(video_drvdata(file), i);
+	struct f54_data *f54 = video_drvdata(file);
+
+	if (vb2_is_busy(&f54->queue))
+		return -EBUSY;
+
+	return rmi_f54_set_input(f54, i);
 }
 
 static int rmi_f54_vidioc_g_input(struct file *file, void *priv,
-- 
2.55.0.rc0.799.gd6f94ed593-goog


