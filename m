Return-Path: <stable+bounces-220223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGlAJO0xo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 026411C5AE5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E61330FAF08
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3444A4E379C;
	Sat, 28 Feb 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbq6Ihyo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9204E3797;
	Sat, 28 Feb 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300129; cv=none; b=b7Jw6bVwoiRIL0KwA+VLTv3g3VjyQTAWiThTYyKqUHV9NUaFAd3YQATDvg+vB3VN3qqA0+ijW5Wh4bg9DZ9luDokr3Mm2alUEml+0x79etIwFzhKx6Btw132WUKnYbRRHa+HN3JK1+n5KvJk0r/iPlkya1Yca7+BrcN0f7DNCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300129; c=relaxed/simple;
	bh=iIt6d5bJBWv/HXppUH7hgW+elfsL6jgbAZ6J2R5Bz/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPGWNH41c4oMBOKdY/zVgcDHuxgWgd9YbKdZy88Me8QH8qeL8OSYd0hsZPu/iVFIfKrYyXiKcRpbbXWWWtL/J7VJvupuundW3UM+qOa5fmvTFjFnWDi60vJSsiGepd6xZf2iane/Va2wA+o7onttKwa6OftYM88a88yzAVM2W1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbq6Ihyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2227C116D0;
	Sat, 28 Feb 2026 17:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300128;
	bh=iIt6d5bJBWv/HXppUH7hgW+elfsL6jgbAZ6J2R5Bz/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbq6Ihyo/DbmQ+SJIhkg2jsBvZxXZY6+XNGo9rBlRihmrSw0WQnKrTCscJcUMRbB8
	 HOm5ZqahRIQawG069ppAQp+IRj0PCkSf4v7NZcWVCfewyRlikEXBU3KjqxKKvBZLQx
	 E4nM4iw/1ez6PvkF6XdX7MG4I0F3Rv4zXSXmUK3LvVKLk6hUBM378Nosl85Vm7zMO8
	 udjL4s/ujwXGH/6mlc1/0Ew4FISP5x8vFNLMCSyfG/lGm8oyGq0Crc5h4MDOGA1hcg
	 I5uILN4P50BLyHOBbaNagMVUyuikCL37IQwopWglNRKY5uPntgIfQe/7QMOlbsm2MN
	 wTR4E40ZsBbdw==
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
Subject: [PATCH 6.19 145/844] ASoC: SOF: ipc4: Support for sending payload along with LARGE_CONFIG_GET
Date: Sat, 28 Feb 2026 12:20:58 -0500
Message-ID: <20260228173244.1509663-146-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220223-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 026411C5AE5
X-Rspamd-Action: no action

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit d96cb0b86d6e8bbbbfa425771606f6c1aebc318e ]

There are message types when we would need to send a payload along with
the LARGE_CONFIG_GET message to provide information to the firmware on
what data is requested.
Such cases are the ALSA Kcontrol related messages when the high level
param_id tells only the type of the control, but the ID/index of the exact
control is specified in the payload area.

The caller must place the payload for TX before calling the set_get_data()
and this payload will be sent alongside with the message to the firmware.

The data area will be overwritten by the received data from firmware.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20251217143945.2667-7-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index a4a090e6724a6..20d723f48fff0 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -15,6 +15,7 @@
 #include "sof-audio.h"
 #include "ipc4-fw-reg.h"
 #include "ipc4-priv.h"
+#include "ipc4-topology.h"
 #include "ipc4-telemetry.h"
 #include "ops.h"
 
@@ -433,6 +434,23 @@ static int sof_ipc4_tx_msg(struct snd_sof_dev *sdev, void *msg_data, size_t msg_
 	return ret;
 }
 
+static bool sof_ipc4_tx_payload_for_get_data(struct sof_ipc4_msg *tx)
+{
+	/*
+	 * Messages that require TX payload with LARGE_CONFIG_GET.
+	 * The TX payload is placed into the IPC message data section by caller,
+	 * which needs to be copied to temporary buffer since the received data
+	 * will overwrite it.
+	 */
+	switch (tx->extension & SOF_IPC4_MOD_EXT_MSG_PARAM_ID_MASK) {
+	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_SWITCH_CONTROL_PARAM_ID):
+	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_ENUM_CONTROL_PARAM_ID):
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 				 size_t payload_bytes, bool set)
 {
@@ -444,6 +462,8 @@ static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 	struct sof_ipc4_msg tx = {{ 0 }};
 	struct sof_ipc4_msg rx = {{ 0 }};
 	size_t remaining = payload_bytes;
+	void *tx_payload_for_get = NULL;
+	size_t tx_data_size = 0;
 	size_t offset = 0;
 	size_t chunk_size;
 	int ret;
@@ -469,10 +489,20 @@ static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 
 	tx.extension |= SOF_IPC4_MOD_EXT_MSG_FIRST_BLOCK(1);
 
+	if (sof_ipc4_tx_payload_for_get_data(&tx)) {
+		tx_data_size = min(ipc4_msg->data_size, payload_limit);
+		tx_payload_for_get = kmemdup(ipc4_msg->data_ptr, tx_data_size,
+					     GFP_KERNEL);
+		if (!tx_payload_for_get)
+			return -ENOMEM;
+	}
+
 	/* ensure the DSP is in D0i0 before sending IPC */
 	ret = snd_sof_dsp_set_power_state(sdev, &target_state);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(tx_payload_for_get);
 		return ret;
+	}
 
 	/* Serialise IPC TX */
 	mutex_lock(&sdev->ipc->tx_mutex);
@@ -506,7 +536,15 @@ static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 			rx.data_size = chunk_size;
 			rx.data_ptr = ipc4_msg->data_ptr + offset;
 
-			tx_size = 0;
+			if (tx_payload_for_get) {
+				tx_size = tx_data_size;
+				tx.data_size = tx_size;
+				tx.data_ptr = tx_payload_for_get;
+			} else {
+				tx_size = 0;
+				tx.data_size = 0;
+				tx.data_ptr = NULL;
+			}
 			rx_size = chunk_size;
 		}
 
@@ -553,6 +591,8 @@ static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 
 	mutex_unlock(&sdev->ipc->tx_mutex);
 
+	kfree(tx_payload_for_get);
+
 	return ret;
 }
 
-- 
2.51.0


