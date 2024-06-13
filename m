Return-Path: <stable+bounces-51463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97427907001
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB211F21A24
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57123144D34;
	Thu, 13 Jun 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="alzM9TNW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CB1448FD;
	Thu, 13 Jun 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281372; cv=none; b=XuRFK+Gfv6TLnH5OKfwcm82JBqbt1qZAX52Zf17kSzSZvo6qWD/IFb6zfj/NH1lLKQvCfPJXCM8qvRt0f+sXfKEJEVvm2ePeXpSc5Ur/jNhW4xet6XRnqyEgH1TCjieZACKrYH8eK3NWwKfS3g+nYhc8rdMvMuPB1NaVpLSSlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281372; c=relaxed/simple;
	bh=Pok/gAHShtsW6QtZ59eRMyYZVba/x1Yix9f03qrx3U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkLXAettu+1+nnukg0bpYGY5cRnV2xS7CsMKmxwAj+8eQVynoVto4aGieWr4IBXk936i1Bu2cQDIxNo8wkpFtHItMUHOBEP+iBo+LWj0kcVjBfVj5JcoAqQ7cGpJwFNkHmt2ToMuHAPbunhS1W2MXcZRrFepUIq0qriizmJCTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=alzM9TNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891E2C2BBFC;
	Thu, 13 Jun 2024 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281371;
	bh=Pok/gAHShtsW6QtZ59eRMyYZVba/x1Yix9f03qrx3U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alzM9TNWSS4/wsSVLC0vkU1uq9ZkAwnTVhn87crOJYemQKy0tWBZPhA19CwyYjrJm
	 NK+QN9Zlf0TDmFBoODYBb3NmuOWoojWhMT9W0VewaerpNTfX8tzjiOvrDblXDMeL3B
	 zZdlZAxDPujPjDVUUDxcadrGQXkCGARKuEyICZDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fenglin Wu <quic_fenglinw@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 202/317] Input: pm8xxx-vibrator - correct VIB_MAX_LEVELS calculation
Date: Thu, 13 Jun 2024 13:33:40 +0200
Message-ID: <20240613113255.370506198@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fenglin Wu <quic_fenglinw@quicinc.com>

[ Upstream commit 48c0687a322d54ac7e7a685c0b6db78d78f593af ]

The output voltage is inclusive hence the max level calculation is
off-by-one-step. Correct it.

iWhile we are at it also add a define for the step size instead of
using the magic value.

Fixes: 11205bb63e5c ("Input: add support for pm8xxx based vibrator driver")
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240412-pm8xxx-vibrator-new-design-v10-1-0ec0ad133866@quicinc.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/pm8xxx-vibrator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 53ad25eaf1a28..8bfe5c7b1244c 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -14,7 +14,8 @@
 
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
-#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
+#define VIB_PER_STEP_mV		(100)
+#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
 
 #define MAX_FF_SPEED		0xff
 
@@ -118,10 +119,10 @@ static void pm8xxx_work_handler(struct work_struct *work)
 		vib->active = true;
 		vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
 						VIB_MIN_LEVEL_mV;
-		vib->level /= 100;
+		vib->level /= VIB_PER_STEP_mV;
 	} else {
 		vib->active = false;
-		vib->level = VIB_MIN_LEVEL_mV / 100;
+		vib->level = VIB_MIN_LEVEL_mV / VIB_PER_STEP_mV;
 	}
 
 	pm8xxx_vib_set(vib, vib->active);
-- 
2.43.0




