Return-Path: <stable+bounces-221570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M83K32mo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:37:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F4B1CDBD7
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A6BA303799E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDF296BC1;
	Sun,  1 Mar 2026 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aax7YxzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D425DB1C;
	Sun,  1 Mar 2026 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328605; cv=none; b=ty4tS9eD6dFiRrOP0WxPq68Y5kt7GZy6D1Fmb3vRI/Hr90Yn9Gwe5aje2rebqSe+wES64Jus1mxZz2XHNyjrby8XTN4gJVkmcG7b5joL9Czw8jtKTtroVBVLHj84UxubsJbm9Uoh2JChPzJvapiB44Mz7aziXY/+oR/ajsJx7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328605; c=relaxed/simple;
	bh=7Cfp/4SVUGcIqWMA3vGiYG1fxuEciPnA5xbxttMSn5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuIkNp1zSI2wLFxVFqGBG4cbS2lkZIZxFhdbrUmWN+mbOExK7sX0w+jzVqV76Hm8jfdJ0HG/GfgGKUSCeswNl0KvU1tcB+fyRXwKhpmaeelWFuy88Z802Ewojf+GBj/IcIV0DESP+S+41wUWGxoQ+Cy5lqABoHMyem8Yyij9onM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aax7YxzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B07AC19424;
	Sun,  1 Mar 2026 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328605;
	bh=7Cfp/4SVUGcIqWMA3vGiYG1fxuEciPnA5xbxttMSn5g=;
	h=From:To:Cc:Subject:Date:From;
	b=Aax7YxzQ37WVcZ+iedeAXxePRytm2TkbMR3SBClxu+tli7YyjxQu4Z86OKAL14pWx
	 lr96xOCbo74ITvgPPnEHvovcmycn7m2ceQ+rIlSyXDMf3q4MfeUAdHpH7LkjxC284z
	 S8kH2Iil9QmCB6qmjJjpsWlhQCy9GH6Wef1h1GIobo/VSSjmCyrjkCh9xl2uQpvyPL
	 jezJFbJ2hnK0fXeMtyz1xhgvUkFaTeZs8rtGOcoE9NtQhuDpKQVctgPVy+cBX+jBvV
	 rXrW0wE18l9u16LPDaoAWhvXtKhELuKm/xy8Czf1jbxbdrrw3kF2ra3abcf9pYtQa9
	 a75xtzZco8kUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	peter.ujfalusi@linux.intel.com
Cc: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ASoC: SOF: ipc4-control: If there is no data do not send bytes update" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:30:02 -0500
Message-ID: <20260301013003.1687979-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221570-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 42F4B1CDBD7
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2fa74713744dc5e908fff851c20f5f89fd665fb7 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Wed, 17 Dec 2025 16:39:38 +0200
Subject: [PATCH] ASoC: SOF: ipc4-control: If there is no data do not send
 bytes update

When the bytes control have no data (payload) then there is no need to send
an IPC message as there is nothing to send.

Fixes: a062c8899fed ("ASoC: SOF: ipc4-control: Add support for bytes control get and put")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20251217143945.2667-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ipc4-control.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 976a4794d6100..0a05f66ec7d92 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -412,8 +412,16 @@ static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 	int ret = 0;
 
 	/* Send the new data to the firmware only if it is powered up */
-	if (set && !pm_runtime_active(sdev->dev))
-		return 0;
+	if (set) {
+		if (!pm_runtime_active(sdev->dev))
+			return 0;
+
+		if (!data->size) {
+			dev_dbg(sdev->dev, "%s: No data to be sent.\n",
+				scontrol->name);
+			return 0;
+		}
+	}
 
 	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(data->type);
 
-- 
2.51.0





