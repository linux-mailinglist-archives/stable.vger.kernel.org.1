Return-Path: <stable+bounces-100187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E69E98C6
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAC166EA1
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC5F1B0433;
	Mon,  9 Dec 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYYIatlH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDFA1B041F
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754488; cv=none; b=g158S1E4MJ9crwu2F4sydEYNKEFfd77RBgRcORgfEkvL+GN6nCWAqX0U3nBsvxNKaqlwAwKcb3DW/7GcZ2sDRvmjspoxBJaSOFtErQTXus3tj7vWqXLV26PmObSmq/t6853yV6Ea7ynOTZeF2GhM3DKvrEHjcnyUwU0z2BZzeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754488; c=relaxed/simple;
	bh=KjOrhvyvDHXkEiw3y+kYJ/bB1m80ZFzaaG16ro1MQAo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tJUtDjgE5Hf5i2NP4I0I+Hb7z+R4paggkRcUtMAPyCYgI59OXdyPNN2bXnlvKXHz6ykvjfIe2qnmha8edNBHDGSZalFSID0wMtip0/KxGtfpFEPet8dN/fAi8v6tZGcD3/WlXxyNGGRfGF3/ES7aKUSdSvtEOKMMVYe9J4rR5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HYYIatlH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68ef1so536708a12.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733754484; x=1734359284; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXliwLtoNdFR0QWSKIqXT1HHCcslPPaCpS8Xmnf7dbc=;
        b=HYYIatlHzMDxjbCyHoY25u7V5tJFcisI4UmIJ4XijgjYg8s/JnCWLH2lQemn2VNl5+
         GaujK66xLUjn78BY8dIUw52O0Loa61fCxZX0HsF6aZNNFIgxkZ7o04irgH1rH8B+MKux
         haix8bqBR0MF2sHJqK460tuy1UoFNWPJndXs0CdLQ0D7IUm7njqtVyBeUlKovsuknTdg
         uZzvMlzdriGhgHW5l8ok/AGvYJmMpctn+ax2sXUjZUaTZNkttaBZcI5lODTsdwPxgkrg
         7ad6/DUx862zAJ5pNrnptPSTEQ7LFgNQ6QIvxAqCEBXYJd82t+YWv6gtaf0D9s9Xd9Bb
         kt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754484; x=1734359284;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXliwLtoNdFR0QWSKIqXT1HHCcslPPaCpS8Xmnf7dbc=;
        b=luss1Y0vJoUoSSyz41KlukboVTC5r/QIaHfq0VNViYT6MMBSM/g0OSEUMn8Rllu8BZ
         lhuT0UP3PMc5re00YHIyb+7oeBTCaGwEFDNgwv+m2ozFx0qX+vrQxn7VLYYiFF8S+Vjt
         HtcwyJijAh/PzX49ZcqWFH7Zxgpz2Rr8HLYMJbzQDj8fqoxieD+xLBdsAqzNvVt8s4I1
         6JvnUpgfJ18gEPYvjxxtMW9/cCOrM0BaUjmq/VLnBYNQZB9L+WezVsGZCKrIa8l88Pvm
         Xx9z6faJktjC6qFb3+itu78m4iLfhBDvPSdOWoBPTzDGfiDvpsWXJAjNfZJ5D5MhPUGp
         fqJA==
X-Forwarded-Encrypted: i=1; AJvYcCUgQmzEQyB8VNyNyxr0TH42rHCu/pRjbM7xeq5CuHHAMJ+s9edVW3J/f9fig3UX95FrW/Zah7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVMJ5SJfDwzMz+VXskPI7WLYJN31J2831JDSSJKDchYH7WLR0
	fH4keE/hSbX5/B4emOe6LvE/4+26Klr+HR6wsM1kYk0yNrLodSQCsFIVbkj/NGI=
X-Gm-Gg: ASbGncs8xHMCGk8c6ELLXzIPy7NHObN6mrh/M4OiHk1a0Npz52Kb+Gs07sSVz9dvlG8
	0pduic//DS9gq1RWWS50nXS/2IZvfbmfTjfNjPJp8W+bYV7YfGuUoadAc9HqUtRg/9wCne7v3Ww
	45e3oeMJUqEJdCeXokA/SH6molbeuyp/rQh+hYVq1n0yRDc3X+fM211Vpxq+M2xAhclr1jcp5r4
	1W1ODtTRgx1tr1V4xGV8LEZoXQ3wXsqH/LCYtSTv9sT4FiOYcw4Lzpge7Pg99p2JA==
X-Google-Smtp-Source: AGHT+IFE562HPNpz44Q+78bBZyr0KEYVppcSJ6RnEgp+gl8LIUSf2FK+l/41E0kbUQ29TgqYUiBIsQ==
X-Received: by 2002:a05:6402:1ed2:b0:5d0:bb73:4947 with SMTP id 4fb4d7f45d1cf-5d3be4617d1mr4884890a12.0.1733754484476;
        Mon, 09 Dec 2024 06:28:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3eb109bc9sm2887141a12.42.2024.12.09.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:28:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/6] firmware: qcom: scm: Fixes for concurrency
Date: Mon, 09 Dec 2024 15:27:53 +0100
Message-Id: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-0-9061013c8d92@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGn+VmcC/52NQQ6CMBAAv0J6dk3bgAVP/sNwWKHAJtDCLiEaw
 t+tPMHjzGFmV+KZvKh7tiv2GwnFkMBeMtUMGHoP1CZWVtvcGFPB0sQJpJlgIhEKPbyQU4EFMLS
 A4wgSeYXYgTDOgLZoi0q7vCytStGZfUfvc/isEw8ka+TP+d/Mz/692gxocLq4Geu0dugeIwXke
 I3cq/o4ji9JVUPo7QAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KjOrhvyvDHXkEiw3y+kYJ/bB1m80ZFzaaG16ro1MQAo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVv5smD19zt5dM2ojBpD08xTuyWmqdQsntbXXP
 9ryGGpwQs2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1b+bAAKCRDBN2bmhouD
 10UUD/0a/GTniURmpouC9K66cRfc2YA+fDqhWcodpVsYWCtRsB+5r/TTqF8vZzPtKLTQRO1lpXk
 VKyMq+i2XejgBlgCgfkdQQpURwxm9Mhs4Gt3vD8iOkEHiyaEfAamXqwzGP6dhQVC33dtgl5aJPs
 ThnWpDYeDwYnNquBfsSv5apv1buYdQxr2HxLVYYN2zp/owNKLy1tK894SE7T0YWLcck0W+vx4uM
 5/LvzpJ0zR5kPvOggbMjiS/5Ay1wAWz8cRIJrzQqCAcHtjsHlZcuYuE9ivt/kA9yOBpyhFx9OcC
 Rv52QOrZsTZOwvNIqUbyVN9YpUYUsTaMAelhwZqzE/WvyQGSKhGyKwtX+ZzI5VQFpkbwX58nnpm
 zLVjfrugWZ5MWfFtbLSU2VzNamET2UMYCqFuGxF2bv2rX41yjaJ6VR8dPp3nYGdzntxP98OHpHh
 vdthgS42OzNRPhVfqoDGfUfOJn0htdKGEhflJpjijwa9+Ch5JtPSc6enUfJT0L/g3MLbtQeu/aI
 2iY5N4kFqTlk1Q7eKSXaM2Hvvsc5krDPyeklmiYOFG6WHCFyF9V2BRcxl7wsDpA5Pa4YAlmDaOz
 1zGRVtNTy3Tn+1PDlLlyShMhyWvfOuMwZe+akingqF8FNlodu7+OSbXhblfit01cCyWQXy8eCzt
 noMs46NlP/FUJqA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Patch #2: Extend commit msg
- Patch #4: Store NULL
- Add Rb tags
- Link to v1: https://lore.kernel.org/r/20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org

Description
===========
SCM driver looks messy in terms of handling concurrency of probe.  The
driver exports interface which is guarded by global '__scm' variable
but:
1. Lacks proper read barrier (commit adding write barriers mixed up
   READ_ONCE with a read barrier).
2. Lacks barriers or checks for '__scm' in multiple places.
3. Lacks probe error cleanup.

All the issues here are non-urgent, IOW, they were here for some time
(v6.10-rc1 and earlier).

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      firmware: qcom: scm: Fix missing read barrier in qcom_scm_is_available()
      firmware: qcom: scm: Fix missing read barrier in qcom_scm_get_tzmem_pool()
      firmware: qcom: scm: Handle various probe ordering for qcom_scm_assign_mem()
      firmware: qcom: scm: Cleanup global '__scm' on probe failures
      firmware: qcom: scm: smc: Handle missing SCM device
      firmware: qcom: scm: smc: Narrow 'mempool' variable scope

 drivers/firmware/qcom/qcom_scm-smc.c |  6 +++-
 drivers/firmware/qcom/qcom_scm.c     | 55 +++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 17 deletions(-)
---
base-commit: d1486dca38afd08ca279ae94eb3a397f10737824
change-id: 20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-a25d59074882

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


