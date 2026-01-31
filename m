Return-Path: <stable+bounces-212954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJUANmo7fmkOWgIAu9opvQ
	(envelope-from <stable+bounces-212954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 18:27:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEEAC3342
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 18:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935A93050A0C
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9934DCE4;
	Sat, 31 Jan 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="PH1VnivB"
X-Original-To: stable@vger.kernel.org
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch [109.224.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D735028E
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880380; cv=none; b=D2AXPZrKszwPlrse07AvAJFflLA7TpfpLEG3nCZKDbK2RexaPlwiLloUcpPYRolJgExlYzg9lgCstjGZuHGfEvj3ajtGQB0Vx3RNK5r02HfDVxhTJaDlVch2xx5B4QGamXqVZwbLdjuhEZ6lseW8C3AfUZtxLV5W4I6HFOOPm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880380; c=relaxed/simple;
	bh=yNwHhNa+heliVuLXUrQko/d+H6PvZ1Ncj1k81RKd9lc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMeLPgBowJRS4p/wJ0/EvgWN5dCM2NwYk6w9guq1yy7xzVBdEUnX5Z6/JMleleKRdUHw9FOA61JB2fFqJgMLBLXTcnIxqm2uYuczpX59F7SbAt2Zbj5XfkTLrl4pyiOAmj6NgwlyhmE2/lBtQG5rjPIL2YGcRMdrhdx3+x/Iypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=PH1VnivB; arc=none smtp.client-ip=109.224.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769871627; x=1770130827;
	bh=Qh+3JkFhiy4nIGSMFxn6kJmF5ZPrgjdBMWDDxS2+4/M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PH1VnivBgpmU8D1Ll8IP+c+gYhLczr3puNPVU67XL1ieYZx8FYgLPVsJHTAWhm3tv
	 sX9x2bg4CkNtwy9MjQp5zHYgcnPR8qlIYwvcdvtusAwxUZD7qCVfEwNoxyJuXC9Hlf
	 W1X3zvY1nvIM5UIEPwhD/x1oJIcR+rH0aX9UtsEWke4nRv8WB5ImZBb7b+B8Re51+5
	 aYK5VLeQdTqQBCgYIL1d2/bW1gAP2Bq7adSCqX5VwHduhe6zSc8kaVmcFME/iQEQ5E
	 w1R6rTgdMcDRcwepqnF8ec7sqUseKSB6gmYaIeeAMYyw96nH0dbcPrnZh1A9sFo/Do
	 +2692kznb/yMQ==
Date: Sat, 31 Jan 2026 15:00:23 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule list
Message-ID: <Pr4njxDDR8e9tElhovQfunuoyxlxUQdZqfdGBZg028rsKLPq4w1aYIUNKcAlF9EuqQHZjoj-9ocK2wEltjyQoRhUvsoKyZYveLK3oCAAd4k=@1g4.org>
In-Reply-To: <CA+NMeC-65UfJyq=34_K9tzf9J=-XFPJqDe1BxLNZv0mnjkxZEA@mail.gmail.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-7-p@1g4.org> <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com> <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com> <77q-JcImMG2fuQxj_GMUtYmaFAIuPrYMasj4I3aqIVID-Op24JIShBIPgt9kozLZgN4HvsGCS8Ez16mKq4Wq9juL1IOKydWUJwMwCYgHRMg=@1g4.org> <CA+NMeC-65UfJyq=34_K9tzf9J=-XFPJqDe1BxLNZv0mnjkxZEA@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 33c208a5f3561c0aaf6e1841e737ff64732bef69
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212954-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BEEAC3342
X-Rspamd-Action: no action

Ok, just to confirm the intended behavior changes compared to what is curre=
ntly in the tree:

  create missing entry list      FAIL (got -22, expected 0)
  create empty entry list        FAIL (got -22, expected 0)
  replace append entries         REPLACE append failed: expected 2 entries,=
 got 1
                                  FAIL (got -22, expected 0)

- CREATE with missing or empty entry list now returns -EINVAL =20
  Previously, CREATE could appear to succeed if cycle_time was=20
  provided even with no entries, but it still left an
  empty schedule and later called list_first_entry() at
  net/sched/act_gate.c:552, which is unsafe. Returning -EINVAL here is the
  correct behavior fix.

- REPLACE now replaces the schedule, it does not append =20
  The old append behavior was an accident caused by reusing the same list a=
nd
  never clearing it. With the RCU snapshot change, a fresh schedule is buil=
t
  and swapped atomically, so providing a new entry list on REPLACE replaces
  the old one and avoids stale data.

- REPLACE with an empty entry list keeps the old schedule =20

Thanks,
Paul


