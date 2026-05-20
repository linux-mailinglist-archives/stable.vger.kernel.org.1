Return-Path: <stable+bounces-249795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIY2MVGGDWpdygUAu9opvQ
	(envelope-from <stable+bounces-249795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:00:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E18658B3F2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A6D0307E9B9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B883D1CA8;
	Wed, 20 May 2026 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMr3ejzB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313833B3C1A
	for <stable@vger.kernel.org>; Wed, 20 May 2026 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270918; cv=pass; b=UEMYGvJXLnj1mOWpGy4pCHoOzvAZcqbmfQpvS74HW3wtoDgzOj44CJr3fK7TnVF2mr7Tw+V5EwGNsugKLn8urzqCYyW5arnIbQxtLuQrnFASXlRTqdfoXNrE/LhfuNC8UCzYVqojRoHZMcD9Tmz2Yqet6gJ6dR0kkogeuv8wULQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270918; c=relaxed/simple;
	bh=aqk78QgJ104he+OWGbfDlhysznkZBUE8x0MvCqO2EdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnnLpYMpn7prUmRGCH26z4vQurdUuVQ+Yzt8yUTi091bbEZMoTXzJrIRqsfwH2vqJR9IwGhmS9geUP4TVsj4RuCGGdlcTro42MXZvgJs03CiC6z+HAzOQNKLES7Jekg0lfw5kkwmBk75tFHd5m7690VrDOTdEz2zd+j/vpcPnqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMr3ejzB; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-439cae0dc81so1119090fac.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 02:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779270916; cv=none;
        d=google.com; s=arc-20240605;
        b=HCVRanjryLjLf0Hz8gnJrwYUYK8PxnwqJpY8DCW3RwCR3Oz1gJe8yNJHzrfA5p0mHm
         kMKxi9pYE96VEn71u7mP+IAMqn4OP0vVzHIm64hcg4ZEF45ncsbfu+k2BvvK3Es825ut
         Y4dhuH+Nal8VON477JY7GbHIADWxPiPAVXZUQnep89eXX8Wkk7Yy6cIvTDwBT1RjjPU9
         MEFRO9g0iyfnJyEf9ONcFK2ZYtjnYG11As2dO1w+otIDYbOyNJ7yCKwr4osEoXWan8Jq
         RtwCYxs7j8MOd1FPeUEMgMbyOjXMcWuGeByLd+0nghxlW6IqSD/1xkomOpRBtrMC0gtM
         bdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aqk78QgJ104he+OWGbfDlhysznkZBUE8x0MvCqO2EdY=;
        fh=vYqjDj3srS9NhIdl+GE+cSGW6bgw+/ep7esPN4UWYLw=;
        b=MlDPolDjqMq/YF+a5/Mgv4YFaKSnCAZaeLsOxhjm4RFKF99P0BUeZpaR1xXcs2+R6f
         sZ86wqxUvW+N5W5PbonshtNJLp08A6JrgQAae3E+mVYkhMaax5FVDf6uxUZHqEVP+Eju
         50rCp/+8iDlp2J7GQZ/7qcxAwp/ooR6iMuq+fUvleeZszHcy8DsXp4qEJxWWNI1IrOsi
         iCnGM7uINnSU/V/b7Jg1+RjFR6j98ThicxJZ/HhB6asz32BQgPgP5Fc27oBqtcZv4K7L
         mhw4oNLsKXhjD59EOl7kOEd6TSXIKvxuoAA+r3c6qZUkliiopPhGVexz3FQU7qJvsGll
         Rq1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779270916; x=1779875716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqk78QgJ104he+OWGbfDlhysznkZBUE8x0MvCqO2EdY=;
        b=MMr3ejzBNVvIoAlR0TGaxSG/E6OU6K6uyPaUmN85APANsp5qPgimkLDttK//EJkVPY
         CTJCouFHyaWdaitnYASVw2xy3TR8HqmIWKXBWNKusKmzpUAz0fnVFhFsQ8sJA9SuijIv
         8fgIawurWtIF1f0Vs+J9L9kMBTHReAKpSW6Ed6Yap7OnD+NvOoYOGfWsNCbWaukcLjPn
         eWD0J11ZjvQzp02JKe7foIB2oFdOTomgFmJglAzunlUzaisIEOlal55tV5FusSjruzh3
         aJIJYwAg1x3N/AQmSVvMqUG56qqxcBzRePo6tJhxqCNg5YdKwWCAVr3EqdmJbodRVxR2
         EiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779270916; x=1779875716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqk78QgJ104he+OWGbfDlhysznkZBUE8x0MvCqO2EdY=;
        b=hOhPn5/9Q+pCoR+/Pmtq+8ue1Gmcb7mg1ikdhSB3UkNBedGLQZZw+IpBMaocLukINL
         j+xeNmXQssYWP9LkIpW8L1Y1CQ+hWn4vJwFxb2oRwTIXMx8zip8hYf3QByrIwX/K35WX
         qAgzgCpML2fy3zD4/v7NUbygx0cS5AEWP9X57nnwVOVXoSsFGWYM6Kn+6trJaLJ61jTk
         LSxii4ywd5ieu3Izmkkm4g3BDYepZ25qqMh5Gl2tCkORsgpMe7Xhhidzyo6pB+f/Jz6a
         QAKlqXiejrVkkljvc5AE9oZPUB3gU+m4QtCsNPQrgU2GHFJPXyrAQ4uzooeiyYAaEyOO
         cvEA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ui70Xfi/IYT/k9xYgrYbnIhai9udvRZlIh5OXKunZKVqqRH2EGsct7VLYQqZYKF5Kg2wIDF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUjW9IgkijfH7OXDHkvxPat0N6gsi6FNHLUPNPOMyoU8cqfgo
	w3rg+qOFhs4rck1v2INPnGyKcfn9+r4p68wRiLruiScMoyqW0+tGf/fTlgfi1tcvkzou5XpVRu+
	/o35E5ubs0DB/96kNH4dLqUIGFPTvGb60CzQTgclf7g==
X-Gm-Gg: Acq92OHf6n8iMYFFl2R20V3476s5FltLl0ciVAQj4LC/ETSQynciW8gn/s2oR1D5xpL
	r+NYb3mbuQBDGtb0qgWdPSNJ5vvI51Bz2dzsrNE4V5xON5JTVWXsMmat2i6N90p/lQs473DOaEV
	eZ+agu2/7s/VvPmxQy7zMc+rcb1D6OUMAcAhfuPg4/yFIEF2szM9SBUgByJoeTNl0Dr4DlsGRUg
	P6i6vsD+Uip8Cx2GiUUQmKYq2W6L2SXL7/lNGlYqnKa4YTObh+etnur9qWqGrRctwYep0GPHmvZ
	J+QxgB/y
X-Received: by 2002:a05:6871:85d3:10b0:43a:e061:c99d with SMTP id
 586e51a60fabf-43ae061e95dmr2646830fac.7.1779270916227; Wed, 20 May 2026
 02:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
 <20260519235713.49109-1-lucid_duck@justthetip.ca> <20260519235713.49109-2-lucid_duck@justthetip.ca>
 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
 <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
 <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com>
 <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
 <CA+bbHrUqh+nu_eKBMVaPH6Q8YxuKS=S0kON2Zsb+gRZHU=SBPA@mail.gmail.com> <e73634b3b52d9ebe6c4e339ea5f6c35cb6d433a7.camel@sipsolutions.net>
In-Reply-To: <e73634b3b52d9ebe6c4e339ea5f6c35cb6d433a7.camel@sipsolutions.net>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 20 May 2026 11:55:05 +0200
X-Gm-Features: AVHnY4Id6Yle6QkH4Hljq9XolpLHRYF8rDV8ZoJve7dZ581wt_uk2wJ9p8JWBdw
Message-ID: <CA+bbHrXtEdHEDHDb+8KNaKu=ODvkYwjiEEOtU2HntSRb8-WZ5g@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249795-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:email]
X-Rspamd-Queue-Id: 2E18658B3F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ok, I'll do the testing using this one you suggested:
https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.49=
109-2-lucid_duck@justthetip.ca/

Thanks.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mi=C3=A9, 20 may 2026 a las 11:53, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Wed, 2026-05-20 at 11:51 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> > Ok, let me do one final test using Johannes=E2=80=99 v2 patch. The expe=
cted
> > behavior is as follows:
> >
> > 6.18 or lower: no need to test, it will not work. It=E2=80=99s clear no=
w that
> > this does not matter, since the goal is only to fix newer kernel
> > versions.
> >
> > 6.19: some versions of the 6.19 will crash and others will not. The
> > crash was fixed at some point between 6.18.12 and 6.19.12. No need to
> > test.
> >
> > 7.0, or 7.1: the expected result is that there will be no crash, and
> > VIF + deauth will work only on 2.4 GHz. It will not work on 5 GHz
> > (I'll test both, normal DoS and VIF+DoS). There should be no crash,
> > but it will not work.
> >
> > So I'll focus my testing on 7.0 and 7.1 and I'll get back to you with
> > the results. I'll be testing this patch (v2):
> > https://patchwork.kernel.org/project/linux-wireless/patch/2025121611190=
9.25076-2-johannes@sipsolutions.net/
> >
>
> Thanks. For testing that one you'd have to revert the other first, I
> think, you could also just test this one:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.=
49109-2-lucid_duck@justthetip.ca/
>
> But I think they're basically all equivalent.
>
> Since we eventually need a patch to apply w/o reverting, Devin's is
> probably better than my old one.
>
> johannes

