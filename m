Return-Path: <stable+bounces-268215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Hg6AOAjPGrFkQgAu9opvQ
	(envelope-from <stable+bounces-268215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 20:37:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A126C0C33
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 20:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=abQkgu7N;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268215-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268215-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9759E3027375
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA097331200;
	Wed, 24 Jun 2026 18:37:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63569325706;
	Wed, 24 Jun 2026 18:37:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326235; cv=none; b=WxsG7dH+4WQep2fhMYpQjo5zY32jovVjCx1Xg5O0YX1k3nOevP2TY2tFuDrckfpM1qwB/Ig//UbMQbqZURcuxLMGRXIAdmqVpzQlrphDZA02XiWSbGgZGnHvVgXkNNxP91RiZ3JDeVF8jhOtv+sUxnPEH14FeiTAbKZPVEZn6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326235; c=relaxed/simple;
	bh=cYgKJTc9gkW11/NnIWcI7YTOuDswywvAsTQV0uV3LR0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EXgWvVqc9dS7naJdN5eH184B93bOeQsjN+hEVwMLpfVKG6lWwtdSAdazeYWXKndAXkXlaQFhOSmkEkvACwmveDPbLb8EVAsRIgt3YSaqO+h5d12x4BQGr8MHq0T855C95suPgBuIisq8ACwFDtprtyL0BA6sM4pbxV9XgP5njt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=abQkgu7N; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782326232;
	bh=NI46s4EnJvuP923IrCreg9YPlL82QCQYf/Ag8Yhe+Gg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=abQkgu7NFxeoFje3tY15Ct7rEGE1UYqmUqhAlpWEFcuJNYYjvc6tHdnVP5WbkUQdl
	 q76dm//6kZk9Tu1OxSyWOHKn6vyCa7jBDOe+zcCLX5SvFeVwlk6bs/yob8mdnqVMg2
	 Yh9gU3E0XBtHs6AEzIEMQDd6T2j0yGnfEKFJatIM=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glrJS6fykz10tT;
	Wed, 24 Jun 2026 18:37:12 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glrJS2KFkz10s3;
	Wed, 24 Jun 2026 18:37:12 +0000 (UTC)
Date: Wed, 24 Jun 2026 19:37:11 +0100
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>
CC: Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>,
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>,
 Vincent Donnefort <vdonnefort@google.com>, Gavin Shan <gshan@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/3=5D_KVM=3A_arm64=3A_top_up_s?=
 =?US-ASCII?Q?tage_2_memcache_for_dirty_logging_faults?=
In-Reply-To: <86ik77re2n.wl-maz@kernel.org>
References: <20260624160028.15591-1-include@grrlz.net> <20260624160028.15591-4-include@grrlz.net> <9FCEC7E9-DE50-443F-8E82-9FA22CA15ED6@grrlz.net> <6FBA06E8-B0C4-444C-B226-0B756C0172A7@grrlz.net> <86ik77re2n.wl-maz@kernel.org>
Message-ID: <548B439F-7DDD-418B-98E2-D7D6BB047A6E@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268215-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:oupton@kernel.org,m:tabba@google.com,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:qperret@google.com,m:vdonnefort@google.com,m:gshan@redhat.com,m:alexandru.elisei@arm.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[grrlz.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62A126C0C33

On June 24, 2026 7:25:04 PM GMT+01:00, Marc Zyngier <maz@kernel.org> wrote:
>On Wed, 24 Jun 2026 18:46:10 +0100,
>Bradley Morgan <include@grrlz.net> wrote:
>> 
>> On June 24, 2026 6:39:16 PM GMT+01:00, Bradley Morgan
><include@grrlz.net>
>> wrote:
>> >
>> >Note: Patch 3 seems to conflict because of patch 2 (the comments)
>> >
>> >
>> >Oops! :(
>> >
>> >V4 (after people have their review go), will contain one commit (patch
>> >3) with the updated comments.
>> >
>> >Patch 1 and 2 applies as usual.
>> >
>> >Apologies for my messup. 
>> >
>> >Thanks!
>> 
>> 
>> Actually. Hmm.
>> 
>> I'll just drop patches 2 and 3, I'll do them at a later date, please
>> disregard patches 2 and 3, patch 1 doesn't rely on 2 and 3..
>> 
>> If you guys wanna have a look feel free! :)
>
>As I suggested in my reply to your hasty v2, taking a few *days*
>between versions is generally a good thing. it gives the reviewers
>time to chime in, and gives you the opportunity to reflect on what
>you've just written (reading your own patches after a few days is a
>sure way to go and rewrite them).

welp, I guess I learned the hard way with the hastiness of my V3, (that's
kinda why I dropped p2 and p3)


>Actually, by posting more often, you are guaranteeing that people
>*avoid* reviewing your stuff, since odds are that there is a new
>version coming in the next 10 minutes, so why bother...

I'm not planning on posting another version, until fuller review concludes


>But hey, that's free advice, so it's probably worthless.

advice from someone with experience isn't worthless. 

just stupid me decided to unpark my V3 and send it :(

Sorry about that..

>	M.
>
>

Thanks!

