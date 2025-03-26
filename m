Return-Path: <stable+bounces-126729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5BDA71B10
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C1618982AE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8691F460D;
	Wed, 26 Mar 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4W0V3cO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A52747B
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003836; cv=none; b=Wsp4xSTfLEw0D+f2QUtDbCiFTP1/owCsYy6qJYYHriiqVyrxnwrZkAV17YlMBa7gqCweZb0li9Rl+ivmSU5iSS0x22H17JxBJhoAJU3Ezs2VYfxvBn+vesMW/YTMNnx1fcEWADfHiquQz1dRBTU+NMdfQp9An3DrHoGo26TSdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003836; c=relaxed/simple;
	bh=hIc+tdIfQT0s7dTy/yCt0y4LrbBGmjc8vlzQgU6enVs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mLiJhjC3tBvwX7/dcNCUnUGk4PNy4s8v9lxO73jtg5V9HzjL8tTFvZPF7ZTrbyFk/2DK71akFJlBzf+mQuFrjASpHBd8id8xFornJc/Q42rpB9YRY3EbKomQ8DcM3+iATIxUcp+hS4Y9M0lAlX/sgY16irY6Bvdh0WRiiuM7sLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4W0V3cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E416EC4CEE2;
	Wed, 26 Mar 2025 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743003836;
	bh=hIc+tdIfQT0s7dTy/yCt0y4LrbBGmjc8vlzQgU6enVs=;
	h=Subject:To:Cc:From:Date:From;
	b=h4W0V3cOaWXeWlDs5O2BQuut1VRw1yeDRHKcNo1Aez0UyQCrLMKf09djYiKhq+ca3
	 zZsYqBecASpJyawMC+K8H+ueFD8XnQyG4bxJOVqe9FbwCR4PKWAew7L1OFRLFVpdA9
	 P1/a26gPPLsl1BJJsriik52416ocbdXHKHrR7plI=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: Add missing PCIe supplies to RockPro64" failed to apply to 6.1-stable tree
To: dsimic@manjaro.org,chris@z9.de,didi.debian@cknow.org,heiko@sntech.de,helgaas@kernel.org,pgwipeout@gmail.com,vincenzopalazzodev@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 26 Mar 2025 11:42:28 -0400
Message-ID: <2025032628-fiction-upcoming-5d09@gregkh>
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
git cherry-pick -x ffcef3df680c437ca33ff434be18ec24d72907c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032628-fiction-upcoming-5d09@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffcef3df680c437ca33ff434be18ec24d72907c2 Mon Sep 17 00:00:00 2001
From: Dragan Simic <dsimic@manjaro.org>
Date: Sun, 2 Mar 2025 19:48:04 +0100
Subject: [PATCH] arm64: dts: rockchip: Add missing PCIe supplies to RockPro64
 board dtsi

Add missing "vpcie0v9-supply" and "vpcie1v8-supply" properties to the "pcie0"
node in the Pine64 RockPro64 board dtsi file.  This eliminates the following
warnings from the kernel log:

  rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy regulator
  rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy regulator

These additions improve the accuracy of hardware description of the RockPro64
and, in theory, they should result in no functional changes to the way board
works after the changes, because the "vcca_0v9" and "vcca_1v8" regulators are
always enabled. [1][2]  However, extended reliability testing, performed by
Chris, [3] has proven that the age-old issues with some PCI Express cards,
when used with a Pine64 RockPro64, are also resolved.

Those issues were already mentioned in the commit 43853e843aa6 (arm64: dts:
rockchip: Remove unsupported node from the Pinebook Pro dts, 2024-04-01),
together with a brief description of the out-of-tree enumeration delay patch
that reportedly resolves those issues.  In a nutshell, booting a RockPro64
with some PCI Express cards attached to it caused a kernel oops. [4]

Symptomatically enough, to the commit author's best knowledge, only the Pine64
RockPro64, out of all RK3399-based boards and devices supported upstream, has
been reported to suffer from those PCI Express issues, and only the RockPro64
had some of the PCI Express supplies missing in its DT.  Thus, perhaps some
weird timing issues exist that caused the "vcca_1v8" always-on regulator,
which is part of the RK808 PMIC, to actually not be enabled before the PCI
Express is initialized and enumerated on the RockPro64, causing oopses with
some PCIe cards, and the aforementioned enumeration delay patch [4] probably
acted as just a workaround for the underlying timing issue.

Admittedly, the Pine64 RockPro64 is a bit specific board by having a standard
PCI Express slot, allowing use of various standard cards, but pretty much
standard PCI Express cards have been attached to other RK3399 boards as well,
and the commit author is unaware ot such issues reported for them.

It's quite hard to be sure that the PCI Express issues are fully resolved by
these additions to the DT, without some really extensive and time-consuming
testing.  However, these additions to the DT can result in good things and
improvements anyway, making them perfectly safe from the standpoint of being
unable to do any harm or cause some unforeseen regressions.

These changes apply to the both supported hardware revisions of the Pine64
RockPro64, i.e. to the production-run revisions 2.0 and 2.1. [1][2]

[1] https://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
[2] https://files.pine64.org/doc/rockpro64/rockpro64_v20-SCH.pdf
[3] https://z9.de/hedgedoc/s/nF4d5G7rg#reboot-tests-for-PCIe-improvements
[4] https://lore.kernel.org/lkml/20230509153912.515218-1-vincenzopalazzodev@gmail.com/T/#u

Fixes: bba821f5479e ("arm64: dts: rockchip: add PCIe nodes on rk3399-rockpro64")
Cc: stable@vger.kernel.org
Cc: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc: Peter Geis <pgwipeout@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Tested-by: Chris Vogel <chris@z9.de>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Tested-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://lore.kernel.org/r/b39cfd7490d8194f053bf3971f13a43472d1769e.1740941097.git.dsimic@manjaro.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 47dc198706c8..51c6aa26d828 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -673,6 +673,8 @@ &pcie0 {
 	num-lanes = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_perst>;
+	vpcie0v9-supply = <&vcca_0v9>;
+	vpcie1v8-supply = <&vcca_1v8>;
 	vpcie12v-supply = <&vcc12v_dcin>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";


