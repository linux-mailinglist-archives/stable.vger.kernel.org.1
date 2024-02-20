Return-Path: <stable+bounces-21305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5DC85C842
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE6F281B73
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEFE151CD8;
	Tue, 20 Feb 2024 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2dmgp/iS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1814A4E6;
	Tue, 20 Feb 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464002; cv=none; b=XGEqtx75TlbtccS/DOn/oDPceR/Upm1NQneTxmc6M9sfNE8QRrXotbCHorBMTO4Lv9HVbA8m9c/vIl/PrprRz+bRHxqfFhduMfTPuGv+xDQ2TXbDUQCmJoUAeKo4zX76kSBn6ZqKOw6Zfp70E3FPJGaYL0+OMto2g5wnLFiMwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464002; c=relaxed/simple;
	bh=nz715QnJIERJSSvAZj7KyRNAycUhm3lF+BfvQVbwQ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BClzg7HjTbPBWcFaV0VkD+x4MM23bUkLY4m+Lhyj23waxW5p1uGZmXvrWzUPkCgTstTKUCiGXlu6LyrXD0yu8m19CTsmm95B99WN2RLHkSKjqprk6qZ/vYp5ZvF1ipPHqyaxr3HhgCaQxTI7xmk4mhxyUQosz10VfDn+a6NS7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2dmgp/iS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7B8C433C7;
	Tue, 20 Feb 2024 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464001;
	bh=nz715QnJIERJSSvAZj7KyRNAycUhm3lF+BfvQVbwQ5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2dmgp/iSz3qYwg+hinJZyBkKoUdLwPiSydTHzBd95pP7QJUS8NJZY4bocUrnyo7dV
	 mlGoRT0IwHHEoQ+cSwnW+cd7xKMNf3IRgc5f08f5hR3jZZuLxYyIFCHQKTvNPHOnMS
	 FHogvmTdiPTs4JHOI9vAManP5V8Rkvbcxd++WuYs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Van Patten <timvp@google.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 221/331] ASoC: SOF: IPC3: fix message bounds on ipc ops
Date: Tue, 20 Feb 2024 21:55:37 +0100
Message-ID: <20240220205644.677703986@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

From: Curtis Malainey <cujomalainey@chromium.org>

commit fcbe4873089c84da641df75cda9cac2e9addbb4b upstream.

commit 74ad8ed65121 ("ASoC: SOF: ipc3: Implement rx_msg IPC ops")
introduced a new allocation before the upper bounds check in
do_rx_work. As a result A DSP can cause bad allocations if spewing
garbage.

Fixes: 74ad8ed65121 ("ASoC: SOF: ipc3: Implement rx_msg IPC ops")
Reported-by: Tim Van Patten <timvp@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://msgid.link/r/20240213123834.4827-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/ipc3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/sof/ipc3.c
+++ b/sound/soc/sof/ipc3.c
@@ -1067,7 +1067,7 @@ static void sof_ipc3_rx_msg(struct snd_s
 		return;
 	}
 
-	if (hdr.size < sizeof(hdr)) {
+	if (hdr.size < sizeof(hdr) || hdr.size > SOF_IPC_MSG_MAX_SIZE) {
 		dev_err(sdev->dev, "The received message size is invalid\n");
 		return;
 	}



