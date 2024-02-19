Return-Path: <stable+bounces-20688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B785AB44
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556A8283C22
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CEE482E5;
	Mon, 19 Feb 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nu6cs4ki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4033482EC
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368132; cv=none; b=pLPUOosFRkcJqjbhvIPcI4kICkODU81dLFhrdiT7GECixT8QSIcOPXelifnBf2AtiWiyeCRhRgL3He7DLHY/MIOSZ+5fOmc3ioi1/g3Wgd793Hj+iRKFxsB75M6usitMufnLyaQCM1xFZBpfcMYWUWvkFk7Dp+eSGMItuIm5Mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368132; c=relaxed/simple;
	bh=rTdhU5lbWB5Sv1Y/CDnynLlV7qBOyJkGwbbdA50VK7I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s8CL9oERSvW+NjQFJrHPgu9v/p1XKws+OjTcIKTi9btMxK+zoBFg3nzq4U1Wefldzh5SV75ERKOS0BzL7WfI16O/glUarp6/AcVn81rIKBGq+4eQLMZ7/ZI6F0DTPw9Rl0s+DIC4lYtLt6zxcJ68uOiKdF18/Az8hC/9hTiWXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nu6cs4ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421A9C433F1;
	Mon, 19 Feb 2024 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368132;
	bh=rTdhU5lbWB5Sv1Y/CDnynLlV7qBOyJkGwbbdA50VK7I=;
	h=Subject:To:Cc:From:Date:From;
	b=nu6cs4kiCb/Mw6Rt0bYeQUrj+ulVH9Jsk2Jz4Q4jLD6OyViCgeu6P4uEqShiZlp5f
	 /uQxGf+iieBjBeR29gX41xPZRto0ibvEGhBbsK25/q1pWvCf1YuG0K1ekR4mpH6tp3
	 px0w9lyrzxMjMKzJgIZ2+0p1aTJgSoErLP5JPiRI=
Subject: FAILED: patch "[PATCH] thunderbolt: Fix setting the CNS bit in ROUTER_CS_5" failed to apply to 5.15-stable tree
To: rahimi.mhmmd@gmail.com,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:42:01 +0100
Message-ID: <2024021901-java-rejoice-9b51@gregkh>
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
git cherry-pick -x ec4d82f855ce332de26fe080892483de98cc1a19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021901-java-rejoice-9b51@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ec4d82f855ce ("thunderbolt: Fix setting the CNS bit in ROUTER_CS_5")
d49b4f043d63 ("thunderbolt: Add support for enhanced uni-directional TMU mode")
bdc6660e553a ("thunderbolt: Do not call CLx functions from TMU code")
12a14f2fca32 ("thunderbolt: Move CLx support functions into clx.c")
ef34add89ee4 ("thunderbolt: Check valid TMU configuration in tb_switch_tmu_configure()")
4e7b4955cba1 ("thunderbolt: Move tb_enable_tmu() close to other TMU functions")
20c2fae9dbe3 ("thunderbolt: Move TMU configuration to tb_enable_tmu()")
7d283f4148f1 ("thunderbolt: Get rid of tb_switch_enable_tmu_1st_child()")
701e73a823bb ("thunderbolt: Rework Titan Ridge TMU objection disable function")
826f55d50de9 ("thunderbolt: Drop useless 'unidirectional' parameter from tb_switch_tmu_is_enabled()")
c437dcb18310 ("thunderbolt: Fix a couple of style issues in TMU code")
7ce542219b63 ("thunderbolt: Introduce tb_switch_downstream_port()")
3fe95742af29 ("thunderbolt: Do not touch CL state configuration during discovery")
d31137619776 ("thunderbolt: Use correct type in tb_port_is_clx_enabled() prototype")
d0f1e0c2a699 ("thunderbolt: Add support for receiver lane margining")
b12d2955e732 ("thunderbolt: Add helper to check if CL states are enabled on port")
3846d011403b ("thunderbolt: Pass CL state bitmask to tb_port_clx_supported()")
95f8f1cbc87b ("thunderbolt: Move port CL state functions into correct place in switch.c")
b60e31bf18a7 ("thunderbolt: Add DP OUT resource when DP tunnel is discovered")
9e2e5ea3b28f ("Merge tag 'usb-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec4d82f855ce332de26fe080892483de98cc1a19 Mon Sep 17 00:00:00 2001
From: Mohammad Rahimi <rahimi.mhmmd@gmail.com>
Date: Sat, 27 Jan 2024 11:26:28 +0800
Subject: [PATCH] thunderbolt: Fix setting the CNS bit in ROUTER_CS_5

The bit 23, CM TBT3 Not Supported (CNS), in ROUTER_CS_5 indicates
whether a USB4 Connection Manager is TBT3-Compatible and should be:
    0b for TBT3-Compatible
    1b for Not TBT3-Compatible

Fixes: b04079837b20 ("thunderbolt: Add initial support for USB4")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammad Rahimi <rahimi.mhmmd@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 87e4795275fe..6f798f6a2b84 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -203,7 +203,7 @@ struct tb_regs_switch_header {
 #define ROUTER_CS_5_WOP				BIT(1)
 #define ROUTER_CS_5_WOU				BIT(2)
 #define ROUTER_CS_5_WOD				BIT(3)
-#define ROUTER_CS_5_C3S				BIT(23)
+#define ROUTER_CS_5_CNS				BIT(23)
 #define ROUTER_CS_5_PTO				BIT(24)
 #define ROUTER_CS_5_UTO				BIT(25)
 #define ROUTER_CS_5_HCO				BIT(26)
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index f8f0d24ff6e4..1515eff8cc3e 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -290,7 +290,7 @@ int usb4_switch_setup(struct tb_switch *sw)
 	}
 
 	/* TBT3 supported by the CM */
-	val |= ROUTER_CS_5_C3S;
+	val &= ~ROUTER_CS_5_CNS;
 
 	return tb_sw_write(sw, &val, TB_CFG_SWITCH, ROUTER_CS_5, 1);
 }


