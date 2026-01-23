Return-Path: <stable+bounces-211384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MPyIaJ8c2lowwAAu9opvQ
	(envelope-from <stable+bounces-211384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:50:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2713276757
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B552301A282
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593731FDA61;
	Fri, 23 Jan 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmSepP7I"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF871448D5
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176222; cv=none; b=QsTw6YBlQqYpFcN/EbWb3RZHFhHM42dWqdw45QT1tcIi3xOWKucPDEljDFwfh1sJBHVais55KmAGqcM/LEMu6NWm3Y5jvClB8/NZNAA1syn16WECSDNfNTDv0GbYoTEdHfIYxB1o0Oyz47ZYizRknkLCbmLl0EAQDqVBwfZw0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176222; c=relaxed/simple;
	bh=oHABnvfXBlVrftVJekZ578HCsQh3TGBXWbJyWOV27ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk8mgNdO7h9dPvJYUk7iY9/uWuWCmsVDoy2o2gK9mhdTMedBSuZiaohN13h5TevOxE9bJ3EsZc/hEGlT+x+p+r4Pu015VM77HjfIvSZpG+fVqwASAuh7YbR4qnYTJ6WopX2wNKWVUmlhMRMjwIsXgfE+HJ9o3C/iZI1OYT95tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmSepP7I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769176220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1WONNtqCu6LKQf22ZJpLLTIem2aa8W5Gfqm0AALqkZo=;
	b=cmSepP7I/AtzRLStZX34pmcLZATN0gKFr7tJJSgDWksBMg0oMLVamq1xi2OEtQa3a9Uvpl
	0dk6B2jKcV0ihqtG7rFER7d0JLi6O01WAO1On6KdnwE6YURCGlROHf7UrCm/CdiN4zn4RA
	KSM6fsr4n3oJoTduVXYBGHDIu2gJZ3I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-YvBjDA30Or6Fq5CVuYWgMA-1; Fri,
 23 Jan 2026 08:50:18 -0500
X-MC-Unique: YvBjDA30Or6Fq5CVuYWgMA-1
X-Mimecast-MFC-AGG-ID: YvBjDA30Or6Fq5CVuYWgMA_1769176217
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F07119775AA;
	Fri, 23 Jan 2026 13:50:16 +0000 (UTC)
Received: from localhost (unknown [10.22.89.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8811A1801AC9;
	Fri, 23 Jan 2026 13:50:15 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:50:14 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable <stable@vger.kernel.org>, Chen Ni <nichen@iscas.ac.cn>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [5.10] net/sched: act_ife: convert comma to semicolon
Message-ID: <aXN8ltBrBMuLmj-s@redhat.com>
References: <fe9a24d2b872878e6bf041f02e6ffe1e3570955a.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1og4atT/0XttzaxX"
Content-Disposition: inline
In-Reply-To: <fe9a24d2b872878e6bf041f02e6ffe1e3570955a.camel@decadent.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211384-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgoncalv@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2713276757
X-Rspamd-Action: no action


--1og4atT/0XttzaxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 03:39:49PM +0100, Ben Hutchings wrote:
> Hello stable maintainers,
>=20
> There has been a build regression for the 5.10 stable branch when both
> CONFIG_NET_ACT_IFE and CONFIG_PREEMPT_RT are enabled.  This was
> introduced by the backport of commit ce50039be49e ("net: sched: act_ife:
> initialize struct tc_ife to fix KMSAN kernel-infoleak") in 5.10.247.
>=20
> After that change, tcf_ife_dump() includes the single statement:
>=20
>         opt.index =3D ife->tcf_index,
>         opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
>         opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> =20
>         spin_lock_bh(&ife->tcf_lock);
>=20
> But with CONFIG_PREEMPT_RT enabled, spin_lock_bh() is a macro whose
> expansion starts with "do", so this is a syntax error.

Ben, we had two other instances where the v5.10-rt implementation of
spin_lock_bh() as a macro required touching the code to fix build problems:

    386242acb15e rt: fix build issue in at_hdmac
    72bf92dcdcab rt: fix build issue in be2net

As there were only two instances, it made no sense at the time backporting
the RT locking implementation from v5.15-rt or newer.

I can cherry-pick the commit you mentioned to v5.10-rt and carry it until
it hits stable. I will also discuss with the maintainers for stable RT
whether it is a good idea or not to update the locking code of v5.10-rt
(EOL in Dec 2026) or not.

Thank you again for spotting this build problem!

Luis

> For 5.15-rt and newer, spin_lock_bh() is a function, and 5.4 is EOL, so
> only 5.10 is affected.
>=20
> Please cherry-pick commit 205305c028ad ("net/sched: act_ife: convert
> comma to semicolon") to fix this for 5.10.  It should be harmless to
> apply to later branches as well, of course.
>=20
> Ben.
>=20
> --=20
> Ben Hutchings
> I'm always amazed by the number of people who take up solipsism because
> they heard someone else explain it. - E*Borg on alt.fan.pratchett


---end quoted text---

--1og4atT/0XttzaxX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmlzfJUACgkQ85SkI/jm
fCb9xA//Qgc5Hh8KawRsZp4yknRQLPYvNK7Yp3hnnwiTpHRKs0yESGgitwWfyePt
Il9CK8WCzLmSz/OM2Cc4ZGAbBl/sexCvv7LmXxp60lxsgbOE2LCFlPZNfcIagxY9
dKLh015qw6Epj1SeDryH5BMDaDJhwIEnG6CNJCgt8jOG/xpVhfVfO4gyc0kOXxZm
ay/coNiHUZOWmY2jwzVw6NDycsVkfGPLVxupyoeZlxNATvIsDnM13FsyELXgi+1k
PyvDR/eMTALqL7HUyk8d5UMOoXZM2pG8dmAI5Njz6hwTrorubG4cA2f9xAS9VkWr
IgsFz5/+Li/SeNhhwjCystTA8cO6uP8MSPE7rMZwoMzIEdplKF8EBuqAkbhunpbi
vamlg6WOmP1g3adDtI1gQgOsixJIKu83QTl2bS8o6QmLYIeZFsNxwK47chkjp+sX
NpAyegHyI3wdDdBgLGfz4IW9WoyQybREJIXvihV5X1ZpaTyjX4oX/QSLYqi5ixMN
V3AxAX1wU0PtVcwqzWQj+pgLoucPDLWJKaxEQBtftFRFFRn3lj7ohaHuKVHpBm0e
vma03MCCqoYMrft0O+7cYbRUL1SWrHs7WX4i9ZjShm0zweW3Dx8noP34c4dUS8Qi
6syHYd33voN5E/Savfx4Pvx7twlgCv7BurnsTxfuLXDyXe1+fpg=
=drRa
-----END PGP SIGNATURE-----

--1og4atT/0XttzaxX--


