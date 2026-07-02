Return-Path: <stable+bounces-271007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id moGKDUqZRmrNZgsAu9opvQ
	(envelope-from <stable+bounces-271007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:00:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECE6FADAC
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=l0osmFvO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271007-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271007-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C222531D55F7
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA143446A7;
	Thu,  2 Jul 2026 16:40:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792A342539;
	Thu,  2 Jul 2026 16:40:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010425; cv=none; b=lxovqlsdw0d4oekIu+z6I6m0MitBN+VGfFW30c57mVFAuwl1Hl/fI9BZxuekwe03cMdYp+gBvcibz+qz3hXTQoIwzkwCggwMTPtgJvpNfIgTeVzgQfMa5eZ6TNypwijmtFQicQFn8Zm/aQDG3q8Nf4VHupJFuf+OFFPugzhYe68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010425; c=relaxed/simple;
	bh=fwsKiieoYWuNaGHcl9jmfLew4n38HhZRsRdaBjfxaPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RatXAMi93f/H3UKGG4bSQN+YI08ohi6p8cfyga2k7YrN5W5GYXEZiLcgdYUNJ2SA6qbQfuBzhTAr4LOLgEwZ2AxkfCpczJAiO/6U1hzYPY4Hf+vHKJSlYf1UUo40yTtENJsQWKYuZNHnmTWPenOuaGvdr4lly52/He/IuPJy2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0osmFvO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2AE1F000E9;
	Thu,  2 Jul 2026 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010424;
	bh=0YoA4Drkglm+zFBraNFOjuXERIGVdFEo+mGC/F6zOMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0osmFvOiILYESW4kx7IDvMgPCL7vNNvPC2RSTT4nVNr4bWPJHe6O8aNXz1r3GFvv
	 PgoEKML0kCtms9xFs/skg2VECs+pj0vc4QMwQpZtcfQeVidjJVhaTs62hWru0Ui8Me
	 h67KjOCT48HJ2a+e7E+QcR3taYQDM0jywKqyNpBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 102/204] batman-adv: tp_meter: avoid window underflow
Date: Thu,  2 Jul 2026 18:19:19 +0200
Message-ID: <20260702155120.800626330@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271007-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,narfation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FECE6FADAC

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 765947b81fb54b6ebb0bc1cfe55c0fa399e002b8 upstream.

In batadv_tp_avail(), win_left is calculated with 32-bit unsigned
arithmetic: win_left = win_limit - tp_vars->last_sent;

During Fast Recovery, cwnd is inflated and last_sent advances rapidly. When
Fast Recovery ends, cwnd drops abruptly back to ss_threshold. If the newly
shrunk win_limit is less than last_sent, the unsigned subtraction will
underflow, wrapping to a massive positive value. Instead of returning that
the window is full (unavailable), it returns that the sender can continue
sending.

To handle this situation, it must be checked whether the windows end
sequence number (win_limit) has to be compared with the last sent sequence
number. If it would be before the last sent sequence number, then more acks
are needed before the transmission can be started again.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/tp_meter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index f6ccb639744a2a..0fdcafca3aa02b 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -817,10 +817,15 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
 			    size_t payload_len)
 {
+	u32 last_sent = READ_ONCE(tp_vars->last_sent);
 	u32 win_left, win_limit;
 
 	win_limit = atomic_read(&tp_vars->last_acked) + tp_vars->cwnd;
-	win_left = win_limit - tp_vars->last_sent;
+
+	if (batadv_seq_before(last_sent, win_limit))
+		win_left = win_limit - last_sent;
+	else
+		win_left = 0;
 
 	return win_left >= payload_len;
 }
-- 
2.53.0




