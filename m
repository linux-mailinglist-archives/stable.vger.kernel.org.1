Return-Path: <stable+bounces-231842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNNtC6/7y2mwNAYAu9opvQ
	(envelope-from <stable+bounces-231842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:51:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C376E36D471
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1EBA311D95A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9884266A8;
	Tue, 31 Mar 2026 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGxSxCnE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FA33F38A;
	Tue, 31 Mar 2026 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975211; cv=none; b=Yga5mYqpmR8gnewFWIhQnUP847dXhctyHegjBaPMHgba8TydcwyxO+XuFrqOf6glWQoxU6+S1VJExL2DFgJOcG1L6VzotA63NASTpslIeAv+3VVt+X9m37a/X2sbLuehAH67xZKvepZvxjoSt0Y2v5uwrIXf+pdAb6fSTLw5Daw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975211; c=relaxed/simple;
	bh=G/RXOzn0Ze9s7LXBjm3HkA044cOLYUGAHPKlIQBC4wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvNhLm9+UrZRuQ0HeOKQ2JTartVmxror6PcKtRHN/AROZP2gL2qS49G7bQVYA3Xv0SfYuYsHLKuJw8cTy3M7rvowSS9tq+WmXgD+rI6nnyINl3fz3JDw4sR+LGd1z0CtfQJRRveXPFhM1UJqk2N8112Bdv71Pno1NJp3pa2532I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGxSxCnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7765C2BCB1;
	Tue, 31 Mar 2026 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975211;
	bh=G/RXOzn0Ze9s7LXBjm3HkA044cOLYUGAHPKlIQBC4wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGxSxCnE1onqhy/DXqneAxslMB6S4t6tMPT/6hYzzJdWzu/G3tGgzmsXt+vqrQ1jK
	 0zBzr8AGeKTU7CkxeHronjzgHiIhl6t0z6EJD7enQK+4aXIcpJHl7y7/rk73hqgw/r
	 snpy9bpkq6F7A0nbokSp2yiFXPs1lXabuWodgTPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Nepomnyashih <sdl@nppct.ru>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.19 207/342] ALSA: firewire-lib: fix uninitialized local variable
Date: Tue, 31 Mar 2026 18:20:40 +0200
Message-ID: <20260331161806.598794954@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231842-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,nppct.ru:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: C376E36D471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
 



