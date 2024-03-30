Return-Path: <stable+bounces-33817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01291892A1C
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A711283393
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614F411724;
	Sat, 30 Mar 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PzFkIc2+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00C33DF
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792014; cv=none; b=lfuCs6jbQTPsS5alnppiSnN0wxXEaluox6KetKVCJepETF+/GtKkq+BQT9FAhb56yb2k8UmoT7n+HI2nJruMDKXCS0i0UA68YpObIVVNd3ATOFUrKchK+hkX0IF9ADs+QiKPWqL8sxlFkYtRWnWy2Qyb7PWPOdVIGPf6I9qOyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792014; c=relaxed/simple;
	bh=x+4iPX2HahoEvpsiJ3SghtZmX/jiu766vJkX7elfPmQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j8dYVV2fRUeYAYkvZ440xc0SmlQmJBmAMqlP11fj+49ucTjApcOgQr65YAUXGtYV+W0F+k/52YuldbbkZeRQjrq/mXx5Ior+xqKCkRoe4Vlf3m6YhFiwAmmgkrweTtXuljRPA51GbStKlWu0TWYCwrtHi1xvYk5vN73Kq+RDq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PzFkIc2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A331C433F1;
	Sat, 30 Mar 2024 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711792013;
	bh=x+4iPX2HahoEvpsiJ3SghtZmX/jiu766vJkX7elfPmQ=;
	h=Subject:To:Cc:From:Date:From;
	b=PzFkIc2+T+7QCzracOI8MmjuUt6m6Cy7YHloFUhTih0EvSS303dldnEe8vzryVwCH
	 0Rlq7LG9OaFr6c9QDxm8QH3DIktZnTKpqp0T2chWdX4oE4m2OwpioVcNOIIk0/+zPm
	 +FxGumX4EUECxpMqNFsyD1IrT/ggspnVh4SDn0hI=
Subject: FAILED: patch "[PATCH] thermal: devfreq_cooling: Fix perf state when calculate dfc" failed to apply to 5.15-stable tree
To: ye.zhang@rock-chips.com,d-gole@ti.com,lukasz.luba@arm.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 10:46:50 +0100
Message-ID: <2024033050-imitation-unmixed-ef53@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a26de34b3c77ae3a969654d94be49e433c947e3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033050-imitation-unmixed-ef53@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a26de34b3c77ae3a969654d94be49e433c947e3b Mon Sep 17 00:00:00 2001
From: Ye Zhang <ye.zhang@rock-chips.com>
Date: Thu, 21 Mar 2024 18:21:00 +0800
Subject: [PATCH] thermal: devfreq_cooling: Fix perf state when calculate dfc
 res_util
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The issue occurs when the devfreq cooling device uses the EM power model
and the get_real_power() callback is provided by the driver.

The EM power table is sorted ascending，can't index the table by cooling
device state，so convert cooling state to performance state by
dfc->max_state - dfc->capped_state.

Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 50dec24e967a..8fd7cf1932cd 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -214,7 +214,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 
 		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
 		if (!res) {
-			state = dfc->capped_state;
+			state = dfc->max_state - dfc->capped_state;
 
 			/* Convert EM power into milli-Watts first */
 			rcu_read_lock();


