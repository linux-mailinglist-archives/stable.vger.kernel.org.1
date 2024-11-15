Return-Path: <stable+bounces-93513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B909CDCF4
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 11:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750E1B24AF5
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742E18FDCE;
	Fri, 15 Nov 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="dHu/oV6U"
X-Original-To: stable@vger.kernel.org
Received: from sonic319-22.consmr.mail.ne1.yahoo.com (sonic319-22.consmr.mail.ne1.yahoo.com [66.163.188.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FB7D3F4
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667699; cv=none; b=fDI2e7ijVWxbJhvkSV/UiFWWuutES7EtlHKHs2BDr4Hx6vdMczX8WKD0EC0kHxcOtbM9ScWPwydCCJpBLZQIwOypHDyY/EoqZhhsVyh4ARrglXzFWwlLjS6ZDu441uRAVKGbAAfJYXEdPPizbUgjPGucheCdVsPlu8LQW/UCAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667699; c=relaxed/simple;
	bh=S2cz4N23FOO7l9kFiwK1yW/njfrzwbrH4HXWjDGScis=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IBrAC2Sijgg56pQsd2bAFarethHOUR/QCagEMtdAlG564z4EjgAAXplGVKnwQBLCMTQtJZ8lZ1Ln2r1havm73yF5NY3AJsqnesikWSx/COuzysmmHGmsGJ6RnOBwf94d0wKREN3Ahv6aiRexDrQT4L8xrQaqSVEYUTje5C2YPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=dHu/oV6U; arc=none smtp.client-ip=66.163.188.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1731667696; bh=S2cz4N23FOO7l9kFiwK1yW/njfrzwbrH4HXWjDGScis=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=dHu/oV6U93INSj4t9bP5iPRhiU03JJUGV0rXqpxVLSTbhjMuCwI1XponO1OZvRDhPjVPq3oNPR19AKocvx2keWLqQFHUDVHX9lcFyh3aGLOpHRuK3U1PrTvhni0gowGTF37QpxzDBTgDkaoQgCFWMbcwiFVUWWvMfREIMTy9uKAhZBc3fTkp7eb7MOgBERyluxwNPw83iBJ9JhnzzaYW49dcEYi1qSkjfDMVJ7I8PDhFwKeNOLWB6YR5VywwPrsjKqUScIyM/PdFAmyAcecp9aVuMmz0cZzPeJngKQzX2jIhcB/hxsZruHMr9TzIiHL3XbqGWZyZeYN/t5+oWxPpzA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731667696; bh=8YczTi89BNq5gq6OuBUFlvts74NkHIGVYIwtEMjhgzz=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=Kn922XVPA4OHovaWllND+Lu/ctNXiztykvi0N0RZgoLQx1uva8pFCLOQlCNrwF1KCOfGvDeTiCeiNg9yQhSV8JKLWW83M3l2QCIYWOLgkPZP0OPhMFpagBI6ueXygmuc/xc0iUALFu07J9KVJgKRlrLLF6EE3EKfBg7Lx8zOuh8WhIhEFYOtfUgqLEfrtxiWnqpLLocoS27WU+Enp6AfaGYH8S0CXTzOhXjSGE8Hn3kzzAEf+qUiHCoSdOYHdPET15El68x7doqzpbzoDApjI0QWa9ZKud50OYRZW/kuxV/CDWnn1IGMSjqESwQkfkSNTVDiTge/mJQ3/RkaFw3g2w==
X-YMail-OSG: 0wDoFo0VM1lCIcg.ZDsOAXLZQ3LHqIts9h.aYp7xz4nAC5RgytYYwNYJzSN416x
 cJSvRJwppY7jsMdlKfkqusF6CSfVENuNF8VsIpvTsUPhV18Q_U2AjLmvZ9NqxfniVeaff1PVgV2.
 2vNCl9QodNdnMp7xVhC3UkkrVajqXYRS4qvYaPUpWaHjAP2tYI2J3gNmCCEb5S5C8a5JTBkEmrrX
 8AY4Cl0kms7Oi899leRuE5I0UPP4ycHkfvLW9UBCcERYfDoBCMJbFUQsbzje_rBaWhFyQwcT3nX8
 C3GgPpqUdsuvHna1iP4uyTJoaolQqbX1oL_iUgq42i2c0Is7NbPnBio0jtpvFXjYErgefSe16myn
 fZdSjfHnmhNzBmSSEGyqgKKv8FR2UlZyCDtP1laH4IAwGyz3GaI_PImGoJys5miadmYOHkqKCycZ
 eYLEecfTopteO7_nWxfSpLgG8X4F.ynulK_EIxg4oFJLHKnl5_ESY8bU7HAyTLcVJVlN_MbUwCPo
 71zpuSG_mk3LeuKphnelCqeA5PG4kWi8yBJa4v01pxzdVmF5yHubALbsTf89ZyACAQDIyI8UVccp
 vhPdosbsEEgpDF1H3Lx2LAUBGNKigilysa2mYGZdntl06A.9ytJ1A933diMP2sW.g5DZjpLWieY_
 7gTzahZh1EnjDnPTg1GIaWbKknAbU7ajbHjewClJx9HAdjFwz.AM9FsSDNfopRK139W8kCOwVqPb
 1LshD0OhC876QiY170s6JtwxMvXfgr01i1fq_9c6WjuI1kJ7Bpl7Iq1RH5yoey8kDHUpcpjk6rVz
 ZdxgOzMGoS_W.K0OfSYc3p5v5HY1xPnFkhrhiGZ.7D4imQ1HNCwJp2O8xdEuBEhk7IdpKQfcyb04
 Yiv2nsIw7uAm5pnMUv8BW51feT8mgn.93AyYavfAqcoCQg_Jy26NfEgFdmJdaGbcijegybYkDRf5
 _2BPUrIgQD6EbMr474FWYL.vKpQ09xwY2Rqf44ud0a2G9ZayBE2V1U1_T6vjvUUyOls7vKIa6_tv
 M_RQvcN1CMAJJ7Tu.UKpiSVmSTr0_7snP6yFWGDrO3u5K7n8CD3IjnZobY.7FdmLQJIQslwVKty_
 nXq0zXoLUTKuGq790l_Z9elJAngyS3rKNrnptLJkySJSSMVuhx7tr_5ThUqlQY62L2kzJPCi4Mdx
 cdTFrbRtNC.lQc3Glh7dh1bhRmz7_8shzUivYGe6RAX9wZZN8RPEKbloYqE_qtoHkbmkKAtYLM9G
 CmIb.tG0QbHHFFwIfLhc5LY6Dp4tlu8bzjzcD.gW9Pda84ZGjPmtBKshbiF9v_n89KueFbrs8DYd
 8w2kbPIKM5U.BCk7vsLbAS1BCVIv312opx6p_ceVOxWXTheFU12rP70rKaYHhKicGCxOymYupojp
 AWwrjy7NaGa6uDm6e.YblTK8x0SasOts0yoIH8rJnrMe1UzxW7FxTNCKdnBicodhhO8nDZkTohYQ
 A_sYZKO0eofPqt4_eQMogHvaYqE5c_WVPg4sX1SvawAgwQIzM1I2PnsGw0yZ58Rwg5GqyEEOPm73
 ZZbSCk4G6.wA0_3g7JFw3bxnMJ_3PkQ_9lppm0LmUOu7Cgea4t8R2nzZL.iXxowSF9oLOIdsx0v8
 PZZNv8VyJAMdb3VhkkyCvqNYJOdQqWcCvp.XQYgxhCRGkVMaLsuSyUgPdppA71xVDgGMomxB2DIU
 3.SLLTitDV4kuSxVW.dU6OPWgRDSy3iEzTf14I8Sxy3DOJTf6.a.dTdbfAemXWFBFVdcviM5MHP5
 kQIU6foMi8dHADpxhYbDwcx0nqOEqdQ3LHM20d82x0HXlYvVpkEbbNOwGsOm06fV.FgFkddH6HH0
 Qrxcx.J4VOyuh2WSyjc_zq5Gdzn7XB6lc22nYoU5rGrZE0OV6dfFs38tv4yasjAQ_0Gm_zH0b9mS
 Si8L4S7cJnbCRFiuAq8wU4a56MRHf7n2khwdfSpTK53suhlNvQ0Y0KnDvqi2TrYuunhk8_FvepuV
 WR6MCeCrX2DnVg4A_6gSitAG415TbXJz70HuG2yb5ViCf_Yr289BchVhmNd.FTTClmXTLcRlszow
 GIZZ.7xwBnQkAF0N96aWRk2ysHQbJJtpv8z3FXMWhUsGFfaNZvmDWBlymnJUb04jJXRZdikd8lHL
 yBNKSdil2DBteGyz4AZdD9a57PFTJs2MIA.8Ff4Q15_5VtdkVNJMbkcKpvtKKxEblsUXmKlYAkQI
 ixGDRP7GnnFQVGfON6gRnU7a2Z89krGQkpM6W
X-Sonic-MF: <xiangyu.chen@aol.com>
X-Sonic-ID: 1b8a27b7-decc-4c6c-85eb-f00a7c2dd425
Received: from sonic.gate.mail.ne1.yahoo.com by sonic319.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Nov 2024 10:48:16 +0000
Date: Fri, 15 Nov 2024 10:07:44 +0000 (UTC)
From: Xiangyu Chen <xiangyu.chen@aol.com>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>, 
	"perry.yuan@amd.com" <perry.yuan@amd.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	Anastasia Belova <abelova@astralinux.ru>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <1645909597.2921894.1731665264848@mail.yahoo.com>
In-Reply-To: <bfad2b5e-4d7b-4083-afc8-a40d25ed9917@astralinux.ru>
References: <20241115083338.3469784-1-xiangyu.chen@eng.windriver.com> <20241115083338.3469784-2-xiangyu.chen@eng.windriver.com> <bfad2b5e-4d7b-4083-afc8-a40d25ed9917@astralinux.ru>
Subject: Re: [PATCH 6.6] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22876 AolMailNorrin

Hi,




Thanks for your info, I've solved the conflicts in a local commit and forgo=
t to


update the commit author, thanks, and please ignore this patch.




Let's wait for the patch you sent to merge the stable branch :)



Thanks!


Br,


Xiangyu



=E5=9C=A8 2024=E5=B9=B411=E6=9C=8815=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=BA=94 =
=E4=B8=8B=E5=8D=8805:17:52 [GMT+8]=EF=BC=8C Anastasia Belova<abelova@astral=
inux.ru> =E5=AF=AB=E9=81=93=EF=BC=9A=20





Hi!

If I'm not mistaken, the line From: should contain the name of the original
commit author. Also I=E2=80=99ve already sent same back-port [1].
However, I didn=E2=80=99t get an answer yet.

[1]=20
https://lore.kernel.org/lkml/20241106182000.40167-2-abelova@astralinux.ru/

Anastasia Belova

15.11.2024 11:33, Xiangyu Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>
> [ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]
>
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return in case of error.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> [Xiangyu:=C2=A0 Bp to fix CVE: CVE-2024-50009 resolved minor conflicts]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> ---
>=C2=A0 drivers/cpufreq/amd-pstate.c | 7 ++++++-
>=C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8c16d67b98bf..0fc5495c935a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -579,9 +579,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long max_perf, min_perf, des_perf,
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 cap_perf=
, lowest_nonlinear_perf, max_freq;
>=C2=A0 =C2=A0=C2=A0=C2=A0 struct cpufreq_policy *policy =3D cpufreq_cpu_ge=
t(cpu);
> -=C2=A0=C2=A0=C2=A0 struct amd_cpudata *cpudata =3D policy->driver_data;
> +=C2=A0=C2=A0=C2=A0 struct amd_cpudata *cpudata;
>=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned int target_freq;
>=C2=A0=20
> +=C2=A0=C2=A0=C2=A0 if (!policy)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return;
> +
> +=C2=A0=C2=A0=C2=A0 cpudata =3D policy->driver_data;
> +
>=C2=A0 =C2=A0=C2=A0=C2=A0 if (policy->min !=3D cpudata->min_limit_freq || =
policy->max !=3D cpudata->max_limit_freq)
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 amd_pstate_update_min_max_lim=
it(policy);
>=C2=A0=20


