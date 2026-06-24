Return-Path: <stable+bounces-268213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/eaAgshPGoQkQgAu9opvQ
	(envelope-from <stable+bounces-268213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 20:25:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8226C0B8D
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 20:25:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=et54GvQw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268213-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268213-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2512B3008894
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3E3264D4;
	Wed, 24 Jun 2026 18:25:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBD298CA3;
	Wed, 24 Jun 2026 18:25:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325508; cv=none; b=rcjlkqsflxJwPm6clrX8Q1EgDWJ3ljwSAM74j/SC2O+B8Qh0npp0Atu01smkvd63auCgz+syL5j8DmhPWzREtEzJ4epQwvRiB6Pnr+7gncawe8iuhFJh0Tqx51w63O8mtk6a/p1R1Spm54+0wThkJCcHZ9KdJbrYWWE7EWMs+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325508; c=relaxed/simple;
	bh=5+Sy2FOiWnGoth3jqSOjOwUWo/xuVYB5KHaM0bCqpWk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYmEA0TOIpoN8mKBcYqo0A1ZdkeJGwURUrdsnXjIA0iYU1IMZ+eQ34Qg0VbBRwisZFWhHgEsKGkzjCxKBHC0wL3cF+/VafDGJuHktcjd1yEKrQeQJ7Ckdq8ZatGaHV/M6L7aO4a90VSe/aMdyfL6+wEzZl8wzarUSk2T5HyHJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et54GvQw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF5F1F000E9;
	Wed, 24 Jun 2026 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325507;
	bh=0fbeFIfFUvGMAe5cuzxSu1wxHQwrTOcqgfAbEnIXJ9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=et54GvQwwoFwM29uYCezg/ao4/R7nkfnsMbw/fNchDLOPrBnKsXaVQrkXAJnZV9UZ
	 pKpn+jDq9NWNJzICNboo4ikKAQxuggzhtINQ2HEYkgyaMc26gXoCtM5srIqM22gSh/
	 iD/d2L0IaNFnWasv7Je+pNlpdh/ue+4fcii7aieLdb74gf0fwtvoFDYzQcBk0GD+w/
	 6zjCZhdJqwjvNknSYJz7EFZW1/WYy7DaEO7D5OG4J3xqTE1FhRIxliWHPluPT5C/ZJ
	 r129Cy6UkSnso0cSQna2njd2EaCN0i0lVKNZAdX8wQ3Ado0i37rToef+S4OEAhu3Hm
	 iuhIxqYjn1Wfw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wcSHY-0000000FjZo-4Aon;
	Wed, 24 Jun 2026 18:25:05 +0000
Date: Wed, 24 Jun 2026 19:25:04 +0100
Message-ID: <86ik77re2n.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Gavin Shan <gshan@redhat.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] KVM: arm64: top up stage 2 memcache for dirty logging faults
In-Reply-To: <6FBA06E8-B0C4-444C-B226-0B756C0172A7@grrlz.net>
References: <20260624160028.15591-1-include@grrlz.net>
	<20260624160028.15591-4-include@grrlz.net>
	<9FCEC7E9-DE50-443F-8E82-9FA22CA15ED6@grrlz.net>
	<6FBA06E8-B0C4-444C-B226-0B756C0172A7@grrlz.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: include@grrlz.net, oupton@kernel.org, tabba@google.com, joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, qperret@google.com, vdonnefort@google.com, gshan@redhat.com, alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268213-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[maz@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:oupton@kernel.org,m:tabba@google.com,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:qperret@google.com,m:vdonnefort@google.com,m:gshan@redhat.com,m:alexandru.elisei@arm.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,grrlz.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D8226C0B8D

On Wed, 24 Jun 2026 18:46:10 +0100,
Bradley Morgan <include@grrlz.net> wrote:
> 
> On June 24, 2026 6:39:16 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
> wrote:
> >
> >Note: Patch 3 seems to conflict because of patch 2 (the comments)
> >
> >
> >Oops! :(
> >
> >V4 (after people have their review go), will contain one commit (patch
> >3) with the updated comments.
> >
> >Patch 1 and 2 applies as usual.
> >
> >Apologies for my messup. 
> >
> >Thanks!
> 
> 
> Actually. Hmm.
> 
> I'll just drop patches 2 and 3, I'll do them at a later date, please
> disregard patches 2 and 3, patch 1 doesn't rely on 2 and 3..
> 
> If you guys wanna have a look feel free! :)

As I suggested in my reply to your hasty v2, taking a few *days*
between versions is generally a good thing. it gives the reviewers
time to chime in, and gives you the opportunity to reflect on what
you've just written (reading your own patches after a few days is a
sure way to go and rewrite them).

Actually, by posting more often, you are guaranteeing that people
*avoid* reviewing your stuff, since odds are that there is a new
version coming in the next 10 minutes, so why bother...

But hey, that's free advice, so it's probably worthless.

	M.

-- 
Without deviation from the norm, progress is not possible.

