Return-Path: <stable+bounces-145688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F7ABDFD2
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35627B0C29
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5224EF88;
	Tue, 20 May 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="VIO0To7o"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7D288A2;
	Tue, 20 May 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756909; cv=none; b=ox04wadpr+YeKtkY/k37A6wB2fsn1NZNL4aW132th7WZ4fyzu6jw9/PNVDJ/6VtPjKvek3rg3k1Df4l6W5XonxW2tCUUFfvJowP5N9KnFlkCK++BqB2YeDBmPU2gPmsT+tqvsWePgp73xwFuaQk/ek7q2tRwrtv/v5X36PChpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756909; c=relaxed/simple;
	bh=IKXITva7/YjghlR4ZVT7/WJCzWQopHSqmbEBjvNw80o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7LEdq7ybSMplpeoMXmyZgM9RgRJjQ8Jxvnw93tbnnFoJCtEQFsc4lUtCBaG8zR9P2rfz+57+7l4tJwNYSfRUyzE7eYQjsQCBAR0Ro/O5nSTEwcnU4Pz7/VKsVy80dUwSxuj3zJZSdWqEgF1ce77QvVamu8ydHYgktBRepP11uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=VIO0To7o; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747756904; x=1748361704; i=deller@gmx.de;
	bh=N5oy7CdZNTw3mP2yyf7QkYGg65zZPa4HL8zBeUx5BKA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VIO0To7oOB0XzRDIOmz1F/j/MLwD6DIWQuILoDFBmsnMC2wf5LsDTUTiXBhF2r3r
	 lRW8BGJJGds1hhr5GBf2QpUa0GYhBQZCXfsWLh5UXwMfZbl5gfDyxy1JH2aWlCIuw
	 gomm4umIVpawNfaxGaiCmAFIr66jX7HdHEsH07Xr0f2x4k3XzzuNLmZxZ1sZ8MoS7
	 HeUrSXe3whqkzql3sYOdU/piO/F0cktemVKmnKC59/lnZiF7nC9phy8RkILr22ZRq
	 SHPHW5/cFvF6VAxRk2lCKe99iHZMlGQnXUAvOmUwqUHZPWWsVLzUbwcMHD8bXVg48
	 ucLe9b8b9E/EHH1m6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1uwYUg25Wg-00sRoi; Tue, 20
 May 2025 18:01:44 +0200
Message-ID: <36dcda92-340e-40d1-befc-ac488fd534ca@gmx.de>
Date: Tue, 20 May 2025 18:01:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: fix building with gcc-15
To: Arnd Bergmann <arnd@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520090051.4058923-1-arnd@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250520090051.4058923-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GHXPlDyH2MYPG9DJ8Vu0GnBw9TSk4jjkoubRr89fecbhrOwmC2h
 DEIgoIMC/dTw0LydEzkGHtSjrG9wirOI6JGQ9rX29BzxXPlYGBSKv9q2KwE8yr1JFxKwgYW
 qpD9saKIhczJrMHb+InziT8NPsfBRccLa9dzPVf3i13Lp7ZSGJY9QdG3LzydTjyTEA9hVA2
 QP6SWVTLj0nADhi9tAj7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J6Q3zKgrijg=;NQscuhJ1w6rtCTsz8qjQIZGzkxi
 tOqq5Y3Hp5Bak6JgvQ4R5/SyjcJwwR5fhNDTxrd7WNLCFymAR8SKpzZsv/fplNkqdovRBoiv8
 Qjko7CbVCU+FqeUomfIQlvGHt7gstUv/Tm7zeOoiusux4Ec36WQtfokkCfKWhLKCDryVANI6i
 gjmkAf1xM9aTFnCNKPc2v/t4180LYI1SsIYZY3gBU2+NuwuCbabuzrSantqhPlrz7kZ8xOcaV
 S6RwiRhs1oQLGWYTtIvgFvP5rgMjMn9oFLvlZ8KRBWzaietcLND/iktqwxd76jChc9a5+uGY6
 f2jbokM1DqoZk6thKsDNdk1R+hKgTZX6UIoCp7ePXCQoHDuezISUjp7MF5bJ7M+SWg2wh+/Q3
 Kf66vDF6ttaeQj1kv+jl89BpLF0rlkrzGk6LX0wjY/1E7sJhjVmeh/fcTD3Z+I5/8zbXuCG76
 3i7MYJPd8BMYO3exlx0FR9JPHjJdihF8SA1wljR5Vz5dW2o1QDuFhji5sYigU3IquGVeo4JJk
 Dxf+7enFO/j5RMqRZUqe29KhC5EbR9DM5zh/Wh138Q8TgG/yGVkL0vwJQq9MI9xnozMDyyJHd
 n54GlSmYXzKyvpT1NeuD0iIcNb83lTKeURPx2dNjxmpxjkaKkSzQknXHamJ+Ov43sp0d0vmby
 PCOZoUr0N6u25uo31BYnh6xxWL8q4u94BLk85294w58ZP3W/B3FEK0l85VAJY4fn/HbU+JOAi
 egb8/mk7cU8QqDNrBBdynrydZoq5GyyN0IHC3dIWQ5iGsOgDFCOiyrYRZBS64cPgXu40rjXMW
 /BUrbhUQ779i2HGC6m8jkh9kUWcDNh9+uig3NFTJGWAkGX79SHLOTjZeKe03DBSX2lORGfpeq
 Hx5F91FRSVaS6zcMsBfSZzBgtDAhiUXNrPrQiHyM6QJf/yIdWsNtB8+jwMVCpUC5ByUO6f1S4
 C1bzpWUp803S7gx3OGAg7LwrJB9R/zRSX84HUsd4mnlKjE5XgPaJOJ2AkcCQbAbjKzZIJ7tJW
 +jrl5rRiXZPBhzGvulHVmf36Xun283mSt9xp0NMnRxeWcMcXkn+qdQTnoNYBJbd+XOlTTTyBt
 V1kUwq9A/rkFY9y29KfjWJMN3btPR/IEuxvDv0DU7L9EHXQooE8T/KVr8LGjTQDXmJeh4MTrD
 P0ActVgZhrROV9BO2AUSCQQ/NHyKRGIABbKPsDKY9+J2C29moukmwIFM0nXTIQSXcIzqjcBzk
 gllk9MoRTZLQ1O0r6eJVuX9VcLXbVUhZT6aGPUrKdh0TuWhPOuy7m/4zrBSGfoG3ZfZK3lu4a
 /ET9MVuRZj0LjxaDupiVYI1w0+sqiec8HFVW6+eJXeRWiYwLd1NmHrnEAW0giwm6QI/eot/du
 cdlHNgrY4KOjkOQgadZxc4933mkCoUyyhkyXvDCWkW19i1OT6g1NyzIdb2lhq+K9V9xSwNTCR
 QfwZjAihIdEJNCwsUpn/rTzVC0YD7xjZeD2SA6AJbwQxevuxYjZd+E3ypqAsjs0gaD7J4Ey46
 2m0lFwaSvVEPWfV7vH7QjS9ANG0+aUvkCfrki6DOVWFNugi7AADZQy4DmZhnRuv+2iBm8ylHU
 7AcjZUeLHxvuGEz+YKxSIP9U85BGnJEnsmtzloEffGPSQ5sCMk87uCdA7NVv90chnuJMqePs5
 ZEoFp0Ct9vMxwhqCPRMNNSjopn3/mBBPEVfIug5MiS2AuP2ohE6crnquTGGq3V3+mtZzgk7lc
 2kuYZEnO4NwPO1tZ4v+TyY/9oX/2V2PNM7XmCvvxGdWvibr4QAiQs3YN15YnbMGa3u0BlJjJ8
 vKb5Z77gmwDdHYDeZ2oTn40yO3kApvdDWvzZq79dtsxykh0IHP0txPClFD4afvAWFSde6V/Y9
 mAIMiNH+xEDDDLg7DvSp7fgSpBhg4cqH2BeowcW4l3ndEfI7/rq63Y3HGA8qLBTz2iqPcCq/I
 8iTpLA5brfG77Ji9e7BOVMzkT1QiqDEVzmMAq7buKedhuQxQdmz2tp/1iB6d14NwISn2U5+pc
 L401OjzCqKoEAsYE/uw9Ubz1HPxwfVyWQJ8xzlyiJjMoIkzpcjSOQFSDF762WYDagQEBNb1QL
 zDZlDIxIibeG60Ag9772PYzDbPhpe7CbHTd8VZlVjq7ao5LvIV/20Ky6GNMlHq9nXbZiJQZd2
 AgMZ097SwWSdauFvjDFq1UAyhpiuBv6IGbJu7DEtoIgY6WVf6tMcTDYI2pXZpbBHX5+fw9UgW
 mBGTPoaFcHjklNatvPC4thzUXJ9XYRkPlndqeJaqUyPt5MNhWb3jtUjhbKiZwf8kr0wnGfNxm
 B5wYYGsf538AfUqR8YdKA6mbaucShVRWL/RDHnGT9KsjaIXnVs5+2dXs6HsCpsTv2w3QtVHrb
 t4UxWV6wiZdvuFrMODdLPonGhe78vVYM8iK2nAm/NQ3O4FPcZuEKjK5UTMcnPGW5If0bDF4Vl
 kksTmEdkq0p4IBvuNKKoi4+icf6fU1WKkjqKiTzD8R9XpB/SrjAuHc/pSOBlEJajDLINu8MEG
 7Ko/clZ/3OaAmJ/BLZk/hnhLwIcQfaZq3VwC9zzUBT4NUFwE7lNUoThaQKAmotW6Dit8qBA5v
 KtYJy42kYxtAJ9PTHHp4TexVn/Fvy3KkNmPpJrXlIZiA3R4MLpQm9z71B+4jS4IHorNKVNy8v
 szf+wftmXMdOE4ThuIlBBj4r1NpgSlvy2EaZ8yiWv1tj9bMzKP5W3BQA81u2sU/ZoxS9lLF+0
 p3HxKjBMuDZQy/2vKs1Ro9HEC65ShtpgYyOk5kttecWJCpYL7Xhq7mt+ohhBJkDPjLwS73/8u
 9IZ95szBzqGIFBq6B91t3dfEzOYYhZLjSBVfRyN0cDTNiNvIaiDuH/tR+KleFvEwhTGtNc6G7
 aEIAKa7M38pdqCWRhi6a8KeoMxq5xuTChQRhY3qw7joKHpyDi9VpjyxthQ2y4SIzfKKwZYMNJ
 FyPoZvJxGFt2ewKoxsoAf8pZANcYLS6Uo2E7vFfAR+nIVwm02HMGRRsiwsL/wGZbKpz+mfO+v
 f8DMK9D1T4Iy63KjiNoTlpSNMW9q6XmkZRr/clyOvmy

On 5/20/25 11:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The decompressor is built with the default C dialect, which is now gnu23
> on gcc-15, and this clashes with the kernel's bool type definition:
>=20
> In file included from include/uapi/linux/posix_types.h:5,
>                   from arch/parisc/boot/compressed/misc.c:7:
> include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumer=
ation constant
>     11 |         false   =3D 0,
>=20
> Add the -std=3Dgnu11 argument here, as we do for all other architectures=
.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/parisc/boot/compressed/Makefile | 1 +
>   1 file changed, 1 insertion(+)

applied.
Thanks!
Helge

