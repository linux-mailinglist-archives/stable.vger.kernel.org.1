Return-Path: <stable+bounces-112117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C389A26C97
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 08:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0C33A82AD
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 07:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF04205505;
	Tue,  4 Feb 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JT1oddcW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69C204088
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654471; cv=none; b=awX5DifjU396CdMWXWRPdxCsyJao5cQkyxDt8ONVi+JJjoQfN97mXSPBNQelPvU/oGPBwSfgG2QBIxxoESeswCvwxqc1ntDom5HY+RLgrL29PJVGRdGd30ndl0RdIAXa/aucgGJZWmT37MqMpKzhPjJ/JZFPoxsc4Uq99lpFA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654471; c=relaxed/simple;
	bh=cl8ZT91z9S2tpe4krwwQNNz+rzfjEqha0MrzcdBk87M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kP14onf/yyYB5Rh0Yoirnp8fBQ82cQBMYr8cCnzVuEP6sd5MzZGfIH7m9/+BUxsFZqiQ844mCniUdkW1SxpOa0tPOdFCY81qcwOO/oQrnM0ubLr84sz/TCPJkIgQAHBz25UfkKpsRQY38dW7MHqt9AskQ+eatHA/LCKHBfXxyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JT1oddcW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166360285dso87418305ad.1
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 23:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738654469; x=1739259269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orjpaukFM37/+hASeec/fvQ2v80Tt5itf/oXBVJGIZU=;
        b=JT1oddcWtX9Q3VRMGwZeyB/J+HlEw11PmRsXDJuOx+4f5gO3My+heq835jfdsRBcKA
         TlDLWSyrQXLM6qkt8FXJ1ozIZZZSRwhqZAUKEb2WJFYuDEKmXCq9L8eQ3miqv6kom/55
         te0DtbIXGS4gEYRbFsi1rVogFmAKOSNHhnlueJGzobbZl6tqPRMdb0tTVd2mOoAYfGAJ
         zQu5smnMpPBaROFbcnQFpYxnwTHEkUv7zrASfa/uBhUYYD6LXgg1i2/qpdNjDgtPIeVa
         Uz5o7EM9jsNOHQFKSE0YyLFp349pIc8WHuEFUMgHZmqqnlksYOqHRY7i/rgsEUQoNN/k
         I4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654469; x=1739259269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orjpaukFM37/+hASeec/fvQ2v80Tt5itf/oXBVJGIZU=;
        b=jxyySHaTw/yXGo9ijkNb5KBDNTtpQ5tMF5/+KKxEt3HLGrdPxPB+kD+NsvnSYc+Z6s
         UkyVX7hAoJd5FaZ9aH+DARGRZxt49b4NT8Ua5/ctrikxasDhoCO5Tsq19oFkeob/8j1c
         PgVX8C60FHy5yMB5fuwwzPvbhBJWdNC9n3anE19PVTczPA0FXzgrZewm1JytokCZxOm/
         pzPfp+xnIFAHg8AoVd6QYrnuJynFoX3MzlHqnKKQ7p5S8Z02ByWb6E/I87z1PCU2ZZjC
         IPR+LfsRxhOT0aU3u3/bSSwFS9ST04D+OHumJSIyXNx9RWa7VOk3Ltlg9DdRHeyvdzWn
         UTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd2m3E29FSz0uICBTMHxQRWY0hruCrYHwTNG+Kh5mFNlf9o22qmbV3PqFrHsFzICT3WSQYW4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzflQuANSxUuOIs9eFmdrhQNH/3/Ex/CDSazkStCBjqmaY1rMMU
	XU0dKhuSJfczE9sdteUA6Hd2b0KVgB5fYgjbzwFnNwXAwMbP0ynLo2Un8YVazs8=
X-Gm-Gg: ASbGnctIvP96q+o8QkdK45DfvwFPW+xVy8zGd1buVaKQxwM9Wd1CgtIsVZIkb9C+wVt
	WEPavSyShiVN7w+V02WjH2si4XfHKs+KYh1sI1x7AOkn8KkjzcH7i8d6dLDiduPwwdD/V4oJ5Pi
	E3e0yLaj5DmdPXpmwGxKF6AMAbDxi4kt69etpTYl/mj3pmQBk8YzyTYAdYoEft2ijMKU2a9rJCd
	F7pbr5SXzQeXuue24ui9meUUA+n3dCBiwKB6tUl4uOQW4Fh4fYBrT5c/e/1OXfKtIT7VD9bk26h
	ZYl58YMvS1ky3OcF
X-Google-Smtp-Source: AGHT+IH7iRztA6y9IjznIKh/2zF04c+yLjm/3BTLuBiqf/u/s9hr0MUSVaQHHQhZkJm6tpZj+s6tVw==
X-Received: by 2002:a17:902:d4cb:b0:215:a434:b6ad with SMTP id d9443c01a7336-21dd7ddde1bmr392541465ad.33.1738654468133;
        Mon, 03 Feb 2025 23:34:28 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32eb97csm88569225ad.123.2025.02.03.23.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 23:34:27 -0800 (PST)
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
Subject: [PATCH v3] tee: optee: Fix supplicant wait loop
Date: Tue,  4 Feb 2025 13:04:18 +0530
Message-ID: <20250204073418.491016-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OP-TEE supplicant is a user-space daemon and it's possible for it
be hung or crashed or killed in the middle of processing an OP-TEE
RPC call. It becomes more complicated when there is incorrect shutdown
ordering of the supplicant process vs the OP-TEE client application which
can eventually lead to system hang-up waiting for the closure of the
client application.

Allow the client process waiting in kernel for supplicant response to
be killed rather than indefinitely waiting in an unkillable state. Also,
a normal uninterruptible wait should not have resulted in the hung-task
watchdog getting triggered, but the endless loop would.

This fixes issues observed during system reboot/shutdown when supplicant
got hung for some reason or gets crashed/killed which lead to client
getting hung in an unkillable state. It in turn lead to system being in
hung up state requiring hard power off/on to recover.

Fixes: 4fb0a5eb364d ("tee: add OP-TEE driver")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
- Use mutex_lock() instead of mutex_lock_killable().
- Update commit message to incorporate Arnd's feedback.

Changes in v2:
- Switch to killable wait instead as suggested by Arnd instead
  of supplicant timeout. It atleast allow the client to wait for
  supplicant in killable state which in turn allows system to reboot
  or shutdown gracefully.

 drivers/tee/optee/supp.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..d0f397c90242 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -80,7 +80,6 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req;
-	bool interruptable;
 	u32 ret;
 
 	/*
@@ -111,36 +110,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	/*
 	 * Wait for supplicant to process and return result, once we've
 	 * returned from wait_for_completion(&req->c) successfully we have
-	 * exclusive access again.
+	 * exclusive access again. Allow the wait to be killable such that
+	 * the wait doesn't turn into an indefinite state if the supplicant
+	 * gets hung for some reason.
 	 */
-	while (wait_for_completion_interruptible(&req->c)) {
+	if (wait_for_completion_killable(&req->c)) {
 		mutex_lock(&supp->mutex);
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
-			if (req->in_queue) {
-				list_del(&req->link);
-				req->in_queue = false;
-			}
+		if (req->in_queue) {
+			list_del(&req->link);
+			req->in_queue = false;
 		}
 		mutex_unlock(&supp->mutex);
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


