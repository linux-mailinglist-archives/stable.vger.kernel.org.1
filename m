Return-Path: <stable+bounces-120430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE90A50014
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E03716CCEB
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF824EA85;
	Wed,  5 Mar 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYIFdZ+F"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36724E00D
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180165; cv=none; b=Uyjde49gE9HlkeSqQmaDXFMa9r/iGOaSsxE134+JiIRCHq8/8rB/rRRCjtatgBpHkCRa6Z6XcmUWtelTFvIS7XHBt3XRsKgcnJgN5UurS6JzNsvSPO8IslYXBkU1MkwmUIf/gabaXn7dZviFO3uIfna2dpZUSEh9T9vZS+9/b5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180165; c=relaxed/simple;
	bh=SuvVmJ4Sr+a7dK1Ic2JXgHQ9vplQfscMsmavcbKN2Tg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WGEn6yQ1IW9nTs5MK6fnWcAIPrLR4ZBQ1J6gM5BOu12qCNNj1nuVV+XkL1eElpAuAq/eKzsvdvGHZDw4EbkThR47TIudjjoQtPRlkBFqSrpjqJNb2mQvN7d5dJoa0GgOxrxm5cRCwO29JZWhvRA51cGZBh112z+pyM2JWta3Juc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYIFdZ+F; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso11119078a12.3
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 05:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180160; x=1741784960; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEX90oUW0TXTnfvsLPGvaD0pMBzwyn6s3WqQHJ4nyns=;
        b=mYIFdZ+FqZD9zRzlCi81lBQ3Y1LD6WWmwots4EUPODGbgAYuEgvCdK/OeE7GUjZDQR
         2yhgPMw8Bfn7PGXWdvwXeLBkBpG8EvmUIl+/sUw5GfVIuWs4h2VzkBI1UwyJKCi0hoi/
         Amg9nggcsuWNsB0zNWwGdX+Kq4QizOq+659brDy/A4lcMsoOYT3upP3Mw2RVn6N8aZ5s
         rfQTgf4jxPcybXlAZmrwqmyDvXk6rXx/jdRe6U47oB3wBeSeqNNmrgzIRqz5A6llkhTw
         Spl/ioJrXjYb5DxQGN/R+p+qwp1SfaSqvQemFm0A+HogiffbIIVlm9AD8NF8j+RyKnzO
         r6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180160; x=1741784960;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEX90oUW0TXTnfvsLPGvaD0pMBzwyn6s3WqQHJ4nyns=;
        b=QDSC97/4trG33n4v2NIsRqOjVMnUiiY4G8kDE8NsW3SlS8c9OPEjOLv/6xSFqTK5ly
         GX9HVu8AWT8shGxbKo+9F1m/VrmHolaq7nTJCOpyUjRemeF0Vj4DLUuSHTtTLwVkcod5
         9LIfR4ubFXwnDcX2AGEha0g0IQf77VlqHHvC04TQx64FwjEx/1RQEXGEcjMzBnOCzGS2
         2ZYQtD8KFBDimMMTXw/Fnmm8twa+UqhxFzw+zfuEVHw0YT46C1MPHvXmh+eeUuLPKXJU
         4mib9PbdL+eK9s33IibjENhxskFf65yDmKJ5KIAXorBnoPGNQHjVBHAoDm/lX6QZy9BH
         Mjxw==
X-Forwarded-Encrypted: i=1; AJvYcCWcLgtCTY658KXD0PWzMfTOt++5CHUwCf5mu+K6uUJi+lPYivBiUXTQjvQOBJaMM2ReCy3h8CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEYNcQ1soRqfZUSztTDBym2eJcgNWIhfqL4S4IiToSA0dTKw1X
	GL5262z02oMy5rEXRHrnvRPZiQXAMUc5UDQdXSKZImT1ONPeP1ULtuaP+yA3mUw=
X-Gm-Gg: ASbGncu8hDIrXP+Y/oc5fYDxGrxoLbz3MX5tHErFWzLk+HdQeO3GD7m+LqPnxLs4U0E
	nZ3jc4y0g6N2nozUZ0yjLionR/Ey9lxUsApiC5az0e/8ca4KJLjMAryShGVklvNNPg/10JYcwQE
	04OBVwl6sFHNwCJllQkYndci77Re6/EADir6z5IdyTcNj3uDa2b5QkZDDWac7chofNGHryt162U
	Ct1eQR+8ZAGfkQV+dFlqTM6zwiqV/KGzv/R3raujITZEsHMXMKipbexIxFCWJ4PTA62mGR81DAh
	6SlbbAsQ3nJmtRhcIrn4MSI+bm5VIKjrLU9LO6Ri7aA=
X-Google-Smtp-Source: AGHT+IE4rWTzsTxolX8cDUpaOUjiyqUJYJo5sUXRRhBSYUaZ/i3/G/CNpWjxTqUs7xmXYXkpR2yVpw==
X-Received: by 2002:a05:6402:40c3:b0:5dc:74fd:abf0 with SMTP id 4fb4d7f45d1cf-5e59f3c4179mr3367598a12.15.1741180160053;
        Wed, 05 Mar 2025 05:09:20 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa5dsm9627341a12.14.2025.03.05.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:09:19 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 0/3] leds: rgb: leds-qcom-lpg: PWM fixes
Date: Wed, 05 Mar 2025 15:09:03 +0200
Message-Id: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9MyGcC/5WNwQ6CMBAFf4X07JptKy168j+Mh1JWaAIUW4MYw
 r9buBhvepyXl5mZRQqOIjtlMws0uuh8n+Cwy5htTF8TuCoxEyhyFAKhpSrC3foO2qGGm5ugMxM
 Mzw58D42DQBFQaSp0IYw+liyZhkDpuFUu18SNiw8fXlt05Ov6n3/kwMFwxckqjWTyc+t6E/zeh
 5qtgVF+pBLlb1IJCEpolBZNqZX5ki7L8gYgw2MxLAEAAA==
X-Change-ID: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=SuvVmJ4Sr+a7dK1Ic2JXgHQ9vplQfscMsmavcbKN2Tg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnyEz2RKjNcPuwHvWMtD9dfjX5mCFVFRA0/6pPT
 jlNDAjN3jaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8hM9gAKCRAbX0TJAJUV
 VsGZEACu5byabqhkkSI6jU9QtHlwmy84dTvZMdeRqo0BCDXFdyO/ZqV1iOE9Tgx8jcvip5ATFNg
 h4gdWfQULDLRKiBsRofnPjeydLHB3JNd89B4zFgCoO5SNBI55Ro9LAytV1+sTDOLv5M6re5goaZ
 1OdaetMG89v62u/VBIE7d71wq5PiFlqE3LxGY+K4dWCcaM8VqCjzXfE4qkkTxj2GwqGj8K3c+5+
 T8DJa5aFaveQbYMGbq8sYvDP6VAIXBxHQW7KtxFldWbVyUnHB6IWvbkH0VnzjLZ5sDmbf1LpH9q
 4lyHlJzZQi+2g1fHSRxwyqza/mhRyqwrDykLOiFjrVlVJQYSW82gQFtjlRorsjq4FvtrHHm4Ebd
 eAVqPyW8ZJDPPHhSI/kAUzYKwUbdAWGZarYemJDCUuI5oHwaJD8T9Y2fvO0+UCyN5yMse+HUYcS
 87Egf6UqKoP9Q21yMc7Fkb27aBjMJR5Iaq7Ec4wLlZs0pesHxjhgQVaZKyCY+qOr+jUYn/j/uYk
 tVoqf6q01axzTL5+1zwMyucvcQYpyTHX/KB1Lm7qqdYZTnIE1e0OEfHTDczFnhY+CYO0Gc1F8En
 CBAG85BMxY5fdCtMLgHSQrapoJcgg4uLNvUCM73Ci/E6UE7abRZ3cvfWeTwzEY/qJMDXucktseE
 hNOqhPivf6sZPWg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The PWM allow configuring the PWM resolution from 8 bits PWM
values up to 15 bits values, for the Hi-Res PWMs, and then either
6-bit or 9-bit for the normal PWMs. The current implementation loops
through all possible resolutions (PWM sizes), for the PWM subtype, on top
of the already existing process of determining the prediv, exponent and
refclk.

The first and second issues are related to capping the computed PWM
value.

The third issue is that it uses the wrong maximum possible PWM
value for determining the best matched period.

Fix all of them.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v4:
- Rebased on next-20250305
- Re-worded the commit messages for the first two patches to include an
  example that should better explain what the issue that is being fixed
  is. As per Uwe's request.
- Link to v3: https://lore.kernel.org/r/20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org

Changes in v3:
- Added a new patch that fixes the normal PWMs, since they now support
  6-bit resolution as well. Added it as first patch.
- Re-worded the second patch. Included Bjorn's suggestion and R-b tag.
- Link to v2: https://lore.kernel.org/r/20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org

Changes in v2:
- Re-worded the commit to drop the details that are not important
  w.r.t. what the patch is fixing.
- Added another patch which fixes the resolution used for determining
  best matched period and PWM config.
- Link to v1: https://lore.kernel.org/r/20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org

---
Abel Vesa (3):
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for normal PWMs
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for Hi-Res PWMs
      leds: rgb: leds-qcom-lpg: Fix calculation of best period Hi-Res PWMs

 drivers/leds/rgb/leds-qcom-lpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
change-id: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


