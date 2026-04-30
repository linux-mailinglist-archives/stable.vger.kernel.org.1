Return-Path: <stable+bounces-242168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J3+EPiJ82m74wEAu9opvQ
	(envelope-from <stable+bounces-242168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:57:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D20EF4A61C9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91EF030143EC
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC736495B;
	Thu, 30 Apr 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FohaC2vM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D883644C5
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568049; cv=none; b=mQUhWMXhWNOq4+jU+REjs8vdrrlUst0tnBxsNAoV1GbvfLsH1Hkz8U2m6EtTorL8Dtp/y1QzfmIjDfZSbuavDuwTgmW4il6mHvSjGN2oeVcho5ULJcKBk9SdeTSnRPh6BkzteMuGISb4NJDI4whoplENQf9NJ5Gh9FHhjH/NbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568049; c=relaxed/simple;
	bh=izFESbJ+CGgPGli1AePCQvzqktGBjX0pjVK90sO77bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hou5mb7Xg0N6e4jstAN9v2Mr1pkNoHpjbg58CeEYM0eB46Utg5q8+XNJSrjISMSkpxa6JJgrDecePxtlA1+M5If2/zgrbL8T7Sh44u1KNCoh59zh2yXp6192HQrT0jVbBbpDjkXoxhep43V8o7D7BbuSMB7VV9w44jnRH+2wDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FohaC2vM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31E4C2BCB3;
	Thu, 30 Apr 2026 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777568049;
	bh=izFESbJ+CGgPGli1AePCQvzqktGBjX0pjVK90sO77bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FohaC2vMe1xvkFrzOMP4ljsfdojTcABSnn8ii7t80heSMsD95n6EFkL8uuvpWdbKX
	 DS2PlnQCOU94Rqk/u2kzWULohM+uYVt3Y3l6iXGdjYCP6hlt6aP1NUrpjjNusTXgDA
	 MothHHPEvjVyLSBn9TH6Zon4D6cAEOQM/5UIImXOQqSH/I4vXd06yyEBGUM8v83r5D
	 g0Tw5npQZ/lEnMYpc5xB39XeUOf2vUQntGOBnUtYXHyENrwjbTWrzpx4Nmb9SmV+99
	 20AQPZNyCreSMbDuT6vjZgoN8rEqq3Xdp85G8D4tcg5tsY9PbQ8rmrQuR6ejX/ouJY
	 GyQehxIZn0aIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
Date: Thu, 30 Apr 2026 12:54:06 -0400
Message-ID: <20260430165406.1860168-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043027-gave-faucet-44b4@gregkh>
References: <2026043027-gave-faucet-44b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D20EF4A61C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242168-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url]

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
index c9c58419c37bf..64d651c78570d 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -386,7 +386,7 @@ static void mwifiex_invalidate_lists(struct mwifiex_adapter *adapter)
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


