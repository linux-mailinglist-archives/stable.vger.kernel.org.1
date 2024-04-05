Return-Path: <stable+bounces-36000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113D899536
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA98B2312F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C8224DC;
	Fri,  5 Apr 2024 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VWQkSTmV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76251803D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298253; cv=none; b=INa4SuQ8BHnQkWD/L8vW15RR7XhvzcmC4i00Tl/yAVKig+/0nVhBTcPctHoBKUwd4WUhauup3XkHcZLbA5kYDfPgBmVNsBiYZ28j7j9K81E4xrQ0s3dvkKeBDi/oDW4h0ucgtkrpgIz761srvrebRGy/iyK2QaX6DFqwXuEvhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298253; c=relaxed/simple;
	bh=RKVO+mp6ji09X77sfxJ7LwtiDrqxpprqPModrvph1Tg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rAllIzWvB9E+B90tq2cqonYpdd8YwNiObrCUJ9uZtvSNqs5jnwQ2qB6FmjYVrgjaE6HqzA+3O10Ndy9fDhWGEtdioKPCAFMMeJYhFShNKwc9mfS9XPCXAkGrhFgxONFGTjjFjUOo1Gp7ncV3PZDqU9q2Jw/FV7qwO3N5+IRTbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VWQkSTmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F10EC433F1;
	Fri,  5 Apr 2024 06:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298253;
	bh=RKVO+mp6ji09X77sfxJ7LwtiDrqxpprqPModrvph1Tg=;
	h=Subject:To:Cc:From:Date:From;
	b=VWQkSTmVAXWqlt5YK4QFJu+Q/ziJPfa8wtyIoXDKAQJw2F/FG126gzUiyy4L9Q23E
	 fb8/+ro4aZEJ2jclhfeWFm8XtM3iT+juNuknOPtTwJ+ok/FWwqPcB5H9o1jMT6xON/
	 lxEih6J05BvW8B7COERB0uJI3ov1HH0ENTN+cin4=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,dianders@chromium.org,luiz.von.dentz@intel.com,robdclark@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:24:09 +0200
Message-ID: <2024040509-hyperlink-tartar-3f06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e12e28009e584c8f8363439f6a928ec86278a106
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040509-hyperlink-tartar-3f06@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e12e28009e584c8f8363439f6a928ec86278a106 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 20 Mar 2024 08:55:52 +0100
Subject: [PATCH] arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as
 broken

Several Qualcomm Bluetooth controllers lack persistent storage for the
device address and instead one can be provided by the boot firmware
using the 'local-bd-address' devicetree property.

The Bluetooth bindings clearly states that the address should be
specified in little-endian order, but due to a long-standing bug in the
Qualcomm driver which reversed the address some boot firmware has been
providing the address in big-endian order instead.

The boot firmware in SC7180 Trogdor Chromebooks is known to be affected
so mark the 'local-bd-address' property as broken to maintain backwards
compatibility with older firmware when fixing the underlying driver bug.

Note that ChromeOS always updates the kernel and devicetree in lockstep
so that there is no need to handle backwards compatibility with older
devicetrees.

Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogdor and lazor dt")
Cc: stable@vger.kernel.org      # 5.10
Cc: Rob Clark <robdclark@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index f3a6da8b2890..5260c63db007 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -944,6 +944,8 @@ bluetooth: bluetooth {
 		vddrf-supply = <&pp1300_l2c>;
 		vddch0-supply = <&pp3300_l10c>;
 		max-speed = <3200000>;
+
+		qcom,local-bd-address-broken;
 	};
 };
 


