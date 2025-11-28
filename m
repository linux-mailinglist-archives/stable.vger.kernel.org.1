Return-Path: <stable+bounces-197587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81266C92059
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 13:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DC3934816C
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAA92FE59A;
	Fri, 28 Nov 2025 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPq0SR4f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1730F921
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334046; cv=none; b=KbxM6SM3YRX5kVjDHcohp4uGpZ92DUcyehWK6dTEcNVhJCZ/scfjV+VYLzEIRMKBeuS7WR1l01H1V6K/dDONPVsiAO3dCwKTD3GX4ZrSqGTIfEA09Tq1ywWJ0rsmPHQwY7YhIKZUOrtB5g5txjziSPMnO+oveT1uhKq0nZPJWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334046; c=relaxed/simple;
	bh=kzV9+demnOfcGL4XXbAez13alLimd8ksp0/UGXP6G3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keqhl+pSkfLLTL3iGJk6L99W1k4x55ZEyyGFnh3+B+zzxOBbx+WTE55nhd/QhY7aJ2cRLblqe6Lm7D3tmo/CXxob6MrE8CnA58f31/JxDfqQoYptpQMbiqijxb2E2b28PqcUpu4IswBNNC+nI2lZW/LX3Z1/wxgOoe/QSrEOle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPq0SR4f; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so2112291b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 04:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764334044; x=1764938844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=to/vAA7bFq5ou2zypDaoBxJgK9XuwGqaOChWbgZEfKc=;
        b=hPq0SR4flAB9joF8x7U0XGpCjGcV/5C+VeQ3pkEnprTbH4mcwTIxaGSubZuewQ4nDm
         xhCKxjgBJv6qcu2UA1thVHGK7yhnIy1eW4RwRoR/aDAu1rVjdHcI3EuIkaxagn5t+9xX
         Z4gv+vbE1DskSgV9cthcrsQgw+/TWr28MBw8HKPRnuSrInGjVnyLIC90rudthkV4nP5k
         MT1LekDXkUj/ErkcFbO4tItJnhut7VHBJtGWKsBZcz/BwRQ+FhnMXjgNEl2F6WkdTSJI
         S5sry03Iqwg8F27bW0mJDC8p95kOzRV7x403BmJqjYINT5WkN7L8Bhkda8NPHTeHWZGX
         4iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334044; x=1764938844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to/vAA7bFq5ou2zypDaoBxJgK9XuwGqaOChWbgZEfKc=;
        b=dKk1di4DKX8eCr7Jl3eoNjw2+fNvdWBXLuzD5ptSE9dcXB64nNUgxURbHKVhCtQclK
         tyIQ97PVy+gQv50xrRehT/lXh07GseS+At3SzuE1Hk2QoOG59a81eDVbSJiswpI48dyA
         tjUg/D1Gg339FyRQ5/3jjD7nSxbbLilcG/Eue7c/WIZvL7DRsOiov+IpaOyx07lBrPFn
         EhE54b9DAlAEJVwSjEMAmcH4q9fMkZnBLMLQL57WWy+BQ0TzdXQakQ+Ep8URNE/su6it
         N5+NMqZiPVKfIa9hGl9pxy+2KCizBQb72qDLjdKkUcN3r+tJ1006oIhGSye5iySodiwO
         4UzA==
X-Forwarded-Encrypted: i=1; AJvYcCXV+H37gB8sltEJuT/OXDBbh2t3jDknH9P6kx5eRiubYOROqXNFmnfvJQlgs9N312OZtPiToIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaJAJTqOjoO0OHGysApIyznbRdxKQKPzZKq0BVXZV1UspteyB
	g6sUWxdeIXx8Q4t9eGQtsOAwEFN2A2GI1sx9szbzPnTYbdUFzCrOmMlAzWr+oQ==
X-Gm-Gg: ASbGncu4UBDABpgMkzpCEW4r10DrflGcQ35LjBLYqDMazTBGigUjzWo52c5WjNpC4ln
	6ZPWySRbX0bv9C1WnUczoEyANOtfq+R2NYLDg1IFaRbVjLkT4L0LI8w5yYnrf8UK0eEGBGB+d68
	EFB/Y/NauQxd+DopOqbG5yRKbMwpwBlzn4vyONPWKroUKnGhGegX/uOWhU5518oYR1SpqiigUer
	uDI9H8eGCY66sWzRL6eXJ7iK9z0EwZPrUFsrhqX9axa4lbiRiV5U8ibabera4VM+hBsqszCZ9l+
	Cj+42DleHYuebzu/gzCjG2NBr3i/xf20Jt3EAJKJn0ITFKlCyu6oa3uIf63RTyhTtaw4QF/vyyC
	yB2pn0a8T60MqvVYbA3XSD7e9oshRVKYNmrzCsjHkDdymv6P2nwSj3CAb/TgpIdHKaB7QUVG6Ez
	3/OgonxC2UCUrm3xEGBmx7pFErQvOm+MnYD47feL4atfQ7rkh9C8pJnchtngH5N6yCejaX
X-Google-Smtp-Source: AGHT+IExavDrPYTAuFxviXdm3Se4ZMrsz/2FAilIbVsaAp7O+j6qMRHnuF8vULFtkbT7mW/nwVgERA==
X-Received: by 2002:a05:7022:2521:b0:11b:a892:80b4 with SMTP id a92af1059eb24-11c9d60dc74mr17778260c88.5.1764334043683;
        Fri, 28 Nov 2025 04:47:23 -0800 (PST)
Received: from 2045L.localdomain (7.sub-75-221-66.myvzw.com. [75.221.66.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5fcasm20956715c88.2.2025.11.28.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 04:47:23 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (max16065) Use local variable to avoid TOCTOU
Date: Fri, 28 Nov 2025 20:47:09 +0800
Message-ID: <20251128124709.3876-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In max16065_current_show, data->curr_sense is read twice: once for the
error check and again for the calculation. Since
i2c_smbus_read_byte_data returns negative error codes on failure, if the
data changes to an error code between the check and the use, ADC_TO_CURR
results in an incorrect calculation.

Read data->curr_sense into a local variable to ensure consistency. Note
that data->curr_gain is constant and safe to access directly.

This aligns max16065_current_show with max16065_input_show, which
already uses a local variable for the same reason.

Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
Fixes: f5bae2642e3d ("hwmon: Driver for MAX16065 System Manager and compatibles")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Based on the discussion in the link, I will submit a series of patches to
address TOCTOU issues in the hwmon subsystem by converting macros to
functions or adjusting locking where appropriate.
---
 drivers/hwmon/max16065.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 0ccb5eb596fc..4c9e7892a73c 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -216,12 +216,13 @@ static ssize_t max16065_current_show(struct device *dev,
 				     struct device_attribute *da, char *buf)
 {
 	struct max16065_data *data = max16065_update_device(dev);
+	int curr_sense = data->curr_sense;
 
-	if (unlikely(data->curr_sense < 0))
-		return data->curr_sense;
+	if (unlikely(curr_sense < 0))
+		return curr_sense;
 
 	return sysfs_emit(buf, "%d\n",
-			  ADC_TO_CURR(data->curr_sense, data->curr_gain));
+			  ADC_TO_CURR(curr_sense, data->curr_gain));
 }
 
 static ssize_t max16065_limit_store(struct device *dev,
-- 
2.43.0


