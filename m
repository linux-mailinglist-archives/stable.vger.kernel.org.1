Return-Path: <stable+bounces-221287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D43GbGUo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:21:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC871CA453
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 150F0305E363
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49A24A076;
	Sun,  1 Mar 2026 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou9j+fup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3466246798;
	Sun,  1 Mar 2026 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327892; cv=none; b=RK/QLUGUiNQuaFcMfeAiCtDzMsoTXAmnAq1ivrQfKlDF+Bukvmny8stKli80gaJtYNYeFuBzoZLsoyp46vt7FpAYEizfRlCUFlQmDJ3yMADRKLoAMjLv1OqzhOhQxESrwqkps/nexozpwrqqDhhLmM7IV/fc1YF23aufhXpgNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327892; c=relaxed/simple;
	bh=kVXojag/5Ms9A+eLOFjtSAVAB7L27XM3BQmtkkBY+sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oX9AHTatisOXumvj957CPI6nAu214TOcWtsa6c7X8UOOmDv8YPWGFAPwkIRqTrUuj2zpBjB0JNAd8YN+H2hcNJOL1rDf3nF++/JMNXrEP/st33JZedp7kwYtGTxTFsBx/G78T4V39F/Nu14fWeZT4hVkc9DY6zfNO+2khSCMmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou9j+fup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F8AC19421;
	Sun,  1 Mar 2026 01:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327891;
	bh=kVXojag/5Ms9A+eLOFjtSAVAB7L27XM3BQmtkkBY+sU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ou9j+fupsW5rmKl8T/CFHtFEogBV8A6yn50iX8hR229X3OZZQnEUh1VbmiEktDIfZ
	 DtV2frriQhSo6X7d5+Tqq/ouXgyyf4n4/i/LghxHVheLVl2beiFXDcnUq9U0lTnZ9w
	 0ZljX8YYJttt3+n/4A6OFDrwrJIs6aEfagScqN4WQSEhjPHLf1uM8bXji9gsapgFyH
	 t8FhmEn6yL9jn6jxe02zgY2XHkmPrC6Ue9B+so+EEgz3IhzCpkCduAxrM7Ru+BQGyZ
	 131H0QeqKUdtzLAT+4GrsRzhPh2Fh39FDc7ypzcFZagR+zC5ayPlUA9vZewG5X6Iuz
	 IwgWRkaccUJEQ==
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
Subject: FAILED: Patch "ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:18:09 -0500
Message-ID: <20260301011809.1672320-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221287-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: BBC871CA453
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a653820700b81c9e6f05ac23b7969ecec1a18e85 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Wed, 17 Dec 2025 16:39:39 +0200
Subject: [PATCH] ASoC: SOF: ipc4-topology: Correct the allocation size for
 bytes controls

The size of the data behind of scontrol->ipc_control_data for bytes
controls is:
[1] sizeof(struct sof_ipc4_control_data) + // kernel only struct
[2] sizeof(struct sof_abi_hdr)) + payload

The max_size specifies the size of [2] and it is coming from topology.

Change the function to take this into account and allocate adequate amount
of memory behind scontrol->ipc_control_data.

With the change we will allocate [1] amount more memory to be able to hold
the full size of data.

Fixes: a382082ff74b ("ASoC: SOF: ipc4-topology: Add support for TPLG_CTL_BYTES")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20251217143945.2667-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 221e9d4052b8f..4272d84679ac1 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2855,22 +2855,41 @@ static int sof_ipc4_control_load_bytes(struct snd_sof_dev *sdev, struct snd_sof_
 	struct sof_ipc4_msg *msg;
 	int ret;
 
-	if (scontrol->max_size < (sizeof(*control_data) + sizeof(struct sof_abi_hdr))) {
-		dev_err(sdev->dev, "insufficient size for a bytes control %s: %zu.\n",
+	/*
+	 * The max_size is coming from topology and indicates the maximum size
+	 * of sof_abi_hdr plus the payload, which excludes the local only
+	 * 'struct sof_ipc4_control_data'
+	 */
+	if (scontrol->max_size < sizeof(struct sof_abi_hdr)) {
+		dev_err(sdev->dev,
+			"insufficient maximum size for a bytes control %s: %zu.\n",
 			scontrol->name, scontrol->max_size);
 		return -EINVAL;
 	}
 
-	if (scontrol->priv_size > scontrol->max_size - sizeof(*control_data)) {
-		dev_err(sdev->dev, "scontrol %s bytes data size %zu exceeds max %zu.\n",
-			scontrol->name, scontrol->priv_size,
-			scontrol->max_size - sizeof(*control_data));
+	if (scontrol->priv_size > scontrol->max_size) {
+		dev_err(sdev->dev,
+			"bytes control %s initial data size %zu exceeds max %zu.\n",
+			scontrol->name, scontrol->priv_size, scontrol->max_size);
+		return -EINVAL;
+	}
+
+	if (scontrol->priv_size < sizeof(struct sof_abi_hdr)) {
+		dev_err(sdev->dev,
+			"bytes control %s initial data size %zu is insufficient.\n",
+			scontrol->name, scontrol->priv_size);
 		return -EINVAL;
 	}
 
-	scontrol->size = sizeof(struct sof_ipc4_control_data) + scontrol->priv_size;
+	/*
+	 * The used size behind the cdata pointer, which can be smaller than
+	 * the maximum size
+	 */
+	scontrol->size = sizeof(*control_data) + scontrol->priv_size;
 
-	scontrol->ipc_control_data = kzalloc(scontrol->max_size, GFP_KERNEL);
+	/* Allocate the cdata: local struct size + maximum payload size */
+	scontrol->ipc_control_data = kzalloc(sizeof(*control_data) + scontrol->max_size,
+					     GFP_KERNEL);
 	if (!scontrol->ipc_control_data)
 		return -ENOMEM;
 
-- 
2.51.0





