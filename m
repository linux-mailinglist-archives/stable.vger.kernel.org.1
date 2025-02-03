Return-Path: <stable+bounces-111985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC2EA25372
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E6D18847E3
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527CB1FAC5A;
	Mon,  3 Feb 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOZCFPIP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC53594E
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569642; cv=none; b=uxVZqDY6GHJDnG79YYA6KT7OvGt5ouj41TsZX1KLefnqZHvLxB9Xz7bV7u/5LgcKn045NWLbOmDsmCWe3v0Hz+Fc74C5ATR6hhmYiQ/zsw1zqCdWbXz9rs0bZxnHzTX5tts5kEKO1vKIUjoZv2MsF/YrMte+lBXJFjcjGDgd3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569642; c=relaxed/simple;
	bh=jaKiohpGb5GRdH2MM0NHY0F9IMzao8bMivRAcK7K9P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0cxIcBQwaLkd/UKgplBwPhaM4K2Z5Ge430+hzsEfUWY+Rtm/cB3Hca1aupdyHsLA4wehGITBZa4/Z6EDoXhBaWu/VCEsOBNXWGgILSw+7tbSWgsZIAYJ4fNSU+a78N0qUBNq974XOl3UBo+Dcn2ccvE/YaJE4EoluS20tY89lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOZCFPIP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-218c8aca5f1so78747945ad.0
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 00:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738569639; x=1739174439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEhIHxdD7NA+wb7AGZrBPq/eWZXsbGs0lajgHFDORFY=;
        b=VOZCFPIPJBsFnPu+4rYTCOdUOmVhs1EhTyShILZyxefa0G9uF1IyO8VRHv1ZiKzJNH
         ZvQExOt0TpzVq4Jkj4M1KfyoX5jI+uyocCv2C1afuQIqBARvfIu85X7FmqbikqmPSZTE
         AuIBqDMM6xfqLaKg20GEYWDhGVhkDfkFvqr19J5VDAH1rkcXpdB7Einds4Vwg2aPXrHp
         ivgzTJqyO+CTiDbeKmBp8rcONn7jV7QNODlyvTutrRmvaExJT6v5sB76lfRy+AjHRE7E
         gmSTtlt6xkLLyJyGuoRPd1pQmI7/PGRQ9R/UKJ0vS/bGrk6pjg1R9dlZBJPIiM8aVzYa
         KKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738569639; x=1739174439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEhIHxdD7NA+wb7AGZrBPq/eWZXsbGs0lajgHFDORFY=;
        b=v/nVZ8jgiZTcSQINwkpqgI+eTzd1fUrCYgBcmB9T8lyvfKQyP/KwAFFVkPEK/BW8F0
         hFtt/7Elk6VU8nnE4Q2icHiY2GkehGXIjUqMt8KSUrB/Ov9TrEKteS6ntlOFbFDqMSu4
         DQTHmtgvU4qILCBrPPQnTNb2GcPo+6yHsOt/4Hl2LbPf2jFI4hndRNnNI4ghy7McOV3V
         YHtmGklrF8a4+taDZ6WAN8a/Yd7/PyN4qBiNt2cRI3BN3Uap/mnL9N7rzFycfEs7zCsa
         rxloBfeqBbBkiq3diyJIlcnSqbBFfJD25fpBqOZfRIzQ4xPZD7hhROfuYrWcgmDQqUVE
         tDJA==
X-Forwarded-Encrypted: i=1; AJvYcCW1JHBbp+TdnnYt85aJwu1o9NkMMa+vb03VJ8Dwbyhk7kufBuHTBCuLgGkmGjbSFHTY25AOOvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP00DhPQp0XyksRhj12Ia442AhBy5Ee+hOxk6AxtTHzbs1Edng
	SmNghQaPm4cqHZlFAmbZc/AbREnzXyaM9OXOcEDf7afS1cRGDCoz5WqMWk2I3Vo=
X-Gm-Gg: ASbGncv+lI1ViqB4WZCDaBOj1KyYePYYIOVgkahh268gRglXudD4AYtyIVmrT8K20J7
	9wLKqI5FSOfsQUQ30OVwtt/iZTJeqXO4JOuBTVYvHrWtGUpene+EuGKL15ZZzxhcARUKRhXW20E
	nmJWHvm+GVUaTxcqORobfF7CE+Zxjd8wvr3URFGk/NBOGDJyr2C0bQ4YAmZCYFKswiiV6r63dS3
	JAiGgOek01KR7yaRqBebWbBw4vDooBnGTuxBFz6WpZdgYsdmIO1Nj0QGWmcy3OaaqmPcmIXVhQP
	HGKyEBxwt2VuJOgM
X-Google-Smtp-Source: AGHT+IFygNmOrpVihmSPJ5OWge6wX18dOo3mm00DI8j33PuGPe0wQOTVelVmoTclLlggQpQiNOjbbg==
X-Received: by 2002:a17:902:d4c3:b0:216:6ef9:621 with SMTP id d9443c01a7336-21dd7d96eb8mr319257395ad.31.1738569639585;
        Mon, 03 Feb 2025 00:00:39 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f71b9sm70236425ad.84.2025.02.03.00.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 00:00:39 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: jens.wiklander@linaro.org,
	arnd@arndb.de
Cc: op-tee@lists.trustedfirmware.org,
	jerome.forissier@linaro.org,
	dannenberg@ti.com,
	javier@javigon.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] tee: optee: Fix supplicant wait loop
Date: Mon,  3 Feb 2025 13:30:30 +0530
Message-ID: <20250203080030.384929-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OP-TEE supplicant is a user-space daemon and it's possible for it
being hung or crashed or killed in the middle of processing an OP-TEE
RPC call. It becomes more complicated when there is incorrect shutdown
ordering of the supplicant process vs the OP-TEE client application which
can eventually lead to system hang-up waiting for the closure of the
client application.

Allow the client process waiting in kernel for supplicant response to
be killed rather than indefinitetly waiting in an unkillable state. This
fixes issues observed during system reboot/shutdown when supplicant got
hung for some reason or gets crashed/killed which lead to client getting
hung in an unkillable state. It in turn lead to system being in hung up
state requiring hard power off/on to recover.

Fixes: 4fb0a5eb364d ("tee: add OP-TEE driver")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:
- Switch to killable wait instead as suggested by Arnd instead
  of supplicant timeout. It atleast allow the client to wait for
  supplicant in killable state which in turn allows system to reboot
  or shutdown gracefully.

 drivers/tee/optee/supp.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..3fbfa9751931 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -80,7 +80,6 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req;
-	bool interruptable;
 	u32 ret;
 
 	/*
@@ -111,36 +110,19 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	/*
 	 * Wait for supplicant to process and return result, once we've
 	 * returned from wait_for_completion(&req->c) successfully we have
-	 * exclusive access again.
+	 * exclusive access again. Allow the wait to be killable such that
+	 * the wait doesn't turn into an indefinite state if the supplicant
+	 * gets hung for some reason.
 	 */
-	while (wait_for_completion_interruptible(&req->c)) {
-		mutex_lock(&supp->mutex);
-		interruptable = !supp->ctx;
-		if (interruptable) {
-			/*
-			 * There's no supplicant available and since the
-			 * supp->mutex currently is held none can
-			 * become available until the mutex released
-			 * again.
-			 *
-			 * Interrupting an RPC to supplicant is only
-			 * allowed as a way of slightly improving the user
-			 * experience in case the supplicant hasn't been
-			 * started yet. During normal operation the supplicant
-			 * will serve all requests in a timely manner and
-			 * interrupting then wouldn't make sense.
-			 */
+	if (wait_for_completion_killable(&req->c)) {
+		if (!mutex_lock_killable(&supp->mutex))	{
 			if (req->in_queue) {
 				list_del(&req->link);
 				req->in_queue = false;
 			}
+			mutex_unlock(&supp->mutex);
 		}
-		mutex_unlock(&supp->mutex);
-
-		if (interruptable) {
-			req->ret = TEEC_ERROR_COMMUNICATION;
-			break;
-		}
+		req->ret = TEEC_ERROR_COMMUNICATION;
 	}
 
 	ret = req->ret;
-- 
2.43.0


