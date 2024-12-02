Return-Path: <stable+bounces-96041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFE29E04C2
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D88161225
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EBB204093;
	Mon,  2 Dec 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIqY70pg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA9202F8F
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149481; cv=none; b=MLYx//ckaHPrYiApQH62NZyTpJFslSYZOrdXbg5J7hPi54mHf/e13kmgPJHIx34IEwuhfcqaudRPBSTkHsLxD0syGHAEHyjB6ttKctUdaRNvZZwkaHRU16qeX89zMg/iaN6qOYhbCHDy2D6nFIuvBD9JLehIpxvLekQ15l3TTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149481; c=relaxed/simple;
	bh=oveab0x/X5lxQcctIhT1NPmDKwzpaRt5bfuaux7SDmM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qDe+J2Csd2LkuDFNIjFG3AhRvfQ4FfTATUhVAo2upGe9ffTiQHTMkJdhijR28WTGjf/b0GMbnt7DqBSLszHuTgusE2Y/L/9eg+ePmPmY7xCn5Otj2xrK4/j3epxosuNkvijO5PqWzzWElAXwXciOJdMPnyylM3TR20Fkje4Yn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fIqY70pg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b66d08d529so369481585a.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733149478; x=1733754278; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uR/f84OMp446oPhdoEj+ac1SLyhexTWGRvHwC4hhgxI=;
        b=fIqY70pgULraV5XU4IS5HDBAW1s066VE1fdWv97xerIgBcBEViSfy/ufTREbdrXEHR
         wopFCb6xx3+cJa4yfdPFtHwWNLM/ad4Q0cMI+vd4fY50zsqX5phvjnYdKCb1nm/UZfF6
         BeM0E8MgtO/tt+v0JJzrYrNafvZynw1RD2MtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149478; x=1733754278;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR/f84OMp446oPhdoEj+ac1SLyhexTWGRvHwC4hhgxI=;
        b=sWCvPrkIultHXmWGFFnmRaakqR/6b4srIGCb+BE+xBCKxwpzOq/ML1ecl8uP0828Ba
         lgggXbyKcS9PXHirKPfCRdyaYhu2cZtYYjxEQCwsdMY0ZShOOBbneqzQ64X+jZyIpBoy
         T7p9x+YAnqqZL10r7cvMqsMmSArBzd/r7Jnt1mEilWzdRnC9CcLnsbvU2BVbbKc18nEv
         TkrSnzYJ/Vlca1+7kz/5t01MYtk9xVOKIMRR+sDPAr5+Wtj7acDISbkNe/QZDwnor5O/
         tNDylW18r00j9VzoIKzF3stoyFYm1/nq3lnBvWbP/5110OtegezzdRcuoSMo2hsUDJAd
         Ktfg==
X-Forwarded-Encrypted: i=1; AJvYcCXBwpdWgzmr7aV6mEOJkNQ0QP7QOzn7qNbCYwqn8uJXewndYDmR0KQT5AY3K6qChi8QOEe+1YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUu//nbZoSghpAB3s+o3RhWOsaNHcdPuKvHACdOV/V0x0lUhpy
	/osC+kAoSwNvkE5PO6v6iN+NH/5mRk7b4zo4PRL9QbLKUEuUY0Ff9mdZXOSBwg==
X-Gm-Gg: ASbGnctEUmyifnGWv3+7N7XJjWtc0fNlPJYrOy+Z5Cj30PHda1ZpvNOr0f+WqgjgVmD
	JKcq1dfgGT6xGTXHSEcfYZWsQ+KpCndwc7IhcC7CRH39e1nXJmQilasQcwq+1YrK9LoGr6o2GGg
	tzWxBTWMrSfTPhpH1hVo4UGVz3mGFhwCumYOmQRigHkUKx+V4SuzhXqvpd7ZBdHo/TuOeuu7I3J
	wVUwiR/2lKKP2UNXLpzJcILXAItpnHAk4yRQSTSgy/+HK/EF8geUHm8liVDZGZirBglKyHjfsFR
	alQwUj7DQfNwOWWDlWbvyC6U
X-Google-Smtp-Source: AGHT+IGdnM12FG/mve/yBjS01j+lXu+XUWGzwYOjmdB0FCytOi8NRKrlt+bH6OQ9s4cPAmEC05Jx7A==
X-Received: by 2002:a05:620a:2782:b0:7a9:abdf:f517 with SMTP id af79cd13be357-7b683a58b3emr3038810285a.25.1733149478198;
        Mon, 02 Dec 2024 06:24:38 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85be9087890sm179710241.25.2024.12.02.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:24:37 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/5] media: uvcvideo: Two +1 fixes for async controls
Date: Mon, 02 Dec 2024 14:24:34 +0000
Message-Id: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLDTWcC/33MTQ7CIBCG4as0rMXAAIW68h7GBX9tWbQ1YInG9
 O7SrozRLt+ZfM8LJR+DT+hUvVD0OaQwjSXEoUK212PncXClERDglILEc7a4DQ+s03O0GGzjOOG
 UaadQ2dyiL8/Nu1xL9yHdp/jc+EzX6z8pU0ywN0oCCEaNsmfbx2kI83CcYodWLMMuAAUQlGhtG
 iGJcz8A9gk03wArgDa1FNbXtTPyB8B3AV6AFphU3BmtSPsFLMvyBt1q/z9wAQAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This patchset fixes two +1 bugs with the async controls for the uvc driver.

They were found while implementing the granular PM, but I am sending
them as a separate patches, so they can be reviewed sooner. They fix
real issues in the driver that need to be taken care.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v5:
- Move set handle to the entity_commit
- Replace uvc_ctrl_set_handle with get/put_handle.
- Add a patch to flush the cache of async controls.
- Link to v4: https://lore.kernel.org/r/20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org

Changes in v4:
- Fix implementation of uvc_ctrl_set_handle.
- Link to v3: https://lore.kernel.org/r/20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org

Changes in v3:
- change again! order of patches.
- Introduce uvc_ctrl_set_handle.
- Do not change ctrl->handle if it is not NULL.

Changes in v2:
- Annotate lockdep
- ctrl->handle != handle
- Change order of patches
- Move documentation of mutex
- Link to v1: https://lore.kernel.org/r/20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org

---
Ricardo Ribalda (5):
      media: uvcvideo: Only save async fh if success
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
      media: uvcvideo: Remove redundant NULL assignment
      media: uvcvideo: Flush the control cache when we get an event

 drivers/media/usb/uvc/uvc_ctrl.c | 77 ++++++++++++++++++++++++++++++++++------
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  9 ++++-
 3 files changed, 76 insertions(+), 12 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


