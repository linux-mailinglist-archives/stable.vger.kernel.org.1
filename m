Return-Path: <stable+bounces-157996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C32AE5686
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAABD4C4473
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A638225785;
	Mon, 23 Jun 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D7l9i3ZW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506616D9BF;
	Mon, 23 Jun 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717229; cv=none; b=BCmsGdS6Ut3xkDp19lSFTbl6gMWqAejphOoj/wH0ZEysj6P0awmav4CRHZ3obw2rri9SRReZvChOZXlfjbmXzMgQ5dXKvCFVchJiaE48M81ca9R8LnmqefhXLODLSyji/nSlJVvbDeI9GL3GTlQArlQAli7qcwYio5DPpTiv+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717229; c=relaxed/simple;
	bh=xEcvWVW17WxsVpMqUYV5Y2I2HiYCUULTcYWVb+iftiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CamvWVoqeie06kfWNAdsaWj4AokHoYiSVD4VY7Uu7IEAYLd/b5KzUODo0VsULjWrsE7nlfZFYvSt0WLRy5/Pq7E9NaeeVIHYZP81WF00DNoJJ7trg1iSQeER/vz4uWx/YV+2dU3CCZGwTg7d94BTuP8J2oupCAmyyMopCGg1g7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D7l9i3ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01FAC4CEED;
	Mon, 23 Jun 2025 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717229;
	bh=xEcvWVW17WxsVpMqUYV5Y2I2HiYCUULTcYWVb+iftiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7l9i3ZW3qwBSfwygWGFtqZ5B60mNsCPg1/zURfNUstVJjszhOWkEDl+0gE1twZTR
	 GZn/RgHkUzddKd1qZhfTTqac0cgHIkhjVPyT9zrhnONwnpUIY5Htr3FRDRl23erwEU
	 ZP/18ns+6yx72yZa5UhQtT8eWO+yX+XBJ12mQJ+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrick Daly <quic_pdaly@quicinc.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 385/508] PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()
Date: Mon, 23 Jun 2025 15:07:10 +0200
Message-ID: <20250623130654.766064351@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charan Teja Kalla <quic_charante@quicinc.com>

[ Upstream commit 40d3b40dce375d6f1c1dbf08d79eed3aed6c691d ]

pm_runtime_put_autosuspend() schedules a hrtimer to expire
at "dev->power.timer_expires". If the hrtimer's callback,
pm_suspend_timer_fn(), observes that the current time equals
"dev->power.timer_expires", it unexpectedly bails out instead of
proceeding with runtime suspend.

pm_suspend_timer_fn():

 if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
 	dev->power.timer_expires = 0;
 	rpm_suspend(..)
 }

Additionally, as ->timer_expires is not cleared, all the future auto
suspend requests will not schedule hrtimer to perform auto suspend.

rpm_suspend():

 if ((rpmflags & RPM_AUTO) &&...) {
 	if (!(dev->power.timer_expires && ...) { <-- this will fail.
 		hrtimer_start_range_ns(&dev->power.suspend_timer,...);
 	}
 }

Fix this by as well checking if current time reaches the set expiration.

Co-developed-by: Patrick Daly <quic_pdaly@quicinc.com>
Signed-off-by: Patrick Daly <quic_pdaly@quicinc.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Link: https://patch.msgid.link/20250515064125.1211561-1-quic_charante@quicinc.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index bb68cba4d85a9..313ccb7e77646 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1001,7 +1001,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
+	if (expires > 0 && expires <= ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
-- 
2.39.5




