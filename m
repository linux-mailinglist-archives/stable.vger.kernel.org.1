Return-Path: <stable+bounces-232412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE6mIM8AzGkoNQYAu9opvQ
	(envelope-from <stable+bounces-232412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:13:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 198F736E3AF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEB75308E4B2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4170301471;
	Tue, 31 Mar 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mvOXKF6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B862FE042;
	Tue, 31 Mar 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976680; cv=none; b=jjbs9+hWGMowroHRotexgQ0tgQguwOWZOIDS7W8d5GWye9MUj6zND+ZD1aaCHakJTl4FRk4HIHQUSZvVoVok2KGocgy7zIKrc1GVsL99WlLVhBRXKlA3k/ApRsmu69ngiX9aAwe78Nd4UjyLVZX7wVhx38YQ9n/aqLbCHXDit0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976680; c=relaxed/simple;
	bh=fzSI70kT9r1o3NJzUrcoF+d+VspSwqUqDuBSIsgV/zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSETXESpUG2Pf3N9eMF6hIqnLQHTZeS0jzXbgHSXXXTL3zt+b6cs/FB7fAo54keVyBO1Rt/z2euUWZsWTDwQJERVOXW3YOZ6d+6AoTejNTyh9NvMfVmYLO4dKKbQRSrEiLs3Imdt3BaBgb3w2gGzRnubndAc4bJeYagw7GKoaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mvOXKF6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A182C19423;
	Tue, 31 Mar 2026 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976680;
	bh=fzSI70kT9r1o3NJzUrcoF+d+VspSwqUqDuBSIsgV/zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvOXKF6H3YpU/1Sn35Os3QZm7F95PA8f/9cir0puxbEDYVDfbkRUQq2iGnKK8R8do
	 oOgd14fBe+LEswYMznaWfAL7DphCWFxaNTd9g9JuExqGVH1aLLITT27a5lyawbcYyR
	 F5l0VFCeKLP2OVcVBCCu8eI2QaZqtI+2tJzrWfXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Nepomnyashih <sdl@nppct.ru>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 186/309] ALSA: firewire-lib: fix uninitialized local variable
Date: Tue, 31 Mar 2026 18:21:29 +0200
Message-ID: <20260331161800.306959322@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232412-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,nppct.ru:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 198F736E3AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Nepomnyashih <sdl@nppct.ru>

commit bb120ad57def62e3f23e3d999c5fbed11f610993 upstream.

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
Link: https://patch.msgid.link/20260316191824.83249-1-sdl@nppct.ru
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/firewire/amdtp-stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1179,7 +1179,7 @@ static void process_rx_packets(struct fw
 	struct pkt_desc *desc = s->packet_descs_cursor;
 	unsigned int pkt_header_length;
 	unsigned int packets;
-	u32 curr_cycle_time;
+	u32 curr_cycle_time = 0;
 	bool need_hw_irq;
 	int i;
 



