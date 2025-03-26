Return-Path: <stable+bounces-126731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4022CA71B0A
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091183B8D2B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19341F4626;
	Wed, 26 Mar 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GiWdr/0d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624091F4191
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003842; cv=none; b=J0YI0tzS4n9r3EvKOmWmCsR4Ggpl6szkADtmSrByuZy+Q3BTPsOb0x7YmqaM7eZLTfpyR6FC82ccOq8vx8BC80rEV4v6VT/cikU1cYRzEw9LGqTdVStCRGaHsdDM72SRMRm7rqX6Esw3nfbMITMh9azaOcGqEEwnm5ur4e6sL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003842; c=relaxed/simple;
	bh=X7PFlQILV5L9vK7fAEDnxYUOp5AgPbeiuXW47kp79Jg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jNnUeVtvE/ryHLqS8M9F5nIf77Dz5Mz2EDnw1iy6hZeX+4mL2ouyLaa63TpQQXIDswTwhFcHp7DWNnpCjhkkdoIlbTUXiKM0cTbTylwKd94nK1qE3cbTW9ZwILDW39VeQwevLFjanlzcm2uPiJdVakT7g/efXWIfENp6zc788QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiWdr/0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8550EC4CEE2;
	Wed, 26 Mar 2025 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743003841;
	bh=X7PFlQILV5L9vK7fAEDnxYUOp5AgPbeiuXW47kp79Jg=;
	h=Subject:To:Cc:From:Date:From;
	b=GiWdr/0d6F71bsFiMafSUpEN/t3ufZAqS//+oiGdKafkip4p7aiYGBJ26RAKjvdzX
	 w+f5wk2Nt6k39duENmjDeFucam85CxyRI24RpAomBxqPLGhM+gIcAp/QVXtieG3im8
	 RGUuRnZUmARbe4flUtKKzvco8WEuXYo1j4vJnLVk=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: Add missing PCIe supplies to RockPro64" failed to apply to 5.15-stable tree
To: dsimic@manjaro.org,chris@z9.de,didi.debian@cknow.org,heiko@sntech.de,helgaas@kernel.org,pgwipeout@gmail.com,vincenzopalazzodev@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 26 Mar 2025 11:42:29 -0400
Message-ID: <2025032629-election-startle-0fcc@gregkh>
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
git cherry-pick -x ffcef3df680c437ca33ff434be18ec24d72907c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032629-election-startle-0fcc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


