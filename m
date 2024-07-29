Return-Path: <stable+bounces-62413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E1C93EF8A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F082D1F22B32
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21A9139CEF;
	Mon, 29 Jul 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syAV9rwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347D137776
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240741; cv=none; b=pZDxv5HAR07QIIwgtgU5AJgXEnbVvtlJFR0ZQBKKpOvafmqhBcPfdi8HxJb0kqKkHgT+IxyDGIB5WVRl9YfcFcL2XGPKXgHyEmTFpgmbi5bJBvnMGxy3jloOXDOapweYCAXIcM2zaKhLlu2hv4N41oE71wHQ8A48MjDb+8g2wtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240741; c=relaxed/simple;
	bh=ynD8hY35nBL/oH3NuCbGp174TDjj0tmXGVZsFoGSFrY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dSzCd15naDpIGdM92aVEMJK00ZpbldXwCpHPORE1xHzsp4MktqV45wZhjQb5V9kpPNYfmevbeW+n4j0bBI/xzWMuiJFPiHXhg+WuPMDe7YY9nuOM03x6lk1TzqdJKZGhEMYN0D3onaPgDXDPR8WwGRqxpawiQcNJ0koY0Mgz4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=syAV9rwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6447DC32786;
	Mon, 29 Jul 2024 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722240740;
	bh=ynD8hY35nBL/oH3NuCbGp174TDjj0tmXGVZsFoGSFrY=;
	h=Subject:To:Cc:From:Date:From;
	b=syAV9rwm2uwAMqonkT2OpBY4mcsibu2uJ/cK8qwtYvAB+UsetmFL57eGKpPnHLct5
	 ws32my0J3B5661BjL3wesZ9AatHm6tYHFzN1D7/zlG1/36XcMBo/tuzvA5XKTe6k7s
	 odJirNRVXS0vDLrcRXNWo0eQYIbGfe31XaUOfwZo=
Subject: FAILED: patch "[PATCH] ipv4: fix source address selection with route leak" failed to apply to 5.4-stable tree
To: nicolas.dichtel@6wind.com,dsahern@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 10:12:09 +0200
Message-ID: <2024072909-turbine-disparity-9044@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 6807352353561187a718e87204458999dbcbba1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072909-turbine-disparity-9044@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

680735235356 ("ipv4: fix source address selection with route leak")

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


