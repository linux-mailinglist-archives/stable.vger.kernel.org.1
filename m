Return-Path: <stable+bounces-119210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE9A424EA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA03B6EC3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84C207E13;
	Mon, 24 Feb 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ksDyBwqU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE9156F44;
	Mon, 24 Feb 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408692; cv=none; b=ba2Qo2RmqN+IpQExrkMEK4IN/n996GqZGnVBapahHXf5aNMOfpUBSyQRmQ87aKJuzYaGnvZIkryryc2S+vD04+HkBoT6oC5LGfu5gJGvNDJ/tmxgv+zEK5MQZ5EhcLQonSc8tsDxj4v+J9Or0G/jHrYt590bkce2TedWF3yyw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408692; c=relaxed/simple;
	bh=qJgL3RK7ny/nfuQMmQIM8BPzVBYFiogsP1Y6REmqQnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUYwCN+fUvVNV4TOmQljvHzhMqo/Xxx8gAYnJw7Tp1HcApwueIubcMoPv0bQs2GgyaCLgw0v5AMSQ4nSU5Jk2a/AIBSjpTF4jsoVxvNAJBgu7ymyiUuCzrDGmOiieJw1c/pEulCFXJYiQa16tNfqs/Roh4SFWGRFbvVDVXOS+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ksDyBwqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E8EC4CED6;
	Mon, 24 Feb 2025 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408691;
	bh=qJgL3RK7ny/nfuQMmQIM8BPzVBYFiogsP1Y6REmqQnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksDyBwqUJ47V3o9X8L0OYznrtok52XjL+DAdikBWFv46B6xd2zMX+Jg/1BH/bgYP0
	 khZ26TskgDBzRj5LOjKNVWhB1PnDpp2RnrGnqSQI0I6FJwhPWznmg6X+XgDr2Hu1Ex
	 36z9YALeYZW1+akLR3HhoawBbYVsxHo9ahx66FC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Curtis Malainey <cujomalainey@chromium.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 133/154] ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
Date: Mon, 24 Feb 2025 15:35:32 +0100
Message-ID: <20250224142612.257744393@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
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

commit 46c7b901e2a03536df5a3cb40b3b26e2be505df6 upstream.

The spcm->stream[substream->stream].substream is set during open and was
left untouched. After the first PCM stream it will never be NULL and we
have code which checks for substream NULLity as indication if the stream is
active or not.
For the compressed cstream pointer the same has been done, this change will
correct the handling of PCM streams.

Fixes: 090349a9feba ("ASoC: SOF: Add support for compress API for stream data/offset")
Cc: stable@vger.kernel.org
Reported-by: Curtis Malainey <cujomalainey@chromium.org>
Closes: https://github.com/thesofproject/linux/pull/5214
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
Link: https://patch.msgid.link/20250205135232.19762-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/pcm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -511,6 +511,8 @@ static int sof_pcm_close(struct snd_soc_
 		 */
 	}
 
+	spcm->stream[substream->stream].substream = NULL;
+
 	return 0;
 }
 



