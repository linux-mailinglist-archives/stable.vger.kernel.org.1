Return-Path: <stable+bounces-187857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CFBED43E
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F924002FC
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270B8253F12;
	Sat, 18 Oct 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8LAu1j3"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055922D785
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806703; cv=none; b=ljUTq8YZVyO8uckyyDs7E6REClH44VQL9HY6NcXt7uLsXSc2bCvC4nWNLeqyrl8T24DQ/ySODasQSH3oJ2OvqKFrN8amnVu7psWdaXc1EDAesJfa/dTm+d/A/dX0Dt/5Mb0ZwEhkkGVWIVHBMgPnOAweKuLEFXpGos1Y+ApC+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806703; c=relaxed/simple;
	bh=XmnewOa5kOv9A8PiFNHvc/4WhDeZEr902sYESOj6+cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLfJTA2/3FFgvsaWaDNWv51shoXd9NIodU0HOr9CWPzJPIOp++uZXAmauXia7grJrq3XMWM+TiVZcLLWmONp+C2xAtlMSvHrOQwMHtPeN0ziGKaZqAG48sgMrABs4DlZv+fwjzEEz6nO8uyK/NvjGywFKST23OQr2TH4SS/Pdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8LAu1j3; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-9298eba27c2so190441439f.3
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760806701; x=1761411501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L7fSCgt2SjB2mGlHB+H5VapQzGA1nEVjQynnqFcyw14=;
        b=D8LAu1j3tiqVbpcb9OEiekLRd6OkGeNofL+MfBEncgQLAfKWWWAgJQPyR0Euma5xfL
         WSoIDgEDi6TRbO0gvYyaQpFSYUyOC8oIRhOHiI0i4iboRPy/ipzt4iZf8LWOC5lyhv3r
         AOgNLrKSTBEM+0qB6POLNgOsdLNGVQx9sPpSSp5dxfyKXcrojVq6pmp5Og0SkoTS33BB
         Jq9SHZLyE4hNgIHBfbaB+c6rSdIt2iKePLMG7P/2oXXnAMpWKQYfITV5uTwcBGMKPiSN
         QcXL5nX8czh9NCpQyr9UI9qE4j9NN+8+Gdto5QYbiXbTJkvvf3ury/IsRqj6amEZINyo
         Mo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760806701; x=1761411501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7fSCgt2SjB2mGlHB+H5VapQzGA1nEVjQynnqFcyw14=;
        b=OU0ZCyuyVZtclWFqYkqHvtEDOOqcszuuPuvOLSef1jbn/KfDBcNMr1J0k0cnZdUgAt
         ckMs5UnMVW9/Bb2HjXswfS+RSMGhmUzgOzhLQjWeAN1WxJ37HEK/3sr3ky6fNSZdWm1B
         MoxZpdKi/aTV4TbXt+VSPcati1aiXs7W1o9fyzveflh0nmTZ3+efl8vASPSIqG8LMM4d
         c4oHwENIR8nWbRlkw5nmVkpqxKn+ZfWtLZUusvmFLZmnlykNvDbt6BraWyg32ONsZor+
         kFDcQA29fVezYZV2urfNiP6LBTjyoTZswmTD2NA5ftRQv5Xzghr2xfoM5P6NXcr/pv+H
         Gd+g==
X-Gm-Message-State: AOJu0YyhiKoY3FbAMlNVBcFwmVWqdiYKiK5JM+95jywly8ga7R4qX8wa
	lvcr3e8QFwHXc/7kst80vtSp3IHobHZ9909BV8b/2J79+7ebn6hccivkHNEkRtQsKdI=
X-Gm-Gg: ASbGncvPNgpSfSS6DrwALzamaMvNJE5hulpKXT3bcHyWZfh6HTm+eFrH7Qm07jSs2uw
	F2ctzMO7sQG4rPUx+ECXRN9dknKBBgp/xN0bUZy+QBW64fQc3Pqp1ppuBqRtYNqnlLNaoTDwnMJ
	7+WJZwznMs2u2KLPpyaAJcVP5cAToxLhfsC1I2WbfqFCssBQAAjCbKxqYe5r/XFAjWuXKBUAau5
	zerVtkStKtNVYWH9z9pe4/93qMtCjZ7DZRqnkA/Gf/P18P2Ejhpf4Y+Lh3Tf9GCXHbuXWZCvOGw
	kRfJEH0N0TQd9lOmzrvJuKXy0gyZeV8OCnBb90czvUQiX7HXW3yRcgtQT/N+2GaXQfEpr8HCMVy
	Y+0WjFYX725BG8SrFTh2JCWq9iKvZTx8AC5XToAHYWAT2ajVoNUOjsOIxAUrDX3zAct0kJcmt38
	fiNs/9nuk9GKvOTYCadB8xpS30ie9Pg3XaKs9py9LLSk7BhYsJ
X-Google-Smtp-Source: AGHT+IH1fopTouG5+V7fvyEClHqaGvkgn74QyqIeIeghW5gwvAbGx180ka2Rvu91VrM6a5ll9HGPAA==
X-Received: by 2002:a05:6e02:190d:b0:42d:84b3:ac43 with SMTP id e9e14a558f8ab-430c5241c9amr122700125ab.2.1760806701346;
        Sat, 18 Oct 2025 09:58:21 -0700 (PDT)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b4614sm11927545ab.33.2025.10.18.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 09:58:20 -0700 (PDT)
From: Adrian Yip <adrian.ytw@gmail.com>
To: stable@vger.kernel.org
Cc: Adrian Yip <adrian.ytw@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH 0/4] drm/amd: Check whether secure display TA loaded successfully
Date: Sat, 18 Oct 2025 11:56:40 -0500
Message-ID: <20251018165653.1939869-1-adrian.ytw@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is a patch series of backports from a upstream commit:

    c760bcda8357 ("drm/amd: Check whether secure display TA loaded successfully")

to the following stable kernel trees:
  * 6.17.y
  * 6.12.y
  * 6.6.y
  * 6.1.y

Each patch applied without conflicts. 

Compiling tests will be done for patches as I send them in.
I have not tested backports personally, but Shuah khan has Kindly offered
  to test them.

This is my first patch, please do let me know if there are any corrections
  or criticisms, I will take them to heart.

Thank you so much Shuah for providing this opportunity! I'm very grateful for it!


Respectfully,
Adrian Yip


Mario Limonciello (1):
  drm/amd: Check whether secure display TA loaded successfully

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0


