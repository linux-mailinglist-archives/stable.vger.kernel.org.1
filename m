Return-Path: <stable+bounces-262032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id exrTEw3BJmoQkAIAu9opvQ
	(envelope-from <stable+bounces-262032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 15:18:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB0065688B
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 15:18:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=DaAOSI+g;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262032-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262032-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD327300A4AE
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8A33DED9;
	Mon,  8 Jun 2026 13:17:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A830675D
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 13:17:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924675; cv=none; b=jdJ/dcnCMZy92uUOn5yxznGWPU19slcMRGdtHomJCvZbwpOe2vCwezrPczke+eFzCiFVcIcCWDyjvkdlny4WC3l+DXStk3Akk/7d5cqnVLOqgMlUof1CiOLCCKNBH1qApAmF8Owjg+Aj/A3R32wpfnuGdfa3mhvU8/UxnybeVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924675; c=relaxed/simple;
	bh=557A4rslfuELDPas1rUlSRtz7XC3ubYCXfKrEJMIPQc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=YFH1aNFkw+35UNhNuzO/Y2NkwvBnjx1NayshmjL9mxxf85uqtErOAJpIXG8//PczyG5efWhmDHMcSmjtclC8pQIqfz8Nq5X9wCiBjj2I60ohtoFn49tM6kwEI+JnTxUrXz1OVx52Gjerv1ri/i4gjni3xrLUkU8awzqWN6wNMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DaAOSI+g; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DBEF7C5147D;
	Mon,  8 Jun 2026 13:17:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3F135FFB7;
	Mon,  8 Jun 2026 13:17:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9FD6106A28B2;
	Mon,  8 Jun 2026 15:17:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780924671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pJlyIZJnB6mb5l3T1DHISpp+MXT5INLcjb7JHMUtO0g=;
	b=DaAOSI+g80z5cTwL/GBPQ9XJdZTtV1sZMoVO5UNLlYabQK9S89Xcda7wQbx6s0ZSGX4gZR
	CRUwLC9UB5NIlq2KtC8tbUPpmkiuvG8nSqufJb5aWBtJgFYD/wT6L+N2Co5On/k/01dupR
	eJNR+ZqLzg2C3Q6CwLi+LfXO+lv3mh4HpNiRCj2PUQlkcL2g+011aTAZ/QOxUvs8PTtBhL
	8gpYadJfsAQpr4icSs747vpt+Cr92f5RKJn2EBc7iuMPZWjN9ugp6Jc95qbzI5/CLJvGrC
	/+pES53rUebayKSFaM0q3PYngkLtnLqG33IkwNytdkcCmhG3w4gotpvMoilAjA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 15:17:49 +0200
Message-Id: <DJ3P3UDLPP2D.X4DC9XWSHPR7@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Srinivas Kandagatla" <srini@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] nvmem: layouts: Add fixed-layout driver
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com> <20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com> <a13529db-a85a-4cee-9269-17c0f8fc9781@kernel.org>
In-Reply-To: <a13529db-a85a-4cee-9269-17c0f8fc9781@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262032-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:miquel.raynal@bootlin.com,m:gregory.clement@bootlin.com,m:thomas.petazzoni@bootlin.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mathieu.dubois-briand@bootlin.com,stable@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c09:e001:a7::12fc:5321:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[100.90.174.1:received,212.83.139.233:received,2600:3c09:e001:a7::12fc:5321:from,185.171.202.116:received,212.83.136.155:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.dubois-briand@bootlin.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,185.171.202.116:received,212.83.136.155:received,212.83.139.233:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:url,bootlin.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDB0065688B

On Tue May 19, 2026 at 4:59 PM CEST, Srinivas Kandagatla wrote:
>
>> -static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct d=
evice_node *np)
>> +int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_n=
ode *np)
>
> Export this in this patch itself.
>

Sure, I will export this here.

>> +
>> +static int fixed_layout_add_cells(struct nvmem_layout *layout)
>> +{
>> +	struct device_node *np;
>> +
>> +	np =3D of_nvmem_layout_get_container(layout->nvmem);
>> +	if (!np)
>> +		return -ENOENT;
>> +
>> +	return nvmem_add_cells_from_dt(layout->nvmem, np);
>
> np is leaking here.
>

Right, thanks for catching this.

I'm going to send a v3 soon.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


