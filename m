Return-Path: <stable+bounces-55081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E09154B8
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BDBB27AAF
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56E19E7FF;
	Mon, 24 Jun 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kKEtpchl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1E19E7F3
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247703; cv=none; b=RqDXeVw+Boxv/O7XOacPPbmGjtXBgWERWruDeLqclNQccptNm8GsWjNpie+6vf0wdhgJ7g2ewMtmudDGmOw77TU23xNikejqJTICvOnmEykkLDO9yW9+iVWBH0Hd3XzKP0AnSKOdWdhJz2Yn0LSO4ekY4rsEUH0GbsFOyruLS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247703; c=relaxed/simple;
	bh=p2qlgYfyuBC1pRUzktQY1OafkDJPhxPsroA7kjlV6x8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LtG8BNcS4mzC5WyZvMB/rq0ZBbL1SmDqcIxW99wLNfXhU+Hw+fXdFrehemrmMzhXWcirfZPDfRxj+l5NwGmPLLCiXbvh3xS9kxatImRh5t3woi2Eitzy+va0fJmS3oTg9jMjYxuq2BaiWPLxMhQrDINAFpKaO2+0++F8rN01wMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kKEtpchl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EF5C2BBFC;
	Mon, 24 Jun 2024 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247703;
	bh=p2qlgYfyuBC1pRUzktQY1OafkDJPhxPsroA7kjlV6x8=;
	h=Subject:To:Cc:From:Date:From;
	b=kKEtpchl0JHP5BmOwXx6R4g6yAaJhW+0kawXp8gcB5licWMKzly3Yf6FaINC50nsf
	 0uqSMdP9/VIKd4zAURmZTh7gRwpNbj8SsjMfbyEHf2iBRTxixaBn7ctr/J77hgR3Ue
	 bE+PJJJKOOwGh4Ht5BoCMfRFrktui9RuYcqEQN6s=
Subject: FAILED: patch "[PATCH] i2c: ocores: set IACK bit after core is enabled" failed to apply to 4.19-stable tree
To: grembeter@gmail.com,andi.shyti@kernel.org,grygorii.tertychnyi@leica-geosystems.com,peter@korsgaard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:48:12 +0200
Message-ID: <2024062412-mobster-doable-acc6@gregkh>
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
git cherry-pick -x 5a72477273066b5b357801ab2d315ef14949d402
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062412-mobster-doable-acc6@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a72477273066b5b357801ab2d315ef14949d402 Mon Sep 17 00:00:00 2001
From: Grygorii Tertychnyi <grembeter@gmail.com>
Date: Mon, 20 May 2024 17:39:32 +0200
Subject: [PATCH] i2c: ocores: set IACK bit after core is enabled

Setting IACK bit when core is disabled does not clear the "Interrupt Flag"
bit in the status register, and the interrupt remains pending.

Sometimes it causes failure for the very first message transfer, that is
usually a device probe.

Hence, set IACK bit after core is enabled to clear pending interrupt.

Fixes: 18f98b1e3147 ("[PATCH] i2c: New bus driver for the OpenCores I2C controller")
Signed-off-by: Grygorii Tertychnyi <grygorii.tertychnyi@leica-geosystems.com>
Acked-by: Peter Korsgaard <peter@korsgaard.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 56a4dabf5a38..4ad670a80a63 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -431,8 +431,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 	oc_setreg(i2c, OCI2C_PREHIGH, prescale >> 8);
 
 	/* Init the device */
-	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN);
+	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 
 	return 0;
 }


