Return-Path: <stable+bounces-65303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A8946408
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 21:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735521F22D4D
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498A50269;
	Fri,  2 Aug 2024 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsNy42Eq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B181ABEC9
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628060; cv=none; b=OsZorwZBIC1EMnmz0L/zTT8dx8f4mGtgqhlETEC9PlpogM5jYOGWe82HgAK5MmewSnWbGqUC6L31TKdf68anUWliZoj3NrJk/Xzodtzo2XY9ak8QENXaY1+n8Q8E57mdUoVzkF+NJOIdhodtcFovm63PMbNuJ0/TCuQu0dNEYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628060; c=relaxed/simple;
	bh=TjN2mqLbZL+GZvBbQNPpxnmGx0zOZo0YLxgNMkhjNgE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kXW9GdMIs7Gm7+ZLc2zffDR+AVSIctExhVj9IjHfjCxllVi0DQDpL8ojVFvunmpLeeDhUfozzZPUk/sCFQSbYGxLQq937GJyppqqaDdWeyy9ctF1Yxv+ph4oL6NES2UGdFXFJH9DxTzzD4s5ZF0/cpnQl1obBZoFWHJs6QIuW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tsNy42Eq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so5821468a12.1
        for <stable@vger.kernel.org>; Fri, 02 Aug 2024 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722628057; x=1723232857; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRkZO0QxGsY8q5b8djGsFwrWLk6pIxSotLSe9SlQGrA=;
        b=tsNy42EqJiFefaDjA33Cwy5aMZWOuRF8ROxuCV9dErS4XPD9jXooF6U+X57WeQGALO
         ilKTdwumUlPE34tnmkpxQdyhYKMDNAD6GmT0b+AEsVzmOpTQDFaMhWQsSAMT5xFif4ux
         7fqw+mxx2G+m9k6HqrrMdJH0aeHkkMPU441pOStM++0qSDj7PkVlIhLkw28AAldtZUNO
         NUXRh2YSBNbAipyn23qbKPI3q1Vndy56j6JrpWi4Q5GWLbhwDu1l7HGgO7dM+OMjpPYr
         EoGIqiOrHrIbSD1+4z6MKeJ4vrY22MInwEg0mJou4zyCpHM8TnToCUD2nR65n2K/Nmxq
         mCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628057; x=1723232857;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRkZO0QxGsY8q5b8djGsFwrWLk6pIxSotLSe9SlQGrA=;
        b=JVCYIigQRptd7T8rUwVRXm/CoiE43V1GEFc/HLFANjYHjQVD5lPC1Mkaxif3hXmdDh
         QCML2PrpGuJZxJ4omJm8smhpa5mAoFrzPv7p0m+fiVJBEB6jeBbMTRbj4GynfgEJBkgv
         NGPvdtsfpSTAJattrsxAbv2ZyqKu2cbOQK0BT/kAVoZRho3a6cDxR/AXWyu2SrftsF1b
         iC0fe1Zbvdg1D8kvORjTwMqVfPxza3hTdO1gxtjW5UyvEDIqYUWSARO0i301WntqOihl
         yoAIWAupihlWQj4hsn8JkT8oq3+veG9F/rw9oNSjhmU8HyQ8wSVADy+qqrh+duvtPhQJ
         xodA==
X-Forwarded-Encrypted: i=1; AJvYcCVFUxb44F/Yp0H5TfOwWzj3WG1LoXnIW4hnIlvGg8pI3PV9WSTmWSw26Jityw+TmKgcbJOMZyEPpRa19CPW7SE3uGsKBTO3
X-Gm-Message-State: AOJu0Yy9FDUkPPGGwZVG2IunpwMAAiqLGuw/iHRkt0oPCuFxQ1D5PlYX
	pWzWR6xemLVURK6XI9BRyRorxuGg6Xslwe4bfZ1oH5p4gR8PHsTaxD9r7FY901s=
X-Google-Smtp-Source: AGHT+IFic68LAIlCdG/bfKeHoDNIwgwWvtlOrgBoVGhYtpiN8xKfnemLwzBvFi2dD1lEy8v40ozXYA==
X-Received: by 2002:aa7:db47:0:b0:5af:5538:e03e with SMTP id 4fb4d7f45d1cf-5b80b18e4c0mr4159463a12.9.1722628056902;
        Fri, 02 Aug 2024 12:47:36 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839b2b556sm1440939a12.25.2024.08.02.12.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:47:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] drm/msm/dpu: two fixes targeting 6.11
Date: Fri, 02 Aug 2024 22:47:32 +0300
Message-Id: <20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQ3rWYC/22MQQ6CMBBFr0Jm7ZhSqiAr72FY0HaASQwlU0UN6
 d2trF2+//PeBpGEKUJbbCC0cuQwZ9CHAtzUzyMh+8yglTaqVhf0yxMHfuPL4tn5U00V2bLRkIV
 FKD977NZlnjg+gnz29lr+1r+ZtUSFxjSVaezgjbPXO8+9hGOQEbqU0heqIkHlpQAAAA==
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org, 
 Leonard Lausen <leonard@lausen.nl>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TjN2mqLbZL+GZvBbQNPpxnmGx0zOZo0YLxgNMkhjNgE=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBmrTfXh2xfj98dHX4dp4WVxiTewYFdEJvL8x9/I
 +GVW9tGYNKJATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq031wAKCRCLPIo+Aiko
 1RcBB/icOU+VTgYw+8b1leBG7lCGIGdzBaJb/Yxgd+nQYVsGIKxVnrqaSXzlWiXYlEgokYGnthp
 6NvhfFxjeUrr3Z7qKjz+cj2IHCWzZbhbqNwEEVuiKu6OPT5hotL2V2wm1byGs9oTK3xwI5htKzf
 pTrTmbF9+w7BxxHRSa7hvERKYLj8bspW462GgiWhDzkGDf+i2FV6+xTKrkm0nTzMvYCAC50KsBU
 xSQonKPKsCsZtbL3HOFHTy4SRWiMMgI0VQv8kCG+KbQ5lBQIFWFsDzMjUHgFuVgH8dCznLPyuVR
 jdzl+JPgkLVmHUuhG9B5XbefEFaTNk5D0aYvJQyyPlr/eFE=
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Leonard Lausen reported an issue with suspend/resume of the sc7180
devices. Fix the WB atomic check, which caused the issue. Also make sure
that DPU debugging logs are always directed to the drm_debug / DRIVER so
that usual drm.debug masks work in an expected way.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Reworked the writeback to just drop the connector->status check.
- Expanded commit message for the debugging patch.
- Link to v1: https://lore.kernel.org/r/20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org

---
Dmitry Baryshkov (2):
      drm/msm/dpu1: don't choke on disabling the writeback connector
      drm/msm/dpu: don't play tricks with debug macros

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       | 14 ++------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c |  3 ---
 2 files changed, 2 insertions(+), 15 deletions(-)
---
base-commit: 668d33c9ff922c4590c58754ab064aaf53c387dd
change-id: 20240709-dpu-fix-wb-6cd57e3eb182

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


