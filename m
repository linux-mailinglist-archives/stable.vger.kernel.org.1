Return-Path: <stable+bounces-94055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2BE9D2E82
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 20:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DD1B376E0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64E1D9329;
	Tue, 19 Nov 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTKmyAN7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D01D0147
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041220; cv=none; b=Az5nlEUfNJysUgTzI3eeLVi6N788D2gF5cZ59q6Bc4Nfzy2JeSCuoVt3oASnGQPxh/9nuG20FaXvFwAgjNbRSJGfXeelr+yGW8KiFnJ8evcE+yRCFeM8x2ZfjIytJT3zJwJI9rRcTqos4aeaD1thMhCWmEqEeSCvMkv+tL2Pv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041220; c=relaxed/simple;
	bh=QxQemEHGZ9KofZh2dhxrC4puyYzWDwPDCmQkhwIKnEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FktmynyvnPznQ4qB5WpRlG2kBkuajJJQIM/C7KOSBWVstLGbFRs21rGt5FnT1a5e9+2Y+6pzNt1oKe08tagtafpMq/Lo0hlK05WRXKgV40dvZD8PH8sq75o0W2fMhVPUnWx4mDPvRUMa6QIeI6vfprlHuBVHfkLk3zZLa6QzV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zTKmyAN7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso5617195e9.1
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 10:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732041215; x=1732646015; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uxBlhEzCEm273gWZ0Z1r3LrMeos0nChCkSfjPfMnzE=;
        b=zTKmyAN7fypxvTk5uaz+rlVPv9RlilhlA8fhCi0TmaWzEJT/vde2OxU+vE9n389iMN
         egDwjvoWQEH4uUS/2EJ9+s7u9REAEYXp18ecjypAnBHutfsJjLBJr1gWaxgrhuYg7jRP
         MOmD5meE9KIoMFT97/mQLkpesGp+Hglav/GAyPAtn8Pt4dfmplei2txFoAXEfYFpzhwO
         N77KBrM7SgoFeqaotJYAsPiJqK3E7phPss5fonVYamNaiPjz8vfHUBMKNXIEmTyf3vQ3
         iJqrB6BqA5cYubiRhD9SBqyifIso2GxEXkvKB/KaaFru77RHdUGgYXiJF8Xp+FlkDC3y
         v5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041215; x=1732646015;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uxBlhEzCEm273gWZ0Z1r3LrMeos0nChCkSfjPfMnzE=;
        b=tMT//J12VccHK4N4+4+SU1lTrb3F8A3UUSmKC8XT5D690Mr379bRjmka8z9fwx6YNH
         V8NQt4DKogccEuWIMGzA5cU3vwykzStNnkhyX68XHEZzABsovzmkjO93wftUBKfXcn04
         qVv1jqn5WlwFyFdaaUAv74rOvbf8kTMSIIj4wy0R1mbsZtrjFSEwgGYkmv4MT+BgFDi6
         5f1Q73Ov7up/spSllAszlrtCG4U1ZpSCDxH7pn5Oh1aHlAEmytniBkkREjwBNhCiESu+
         kONg5vt21NpwM/+Bh9LLgmsokrhsOaEh5/NN5FKZtq+S3fCSOnyTJR0aCN4Dawvi/29Z
         iodA==
X-Forwarded-Encrypted: i=1; AJvYcCVfLdFrbm6ge3aRZ9rXRXGR7SZp1b8kLVoleUNuDc0qwbiHhOHv2vXVtQSApuT2/HwFyzmBauE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnI6RcFO/bN2Wj3NMz0b5OaNa5dg0PaAqTXq5QIIBxE5yA7Xs
	gr/u8k+EQ88pxKPRpa9ePIAgeVKhnwprfOk83BdBJSjxKeSuwRxDLGyrsKCZaH0=
X-Gm-Gg: ASbGncvQ3fh8y92Qzf3RNPSJdG0pOyYvrElmiOhJ40fT9HPcPIlfS/qG6NKBl8GD7aD
	5+LRu0CBSlYMRxFXUvhFQ7igbva02MDKhvDGmIK//12ULVuuNeyy5QrmL8OXu75G3sw9uLmujkW
	JxGitM5P09bu29gxH7uEALI46uvzXPtKAX6K7e/v+Wz9+TUTqhfRxfccU9H4gxChSXzqGpeoqBM
	ZMYsBN34Rhr/kbOG6Yn2xC2FgWbAhDXN0K8oKBkQbRtr84qsvj/HzYGeT2Bob2x4Q==
X-Google-Smtp-Source: AGHT+IEv8u9mS7b3Hjaj8uwdJ2FGRBK///EN6j4F7a0RsdLD3QQC7qNAwSSPJAVtSHksF/xeUp+riw==
X-Received: by 2002:a05:600c:354b:b0:42c:aeee:80b with SMTP id 5b1f17b1804b1-432df797e02mr64687705e9.8.1732041215219;
        Tue, 19 Nov 2024 10:33:35 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fb7asm201566805e9.42.2024.11.19.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:33:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/6] firmware: qcom: scm: Fixes for concurrency
Date: Tue, 19 Nov 2024 19:33:16 +0100
Message-Id: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzZPGcC/x3NQQqDMBBG4avIrPuDCUq1VyldTE20AyaxM1IK4
 t0bunyb7x1kUSUa3ZqDNH7EpOQa7tLQ9OK8REioTb71nXNuxHsqCTYlJDGTvODJWgU1cA7gdYU
 V3VFmmPIG9n3ox/baDYOnim4aZ/n+h/fHef4AcxNUboAAAAA=
X-Change-ID: 20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-a25d59074882
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Kuldeep Singh <quic_kuldsing@quicinc.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, 
 Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=QxQemEHGZ9KofZh2dhxrC4puyYzWDwPDCmQkhwIKnEE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnPNn01sfaeiAILH62481Qc8WKb9yZRN57MIG3r
 9L9KJ+HMaCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZzzZ9AAKCRDBN2bmhouD
 1xpLD/9ct2p3xGbW1rNsPWJVNjot6Qj9SnzyG8S64Q/hbmzt7tFJAWPDyJE3xctWD3W+8CnRS2X
 AWMlCoelvil+5Pg6wy8lPfewFyrt6MwaGI/Ukjd5kZFNUxPzuH9o9WVOFV4cs9TOj7YAGvhUpnz
 E0hMQg7Ms3D6Cmp6ASD2VzPnZOTLfi0Zy/7pLwYkn8c8xOV9kKidw7Kx6VmQEjfvM5L907VIA3x
 aqYbEZ06elWAekwEFwAn+txMpn7Hxr4kD26g0w61FFnfj1B5ewGVPbx/r+nc29pycXivLfjSzg3
 +i07q0GC1MoeHuXxpEIo5jg/jH09ehbNWwjBPK0Nmk8WzkZZBIrM+3EQeUanpyqct+oTyT9XZF9
 0OHA2F6leAAzfb0jKD0y9Pcrg41M0MapiTd/Iv5EL2hM6gqHwXutNPT34xUBer+T8D8sPXgitpx
 yjs+ijos8oUW9Ifo7W7pmIrqYfcjt+e+UzBf3xZU4RXsD3H7P57zwB5uxtYSHongbnGDJK/lX88
 rEwdpnOB50tdHe09FzlPVpGotWw5eIWv1YncfKORspQs9z638n5YvmSe/ffwQ9cP35JQ00v8j+Y
 +z5eh4be6er6mDaEr0vMF6Qm/GlwnCfKqrCgRwNTNG4V9PrwXgUiB10RZr1vq6FVNAPg6picO3C
 bNKWKvA7+WsD+fw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

SCM driver looks messy in terms of handling concurrency of probe.  The
driver exports interface which is guarded by global '__scm' variable
but:
1. Lacks proper read barrier (commit adding write barriers mixed up
   READ_ONCE with a read barrier).
2. Lacks barriers or checks for '__scm' in multiple places.
3. Lacks probe error cleanup.

I fixed here few visible things, but this was not tested extensively.  I
tried only SM8450.

ARM32 and SC8280xp/X1E platforms would be useful for testing as well.

All the issues here are non-urgent, IOW, they were here for some time
(v6.10-rc1 and earlier).

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      firmware: qcom: scm: Fix missing read barrier in qcom_scm_is_available()
      firmware: qcom: scm: Fix missing read barrier in qcom_scm_get_tzmem_pool()
      firmware: qcom: scm: Handle various probe ordering for qcom_scm_assign_mem()
      [RFC/RFT] firmware: qcom: scm: Cleanup global '__scm' on probe failures
      firmware: qcom: scm: smc: Handle missing SCM device
      firmware: qcom: scm: smc: Narrow 'mempool' variable scope

 drivers/firmware/qcom/qcom_scm-smc.c |  6 +++-
 drivers/firmware/qcom/qcom_scm.c     | 55 +++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 17 deletions(-)
---
base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
change-id: 20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-a25d59074882

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


