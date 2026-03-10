Return-Path: <stable+bounces-223944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK12Ocj8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58A24A204
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5743163AA8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BD2D24B7;
	Tue, 10 Mar 2026 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv6hZFwd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7A2BF3E2;
	Tue, 10 Mar 2026 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141079; cv=none; b=Np3cK+w0YVxJHsdXqXUg/3nodqBWZv0xGpyANOsV2PMzPxbNzks86qSbD4pQOcPmDfyuWjFLjXeYdpbvDgQzbFzFhZT2J4pGWCnISix80zJWPDv8JELLrDwrc4LPgqHkbvgALPtfYSxltFIb+GxtgljGYmeGhI3DU9wjAL0WcH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141079; c=relaxed/simple;
	bh=/xCk9wZoKz4PDUZYFlsBWww20E1X06K9mUbR6l1Aqgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVTiEUbLLejz56uesOYjo4q1+duWHzmceO6qvU/A19VQOsIcwqB7YlBIMbxdGkTzgIdOyQiB6YH8BooMA2ZZfdvzAJjD2+be6XM2YbPISsXwehF19BT9b3ourPHAPNyUE6UYYVErw+s7smm+l6A3jcpAWZN4ntbmjHhmFBzOFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv6hZFwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4DAC2BC9E;
	Tue, 10 Mar 2026 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141079;
	bh=/xCk9wZoKz4PDUZYFlsBWww20E1X06K9mUbR6l1Aqgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uv6hZFwdq1mDVWu9XQxrEGWV1YQWaKcUHkDgJP6v9N7F9MF0p4KBR99V00qByeVMR
	 OSeb3+pNsGTm1JcErrDCPlvtQ0hy4ydKzsB4ciDnir500s/pNM3MnBd6msgmT33+je
	 1Qoa5/SdRr6s+DEXyHQX94nHQ5YjexVgK9PgiTut/nzFqXD6Uxk2bhr+G3wHfO9gmE
	 SI83qj1SlMEgePJWiLhgIjLHCgzVPIBPl7nTCkYl8rAV89Fk9gJXH8wROrLAxYe5wd
	 SwwIVuiMvx1dPV8l4TUGjG90qyZt3qGU10Wh06B8eNJkqvRAXqd1HyOHLLLerIKjKK
	 tP4njKrvFOVAw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 079/311] ALSA: usb: qcom: Correct parameter comment for uaudio_transfer_buffer_setup()
Date: Tue, 10 Mar 2026 07:02:06 -0400
Message-ID: <6a8dc0a9f5b35a8fb708eeeaa580569a2a4053ea.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B58A24A204
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223944-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 1d6452a0ce78cd3f4e48943b5ba21d273a658298 ]

At fixing the memory leak of xfer buffer, we forgot to update the
corresponding comment, too.  This resulted in a kernel-doc warning
with W=1.  Let's correct it.

Fixes: 5c7ef5001292 ("ALSA: qc_audio_offload: avoid leaking xfer_buf allocation")
Link: https://patch.msgid.link/20260226154414.1081568-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/qcom/qc_audio_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index cfb30a195364a..297490f0f5874 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1007,7 +1007,7 @@ static int enable_audio_stream(struct snd_usb_substream *subs,
 /**
  * uaudio_transfer_buffer_setup() - fetch and populate xfer buffer params
  * @subs: usb substream
- * @xfer_buf: xfer buf to be allocated
+ * @xfer_buf_cpu: xfer buf to be allocated
  * @xfer_buf_len: size of allocation
  * @mem_info: QMI response info
  *
-- 
2.51.0


