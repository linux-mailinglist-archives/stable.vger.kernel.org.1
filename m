Return-Path: <stable+bounces-10184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF6B82739A
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F2281779
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB751032;
	Mon,  8 Jan 2024 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Osftsdw+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF34C3A0
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28beb1d946fso1752293a91.0
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 07:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704728262; x=1705333062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZTNcSUeVz4r+BVFzK0hF1tJPJmqGckA2k7wWaSIIdU=;
        b=Osftsdw+2VFoM0lH/ptIKj+KY8HkbH9CbmbEh9uc2xJyxMFkLX1tB1F18VP0e1xJ7b
         7KURBThFjacxqms1VvmyBQngKUzRxNV3hyHcWEx0QP4xxbbcz+J+V7uo0HsI6ksw3DrF
         epznOaRMgwd/6naAycPxJEJCNB8Ad3SE5WrsMAsXMQ2jVrpt/JEipw9zOOqzamcmttZF
         /BYcebYGFaL4Zj+Nfa6EaBMtcYTPgJmfOyvicX0jGd5zQrABht+JRz1zCKSMd2N15ORZ
         dFwqpcTZ40KtXfhkVWDlsnCrfKiXAJGMsTtL0REc2sXWZUipBoFQYuACuMDQ/oImaL1r
         9hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728262; x=1705333062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZTNcSUeVz4r+BVFzK0hF1tJPJmqGckA2k7wWaSIIdU=;
        b=PhwfhUa+pMHN3s+zRNVfwLNEY3EM8AV4IX6GL+5CR5bJdDtzHtWLKeEKGBEh8tr3EH
         kxi+omyYiTMSsTsQgwS4g1O/WHhwQ0MbMmVL1cqfQTDMOhEn4rHWwx659+iWkfc/YPIt
         mxnR3KB/ixXFeY72LByi0CrwytQCNfLaFL9juc98i2DKgw0gXXG8zT+j64qa6KtsQLLN
         A2u3JLH0yLtkoKQs+fNgHc9xYUqvbWbU6jsOkOMI0fmR22ialjJyfFMdNRptRNLKZo43
         /s5V942l5DiXDmUzzHKO2rb3aAiKqmYBfBeZCtEYQyzjyqjWgLR4YLGTmdMZytMyY4Oy
         dK+g==
X-Gm-Message-State: AOJu0YxfeH6/RYczTZo/CMUMFGCyBDwzyiOmjhTc+qxWe/l3gcC2yRcH
	mbpsBoxpJg/wveZe+L4VEItFcDIywsmYHnpM7b7rm9x31f8=
X-Google-Smtp-Source: AGHT+IEPzlx/awUt1qPJVSem1cWc/kHWbezWyIQDglUJB247IB6NICiB94xv0tGcmEQvIQVwAa7hnQ==
X-Received: by 2002:a17:90a:d48f:b0:28c:a76e:7c36 with SMTP id s15-20020a17090ad48f00b0028ca76e7c36mr1810535pju.68.1704728261825;
        Mon, 08 Jan 2024 07:37:41 -0800 (PST)
Received: from x-wing.lan ([106.51.164.237])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a318500b00286f2b39a95sm122218pjb.31.2024.01.08.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:37:41 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rakesh Pillai <pillair@codeaurora.org>
Cc: Yongqin Liu <yongqin.liu@linaro.org>,
	Stable <stable@vger.kernel.org>
Subject: [PATCH for-5.4.y 0/4] db845c(sdm845) ath10k fixes
Date: Mon,  8 Jan 2024 21:07:33 +0530
Message-Id: <20240108153737.3538218-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v5.4.y commit 3cf391e4174a ("wifi: ath10k: Don't touch the CE
interrupt registers after power up"), which is commit 170c75d43a77
upstream, unleashed multiple DB845c(sdm845) regressions ranging
from random RCU stalls to UFS crashes as also reported here
https://lore.kernel.org/lkml/20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid/

Taking a cue from the commit message of 170c75d43a77, I tried
backporting upstream commit d66d24ac300c ("ath10k: Keep track of
which interrupts fired, don't poll them") and other relevant fixes
and that seem to have done the trick.

We no longer see any of the above reported regressions with the
following patchset. This upstream patchset is just an educated
guess and there may be one or more fixes in this series which are
not needed at all but I have not tested them individually and
marked all of them as Stable-dep-of: 170c75d43a77 ("ath10k: Don't
touch the CE interrupt registers after power up") instead.

Douglas Anderson (3):
  ath10k: Wait until copy complete is actually done before completing
  ath10k: Keep track of which interrupts fired, don't poll them
  ath10k: Get rid of "per_ce_irq" hw param

Rakesh Pillai (1):
  ath10k: Add interrupt summary based CE processing

 drivers/net/wireless/ath/ath10k/ce.c   | 79 ++++++++++++++------------
 drivers/net/wireless/ath/ath10k/ce.h   | 15 +++--
 drivers/net/wireless/ath/ath10k/core.c | 13 -----
 drivers/net/wireless/ath/ath10k/hw.h   |  3 -
 drivers/net/wireless/ath/ath10k/snoc.c | 19 +++++--
 drivers/net/wireless/ath/ath10k/snoc.h |  1 +
 6 files changed, 64 insertions(+), 66 deletions(-)

-- 
2.25.1


