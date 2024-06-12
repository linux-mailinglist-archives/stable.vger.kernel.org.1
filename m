Return-Path: <stable+bounces-50323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D8905AC8
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4E2B22746
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC638F98;
	Wed, 12 Jun 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DObALbhi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FE1EB2A
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216679; cv=none; b=tVJPxSHMk2SdncM04uITa5+arUC+Oats2334i7QRZXvp15mbiH5yAOdCFz4qMGAMmiOZYzsn6T9jKql7MdiwfDFJgRVwyoO4fuK0y0J85TUZ3ZoPgSR0ge3Xayf6Xf/uIPISe09WTaewXMhaGt5dn0ulUOhZFjy1oQApxTdcXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216679; c=relaxed/simple;
	bh=7rH5j00R8n2aB0aDPCTsihHBIrcQ7O3PBAS0wmdZbJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ig1W+XwqBgwOF2CzMoxFVFtU8WfHupv6c1atk7H06c8LmR7kdoRQRRDAKH2Nn96RYUMJcu8aYKaB/XC8K8l8O8qJDyWcdibjtBQVua6dK66h8yOcJnCnOyG8g9bOfEWNUGkwhJ68Kg1WvlCrsVI4+GDc68dslLNnMS18pKNIWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DObALbhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E1BC32786;
	Wed, 12 Jun 2024 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718216679;
	bh=7rH5j00R8n2aB0aDPCTsihHBIrcQ7O3PBAS0wmdZbJU=;
	h=Subject:To:Cc:From:Date:From;
	b=DObALbhiHxMhoH39C1NQIdTwlQd2gNfZ363vB9X3pQBPRBchIXF0fip2Rua1GDx7b
	 W+zDmp5EbDNY9PaUdF7H9caKLVG/S1fsezbQWeMY8xCB9CQy4Wx8Qd4yT0c0RbcT8U
	 2gFIK+l9Is8EhOcW0Hk+5Q5U5+PIWd1wesU51V9U=
Subject: FAILED: patch "[PATCH] firmware: qcom_scm: disable clocks if qcom_scm_bw_enable()" failed to apply to 6.6-stable tree
To: j4g8y7@gmail.com,andersson@kernel.org,quic_mojha@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 20:24:36 +0200
Message-ID: <2024061236-vanity-bankbook-d9dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0c50b7fcf2773b4853e83fc15aba1a196ba95966
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061236-vanity-bankbook-d9dc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0c50b7fcf277 ("firmware: qcom_scm: disable clocks if qcom_scm_bw_enable() fails")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c50b7fcf2773b4853e83fc15aba1a196ba95966 Mon Sep 17 00:00:00 2001
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 4 Mar 2024 14:14:53 +0100
Subject: [PATCH] firmware: qcom_scm: disable clocks if qcom_scm_bw_enable()
 fails

There are several functions which are calling qcom_scm_bw_enable()
then returns immediately if the call fails and leaves the clocks
enabled.

Change the code of these functions to disable clocks when the
qcom_scm_bw_enable() call fails. This also fixes a possible dma
buffer leak in the qcom_scm_pas_init_image() function.

Compile tested only due to lack of hardware with interconnect
support.

Cc: stable@vger.kernel.org
Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Link: https://lore.kernel.org/r/20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633a..e8460626fb0c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -569,13 +569,14 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	desc.args[1] = mdata_phys;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
-
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 out:
@@ -637,10 +638,12 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -672,10 +675,12 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -706,11 +711,12 @@ int qcom_scm_pas_shutdown(u32 peripheral)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
-
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];


