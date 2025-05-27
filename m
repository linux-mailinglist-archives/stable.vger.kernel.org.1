Return-Path: <stable+bounces-147813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57846AC594A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F554A7FB2
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2F28001F;
	Tue, 27 May 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JvSXhOZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6F1DFF0;
	Tue, 27 May 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368513; cv=none; b=giBZkiyKq6KJVfva0Q3gFsofP8kHj39x0L9A1QAj3qb6HIJ+62r/w6D72VXHR6hxI/KkZfkmS8EeT4AINfGLPgXx1hpODPTXCjTV1J7d+tWMPIewMcEsedkTxEFIuVf8M5rptGfid9mEBG4Mu5sBI5Uxqe96q7sBgSxDMeO+TVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368513; c=relaxed/simple;
	bh=jqQh9kIVBb2L5ofcRP0wauEXmrepd2OOvHbldnNJAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjU9vbAVX31jcfazPrW6jm5IROsq+ljAVk5nH7UycVSpcphc4rw55bdPHxkgkF7e+7W58XvuJi+qcutEKRsOqIB2WSBYX0BAjQFEEJ41pmIBRPC2CqEKzD1KzwyxnK7R1USvjxEjeDE/LCALGQnTEWgLvAw5hCasHU7gYnY3ovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JvSXhOZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473A9C4CEEA;
	Tue, 27 May 2025 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368512;
	bh=jqQh9kIVBb2L5ofcRP0wauEXmrepd2OOvHbldnNJAgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvSXhOZvY6XMg3UDczu/+3A6qkNjXp16eJ3/1X7nyyxVwuA939W+WWMMe3dm8K3ji
	 BPps5+xXWDa7VAAB0suSp+edAF/zWBgYGWQEdfM8IArDSVp5LlqGI5TPJajzQtBCoS
	 nq1Gw30E1HMU61dmpdJJoMggRBc794iZDrizPJ4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.14 730/783] ASoC: SOF: ipc4-pcm: Delay reporting is only supported for playback direction
Date: Tue, 27 May 2025 18:28:47 +0200
Message-ID: <20250527162542.851521376@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit 98db16f314b3a0d6e5acd94708ea69751436467f upstream.

The firmware does not provide any information for capture streams via the
shared pipeline registers.

To avoid reporting invalid delay value for capture streams to user space
we need to disable it.

Fixes: af74dbd0dbcf ("ASoC: SOF: ipc4-pcm: allocate time info for pcm delay feature")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Link: https://patch.msgid.link/20250509085951.15696-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/ipc4-pcm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -797,7 +797,8 @@ static int sof_ipc4_pcm_setup(struct snd
 
 		spcm->stream[stream].private = stream_priv;
 
-		if (!support_info)
+		/* Delay reporting is only supported on playback */
+		if (!support_info || stream == SNDRV_PCM_STREAM_CAPTURE)
 			continue;
 
 		time_info = kzalloc(sizeof(*time_info), GFP_KERNEL);



