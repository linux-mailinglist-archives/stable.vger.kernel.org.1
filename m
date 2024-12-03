Return-Path: <stable+bounces-96226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835739E16E8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D971659F8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98F1DE3C9;
	Tue,  3 Dec 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J2LXj6mL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6621DE4D7
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217134; cv=none; b=PCH3TXwAk7HS669nYq3aUl35ZOf4xtfc9BBLlUb2UULzpSdnjzkAKOH2MRu9pzG6ncempgr9EIo1HBrpNQI0qeMDSREclu03BwnatBkxI1J5v29solc44ZEb0js2TCnAxLB7jGh9I0gDKFruBZoVeN5ulwHyZZ0uuDLd9Jbp1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217134; c=relaxed/simple;
	bh=bkvzxHu15w3aiPOpfYNaCFKvCEdch1/YPTg6sVl6JDM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GfE4f2++wAGUo5rmUo5yCrFytFu5Q8p0rfJFbuuO818ORv0Jo5LbzqSrD1nfAWvbaOaSXM2CBalUf/xcJUBsiJI+wjwXH1/l+KPOrF+MVLVNJzO/L+c23kDW0xv+YxZtYHG00MC/3JYUxm46qvvHnWmLsAHo2AG7Jv6V67IgjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J2LXj6mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21102C4CECF;
	Tue,  3 Dec 2024 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217133;
	bh=bkvzxHu15w3aiPOpfYNaCFKvCEdch1/YPTg6sVl6JDM=;
	h=Subject:To:Cc:From:Date:From;
	b=J2LXj6mLKvh/lTvdskTkZKk4mwcs3kKa/oAXnLcBVxUMWDAQ4Zsmz7XveQC3MeX2N
	 GqpDl/DCvfcwHLgU2pQ2DDjWABXNo5GV5ez/H9X948hdIXYsVPO/Q0rm3zDYG+peWM
	 whUrwTsGD/bxtLrGMmguqZCQfUVzay8OAGbkaZc8=
Subject: FAILED: patch "[PATCH] ARM: dts: omap36xx: declare 1GHz OPP as turbo again" failed to apply to 5.15-stable tree
To: andreas@kemnade.info,khilman@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 10:12:10 +0100
Message-ID: <2024120309-bonehead-okay-3641@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 96a64e9730c2c76cfa5c510583a0fbf40d62886b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120309-bonehead-okay-3641@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 96a64e9730c2c76cfa5c510583a0fbf40d62886b Mon Sep 17 00:00:00 2001
From: Andreas Kemnade <andreas@kemnade.info>
Date: Fri, 18 Oct 2024 23:47:27 +0200
Subject: [PATCH] ARM: dts: omap36xx: declare 1GHz OPP as turbo again

Operating stable without reduced chip life at 1Ghz needs several
technologies working: The technologies involve
- SmartReflex
- DVFS

As this cannot directly specified in the OPP table as dependecies in the
devicetree yet, use the turbo flag again to mark this OPP as something
special to have some kind of opt-in.

So revert commit
5f1bf7ae8481 ("ARM: dts: omap36xx: Remove turbo mode for 1GHz variants")

Practical reasoning:
At least the GTA04A5 (DM3730) has become unstable with that OPP enabled.
Furthermore nothing enforces the availability of said technologies,
even in the kernel configuration, so allow users to rather opt-in.

Cc: Stable@vger.kernel.org
Fixes: 5f1bf7ae8481 ("ARM: dts: omap36xx: Remove turbo mode for 1GHz variants")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://lore.kernel.org/r/20241018214727.275162-1-andreas@kemnade.info
Signed-off-by: Kevin Hilman <khilman@baylibre.com>

diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
index c3d79ecd56e3..c217094b50ab 100644
--- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
@@ -72,6 +72,7 @@ opp-1000000000 {
 					 <1375000 1375000 1375000>;
 			/* only on am/dm37x with speed-binned bit set */
 			opp-supported-hw = <0xffffffff 2>;
+			turbo-mode;
 		};
 	};
 


