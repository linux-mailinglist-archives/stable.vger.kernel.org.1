Return-Path: <stable+bounces-242161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAzOAlmF82kY4wEAu9opvQ
	(envelope-from <stable+bounces-242161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:37:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1E4A5D5C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA93305860D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286CD1632DD;
	Thu, 30 Apr 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+dPgLHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136A3FF889
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566719; cv=none; b=tweiRn0Gth1DDhgqSOUtsyGFaeWQk+3UBDGrfAWVLkC655CinT5tf+s5BBIVdB1KBrqvvE6rrBA5jRswNfNGZPk6rhrc+s5DYpr3tObEv+5+MLpV+8fvekEAQ0VnHc29cOm2/V+MLb6XZo+t8LW2RM4dUCan6gzDHE7qiesyIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566719; c=relaxed/simple;
	bh=Rc04gXUKMcu7XC1waqA09bCbqBAg+aeYH1BWOhBm7dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufogTYWPJuxOkESfH7RxioaTvfdk6pEjOXYp0+u9EUK7cnBx53IFJQ3DohohMAqbER7isgJlqVS2utEaSbeKn4Uw8FwAaWSSZUkHbvhbmbRhysw5OE5ENLdiiD1VRzh7qZPX8VfSoCCO4dWcUkz/FTEQOIuQlEbccfi+nPdWVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+dPgLHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3CDC2BCB3;
	Thu, 30 Apr 2026 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566718;
	bh=Rc04gXUKMcu7XC1waqA09bCbqBAg+aeYH1BWOhBm7dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+dPgLHjFiU/XdHU13tZuY+cMzkg1lt72tX+skSEYKVAF8ltVkkQJ3XrQ0JPriC5F
	 4K5CO4uzKqbPIm8+S2LiXb8Mu2+56tbOilSqmfxen865xTrNOaPulu7tK/x34zNkui
	 4+nFZe5x6XBGQ8gApIiJ75y4ieoqEQsUh0LB6wCjalZXt4VOiQOCDB9vtwC8lSogWp
	 y6QjSvbPGx+kDcCa+t9RhYRPzDJrpRv2JcX1AvmSM995j2FmPZ8hev987PD0JX6Rge
	 Pt+hbxbBySccP+zdBN4SQJa+4m/X7N4bhHz4x1t9hniG2G4alEvL5XKzsayyuMKAfr
	 JCivpE0UtJyPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
Date: Thu, 30 Apr 2026 12:31:55 -0400
Message-ID: <20260430163155.1837709-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043026-graveyard-rinse-022f@gregkh>
References: <2026043026-graveyard-rinse-022f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59A1E4A5D5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242161-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

From: Daniel Hodges <git@danielhodges.dev>

[ Upstream commit ae5e95d4157481693be2317e3ffcd84e36010cbb ]

The mwifiex_adapter_cleanup() function uses timer_delete()
(non-synchronous) for the wakeup_timer before the adapter structure is
freed. This is incorrect because timer_delete() does not wait for any
running timer callback to complete.

If the wakeup_timer callback (wakeup_timer_fn) is executing when
mwifiex_adapter_cleanup() is called, the callback will continue to
access adapter fields (adapter->hw_status, adapter->if_ops.card_reset,
etc.) which may be freed by mwifiex_free_adapter() called later in the
mwifiex_remove_card() path.

Use timer_delete_sync() instead to ensure any running timer callback has
completed before returning.

Fixes: 4636187da60b ("mwifiex: add wakeup timer based recovery mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Link: https://patch.msgid.link/20260206194401.2346-1-git@danielhodges.dev
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ changed `timer_delete_sync()` to `del_timer_sync()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 8b61e45cd6678..4caf54954894d 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -390,7 +390,7 @@ static void mwifiex_invalidate_lists(struct mwifiex_adapter *adapter)
 static void
 mwifiex_adapter_cleanup(struct mwifiex_adapter *adapter)
 {
-	del_timer(&adapter->wakeup_timer);
+	del_timer_sync(&adapter->wakeup_timer);
 	cancel_delayed_work_sync(&adapter->devdump_work);
 	mwifiex_cancel_all_pending_cmd(adapter);
 	wake_up_interruptible(&adapter->cmd_wait_q.wait);
-- 
2.53.0


