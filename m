Return-Path: <stable+bounces-125015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82971A6923C
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2851B6185A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703151B3934;
	Wed, 19 Mar 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1S2GI1N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6081E0B86;
	Wed, 19 Mar 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394892; cv=none; b=tIMKIblKBsUIGO8qbmqN0NJl9EcESydZjM+wJNFGvlAk4LHXVAjErsmHn3mle5yww4VLDmGJAM1djQjkPi2Wlh5R8NWcJVCeDThR10TSOyjhGz2X5bLufVkq/WmA38gky3ug6jydZqgmcU9dixTVCkBfHe7YKUg6yTfTkvTUUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394892; c=relaxed/simple;
	bh=iLR2EddhRiEpkxcWj3/95EO+yt5Xb3hQUPgQ8kH/vGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJBq09vQyUd/JxuPItPf5zMQfZ3EbF+LjgGyYNYsLlA2f8kUEsvGs2M7btXwdBwquHOGFphHbL+D0ryY/gcg0aPN4t78Na2I2o7VLYIr4OljytxfElmFD5uG6QPbRAMEIoKGiDY2s0l4qd18MOr0pzQXqVE5ZkrA6EBifTwO55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1S2GI1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D6BC4CEE8;
	Wed, 19 Mar 2025 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394892;
	bh=iLR2EddhRiEpkxcWj3/95EO+yt5Xb3hQUPgQ8kH/vGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1S2GI1NPWfOataGqw0xGklqXrmN+tJi1KcA2fM+7wsnT1biI2MuefkQ0uuu5H3xX
	 Ub5QDugHsTuU7TDZAUt8cxifVerpcETlFJOfySfx0vtjdJRKM+xmPY4+8DENI7OQ2h
	 F0fpvoj7PXhU5guyKcevugnzG0/8rARLzMPrNoGs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 095/241] thermal/cpufreq_cooling: Remove structure member documentation
Date: Wed, 19 Mar 2025 07:29:25 -0700
Message-ID: <20250319143030.073226455@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lezcano <daniel.lezcano@linaro.org>

[ Upstream commit a6768c4f92e152265590371975d44c071a5279c7 ]

The structure member documentation refers to a member which does not
exist any more. Remove it.

Link: https://lore.kernel.org/all/202501220046.h3PMBCti-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501220046.h3PMBCti-lkp@intel.com/
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/20250211084712.2746705-1-daniel.lezcano@linaro.org
[ rjw: Minor changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/cpufreq_cooling.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 280071be30b15..6b7ab1814c12d 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -57,8 +57,6 @@ struct time_in_idle {
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
  * @em: Reference on the Energy Model of the device
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
  * @policy: cpufreq policy.
  * @cooling_ops: cpufreq callbacks to thermal cooling device ops
  * @idle_time: idle time stats
-- 
2.39.5




