Return-Path: <stable+bounces-247977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOasN9FLB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-247977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:37:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437435539CE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE603189462
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F63FF1DE;
	Fri, 15 May 2026 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqcEr9e3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A23FF1AC;
	Fri, 15 May 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860555; cv=none; b=dhFiIR/i33R7EJCkczLwmmmgv4OQFXXxUD0XC7pseaaLIelZ3Hs1XO5SZLUaB8g5wl0dQV+tgwuglJ7i52qCYzlFPMfy/aAf8g6FDGU4uoDnw9u9wivCscRQSlD+w8h8umQWob/C2HuC+4pE1xILHCj+Vn8ZXdBxFbWIL6cSFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860555; c=relaxed/simple;
	bh=jnZTRx6sw6BXSQdbkpOn856iAirUPtmsGCu8sm3nJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi5h3ClO2q4OQKoohRW7KOcZrlBzT8vDXLNC2Wfftz8uU2+8HM+XOyXKHgQbV63TCzdK6bRHU4kMQ4USMVuYeLPgg/zRYdiK7G4iVqIRLkfRT6DKT+BBV+evNmNKxwu6DS9TEDnfVt8Z76B/jidhtGy8LNPT8aOYNFlE5ohBA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqcEr9e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5BDC2BCB0;
	Fri, 15 May 2026 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860554;
	bh=jnZTRx6sw6BXSQdbkpOn856iAirUPtmsGCu8sm3nJd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqcEr9e3bpr8cORDNC63OCoNqqTEmnif6RoHQmCPEZM04TxwbjznhFlcDxa/if3zY
	 tSedwIpo3zvdQfUwsri6FtiBE7FvJf3V8tJcn6zU1lCvOjUqhq7lxDl9U1FvuvkNS1
	 QvAHj94Iv9dV0/XKErBpIKmJQb1sK1m+4FooWeG0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Lentczner <mark@glyphic.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 107/144] ALSA: seq: Notify client and port info changes
Date: Fri, 15 May 2026 17:48:53 +0200
Message-ID: <20260515154655.975318396@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 437435539CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247977-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,glyphic.com:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b8e49e24cdba27a0810a0988e810e2c68f2033cb ]

It was supposed to be notified when a sequencer client info and a port
info has changed (via SNDRV_SEQ_EVENT_CLIENT_CHANGE and
SNDRV_SEQ_EVENT_PORT_CHANGE event, respectively), and there are
already helper functions.  But those aren't really sent from the
driver so far, except for the recent support of UMP, simply due to the
lack of implementations.

This patch adds the missing notifications at updating the client and
the port info.  The formerly added notification for UMP is dropped
because it's handled now in the port info side.

Reported-by: Mark Lentczner <mark@glyphic.com>
Link: https://lore.kernel.org/CAPnksqRok7xGa4bxq9WWimVV=28-7_j628OmrWLS=S0=hzaTHQ@mail.gmail.com
Link: https://patch.msgid.link/20241128074734.32165-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 92429ca999db ("ALSA: seq: Fix UMP group 16 filtering")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/seq/seq_clientmgr.c  |    7 +++++++
 sound/core/seq/seq_ump_client.c |    2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1329,6 +1329,10 @@ static int snd_seq_ioctl_set_client_info
 		client->midi_version = client_info->midi_version;
 	memcpy(client->event_filter, client_info->event_filter, 32);
 	client->group_filter = client_info->group_filter;
+
+	/* notify the change */
+	snd_seq_system_client_ev_client_change(client->number);
+
 	return 0;
 }
 
@@ -1452,6 +1456,9 @@ static int snd_seq_ioctl_set_port_info(s
 	if (port) {
 		snd_seq_set_port_info(port, info);
 		snd_seq_port_unlock(port);
+		/* notify the change */
+		snd_seq_system_client_ev_port_change(info->addr.client,
+						     info->addr.port);
 	}
 	return 0;
 }
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -272,8 +272,6 @@ static void update_port_infos(struct seq
 						new);
 		if (err < 0)
 			continue;
-		/* notify to system port */
-		snd_seq_system_client_ev_port_change(client->seq_client, i);
 	}
 }
 



