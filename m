Return-Path: <stable+bounces-218135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCcWIdxQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B018ED8A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D170303D7E3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41FC242D9B;
	Wed, 25 Feb 2026 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smnTQmf+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79914369A;
	Wed, 25 Feb 2026 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982916; cv=none; b=U+5IMowJWl/aoGEALOVxDJFldKDPl4xAnAuF/pm+E6t3EBNs+O/CbpnNppDlP5s7Xuy7R5uleRMFiUlOXwJyHTsJKguQBcmFCK7NRw8glhT34peQzYgf9RBifmkLZ/cHTYo4t9eM7Xc70+DxuuS9rp3mh+txl92nVSs2055olcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982916; c=relaxed/simple;
	bh=IpjhfUVwjnM0cAmCtRMkz2usyn39z5uQxywpBG/W0B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3pvsj6aIf2kneBXB6it8GSXjeO43WIuEvFtCTRFurDDVnJTFU45B7/zrn/Wo1Vy27tMPAcIaqlnElii+fcaAzT3Gh+xKNKgSOWVjwK3svSNAzQmMYqA8mGf3tbC0iGh+R5/MOGx28dvPj+yve3rMS/GDHloV9q2pGM1+1QzQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smnTQmf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7731AC116D0;
	Wed, 25 Feb 2026 01:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982916;
	bh=IpjhfUVwjnM0cAmCtRMkz2usyn39z5uQxywpBG/W0B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smnTQmf+khvYAsGZRY2tS/jBx/PhVCVut7O5As/eNavc+5GK1EWgDKYCULH35P0lU
	 Mv2hI9i5BrPaqPPsr/PTjXjT9bGFeU0DnJ2gQBp2JjFSeZvCwOWJwtMh2Thiwyd3xG
	 57vMBBKkKb79UzlVk8wkNLnzJ0oS4yUdzxXKtKEU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 096/781] hrtimer: Fix trace oddity
Date: Tue, 24 Feb 2026 17:13:25 -0800
Message-ID: <20260225012402.045517056@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218135-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B32B018ED8A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 5d6446f409da00e5a389125ddb5ce09f5bc404c9 ]

It turns out that __run_hrtimer() will trace like:

          <idle>-0     [032] d.h2. 20705.474563: hrtimer_cancel:       hrtimer=0xff2db8f77f8226e8
          <idle>-0     [032] d.h1. 20705.474563: hrtimer_expire_entry: hrtimer=0xff2db8f77f8226e8 now=20699452001850 function=tick_nohz_handler/0x0

Which is a bit nonsensical, the timer doesn't get canceled on
expiration. The cause is the use of the incorrect debug helper.

Fixes: c6a2a1770245 ("hrtimer: Add tracepoint for hrtimers")
Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260121143208.219595606@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0e4bc1ca15ff1..84c8ab2a0cebf 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1742,7 +1742,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 
 	lockdep_assert_held(&cpu_base->lock);
 
-	debug_deactivate(timer);
+	debug_hrtimer_deactivate(timer);
 	base->running = timer;
 
 	/*
-- 
2.51.0




