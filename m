Return-Path: <stable+bounces-220508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHSuNyQ5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:51:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E31C652C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD4B5321A3C0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41433CA783;
	Sat, 28 Feb 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE90BElc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC63CA77A;
	Sat, 28 Feb 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300392; cv=none; b=IQEim4zs+7IfVRSNMuqvPlvMq66qXxYU9T+Si7sBubPJ8rOuXf8OxIioRc3R/Su3U2+j+K1byRqTw7JAFF4sfGGXmHUoOkICeus4A9kJLev45u4ISSZrwzmHRV/Q4YF/m9ioi+21ArTagTMCSKvPHKNbglMoDrmCC0COMYyNCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300392; c=relaxed/simple;
	bh=jGjwEs4qfs/Cs+UbuhuSh0oAOAqxAXQEo1nK2ljfwqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKey6zbZse9TwIsbcXki9zJvMTnBejhqwrBZ2x9EV+m//78wd4Oc1xvRGeKp1uXm5k5O1ikXpTA74HBNjtge8V1+Ye0n6m8IzBjTORs71XlN6t8oG3U0bcEJaW5v6UbGSTJCeiGFr/Uv54q9QFXhhTjr9ZF5N/5PjNz6j8AMCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE90BElc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D6FC19424;
	Sat, 28 Feb 2026 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300392;
	bh=jGjwEs4qfs/Cs+UbuhuSh0oAOAqxAXQEo1nK2ljfwqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fE90BElcAfb4gQFBobEV+N8sJjudJ91gAi8dDIKZMp53rQurjde4SBtFubiMusqdG
	 zLuEpvE48NOKsJrcPCCNJSBzZAVwwQZJMV+PBfclbwagWNMJB+bkL5WDsE5ZeZkHls
	 Cbqcq9uLHItoFr5jiR+lqpsdaEtkaGaUUFgIDVBgFCNDFoNGaR3+rkOk+ZC/3JQE1K
	 LzQlnmrUsLj+oa0c5XgdGII5OGOCXc7e5raTta3fICi+hndCSfTkdVpaUjUCdTkX+8
	 TmKPBKJntJ55gL2+QZeuQYoazoSx5esqbXfi7c/xtky/MVGJs4+BK4njSWZeZYCXKg
	 romrPIvDzhf0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 429/844] ALSA: usb-audio: Update the number of packets properly at receiving
Date: Sat, 28 Feb 2026 12:25:42 -0500
Message-ID: <20260228173244.1509663-430-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220508-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 655E31C652C
X-Rspamd-Action: no action

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit cf044e44190234a41a788de1cdbb6c21f4a52e1e ]

At receiving the packets from the implicit feedback source, we didn't
update ctx->packets field but only the ctx->packet_size[] data.
In exceptional cases, this might lead to unexpectedly superfluous data
transfer (although this won't happen usually due to the nature of USB
isochronous transfer).  Fix it to update the field properly.

Link: https://patch.msgid.link/20260216141209.1849200-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 8f9313857ee9d..27ade2aa16f5a 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -481,6 +481,7 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 
 		/* copy over the length information */
 		if (implicit_fb) {
+			ctx->packets = packet->packets;
 			for (i = 0; i < packet->packets; i++)
 				ctx->packet_size[i] = packet->packet_size[i];
 		}
-- 
2.51.0


