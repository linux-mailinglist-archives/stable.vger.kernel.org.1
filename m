Return-Path: <stable+bounces-263751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pJr3FgpXMWqPhAUAu9opvQ
	(envelope-from <stable+bounces-263751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:00:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54E6902C7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:00:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fHtswDRL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263751-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263751-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5754931C59E5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7911340401;
	Tue, 16 Jun 2026 13:55:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF92337688;
	Tue, 16 Jun 2026 13:55:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618129; cv=none; b=Uy5iKH9jVzTkC2Tmi6+T9gyro2yiw7gxqSkSLjzSmyIlGgkzqVK4Iv+vXcYEUC9VSVBqVM/FKc4jEeDDJvOdOyjMY4lnJmWaQ3pLWwd6zmodMIHLPV4lzapeIwvC4sWHloXC5v5GfR15hxsGmTNomtTTPGfXDseanrc//a4IDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618129; c=relaxed/simple;
	bh=AaUDgRAYKXQQd7PyYa2zrQQR4Ktrj0DDDZ01cUpLe5c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=npjflqtQ25YEC26WCAqW72ZqKZNgFycl3rKmepEWwhgdvAWGb2c8XFecCN1LffEttAAMKfL41eG4H5f/SUWzFCQpEei+xkMFKNHbYA4GHsEmgfieZ/B1YBGyxlXT5qz5b2lIAqmxVB0KgzsAc28m5O0UeNZGZkSNVt8ObL+GLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHtswDRL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3931F000E9;
	Tue, 16 Jun 2026 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618128;
	bh=QyF84nqSk9ebDNws1PdrM6L0rUUvlTQZheOw/Il6Zbg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fHtswDRL+VZvqlH6MaqUfWr91+VRYWrJc0UX0mpeCqETVowWwLdywrv1toWQJ18wL
	 RJwsSyBfzLtAloKRY0EwCIk+yml43WKHjG6LkjCakmXrKGBKpDsfVB98tlSyiQhgD2
	 60EI6JLWtPq0nw9sXaiAJOMb048QoiXn9eSWGSJjsX3Jm1uvNkD0qr5c6oeTQZgyT1
	 VJwGMBpOGRW1EoQ/u0Q1L/33eznB7Ib4YS/jYY1RWc9NAb7oQxaUV4ffAr1/EpZd2+
	 gvaEI9mqH5AkYPYo6o4mDDk6utOWBVV85zCBC+LQy70ROWS7+9J9j4pT43P5OAfl+m
	 ci8uj//KUNjxA==
Content-Type: multipart/mixed; boundary="===============8414396918092606343=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22624c18aedcefcada9ef30f7b9b2d03bf228d0314de708c5474f9115680d319@mail.kernel.org>
In-Reply-To: <20260616164741.32252-6-adubey@linux.ibm.com>
References: <20260616164741.32252-6-adubey@linux.ibm.com>
Subject: Re: [bpf v8 5/7] powerpc64/bpf: fix compare instruction emitted for tailcall
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 13:55:27 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-263751-lists,stable=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_RECIPIENTS(0.00)[m:adubey@linux.ibm.com,m:bpf@vger.kernel.org,m:hbathini@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[bot@kernel.org:query timed out,stable@vger.kernel.org:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC54E6902C7

--===============8414396918092606343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The tail_call_info field can contain either a scalar counter
> value or a 64-bit pointer to the counter, using a 32-bit
> compare (cmplwi) only checks the lower 32 bits, which can lead
> to incorrect comparisions when location of counter is near 4GB
> boundary. Use instruction cmpldi for accurate comparision in
> all cases.

The change now uses cmpldi on ppc64 and cmplwi on ppc32 through the new
PPC_RAW_CMPLLI macro, so should this sentence read "Use cmpldi/cmplwi
instruction" rather than "Use instruction cmpldi"?

This wording was raised in the v7 review by Hari Bathini
<hbathini@linux.ibm.com>:

https://lore.kernel.org/bpf/5c095e3d-d554-4506-9dbc-96d568b4be5e@linux.ibm.com/

  This should be "Use cmpldi/cmplwi instruction" instead of "Use
  instruction cmpldi"

The technical part of that feedback (defining PPC_RAW_CMPLLI rather than
using PPC_RAW_CMPLDI directly in the shared file) appears to be addressed
in this version, but the wording still reads "Use instruction cmpldi".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27620315552
--===============8414396918092606343==--

