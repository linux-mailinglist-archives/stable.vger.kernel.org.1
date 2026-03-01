Return-Path: <stable+bounces-222240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHGFCBago2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:10:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7121CD30F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 839EC306FD38
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7892F28FF;
	Sun,  1 Mar 2026 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq6pURcR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58802727FC;
	Sun,  1 Mar 2026 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330387; cv=none; b=IhRH7pUbbiIxeJ3SIZvOL2EN5BohzqS+naJ8lWkMybTSa2A1b998E1tvhVSmlx5XayusQCQ4onM0apmdZRVJC/UtydUU1sIt8ngXJHtjCLNxJl9kCwAkUUPtykiOLuEHxF7qnmaaOsWxpGj8uy7g5ZScMcSjmM4GJheEHIbltPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330387; c=relaxed/simple;
	bh=90FcIs+NjDarGkcvLFbKykf5R+MjETlOlp1l15GHMSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMTGaT92PHZ8mzi0ovQLyC2jYTOezPQ0/k+XOzTV0Vu+439JrW+iPw6CfyCNsvM5dPigttybYYAZK4jKt93NSENHhdwThfkMkvNkDm2DgWXaoWvlod1dIrytT1lSIARQxRkEnxg91GCrYEtl88whgbE2jj66PVqyBBaVW2lDkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq6pURcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54706C2BC86;
	Sun,  1 Mar 2026 01:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330386;
	bh=90FcIs+NjDarGkcvLFbKykf5R+MjETlOlp1l15GHMSQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Mq6pURcRPH16aTlgfeyPEuF/5j4TJFHtIJljDPi2VEDkqq4HG23+NMTexwnIDyM26
	 UM/yrqCtCcaoICCvCSx53MY/sRzmfFRI79WcQmW8e6fdNrNnOFq0242HBR3q6Sd6cz
	 h0bsoGxVy/UBsTNMXSg1rRolOgtMgzzj1FfQRqOIJkq7FmStwmEXx5k/EXnKKuIB6F
	 1/unpegrtmZ5/cibi0o/nxWDVReo7A3Ax7p6S5yxs3d3maxbP1W2MROdya5MqFQBuj
	 EIunGcWqZJ6SmV6IeZWA/KrQL8AROESEB1Qi6yNgeKhSNH31YygBdDTc/G4rz/y2cL
	 Xn6ik6aPtL35Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: prodikeys: Check presence of pm->input_ep82" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 20:59:44 -0500
Message-ID: <20260301015945.1725609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222240-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D7121CD30F
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cee8337e1bad168136aecfe6416ecd7d3aa7529a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Date: Fri, 9 Jan 2026 11:58:08 +0100
Subject: [PATCH] HID: prodikeys: Check presence of pm->input_ep82
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fake USB devices can send their own report descriptors for which the
input_mapping() hook does not get called.  In this case, pm->input_ep82 stays
NULL, which leads to a crash later.

This does not happen with the real device, but can be provoked by imposing as
one.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-prodikeys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 74bddb2c3e82e..6e413df38358a 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -378,6 +378,10 @@ static int pcmidi_handle_report4(struct pcmidi_snd *pm, u8 *data)
 	bit_mask = (bit_mask << 8) | data[2];
 	bit_mask = (bit_mask << 8) | data[3];
 
+	/* robustness in case input_mapping hook does not get called */
+	if (!pm->input_ep82)
+		return 0;
+
 	/* break keys */
 	for (bit_index = 0; bit_index < 24; bit_index++) {
 		if (!((0x01 << bit_index) & bit_mask)) {
-- 
2.51.0





