Return-Path: <stable+bounces-60895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70093A5E2
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7BAB20517
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6759F158862;
	Tue, 23 Jul 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvUzQuST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C01157A4F;
	Tue, 23 Jul 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759371; cv=none; b=lkluJ/OGoD/u6J8iB7QtpKLkITV0Te882U60iQPOtMn+Hqa3P0G7suvRp73a+XaA2+G67sGTaxq5Y4JaMp0pfQhrHQl8vCE1AffiflP9oMaLbYhdtuB865BoY01xy0B0/WEEGCZsS6uS98GWLiC5c4WofUTA0xPWZlCy+xeKiXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759371; c=relaxed/simple;
	bh=azEYriXkMdquOW9xTWWs2kqzyYOanGb0xpPuxFX+G1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swSupo46eaDDKb5SBv+r9NguQCcoJmd1orEjpxhB8d+sbAakkc54CUxw2BsPYy+6m2D7G2DFms8eCdkL4hfCM9fG7mZbVa7817BfJw7LPQ3JeN9lAoXK1fb7DtKGavsPV/M3t/0IZ6SY4k6MUfkI/WDNmgRBNXbduV6YvPE7b68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvUzQuST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBF6C4AF0B;
	Tue, 23 Jul 2024 18:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759371;
	bh=azEYriXkMdquOW9xTWWs2kqzyYOanGb0xpPuxFX+G1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wvUzQuST+AoH0UGw5aaeImTxG0YZ+qTclv3s46Yq+syFK+1Vqx3FqUbKNfwTNwNal
	 UdvqExj7i7AC3dramvCsauSnBw9L8MwGUblwyT/1pZJ3uUU5xK+2O2xcYVVEyjTZXX
	 84lilsPhls68MfcriR58kRNKbf2QbT/yKrucWwLs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/105] ASoC: SOF: sof-audio: Skip unprepare for in-use widgets on error rollback
Date: Tue, 23 Jul 2024 20:23:39 +0200
Message-ID: <20240723180405.637541902@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
References: <20240723180402.490567226@linuxfoundation.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 6f2a43e3d14f6e31a3b041a1043195d02c54d615 ]

If the ipc_prepare() callback fails for a module instance, on error rewind
we must skip the ipc_unprepare() call for ones that has positive use count.

The positive use count means that the module instance is in active use, it
cannot be unprepared.

The issue affects capture direction paths with branches (single dai with
multiple PCMs), the affected widgets are in the shared part of the paths.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20240612121203.15468-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/sof-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 061ab7289a6c3..b1141f4478168 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -328,7 +328,7 @@ sof_prepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widget
 			if (ret < 0) {
 				/* unprepare the source widget */
 				if (widget_ops[widget->id].ipc_unprepare &&
-				    swidget && swidget->prepared) {
+				    swidget && swidget->prepared && swidget->use_count == 0) {
 					widget_ops[widget->id].ipc_unprepare(swidget);
 					swidget->prepared = false;
 				}
-- 
2.43.0




