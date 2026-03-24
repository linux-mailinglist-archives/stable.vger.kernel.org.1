Return-Path: <stable+bounces-230189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAMpKoWtwmkyggQAu9opvQ
	(envelope-from <stable+bounces-230189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:28:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30F31802F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F05030338AE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB9405ACF;
	Tue, 24 Mar 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="KolOZT9B"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E940245E;
	Tue, 24 Mar 2026 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365847; cv=pass; b=GDt6cnRwdOesFiecnneu1QWHReN0casu2clVAL3pXtVMDD5ZIycmamStvCqIaeK3583b5JZ5Q3rLBaHDYQ9UWz4T4jTN821lBJ32GSHGXH8lxZ2Ul3z7qTteCGGweFMtyLYMdgHRDgBqUoN0sSY4dOcsgqE80ntvGGq15bN255Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365847; c=relaxed/simple;
	bh=VlKJv8dWJlaHJHXMlIE4BSaindyrxVSs1O+vhEZ+g8c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YFYKnBFa5TfDkeNJUZvFj5K4LYKeV8A8ucl7fKAlJLX9c4k6bMObXitp5RWrp2r5rMstJphCXETcIL758slzvHNa+nh5jrkMVh9IOJs8jnuvdH8MPliykc/XiVEz/6mfu1crWW+47UVFX88x17gUbEMBG3hy0/k+yc9jaYLztQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=KolOZT9B; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774365816; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LXnBElSlmUVOrfZCAPwDY2tQIouurVoPwZUIhJLFLvx2B3n/wAomA5p66z4W5YhRuPPZVlHz1b2xm8/BylsHNnbizEmjsXmqTJQZ77bZhjqQVxk1McAwqWbcmcbQOKhZKVw7V1Qynpczh5krRlc2nHn6CTwSn2cMy7BFusVznAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774365816; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rQNo5gRq0ttu6AMLBxnpSMS80bStRyQxiFciq1sROUE=; 
	b=TfZLL0eSC2/ECusdMMCaLHdOD4bcdbxvqD6XIXLloSN3zp9hBkOKTMHLbqRoP4eiOXzk6rTNnIbp8Fe5pvZx2zVZopGgDzXfVHw4c8Z4rQFKKJ5/kJ3nbvMd+JNYQHhNZ/pUbcgh4zICHdG38UszPTyT2bnBFOVYu6TuhJRFaug=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774365816;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=rQNo5gRq0ttu6AMLBxnpSMS80bStRyQxiFciq1sROUE=;
	b=KolOZT9BTJENIDtAt4aXF1Erxgz3JzZtMBddJDw2jJpN1qq+rA0c4ZZOb8pDyW03
	H5pUyxGV/5kEJHj0/pqe/E3bASlrrql7JRLOLl5J+3UPGNoel2NchA5WH9yUKPdNffU
	Jvtex75qYDkDYeqmV78FOhvrIGNnBQRrZRjh0yfc=
Received: by mx.zoho.eu with SMTPS id 1774365814980617.8320820549221;
	Tue, 24 Mar 2026 16:23:34 +0100 (CET)
Date: Tue, 24 Mar 2026 15:23:32 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: Markus Elfring <Markus.Elfring@web.de>, damon@lists.linux.dev,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bv3_1/3=5D_mm/damon/sysfs=3A_fix_param=5Fctx?=
 =?US-ASCII?Q?_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260324141537.91434-1-sj@kernel.org>
References:  <20260324141537.91434-1-sj@kernel.org>
Message-ID: <7C2341EE-3CBE-42E4-8D2F-341137CC6234@objecting.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.95 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[objecting.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[objecting.org:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-230189-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[web.de,lists.linux.dev,kvack.org,linux-foundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[objecting.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A30F31802F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 24 March 2026 14:15:37 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Tue, 24 Mar 2026 07:06:25 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>>=20
>>=20
>> On 24 March 2026 00:14:59 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>> >On Mon, 23 Mar 2026 16:48:19 +0000 Josh Law <objecting@objecting=2Eorg=
> wrote:
>> >[=2E=2E=2E]
>> >> Also, unconnected to our topic!
>> >>=20
>> >>=20
>> >> I've tried to backport Damon to 4=2E19 (for a personal android thing=
, and failed! Of course)
>> >>=20
>> >> Can I have a bit of help if that's fine with you? The tree is based =
on GitHub a bit
>> >
>> >Sure, I will be happy to help as much as I can without burning myself =
;)
>> >
>> >Seems [1] Alma Linux has backported DAMON on their 4=2E18 kernel=2E  M=
aybe you can
>> >try their port first?
>> >
>> >Also, what is the oldest kernel that you have to use?  As newer it is,=
 the
>> >backporting will be easier=2E  When I was in AWS, I backported DAMON o=
f v6=2E7 on
>> >the v5=2E10 based Amazon Linux kernel, and the source is available on =
GitHub=2E  So
>> >if you can use 5=2E10 based kernel, using that could also be a good op=
tion=2E
>> >
>> >[1] https://oracle=2Egithub=2Eio/kconfigs/?config=3DUTS_RELEASE&config=
=3DDAMON
>> >
>> >
>> >Thanks,
>> >SJ
>> >
>> >[=2E=2E=2E]
>>=20
>>=20
>>=20
>> well android likes using old kernels for some reasons, especially LTS, =
so 4=2E19=2E=2E
>
>Well, but the long term support of 4=2E19 has dead a few years ago=2E  Th=
e oldest
>LTS kernel of today is 5=2E10 [1]=2E  I understand some vendors might sti=
ll use
>4=2E19 kernel, though=2E  Anyway, let me know if there is anything that I=
 can help=2E
>I will try to help=2E
>
>[1] https://www=2Ekernel=2Eorg/category/releases=2Ehtml
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


The device itself is unsupported (Galaxy S20 FE)

I've been working on a kernel for this device for quite a long time=20

V/R

Josh Law

