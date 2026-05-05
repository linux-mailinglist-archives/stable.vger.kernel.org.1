Return-Path: <stable+bounces-244260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIKMKN5O+mndMAMAu9opvQ
	(envelope-from <stable+bounces-244260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 22:11:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F33634D37CE
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 22:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E87330DA748
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 20:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E343D9025;
	Tue,  5 May 2026 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lj0pDdPs"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6A2DECBA
	for <stable@vger.kernel.org>; Tue,  5 May 2026 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011491; cv=none; b=t01cVDjYTZirx/rNkyNh5szW8UL1lKGTQcJelkmxoijeKiIWH48mu0VO210gQsC60tiLDQBwg9vzv/PmjibZQwED7NKmXSlqRy7Wool/U10Q5LZoml0lYQyofOCr8BVACbC4QUWrL8rbKqEUMCmyenQfg21J1fLG9s3EJ7Txzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011491; c=relaxed/simple;
	bh=MmoaovAWFRTFBc9PhK7nEaBrmzdaJ4bRRxyyepxPf8E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=G30+/Ck8Gx9ZYeuXtAD5yn802CoavwNmt2APoV2C+ts3NCbRET8kpdO3vRw0UMSCfeb5IjUblnx9XM/uXn0VxHhbRMRlrd3XfDax2lXAvl/rkgFPCWLufWWOIiCzbCnS9alScnwXnkBthNInFn+7hlIFqkGZWT9lcxSJcDTxySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lj0pDdPs; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 05 May 2026 22:04:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778011478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmuVpxHvRehCyVtpfMoFPpSUr10pei5H6v2Vlv6Qqls=;
	b=Lj0pDdPszd8Z3lXZtbgHowUHmW48SAGb+yAihyKn8hs3mcj4GQkEHLFqpNBXKSvVfXq/Ud
	iQZBF4KPW4Bo7bpa+z7oG8AwoZvefR2MhLiK/e0Pj3fDrqNNsbMVj11/v64y6I0IkUPTYl
	kT545uRzttloJNlHtLV9gMWKgrsw/X4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>, Feng Ning <feng@innora.ai>
CC: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6=5D_staging=3A_rtl8723bs=3A_fix_hea?=
 =?US-ASCII?Q?p_buffer_overflow_in_cfg80211=5Frtw=5Fadd=5Fkey=28=29?=
In-Reply-To: <2026050434-unpadded-sandstone-0412@gregkh>
References: <20260413113224.5201-1-feng@innora.ai> <2026042626-tabloid-suitor-33c5@gregkh> <20260427111738.33069-1-feng@innora.ai> <2026050417-monkhood-backless-4c3e@gregkh> <20260504154823.52057-1-feng@innora.ai> <2026050458-numbness-haven-1ae4@gregkh> <20260504163828.90294-1-feng@innora.ai> <2026050434-unpadded-sandstone-0412@gregkh>
Message-ID: <F9E617FC-FE79-4EA7-A5FD-004997CC127D@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: F33634D37CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244260-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,linuxfoundation.org:email]

On May 4, 2026 7:01:00 PM GMT+02:00, Greg KH <gregkh@linuxfoundation=2Eorg>=
 wrote:
>On Mon, May 04, 2026 at 04:38:35PM +0000, Feng Ning wrote:
>> On Mon, May 04, 2026 at 06:03:02PM +0200, Greg KH wrote:
>> > Let's fix this in a way that the code can be moved out of staging
>> > someday please=2E
>> >
>> > > That said, I can see the argument for -EINVAL: it makes the contrac=
t
>> > > explicit and avoids installing a key with a truncated sequence coun=
ter
>> > > that could produce unexpected crypto behaviour=2E
>> >
>> > Yes, that is better=2E
>> >
>> > > Regarding hardware testing: I do not currently have a physical
>> > > rtl8723bs device=2E
>> >
>> > Ideally someone can test this on the real hardware=2E  I'm loath to t=
ake
>> > real patches for this driver without that happening=2E
>>=20
>> Hi Greg,
>>=20
>> Thank you=2E  I will change the silent truncation to an explicit -EINVA=
L
>> when seq_len > sizeof(param->u=2Ecrypt=2Eseq) for the next iteration=2E
>>=20
>> Regarding testing: I do not have access to RTL8723BS/BU hardware to
>> verify this, and I will not resubmit as a regular PATCH without a
>> Tested-by from real hardware=2E
>>=20
>> Would you prefer I send the -EINVAL revision as an RFC on
>> linux-staging and linux-wireless to ask for a community tester, or
>> should I drop the patch until someone with the hardware picks up the
>> thread?
>
>Submit the patch and ask for someone to test it=2E  I think Luka here sai=
d
>they were getting a device, and I might have one somewhere around here
>as well if I dig hard enough=2E=2E=2E
>
>thanks,
>
>greg k-h

Hi Greg,
my hardware (medion akoya s2218 laptop) is currently on its way from=20
Germany and should arrive in approximetely 10-14 days (approximation=20
is based on time that it took other orders to arrive from same area)=2E
Once it arrives I would be happy to serve as a tester if necessary=2E
Best regards,
Luka Gejak

