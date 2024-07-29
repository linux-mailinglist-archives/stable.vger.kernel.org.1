Return-Path: <stable+bounces-62385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88B93EF03
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CBC1F2120B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F712A177;
	Mon, 29 Jul 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nzzJxm/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C07126F2A
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239434; cv=none; b=Zo7J0A5JXOxdpc2PwJ9YiFZz/eCC/nqSVAhsJpcvMYKPM6AONC+rO2mEicNITGOvn9YQ3OJgDOhoJBhJfW2qNl9zQc+fJwoRQ8Bh3yBYy7WGyoz3786oK92inq+v48oxlnf8jNVxSXmvIBMkGroTikeOHaM8UeYrJc1oiFasCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239434; c=relaxed/simple;
	bh=PhUfpc7Qs7WDsXZTbZPtdcWHKH1MzlYeops3zYmc7FM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hljA405Ow0Q5WibWYL9Ah6bvIJIEg/jsz4+pFPa+zHlnOw02EuZL1p7e8MChJuJAiSw88sNeHOCbBrHhaqehrpeF8SUQDNwnZaCrn8NimU/W1x1IymN7U+qA84Bjm/XmTWZ9MGEnVt/TvHMSbzDGSZlQ/al+azOwjYzNvIiJG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nzzJxm/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FE1C32786;
	Mon, 29 Jul 2024 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239434;
	bh=PhUfpc7Qs7WDsXZTbZPtdcWHKH1MzlYeops3zYmc7FM=;
	h=Subject:To:Cc:From:Date:From;
	b=nzzJxm/iqgbM0uFOSbSJxkc7l2xwO5iOxCWccYcnOKKz+ubczfSdbxLfFvcuFJDFk
	 VadEUzWjOth+u7m9NzLDBn0hP7WB4r802k+2VAp4RV+mlbhbzDyCXC92hKjdfH2aRe
	 JkbNhYuYaFlW54B6ng0FKg3Zya+RFDpgehl6tRPc=
Subject: FAILED: patch "[PATCH] ipv4: fix source address selection with route leak" failed to apply to 4.19-stable tree
To: nicolas.dichtel@6wind.com,dsahern@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:50:23 +0200
Message-ID: <2024072923-veteran-backless-4326@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 6807352353561187a718e87204458999dbcbba1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072923-veteran-backless-4326@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

680735235356 ("ipv4: fix source address selection with route leak")
eba618abacad ("ipv4: Add fib_nh_common to fib_result")
0af7e7c128eb ("ipv4: Update fib_table_lookup tracepoint to take common nexthop")
b75ed8b1aa9c ("ipv4: Rename fib_nh entries")
faa041a40b9f ("ipv4: Create cleanup helper for fib_nh")
e4516ef65490 ("ipv4: Create init helper for fib_nh")
331c7a402358 ("ipv4: Move IN_DEV_IGNORE_ROUTES_WITH_LINKDOWN to helper")
8373c6c84e67 ("ipv4: Define fib_get_nhs when CONFIG_IP_ROUTE_MULTIPATH is disabled")
544fe7c2e654 ("net/mlx5e: Activate HW multipath and handle port affinity based on FIB events")
724b509ca023 ("net/mlx5: Add multipath mode")
10a193ed78ad ("net/mlx5: Expose lag operations in header file")
bb19ad0d8d49 ("net/mlx5: Use unsigned int bit instead of bool as a struct member")
97417f6182f8 ("net/mlx5e: Fix GRE key by controlling port tunnel entropy calculation")
d9ee0491c2ff ("net/mlx5e: Use dedicated uplink vport netdev representor")
025380b20dc2 ("net/mlx5e: Use single argument for the esw representor build params helper")
958246664043 ("net/mlx5: Handle LAG FW commands failure gracefully")
7c34ec19e10c ("net/mlx5: Make RoCE and SR-IOV LAG modes explicit")
292612d68c4e ("net/mlx5: Rename mlx5_lag_is_bonded() to __mlx5_lag_is_active()")
eff849b2c669 ("net/mlx5: Allow/disallow LAG according to pre-req only")
3b5ff59fd851 ("net/mlx5: Adjustments for the activate LAG logic to run under sriov")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6807352353561187a718e87204458999dbcbba1b Mon Sep 17 00:00:00 2001
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Wed, 10 Jul 2024 10:14:27 +0200
Subject: [PATCH] ipv4: fix source address selection with route leak

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

CC: stable@vger.kernel.org
Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20240710081521.3809742-2-nicolas.dichtel@6wind.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f669da98d11d..8956026bc0a2 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2270,6 +2270,15 @@ void fib_select_path(struct net *net, struct fib_result *res,
 		fib_select_default(fl4, res);
 
 check_saddr:
-	if (!fl4->saddr)
-		fl4->saddr = fib_result_prefsrc(net, res);
+	if (!fl4->saddr) {
+		struct net_device *l3mdev;
+
+		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);
+
+		if (!l3mdev ||
+		    l3mdev_master_dev_rcu(FIB_RES_DEV(*res)) == l3mdev)
+			fl4->saddr = fib_result_prefsrc(net, res);
+		else
+			fl4->saddr = inet_select_addr(l3mdev, 0, RT_SCOPE_LINK);
+	}
 }


