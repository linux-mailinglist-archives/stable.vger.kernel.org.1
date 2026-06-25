Return-Path: <stable+bounces-268630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QUlzHkRgPWq12AgAu9opvQ
	(envelope-from <stable+bounces-268630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:07:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C76C7B2C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:07:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268630-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268630-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729CA300A38E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44253AA1B0;
	Thu, 25 Jun 2026 17:03:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBA23E25B;
	Thu, 25 Jun 2026 17:03:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407016; cv=none; b=f19BIrT9b61orhfC7Hh5xJGLPSsJkXyi2AZjsB1uJx+Wk6WjsXk3FAcE6ep/KeGNK1YSmD8qbVhNC6s6P7jW1bJg3cLGutPHat3O0TP4w6xxHuZ4F83eE1d8CpSvqnb6Vcs22vcvc/buAVovRx+9W/v4eNZHqiWn1wuu1UDmjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407016; c=relaxed/simple;
	bh=TkaC+ITyc5ECGcY11xX9NJOyBuFYLfP2h/nqfbyS8KM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jh51cb02wJsbPt/itLSPdtp00yF4zRNZTaPIn+RIH7wblJUre7QlcxOm/wHuv2GX0sskqjX9egpikOXzdZgbPNL+IFd8IFtjETJ0t6Xnlpi6WwaX0H5UVJk7aTXt+2XoWLPdgx3qpefOhqhGnB0/BXFk7GKZSQPgPon4jkT2SY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wcnU5-004JTU-0c;
	Thu, 25 Jun 2026 17:03:25 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wcnU3-00000008Sti-30x4;
	Thu, 25 Jun 2026 19:03:23 +0200
Message-ID: <0e31e18e9567e8d58fbb8e06955c3ed8e5a120d3.camel@decadent.org.uk>
Subject: Re: [PATCH 6.1 431/522] cgroup/cpuset: Reset DL migration state on
 can_attach() failure
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Guopeng Zhang <zhangguopeng@kylinos.cn>, Tejun
 Heo	 <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>, Waiman Long
	 <longman@redhat.com>, Sasha Levin <sashal@kernel.org>
Date: Thu, 25 Jun 2026 19:03:18 +0200
In-Reply-To: <20260616145146.132165243@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
	 <20260616145146.132165243@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-MaYQKXGlI/qt01T47OJK"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268630-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:zhangguopeng@kylinos.cn,m:tj@kernel.org,m:chenridong@huaweicloud.com,m:longman@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,decadent.org.uk:mid,decadent.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C51C76C7B2C


--=-MaYQKXGlI/qt01T47OJK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:29 +0530, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
>=20
> [ Upstream commit 4a39eda5fdd867fc39f3c039714dd432cee00268 ]
>=20
> cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
> state in the destination cpuset while walking the taskset.
[...]
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2579,16 +2579,13 @@ static int cpuset_can_attach(struct cgro
>  		int cpu =3D cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> =20
>  		if (unlikely(cpu >=3D nr_cpu_ids)) {
> -			reset_migrate_dl_data(cs);
>  			ret =3D -EINVAL;
>  			goto out_unlock;
>  		}
> =20
>  		ret =3D dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -		if (ret) {
> -			reset_migrate_dl_data(cs);
> +		if (ret)
>  			goto out_unlock;
> -		}
>  	}
> =20
>  out_success:
> @@ -3401,7 +3398,10 @@ static int cpuset_can_fork(struct task_s

In this backport the second hunk is being applied to the wrong function!
The backport to 6.6 has the same problem.

Ben.

>  	 * changes which zero cpus/mems_allowed.
>  	 */
>  	cs->attach_in_progress++;
> +
>  out_unlock:
> +	if (ret)
> +		reset_migrate_dl_data(cs);
>  	mutex_unlock(&cpuset_mutex);
>  	return ret;
>  }
>=20
>=20

--=20
Ben Hutchings
Humans are not rational beings; they are rationalising beings.

--=-MaYQKXGlI/qt01T47OJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmo9X1YACgkQ57/I7JWG
EQm1IBAAyTPz8RlfmKVe8sazTi0W6JmbsxE0aONe892BrngEcAz0g2zEr+OIkgHN
vh1p7udtSSTGT9iy5SqAu/N+PUd/vlGWb/qbzLHat74HdsxfdcS3iV2qPBivEwNn
INA7DxD83LCx+Hvz/Dmz4dy5G4tXqpRZLhWLAnCTqoMSeXpaW65XfddJnAPLPXl6
Y+V/tvyLOwRa9F+ZJUlaUIQ73JlzS7fApzj4wPz59gkyDrwzv3+otM9WY52zmwtx
gzCaKUK8epodzNBrKFdXBN2EbzUJu/cihPreFPIx5KcT3nWkwC863HOlAxv+EXsX
rgLcDCjEI6Xi3VozaTrQkYKEPIQRHL6Y0vMFF8Nc+nii6yS1566Uj5PzmkK0ybch
ZYsSz7rs6fl+HFD9iOPKmhqM9mQ4WNRtqJZ63phqUTceQwp6kBrJd+sJ+p4+78HQ
1UhoSeAnlCSJnu67gdrUbfga9rKi9ZbhGn4de+B5GEAsAreehG0+Bx2a2IPkMham
oLY7XBLLl1aHJQ9qpciqdhjliXoFDDdMl12Rz9PkwG6eMPu+8rTujtY4qPrhpcnB
PjITP0JQlbSLegJWwd2Q6YiC8ptseGuFB2z4cCTExgfh0pAP12lxOyzo+CtUDoFj
O2MluhcBM99WLEXTE1rrbDfPUqUSxcU8qt4a0sveKq/Ipuj1HOo=
=SrAn
-----END PGP SIGNATURE-----

--=-MaYQKXGlI/qt01T47OJK--

