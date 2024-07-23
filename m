Return-Path: <stable+bounces-60981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B1693A648
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FB8281D90
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE12158215;
	Tue, 23 Jul 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lUiE4qm/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AB14C5B0;
	Tue, 23 Jul 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759623; cv=none; b=hZBUNxIgALi6jtINybdwrhsS1PJZEU7ocS+MQ63tuL08K7bHH+1oeGUqkzqdoEpb6b8KDLG2nmz+cEUvuzy7tJfDhmHPoAUiMj8jCtU/E65yHQJtcIMkX6gy6mxKVHCXM/WuaZ1xNslQL5IDYgTMFHX6ocVM0Ct8CVNIM7b0UI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759623; c=relaxed/simple;
	bh=WdhNzHJW1WBGPSPLz3TqJbrODUOAP+mKVAvkC36MQNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQGdSK60yzSQsWz4fn9A6msMxWhM3CFrn6hb/FtG/QvScLtaBmAmiNxlPtxYvVzYSloztX/ZMvt2Uo4QChOKFlCKzjqfXhyKR5OOQSu4qDgmdXCIO0/DtXGLqjWxhzN1F2qkSGbCNmR1ynwBqdXdMs4HuT+gTvispapvAGku3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lUiE4qm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F410C4AF0B;
	Tue, 23 Jul 2024 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759623;
	bh=WdhNzHJW1WBGPSPLz3TqJbrODUOAP+mKVAvkC36MQNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUiE4qm//tWAXe3mGB+yz0E9mtVeYXDFhp1P1gjdQM/Ft13QJyr3WcIgEY2q496m0
	 4oeUkoHNVu/12td8EpKoHJvs+d7Nb5VfDz0XjBc3Dg81aUQV/4vAHPGl7Ub/qhfP6n
	 pmZthK420Lcw2Tc0toueOm+J9+0WO9/XEnYdCBsI=
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
Subject: [PATCH 6.6 073/129] ASoC: SOF: sof-audio: Skip unprepare for in-use widgets on error rollback
Date: Tue, 23 Jul 2024 20:23:41 +0200
Message-ID: <20240723180407.604604467@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
References: <20240723180404.759900207@linuxfoundation.org>
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
index 77cc64ac71131..5162625834725 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -488,7 +488,7 @@ sof_prepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widget
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




