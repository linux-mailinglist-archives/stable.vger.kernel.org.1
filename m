Return-Path: <stable+bounces-187424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B74BEA38F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5355C1AE3C2E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA70330B1C;
	Fri, 17 Oct 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2MVqOVjQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02C330B00;
	Fri, 17 Oct 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716032; cv=none; b=iDpEX+dYijhVjTpRBJdhsLHxybjpzLbpWLkABkzNSvR6Y13Er0MQHdWDd5HUazk20J4RimtcU9BrACBmOg/frdQzFM7fX/SdhDjGUGCwx35T0kZnv50ns9GQRYH1tLizqkEk7eOk22iCiyGSpUSaJ4l1Ep1CnbZgvF3mUtPPt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716032; c=relaxed/simple;
	bh=cme9UmgvngKn8YowYd3wbBG9V+P4/Fl1bv1RD9kjmQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHd2LkOQWxl+na1BSFMJlHb28BQRZ64v6xhnjAyU2G4y8SpmBufCJmvnSrcpCngP2GKEpEk3VSDoL7F/vbVdb1hLUIbeOlSc4VHMNmA9DmIQcAfUAV1V1egaF9lgTSFJgxjYjCVpZ7IGFutoCzk+RLMG8u58ciq8z0vylXrQ9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2MVqOVjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C2C4CEFE;
	Fri, 17 Oct 2025 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716031;
	bh=cme9UmgvngKn8YowYd3wbBG9V+P4/Fl1bv1RD9kjmQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2MVqOVjQ5mQmMxDpqxhh9risAziy9ew4H4mfZX68VYknsi4Tx/nF3EEnedyPjZu7D
	 Du4Pd6rf5oh5i9vjoWVNoy6Tfw2PNtOGVaYPkXZ3ohyr5Bg2tp/zo8tvk0IT9CYeww
	 xK8T5jKV0e+OsgzfaLD80YK6VZEpJonPZX1ZEYcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 050/276] thermal/drivers/qcom/lmh: Add missing IRQ includes
Date: Fri, 17 Oct 2025 16:52:23 +0200
Message-ID: <20251017145144.315970683@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit b50b2c53f98fcdb6957e184eb488c16502db9575 ]

As reported by LKP, the Qualcomm LMH driver needs to include several
IRQ-related headers, which decrlare necessary IRQ functionality.
Currently driver builds on ARM64 platforms, where the headers are pulled
in implicitly by other headers, but fails to build on other platforms.

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507270042.KdK0KKht-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250728-lmh-scm-v2-2-33bc58388ca5@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/lmh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 9006e01e18c20..62c20d5c2a66a 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -5,6 +5,8 @@
  */
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/irqdomain.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
-- 
2.51.0




