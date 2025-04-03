Return-Path: <stable+bounces-127511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C655EA7A2D1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF597A3E9B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5624CED7;
	Thu,  3 Apr 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="ZkPi3PFk"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987492066DB;
	Thu,  3 Apr 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683171; cv=none; b=SyzoaOJOlMRwsrCYXmGZJsIJRbXQ+Uk2WOnZz9G8RtcO7hJp5DJl9M4zNSQXIo+09SWG1U7SgG+JHnXRX8nWvH9HIFboM+MR4/PTDI7Mv6n7j5sZRw1qDuUYsxTuYoI46X6TCxaioXQspsbBgQch7tDHEodDNCsiItvPQYKq9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683171; c=relaxed/simple;
	bh=iASQGzh0VvwZMf757gdapgNz7NYswb6FYL1Z0BWsk2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hsIWvwMopS5Ol73UBGyikMrBTPceF/TUqzORjP9WvLu1OlS/KMmtW8DpZ0/AstG/1dP10e2WkDHAFpL0FQVXauAudVF1r78J7U2M5uAl6ATuwF3RzQO6qus/YzNDXlVppj156RgFmvdRqHeTvJFAN0nopvLAHhcqd226NPHFEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=ZkPi3PFk; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1743683164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xVAG3hFiIEdM+Jd/To+sNmSTBWE7HCzx/1+ORr6F7iU=;
	b=ZkPi3PFksh4z3nmW9IMzbp3k/eOZ7OwEstmA+YVHx2L4TqNFllDzuiotO2vOKv1geLsZB8
	1xFbxAHHG9S7G/6xgZ68f5nqmuxooCoW+rWa51LoNQgEYrac1rMInoLj18myCjA8T+k0+E
	3GUq/BxO9IRaELk8FLlUUiyJUpQ6Uqw=
To: Corentin Chary <corentin.chary@gmail.com>
Cc: "Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] asus-laptop: Fix an uninitialized variable
Date: Thu,  3 Apr 2025 15:26:01 +0300
Message-ID: <20250403122603.18172-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The value returned by acpi_evaluate_integer() is not checked,
but the result is not always successful, so it is necessary to
add a check of the returned value.

If the result remains negative during three iterations of the loop,
then the uninitialized variable 'val' will be used in the clamp_val()
macro, so it must be initialized with the current value of the 'curr'
variable.

In this case, the algorithm should be less noisy.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b23910c2194e ("asus-laptop: Pegatron Lucid accelerometer")
Cc: stable@vger.kernel.org 
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
V1 -> V2: 
Added check of the return value it as Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> suggested.
Changed initialization of 'val' variable it as Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> suggested.

 drivers/platform/x86/asus-laptop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index d460dd194f19..ff674c6d0bbb 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -427,10 +427,12 @@ static int asus_pega_lucid_set(struct asus_laptop *asus, int unit, bool enable)
 static int pega_acc_axis(struct asus_laptop *asus, int curr, char *method)
 {
 	int i, delta;
-	unsigned long long val;
+	acpi_status status;
+	unsigned long long val = (unsigned long long)curr;
 	for (i = 0; i < PEGA_ACC_RETRIES; i++) {
-		acpi_evaluate_integer(asus->handle, method, NULL, &val);
-
+		status = acpi_evaluate_integer(asus->handle, method, NULL, &val);
+		if (ACPI_FAILURE(status))
+			continue;
 		/* The output is noisy.  From reading the ASL
 		 * dissassembly, timeout errors are returned with 1's
 		 * in the high word, and the lack of locking around
-- 
2.43.0


