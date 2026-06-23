Return-Path: <stable+bounces-267998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kr7OHKrVOmqzIAgAu9opvQ
	(envelope-from <stable+bounces-267998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:51:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0B86B986E
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:51:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=t9P1Hu1O;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267998-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267998-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C81C13065BF0
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C3348C42;
	Tue, 23 Jun 2026 18:51:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACD2DF15C;
	Tue, 23 Jun 2026 18:51:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240673; cv=none; b=MSxTg7t46UCUpeuLfb4nyVJmhIjNTQSvEMlZntFTcljJdy9aLipdDwVTMGnX/1/2wY5Fn/2C/5vDUddHene7ph7cdmISucukrQeegV1kh1MbFToD+E8NgqK9Rxe0UWErpiXczmZ7QG+xLheegh3KZlVfurJ9AA/b6y3ybtGjSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240673; c=relaxed/simple;
	bh=mA2uhvfC/x724eYMluHFeY+d4iPLfQZaUspe1Bc9LSo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hGi3z5pZrFGxi81X164Uauzpu6wqpAc5egH92Zkq9nthoQPkE6t7tTdECa7bFzoJLEsYJXCD2OixHLfUymMFcYfEMS4PZ5267suUX0098fx0iEcj/R3dVH3FlSqDbxk/TlRqMQq4hVfyUqJQn1Scu0maN+iIg4Gig//vtQ4pseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=t9P1Hu1O; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782240668;
	bh=xlRXCKKPWACvAnS4iALqH+JPpXRCzsovrB7Jtm/n3rM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=t9P1Hu1OLFc2SI0lw8Q1OSGHqJXhZIigwJmYPR9UQAtEWYqHKcpENs1qU70YjmqE2
	 GDRoWG/Mi67Tuc4U04Aa5cmTFENIk3xEnejiJaQws/ba5yQaz5XxpprgPeNQtke66S
	 m4P7JmELgeB/mfU6JvuVD1cnZvrxWngS8UfkcmFw=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glDg029xDz10ry;
	Tue, 23 Jun 2026 18:51:08 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glDfz65FMz10rw;
	Tue, 23 Jun 2026 18:51:07 +0000 (UTC)
Date: Tue, 23 Jun 2026 19:51:05 +0100
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>
CC: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev,
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_KVM=3A_arm64=3A_skip_pKVM?=
 =?US-ASCII?Q?_cache_flushes_for_non_cacheable_mappings?=
In-Reply-To: <86pl1hqiwj.wl-maz@kernel.org>
References: <20260623160339.15143-1-include@grrlz.net> <20260623163756.4591-1-include@grrlz.net> <86qzlxqjf3.wl-maz@kernel.org> <5925B41F-0F57-4BCB-9F93-7600878ECA27@grrlz.net> <86pl1hqiwj.wl-maz@kernel.org>
Message-ID: <95A8722F-D486-4030-BA51-9117434C6E63@grrlz.net>
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
	TAGGED_FROM(0.00)[bounces-267998-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:oupton@kernel.org,m:kvmarm@lists.linux.dev,m:tabba@google.com,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:qperret@google.com,m:vdonnefort@google.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA0B86B986E

On June 23, 2026 6:13:48 PM GMT+01:00, Marc Zyngier <maz@kernel.org> wrote:
>On Tue, 23 Jun 2026 18:04:07 +0100,
>Bradley Morgan <include@grrlz.net> wrote:
>> 
>> I'll go and do V3 with another sashiko suggestion. I'll fix your path
>too.
>
>Before you do that, please verify that whatever Sashiko spits out
>makes any sense. I'm not convinced by its reply on v1 at all.
>
>	M.
>
>

Marc, 

hi, I have verified sashikos concern.

I am out right now. So I will give a very short result.


Sashiko is being bit dramatic with the whole "Critical" rating, but it
is real in another way


I'll explain it in the code in about 30-40 mins.

Thanks!

