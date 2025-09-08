Return-Path: <stable+bounces-178824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D776EB481D9
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB0F7AE72F
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B71F4C89;
	Mon,  8 Sep 2025 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiUF0g7N"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2781E47A8;
	Mon,  8 Sep 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293787; cv=none; b=KUwUMtLNXLuleFX+3zFq7dIpO5OItf/rZOWw8S7qLc8aB58RWaFalOgLeoyLuElygNEBfoioRXfbt1QQ7GyDaxglIL0owqa4YJgBSQHf/kt6NIDgFGvISw1PdnSioo/D3I953uLGFue61W2V4+eiOmKGBQXMhZm8AajKKQ8Q1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293787; c=relaxed/simple;
	bh=2c/B+jVJU+eMT1REUyPuXAvy9saBACnvLnSQGlmXcaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lH6QgqtgqxhYbYO+GQsCzEQY3ilqKwLBdajrBTsJXAba92jtKj78k30Xk/n/xwm3auIVH6osEBJ9DU0SG1ZInL3aC+te58oyU3JAGVK9tbYik98KTT3H33uN5eF6xFyjML5/TLeiILCtLU/lT3BqGzWO4AA4JfWOF5WVARL6ZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiUF0g7N; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-544a1485979so1392366e0c.3;
        Sun, 07 Sep 2025 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757293785; x=1757898585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dGtV+MjNh+y4+MbTmaKA4kHO3anKPg6NBgz3rdrNSY=;
        b=aiUF0g7NfdEiZyYtiJTsxfiS8qgTIIQEWsJr5XxyPtDN8cKPmFH2KMthPeeXWAJKzJ
         oynqPzFwreTdo+VCMioLlJbck8iJrgHyymrng58F7+OqTj3Yc0ILimAztY448b7HuLpY
         AaL2/RZhTCHjTM5qoOca5A2ly9J32dlmQYel9F9LRHHghN/w/n8COmbMS+AyGkIlreVj
         lRjWu2A3caQ+W/WX4vkeK70Y/AUmt/VVSJQn2wWhctcHujo/hhI6xck7htakDa2HF0h3
         YaRPm67Psz63okwJpPWhw/Bret3ADc8X996vzvTY8VDNoEourtca2VqZLFbJs2Wa+iwv
         y/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293785; x=1757898585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dGtV+MjNh+y4+MbTmaKA4kHO3anKPg6NBgz3rdrNSY=;
        b=SewBphhqZx/hlckXC+va1QJtY+EFPYAlze6vVF8wbi0Z/SgTKv3e52V/VzlqlhRBVt
         aKSlunl0gsTpNv5cV8l+Z7qrBhExNX09dJS8tUZiF/APSUAXrGhhFUZrl7ONtRocyZeW
         HiESjV78JhoMKB/p4n8c+vRglu651Osn/zPLw07bXu6tFyq9jf6bpcV1aCTsuYLUFxLh
         YZPN+aR8bXNQ02lTfNkEgny5dMGnxheMdd3cqr+qJRY72+FijS8pdak+6lDDzwu2YV0i
         DpxalZgK8xzVF5iiWY05fPO/nIXjr5YoLwK9Jq0bl6XRN4kx1C21mexde31ARxtGTnCJ
         VvFA==
X-Forwarded-Encrypted: i=1; AJvYcCV7yy+rKwzpV4uGDZ1AZYGoUHHSp6BULJDzmoLGgPzEzc2cJMNJq+EymMIkpallHRLsVzDuQvtdw7b3eZU=@vger.kernel.org, AJvYcCWPDtMisf+vBlfX07GW4AAWf3zbUJ6xvloD9yGCMvID1YIaRs1b/AxnzrRnWfPa9AXP9Xl1ZPHq6fxH@vger.kernel.org, AJvYcCXbqG6U6nomVHnBx2ANxfDws0yD49GX3pxHqBv4rt9rdzVr6SPfy1X6CeagUH7uswjBOJ8hu/E6SLGc69WS@vger.kernel.org, AJvYcCXvOhRt+S6uyAa2ON7fMvtz9o0MZmZlAoVBGWrKobEsX5tYhNTL0K5Nuz5JUxEhJ8fl9igiLxgn/quH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74z7wWM2YXKg8V8CBTJVgKnbtvqf62kjQJRqb5ny/5HFneSTF
	S+u1NW2JOeP+S8GEB+2Tzu682kQ9kBEH7BTkOtb2vxtmimilwIA+CDTx
X-Gm-Gg: ASbGncsAtzhSar8kK0XhRrYkUg2qjHsjYZ/M4fBOnAEVvsMt9TyKbvS34JaVWw3CdSN
	3KXgen+fVYHlLYFWhylR/Juu589xbel8yGwtvOLELoPwnMxvth38+1suDmu7LfrAqzCm34wN/Wx
	J4bw3obpiNVeCbEfs5YvU04Olgn3Jfm5HOOIt/Bl2DbGmLrDz28t3tuorz+eUU9hu33jrHJO0z9
	015bNn6hN6im/bc5iKZjaRbYlyVtP3XdxANGNIsjttHCBWaaG62hJEGiwFu9SUVJZBhqdb0rTCE
	tS4uLpS+4eCUEPMMPikGoZgPnDHepJ3DeQBddfirMJtps0T0Pw9OKlc5w/dyXnz9Q0dRtnEjNJF
	4/H38cVzozfNiaXtTzS1vw9FTFZYT6UGsO/A=
X-Google-Smtp-Source: AGHT+IFxMOgapuvhqt+CZj46bK/SH4AqTmugsOy8gdKwQjWvZ3bLFKDNCuj+T5V6aj6SBebN+8/9Rw==
X-Received: by 2002:a05:6122:2086:b0:538:d227:a364 with SMTP id 71dfb90a1353d-5473a3ae001mr1238269e0c.3.1757293784992;
        Sun, 07 Sep 2025 18:09:44 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544b1933316sm9152572e0c.9.2025.09.07.18.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:09:44 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 20:09:13 -0500
Subject: [PATCH v2 4/4] dt-bindings: trivial-devices: Add sht2x sensors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v2-4-1c7dc90abf8e@gmail.com>
References: <20250907-sht2x-v2-0-1c7dc90abf8e@gmail.com>
In-Reply-To: <20250907-sht2x-v2-0-1c7dc90abf8e@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=2c/B+jVJU+eMT1REUyPuXAvy9saBACnvLnSQGlmXcaM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7dC6wy0w4tf8oW+m8pTKWbULtt5mfrlrvzuTD8H83c
 +GTnl0CHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCRg6sZGf6Exwecn93pvXJe
 r2WCitrF8+//GWfmKr6UvH2mfsf3u80M/wNCNvxacnB//M0CwbTvhf/uL99X+Gr+9+MZMr0mPq1
 905gA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add sensirion,sht2x trivial sensors.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6f81255141bdda6daf8e45369a2c2..952244a7105591a0095b1ae57da7cb7345bdfc61 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -362,6 +362,9 @@ properties:
             # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
             # Sensirion temperature & humidity sensor with I2C interface
+          - sensirion,sht20
+          - sensirion,sht21
+          - sensirion,sht25
           - sensirion,sht4x
             # Sensortek 3 axis accelerometer
           - sensortek,stk8312

-- 
2.51.0


