Return-Path: <stable+bounces-16408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BCF8402E6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A5028431B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419B4CB20;
	Mon, 29 Jan 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKCg+pqM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C08537ED
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524749; cv=none; b=Orsi1SX4zK4Fn/Qc9eXES5l+L67Rq+7D3cWWOVIQNlOVywoLqyq9VW2lqbiXC4+kBmeUVOMtUPIQDUaBnvXz/LJkg3CTl9enPhAjkPw5D+UntTKXR108n6IqG6Iyp5OXqcKewVzsLHs7+617AaUhgszBdgS0s0k7KW2NGEgNajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524749; c=relaxed/simple;
	bh=Vz1CVy8uq43wRSVHcOhqTWSOKRhB31YCrfj4XMOL6ZY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=r/Y9tqxoiWS1rhlM9Y2TTJEh8lxW73Hr5QTPi6Zi/JHNtSOdmOTaE9W/19QhNx/pSqh1kcTKxgoavErHEwkQtHWpnuwAZw4gET0iatdCYedhWXsqKdqPBlAxf6CFhopjtPJ0VY7X3gOR5y1B3Plp1UGTDj68XFPD/0B2MwDspT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pKCg+pqM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso954472a12.2
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 02:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706524747; x=1707129547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8K3TZ6SkujVnWFMn1kyY790OEWPR4SJsIMrWtxXZnLc=;
        b=pKCg+pqMKhTOrwGtwcxaSCfbwCUqPefb4QYveim+O3oad0s4NuzuoC0tpnE3Sx1Il3
         md1p3M1huRnYlHZ/UyF96EACPXmlsmkatkwmFTM2p/K00MSEwqx2XSpH5mR2MTDEh8RJ
         rnnTfSGlyHCe9jntH9sIgk4HfRLQGikIu73xHq6I77G1GgTwEaXAc4YhYHELsjyvhOjw
         AIGt/5200xUDldGaqizQi2ZX+AiHyliSCnYtA6uiJqrsJqANk46qQxQM4WlGGT2tlJCc
         gXt17zF5AqUD+gLRBgWndmPMVvYCyfhb4Jpv28YRxwo8QW44VhH7jYpp/Fug7A7WCRDF
         iBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524747; x=1707129547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K3TZ6SkujVnWFMn1kyY790OEWPR4SJsIMrWtxXZnLc=;
        b=CuYVJ1CtVg6WBIP4I/PnAEG7GiGa0BJ9adnhaBxlsQxVs5gA1JxNHEBXG4vMlovahI
         ZSHwnq7r6BSB+LyaGtWV8t0E8k6B08CVdD/xbkdq7do7lw/ifuLAAInf3zJJoasz48X8
         uIToQR1l9FhB0WfNLJ7u6fXMUH7sJzN/r1+FgnmnlhM9ihCO/MqM3ATA69C9amUolEsq
         aberllxB+oTXbdW1HtUghQehUsk9UwdxAgEnWb3FoaYhNE9E7dZBMdDmk2VNj7Ti1KN7
         KtahMkteKuH5rDeWzVDr73hgjCuu1MMVhox2i3k+CdT6kVMmhHWCDzpUhpD4SjFWfxUI
         8r6g==
X-Gm-Message-State: AOJu0YwYLEqQtQW/dyNTIN9G74JYuAwS60A7MmAy2yrRk2sc26wNksGc
	7IIKOny5tRstBbsLUx16lrhwbc64OsTh2WYyhjXW0MCdQ6CpMU/W5U9QZfpXiDA=
X-Google-Smtp-Source: AGHT+IFw0Q6K8g8lmGnNEt19XDowBa4w9g8hRV1aa7gtAvrl9NyFuTxaqNfHg406+jQ9kWxWUqEDhg==
X-Received: by 2002:a05:6a20:252e:b0:19c:93c2:7ef3 with SMTP id j46-20020a056a20252e00b0019c93c27ef3mr1452199pzd.46.1706524746899;
        Mon, 29 Jan 2024 02:39:06 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b0029564dec437sm2285401pjb.6.2024.01.29.02.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:39:06 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH for-5.4.y 0/3] db845c(sdm845) PM runtime fixes
Date: Mon, 29 Jan 2024 16:08:59 +0530
Message-Id: <20240129103902.3239531-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v5.4.y commit 31b169a8bed7 ("drm/msm/dsi: Use pm_runtime_resume_and_get
to prevent refcnt leaks"), which is commit 3d07a411b4fa upstream, broke
display on Dragonboard 845c(sdm845). Cherry-picking commit 6ab502bc1cf3
("drm/msm/dsi: Enable runtime PM") from the original patch series
https://patchwork.freedesktop.org/series/119583/
and it's dependent runtime PM helper routines as suggested by Dmitry
https://lore.kernel.org/stable/CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com
fixes that display regression on DB845c.

Dmitry Baryshkov (1):
  PM: runtime: add devm_pm_runtime_enable helper

Douglas Anderson (1):
  PM: runtime: Have devm_pm_runtime_enable() handle
    pm_runtime_dont_use_autosuspend()

Konrad Dybcio (1):
  drm/msm/dsi: Enable runtime PM

 drivers/base/power/runtime.c          | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c |  4 ++++
 include/linux/pm_runtime.h            |  9 +++++++++
 3 files changed, 35 insertions(+)

-- 
2.25.1


