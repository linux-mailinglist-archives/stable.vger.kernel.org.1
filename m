Return-Path: <stable+bounces-220594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCkMEng+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B747C1C6B78
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477F93272217
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06DA3E1504;
	Sat, 28 Feb 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REA176Zf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA148AE0D;
	Sat, 28 Feb 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300477; cv=none; b=Ufw2DnYBi4fGoirN6RqgSMtB0D6ZZKdAG1LWnTw7G7Lsrk30hH+Eb2zf0KQRNDqZbthINCjGLBbtoAL77/f0zTR6XpV/8JC1iaDOy8vYCtlmXNpN+DKVQ0TmxPXXr8Nk636DuY49E6LEugCmfnHS/tA6CoIVdB01NZO2nlLI/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300477; c=relaxed/simple;
	bh=kU/f+89gQX8msH1ELgzNKPQu5/7ZsX59MFBTN+0lF0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/YL1GHVfE9croA0FCPQFRjxRiIQL0Wt7jm7EKuonOdy0mA6XMp07gz6F6QiManJoItyBJjbjmG1O4CVBwyX/0FxL5SGmsKXILEzYAbDxxwmbdvD/ptaCrGr08K61LdTG6f84cpdx8l2+mpdl5oHVPwCiPbMHcnPypE9IW7E80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REA176Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867AEC19425;
	Sat, 28 Feb 2026 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300477;
	bh=kU/f+89gQX8msH1ELgzNKPQu5/7ZsX59MFBTN+0lF0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REA176ZfPPd44zwGwlcnlGu6liHfjKAdY+MUDuFk5CQYEURO8IQpA+EGz1BtwiK9k
	 Pkf5Vxey0q1/rMmF1R23odV4QH2X7ehbG5e4vxGENNoidk3VJMjubrF6Qjx9bAM4zp
	 j62NryKzQ/1dsvWVByIHvhvbOgSUkLbYVFCldN8pXfs+nt+mM82R+SXBZ2bf2uhzVi
	 j9mr5q2nxphp1Wh+QGEDODTCE+MCV/jYxUBnwjabBRGt8AI2ae/jOkz7n+m1QrS2+V
	 iPr90nnB1rHcm8HNRMIxqwXHuHDJsx8p6awzHLho6BDAdxw0L6/gQcKenhRV4aSeFe
	 hdIy8Su6dwyyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 515/844] ASoC: SOF: ipc4-control: Use the correct size for scontrol->ipc_control_data
Date: Sat, 28 Feb 2026 12:27:08 -0500
Message-ID: <20260228173244.1509663-516-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220594-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: B747C1C6B78
X-Rspamd-Action: no action

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit c1876fc33c5976837e4c73719c7582617efc6919 ]

The size of the data behind scontrol->ipc_control_data is stored in
scontrol->size, use this when copying data for backup/restore.

Fixes: db38d86d0c54 ("ASoC: sof: Improve sof_ipc4_bytes_ext_put function")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20251217143945.2667-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 0a05f66ec7d92..80111672c1796 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -66,7 +66,7 @@ static int sof_ipc4_set_get_kcontrol_data(struct snd_sof_control *scontrol,
 		 * configuration
 		 */
 		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
-		       scontrol->max_size);
+		       scontrol->size);
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
 		/* Send the last known good configuration to firmware */
@@ -567,7 +567,7 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 	if (!scontrol->old_ipc_control_data) {
 		/* Create a backup of the current, valid bytes control */
 		scontrol->old_ipc_control_data = kmemdup(scontrol->ipc_control_data,
-							 scontrol->max_size, GFP_KERNEL);
+							 scontrol->size, GFP_KERNEL);
 		if (!scontrol->old_ipc_control_data)
 			return -ENOMEM;
 	}
@@ -575,7 +575,7 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 	/* Copy the whole binary data which includes the ABI header and the payload */
 	if (copy_from_user(data, tlvd->tlv, header.length)) {
 		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
-		       scontrol->max_size);
+		       scontrol->size);
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
 		return -EFAULT;
-- 
2.51.0


