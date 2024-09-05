Return-Path: <stable+bounces-73124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ABF96CD4F
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 05:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A768DB228B2
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6718B149013;
	Thu,  5 Sep 2024 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFDha7Fy"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7413FD83
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507223; cv=none; b=cV4RH1PzgFAsVh4HW9jHkJUu+jh9Tsb0Ut0Juwr+ULdK0EffZCBK+TCbowyJEd10YY+lyKBZhvS7QWB/ozCBB+qJQRVK8OyuMbbtckpQtpU8axNzutf9bspObV92/5zNevAK2PWi3fPja4TIkXmXnl6LnMN0dviwZxgqOmEXidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507223; c=relaxed/simple;
	bh=Zk7CuvNCGglePje0MWpioiCBoDt5MfGEPMscrIFpuTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmO4tWJ+4kNO0JfQaMzkOGSk1kSyuXE0hIaC4g6x9U89M9gISYoQVq6gGQd4RPjQ2kWR1tlterG1MHQdMes0aNHDmS/kIzomRtIm6mnYi6TsAfs+oP60uTM2swU3GP57YnFo2OKJ3Nuq+/9A2ZSa8unjnWu595OnTboId4QGNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wFDha7Fy; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533488ffaf7so262191e87.0
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 20:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725507220; x=1726112020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHqDfVFz4e4ch7Qvu8SgYzoITxtA7TzKSa28k2tmaC0=;
        b=wFDha7FyDuKPJM+JrWv9DM85Xje5HVQw7oYYTxV3ihWImY6n/yRPeDbhIDbgT0mzm/
         kFZiZzP8Ut3+YXRiQ5h218CKKPuy9jKcPeyksr8kSNLnC6w0Sc1blx9H5P7qlyZ60ZHu
         825q5j+1qh40VCy0msXOwAo8RqkFJnRz7YAFWcxOjZCSq2dB9f5QUHGUDoyb6PUSujcG
         2H764iDGQolxXaKt+y5GiHBP/+tBbK5ybnjWNNishnYVvumiy08gj7gybZ15VQ2628/K
         LTrh08/LNNMUA/7cpTHHcg2ovvX17qPMmTlD9dnOXua1VBsr6WgqfL+mNkM4pUPdy+Fb
         VpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725507220; x=1726112020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHqDfVFz4e4ch7Qvu8SgYzoITxtA7TzKSa28k2tmaC0=;
        b=k2lD/x2a+yNjs1YhPlYvrnRv3WRoSV1JY1l8ke1TgR54ZsTAGgpXC0luN7bAqfFTom
         UKh6pKMmGz7RPnYUbg2t3OnpmGEwBSFXHXt5klQ1hfpTSpYnPzFp7mdnMunXbaZkomoE
         aSLwKA98nJ1bMNtZKNOjYLTOD6rRLfXjrcI+7IeHjkz/ABjonWQKSjlxxjEF0MRaWON1
         15ojd6DzJCpf56LGx6m0fs9Fe8W2f5rq5xvJsrU1FY8d2dhicrUwKAHolunI7hCEG2u0
         BTba3Vue3PlcyMhhjpYYIokSft/lA6H13Q7nn/c8q25ZMgDTFtcp6+3atoLcWgaQspVB
         s8hw==
X-Forwarded-Encrypted: i=1; AJvYcCUEggqE6gqSjD1P+OH+iUpKu5lKb9oPe8jmiwfhU3K74tbV8hdoVMb26RJlXW141+8aReG0TBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsMcDNdSUIa8ffB0t9JhHU62/wlJIp5TAOKGzo52NQ2cmc41V
	VbLrg4AVurbFRMF3VgaPT1Qr5fo/mJcwT4svRvYp15+n3yctnjTtuaj2v+HenhQ=
X-Google-Smtp-Source: AGHT+IF8RYrZhm6Rb+d5KJJUucAgU85MelFmmJWy0tHStryL1PjwkJENosRYCfI0WLW1G2JNywVluQ==
X-Received: by 2002:ac2:4e0d:0:b0:52f:d69e:bb38 with SMTP id 2adb3069b0e04-53546afd7c6mr13901020e87.2.1725507219347;
        Wed, 04 Sep 2024 20:33:39 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53565f6d409sm389165e87.35.2024.09.04.20.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:33:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Marek <jonathan@marek.ca>,
	Robert Foss <rfoss@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 00/11] arm64: qcom: set of fixes for SM8350 platform
Date: Thu,  5 Sep 2024 06:33:33 +0300
Message-Id: <172550712140.3299484.13498001864474908780.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
References: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 04 Aug 2024 08:40:04 +0300, Dmitry Baryshkov wrote:
> A set of fixes that target stability of the SM8350 platform.
> 
> 

Applied, thanks!

[03/11] drm/msm/dsi: correct programming sequence for SM8350 / SM8450
        https://gitlab.freedesktop.org/lumag/msm/-/commit/1328cb7c34bf

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

