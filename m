Return-Path: <stable+bounces-226719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBxxJrKNuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:21:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3C02AF69F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7857A308F8D1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5065632AAC5;
	Tue, 17 Mar 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tTzvhM20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13020320CCF;
	Tue, 17 Mar 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767942; cv=none; b=YHWlMHrz6dpJJ8o1Nv40lw3o68JcW3qsFa78pTk4vdg08nOGlsFeIqSOKccBq5srai93gzXAYJSY/gDeElqZk606964IihTMi/KknPxgLIbar3EELeFRHjTHLbF9Rm//yG6UqQ3ucYPnU+QJ/w2Ere7OZhRHCwM1pq4FJetyqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767942; c=relaxed/simple;
	bh=SWFetloNZLDBHErkvdhoyWRu4Bsvg3vWC7ary8grbfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=symXURcyU6wLnYj/kQ5tyMIpre7Rlc5mqWcYHGn3SxWvjPCj5Gx5ydbM0RdVztlQ3kt3J+S6iERfwpPmHXq4KlwH/OBVKBfHpVxTg5M5qZevmNc+o9Hs28/MH/EZo0kBIsLcWRv9aK5K3GPAaqrfNEyB32hD3zo+ETyvPO85sQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tTzvhM20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE34C4CEF7;
	Tue, 17 Mar 2026 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767942;
	bh=SWFetloNZLDBHErkvdhoyWRu4Bsvg3vWC7ary8grbfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTzvhM20b+6o1v2etvFoy+D8q4KQwd5oRj1dfmgJcq0qN1+6J7ax+FRmgE93E9WhT
	 5jxq+LcRf27xEZTPMEN1fKz5Jrrm8QPH8z3K6NH1oqk7X9DHy2I91mQYOnzzlLJTE4
	 r/W7j8WAaRAO5/cSZHfTyCE/LFMD1nj4cIvwNYV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.18 195/333] ipmi:si: Fix check for a misbehaving BMC
Date: Tue, 17 Mar 2026 17:33:44 +0100
Message-ID: <20260317163006.588337907@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226719-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,minyard.net:email]
X-Rspamd-Queue-Id: 2A3C02AF69F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

commit cae66f1a1dcd23e17da5a015ef9d731129f9d2dd upstream.

There is a race on checking the state in the sender, it needs to be
checked under a lock.  But you also need a check to avoid issues with
a misbehaving BMC for run to completion mode.  So leave the check at
the beginning for run to completion, and add a check under the lock
to avoid the race.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Cc: stable@vger.kernel.org # 4.18
Signed-off-by: Corey Minyard <corey@minyard.net>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -925,9 +925,14 @@ static int sender(void *send_info, struc
 {
 	struct smi_info   *smi_info = send_info;
 	unsigned long     flags;
+	int rv = IPMI_CC_NO_ERROR;
 
 	debug_timestamp(smi_info, "Enqueue");
 
+	/*
+	 * Check here for run to completion mode.  A check under lock is
+	 * later.
+	 */
 	if (smi_info->si_state == SI_HOSED)
 		return IPMI_BUS_ERR;
 
@@ -941,18 +946,15 @@ static int sender(void *send_info, struc
 	}
 
 	spin_lock_irqsave(&smi_info->si_lock, flags);
-	/*
-	 * The following two lines don't need to be under the lock for
-	 * the lock's sake, but they do need SMP memory barriers to
-	 * avoid getting things out of order.  We are already claiming
-	 * the lock, anyway, so just do it under the lock to avoid the
-	 * ordering problem.
-	 */
-	BUG_ON(smi_info->waiting_msg);
-	smi_info->waiting_msg = msg;
-	check_start_timer_thread(smi_info);
+	if (smi_info->si_state == SI_HOSED) {
+		rv = IPMI_BUS_ERR;
+	} else {
+		BUG_ON(smi_info->waiting_msg);
+		smi_info->waiting_msg = msg;
+		check_start_timer_thread(smi_info);
+	}
 	spin_unlock_irqrestore(&smi_info->si_lock, flags);
-	return IPMI_CC_NO_ERROR;
+	return rv;
 }
 
 static void set_run_to_completion(void *send_info, bool i_run_to_completion)



