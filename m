Return-Path: <stable+bounces-242184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKDTEvSX82nz5AEAu9opvQ
	(envelope-from <stable+bounces-242184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:57:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC94A6A8D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65A0A303101A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F34342B743;
	Thu, 30 Apr 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcpVTx/k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7011213E89
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571806; cv=none; b=nYxda+8YRbkFVOt3R7BVNmDN3wDJGqpX/orhamcI/hTB8KYt8JAKKR9+pvgsDT27GFW+sNORzBjRH1nzFsOU2UPJEzxW9lx0eXli4XyZhBpTHndEqAoJAadawydDvBAqUUQcUnZ9TNMLzTFvcEzO55T81gihcLUEb9/5IkNBADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571806; c=relaxed/simple;
	bh=hOYlZT29qQaBLJVdhVdMEpLllGjVluIFmC/hqWsGsko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFDrrIt3KCja1aJiwGlCjS0FV/xXoLTgXIYte5nyqzyGn1+1IvdePMfwRT0YGl3alOU5x2FskcVMsE/SK8bSujs+72K9vdNEHHvZ1GdScvR5XybjFvf80XFmdEOud4QNXg7HWul0fQGhCuRaO9XwcEWuCXfXXlJhLDasGI9MSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcpVTx/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370AAC2BCB8;
	Thu, 30 Apr 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777571805;
	bh=hOYlZT29qQaBLJVdhVdMEpLllGjVluIFmC/hqWsGsko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcpVTx/kJytsYMnc1bZ2coQIKNuGjXc1RIRp+lXY98DSNmNvpjMWZIHMDZU61G7RN
	 L3tkO2XHkm3nT8Yx9f1x0NQQN9xoUjyHenTKJydGBjy4g9Xm6Q5q2cDat9vTxMtVOh
	 kkK/Fb0xuzqU5R7R43oB503ev7Kym+A0PjrIkiW+vB7IyABl7eawBFrCcHHYZHA3HC
	 E2k9KdU2cdQ/t4zSG+HkkmZ7mLv4iY7SFP+9mBGMHGxGh4mS3fLl6v1EXWfiaxOyjJ
	 GDx9A0UcLHFTtphK3ms/Hk/2ORLkqruPyLY9im9tTjsSAUAlRaUbAhylOBn5GYHBp2
	 aaluI9u8pc+xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
Date: Thu, 30 Apr 2026 13:56:43 -0400
Message-ID: <20260430175643.1905462-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043027-lurch-equivocal-ad0b@gregkh>
References: <2026043027-lurch-equivocal-ad0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ADDC94A6A8D
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
	TAGGED_FROM(0.00)[bounces-242184-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,danielhodges.dev:email,msgid.link:url]

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
index 7dddb4b5dea1d..7ebacf600890f 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -388,7 +388,7 @@ static void mwifiex_invalidate_lists(struct mwifiex_adapter *adapter)
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


