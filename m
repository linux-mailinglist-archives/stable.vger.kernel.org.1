Return-Path: <stable+bounces-262832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T8Q/LDFVK2pY7AMAu9opvQ
	(envelope-from <stable+bounces-262832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 02:39:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD9675F67
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 02:39:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=bNCUDtnc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262832-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262832-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE7C830E93C8
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E2629D270;
	Fri, 12 Jun 2026 00:39:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4E26E6F2;
	Fri, 12 Jun 2026 00:39:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224747; cv=none; b=qptJEh+QEkB/eNug9JocJlf9Clig7NR7xt1gDdcz7Bi18hNu0pC7L1DhatQ8mirG7R2gZSqI7HdXi03FxwAVxFceOAzKOc7jrS6MhiaW9LgM6xDXckUOmmu+9/9wSZ3qxOaHpwIsSclOPZhxFY0Z2vf3WwAj1VrPUwNGuKsEIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224747; c=relaxed/simple;
	bh=izL0j4eEPLcRk3oT8/yUGunO6coycfc6sbBDJ25Cu4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f0cnNHhjj3LwkZh6Xmjydm+bphDEam6UKljeg5rU6cr0PeYOwqqkoN+TagBWdQ52QWzW2CuS5LHlcfh90+xbVGK+B8vovnfVCjGREcG5/ptBJiQvq0D/X7eeq03OadY9Zhv5BFb6ZhZmo1+0fpXms+/PoRw3DI1Ra8M/ckxzuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bNCUDtnc; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781224742;
	bh=izL0j4eEPLcRk3oT8/yUGunO6coycfc6sbBDJ25Cu4Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bNCUDtncB3TwH5DnGhWuYj9Awj9cB0VYxeNn+Bh+3DPjyU4iCsRDrBAz7lyShcWek
	 4OXgORZBkvjDoRCXol7F11hZu7b+EvOKUfM/sT2ewNRdRBLc9viKBvI/rV9VpjfBEQ
	 BCByz5Id+HGAlSwdI9Ruh/Kd/amKdbqe6RqHdK6XiuAoID9kQryoAJdn0tkGJM6KB3
	 rOoVwv0mvT7iiZFt4491QSTiuY87OPylPaFDc4CZXY9gG7a6l12QB7Q9L2HVo6c7Cj
	 gTBMRvJOE2U3+J8jqzqDHYggMMwYwOS3b4Vz1GC13aR2A4i+ONLuOo/iNoZ7DZ2QsA
	 XPrqaEgokFjKQ==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 45D6E60931;
	Fri, 12 Jun 2026 08:39:01 +0800 (AWST)
Message-ID: <7db557b8f6fc5751b19b148fc6afc4ad7ec2d1e1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: karthikeyan K S <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 12 Jun 2026 10:09:00 +0930
In-Reply-To: <CAP_JKPu9MTpMUZmg9BY3sxGhmBzgR0E6HnvAT7sQjVUpQp0dSQ@mail.gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260610172310.163321-1-karthiproffesional@gmail.com>
	 <64f8d88bf4cd72d8120baaa304dfe34bb66cbe0b.camel@codeconstruct.com.au>
	 <CAP_JKPu9MTpMUZmg9BY3sxGhmBzgR0E6HnvAT7sQjVUpQp0dSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262832-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:karthiproffesional@gmail.com,m:joel@jms.id.au,m:andrew@aj.id.au,m:kees@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-aspeed@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@codeconstruct.com.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@codeconstruct.com.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24DD9675F67

On Thu, 2026-06-11 at 23:01 +0530, karthikeyan K S wrote:
> Thanks Andrew. The __guarded_by annotation and context analysis integrati=
on
> look good, I wasn't aware of that infrastructure.
> Thanks for applying those changes on top.

Sorry, on reflection I chose my words poorly there. I applied that
patch I pasted on top as an experiment on my end. I haven't yet added
your patch to the fixes branch.

Do you mind integrating that rework, testing, and then sending the
result?

Cheers,

Andrew

