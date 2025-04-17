Return-Path: <stable+bounces-132996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A88EA91977
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B803B19E3FF4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFFA225A37;
	Thu, 17 Apr 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pAstZrX5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB583D994
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886044; cv=none; b=KIbH08gx36wUqRVCkaGhi7chFQqDtj6CafYjNbId0NrsNGIzhZgH82aczs7ha1tu8Y7arLhYRl+CMksuogcU24ahsQc+lWv8mLPh+4CksX0YhOGpIQqYGZFQJyibMHpcri3LM6ReqpodF/63n2ukT7XmVIRW0Ev+g91s17Dc95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886044; c=relaxed/simple;
	bh=AqBgY78qgKXuZvLRujT3zMbxQgjWo8UPTvvanwGRDdM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A9TTE+Gn9tjhtT0InY3k8l/4+0yhnkSXXfFDbvB5JkyOxlKIS7G20UU//i+9/YeM2n/M3EW2WGDzQLjRD+DoVEDJzQBo0/d9/mEAg1iuaArifDdZKcnmWKwMMOOz4axosoGwNGoYNCEwnZYSL0tl2QpSZWPzUq9aeSIkyJPLRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pAstZrX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6712C4CEE4;
	Thu, 17 Apr 2025 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744886044;
	bh=AqBgY78qgKXuZvLRujT3zMbxQgjWo8UPTvvanwGRDdM=;
	h=Subject:To:Cc:From:Date:From;
	b=pAstZrX53RoEAn8jUjt3w22gT6Jm/yLiEc64P7ECbzI6AT6q2WtqAUchHzU/H7tN1
	 evUhmYWEqUo9KN/JYu+QCjwTANkhbtE2s9z+CLZFeaDkQ8vjtWXGbFjFzs2yvp0xlU
	 mli/TZj+U//ZsU8Yq3I+b6KNlPSl+985Iq76gaSw=
Subject: FAILED: patch "[PATCH] net: dsa: mv88e6xxx: fix VTU methods for 6320 family" failed to apply to 6.12-stable tree
To: kabel@kernel.org,andrew@lunn.ch,kuba@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:33:42 +0200
Message-ID: <2025041742-boogieman-power-27fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f9a457722cf5e3534be5ffab549d6b49737fca72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041742-boogieman-power-27fe@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9a457722cf5e3534be5ffab549d6b49737fca72 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Date: Mon, 17 Mar 2025 18:32:44 +0100
Subject: [PATCH] net: dsa: mv88e6xxx: fix VTU methods for 6320 family
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The VTU registers of the 6320 family use the 6352 semantics, not 6185.
Fix it.

Fixes: b8fee9571063 ("net: dsa: mv88e6xxx: add VLAN Get Next support")
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: <stable@vger.kernel.org> # 5.15.x
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-2-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5db96ca52505..06b17c3b2205 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5169,8 +5169,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5217,8 +5217,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,


