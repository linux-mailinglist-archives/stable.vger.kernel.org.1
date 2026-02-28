Return-Path: <stable+bounces-220931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKZsMZpHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E68A1C7782
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AFFD34DC87C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8809C449EC3;
	Sat, 28 Feb 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMvBhKd6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7633FE27;
	Sat, 28 Feb 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301278; cv=none; b=S+307JoIqHsADKz8EVq/UFNKwZSVysqwCiFzz0qaSJAKlR5cyb9VXk+7Qp/n9QgLgg8sVyJJKIDTIiCMIuxcJPEad2wGw0+f3OGsJy8aC2suFiZEFX4b4rrsWEoR6hRs9xVmfwSsfrRCywazhgHVbGgwjKtKcYPT/cRf5Hv7GNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301278; c=relaxed/simple;
	bh=UWaVPDqbRo1gtc7BSQTRsFfzxzPAkRdrtmZckEQLoDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEoKE7n/blocAGk4+gT++ecbQtbnCOoTB5vgJibicp8ro9cW3JpuHoMmHZ6qNB3ewXGWnbjpaxAfZeZzQa9P8TwIpGls6pwA3llRi4hZZIBnH45l1btJTt09IwjLmnFotTFKTCKLKQXfKE+c6oLdWE0rLXn9InrR7y7WOdZ1eEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMvBhKd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4458BC19423;
	Sat, 28 Feb 2026 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301278;
	bh=UWaVPDqbRo1gtc7BSQTRsFfzxzPAkRdrtmZckEQLoDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMvBhKd6bTd3RkVT28D3josT8yq15Tt1clfHBnxTdxVzr1bUQm962bynHf9WzXPBr
	 pAubbmPQHrFLxcbYjdV0SI27XEeM/9qB3PZtwlQxhVdhhS8uuqmTZsqbACOB8PFTTZ
	 nXboxfJNR8OxVa6L0IyOTBXvTk0EK0RzCAaGlGsQYRzSPa2SSHDu0NHHTBk5Xa3inz
	 STgwqsIKhg6uqUeFTylQjrb+nm7Y2bNMOUuiKG9xK86Db4WHYHR778dY2fsc8jxBSo
	 AQebVKb9YzFIKaeqEqmD778s0swXHsBnic3M3KC6DtZ5kEskDASSE3ug2zpc6+MVxR
	 YhvTAoMPxX1xA==
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
Subject: [PATCH 6.18 462/752] ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls
Date: Sat, 28 Feb 2026 12:42:53 -0500
Message-ID: <20260228174750.1542406-462-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220931-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 3E68A1C7782
X-Rspamd-Action: no action

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit a653820700b81c9e6f05ac23b7969ecec1a18e85 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 32b628e2fe29b..5ca995acaba2e 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2861,22 +2861,41 @@ static int sof_ipc4_control_load_bytes(struct snd_sof_dev *sdev, struct snd_sof_
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


