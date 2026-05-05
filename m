Return-Path: <stable+bounces-244013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP3vIW+p+WnF+gIAu9opvQ
	(envelope-from <stable+bounces-244013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:25:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB64C8A02
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C163A30056CD
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D23E95B5;
	Tue,  5 May 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h9TrZAKP"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC43D565E
	for <stable@vger.kernel.org>; Tue,  5 May 2026 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969442; cv=none; b=DnPcfmlyY9TL+JTZN1ob6JuMVoZ7IIvw/XVS2ifcCkR6+nNp9RVlj8EKT9iF9iBcIOtAqlURGFLKZho3AOb5xOLwZGf2QzF2IlAgJA17vbyY4FhvxTzhEA6Ff7aeiNNhYRnVJLSrn5OmnrW06dDMhZ0trWShtYPRpwJQCFW1BQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969442; c=relaxed/simple;
	bh=tviv267WhZUlLMC9SxJZrfVicZ1SusoJ6Bx3/XXYOCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R1iIdjyucWTmJv5P6Ttmxxyu2Joov2rMb9E6ZS78Hryw+ZioFfznCzCo28AjLo+ewKr919SN7TzIJ7xrHwwuM9sCot/9RKt3CeqFket0jHMyuKa/dJCSoVQOoRcHRBb89YaMA2c3EOp+smqsw52j2j9afWQ3ERLxVoUVJcsCCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h9TrZAKP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6450F4E42BD1;
	Tue,  5 May 2026 08:23:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E80C5FD9D;
	Tue,  5 May 2026 08:23:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1973311AD2094;
	Tue,  5 May 2026 10:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777969437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uBIr3CQX6FUQHhQLmkVk7BnOw9CB7okApwAMfGpkl2A=;
	b=h9TrZAKPLIIAQmfpZs5cIBeWKoooSOKlwJoBXj6hj+mP5m81f4+hlzxtENpfxzL6Dx2MAk
	eDSbxdHC6GkoKPnJnPgqZkZ6WV4c1bkoa2/GvraXNtAh/rg5uwhXcK55jdzXfV7bIYtu0D
	QNZ0Y+uyEXFv8LnxzGL3P6VRZnOarWQrYpPUsXJa7hYLul4RudQdIjwkheu2ooe2Q+hCWH
	QinEgOeNF6j81iaQQGjhHwn/GYXtY8jGZviTURjSEQpdPXhGw3mL3Fv8esmMjaeJtqPfNf
	UgAiLDEpmUK0atl6MmkTYfG8wECFJBrkrHbnZZ3Sit2AGgn+lwcAWg152AdEWg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Frieder Schrempf <frieder.schrempf@kontron.de>,  Boris
 Brezillon <bbrezillon@kernel.org>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  rulkc@linuxtesting.org,
  oxffffaa@gmail.com,  stable@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: fix condition in 'nand_select_target()'
In-Reply-To: <335fad03-6113-4508-b28d-b21c7efcffe6@rulkc.org> (Arseniy
	Krasnov's message of "Tue, 5 May 2026 11:14:25 +0300")
References: <20260504221012.1310605-1-avkrasnov@rulkc.org>
	<87mryeqoqs.fsf@bootlin.com>
	<57b0cc2a-6d62-405c-bfa5-68d1c46dbad9@rulkc.org>
	<87h5omqntt.fsf@bootlin.com>
	<335fad03-6113-4508-b28d-b21c7efcffe6@rulkc.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 05 May 2026 10:23:55 +0200
Message-ID: <87bjeuqn6s.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: E0DB64C8A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FREEMAIL_CC(0.00)[nod.at,ti.com,kontron.de,kernel.org,lists.infradead.org,vger.kernel.org,linuxtesting.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244013-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]


On 05/05/2026 at 11:14:25 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wrote:

> 05.05.2026 11:10, Miquel Raynal wrote:
>> On 05/05/2026 at 10:59:16 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wro=
te:
>>
>>> 05.05.2026 10:50, Miquel Raynal wrote:
>>>> Hi,
>>>>
>>>> On 05/05/2026 at 01:10:12 +03, Arseniy Krasnov <avkrasnov@rulkc.org> w=
rote:
>>>>
>>>> Two important typos in the commit log :-)
>>>>
>>>>> 'cs' here must in range [0:nanddev_ntargets).
>>>>                 be                           [
>>>
>>> Hi, sorry, You mean?
>>>
>>>
>>> 'cs' here must be in range [0:nanddev_ntargets].=C2=A0
>> I meant [0:nanddev_ntargets[ which is the mathematical way, IIRC, to
>> indicate that the last value is out of scope/excluded.
>>
>> [0:nanddev_ntargets] means that nanddev_ntargets is included in the
>> scope of values and here since you are explicitly showing that it is
>> not, it feels wrong to use that convention.
>
>
> Ahh, Yes I see, just small misunderstood in math symbols:
>
> I mean: [A:B) =3D=3D [A:B[
>
> https://wikimedia.org/api/rest_v1/media/math/render/svg/0719b1b08cdf649e7=
35e6dab6dc7355fa37a9b21

Ah ok, didn't know that other convention, fine then, take the one you prefe=
r if
both are identical. Just add the missing "be" please!

Thanks,
Miqu=C3=A8l

