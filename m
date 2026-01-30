Return-Path: <stable+bounces-212911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULEYOxEZfWkhQQIAu9opvQ
	(envelope-from <stable+bounces-212911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:48:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D4BE85D
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FC7730093B4
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A345A34EF1B;
	Fri, 30 Jan 2026 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="DZYGi1pX"
X-Original-To: stable@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B65318ED8;
	Fri, 30 Jan 2026 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806091; cv=none; b=Lw13yihvD+Iwi9L1C4uZ0/B1taJtyxSosa4SFtMYTDwm4ZuA4kA2l99MvNzfLiMUCyI/GXWkdhKqDgY2qWNKLvvbe4/6jIArOVbuxOupfrcCU59jeAtybfGrTtTNO5dGGsr4svqYfEpcKiiD1++aAmww6Hf36JujoDefDeX/vpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806091; c=relaxed/simple;
	bh=NH3nSMZ3689wk1k+Ydtvm9911igQwjgTtxEraXA3qqE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6ic1KTtbaj+02jglOSZdyk3f7kgd0Di0IGj67vvsiEUwv/8nWGwQ3hqMGSWE+pQcxQ5mFGOD3MC2FCaYT2mF7OLFPl5HgYi9CnP5PjC+9jFja2iY4Rdw7GOsv+4ULIsOinueKXUckMO9X5wZcmSEC4QjKwQdTYfGzc3zvBIGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=DZYGi1pX; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769806078; x=1770065278;
	bh=Ns6aX4kVdG2x2DS59nidc0rJohsMUdrNgcAO4lwVAHY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DZYGi1pXMmC/ubxw0V9VFT3GCanL1MXxliYflYZFJ0cpNFRDkbhmac4wXsyyWFpyk
	 C0lJwJ34OSynuEP4MSuqk+6JEUe/nInqPxYzOx23wSwJO2NXCurpA3AJnX78idfvKg
	 kQvsTMKmAzSQQA8PPrwMNTYwOWxAC2sWMOYsW1FWx6cFsfoOHD7Rk3OWCFkxcRZoc1
	 4ONFQ7npa9bZlgP4BTreEjbydmy2mNu0Vs9vBAwPh5PFS6cK+oxwj3umDjPnco3/Fq
	 2uxHkZ0xEbXDQcotJjGyiFEqS47iQ9zlRa+mehX0+KY6vS1t/U0jCDtfV3SPQNHUUi
	 RpMd6vCpJ7Uaw==
Date: Fri, 30 Jan 2026 20:47:52 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
Message-ID: <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
In-Reply-To: <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com>
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com> <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org> <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: f7035d83a69cc823dd322282f4eb5a8914867daf
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-212911-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 298D4BE85D
X-Rspamd-Action: no action

What version of act_gate.c are you currently testing? Did you actually run =
the tests? =E2=80=9Clarge dump=E2=80=9D creates ONE action at base_index, w=
ith num_entries=3D100, then immediately does GETACTION. So =E2=80=9Ctc acti=
ons ls action gate | grep index | wc -l=E2=80=9D won=E2=80=99t exercise thi=
s, because it only counts actions. It doesn=E2=80=99t amplify the per actio=
n dump size (the entry list does). It uses libmnl (mnl_socket_sendto / mnl_=
socket_recvfrom) with MNL_SOCKET_BUFFER_SIZE. There is no custom netlink ha=
ndling. The failure is returned by the kernel before userspace parses anyth=
ing. The dumps are transactional at the netlink level, but an individual ac=
tion dump still has to fit in the skb backing that message.=20

look at af_netlink.c
=09/* NLMSG_GOODSIZE is small to avoid high order allocations being
=09 * required, but it makes sense to _attempt_ a 32KiB allocation
=09 * to reduce number of system calls on dump operations, if user
=09 * ever provided a big enough buffer.
=09 */
         ...
=09/* Trim skb to allocated size. User is expected to provide buffer as
=09 * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
=09 * netlink_recvmsg())). dump will pack as many smaller messages as
=09 * could fit within the allocated skb. skb is typically allocated
=09 * with larger space than required (could be as much as near 2x the
=09 * requested size with align to next power of 2 approach). Allowing
=09 * dump to use the excess space makes it difficult for a user to have a
=09 * reasonable static buffer based on the expected largest dump of a
=09 * single netdev. The outcome is MSG_TRUNC error.
=09 */

This is where I am currently but I have seen these bugs appear throughout a=
ll my iterations including what's in the tree currently, if you show me bet=
ter alternatives that solve my problems, I'll gladly accept.=20
https://github.com/torvalds/linux/compare/master...jopamo:linux:net-stable-=
upstream-v4

gatebench --selftest=20
Configuration:
  Iterations per run: 1000
  Warmup iterations:  100
  Runs:               5
  Gate entries:       10
  Gate interval:      1000000 ns
  Starting index:     1000
  CPU pinning:        no
  Netlink timeout:    1000 ms
  Selftest:           yes
  JSON output:        no
  Sampling:           no
  Clock ID:           11
  Base time:          0 ns
  Cycle time:         0 ns
  Cycle time ext:     0 ns

Environment:
  Kernel: Linux 6.18.7 x86_64
  Current CPU: 7
  Clock source: CLOCK_MONOTONIC_RAW

Running selftests...
Running 20 selftests...
  create missing parms           PASS (got -22)
  create missing entry list      PASS (got -22)
  create empty entry list        PASS (got -22)
  create zero interval           PASS (got -22)
  create bad clockid             PASS (got -22)
  replace without existing       PASS (got 0)
  duplicate create               PASS (got -17)
  dump correctness               PASS (got 0)
  replace persistence            PASS (got 0)
  clockid variants               PASS (got 0)
  cycle time derivation          PASS (got 0)
  cycle time extension parsing   PASS (got 0)
  replace preserve schedule      PASS (got 0)
  base time update               PASS (got 0)
  multiple entries               PASS (got 0)
  malformed nesting              PASS (got -22)
  bad attribute size             PASS (got -22)
  param validation               PASS (got 0)
  replace invalid                PASS (got 0)
  large dump                     DEBUG: msg->len =3D 3112
PASS (got 0)

Selftests: 20/20 passed
Selftests passed

Running benchmark...
Run 1/5... done (311721.5 ops/sec)
Run 2/5... done (321045.7 ops/sec)
Run 3/5... done (336402.3 ops/sec)
Run 4/5... done (338419.7 ops/sec)
Run 5/5... done (316618.9 ops/sec)
Benchmark completed successfully


