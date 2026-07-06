Return-Path: <stable+bounces-272214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +Z0sIvGmS2qtXwEAu9opvQ
	(envelope-from <stable+bounces-272214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 15:00:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7A710EDE
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 15:00:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aEU4nSEY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272214-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272214-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEC0030937EC
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810E42A140;
	Mon,  6 Jul 2026 12:39:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE241D4E9;
	Mon,  6 Jul 2026 12:39:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341585; cv=none; b=R8gmZ0lu6j3QPnwYcOlXzEyInsz9MYIt7HBidkwBNQMkjxFH2ueHi2eL1DnQKWQJNaKLowepuC5DbAx/VLk2IFKnl0Oa3kUNjwZAYXkmsZXtBBYYueYJWbjIOoxr0Rsq9SuJY+8IkglYFNaDKSiYpgM7pT/C4k5zyRpiYy3ZBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341585; c=relaxed/simple;
	bh=PZ2Y91omm59iIwuXmCNl/BrSoeCVOyWnKu2Bo31DPSo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=sA71hPsaCF8T/HM/jrKRDzbSQt9P/V8LowUn4JMahH2jz2MtqO4pz3j1wPEg8Mux1pQ38qeKXJX45aBBg4BMnLbDlmpxmJ1R4Zlu7lmZa0Oy6jJskgLY2ur6UekhZGfowOuz7F6eujcvAq7nzYRfUCW6kTSn6qnemteRaogG3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEU4nSEY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738B71F000E9;
	Mon,  6 Jul 2026 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341583;
	bh=Skb+7SE0R6vqpUmC2bWNshEw7taDkLAxusq4vbh+rx8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=aEU4nSEYvUFSI7PohxhfWGsKb0AsG+yxFgnAAvQpHCeAO07NO+koCxtFiZYyhbfST
	 ySjHEGFSRrxLjd7BUFTPO+dyGsz6L7XsPuTElqdnGG3Q4y945sj/UpdnYzpmtw6nTg
	 pxeJX/K3ow0rUNfosgzc10Jl3k+LZ4/t4U2vIWPs1N4jQQ3n7p40dsc7l2CkF1obic
	 vF02svsfonseh9/IMGoRGnVFNeDfQVpLzGen45UYeZL0UKCXCGaZghvvEfOV7BC/j7
	 kefR7ggsSzKS6vhY28r5fOk2RVagWAjd+PTl9BD0jO5JKauc1KYB34KhDt/ApUP1wn
	 kIiDeA6D6HGmw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] signal: avoid shared siginfo namespace rewrites
From: Christian Brauner <brauner@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>, 
 Aleksandr Nogikh <nogikh@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Adrian Huang <adrianhuang0701@gmail.com>, 
 Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
References: <20260622164029.11474-1-include@grrlz.net>
 <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
Date: Mon, 06 Jul 2026 14:39:35 +0200
Message-Id: <20260706-rechen-kreuz-katapultieren-c37fe3b9e607@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PZ2Y91omm59iIwuXmCNl/BrSoeCVOyWnKu2Bo31DPSo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5L+L+x5NdEVHy+/KSpae91h/iYV69dJfnDvPKD1dKF
 UJ6HbLlO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS5MzIMPP4nEAOznNtlpMS
 rj4xuGwil53KYfdKyrzXsenPHHefPIZ/5hvLDa+umDrv2dXZkVryt7Z8P1F6aPLa01YHloQf48+
 34AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:oleg@redhat.com,m:brauner@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:elver@google.com,m:nogikh@google.com,m:tglx@kernel.org,m:adrianhuang0701@gmail.com,m:kexinsun@smail.nju.edu.cn,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272214-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,goodmis.org,efficios.com,linux-foundation.org,infradead.org,google.com,gmail.com,smail.nju.edu.cn,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BD7A710EDE

> send_signal_locked() rewrites sender ids for the target namespace.
> Group sends reuse the same siginfo, so one recipient can affect the
> next.
> 
> Copy the siginfo before changing it.
> 
> Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>                                                                                                                                                                                               Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>

