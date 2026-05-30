Return-Path: <stable+bounces-257309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEDRJ24aG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:12:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7D260F1D6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 096643080F99
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FCF395AEA;
	Sat, 30 May 2026 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PCzcn/Vd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7832D42B;
	Sat, 30 May 2026 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160558; cv=none; b=Zx6f6bIA+WusCU3PrnLxnX/37SgRaovi+dzsnzpkHGd8lUj2znqCxEavKIJuTL9HrO38Etqwtrp/k4e0EdUj5bzbQZdKvwfy7BgaSFWn2TavWJ9JMmTxjjwsHe7S4RhWfSIqM6QHtk6C06HVvuVtce7+y/QZU9N8s0+Q3bPXK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160558; c=relaxed/simple;
	bh=bm3XJXx+kUPW5Ac3GhDUjCxqq/z7Kws1xjGEWgOLpEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc02ZmuXE58//NSx0dCWeuVfUixkL2ZQuQVPQUCZkEU2aMiYCa1S2aq8wDVKDXFwYD9IS1AawGDAswZdm2DhQ4ARRnUxtb38uCtHWsCu7Iudzl3FU2rpkKe9e6XjB9PeBDmQ7OfRoWF/yn0UxZtvqEmzqJRIAtWwP8H31/DxNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PCzcn/Vd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C201F00893;
	Sat, 30 May 2026 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160557;
	bh=YlhUYaVdP/WI+D4K0Y3KoKMkrcLE4dExDTd7X9Papr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCzcn/Vd+TB7KuP3ojdPj1gIJqRhyetb5oPlyYGE2Vi/uG1Keq2os9DjKwEtN9STd
	 Nb0maN/eJaDOpXQWEdX09U3imMpNYGwQbdWJmqJOfVxOZPM9NM9hRheJdz7LAs+Knv
	 mcYwFJNuxCttFeoyQwqoxVq9xiUnZR2GSoIgq4wI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 6.1 341/969] cpuidle: powerpc: avoid double clear when breaking snooze
Date: Sat, 30 May 2026 17:57:45 +0200
Message-ID: <20260530160309.784724237@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257309-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0C7D260F1D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shrikanth Hegde <sshegde@linux.ibm.com>

commit 64ed1e3e728afb57ba9acb59e69de930ead847d9 upstream.

snooze_loop is done often in any system which has fair bit of
idle time. So it qualifies for even micro-optimizations.

When breaking the snooze due to timeout, TIF_POLLING_NRFLAG is cleared
twice. Clearing the bit invokes atomics. Avoid double clear and thereby
avoid one atomic write.

dev->poll_time_limit indicates whether the loop was broken due to
timeout. Use that instead of defining a new variable.

Fixes: 7ded429152e8 ("cpuidle: powerpc: no memory barrier after break from idle")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260311061709.1230440-1-sshegde@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpuidle/cpuidle-powernv.c |    5 ++++-
 drivers/cpuidle/cpuidle-pseries.c |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -93,7 +93,10 @@ static int snooze_loop(struct cpuidle_de
 
 	HMT_medium();
 	ppc64_runlatch_on();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+
+	/* Avoid double clear when breaking */
+	if (!dev->poll_time_limit)
+		clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	local_irq_disable();
 
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -61,7 +61,10 @@ static int snooze_loop(struct cpuidle_de
 	}
 
 	HMT_medium();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+
+       /* Avoid double clear when breaking */
+	if (!dev->poll_time_limit)
+		clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	local_irq_disable();
 



