Return-Path: <stable+bounces-247626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK/AL5PoBmoHowIAu9opvQ
	(envelope-from <stable+bounces-247626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:34:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED354C7D0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62A133276006
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1056442B726;
	Fri, 15 May 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="a6N3SKyp"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801423E9C0B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836244; cv=none; b=Eln5+z1ilpuhCXwso55LGFWzIPElZjGZhRbavaJ66Sq6UPS9HC6V4WYj9MJmOv58ZTC1qrvjioJ2DYWptHaXUnGyJI5r6rPLaH38gIZ+RKQ57j1/T6raKQ4uN8ryXu6gzFean3FqTubRwquC676uvVdFtROxi+P5v2MgvWnWJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836244; c=relaxed/simple;
	bh=vPgjTKMunNzUxF0GBMb+Gm+Tn7Wghf/3sacNG7YtDHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BocAbzpqnDNazf43ZtZIKKYkRJIyl93i0vrpkdvvQeBiOxA4Cproogao3ncMTYDRwh2+8PPlT7SNtmk+1urgOMkth0p90qiiJL+58W2FAycs4uqyfmw9EOX7t7+F96XGLBvoFXxoyG5fCMLZMf/YroXAdWuvZqnH28WVV2r2ia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=a6N3SKyp; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8877520255;
	Fri, 15 May 2026 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778836235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRIScdjufny2yckBG3XmPA4VdhfhAyyNpC+MNTbSWoE=;
	b=a6N3SKypzqhygesmLvUnR91yCZ8kbo64BzPa6V8qzeNHVZsFjIy1HklSaASNHU0VI0kubb
	1flzYW3gi/rjTexum4QWEGNy7X+rYHXF5+3cu7tna2lIJxc5cSW5bxfQ2ZgpnaDDZvdg3e
	cK4WPqvF7Sc791vdbUpLdlLgYd0sDhY=
From: Sven Eckelmann <sven@narfation.org>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject:
 Re: FAILED: patch "[PATCH] batman-adv: tp_meter: fix tp_num leak on kmalloc
 failure" failed to apply to 6.1-stable tree
Date: Fri, 15 May 2026 11:10:30 +0200
Message-ID: <3081197.VdNmn5OnKV@sven-l14>
In-Reply-To: <2026051520-obnoxious-editor-0139@gregkh>
References: <2026051520-obnoxious-editor-0139@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2096374.PIDvDuAF1L";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 19ED354C7D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247626-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[narfation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~]
X-Rspamd-Action: no action

--nextPart2096374.PIDvDuAF1L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Date: Fri, 15 May 2026 11:10:30 +0200
Message-ID: <3081197.VdNmn5OnKV@sven-l14>
In-Reply-To: <2026051520-obnoxious-editor-0139@gregkh>
References: <2026051520-obnoxious-editor-0139@gregkh>
MIME-Version: 1.0

On Friday, 15 May 2026 10:45:20 CEST gregkh@linuxfoundation.org wrote:
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

@Greg, I will take care of backporting the failed batman-adv patches in an 
hour or so. The steps you provide in the mail are always super helpful to stay 
focused and do everything step by step. 

But I've noticed that on a shell with "extended_glob" enabled, the shell tries 
to match the last parameter because it sees the '^' character. Maybe you could 
also quote it too:

-git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
+git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Btw. I've just disabled it here on my shell. But maybe this is still 
interesting for others

Thanks,
	Sven
--nextPart2096374.PIDvDuAF1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagbjBgAKCRBND3cr0xT1
y6qVAQDlNG+fzpTOUzVF8k2vT0wDAO3FzzSq6LFX58PEXUo1igD7Bh1V+BVsYS1O
ooo0kTGRsAbUS9wuI+rTve2uKIalsg0=
=PJ60
-----END PGP SIGNATURE-----

--nextPart2096374.PIDvDuAF1L--




