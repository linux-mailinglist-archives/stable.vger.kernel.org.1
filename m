Return-Path: <stable+bounces-56865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87466924650
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AB3284E00
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF081BE235;
	Tue,  2 Jul 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wpblIFVB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02463D;
	Tue,  2 Jul 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941620; cv=none; b=XQTCMIJSbfvr59LqjbIrLxWyt3fawV/PdW5Yt/lNE6rOWKyvDO8X+KPVmzmb0ncvVSdfPE8kNTOZobYLTpdTcOG0RmOPGG4zdFuIZB0qLMZLiteFIfIMxSTrw7wcOyHGN8W+nTM4eOJXmRsTVofsifpo034GElucfMojOtv7c3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941620; c=relaxed/simple;
	bh=ssPE6u7HICBbmFr4aUrRndaYhrLgKwh5Xo5oF5LWf8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3g+wtuney/Np+8dH3iHIo4tXQZC6CnbnN9HSIlTRBmQVRbHfMoQKLXON08qiVFUJGJrCftkYL6DaBsg7foxpZpsWsttDgSF4VPgFqYDWt32vz1kiBx4vLmKxxuUe2HrA1VEAcHManedH7+CGCftCnyktV0tuyRsiVQo9TMB82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wpblIFVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CBCC116B1;
	Tue,  2 Jul 2024 17:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941620;
	bh=ssPE6u7HICBbmFr4aUrRndaYhrLgKwh5Xo5oF5LWf8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wpblIFVBZFaJ9imacWaNGD7DRcZqPwz1Hz9SbZMi4ODaIRr3EvDfVd5Ho5F9cRgCK
	 Y/w/tkDsOEerQp4Rd40CdX7X3DeJrj7EiDJ4dGrXYRQcVfU+O6KEIPuFabQRsycNeD
	 i+e1KhzwZWc4XeCULpILWyeKzSjiRwRqhrNgSa6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lars Wendler <wendler.lars@web.de>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Peter Jung <ptr1337@cachyos.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1 118/128] Revert "cpufreq: amd-pstate: Fix the inconsistency in max frequency units"
Date: Tue,  2 Jul 2024 19:05:19 +0200
Message-ID: <20240702170230.684573773@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 82590ce3a0d0f26d06b0a70886ca2d444e64acbf which is
commit e4731baaf29438508197d3a8a6d4f5a8c51663f8 upstream.

It causes a regression in kernels older than 6.9.y, so drop it from
here.

Link: https://lore.kernel.org/r/18882bfe-4ca5-495c-ace5-b9bcab796ae5@amd.com
Reported-by: Lars Wendler <wendler.lars@web.de>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Gautham R. Shenoy <gautham.shenoy@amd.com>
Cc: Peter Jung <ptr1337@cachyos.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/amd-pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -424,7 +424,7 @@ static int amd_pstate_set_boost(struct c
 	if (state)
 		policy->cpuinfo.max_freq = cpudata->max_freq;
 	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
+		policy->cpuinfo.max_freq = cpudata->nominal_freq;
 
 	policy->max = policy->cpuinfo.max_freq;
 



