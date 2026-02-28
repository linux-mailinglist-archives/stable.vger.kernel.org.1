Return-Path: <stable+bounces-220930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCj2LZxHo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:53:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB11C7791
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06FD033D42A6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDA943636C;
	Sat, 28 Feb 2026 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjytiZTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05A340A51;
	Sat, 28 Feb 2026 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301277; cv=none; b=eRDjbaYfS2qGN/U8UgCzy2pgWrmyv4XQjAJFsbVcXiqz3jZqjM+orMUzcFIz721kMf1Llwu0eON90HDbW4I1rLs0CcjfBFR7oqnpoHgpTR2ZmwMwUmg5qpoC8PWQ96ietvGeL4fhXuU4gX7JqeclmkjwGEdo1q25GlGhMSVyZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301277; c=relaxed/simple;
	bh=uTqbPw591zXdfTsTtnbae2IXUOtbUZZJRiNlboZWmbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRfpWwgUeb+wxKgoDJwH2ybROSC/13VyU7o2dTKAk/HDLUlAjM8T1tcHgsJvLUpGD26pNYE4iUcrxy612Z9cM+nv0xnX1TLSDF9KejjCSr3uCI7xoqTbTUUf7f5LpNH0fKccqvIRY6oMNr0iD/M8PAWnPnV3Z0CLFswqKEXKv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjytiZTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1719AC19424;
	Sat, 28 Feb 2026 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301277;
	bh=uTqbPw591zXdfTsTtnbae2IXUOtbUZZJRiNlboZWmbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjytiZTIYsYEH9YPzuSt/7FReRETnVdmkLK5IAW2bgoHVTG0uVT8TOVERKij7NLkw
	 xhFeiM89/4vKf9EWSSIwob158rckVsqTApZ7DTfYKRnxWYd3IgXHLtipYAPn+0opyE
	 qYo1WLIjrHw2PxcI5x7+dqnTHlFiB19SWAQtA+RYLQTec3pi4Q2iVUbjPEGx/zzUJZ
	 WnaGOtSCJlc8sPbjRtgd+kXEmDE40JKz4Hou2LjrglESgwBcmpWQirtjlb0Xw4nODU
	 Zw0KkkCugu6wfKePtUuxN6yU1exFEJClCzXYPByOi7iEvYDrAbYswAYHn40HmaTRSl
	 SXCf2314BDdNw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	stable@vger.kernel.org,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 461/752] ASoC: SOF: ipc4-control: If there is no data do not send bytes update
Date: Sat, 28 Feb 2026 12:42:52 -0500
Message-ID: <20260228174750.1542406-461-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
	TAGGED_FROM(0.00)[bounces-220930-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56EB11C7791
X-Rspamd-Action: no action

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 2fa74713744dc5e908fff851c20f5f89fd665fb7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


