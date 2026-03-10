Return-Path: <stable+bounces-224239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DimEJgBsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EE224AFBA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C461132EE5D4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9270389479;
	Tue, 10 Mar 2026 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGh4+++6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1DE387361;
	Tue, 10 Mar 2026 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141936; cv=none; b=RAewhnC1hA7mT/g03TBN9CJyMB7TunKbsM2fE7snGFyzktsvPXXhwNl3ueu1xOHyfuIHOd7ThU/ACKpBULW2211IOUm2gmb6kJ21yyFNNI2VQ9a9bxP5kygjAF1Lgyus7Wg/mIFzQ49rufEXbX+uGXhlwV+C6dSuyIzVeXbpxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141936; c=relaxed/simple;
	bh=/xCk9wZoKz4PDUZYFlsBWww20E1X06K9mUbR6l1Aqgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elFVzTL3lcl0CXQtVKmA7tjW9PNEOXquqNYnCFFJtMZAsQbTzgIZLN6GB2ei+spawt7yuSd2lj8Duh+r+HXcXPYN0hL5esHhRFojWsgE46COXjA6wBsOjw6HynUDX3geyt7pi55qg+agtTQqt8i3dqYSHw+ThqUT+vuCi/7NLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGh4+++6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91E0C19423;
	Tue, 10 Mar 2026 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141936;
	bh=/xCk9wZoKz4PDUZYFlsBWww20E1X06K9mUbR6l1Aqgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGh4+++6JFTRUuHnSjswCn9tZ2fKlXODlJ9D72tDutl9E0j0UI+28sHSPcKybxOhx
	 XOGjR5SxUrCjsoSj9OBzn6s1hruYn7XWvw8sj3HLw7zTBFqkXijioUpEs48tarSv6W
	 RMPuEt0+6QckMI/PXO7FFApftv3Cu+dZrUmBHHfhY1EYtLnXakqFFagL5S+KksyH4x
	 WaJCWnzQ3KLBVvuhj8dpRNxyml5AyukLh7uRZ18i/MCQICDr+TmsdIXL4vGeEzm2tp
	 h+DxsFOwerufCTcxxEG2eDssNk6uP2XdM6s8PjAguUJfw0dOBZo091dwp30YoVqn6U
	 Gk12IGoOohbgA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 060/314] ALSA: usb: qcom: Correct parameter comment for uaudio_transfer_buffer_setup()
Date: Tue, 10 Mar 2026 07:15:19 -0400
Message-ID: <d52cc094a0aa7350fa42252ec27c16dbab8233c6.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5EE224AFBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-224239-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
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


