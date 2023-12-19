Return-Path: <stable+bounces-7878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E38818345
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 09:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8419B235CD
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0C81119A;
	Tue, 19 Dec 2023 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+xmivTp"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C113AC2
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4669068a20bso430631137.1
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 00:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702974336; x=1703579136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4L5uD1RdT2mZbPJoxL2cSkqgphm3L8KHRjyes+Q2wMc=;
        b=e+xmivTp1j6Un+61OZT/K7Kyu2xfdtTpZNCzR63Fylesd54ZSzerI4rSIXXs6ioldl
         tDwrfSY4tHQmCewsSuPxEMfhr6PXeg8f0prNZiK2GthD/ZWEqNkSgieCGKF7C/9JmAhW
         igLcqb3Nsu6SD1948smV/OsXd92iDqVN8tMxFHr0h5wEQN97j40tb2Yin4OrsoBA3oTl
         w6T9NQ7SBTnDG/0CFCCk2mnKkRXhKFsp/ZLddrgtwkV32O+6mXOqIffThUNA0o3URinN
         Ea07EFgR8Vaseqc/c7J/VIxxz+3MqIkWqo55kxOsXNCksuyibcoG+MlOMBGbPALj4Hm/
         DtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974336; x=1703579136;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4L5uD1RdT2mZbPJoxL2cSkqgphm3L8KHRjyes+Q2wMc=;
        b=GLXGdn7/zg+8hcdELnPtkPHyM7QHaH/N8Su/FXKehGV/cI2VjEZdjDfHUWnMDPaPU4
         XXejPVmzeKRlc/270BY42XiajxMFEyv2nE3/AgsAZPrmxa3ohL7aAs8dlTcvA1H98UKd
         FGszupjeBPsnbwcQn+n9h3A2Kg4KquvEaQeZaLm/BNz0ieD0Ek9O2GAaOEP9B3kDR45e
         FlMNHC6van2qo2ZispMTQOafu004xrigEyVnHIsMvr3TLkRrnx1gnm4Jlm6neVYK1Gno
         UhAasRoqbOc2sDGxrBeZFAwSGEGWp9maL7hDtNiYUXb5LBiCWfKkiELZBhO5Nvfr6WoI
         4Eqw==
X-Gm-Message-State: AOJu0YymZ0+EhT8WMNlS+vk7BZn3UrptcbDgW9MFbPsl+wqN0NB+U8un
	a9bZwOAliPKS6vhTRHLQSZABGOuLMXmqlK8VuGbnmA==
X-Google-Smtp-Source: AGHT+IEoZup6yhtDhNP4uUzwHAwiSTvqSmHFmiBSIYpEeIts/4I+mxLVOYAh9bpLEOhsG+nKCN20jI4NWNIkFfh6Ki8=
X-Received: by 2002:a67:fe01:0:b0:464:9c52:d69 with SMTP id
 l1-20020a67fe01000000b004649c520d69mr10043645vsr.70.1702974335762; Tue, 19
 Dec 2023 00:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 19 Dec 2023 13:54:59 +0530
Message-ID: <CAMi1Hd2jWZpZn8O1eP5qCZ2HfLbvBAEJsM5FwZxp-rC3q-V7KQ@mail.gmail.com>
Subject: Request to revert lt9611uxc fixes from v5.15.y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Maxime Ripard <maxime@cerno.tech>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

The following lt9611uxc fixes in v5.15.139 broke display on RB5 devboard.

drm/bridge: lt9611uxc: fix the race in the error path
drm/bridge: lt9611uxc: Register and attach our DSI device at probe
drm/bridge: lt9611uxc: Switch to devm MIPI-DSI helpers

Reverting them (git revert -s d0d01bb4a560 29aba28ea195 f53a04579328
#5.15 SHA Ids) fix the following errors on RB5 and get the display
working again on v5.15.143.

lt9611uxc 5-002b: LT9611 revision: 0x17.04.93
lt9611uxc 5-002b: LT9611 version: 0x43
lt9611uxc 5-002b: failed to find dsi host
msm ae00000.mdss: bound ae01000.mdp (ops dpu_ops [msm])
msm_dsi_manager_register: failed to register mipi dsi host for DSI 0: -517

Regards,
Amit Pundir

