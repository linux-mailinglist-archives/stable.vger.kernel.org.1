Return-Path: <stable+bounces-17404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1924484259E
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F2128E037
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8666A015;
	Tue, 30 Jan 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsg6GvLJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61524C66
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619534; cv=none; b=AfMuJiL8sWPeLBRbQkv7TvlPdaojIBWGw2NvvoDY9kT85iZmT+T7TDXnb3Fvy56kURZHA6v4tabF47jDEo9TzcWjq9yXRSEvPsMTF9si7wkxC11m6Po06d4uJmR5p+kwieNRiA9k+1d/920cykhty96WTbGb8xlmIenK0/IQieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619534; c=relaxed/simple;
	bh=oLPkTLJJxbRP+lAtKg4fnv2jxkG6lB0ThunmN5R35ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vydj6lJociM36ixh4Zt/jN0w2KFwYApm3cifRbANJF5eWjW2Q3i85eXt/V3ZTpwnLFpAZLPHVTCLwxnMqD5TR8Ve4L0fwX+J+C+g+8sFvcB68BSlBguMyHaR7V8WdmhU62NgOx70RSYRj4b2cKWKx8rWQs96TbM+kNXj6efynpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qsg6GvLJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7858a469aso21253885ad.2
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706619532; x=1707224332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffIYkk0nMvkvVH8Ou77KVrt+lDDEFkTEMJXX5WzvhbM=;
        b=qsg6GvLJi6L1vhCEYHtTU3gDMc+P9kEZIMcT6c15bij+AhWuzqx+eOke2HmVYkEdJQ
         aKv2CSC9L6XoXIHJJKZx5LTKr6X6pCpJvvANZrLCg2Vr13FYOBmUfpDuC5pc1eA1onzg
         gsDahJWtGGX03CsiTcQmXjR1OdMb6uRH+O9/zuuyPjZ41GRV6PsBCpXqaho9Z7lTASZH
         vdLeT003QNdaem7KCX6Gu+i2/TYeyqWNfzw0QJAoVPKy55SSnITiETctlyphsIOmWjyU
         LOqwQlQViLyijWF3L+ZliNwgScr4KHFgkrq6IQIJX/hZgH86zsmJIphCKQG+MMkQ6c/N
         Bw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619532; x=1707224332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffIYkk0nMvkvVH8Ou77KVrt+lDDEFkTEMJXX5WzvhbM=;
        b=gELjwRWIewrVFy6QJmDQSPXIkazOPZv4rA77NKkpf2nrTwK6HMn9iDgxcSENB13DlG
         0wdTnOTpCYZchd1eO61wP/GdvYcR33+sPeRxREeF/zAlR/gFmY+8fvMP+euJh1ShTjTQ
         cJFl8S3eyj5qlXjIWuaTdwUv5qNBi1cUqRIq1iJhh0B5mIW5E7YmWo3wk5nVPI5phkh4
         WSZBCpAbLN7/GLT8yT33etwEbnhB+8blGuw4A+kiR8h4Ih9OqFxximelx7f62PUUhYhV
         jHNXXb37ODLFUesBco+V356H87A+jqd0hNdRNVsywRNcd1RnesQA/Tusnc6cODmu8ApL
         lhpA==
X-Gm-Message-State: AOJu0Yxfo5gpYjynjEf/f/16vjExzT+DDlAlvqtY6H0Kykdi62Iiozgq
	ZzCk5YVnrz4PWNyCKJBp0U3yI9SKwPLhracqqnwHGRq3fIZAVkUuoKtLaMlJdzw=
X-Google-Smtp-Source: AGHT+IEumntvsUdskCY2YQ9fAq3/AsmgPVV6UAonMEAeLuSWOSvDN4gjk8CfzH62auQHqrmLdfoyHA==
X-Received: by 2002:a17:902:e805:b0:1d9:55b:6a4c with SMTP id u5-20020a170902e80500b001d9055b6a4cmr1633850plg.32.1706619532029;
        Tue, 30 Jan 2024 04:58:52 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id lw8-20020a1709032ac800b001d8f82f90ccsm2432029plb.199.2024.01.30.04.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:58:51 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Stable <stable@vger.kernel.org>
Subject: [PATCH for-v5.15.y 0/2] db845c(sdm845) PM runtime fixes
Date: Tue, 30 Jan 2024 18:28:45 +0530
Message-Id: <20240130125847.3915432-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v5.15.y commit cbf207b17111 ("drm/msm/dsi: Use pm_runtime_resume_and_get
to prevent refcnt leaks"), which is commit 3d07a411b4fa upstream, broke
display on Dragonboard 845c(sdm845). Cherry-picking commit 6ab502bc1cf3
("drm/msm/dsi: Enable runtime PM") from the original patch series
https://patchwork.freedesktop.org/series/119583/
and it's dependent runtime PM helper routines as suggested by Dmitry
https://lore.kernel.org/stable/CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com
fixes that display regression on DB845c.

Douglas Anderson (1):
  PM: runtime: Have devm_pm_runtime_enable() handle
    pm_runtime_dont_use_autosuspend()

Konrad Dybcio (1):
  drm/msm/dsi: Enable runtime PM

 drivers/base/power/runtime.c          | 5 +++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 ++++
 include/linux/pm_runtime.h            | 4 ++++
 3 files changed, 13 insertions(+)

-- 
2.25.1


