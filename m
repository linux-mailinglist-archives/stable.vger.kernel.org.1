Return-Path: <stable+bounces-224220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NA/JGoBsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:32:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E32224AF4F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91BC530E76AB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3753876AD;
	Tue, 10 Mar 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECrKZNmk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B8137B413;
	Tue, 10 Mar 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141918; cv=none; b=sumCSLK/a/b0aChB7/1CnmeE5TQX5B+MY+DIIdq50SwrCjuKEnv9S8f4DclcXVTz0+1+r0Cu01utMKJhD2psKHHSxRQs5zFBT2XRszlAj5oNfxPiFQRawwktPPPa6NixOrCbzFuOXV7oop1u5z1FmwIbBC8dfuragmYhVi++ATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141918; c=relaxed/simple;
	bh=yqh7JGGMxvpdrvXR8rumBeiIRzEtizOiULGdjg571l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/6DO1YAo686H4Qx9wCNDxVvaOl5uBmOxZZtnWlhvSrXv7aXYAZbQP0z7hbYpGrrmc5k5myfPd0Xhc4aEcr1N0etR1njF8GGwngr6nPgzrgF5HFRIy0DvuOnRHtSyyZzxrUV2hEhacu9q6Ls4SeofDG4+4bfFfyFQN8d/A8fKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECrKZNmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1BCC2BC9E;
	Tue, 10 Mar 2026 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141917;
	bh=yqh7JGGMxvpdrvXR8rumBeiIRzEtizOiULGdjg571l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECrKZNmk/BYNIWyhI1acUEYupf4ilrhNkmUAhzMJm6OtxkNHkFGtqh85o03XoCrEq
	 7f6npVAkP4v2ObMS1TkGN1mTDGwmCSltlMuXpz1nstn3kLJe5cG6RlZkhbPCLkoApr
	 3eFSQGd/dYKnrrJMjvIg4F6iMpnJidIObr0XqfGcwsTCZJ5Ia0bs1h/HteJRnitEPS
	 rfrJyWM6CQ77m7txNX8Qv8D4z5x5LDkMGF25QZQweYbEO0744SgBGAaY9K5MAcE2Dk
	 KZn8vqG5xziI8vVWI6pCijFFKS+CrfWSE1IkE7OFussI1w9SV6ezAYtWQoixAGe2VB
	 ytWpmusa0GEYg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 041/314] ALSA: usb-audio: Use inclusive terms
Date: Tue, 10 Mar 2026 07:15:00 -0400
Message-ID: <8d45e4529c6e487b0d84b12767b2056ec076504e.1773141555.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 1E32224AF4F
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
	TAGGED_FROM(0.00)[bounces-224220-lists,stable=lfdr.de];
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

[ Upstream commit 4e9113c533acee2ba1f72fd68ee6ecd36b64484e ]

Replace the remaining with inclusive terms; it's only this function
name we overlooked at the previous conversion.

Fixes: 53837b4ac2bd ("ALSA: usb-audio: Replace slave/master terms")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260225085233.316306-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 173edce027d7b..eff3329d86b7e 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -160,8 +160,8 @@ int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep)
  * This won't be used for implicit feedback which takes the packet size
  * returned from the sync source
  */
-static int slave_next_packet_size(struct snd_usb_endpoint *ep,
-				  unsigned int avail)
+static int synced_next_packet_size(struct snd_usb_endpoint *ep,
+				   unsigned int avail)
 {
 	unsigned int phase;
 	int ret;
@@ -227,7 +227,7 @@ int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep,
 	}
 
 	if (ep->sync_source)
-		return slave_next_packet_size(ep, avail);
+		return synced_next_packet_size(ep, avail);
 	else
 		return next_packet_size(ep, avail);
 }
-- 
2.51.0


