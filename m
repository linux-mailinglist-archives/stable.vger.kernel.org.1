Return-Path: <stable+bounces-241815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCH4FdqI8WnNhgEAu9opvQ
	(envelope-from <stable+bounces-241815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:28:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF748F332
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FE96303F7CB
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E29E389472;
	Wed, 29 Apr 2026 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QPOCbFHL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAF169AD2
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436887; cv=pass; b=Njc+c+KcIukk/FLMakcTVV+/i6rdjiGckIYtdqaG1AmSReJQXo10L7mwm814ChIMzgywn56IOwro77DQft36GNw+kJ4gb3RDYw8h5k0fmo+M33+bdxRkm6+ezcdV50bQgOiIiFQnkMWfSCSyLcH85K/hRd44O/jmucTYOUqJi0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436887; c=relaxed/simple;
	bh=72+7CylRj1EOV6kfHwAZAuBZhDPTYvm9NqEzFA4Av7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwgNfhS/vSe21wVUdbCTsngRucQ4wKSJcpDV/X358+a9VP7oe6JGNtK1PZZiyITgI6IL9/IyEB+GzZy0qzx4aNTskgQxJwsGh7iDUCCyZdcPhtPqX+TCTyGLl+8l0KVqTTqVGMYO/x9NeGBSZl3NrDYzXHGnxIWwzwnl64cS66Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QPOCbFHL; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba51e69988aso1664428366b.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 21:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777436884; cv=none;
        d=google.com; s=arc-20240605;
        b=bOMfKCOYHi7v5desNO/wTXAncz9VYmpJdejwxzQAXitAb8DFGZFH+naAa7CtGGaJTy
         TloveCgUmUw45uotSfHOiBiJIsufMeyJf+GiefwOY3S9xZJNBS2YDojqlWn4+G5X0sCu
         X6Z+E+iwBe+p9VO4qPnHL2hvWNKJ50Ntz1EO3WvSESvOnU0uncDRdIRQUjJiLu2phepd
         cSj6ur+9LVQo8w44c5yeHtdnBnNmWpxW5fGhSHEYNMm2HQm/8wC8WSJMpN5sRYe7oysI
         fVg/7H251XAau7vRxeYc6xuJKDSx1XuOb/Fg9BvEq4yrNA1+CLTdreqPnB4Ltt0LnMAH
         hQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tCgZRNaYmJSPykbMYrzfut5EXQOeSzWA5g56k7ae8hM=;
        fh=Z9xCnzUzMBop9T3fZaQZ9tBzxf1BGVajxjWoSCj+LFo=;
        b=cvIdRhmbcC7Q06FaeX7UtK6WGcr0nXk/PTcY6KdDu90ua6Y8i+Hd8uEsuG2mXguqow
         5zNbMG8TZ9awm1sVcbpnjc5S7Qzn49N6Rp6jdp9orU6g5Gun0LFYS37JE/XjM6GtzckJ
         pIM2qJfwjlK+mZ25OqiFoEyvknzWow+iDVL8FgU3AJVTBqvcSJVl4+16LO2GNc5hrK95
         OZH8FyMRsRGCS44eYgwJ17EBHZnMr/PqA8UIqp0oK5bVtOehWyM8WMIcitHPeyt17XCl
         DghESZFb7v/totvCY7MXEq5c+JbPwjKs5vV1lFwdMWz19pSHnJMLWhUjdhqny2yBF6on
         pleQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777436884; x=1778041684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCgZRNaYmJSPykbMYrzfut5EXQOeSzWA5g56k7ae8hM=;
        b=QPOCbFHL+hCKbFJZZzmvsJWBKOQ9HleIL/ikkGKNCELU6xE+PZHvziq9KjcV3LFG2A
         aIG6Q934jpq0WizSVeJ9a7/vrOhlG/9fiXSZlzLgKuYEYdCDiO7yUrnklQd3wdH5uxml
         9d0/idR01MevpqPVgSdwNrZV+vlswZADkUfGivAmjUKiOf2dFHu9i0cFBIobFdbXstE0
         Dm89OB85c1SCGJuKLJi2olsIV819inldUC/uXRKdbWfzdUg44lWciH/zp8f2CNS+4X0V
         IIxddkIi/O/zelAERV1THgyxl7vn5oZXpql2RrIXHmM81KOBE9Dq76vkMkAXT5jiKDzD
         sgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777436884; x=1778041684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCgZRNaYmJSPykbMYrzfut5EXQOeSzWA5g56k7ae8hM=;
        b=KTWLbckHwmM7BWlkusZA2ufhbGFGvV4CmbxLkX0PNy8TbkeN0Q8G2niIwh/d8kegFs
         Mxr2mzdb8YArlbssaCr5ZPLMB/cGtVzq1CNyLHG3SnPFEOvNsGaCXA8D1VJ1234nesNS
         7Q4mbsr2hbk6ihHkEZqWJtazjAqEPN2/JHYEJhI2ra6F4T+24DJCetAy77Dis/LlSR5v
         yMTaV23bmgtBuQ2ysn5SXLh5k9SqhIZTqP5/Y1SDxKJBGP+HW+Zm0kPiLPN8d9snnVIL
         eAShz6Q/q/fIQkwmVR9zclF58DRtnov26Tlatae+XktnC5KJdF4ejMPK1OiQGNCFneZc
         dD3g==
X-Forwarded-Encrypted: i=1; AFNElJ/rcn8zzgStx5mjQZKeArLYDRKmeXDjBvApanwomW4AyHjR5vRYTmuii02eHedgHAPM2HJRV+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDAPR4q5zMUO1Eu5WdAnvChDlaCsbU+O7f1OAwgGBaYiZKte27
	VJnJaIlmsfw1Nh0mhsDRbFT8Gct2Iv4SMBRRTGzpOh1bpMnF6ZrXi3olb41FuAjW4q/nmeVnsZa
	zZHE3uanqLAzgWYXnW/3zidVqkcotDMoB8iBLV5/97g==
X-Gm-Gg: AeBDietYbqML26jtxhlHkRzFmPCK+gRPtOWljEPTyxJSaQCo1LjpTT/wRVpWYeu429d
	IEqQPB4qtgHfWamYTEPLR707EUwXqhVf67xAs9nSX0up8GwohfRoKj6wFE0xMs5dtRiwi2kprt0
	fgJE/4Xbfzn58k9mgDjr5lDpzZ7vlqKGuJkORhxcrqTvka5eA2J9ysb7D1hG7GO6fNiJuAug0VS
	WTBk+fZkoIEKq3b4FZy8YsgkpAJUYt84abtce+SULM83yJ5U9hHpsgt6zHFLCElhQUv0Rv+5/qa
	SNDG1f5WHu818Y/37XuyvSBaca2Qhk4wXkbhO7Rps3KwWQc=
X-Received: by 2002:a17:907:c012:b0:bb7:47cc:1341 with SMTP id
 a640c23a62f3a-bb8022c2be8mr360275766b.14.1777436883779; Tue, 28 Apr 2026
 21:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427155813.2561935-1-max.kellermann@ionos.com> <b7827e38e2e4b87aa92261e1f02a7b7340f8d0e0.camel@ibm.com>
In-Reply-To: <b7827e38e2e4b87aa92261e1f02a7b7340f8d0e0.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 29 Apr 2026 06:27:52 +0200
X-Gm-Features: AVHnY4ImG3SgvI4nLDqhi9ljovV8DFkO-2VusdikC_-9zaWiQed6HkWfv8K2t2s
Message-ID: <CAKPOu+8Yumexe=Athx_fjtoNbTBgP2ENQrXx=idmkNeUwE9v4w@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A8CF748F332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241815-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.kellermann@ionos.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ionos.com:dkim,cm4all.com:url]

On Tue, Apr 28, 2026 at 8:46=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> >                       flags |=3D NON_BLOCKING;
> >                       while (!(ret =3D try_get_cap_refs(inode, need, wa=
nt,
> >                                                       endoff, flags, &_=
got))) {
> > +                             static const unsigned long wait_timeout =
=3D 5 * HZ;
>
> Why exactly 5 * HZ? What is the basis for this timeout? Could we re-use a=
ny
> available timeouts in CephFS declarations?

It is an arbitrary timeout, long enough to avoid unnecessary wakeups
in regular situations where we're really waiting for a capability, but
short enough to avoid disrupting the service. If you prefer another
number, say it, and I'll change it.

On our servers, this hang bug occurs very rarely. Sometimes, weeks go
by without a hang, and sometimes twice a day, but no more. When it
happens, I thought it's fine to wait 5 seconds before attempting to
recover.

Note that this is still a minimal workaround, not a proper fix, as I
wrote. The proper fix would be much more intrusive (and of course go
without any hard-coded timeouts and arbitrary wakeups).

> >                       if (ret =3D=3D -EUCLEAN) {
> > -                             /* session was killed, try renew caps */
> > -                             ret =3D ceph_renew_caps(inode, flags);
> > +                             /* session was killed or a waited cap
> > +                              * request needs a retry */
> > +                             ret =3D ceph_renew_caps(inode, flags & CE=
PH_FILE_MODE_MASK);
>
> Frankly speaking, I don't quite follow why do we need to add flags &
> CEPH_FILE_MODE_MASK?

Oh, this is an unrelated fix.  This "flags" variable contains internal
flags that are not understood by ceph_renew_caps() (i.e.
CHECK_FILELOCK and NON_BLOCKING) and shouldn't really be passed there.

I'll remove that change from the patch for v2 because while I believe
it's correct, it has nothing to do with this bug.  I'll post v2 when
we agree on the rest of the patch.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group

