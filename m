Return-Path: <stable+bounces-225678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EaVF4NYuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:22:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD029FC2E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5CE3074E34
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829DA3E9F70;
	Mon, 16 Mar 2026 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="VB46iteS"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539113E5EE4
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688719; cv=none; b=DERcl9BE1jQC/HgJoILzWMbnXYJG4vJhI8YtAxn14tM3LOES+MnSyEOo0vAZ1ZKZKcCu3Q4on4KxnB9sqS/8XNi0aXd5izkwcyHyXtfExOmp3PcWBczv/pYduj7UCZB0ryl04I/4ehzbg7/H77bW+s4vUB+0gbMgCVNG0P9F1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688719; c=relaxed/simple;
	bh=jBFaxbPcLumDJmvk7B4IVWigww+k8VYarEk03GTGXsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llJXwIxa2H+PTZlDcNBGDDubu8D9f032U3P0WpC94k5KqdDPP9FiAr8uoI9LLi6zL40+WLE8ihmSJyJUdEALK4OcFTMEzgNIL7rdHP+3U9PxbeP3qZ31Cm4vZU3xTzd+gqn1L8qW0S7DaC4gUrbPHvwtuNl1OmJwZY6pLjN2GcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=VB46iteS; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 29DC01C0F6E
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 22:18:31 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1773688709; x=
	1774552710; bh=jBFaxbPcLumDJmvk7B4IVWigww+k8VYarEk03GTGXsQ=; b=V
	B46iteS6WkxLnDzVO6g6NXj/cLrNrhNYClGqSp9GmNST3w2DAfsCdlMxd6ABz/mY
	6jQmtPLDNenLT5cZAugPEyoGd9AzOYdpgJNWbOCfigP80pmQULuMCxS+w/CBNZYb
	GPPa6wZIMIEsLfhM58yQNOVit4v4V3iaNOoIjoMVkI=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5hMrMtbgOa0z for <stable@vger.kernel.org>;
	Mon, 16 Mar 2026 22:18:29 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id BACD21C0EE6;
	Mon, 16 Mar 2026 22:18:28 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: firewire-lib: fix uninitialized local variable
Date: Mon, 16 Mar 2026 19:18:22 +0000
Message-ID: <20260316191824.83249-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nppct.ru:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nppct.ru:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225678-lists,stable=lfdr.de];
	DMARC_NA(0.00)[nppct.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdl@nppct.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nppct.ru:dkim,nppct.ru:email,nppct.ru:mid]
X-Rspamd-Queue-Id: B0CD029FC2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to commit d8dc8720468a ("ALSA: firewire-lib: fix uninitialized
local variable"), the local variable `curr_cycle_time` in
process_rx_packets() is declared without initialization.

When the tracepoint event is not probed, the variable may appear to be
used without being initialized. In practice the value is only relevant
when the tracepoint is enabled, however initializing it avoids potential
use of an uninitialized value and improves code safety.

Initialize `curr_cycle_time` to zero.

Fixes: fef4e61b0b76 ("ALSA: firewire-lib: extend tracepoints event including CYCLE_TIME of 1394 OHCI")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---

 sound/firewire/amdtp-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index e97721f80f65..8e70da850fac 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1164,7 +1164,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
 	struct pkt_desc *desc = s->packet_descs_cursor;
 	unsigned int pkt_header_length;
 	unsigned int packets;
-	u32 curr_cycle_time;
+	u32 curr_cycle_time = 0;
 	bool need_hw_irq;
 	int i;
 
-- 
2.43.0


