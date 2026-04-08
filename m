Return-Path: <stable+bounces-234624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH3cCSak1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0503C1DB9
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7769B31AC080
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC43624B0;
	Wed,  8 Apr 2026 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2MkiEfJk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659F351C2E;
	Wed,  8 Apr 2026 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673341; cv=none; b=oLOY5CKT1VT3K+PcLcmTAJjdp3jjcvwQJEtOy5zjA+5jG0dMbkbxX46TDpOUyFz3s16doRwDuDvJuj/kCfgFUiW0qOcBed6x4GICw1xXM3mQmBHbxSrHNPWHE9snsx0UEn4nVKvBGSzH80u7pgErgeXokPsOHQ/sf+WR2gPMBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673341; c=relaxed/simple;
	bh=3KeQslo5dO3LKs9E4dqEr5yIl8C4GcJebpwDQTbOUZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUIy3BnKXlxUXqP5k5fSX9Q7gMwDOlEVsVb0GIXjmJgkaDwjdK+F2K4t9niWxQ3LeI7YUktVtL9SFR76wMhMFwnScxEFr++1Hr0jWRy8CZAFiqYcrQD+e66RWwZzmlZ33cAwqfJfcc9fN6veBVLyRpq5ru1CYhKbxVpemJzfJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2MkiEfJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1263C19421;
	Wed,  8 Apr 2026 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673341;
	bh=3KeQslo5dO3LKs9E4dqEr5yIl8C4GcJebpwDQTbOUZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2MkiEfJkieLZOWV/46G6ToC3qiS80zJyJsvCyvOJKbvsO1wxdBYTeSiJhxTZKPGOC
	 NjABcQNDqA78qUHRPJtrs0T5RE+Jo9xWbRiMK3nvISkTZvtYhU28X4g1F5yLBeF/zV
	 up1xyIEZbkyxGHVjApNuhdDt173iTz5qHykG4ckk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Todd Brandt <todd.e.brandt@linux.intel.com>,
	stable <stable@kernel.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH 6.18 195/277] mei: me: reduce the scope on unexpected reset
Date: Wed,  8 Apr 2026 20:03:00 +0200
Message-ID: <20260408175941.145534240@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234624-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C0503C1DB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit 8c27b1bce059a11a8d3c8682984e13866f0714af upstream.

After commit 2cedb296988c ("mei: me: trigger link reset if hw ready is unexpected")
some devices started to show long resume times (5-7 seconds).
This happens as mei falsely detects unready hardware,
starts parallel link reset flow and triggers link reset timeouts
in the resume callback.

Address it by performing detection of unready hardware only
when driver is in the MEI_DEV_ENABLED state instead of blacklisting
states as done in the original patch.
This eliminates active waitqueue check as in MEI_DEV_ENABLED state
there will be no active waitqueue.

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221023
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Fixes: 2cedb296988c ("mei: me: trigger link reset if hw ready is unexpected")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Link: https://patch.msgid.link/20260330083830.536056-1-alexander.usyskin@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/hw-me.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1337,19 +1337,13 @@ irqreturn_t mei_me_irq_thread_handler(in
 	/*  check if we need to start the dev */
 	if (!mei_host_is_ready(dev)) {
 		if (mei_hw_is_ready(dev)) {
-			/* synchronized by dev mutex */
-			if (waitqueue_active(&dev->wait_hw_ready)) {
-				dev_dbg(&dev->dev, "we need to start the dev.\n");
-				dev->recvd_hw_ready = true;
-				wake_up(&dev->wait_hw_ready);
-			} else if (dev->dev_state != MEI_DEV_UNINITIALIZED &&
-				   dev->dev_state != MEI_DEV_POWERING_DOWN &&
-				   dev->dev_state != MEI_DEV_POWER_DOWN) {
+			if (dev->dev_state == MEI_DEV_ENABLED) {
 				dev_dbg(&dev->dev, "Force link reset.\n");
 				schedule_work(&dev->reset_work);
 			} else {
-				dev_dbg(&dev->dev, "Ignore this interrupt in state = %d\n",
-					dev->dev_state);
+				dev_dbg(&dev->dev, "we need to start the dev.\n");
+				dev->recvd_hw_ready = true;
+				wake_up(&dev->wait_hw_ready);
 			}
 		} else {
 			dev_dbg(&dev->dev, "Spurious Interrupt\n");



