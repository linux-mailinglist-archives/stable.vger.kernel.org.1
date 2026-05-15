Return-Path: <stable+bounces-247674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMf7GcUHB2qNqwIAu9opvQ
	(envelope-from <stable+bounces-247674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:47:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCBE54EBBD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE5A430402D1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7747D954;
	Fri, 15 May 2026 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Xfo3wQyY"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7947A0C7
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845031; cv=none; b=ul5PAbNHj5bmPxjG3774cSbEzaKjYGK2OZM7joP+Q1ElhpfX4X/tXqN3Nltq/XmIQoDLqXh8um/Pls9nWgk3SIIBcdhlYqQzAk/O44ujxz8DPFBVHF3+4gHuMzxy4bOvcP3gUUDo4RTJIuSvyLu30j+exrlN7PSQIVufKBO4CRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845031; c=relaxed/simple;
	bh=TNwYpEF9CWg8saB7BXA8hYxtDJTdgPt+9R5BC+Bap2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7W/vOCJDT4Ns9fiLh/TDepAwoputpCsqKAQ4MoT0fkb6iYE65p/zLJ15fzOixtofxdocyRGm47GHxOW2CazNVHcuSuA/doVG3Bar+CnU0y88WIC1bYfWm0jHbAkjIlsseqNpdTQbnjPie7I/CVXg3sgsalOPQyWQne48hER8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Xfo3wQyY; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id D847021550;
	Fri, 15 May 2026 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778845028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijXEdZFQIcxLwybOVPtRHTo99A/QCfOyA9/6hsEikTI=;
	b=Xfo3wQyYOH+EjUkpn5edWJhlnuL7XpD3xIbS0ervJIT8GBy/L8c8JDyD2kp3hKvIYcVPxW
	XKMnrqAlYy39Ph0U9W4INOmtuBVdkpex1kZDdjQ7a321RdnBlT+DWbqgtUmZNZLjuZ1w6h
	vhSYAtKfOCdJNrWVgmNfHB5616a1rlc=
From: Sven Eckelmann <sven@narfation.org>
To: wangjiexun2025@gmail.com, bird@lzu.edu.cn, n05ec@lzu.edu.cn,
 tomapufckgml@gmail.com, tr0jan@lzu.edu.cn, yifanwucs@gmail.com,
 yuantan098@gmail.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject:
 Re: FAILED: patch "[PATCH] batman-adv: stop tp_meter sessions during mesh
 teardown" failed to apply to 5.10-stable tree
Date: Fri, 15 May 2026 13:37:05 +0200
Message-ID: <2004925.tdWV9SEqCh@sven-desktop>
In-Reply-To: <2026051555-germproof-bolt-6720@gregkh>
References: <2026051555-germproof-bolt-6720@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2312581.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 0DCBE54EBBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lzu.edu.cn,linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Action: no action

--nextPart2312581.irdbgypaU6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: stable@vger.kernel.org
Date: Fri, 15 May 2026 13:37:05 +0200
Message-ID: <2004925.tdWV9SEqCh@sven-desktop>
In-Reply-To: <2026051555-germproof-bolt-6720@gregkh>
References: <2026051555-germproof-bolt-6720@gregkh>
MIME-Version: 1.0

On Friday, 15 May 2026 10:44:55 CEST gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3d3cf6a7314aca4df0a6dde28ce784a2a30d0166
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051555-germproof-bolt-6720@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Possible dependencies:


I had a look at it but it would need get a backport of timer_shutdown_sync for 
the original patch. Then the version from 5.15 should work directly.

But when I've looked into the patches. I saw that there is a big gap already 
between 5.10 and 5.15.

Already backported in 5.15 (and could be used as reference for 5.10)

b0b0aa5d858d ("Documentation: Remove bogus claim about del_timer_sync()")
80b55772d41d ("ARM: spear: Do not use timer namespace for timer_shutdown() function")
5135c7150732 ("clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function")
6e1fc2591f11 ("clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function")
82ed6f7ef58f ("timers: Replace BUG_ON()s")
2249b9ec4232 ("Documentation: Replace del_timer/del_timer_sync()")
d02e382cef06 ("timers: Silently ignore timers with a NULL function")
8553b5f2774a ("timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode")
0cc04e80458a ("timers: Add shutdown mechanism to the internal functions")
f571faf6e443 ("timers: Provide timer_shutdown[_sync]()")
a31323bef2b6 ("timers: Update the documentation to reflect on the new timer_shutdown() API")
20739af07383 ("timers: Fix NULL function pointer race in timer_shutdown_sync()")

But between 5.10 and 5.15 are 134 patches which at least partially should be 
relevant for the backporting of timer_shutdown_sync.

For the moment, I will skip the backporting of timer_shutdown_sync and switch 
it to del_timer_sync() - which should work here because the re-arming will 
only happen by the timer.

Regards,
	Sven
--nextPart2312581.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagcFYQAKCRBND3cr0xT1
y/CuAQCfwMxekEiFk1mwud/7NUFtVqwAO5zveYPB7aMLhtyagwD6AzKGZ7V9NArZ
eD+WthTsnXzDW/baA9eB3978U1J76go=
=tERu
-----END PGP SIGNATURE-----

--nextPart2312581.irdbgypaU6--




