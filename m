Return-Path: <stable+bounces-214890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iErWASuYiWmk/QQAu9opvQ
	(envelope-from <stable+bounces-214890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 09:17:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C8810CD77
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 09:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7282430131FE
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682653090FB;
	Mon,  9 Feb 2026 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R8k2Zifh"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FC3090D7;
	Mon,  9 Feb 2026 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625039; cv=none; b=XB0ao7geFW+BJDCNOgQUy/1yukV5w8sKTToMexFNno0yPiXiUAIWDICA0bMo2bRdsRBawqOLpMm+WEHhyYuo1ev4ocI+MUByiWgnajn7IAEvgDPaOHmsqBgg3EvWIcRZmqw9v/XnMqPE5kMdy+KkR0LQiQhUpsH7moghL4Vvyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625039; c=relaxed/simple;
	bh=YKgVZomkOLmkBz6nw6J99Us56IlFowMmpztGt9teo7s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Je0w8LNtWeif8GZdcCXdY5G8+899s9z2fPqerAZ8DZL63HmJ2+xd7nYiEdpQYGzoPFSIe/gJOQ0+PJHdGOsFGM9Ku0oG7lAWcX3+2gxKO07AzxsN7tHKQVFwBY7FpF2+9BzgC1bYXKPcxEbwQ99EIESScL9UTwZWVJ1AuCVH4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=R8k2Zifh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6198GUiF2695348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 9 Feb 2026 00:16:31 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6198GUiF2695348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770624994;
	bh=MF36z5sKIMBwhrN8X5kJGQR9AralqaU6iXF38KHiIWk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=R8k2ZifhG2pOr6DnnSzssnjLS6Rdho2Oaly4pl0dFp+RfIj2c4tEyitZomrJKEReq
	 P02pBqh3FL53BQSZqYT4t/2IVT1QuxKHGSzi4oxDcAQ/Mfg/2uZC7Rbdard2xcsCAl
	 uplcPah88aFLVETfXrmWfZ9Nksp/tcro96lUHRs+Z9zx0aDsWMebpcJ+RyMKn3G2a2
	 JF8a+A8ZyHmk7HSWpSuR3clzWTahGCUbNxrOgaDiNl5Nw4DXb9BBFZdTgB73Ym5C8C
	 ZFSFVNQSzkJuOS0AIUgGUYRkvQATWT6wuWMNEDRDEvY0I+68Nzg1X6qolHxQA+EUH1
	 DJcoSqZL2bupg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v1] x86/smp: Set up exception handling before cr4_init()
From: Xin Li <xin@zytor.com>
In-Reply-To: <37de06e1-aae4-4ebd-ac93-1846ee4cd91e@intel.com>
Date: Mon, 9 Feb 2026 00:16:20 -0800
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, nikunj@amd.com,
        thomas.lendacky@amd.com, seanjc@google.com, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E3DA211-BD18-459F-ADDE-63E24E8C8BEA@zytor.com>
References: <20260206185035.1250577-1-xin@zytor.com>
 <a7be319d-381f-469d-9d5b-ddcf43d884e4@intel.com>
 <DAF4D431-5596-4FD1-BF8B-D7D753C0810C@zytor.com>
 <37de06e1-aae4-4ebd-ac93-1846ee4cd91e@intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214890-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[zytor.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xin@zytor.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:mid,zytor.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55C8810CD77
X-Rspamd-Action: no action


>>=20
>> I=E2=80=99m curious why cr4_init() is not part of the following =
cpu_init()? IOW,
>> why does it need to be called so early in the existing code?
>>=20
>=20
> The name cpu_init() is misleading. Most of the pinned features don't =
get
> initialized in cpu_init(). They are set up slightly later:
>=20
> start_secondary()
>  ap_starting()
>    identify_secondary_cpu()
>      identify_cpu()
>=20
> The original reason for writing CR4 early on APs probably originates =
in
> commit c7ad5ad297e6 ("x86/mm/64: Initialize CR4.PCIDE early"). Then,
> when CR pinning was introduced, it was a global system-wide concept. =
So,
> the pinned bits had to be programmed when the first write to CR4 =
happened.


Thanks for digging into it and explain it.


>=20
>>=20
>>>=20
>>> I _really_ think we need a defined per-cpu point where pinning comes
>>> into effect. Marking the CPU online is one idea.
>>>=20
>>> Thoughts?
>>=20
>=20
> I think this approach could work. It should cover APs as well as =
hotplug
> CPUs that come online later.
>=20
>> It seems a good fit.  Just that {on,off}line() are not called on BSP =
(not
>> a real problem).
>>=20
>=20
> The BSP is marked online in boot_cpu_init()->set_cpu_online(). So, it
> should be covered as well.
>=20
>> Question is that who would work on it ;) ?
>=20
> I think Dave already posted the patch for it here.
> =
https://lore.kernel.org/lkml/02df7890-83c2-4047-8c88-46fbc6e0a892@intel.co=
m/
>=20
> I will test that out to confirm that it doesn't mess up some implicit
> behavior.
>=20

I=E2=80=99m not sure if Dave also wants to make BSP/AP boot code =
symmetric at the same time ;)=

