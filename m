Return-Path: <stable+bounces-204043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C4CE784E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A55023006713
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7933469A;
	Mon, 29 Dec 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MM/vph5G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2333437B;
	Mon, 29 Dec 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025888; cv=none; b=q9vggPAfJsIcQiLMGYK+/QZtdCLZiNXtLiK5vL6W0RKMVRs2O5jKMfy7CRYw/Kk38qiOqcSElYoVxpYqXpj03kp/qVlSsKEHhgRTzBjYPNNZEyhuROPIJ++yaCFveVQ+rqXEsk9KQJX481n7uTHuUnD2wgotEXavGGDPMJDu55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025888; c=relaxed/simple;
	bh=KvCVe2wtbtvAqUDfwny8WdpX1iiMrDhtbzBI1TYhWi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFhGn3p2vZGNlheGDnz5+d0iDaKmEW3KFNDw1Nm4efnU6kSYjfEwomTa2lvdtXQr2vDX7W1rSiJdt4wI8BY9LeD+UW0U1/1kBiyFD10VmaaAKre8ozI6sWzBck+SYvbcuZyOvGhY5HdSudrfz8oQyW6tnXbzyoOFUd+bzVLjoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MM/vph5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE1C116C6;
	Mon, 29 Dec 2025 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025888;
	bh=KvCVe2wtbtvAqUDfwny8WdpX1iiMrDhtbzBI1TYhWi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MM/vph5Gb8bWkWVq6dMT1/5JP0HbVFzxl/5ERfXuwbLSTwkrMrZqHLXjqoXSCJtxg
	 duc6Q1HJfx21BwncebGIwrTvvHQ1yW4zdyZHS9w0f/W91PDxNmRzGxksBOgxw9WJDp
	 3qbPL+NPzPEyZxavhUuyfYFtMOO3HPOSOOmuQ000=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 372/430] ASoC: SOF: ipc4-topology: Convert FLOAT to S32 during blob selection
Date: Mon, 29 Dec 2025 17:12:54 +0100
Message-ID: <20251229160738.013058275@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit 816f291fc23f325d31509d0e97873249ad75ae9a upstream.

SSP/DMIC blobs have no support for FLOAT type, they are using S32 on data
bus.

Convert the format from FLOAT_LE to S32_LE to make sure that the correct
format is used within the path.

FLOAT conversion will be done on the host side (or within the path).

Fixes: f7c41911ad74 ("ASoC: SOF: ipc4-topology: Add support for float sample type")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://patch.msgid.link/20251215120648.4827-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 47959f182f4b..32b628e2fe29 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1843,7 +1843,7 @@ snd_sof_get_nhlt_endpoint_data(struct snd_sof_dev *sdev, struct snd_sof_dai *dai
 	*len = cfg->size >> 2;
 	*dst = (u32 *)cfg->caps;
 
-	if (format_change) {
+	if (format_change || params_format(params) == SNDRV_PCM_FORMAT_FLOAT_LE) {
 		/*
 		 * Update the params to reflect that different blob was loaded
 		 * instead of the requested bit depth (16 -> 32 or 32 -> 16).
-- 
2.52.0




