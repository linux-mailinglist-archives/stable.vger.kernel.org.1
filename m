Return-Path: <stable+bounces-96225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120C9E16E6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57825286312
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87C1DE3C8;
	Tue,  3 Dec 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsdO2Ll8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791C1D6182
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217130; cv=none; b=h2gqf//4gh2Nomgc82nFqKJsqGvbCk8xjhJHJ9YFQmsWfSVU8Z1Yt8zOqRNRCJrcBjmCKcYvUA2eqx5Ptun6WxOllCCoiTCf5qskGwF+Yks0APkMzAhNvMh9L9zSu8NkxCzhuLn0IoLQqz0tRkcUqv5x+gAL/NU0X0V7vYJHbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217130; c=relaxed/simple;
	bh=iUZU00RXfAgJsWzYP3Ikxi91Xw0mIU2LEE1AboLPfo4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S8OD/+3F8Foxt/ijdFQwfC6Icx9Bf0ereWSYeUGZkv5f590eBOoLOSWR06HnUxO/xYpqwc0MET2SuycSVTGZG6LcEL4udYuCEoxm6U3Gf2dkjmqaDkqbNnjlEYZ4F12WVYfbd04z7LnWHSm9DX+lreatp9KLXs7qtmFer5C0vKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsdO2Ll8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525D5C4CECF;
	Tue,  3 Dec 2024 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217129;
	bh=iUZU00RXfAgJsWzYP3Ikxi91Xw0mIU2LEE1AboLPfo4=;
	h=Subject:To:Cc:From:Date:From;
	b=dsdO2Ll88TZ1NehkNbKVz5FkrUry9D6dVJErS3Z2rAO/5wkJYuLXs8cqg46XqPMA3
	 P5ju4zVjPeOE6iMDXXZP//agddNSTO/NdP2AjFO4FdDErpx8sOhCZ5h1fJogowYK5f
	 e6ReNXtcuOjvd26brS7ICGc2WzPTerpYkHJiAoSI=
Subject: FAILED: patch "[PATCH] ARM: dts: omap36xx: declare 1GHz OPP as turbo again" failed to apply to 6.1-stable tree
To: andreas@kemnade.info,khilman@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 10:12:06 +0100
Message-ID: <2024120305-twisted-earmark-a4b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 96a64e9730c2c76cfa5c510583a0fbf40d62886b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120305-twisted-earmark-a4b8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


