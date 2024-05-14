Return-Path: <stable+bounces-44138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB88C516D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3782B216D1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A2139563;
	Tue, 14 May 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kaNv9krT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB71386DD;
	Tue, 14 May 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684462; cv=none; b=JNep78aGzsppI1kMueChnm2rYkHbPIVJJgxEZbmC29YB0wMaNv2P8ZPXxzs+lCzBCaGIIrAX+E3M7UOVQve5nrBjH7P5WanI4IW2Sm5oPfDDPR985gtRadu3RUtGbIJwfZIDazpO5Z6+hjl9H5wdBOdMC2A0LDMtAPCJga+g2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684462; c=relaxed/simple;
	bh=sKb6tflGbRz2F2tPnG//koHusfParXdAIxI5oD6gPtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRchj/LVP9Ub28w+fF8JSW0CMpZH0QApZOwORSCGQ6GKumt92VZDQMK+Aqe8Wct92W5i/fZEiX2dJz0YaLztWikS2wtQcJ/EiOM5/YvDRoPEiQyH2laJAh0C0uSM8/MGYsBpUzoQblPWUPgbFof0mJn72dlPkpB8+kcE2B4tmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kaNv9krT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEA3C2BD10;
	Tue, 14 May 2024 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684462;
	bh=sKb6tflGbRz2F2tPnG//koHusfParXdAIxI5oD6gPtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaNv9krTOih8Hij6kXAUOl4LQqTaZD0Tt945WmLgq2V/nenmWWdlod6civ6LIibpo
	 DleZtwc3mH7y6EcqR0wmsAsRzUctXDiJF3HaOJRb7XCPYS7eU6ahKODadbsQ9bvvi0
	 v6kjEgcLH+ajXPelQDEMJKsk9H5sw8NmgUXYMqH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 044/301] ASoC: Intel: avs: Set name of control as in topology
Date: Tue, 14 May 2024 12:15:15 +0200
Message-ID: <20240514101033.909750312@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 4cbb5050bffc49c716381ea2ecb07306dd46f83a ]

When creating controls attached to widgets, there are a lot of rules if
they get their name prefixed with widget name or not. Due to that
controls ended up with weirdly looking names like "ssp0_fe DSP Volume",
while topology set it to "DSP Volume".

Fix this by setting no_wname_in_kcontrol_name to true in avs topology
widgets which disables unwanted behaviour.

Fixes: be2b81b519d7 ("ASoC: Intel: avs: Parse control tuples")
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240418142621.2487478-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
index 45d0eb2a8e710..141255420c12b 100644
--- a/sound/soc/intel/avs/topology.c
+++ b/sound/soc/intel/avs/topology.c
@@ -1412,6 +1412,8 @@ static int avs_widget_load(struct snd_soc_component *comp, int index,
 	if (!le32_to_cpu(dw->priv.size))
 		return 0;
 
+	w->no_wname_in_kcontrol_name = true;
+
 	if (w->ignore_suspend && !AVS_S0IX_SUPPORTED) {
 		dev_info_once(comp->dev, "Device does not support S0IX, check BIOS settings\n");
 		w->ignore_suspend = false;
-- 
2.43.0




