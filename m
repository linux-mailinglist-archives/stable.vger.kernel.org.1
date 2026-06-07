Return-Path: <stable+bounces-261187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qkkQHcJFJWp8FgIAu9opvQ
	(envelope-from <stable+bounces-261187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F161E64F87B
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Te4WR+eZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261187-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261187-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DAF53012CCB
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C84D4CB5B;
	Sun,  7 Jun 2026 10:19:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7823392F;
	Sun,  7 Jun 2026 10:19:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827581; cv=none; b=kCm0dM037vaj/px+hnVbmos3i9mIBq2pLtFqI7Fhgk0zj5ffJzQIcIbEZkeT+lxoqboth9StQjOa5uHuVamXw9VKgW7vmVVD0Cv6Yi2FPIHyiR1IgrF534xl0PpKqWsHNrgPllQDJEo0HxhsaO2KGsucJ2w+8JwZ6lJZP0IJ+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827581; c=relaxed/simple;
	bh=+7w8AEyVJiwX3jVOd8/a+q0fNkn0RJxRZCfu2SQjh8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHLz7H/4Y4z1bSMc1BqqKSHYvkAYY2bCf5nph85fhSYAMg9qTjiywByRyru18k7+11x3BlgiUSvSxql2g9Q9ZhgYH3oUyI5Pl8pKX0RcoPRbY+1DW8ivofOEGGQqDiyl1vA0ect9Q10L8ohtw01TT7nuIE78Q6VMCP2MeodrCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Te4WR+eZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29B71F00893;
	Sun,  7 Jun 2026 10:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827580;
	bh=bRY6VzI7Vl96wen62aSaazYfvUCdhYILqxZgXviGQ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Te4WR+eZeghuHeyZ/Ac2o/Zx0fFo5+SQALCx9Izx2B30/idRdPeiYMG7FBb2mYEm9
	 KDp7LQgX13/6ntFtn+zgFc49hTeDbCnZgPOiyT3Y65SoRbuDSOBWlbYE1m2EDh62t5
	 fFRWwSbmjZiRKbaydszBWez11XbkedRQsEeMGBME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 106/332] net: mana: Skip redundant detach on already-detached port
Date: Sun,  7 Jun 2026 11:57:55 +0200
Message-ID: <20260607095732.020081501@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261187-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:haiyangz@microsoft.com,m:dipayanroy@linux.microsoft.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F161E64F87B

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>

[ Upstream commit 5b05aa36ee24297d7296ca58dfd8c448d0e4cda3 ]

When mana_per_port_queue_reset_work_handler() runs after a previous
detach succeeded but attach failed, the port is left in a detached
state with apc->tx_qp and apc->rxqs already freed. Calling
mana_detach() again unconditionally leads to NULL pointer dereferences
during queue teardown.

Add an early exit in mana_detach() when the port is already in
detached state (!netif_device_present) for non-close callers, making
it safe to call idempotently. This allows the queue reset handler and
other recovery paths to simply retry mana_attach() without redundant
teardown.

Fixes: 3b194343c250 ("net: mana: Implement ndo_tx_timeout and serialize queue resets per port.")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Link: https://patch.msgid.link/20260525081129.1230035-3-dipayanroy@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 3ddbf3b9a76501..13a0af0456c9e3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3313,6 +3313,12 @@ int mana_detach(struct net_device *ndev, bool from_close)
 
 	ASSERT_RTNL();
 
+	/* If already detached (indicates detach succeeded but attach failed
+	 * previously). Now skip mana detach and just retry mana_attach.
+	 */
+	if (!from_close && !netif_device_present(ndev))
+		return 0;
+
 	apc->port_st_save = apc->port_is_up;
 	apc->port_is_up = false;
 
-- 
2.53.0




