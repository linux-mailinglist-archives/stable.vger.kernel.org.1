Return-Path: <stable+bounces-37288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FDB89C437
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7CB1C228FB
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D3C85C6F;
	Mon,  8 Apr 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04O6B1d5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BF7D414;
	Mon,  8 Apr 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583798; cv=none; b=dD8T73i86iw8fQo68VBR8J4GNRq0rNw3QtYCe4n33MCwcZKN28UjUD2hBEXZ8ffQZ/bwN817rJq9kRFFw3+aBvnvlqXmyOHEJRSWZa3VA/noo1oVUPlT8VGvivdWncfSwXI3yPZIebHEzyYoj1g2/HPzU0pHf8MAxIcoGi1VdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583798; c=relaxed/simple;
	bh=GiyBUYcgj0awTwlQuZYYvUV3jVebOYEG+uLzBrID6ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiBkBq0OQyRRi3lZoLzxCDJ160fJKooy2TnfoceJ+IyQd11cSF0uQYmHHcFbMvRcqEr4K3vAS2Jfa+gzJP5yDe2QSsut3mwz5BxzlXGu/E+dQmk+HeROK5KHgGeQRJ00us4zCHl93W4m088Z67miRwjada/UqtnJGX5gxaMq6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=04O6B1d5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACD7C433C7;
	Mon,  8 Apr 2024 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583798;
	bh=GiyBUYcgj0awTwlQuZYYvUV3jVebOYEG+uLzBrID6ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=04O6B1d5gl9Xq635lHUFyrqg2GDG1iF71TB9Ve825X2K2jH8P0s8Xq3FTrE2FP7W1
	 CLfMa09Cd7KT9ec4yMpk+5YZ6/GKux6TA80hjymO4oCO+oyOvRhx5p//o3Ht1badB8
	 7Ek89zcKbTNFQEpZhfjfcQdRUZWrF8AQ2OcczvJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.8 220/273] ASoC: SOF: ipc4-pcm: Use the snd_sof_pcm_get_dai_frame_counter() for pcm_delay
Date: Mon,  8 Apr 2024 14:58:15 +0200
Message-ID: <20240408125316.225735030@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit 37679a1bd372c8308a3faccf3438c9df642565b3 upstream.

Switch to the new callback to retrieve the DAI (link) frame counter.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240321130814.4412-9-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/ipc4-pcm.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -880,11 +880,12 @@ static snd_pcm_sframes_t sof_ipc4_pcm_de
 	}
 
 	/*
-	 * HDaudio links don't support the LLP counter reported by firmware
-	 * the link position is read directly from hardware registers.
+	 * If the LLP counter is not reported by firmware in the SRAM window
+	 * then read the dai (link) position via host accessible means if
+	 * available.
 	 */
 	if (!time_info->llp_offset) {
-		tmp_ptr = snd_sof_pcm_get_stream_position(sdev, component, substream);
+		tmp_ptr = snd_sof_pcm_get_dai_frame_counter(sdev, component, substream);
 		if (!tmp_ptr)
 			return 0;
 	} else {



