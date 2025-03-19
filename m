Return-Path: <stable+bounces-125347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A2A690DA
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC68A2517
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03A421B9F3;
	Wed, 19 Mar 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8wqUrKi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11F1E991B;
	Wed, 19 Mar 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395124; cv=none; b=rq5LzEbGia6UvluK9Q1WsJFUK9DxfudM5wTm3tx/7CburliIkh+4pXi5Rb6DmRVRLmsVe7B1Eq3TL+ekepuzzSVh8as3v1muCgOGeXbfPEQ27KLilIohWyNyyDuQlZxtbrR4DK6G9eASHKbPMvAYLqzdeka4HWheVGjyQ3kOVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395124; c=relaxed/simple;
	bh=726Wnaq3ieaR0xQvNglcb5VBdwaen9hTo2h1K8W/YFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bkl4wC5fb+RFZQps1LpF6YbXKKvi7FC0AwZMZbYNF/WNTG+HNX1g5hgTjqZcEJXseZu8l+HXvTQ7PxLA0PDAMpe8ub8OPACxTMNAnAnO1sdERY8ckkxQXLxsvP1hGAmrrhMuk7BIMccorhXfWNxI3EZy2wbVozwCvOSqCGZV+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8wqUrKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616E8C4CEE4;
	Wed, 19 Mar 2025 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395124;
	bh=726Wnaq3ieaR0xQvNglcb5VBdwaen9hTo2h1K8W/YFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8wqUrKiUyO1B6khcrthKK6gJomy6ofSyEN81MzcUBgNYFHTKUDAWdJzXrui2b5rZ
	 E8jpsLAVWw15xyhN7Su7nTgriOEhJthMrEfob5QdZHs1r0HJu4BWSi+331V/PF+dHG
	 w/dQpqLZKJbKafToPVz69Z7o/nKnHyGoP9r+yi+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 187/231] ASoC: Intel: sof_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()
Date: Wed, 19 Mar 2025 07:31:20 -0700
Message-ID: <20250319143031.453067389@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit 4363f02a39e25e80e68039b4323c570b0848ec66 upstream.

Initialize current_be_id to 0 to handle the unlikely case when there are
no devices connected to a DAI.
In this case create_sdw_dailink() would return without touching the passed
pointer to current_be_id.

Found by gcc -fanalyzer

Fixes: 59bf457d8055 ("ASoC: intel: sof_sdw: Factor out SoundWire DAI creation")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250303065552.78328-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/boards/sof_sdw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -871,7 +871,7 @@ static int create_sdw_dailinks(struct sn
 
 	/* generate DAI links by each sdw link */
 	while (sof_dais->initialised) {
-		int current_be_id;
+		int current_be_id = 0;
 
 		ret = create_sdw_dailink(card, sof_dais, dai_links,
 					 &current_be_id, codec_conf);



