Return-Path: <stable+bounces-229531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAhgIsRpwWmoSwQAu9opvQ
	(envelope-from <stable+bounces-229531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:26:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 250812F8179
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10F8D30C01F1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE83B0AE2;
	Mon, 23 Mar 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="h1ep4pQX"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB13271A6D;
	Mon, 23 Mar 2026 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280953; cv=pass; b=GElMOSDstTAMg8xUIXx5mAd38DWrwbkT7FLMTKE3Sr4k45tHG5lrYpFM4B/t44qL5KcGaYNRCBQxD8B3p4qmhHQkifh0xmUkqg37DN3mOB8sW+OhHhO3nOyyqWK+uXU4c26ceRiDNW+PioOOVse5gT9bHcl8O0JhevM0vUiiRR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280953; c=relaxed/simple;
	bh=MNBbzdy1wv3q1CYXJr0qV0f8cJFDu0KPsiy5VWDC70s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Qw8m3Sy6tE1JNxyapbuW/sjLl7/Y6ZfQSAhJshVa5RKuSl8g+ustDY9SeEswsLwPFRLMrIqkwByyrEk13KO8WWfJ5qp+qNiegF2Z86SvQ7rAvXj2prxb1GFiPtS4bMd4w2w4DL9SnJA86sYTe/iklPjRjvB3zLnqCNRHokoxQTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=h1ep4pQX; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774280935; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CbbjtYdP4E/xtQsdx3+okOUtXQbDc1SOiN2xE5WVEx3gtwbaHTWnmiUI+O+Bu0YGcE62s7SdpU31AwicDgN48WX2m/VJL4HNVJCzEzyS+mxo50jZFFf4CTWqpVivGNjggjiessfXPh8E8z9Frl3k50miXdngG5kC+3evfp+yn/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774280935; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wqFlklrlq8f8GMqCaRA6JQDMLtlxicYYgk8CIa7235M=; 
	b=Lr8dxg6nZ+YV+G76OS6FVPIFay0DIb7cR4jWx7rnCHdWTRsVnLRACWjziBMldZS9hLmDcsHzVBfZGUXlOEHaArtg0ZsZ/OHdN1dfc964cvIOTKXeW6UtcqBU3I827jgKmbiIllpIPQ3UTQLcuwecNlNEKNiLis01eyyiovJltOk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774280935;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=wqFlklrlq8f8GMqCaRA6JQDMLtlxicYYgk8CIa7235M=;
	b=h1ep4pQXMZO6jnepVRwIj5Sq2N/4vnOJYX3HjjR0lvSgWDXwhiY+ZFeK+S4tLFFD
	HKf32O7YMlbpCS+Flqlrzraez6QkbbpSJdbL+MbFy8dzhR93yHbHgQIm56slZABrghd
	kOVHal1wxL0CJscvM9ZNVZMDVXGBl6qO1BCgibEQ=
Received: by mx.zoho.eu with SMTPS id 1774280932246117.62916547273733;
	Mon, 23 Mar 2026 16:48:52 +0100 (CET)
Date: Mon, 23 Mar 2026 15:48:52 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>, Markus Elfring <Markus.Elfring@web.de>
CC: damon@lists.linux.dev, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bv3_1/3=5D_mm/damon/sysfs=3A_fix_param=5Fctx?=
 =?US-ASCII?Q?_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260323152453.81603-1-sj@kernel.org>
References:  <20260323152453.81603-1-sj@kernel.org>
Message-ID: <96C00873-532D-4108-8FAC-80BAEB5D503F@objecting.org>
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
	R_DKIM_ALLOW(-0.20)[objecting.org:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229531-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,web.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[objecting.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,objecting.org:dkim,objecting.org:mid]
X-Rspamd-Queue-Id: 250812F8179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 23 March 2026 15:24:52 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Mon, 23 Mar 2026 09:25:52 +0100 Markus Elfring <Markus=2EElfring@web=
=2Ede> wrote:
>
>> > Markus these patches are already merged
>
>It's still in mm-hotfixes-unstable=2E  We can still make changes if neede=
d=2E
>
>I understand what Markus is suggesting is adding another goto label to ma=
ke
>the flow cleaner=2E  Because this is a hotfix that aims to be also applie=
d to
>stable kernels, I think the change is better to be as simple as possible=
=2E
>Adding another goto label could make it better, but I'm concerned if it w=
ill
>make porting difficult=2E
>
>IMHO, it is better to do that as a followup cleanup, rather than make cha=
nge
>into the hotfix=2E  Let me know if this change is somewhat critical and I=
'm
>missing that=2E
>
>>=20
>> Are there still development interests for the application of a better g=
oto chain?
>
>Sure, if it makes it better, why not? :)
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Yeah, I understand where he's going with this, but I'll possibly make clea=
nup patches soon

V/R


Josh Law

