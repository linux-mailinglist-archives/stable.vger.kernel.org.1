Return-Path: <stable+bounces-65417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877639480E8
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 19:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D251C21D8C
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061E16DED1;
	Mon,  5 Aug 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1K6SQjt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8A15F400;
	Mon,  5 Aug 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880619; cv=none; b=pqRL9imWWN2Gn0IXq5mpLK6iBpLg+J6ZJAvuFiegKjVROh75IK0GquNg8Y/ublh1X3gC+9q6eR1pVhVnZZfKzidmU+BpRqHo4w8IzqDQYr0Ts25OojjzG9aKLnknKgemW2qFLcjSUdZ/4xL1zdKlruTN4CRVV57NoeuRGHjGAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880619; c=relaxed/simple;
	bh=QYW/ByXxs15zy8E3OX+AodlaN05WuichpEps84+m0aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3JNOTOLipVEwQ4u4ZleCXzMNuRR9Zex30Jpos/KdzmcTlvTS5utDyFGP9EALfexBmlLuzNNadDUwaLo23CQOG8VC7FbnAY/F0Y/zEVHedtOiA5xtXs8MaHJGk3tyQYGeG035kdaOjcSfp8R1fl5EdCv2/5WZE4KaSnKh5OBPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1K6SQjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DF8C32782;
	Mon,  5 Aug 2024 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880619;
	bh=QYW/ByXxs15zy8E3OX+AodlaN05WuichpEps84+m0aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1K6SQjtWKJxA3QUhljsljv0TIiFp2TTxCm7XTKB2O2G26MnD+tJclM6JCGJh8XEa
	 56kgcOrh6mH8vcOWLTXFydz7F0eO9mZSxltA0IHtkhlJgnhqjj/QfeF0I1rOfS73FP
	 Bp8X8h0dv/dTXFGYDqFdJAiZ33bPO+Zjg45twwHXoNH+I89awVqWOyq5l+PkoCGyWl
	 RcpOOWE3bukwIQCEhS/ljKpQ/k/tDaSdgJjOgxBNVPnPxCrKVkIs1ymO0vt5e7XHAf
	 vaYPhy/QTpdm6vfz8mPvMvfRDxn7oqqwrHZ0pOtdmD8lRZHTlF0Z4h/UkQVqHvu0t9
	 gfQRLuvDc1jnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 12/16] ALSA: seq: ump: Use the common RPN/bank conversion context
Date: Mon,  5 Aug 2024 13:55:44 -0400
Message-ID: <20240805175618.3249561-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175618.3249561-1-sashal@kernel.org>
References: <20240805175618.3249561-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.3
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a683030606fa5ff8b722a5e28839d19288011ede ]

The UMP core conversion helper API already defines the context needed
to record the bank and RPN/NRPN values, and we can simply re-use the
same struct instead of re-defining the same content as a different
name.

Link: https://patch.msgid.link/20240731130528.12600-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_ports.h       | 14 ++------------
 sound/core/seq/seq_ump_convert.c | 10 +++++-----
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/sound/core/seq/seq_ports.h b/sound/core/seq/seq_ports.h
index b111382f697aa..9e36738c0dd04 100644
--- a/sound/core/seq/seq_ports.h
+++ b/sound/core/seq/seq_ports.h
@@ -7,6 +7,7 @@
 #define __SND_SEQ_PORTS_H
 
 #include <sound/seq_kernel.h>
+#include <sound/ump_convert.h>
 #include "seq_lock.h"
 
 /* list of 'exported' ports */
@@ -42,17 +43,6 @@ struct snd_seq_port_subs_info {
 	int (*close)(void *private_data, struct snd_seq_port_subscribe *info);
 };
 
-/* context for converting from legacy control event to UMP packet */
-struct snd_seq_ump_midi2_bank {
-	bool rpn_set;
-	bool nrpn_set;
-	bool bank_set;
-	unsigned char cc_rpn_msb, cc_rpn_lsb;
-	unsigned char cc_nrpn_msb, cc_nrpn_lsb;
-	unsigned char cc_data_msb, cc_data_lsb;
-	unsigned char cc_bank_msb, cc_bank_lsb;
-};
-
 struct snd_seq_client_port {
 
 	struct snd_seq_addr addr;	/* client/port number */
@@ -88,7 +78,7 @@ struct snd_seq_client_port {
 	unsigned char ump_group;
 
 #if IS_ENABLED(CONFIG_SND_SEQ_UMP)
-	struct snd_seq_ump_midi2_bank midi2_bank[16]; /* per channel */
+	struct ump_cvt_to_ump_bank midi2_bank[16]; /* per channel */
 #endif
 };
 
diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index e90b27a135e6f..a63005da2195d 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -368,7 +368,7 @@ static int cvt_ump_midi1_to_midi2(struct snd_seq_client *dest,
 	struct snd_seq_ump_event ev_cvt;
 	const union snd_ump_midi1_msg *midi1 = (const union snd_ump_midi1_msg *)event->ump;
 	union snd_ump_midi2_msg *midi2 = (union snd_ump_midi2_msg *)ev_cvt.ump;
-	struct snd_seq_ump_midi2_bank *cc;
+	struct ump_cvt_to_ump_bank *cc;
 
 	ev_cvt = *event;
 	memset(&ev_cvt.ump, 0, sizeof(ev_cvt.ump));
@@ -790,7 +790,7 @@ static int paf_ev_to_ump_midi2(const struct snd_seq_event *event,
 }
 
 /* set up the MIDI2 RPN/NRPN packet data from the parsed info */
-static void fill_rpn(struct snd_seq_ump_midi2_bank *cc,
+static void fill_rpn(struct ump_cvt_to_ump_bank *cc,
 		     union snd_ump_midi2_msg *data,
 		     unsigned char channel)
 {
@@ -822,7 +822,7 @@ static int cc_ev_to_ump_midi2(const struct snd_seq_event *event,
 	unsigned char channel = event->data.control.channel & 0x0f;
 	unsigned char index = event->data.control.param & 0x7f;
 	unsigned char val = event->data.control.value & 0x7f;
-	struct snd_seq_ump_midi2_bank *cc = &dest_port->midi2_bank[channel];
+	struct ump_cvt_to_ump_bank *cc = &dest_port->midi2_bank[channel];
 
 	/* process special CC's (bank/rpn/nrpn) */
 	switch (index) {
@@ -887,7 +887,7 @@ static int pgm_ev_to_ump_midi2(const struct snd_seq_event *event,
 			       unsigned char status)
 {
 	unsigned char channel = event->data.control.channel & 0x0f;
-	struct snd_seq_ump_midi2_bank *cc = &dest_port->midi2_bank[channel];
+	struct ump_cvt_to_ump_bank *cc = &dest_port->midi2_bank[channel];
 
 	data->pg.status = status;
 	data->pg.channel = channel;
@@ -924,7 +924,7 @@ static int ctrl14_ev_to_ump_midi2(const struct snd_seq_event *event,
 {
 	unsigned char channel = event->data.control.channel & 0x0f;
 	unsigned char index = event->data.control.param & 0x7f;
-	struct snd_seq_ump_midi2_bank *cc = &dest_port->midi2_bank[channel];
+	struct ump_cvt_to_ump_bank *cc = &dest_port->midi2_bank[channel];
 	unsigned char msb, lsb;
 
 	msb = (event->data.control.value >> 7) & 0x7f;
-- 
2.43.0


