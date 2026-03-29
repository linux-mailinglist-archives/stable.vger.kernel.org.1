Return-Path: <stable+bounces-230847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMigAPTRyGnprAUAu9opvQ
	(envelope-from <stable+bounces-230847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:17:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86906351010
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 537703027117
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57E2C3266;
	Sun, 29 Mar 2026 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTa/AzPN"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02A9221540
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768597; cv=none; b=OhaMZ2HzFbjxMdK6QvhWEiRtEOCsEMtTy30ktn7Jo4SiARLhOxvhaWLPZMVK9CZuYoV0uaXAcRxoYeg3xESqQ8jvnc5nv6Xs4L/IUtvq13tswOBhn1SmHcSpw7NwTPqarJAXjXRQVq5NjlW8GniCm7hOGY2aXnOUWbq0fqXW+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768597; c=relaxed/simple;
	bh=SJRE/7KRsudcGVRZrVRgBTRMuVolyj6lhYLA9kgm5S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YobhKsZSgYBzFnw2OOwAKxYP7YdVaEmTObWcaJtRYzBnU/aQcq5L4fNcyHYiSGmDV3t3EwOsQUq3mBBMnINFdfAYCEdf9WINgOCPLNo4UeKSSqVeIxy4+z/xm80jywOJZ7S1tsNqrlGYJsqJ1mcTRWkfycC577XnmwitM0jaJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTa/AzPN; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-604f834349cso713173137.0
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774768595; x=1775373395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toe9kpqOLmbJqv5wMH+Pbc9jMDhi/6HRl6vvRfImJyA=;
        b=aTa/AzPNvz4oTqfq77vO42fWz75vvM/dBJkvK44J+foqV9a+7r1je5kW58Y5heK3St
         f0soMZWVqgHB8/a+UAOE/+CT3GmH6osLrNMUAfb1/TUQXeSRkYZlItOslntl2v3TmpeX
         wV3x194TDnIM6WKgy27YuEISyBIhvmccRLswncn4qBYbbqmUzGuP0Thrj1lK0uQe7uWB
         hdZXdTb6j9inUZQf1Zr48Ydmej4VL7kN7TP6JU8S2VdTWPZJAWVATgixOGGbrgHGtTEo
         TeyyztFpjl5DbUH3/DH31muR+nFJNk2Dr9ZP+Z95Aaw3ASv1mwx5q1JN56+QFzW1c0Qj
         /DPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774768595; x=1775373395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=toe9kpqOLmbJqv5wMH+Pbc9jMDhi/6HRl6vvRfImJyA=;
        b=HdJsSP1X8LteF+VHx6zrY5nOi29kO8c8Gfo46+tPRbejfXG6Fja1MiaIF2e/SWJb72
         6V67K+PLKPyiXab2XOQ+td3A2i4D5VSX6LWNxpnvF2oHYOdu8SeI6fVh2FtcNsYFxo5x
         NkMNyS0zlUQYAbatng2+EBy895bshn+CbScf32N2m+GUtOawnwTdgbBsd++gr9MuwD6u
         aP9mhjVvLMzn6qwTWM6XwlVyoPkAQ6v6TK6rSv6FKfaj7dBnt/9zb+Hq4MQaFCSf5Y9r
         kXEsWzaaYkHV2XC0LQ2y3h3v24F5gOfgKjb4WZHnYvmAwaOANzxFHLdivYQQVPbTrvb0
         1H3A==
X-Forwarded-Encrypted: i=1; AJvYcCXtciSi9lLEFAjrHhbVtwTyGZIxx7vUCaeEhK2NPrlyu0X5KbxYtNxTcxD8MeQP9tcZn38w5MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBveHECTWEXY+ijwIUSY7R+E1cRfTtMyxohL8VIrLByRTz/mU
	cb/fFmEj7tK4ZqLRL1qONyhUYKue1G7kOoJeE/6/Rsqq0E/+h4PR3QJW
X-Gm-Gg: ATEYQzxIz0mWLUWZYgp79E9kqDmiJLCZCSDbgq0uewjAWBEM8rYxQDTTh/Cqk9V0XBP
	NBxCSK0MOaQcKEm/QUYW1ODGL5JbXNGDijvylPOkwVb5vgNTQI1awC7u1Rjg8Nam+/4oTjSprFx
	dgL4n82LSlcYyrqYpYVgrX/At+Lm9P4+oLwnAbAHlM5KGhjBqDuHZsEuOLSfdM66ip8x7w6ioCv
	CsKe+Rof2aUpfsXXd1Qesgj/zj9fsWa8g3sSZg+M4Fi9mLX6T264YKNX2o74cNK9TbUmYtKz6wb
	6sloPAhBbQtB/KBqFacA2YLZ9bO4kYOluTaaoxcdGm/BKwysX0WKZZR1XHKv3K0mIoz2o7jolR4
	HEU6Cyiil20VMrI7ggiRZOGRChvk14U8L29ZdwsA6oOIKpYu3RUPhU7ZZICcq4PbHJjodDncXLZ
	fJ017fx6lwHVO8V0C6yoJm/ebB
X-Received: by 2002:a67:e111:0:b0:5ff:2426:94ed with SMTP id ada2fe7eead31-604f92960edmr3008410137.28.1774768594732;
        Sun, 29 Mar 2026 00:16:34 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6df:aa::11:19a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60512a5afa9sm4390638137.6.2026.03.29.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:16:34 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] staging: vc04_services: vchiq-mmal: add buffer size check in inline_receive()
Date: Sun, 29 Mar 2026 01:15:40 -0600
Message-ID: <20260329071616.507876-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329071616.507876-1-sebasjosue84@gmail.com>
References: <20260329062229.493430-1-sebasjosue84@gmail.com>
 <20260329071616.507876-1-sebasjosue84@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,raspberrypi.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-230847-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86906351010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastián Alba Vives <sebasjosue84@gmail.com>

inline_receive() copies payload data from a VCHIQ message into a
destination buffer using payload_in_message as the copy length, but
never validates that this length fits within the destination buffer
(msg_context->u.bulk.buffer->buffer_size).

While the caller validates payload_in_message <= MMAL_VC_SHORT_DATA
(128) to prevent overreading the source, the destination buffer may be
smaller than 128 bytes. This is inconsistent with bulk_receive() which
does check buffer_size before copying.

Add a bounds check against buffer_size and truncate the copy length if
it exceeds the destination capacity, matching the defensive pattern used
in bulk_receive(). Use pr_warn_ratelimited() for the truncation warning.

Cc: stable@vger.kernel.org
Fixes: b18ee53ad297 ("staging: bcm2835: Break MMAL support out from camera")
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
---
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 9c6533f82..44e5246f1 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -368,12 +368,26 @@ static int inline_receive(struct vchiq_mmal_instance *instance,
 			  struct mmal_msg *msg,
 			  struct mmal_msg_context *msg_context)
 {
+	u32 payload_len = msg->u.buffer_from_host.payload_in_message;
+
+	/*
+	 * Ensure the payload fits within the destination buffer.
+	 * The caller already validates payload_len <= MMAL_VC_SHORT_DATA
+	 * against the source, but the destination buffer may be smaller.
+	 * bulk_receive() performs this check; inline_receive() must too.
+	 */
+	if (payload_len > msg_context->u.bulk.buffer->buffer_size) {
+		payload_len = msg_context->u.bulk.buffer->buffer_size;
+		pr_warn_ratelimited("inline_receive: payload truncated (%u > %lu)\n",
+				    msg->u.buffer_from_host.payload_in_message,
+				    msg_context->u.bulk.buffer->buffer_size);
+	}
+
 	memcpy(msg_context->u.bulk.buffer->buffer,
 	       msg->u.buffer_from_host.short_data,
-	       msg->u.buffer_from_host.payload_in_message);
+	       payload_len);
 
-	msg_context->u.bulk.buffer_used =
-	    msg->u.buffer_from_host.payload_in_message;
+	msg_context->u.bulk.buffer_used = payload_len;
 
 	return 0;
 }
-- 
2.43.0


