Return-Path: <stable+bounces-99904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D2A9E740C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1AB1888854
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6818020C483;
	Fri,  6 Dec 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QvmFGcga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7E20C023;
	Fri,  6 Dec 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498746; cv=none; b=ccTYSbguSgn9O0GRrjwsn9zr87bywBASi8tHq1Ik4urpcncFjOm5zp6whHoj4bD4RVmtvv7LTE3Y7tARYQCQbCMhMzeWIfkUJsYJBkOkQNiFH0AcAsCs4yQPAIh0+N+rQwaMWRW0ug0kNB2/w946awVSl9kEycAOcAHm2JO9wdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498746; c=relaxed/simple;
	bh=XvgIRgoJVNQrmfmCzYD8IcH5KAfIBknFFtdkHDRo6p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfXJAmIiMrxAKxb4sa9KPH9HZpDkTwRPabwP1pYXKYsl0ill6wIvGjk7SLfu76ptaov2CDR5gvq9VMBrlc9BNhLVDrX0ve1E9v0E+0fb/tMw+Gm3ficmxL5jFgPGtrqRZUzw5nP02JXHTbiQG8KioaUSk7V6nb9jSMoAz6/b27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QvmFGcga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D00BC4CEE4;
	Fri,  6 Dec 2024 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498746;
	bh=XvgIRgoJVNQrmfmCzYD8IcH5KAfIBknFFtdkHDRo6p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QvmFGcgakSbKhPgZP5GLZhirOmofxutK8pp1eYs4dlA6XsMwz9keIyxWBEHw3Fdvb
	 g0fP7GJYUnJx9FyFRoB3lqjQxv4FmzQ6RZa6yRDCvgFl07MSUtkZq4Tdsoov3mXp8v
	 d3W5sFtzlN+Phi36k+kMJzI+n3crIT0PKgUAxIZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Umio Yasuno <coelacanth_dream@protonmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 675/676] drm/amd/pm: update current_socclk and current_uclk in gpu_metrics on smu v13.0.7
Date: Fri,  6 Dec 2024 15:38:14 +0100
Message-ID: <20241206143719.738232973@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Umio Yasuno <coelacanth_dream@protonmail.com>

commit 2abf2f7032df4c4e7f6cf7906da59d0e614897d6 upstream.

These were missed before.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3751
Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1725,6 +1725,8 @@ static ssize_t smu_v13_0_7_get_gpu_metri
 	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
 
 	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
 	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
 	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
 	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];



