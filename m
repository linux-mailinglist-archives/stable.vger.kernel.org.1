Return-Path: <stable+bounces-134509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F36A92E76
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99612441190
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 23:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5DE221F37;
	Thu, 17 Apr 2025 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="HwFyXSXl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NO4G0Bd+"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8021506E
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744933935; cv=none; b=GRrgIBCf5cAM+/ARVoCzR2PgjZRDyZUDuAmGF9IcPe+SvrlO9i0JSyzJCI0r4gEuM3Q6mipLHIdG01Td3M9t2vpBXZEjVhKf4w/KhhhUIxJ74AAv6SBWqps2dwl55H9hx+9Uyr9qDv0RLPDBTBlv97TRsayxVV6xUeAH7gwK0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744933935; c=relaxed/simple;
	bh=7hmJynh7D4nGQe3kZTcSx6WotPtuO2oWAzbHzxFTrqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R56kjmIiGM01RMBTOMYmHII1TrwXZ4SaPmZgHm8qUG6jmwAbuFi3JK+YnBN/R4j3SpmxV3+bzCEgEg3gDXjno/lTRm6a0yd2KBdWLYyWYlO1NBNmZGMYClnKCA0zG2QzHKIRG+gxqiYcatLo9HPzqZxF6U+0mgi6y5ztUZVQcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=HwFyXSXl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NO4G0Bd+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 53D1613801FD;
	Thu, 17 Apr 2025 19:52:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 17 Apr 2025 19:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744933931;
	 x=1745020331; bh=UiNPMZG20ODU6B5tu/W16i8qAXI/Ul0Rly84Te6ORSE=; b=
	HwFyXSXlPWc+7LNxD0SnjjTJvpFCXYGmWDLrg7ehFOv5d/bSTcRzyXAKLK1dWYQM
	Jbhq7huHFBOiggkaIZ8jAEjWFcwy1Y8FPXuvl8FMGPH5+zBhSnMkUVvG2xJ5SSU4
	KNbSHZe0Cvj0KwAVrRg8J3YpCdRY7kaSj9UWSUYLotHGzGXV9rbAcVwkmbdDbzvG
	kuMPKgfYfHLBL+QC/BkD3QTRLOxL2nW1/sVVbFfZys6H2oKX7mft3XJL2OlAXxbi
	4uF2H6jyhbGcuQl1rF2zaRsBqBIwGfC491dFoUucxQRqVyAVucz+g7QDpCJijDKD
	3XlJgKdaFFY/4XUjqZ1/RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744933931; x=1745020331; bh=UiNPMZG20ODU6B5tu/W16i8qAXI/Ul0Rly8
	4Te6ORSE=; b=NO4G0Bd+BaFjtxgK4AlxQMs8ENOuCh4ZTyHisjvVANS2BrVp3/d
	fm1eiFIPCordB5JYBGmio/cSWRSbHCUPErw7QtzBEimmaQumpQSvGBDbM5PqqLUo
	zGLz3ghNlo2C4AeEsLDpl/O0kF0UtdgJ1A5uHryilHpPtCR8xtlmYfRcUsmCfrUP
	waAbJ2kID/jvAKGNoXdchF72EKj6L9v3gqRWOcJ7VWPKn8pEdIagB51K1gVqnklJ
	lAw5uO1MwjprBsT5nmBJJEKfENb8vZQMNXNatFv0WbCaOXL7Rvb1BNNoC1MEnB0P
	eChQ3ioqljr1pXD3tQtQLC6IN7FGaZC/dzw==
X-ME-Sender: <xms:K5QBaP7Yk1OG2NFGhxSyPSkwvE5kHbDJoVpz770-G8AK19tUatvqow>
    <xme:K5QBaE60BQFxn4Ijcowa52YWNfj7l5hEDy1W_InKVvscuJ-ZrPpvq-QQNVeXz21C1
    X5SUbynQhpthA>
X-ME-Received: <xmr:K5QBaGcxtGK_ptp-qQV5cRPEh4bhAtfTEY9YQsOmw0SpDk50W-J53NicUj971blfYaRvL7xFH5Wli2MwpPhbvasseMF0jYSrRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghkucforghrtgii
    hihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvg
    hthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgheevkeehvdevgeeu
    iefftdehieefheeuveegiedutdeuheegtdefieffgeekudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgpdhmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthh
    hinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehrrghfrggvlhdrjhdrfiihshhotghkihesihhnthgvlhdrtghomhdp
    rhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:K5QBaAL_8gzP_YzFbKLkZCX6q4Iw_cxuYF2EtJbNNDO4KSKu0KqbnQ>
    <xmx:K5QBaDIkruJ5F9P3JLcGyFLB7kacncvObW11XyZuUQV45gu2SC0Wfw>
    <xmx:K5QBaJzxqDPy5l-lXbulKrXX3bo_sUFvYZ9GofENtBeGPknAFvduBg>
    <xmx:K5QBaPKYbj543CMXjdY0KuN9cI1-tQO6zSNncJr1wkjqRjN5zzx4BA>
    <xmx:K5QBaG8fqjfxQCdV_bCIzBAZrASD_C0jQwQwSycyrgSScTxtIttGYrZt>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 19:52:10 -0400 (EDT)
Date: Fri, 18 Apr 2025 01:52:07 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: gregkh@linuxfoundation.org
Cc: rafael.j.wysocki@intel.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org
Subject: Re: FAILED: patch "[PATCH] cpufreq: Reference count policy in
 cpufreq_update_limits()" failed to apply to 6.14-stable tree
Message-ID: <aAGUKHsF2epjlNqG@mail-itl>
References: <2025041714-stoke-unripe-5956@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ddj5+/sZG0g/0LHm"
Content-Disposition: inline
In-Reply-To: <2025041714-stoke-unripe-5956@gregkh>


--ddj5+/sZG0g/0LHm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Apr 2025 01:52:07 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: gregkh@linuxfoundation.org
Cc: rafael.j.wysocki@intel.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org
Subject: Re: FAILED: patch "[PATCH] cpufreq: Reference count policy in
 cpufreq_update_limits()" failed to apply to 6.14-stable tree

On Thu, Apr 17, 2025 at 03:28:14PM +0200, gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 6.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:

What specifically the conflict is? For me it applies cleanly, both on
top of v6.14.2 and v6.14.3-rc1...
And same for 6.12 branch, I haven't checked others.

> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.14.y
> git checkout FETCH_HEAD
> git cherry-pick -x 9e4e249018d208678888bdf22f6b652728106528
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041714-=
stoke-unripe-5956@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
>=20
> Possible dependencies:
>=20
>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From 9e4e249018d208678888bdf22f6b652728106528 Mon Sep 17 00:00:00 2001
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Date: Fri, 28 Mar 2025 21:39:08 +0100
> Subject: [PATCH] cpufreq: Reference count policy in cpufreq_update_limits=
()
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Since acpi_processor_notify() can be called before registering a cpufreq
> driver or even in cases when a cpufreq driver is not registered at all,
> cpufreq_update_limits() needs to check if a cpufreq driver is present
> and prevent it from being unregistered.
>=20
> For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
> policy pointer for the given CPU and reference count the corresponding
> policy object, if present.
>=20
> Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling of =
_PPC updates")
> Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
=2Ecom>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Link: https://patch.msgid.link/1928789.tdWV9SEqCh@rjwysocki.net
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0cf5a320bb5e..3841c9da6cac 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2809,6 +2809,12 @@ EXPORT_SYMBOL(cpufreq_update_policy);
>   */
>  void cpufreq_update_limits(unsigned int cpu)
>  {
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
> +
> +	policy =3D cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return;
> +
>  	if (cpufreq_driver->update_limits)
>  		cpufreq_driver->update_limits(cpu);
>  	else
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--ddj5+/sZG0g/0LHm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmgBlCgACgkQ24/THMrX
1yz3ngf/ebLS/9Xw3vduU6q4HyQDAvG09eDr2RVscn9WXQAMw7/XNLUaegycMa0b
NhOdtHR2eLVeJareTPdzzTG0cueZT4GWZ/57IwMHK5xypvW2dfZ62EYbvqqHGat4
m3B6CUFWX2Imk72lKGltZvirfUrOuPDxQYrZfgRjJvTsep5kh+o4n0zcf9C6Vzot
yLlSDwNuV3wAmpwpse9wJlTQ6uc6WfLrqBw1YM7cwwp9rZAKiNoG/fph3kJP+vlZ
StGFyXrXzntumKKBNWohpCk5G2MSv9qp6iAOmrcdb3UetgfknAwR0R+YyoOeeN04
3BAn6Ohyl/c56CtrsjuZs0UbuhJwTw==
=ON9n
-----END PGP SIGNATURE-----

--ddj5+/sZG0g/0LHm--

