Return-Path: <stable+bounces-70512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C492E960E81
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CEB1C22FE5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23791C57B3;
	Tue, 27 Aug 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CFk8ZUE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B315F41B;
	Tue, 27 Aug 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770154; cv=none; b=Us3vVFVQfhKkq0uwve/uG/HTRl+qoXVJRK2T3LsA2+dFN/pXAvaxlndav9bepqz8VlpnJph4ZJ06FpcRckZFC57srdAx004rvl6pMLbN85EGf8yOkQMAprHZ6RVhOXcHREq9XZCrRDxh6yYU5aRz39ZNRpYEaox3oyWF2UA4fkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770154; c=relaxed/simple;
	bh=ruGoTRpUgkefRMmAFuiv29HVbzQJuXqbJ1kIXujK4yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlPpU/2Q+TRm4Mo0Jlty9dOJyufBCRBNYMbwe+IRXpTBWRY59QXQrt9yViD2qbc+4clYoPD4XkXd0J5J56zMoLwhxrlV7OfjySKgFUwMcnNb5msDgQiLJmUo39rxBh77Nrxik7s6B0AU90xoh7i9O5fSVJLR8Qj+TOA8lOBrIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CFk8ZUE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03712C4AF13;
	Tue, 27 Aug 2024 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770154;
	bh=ruGoTRpUgkefRMmAFuiv29HVbzQJuXqbJ1kIXujK4yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFk8ZUE+mdtKnijziHoSinlSq9coi0XtWFHUVtrLW2YxSZdu1uOrc0zhoX2t0UdOb
	 ctRkQou3fGqoAYJwAJMlLa89/3a3Rlxr3z+fIlci50xyEEgh6AZlp3fogPXhtSkHRs
	 WVjvNw5JnXcio2J5pDturu1epkkc2z2sxQ6YdKhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 143/341] ASoC: SOF: ipc4: check return value of snd_sof_ipc_msg_data
Date: Tue, 27 Aug 2024 16:36:14 +0200
Message-ID: <20240827143848.861502985@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 2bd512626f8ea3957c981cadd2ebf75feff737dd ]

snd_sof_ipc_msg_data could return error.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20231129122021.679-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index 1b09496733fb8..81d1ce4b5f0cd 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -629,7 +629,14 @@ static void sof_ipc4_rx_msg(struct snd_sof_dev *sdev)
 			return;
 
 		ipc4_msg->data_size = data_size;
-		snd_sof_ipc_msg_data(sdev, NULL, ipc4_msg->data_ptr, ipc4_msg->data_size);
+		err = snd_sof_ipc_msg_data(sdev, NULL, ipc4_msg->data_ptr, ipc4_msg->data_size);
+		if (err < 0) {
+			dev_err(sdev->dev, "failed to read IPC notification data: %d\n", err);
+			kfree(ipc4_msg->data_ptr);
+			ipc4_msg->data_ptr = NULL;
+			ipc4_msg->data_size = 0;
+			return;
+		}
 	}
 
 	sof_ipc4_log_header(sdev->dev, "ipc rx done ", ipc4_msg, true);
-- 
2.43.0




