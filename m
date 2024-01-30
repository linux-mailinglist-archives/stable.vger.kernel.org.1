Return-Path: <stable+bounces-17400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E886842542
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45FFEB2864A
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3226A036;
	Tue, 30 Jan 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcX9W1ss"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF814C66
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618798; cv=none; b=pGE0//L4k/M5Mbmc03DJL54zBEjVdwn1mOvXcDAJgiy1HBcOBbzFr15HO5FrJikfmU9jRonKHhST6pSx7pbm4TCjwhcXwpaEhdtpMPD3i3zwM+U3H5W2depgz4/8h5BgFviS5rpW7NiC768B1CLguOjRdhAITyG/bu+NjqqhdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618798; c=relaxed/simple;
	bh=tCXOAZ9RKaXG7Z9PuK7V3A133Zg8GcPDYyQVzl3FRNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i00j/Dxzbf3YmZi7ENOe4amLi4br5P6b9Gz+gUziIIgjQPgrFodsPBA0LiLsKxOA0TzA9tuo/TKu2WvkSJg4fFmf5REFIUWBOPavFMa+fua0jIrFQ+A7qmfb98gpHmo3KyZp2dbHdeTaLGz1OID3FmPC+CV5oqdqViOlJACSMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zcX9W1ss; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ddb1115e82so2555819b3a.0
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 04:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706618796; x=1707223596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4PtQqAEVn6EHAEZyxwnwW9gwR0IeNJ+8H+/wVoTsRE=;
        b=zcX9W1ssN09aDZMXYgvyezcfmx9s5Zt7OWBcqzcfNFW6+vQGX+tiNAAzavOsCJLpiu
         Q8mlTYtD2RTpSSDFjDYWNf+FdyVUZUJVq5daui6/P4et4aDVczC+RQgTBnnfqMjCbKOa
         jkT2yJfaf2Th60ZC3Qjm52JA6XjwnH7uMVKOjrhpMzHXC6A7P2vvXLyZQdRUXLLEHEqW
         BGWbnSi5nvYjF9cGT7v+vMh8BeP/e8197YS5w3I69/6lVYDkjQrjt+w+y5euCC3xJo0Y
         Xt5pzoRuGNC2zRCD/qLVuz6eDJQhOPy4iVhoPuHcV2cHBGjT0g6DCdOxBGYW0RTt3Rtj
         Zkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618796; x=1707223596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4PtQqAEVn6EHAEZyxwnwW9gwR0IeNJ+8H+/wVoTsRE=;
        b=jL9UfsLgSBcimAfgVrhdSnvTaC800dll8+9T9A509VGKG7qBiMvqa0CnVVGF6Ufmb1
         aD349ZRavNrl84oEd6X11ghUyvywZRDfEwR+rSBZCnsfLHGYQ2rTAFvyHw5suHo1Okgb
         2PD8ANZZN66US7AgT7Om3Us2Ixs0RDMDVO39NGALeYqbWFTGkKvJjX7deVEOt8thJE5E
         TdOvnxq+JHdLv66asVkV8cJTIpHPKJsBK14qxKqCM0jiOlCXry57LVuls7EG3ISsWX78
         +XYT3UuOpUp5+ik4Z3VpavZw+bCYVL612+lsk/gkqgsUkgGG9Te2xtjSZL/+xBCGSDaS
         xEig==
X-Gm-Message-State: AOJu0YxsvA/7RDe+xH8HWMuu6aa9LOxdc3L7NdqTfx2jSa0FthNMasFY
	iJvfAMWKYzUUAYTolzhMPL8eYU7TW82SMgKkj3lPJGtgV8nv2EfsBwfbs6vVRyU=
X-Google-Smtp-Source: AGHT+IEur06OLNwUUAXrGoZqZHky3QnDwF6ybo2usl7ip7EaML8Zc4Gcznbj/Tf6fyT7//j61zxKMA==
X-Received: by 2002:aa7:8b8a:0:b0:6dd:839a:b070 with SMTP id r10-20020aa78b8a000000b006dd839ab070mr6367289pfd.34.1706618795817;
        Tue, 30 Jan 2024 04:46:35 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id p3-20020aa79e83000000b006dddd3e31a8sm7658788pfq.219.2024.01.30.04.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:46:35 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Stable <stable@vger.kernel.org>
Subject: [PATCH for-v5.10.y 0/3] db845c(sdm845) PM runtime fixes
Date: Tue, 30 Jan 2024 18:16:27 +0530
Message-Id: <20240130124630.3867218-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v5.10.y commit da5e0feb12f2 ("drm/msm/dsi: Use pm_runtime_resume_and_get
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
 include/linux/pm_runtime.h            |  8 ++++++++
 3 files changed, 34 insertions(+)

-- 
2.25.1


