Return-Path: <stable+bounces-47732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4448D5108
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC26B22C91
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923F445C16;
	Thu, 30 May 2024 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="J9ZNzbme"
X-Original-To: stable@vger.kernel.org
Received: from sonic321-23.consmr.mail.ne1.yahoo.com (sonic321-23.consmr.mail.ne1.yahoo.com [66.163.185.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEE433C2
	for <stable@vger.kernel.org>; Thu, 30 May 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090178; cv=none; b=mmUIUvoMQGNQl7ZH9bGQH7rOgikf18IY3LJmfvYRtWihb2s6Jr+DiZEH48fZVKiFgQkzQH67le10XpzPbIUBhqa7yh5qx0YQXZHipHD7xapk5VoRpNclJDqbm08IRdJrmlUF36gs/uXxg1iH3ko+r9pbeeu7kQsgzwy0+/cE+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090178; c=relaxed/simple;
	bh=LcYEg4O11dkLWw+UobeZ51xp4nl4Dig+uAX90kQK7bg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ImgQMPuuUuVQq6iy+eRlj6mAghhTYjr4fQWXMB4ffIHr/hBfa0wuPGsxK4CXuOyQYxGzT5GGebLlDpxMVU7Odk2wVqelFaZX9yeyxnHVeQgn/4J8wOC7INJsKQxjTWJufsnc28FnPYcOGhZrMFOvvkB4Wiw5JHOyoJ1fXTFIcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=J9ZNzbme; arc=none smtp.client-ip=66.163.185.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717090175; bh=LcYEg4O11dkLWw+UobeZ51xp4nl4Dig+uAX90kQK7bg=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=J9ZNzbme5xdLMZLfolIrXlrpyZhddkNF+4UISIJcV5MCXUT7omI0wRpZR/8GFmov8RftKCWFliO0Cb3yy2l/097+p3SxaO0IYaDmvOaY9frAeJ72yGFyJW6tpsxBsKRCQoF8Lux4s4qxjBVgPtI+9CWUFEDLfpce01oWgc0T13EmB1kaigPmuqDxWdWHs/4IbUXfvYd7mJ2EuK+0ZZ0/NIT1RvvnubfSGQInBxIB6KMXMeBa6AXdlHvPwIX/GRgkfAkQoTWgelIZU1vT0j+5fnWU6BHXX6Q28d6B9hhfBKaEqRHhxYIrzSuNDDY0rGw0dsZWkxIrHXljMTOyxP0XeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717090175; bh=+fwqy96QGasWm+KVqz3uhFrWmIpg9NdrYkrHB6CJ38c=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=tvc0rr0gCWOhigXOJ0pcHOt3aP1n3QMJIkFFU20FFpdXoex+VXVZ5K6ULlyMCtk10Afi8J1e4WtUVQjXGdNKwYM2GrYUsf7dS/M30hcBN+4JquPa/XTCnqkpEQ9et3/rnCXstvUHMkbRRQi86owqYpu1JRCxph5Jgn6TtoH2DYW0ewdsudhynxY8yFC7C8cB07xMTVOkJD1wY+Kw0a6PGFT4cOrD4imm4XxFxo/9R9dqfQrv4ylBPVevJUf/VBT5X+Muy1a9rdPQK9DABDCDW09ek3ujxFFOOYYyJhc1a/oN5NBcKDyW2vKU8J2OBiQqUwT/PSMHzkJclTcwrjNqug==
X-YMail-OSG: sLnciEgVM1nJnjyxHzAJXCr5ivGGb6fJdaR8jLHDHzQXMPs68aexYYsMABA9QZN
 _YJ.JsYKdAm4uITHFe20Jtz8IPuFvIXqqltsuIl_Q.sFOUXRXp6g3eCIxRwNoq87fuN5YKLauT0b
 jSSzHeQLQehojPEehCwV7ORyknDjfro7VipkHyuge655nBa2K77C8ZMmDN0o2nJXNk.R4WV0BiDV
 .oJ3_GqJ19TZsFy0pefVakEM.te_JNY0r_J3_xsGWbrZoNmQmkOOHcqhvjR42ksBnAjHHvq3HC8E
 vOhIjEEbcERbUQAuXTB2Bz5hO1ZSEB6CbcO5H6kCUGIwv6Rf2uhiB6XtcwgXp.fdmyLnu79ta3RY
 C4HNspnZ514Ge_zugFXGLHM0WGiDvBuE5NeTlKuAe5OqQBTc0CMjt9HU.cczG1DDQMaC4P4boqmi
 Q.G2XkVfpMaTPk21kLnOZtR2zgSf257LalQQAJ2y2Cz8pXusfjH6QuhRuKNFtk3h8mCY3m_Ah8YF
 Wh7wC19IyXQ0x7bStwKN8GXq6mvKUT1VIlU1mZ88VpovuLuT4EJsh9ZdFvZGb5Uj4_X0UQmin.hj
 lp3buQLrVtF1e4NhxdpwHusktngVuh9G5LId5kcqGzwNOHwCARqoTHFzBvv7l839qw018Tvtsqj4
 szccgro5a2VT9STQOG9PzYKxBChPxwFSgANV7Map5qxWlLzj9zDfMIGp0MDMP94KxSeilThqacsc
 t7eQB7v_GFeA.84IsyqjbT6YO_8HXQcua0Ah_dJDCHfP5h8CDVfgzDjxWrE1GRNnx0I2RmAZjmtk
 P.U.jsELWOiEQAhYVEAHsNkwnKMiluZKiIjYJADu.2_hilXkKW2jmxVjyV.IhWiPy2YzIt7NgMrS
 MUabt4JAn_bqrq8pqqJRvjt55deCy7d3F7Pqkcm1f0rsi8OK02R80dVJ_OjgHSRbwyMUfYi2rIg1
 eVvjPjmdFcoPVhu6hGl8lHSBqac7fC_z.4P_6NmHDS5FSonWlNg9jAFKErjmzhLP.AjflkoP_3sF
 xirVZ1W8hk54CByImNHfudvDY6M5dtsah3CF6ldeiKH9EnxDUVwluKHAa9vwu.4sP96.YHHLWImY
 TsB4eE_ulU66UxgWFhs_d567eLtpzNAiLYKLXI5a4ODdjW3URt.jnot1B6iq2Mz5uEv17FlTuTHX
 1ckIGk2WKjukT4RmuZckBguCf38WNM0.QdYHoKd.iTQYrJi8VC.PuGqgx5JxtknsmBAy98DszUfk
 vgdfiJZ2U8eo9ejBY2u7cSZ6SieZjPjnYHT27VzYl1vScB73cdebbCgvxWhpsGjM1iFZVCxzSqLw
 wWTeZMosPX5u40Q2qGSPIhPSLsWQZaZ8lhrJsakj.ZAjeOLFgsrIQT72dSSTMv6eMd1sQGeZdapW
 .iSLbGkznJSRdPhe44Kgs1su.ofQcaPAo4gZZD7Ea_M5NGuTxkM53bmtEsye60tgX2BCPn89xf3i
 NsYenbe7VdJ1M3mC8H4hGG6_Bf7hkpRjlAkBYJzj2mlabjTZWZjnLeZlnjmad36TWXGYnYW73E_K
 St3kAeDbDp5ofa1qVkxrD2I6O4KkHM8uQARs3aHD8L17aPxDIvYBr40xO4iGwMWIWUrr1xEKAzJC
 R884oKYiy_rCRnsqbSTlJDJxovI6f23s8G.fekG3fqJXYLArHVBm5ZW93BjKX3BXqSRESw2z2Jdp
 ZkL5VU7tGpLMtbCkotH6UkQh0Ne5FFwDNYpZgLtwNBfiLwz2ioNRuQ0Lu7_kDgxTHLuj4j3YyvYO
 8ia_dRMJWY7Tr.eoHd9AkLDKsWl4uMDu2iG79dUTkd6ofIdjLl2pTYn77s3NOHhnfieEX.U3mCno
 dpIyqfet0rlfHYsAuI6wP.4Py9fxP4R8MTO7X.hg2aDRaugS31autKUM_BVS68qLfee_Isnd2GTp
 ET6cideWgNUirQtjR9ITSDcYzA_wGNVj_RpSFOfHMe.rc1095I_2ws8KGMI.8JOXR3DtlqUf.BEq
 eFqyc315hg4F388jeXZ942ZHEVnGBBW67BamXTTf_R_CYtaq0.qAzyUyzhbb.yYFYM.uvm8lS0Il
 c2jJiy_yNdcu6OUd.RLSbxlW1nAqb1GFsrcJHNHXr1T623vSQ2_EOgNVNQXr5TAvOQoqCjrUVh7J
 zlJtRqH0nofD1LZe1FJHhSuGoMwqtR9Jf11qxGICEOZ8wRKyHVc5TuT5XqxUfBD0wiw51pk8mtIN
 jQHGtkI0sld3RM7SWiEoj.2ZfYYTiVIJaJXZF7YJpOfAfmA--
X-Sonic-MF: <mh3marefat@yahoo.com>
X-Sonic-ID: 9475da76-8ef9-449a-a9fa-474c5bd7729d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic321.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 May 2024 17:29:35 +0000
Date: Thu, 30 May 2024 16:59:12 +0000 (UTC)
From: Mohammad Hosain <mh3marefat@yahoo.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <1591472096.6190967.1717088352009@mail.yahoo.com>
In-Reply-To: <2024053032-squeeze-such-dd29@gregkh>
References: <321337111.6017022.1717061838476.ref@mail.yahoo.com> <321337111.6017022.1717061838476@mail.yahoo.com> <2024053032-squeeze-such-dd29@gregkh>
Subject: Re: AM5 big performance reduction with CSM boot mode and Wi-Fi
 disabled.
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22356 YMailNorrin

I think it has never worked (I remember as back as 6.7 it behaved like this=
 but only recently I discovered it). If you enable CSM and disable Wi-Fi us=
ing BIOS, gaming performance is massively reduced on AM5 boards... This onl=
y happens on Linux.

I don't know who are the developers involved that is why I emailed stable@v=
ger.kernel.org.

Thank you.






On Thursday, May 30, 2024 at 04:19:22 PM GMT+3:30, Greg KH <gregkh@linuxfou=
ndation.org> wrote:=20





On Thu, May 30, 2024 at 09:37:18AM +0000, Mohammad Hosain wrote:

> Hello
> There is a big performance bug (only affecting games performance) on Linu=
x (not reproducible on Windows) with AM5 boards (at least for my MSI MAG b6=
50 Tomahawk) if these BIOS settings are used:
> CSM -> Enabled
> Wi-Fi -> Disabled (or set to Bluetooth only)
> This does not happen even on Win 7... (I've only tested DX12 games) and d=
oes not happen if UEFI mode is chosen. I've tested with many different BIOS=
 versions all showing the same result.
> I have tried troubleshooting with MSI with some benchmarks posted (https:=
//forum-en.msi.com/index.php?threads/b650-tomahawk-bios-bug-disabling-wi-fi=
-massively-reduces-system-performance.396910/) and after a week we realized=
 this only happens on Linux (tested on Arch/Fedora/Ubuntu with 6.8 and 6.9 =
kernels for the first two).


Is this a regression?=C2=A0 If so, what kernel version worked?=C2=A0 What d=
id not
work?=C2=A0 Can you use 'git bisect' to find the problem?

And if it a regression, please report it to the regression list AND the
developers for the subsystem involved.

If it isn't a regression, perhaps it never has worked?

thanks,

greg k-h


