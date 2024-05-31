Return-Path: <stable+bounces-47769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295D8D5C7E
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E381C255B6
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E488121F;
	Fri, 31 May 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="Y5L8xwze"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC478276;
	Fri, 31 May 2024 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143267; cv=none; b=MKxz4+go9N6hZycqIdd+vFisV1b4YrTimwQ6fx2X2+kUp+vq77ZCBVB9O3r2OEygbJOarlhQV3P/OqLcO+KU5OAA9G7ElI3I5NKw2X6A5K4XEydnZenC9fYRXTRr+/R2A+QkqdQTbggaKUkctnG5/HBR7UCqOc7zeLlTybbGo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143267; c=relaxed/simple;
	bh=nP6eHxryLepIbCbvV63z+a4eiZ9YWlZ+uyeJAbn7Tz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSU4rE27WE7XPfheriyY3A7Oewgf/w5meHXMo0L18ZPTSR8lONHmOeBPp1IWmwqDDPOUHCkOT2nXQpBXqWVClgTHxd+kZOrTYzxRsoo+T3ct7yxYAiZ8NRFFzY54qk35DQ2uCV8gfOs+sDcs4Y77wLgJIcWqqVeA0W80BKjrGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=Y5L8xwze; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1717143236; x=1717748036; i=christian@heusel.eu;
	bh=wH+BJymVDvZg4gMAg7QG7CU7o+Pzrp+2Go1iWGurmG0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y5L8xwzeRmy/jkQZWLIRjIlzzO76/8NlUFB5f5mL/NJDkZbEQHEqafuxJvMnsMtd
	 v3MUNaFBln7Oba4E4YcHilA/m4U2cQQUQn099sHjY7zOxz3kj7uYJzv0NdTTDRVUG
	 8JvGhcc+7w+doj+Rc1hg4p9zn3saPYYxb4VtUBPTSSE6I/73VE2RTvQ0gThVDqKqn
	 nGzyqlD3QeRPs+gYx38K0v76jW/29ZMiRczzrGZJCOQayGUTIcQnEDCAlydbK8WkJ
	 9IeTTbbIBwYO9szBmJFV0vfYZbJ3SXDqK2qvQosSqCrK+k4CQF9WEmccJYZ9PkRGl
	 tHH2oNKdOFwyjwMYBQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M9WiK-1s9fc73JWW-005bXa; Fri, 31
 May 2024 10:13:56 +0200
Date: Fri, 31 May 2024 10:13:53 +0200
From: Christian Heusel <christian@heusel.eu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Schneider <pschneider1968@googlemail.com>, 
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology
 detection
Message-ID: <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx>
 <87o78n8fe2.ffs@tglx>
 <87le3r8dyw.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ml4yake7echoyyum"
Content-Disposition: inline
In-Reply-To: <87le3r8dyw.ffs@tglx>
X-Provags-ID: V03:K1:j0dP5ZRh4oNpd/6JDMZMU93d+hfhx1Mxewrq/WDRy94RIDfjXt9
 yAQEq0gPE+VAJvI5T1tOJaLI+JFoI3EwkCJGWm69XkwU65yGwLmPV5fWgBQTAkzM2nxu9Pp
 t+Bn+ZyHl8NySM5GaaR7U2Wh0YQPPmsqTAwcGoms2/xCDMXyq3KBUlJczx5ASR/ur3zt3rK
 VhW71jfDDM0fsdN/Q5jNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ol7OTCE7foc=;P52IwVeVjz2QEczg1D9PMNG1dJk
 y/5g826ErIe61hrflvqRUgWGyQw8b1EH0qsZBgBcMBW1RuG9zNNji1QncmnzBGtCgfShHrMad
 VZAKmBo75hKN7mTKsqnlW+doDcW+xLs30dyk560HE9lXTPMfYPhT4+dMj+a+N1MdVvtGUiP6o
 c5sB2dYTyOhR9fxeZM1D/WuwZF+pYGjlep/9GoaX+IZ4DuoJBtiA38WJ2oMbNhyGTl/9OgDAH
 i4NMeVJ85yfrcqmZdiwWna50AEBoGgkLIOP1KUGmW7ec8DA5PdQ3A6y8S5WtocJc++LA0eBh7
 V+Wj1ld3ZFSCNW2czrQxewO1r6c+FKEJEAuDO51RGOFWuLkRfOhpeIa99WUd5IjCwIGLMJaeK
 gvsIURXSpbdRcTV6GsIhMpVqO1t+5Y1sUb7dkyxhNny9yZnidwGxrh5G4CGpHX6HJGrSnLTMw
 //8zYZYIDtB5it6RKwIhYAWUWTPS8c97ADITVoRYm/XzRpaVGJWkttA+fS4H+dTxBgH/sArz2
 baLRaoz7lJuaO0Rs5JS+HJ/63OuGZjFx6hglUA+aYoS0MihoT42/W93vzMv+7R9dnN9cd4R0W
 ll99RwenRE7ZtiqG7wxZHodFKvKMmmmVQWqxlkqz67AmFezz9vdWL5ayAs/4ARloyBEaYpbCh
 w85T7HhOINFlw/ILrspWMehZ+tlvZN1+LaREjuLbpMAABKl/6v6xeHKfU/uDxFZQ2AX9TGfhi
 +d+LT8GDw5OXda1XdBa/sU6merDXszwo5bsAsuRDGGoBmyKwJlxrSk=


--ml4yake7echoyyum
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/30 06:24PM, Thomas Gleixner wrote:
> On Thu, May 30 2024 at 17:53, Thomas Gleixner wrote:
>
> > Let me figure out how to fix that sanely.
>=20
> The proper fix is obviously to unlock CPUID on Intel _before_ anything
> which depends on cpuid_level is evaluated.
>=20
> Thanks,
>=20
>         tglx

Hey Thomas,

as reported on the other mail the proposed fix broke the build (see
below) due to get_cpu_cap() becoming static but still being used in
other parts of the code.

One of the reporters in the Arch Bugtracker with an Intel Core i7-7700k
has tested a modified version of this fix[0] with the static change
reversed on top of the 6.9.2 stable kernel and reports that the patch
does not fix the issue for them. I have attached their output for the
patched (dmesg6.9.2-1.5.log) and nonpatched (dmesg6.9.2-1.log) kernel.

Should we also get them to test the mainline version or do you need any
other debug output?

Cheers,
gromit

[0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/57#note_189079

> ---
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -969,7 +969,7 @@ static void init_speculation_control(str
>  	}
>  }
> =20
> -void get_cpu_cap(struct cpuinfo_x86 *c)
> +static void get_cpu_cap(struct cpuinfo_x86 *c)

making this function static breaks the build for me:

arch/x86/xen/enlighten_pv.c: In function =E2=80=98xen_start_kernel=E2=80=99:
arch/x86/xen/enlighten_pv.c:1388:9: error: implicit declaration of function=
 =E2=80=98get_cpu_cap=E2=80=99; did you mean =E2=80=98set_cpu_cap=E2=80=99?=
 [-Wimplicit-function-declaration]
 1388 |         get_cpu_cap(&boot_cpu_data);
    =C2=A6 |         ^~~~~~~~~~~
    =C2=A6 |         set_cpu_cap


>  {
>  	u32 eax, ebx, ecx, edx;
> =20
> @@ -1585,6 +1585,7 @@ static void __init early_identify_cpu(st
>  	if (have_cpuid_p()) {
>  		cpu_detect(c);
>  		get_cpu_vendor(c);
> +		intel_unlock_cpuid_leafs(c);
>  		get_cpu_cap(c);
>  		setup_force_cpu_cap(X86_FEATURE_CPUID);
>  		get_cpu_address_sizes(c);
> @@ -1744,7 +1745,7 @@ static void generic_identify(struct cpui
>  	cpu_detect(c);
> =20
>  	get_cpu_vendor(c);
> -
> +	intel_unlock_cpuid_leafs(c);
>  	get_cpu_cap(c);
> =20
>  	get_cpu_address_sizes(c);
> --- a/arch/x86/kernel/cpu/cpu.h
> +++ b/arch/x86/kernel/cpu/cpu.h
> @@ -61,14 +61,15 @@ extern __ro_after_init enum tsx_ctrl_sta
> =20
>  extern void __init tsx_init(void);
>  void tsx_ap_init(void);
> +void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
>  #else
>  static inline void tsx_init(void) { }
>  static inline void tsx_ap_init(void) { }
> +static inline void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c) { }
>  #endif /* CONFIG_CPU_SUP_INTEL */
> =20
>  extern void init_spectral_chicken(struct cpuinfo_x86 *c);
> =20
> -extern void get_cpu_cap(struct cpuinfo_x86 *c);
>  extern void get_cpu_address_sizes(struct cpuinfo_x86 *c);
>  extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
>  extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -269,19 +269,26 @@ static void detect_tme_early(struct cpui
>  	c->x86_phys_bits -=3D keyid_bits;
>  }
> =20
> +void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
> +{
> +	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
> +		return;
> +
> +	if (c->x86 < 6 || (c->x86 =3D=3D 6 && c->x86_model < 0xd))
> +		return;
> +
> +	/*
> +	 * The BIOS can have limited CPUID to leaf 2, which breaks feature
> +	 * enumeration. Unlock it and update the maximum leaf info.
> +	 */
> +	if (msr_clear_bit(MSR_IA32_MISC_ENABLE, MSR_IA32_MISC_ENABLE_LIMIT_CPUI=
D_BIT) > 0)
> +		c->cpuid_level =3D cpuid_eax(0);
> +}
> +
>  static void early_init_intel(struct cpuinfo_x86 *c)
>  {
>  	u64 misc_enable;
> =20
> -	/* Unmask CPUID levels if masked: */
> -	if (c->x86 > 6 || (c->x86 =3D=3D 6 && c->x86_model >=3D 0xd)) {
> -		if (msr_clear_bit(MSR_IA32_MISC_ENABLE,
> -				  MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0) {
> -			c->cpuid_level =3D cpuid_eax(0);
> -			get_cpu_cap(c);
> -		}
> -	}
> -
>  	if ((c->x86 =3D=3D 0xf && c->x86_model >=3D 0x03) ||
>  		(c->x86 =3D=3D 0x6 && c->x86_model >=3D 0x0e))
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>=20

--ml4yake7echoyyum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZZhsEACgkQwEfU8yi1
JYUC/Q/+KLPr/xG5yCPC5RdysEAsP6D8G0begqtRBY2V+/c4dDXiuwjbPsuelJ9F
8DU1e2rJ5RfRTNAaEHX0mDiYs1g/L1BpO67R1SzjOkT9R+7i2IjAjcRCKdl7gv5Y
T1YGD3A/GhtP8KpMOiS06AEFGzgWkkdDH3Owll8uLKJGFHJTPB6mMqlO1Cy5R7t3
QFQ3zSwi9dp7lSSp+vIzRDfV0V+RzFs1M+II6hNNOIDxeG0LiKV8dAQoIiVHrRaI
0RBAqTSPXydVcPzYPJ3Bl7Gg0dLbM3kBSM4Cz4CG6tWzviaUkOh3ln4NHmCdnHgT
RyQDtkOzNnhaEZLoDOLO60Z6jJjqBLsGyJCZxUsJWg6fkUMWQziW24eltOpJPGmi
5wrGmByoPptxd/UDaIoUUNbO0qzMPivIeJ3OeUyVKlOBARoDLxqZQr9ED3WmpTdz
tidfPhrlpNs81HXYhA4fsSa0pkwaMFUUEQiioGoWSKMwoTBQwjIV6g7Hx23ZN2Nr
82juIhGUFmxL+POUYqEtgWt0xitmF53yYehcPBksv51zjuM0EX6VYPbVuK+wyIUB
MYmNvRa8XEyctM4CmDuixuE/g+VagJN3r0HRicLfgNKMMVNPZ6M9KzATdyfavXGb
C/SrbBzPg9oKmuDjD44MPeNeGhmY6OZiKeM0SOyBJvI9sgqVpQQ=
=Jgcp
-----END PGP SIGNATURE-----

--ml4yake7echoyyum--

