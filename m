Return-Path: <stable+bounces-47789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AFF8D6269
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 15:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA2C1F217DF
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457B158D6F;
	Fri, 31 May 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="FjR9YMk4"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83720158A02;
	Fri, 31 May 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160961; cv=none; b=qcwl0aicdyJYhf1xx8AdO2JZhzn0w3VEhEriFBuF7MPn8/DmVtoFqKuJHCMvQ4rv2xjFh1plp6jFhjmXMbaSnVNfu35X3JWAN1nrZfSqaKq0N70fFe/qExGqbyRtA7cKF/htWFPLcJ6Fza2xhdCK02qpoOjZdZwT4ipel4Pw78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160961; c=relaxed/simple;
	bh=TBWutSQQaYtaDvTdA7RuLuKmuyAU0/itUa+isgvy6GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDuQksZWd0+8Xy5N9LLCpaHiv4nzn1YP7QGS3cVYvSyC+k7PdVcmMAgpft++ezf95pTfUSz95e0xOO3Gl33FjTlRVY8etW8TQ4Nk+crIR2WItllFe2liyNykjZT2mvNv9uxAzldp4Ly0IBb2lWVkWrTCmSpgEjGjiOUK1ug5X8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=FjR9YMk4; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1717160936; x=1717765736; i=christian@heusel.eu;
	bh=7YoOqVIeXe2yk22zrxsappVKUOLfj5gc9fd9CgWTatk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FjR9YMk45XXKbOFT9Q3g4nJPKRWFMDi7H7zr6EArTFJ/EeSiyiEUbMTK1461FPnd
	 AsNhuLBfWytmLMLd8f1zqm6DxZdZHiDSgDiI8xc/IiPxTqIQcyBlqkPf6JlsJDlPu
	 fpciR14b84y599fXMpYAfF8p4KFMDjGfYfFP3zqF0xWx0o4fPX8KGGF/sKnSIKX8e
	 yKKoYA0o+GmLRFnd1cQW49hmrMCP6rSVicH+5H+nmI+moljbsWXELiFLPLEuxzlTc
	 5+pT+RjHwLXyw3QbSP4Dj3UFdQFe1Fq/iMs95+LdyLSsYzrgZKJ44KfiFFGgqNDxb
	 i9WN6NLpf5og12lY1w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MZkxd-1s1BsO206J-00Wowy; Fri, 31
 May 2024 15:08:55 +0200
Date: Fri, 31 May 2024 15:08:53 +0200
From: Christian Heusel <christian@heusel.eu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Schneider <pschneider1968@googlemail.com>, 
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology
 detection
Message-ID: <b42363ac-31ef-4b1a-9164-67c0e0af3768@heusel.eu>
References: <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx>
 <87o78n8fe2.ffs@tglx>
 <87le3r8dyw.ffs@tglx>
 <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
 <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu>
 <87cyp28j0b.ffs@tglx>
 <875xuu8hx0.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jazhwfw32z5ykiyn"
Content-Disposition: inline
In-Reply-To: <875xuu8hx0.ffs@tglx>
X-Provags-ID: V03:K1:iD/WN5wB4UQxUrfkWLRk3LG2yypjlIL4qoiXkAd9hS/hM7a6r6a
 gmVlnTo5z9WhSNqLyfwy8A4ASLe+rgs595vfQjh894aONklqYYXlBB7BW78EI+MA5LEtoHc
 32OxQYOS5qwabB3uD3QaqJUM9/LgW7HDr0O4s4D+8aEQw2nfwF0Rgk2A4d7wevhP891JVBu
 LsVng6L6tDMFG/OEjOeCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3aYz19eBd5U=;o9HqrUoCSHpLKbyWH1bc+jir8k3
 nM8QtgMRONKBF/ELBs5USIphP3LWqA64HBiVPBJprsOSLE1Dl+tfbvPMUyIAKGOcunAMdrkde
 QXz65NvD694AWJWWIQRIlbhT/agWOOVHReEJZWK4yE5MZRg+R3hyitOJmq4s+ZVk5ekxqFqaQ
 7ep6DsxWEbgMvrkaC5azGBsD9Fq4ybtNVQhPBD4aGOC14kGsbZWFFJaId4d29yjDQhAXGp8tf
 Iw9T3Y+L6YVWYjDA3y7ejK+d/R0JpwSFoW79DqoSF6wSONtCjlFTlLIvb+DpqKPY8d/Lva37Y
 SFvsG4vqe3g6sbyn3DQc2xukCIrzsWJDqAjNF3OUz3taFpTZaJ4OympXoeaLYA2w959s/fACq
 HsD6lsp5YJo62Jwg0DJjsCJ7EnCyjnp3JTSW4bYQXjsAmRNJRMSvJYBhD9DCJa8EjlsK6PYS0
 CHfejoZlTXeplEM5aM4EbVVFhdvfE4cDgwukhCV8eIb6Cdnjofp+Hg48C9MSEVTHIg8zmmO9J
 ev9JZIkr49lv+mV3Eeoze4rr95KSi9KY5JBkhMZS72iQLlsWfFImJt1ZYHMwaU2MFoYUVfkVw
 05FvD7Qvhxa5AydXZ4Mpa6/aFq8Oa5rYK4H8cdpBlsujkXOaMN/pcdShGhm6nriixtFD8L72k
 DkU99r2PJZ3jV73K+WmHsWoA8WOnlzdNEix7mq9Tr1z7LoNamI24Dcnx7wCYwVWLGXf+rJamm
 96F4jFiMnWAEkTpJZrXEIlQYms47C5i1fqI7f1ENKF8AI7v/YBWB3Q=


--jazhwfw32z5ykiyn
Content-Type: multipart/mixed; boundary="hnvnxajk7nx6tppr"
Content-Disposition: inline


--hnvnxajk7nx6tppr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/31 11:11AM, Thomas Gleixner wrote:
> On Fri, May 31 2024 at 10:48, Thomas Gleixner wrote:
>=20
> It seems there are two different issues here. The dmesg you provided is
> from a i7-1255U, which is a hybrid CPU. The i7-7700k has 4 cores (8
> threads) and there is not necessarily the same root cause.

It seems like I was also below my needed caffeine levels :p The person
reporting (in the same thread) with the i7-7700k reports the problem
fixed[1] as well, so this is in line with Peters observerations!

The other person with the i7-1255U in the meantime got back to me with
the needed outputs:

> Can I get:
>
> - dmesg from 6.8.y kernel

See attachment (dmesg6.8.9-arch1-2.log)

> - output of cpuid -r

Basic Leafs :
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0x00000000: EAX=3D0x00000020, EBX=3D0x756e6547, ECX=3D0x6c65746e, EDX=3D0x4=
9656e69
0x00000001: EAX=3D0x000906a4, EBX=3D0x12400800, ECX=3D0x7ffafbff, EDX=3D0xb=
febfbff
0x00000002: EAX=3D0x00feff01, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x0=
0000000
0x00000004: subleafs:
  0: EAX=3D0x7c004121, EBX=3D0x01c0003f, ECX=3D0x0000003f, EDX=3D0x00000000
  1: EAX=3D0x7c004122, EBX=3D0x01c0003f, ECX=3D0x0000007f, EDX=3D0x00000000
  2: EAX=3D0x7c01c143, EBX=3D0x03c0003f, ECX=3D0x000007ff, EDX=3D0x00000000
  3: EAX=3D0x7c0fc163, EBX=3D0x02c0003f, ECX=3D0x00003fff, EDX=3D0x00000004
0x00000005: EAX=3D0x00000040, EBX=3D0x00000040, ECX=3D0x00000003, EDX=3D0x1=
0102020
0x00000006: EAX=3D0x00df8ff7, EBX=3D0x00000002, ECX=3D0x00000409, EDX=3D0x0=
0020003
0x00000007: subleafs:
  0: EAX=3D0x00000002, EBX=3D0x239ca7eb, ECX=3D0x984007bc, EDX=3D0xfc18c410
  1: EAX=3D0x00400810, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x00040000
  2: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x00000017
0x0000000a: EAX=3D0x07300605, EBX=3D0x00000000, ECX=3D0x00000007, EDX=3D0x0=
0008603
0x0000000b: subleafs:
  0: EAX=3D0x00000001, EBX=3D0x00000001, ECX=3D0x00000100, EDX=3D0x00000012
  1: EAX=3D0x00000006, EBX=3D0x0000000c, ECX=3D0x00000201, EDX=3D0x00000012
0x0000000d: subleafs:
  0: EAX=3D0x00000207, EBX=3D0x00000a88, ECX=3D0x00000a88, EDX=3D0x00000000
  1: EAX=3D0x0000000f, EBX=3D0x00000680, ECX=3D0x00009900, EDX=3D0x00000000
  2: EAX=3D0x00000100, EBX=3D0x00000240, ECX=3D0x00000000, EDX=3D0x00000000
  8: EAX=3D0x00000080, EBX=3D0x00000000, ECX=3D0x00000001, EDX=3D0x00000000
  9: EAX=3D0x00000008, EBX=3D0x00000a80, ECX=3D0x00000000, EDX=3D0x00000000
 11: EAX=3D0x00000010, EBX=3D0x00000000, ECX=3D0x00000001, EDX=3D0x00000000
 12: EAX=3D0x00000018, EBX=3D0x00000000, ECX=3D0x00000001, EDX=3D0x00000000
 15: EAX=3D0x00000328, EBX=3D0x00000000, ECX=3D0x00000001, EDX=3D0x00000000
0x00000010: subleafs:
  0: EAX=3D0x00000000, EBX=3D0x00000004, ECX=3D0x00000000, EDX=3D0x00000000
  2: EAX=3D0x0000000f, EBX=3D0x00000000, ECX=3D0x00000004, EDX=3D0x0000000f
0x00000014: subleafs:
  0: EAX=3D0x00000001, EBX=3D0x0000005f, ECX=3D0x80000007, EDX=3D0x00000000
  1: EAX=3D0x02490002, EBX=3D0x003f003f, ECX=3D0x00000000, EDX=3D0x00000000
0x00000015: EAX=3D0x00000002, EBX=3D0x00000088, ECX=3D0x0249f000, EDX=3D0x0=
0000000
0x00000016: EAX=3D0x00000a28, EBX=3D0x00000dac, ECX=3D0x00000064, EDX=3D0x0=
0000000
0x00000018: subleafs:
  0: EAX=3D0x00000004, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x00000000
  1: EAX=3D0x00000000, EBX=3D0x00300001, ECX=3D0x00000001, EDX=3D0x00000121
  2: EAX=3D0x00000000, EBX=3D0x00040003, ECX=3D0x00000200, EDX=3D0x00000043
  3: EAX=3D0x00000000, EBX=3D0x00400001, ECX=3D0x00000001, EDX=3D0x00000122
  4: EAX=3D0x00000000, EBX=3D0x00080008, ECX=3D0x00000001, EDX=3D0x00000143
0x0000001a: EAX=3D0x20000001, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x0=
0000000
0x0000001c: EAX=3D0xc000000b, EBX=3D0x00000007, ECX=3D0x00000007, EDX=3D0x0=
0000000
0x0000001f: subleafs:
  0: EAX=3D0x00000001, EBX=3D0x00000001, ECX=3D0x00000100, EDX=3D0x00000012
  1: EAX=3D0x00000007, EBX=3D0x0000000c, ECX=3D0x00000201, EDX=3D0x00000012
  2: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000002, EDX=3D0x00000012
  3: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000003, EDX=3D0x00000012
  4: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000004, EDX=3D0x00000012
  5: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000005, EDX=3D0x00000012
  6: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000006, EDX=3D0x00000012
  7: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000007, EDX=3D0x00000012
  8: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000008, EDX=3D0x00000012
  9: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000009, EDX=3D0x00000012
 10: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000000a, EDX=3D0x00000012
 11: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000000b, EDX=3D0x00000012
 12: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000000c, EDX=3D0x00000012
 13: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000000d, EDX=3D0x00000012
 14: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000000e, EDX=3D0x00000012
 15: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000000f, EDX=3D0x00000012
 16: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000010, EDX=3D0x00000012
 17: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000011, EDX=3D0x00000012
 18: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000012, EDX=3D0x00000012
 19: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000013, EDX=3D0x00000012
 20: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000014, EDX=3D0x00000012
 21: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000015, EDX=3D0x00000012
 22: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000016, EDX=3D0x00000012
 23: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000017, EDX=3D0x00000012
 24: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000018, EDX=3D0x00000012
 25: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000019, EDX=3D0x00000012
 26: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000001a, EDX=3D0x00000012
 27: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000001b, EDX=3D0x00000012
 28: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000001c, EDX=3D0x00000012
 29: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000001d, EDX=3D0x00000012
 30: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000001e, EDX=3D0x00000012
 31: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x0000001f, EDX=3D0x00000012
0x00000020: EAX=3D0x00000000, EBX=3D0x00000001, ECX=3D0x00000000, EDX=3D0x0=
0000000
Extended Leafs :
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0x80000000: EAX=3D0x80000008, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x0=
0000000
0x80000001: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000121, EDX=3D0x2=
c100800
0x80000002: EAX=3D0x68743231, EBX=3D0x6e654720, ECX=3D0x746e4920, EDX=3D0x5=
2286c65
0x80000003: EAX=3D0x6f432029, EBX=3D0x54286572, ECX=3D0x6920294d, EDX=3D0x3=
2312d37
0x80000004: EAX=3D0x00553535, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x0=
0000000
0x80000006: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x08008040, EDX=3D0x0=
0000000
0x80000007: EAX=3D0x00000000, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x0=
0000100
0x80000008: EAX=3D0x00003027, EBX=3D0x00000000, ECX=3D0x00000000, EDX=3D0x0=
0000000


> - content of /sys/kernel/debug/x86/topo/cpus/* (on 6.9.y)

See attachment (cat_debug.log)

Cheers,
chris


[1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/57#note_189134

--hnvnxajk7nx6tppr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg6.8.9-arch1-2.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.8.9-arch1-2 (linux@archlinux) (gcc (GCC) 14.=
1.1 20240507, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue, 07 =
May 2024 21:35:54 +0000
[    0.000000] Command line: ro root=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b=
26c33ae resume=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b26c33ae rw add_efi_mem=
map resume_offset=3D2170880 quiet split_lock_detect=3Doff loglevel=3D3 nowa=
tchdog mitigations=3Doff initrd=3D\boot\initramfs-linux.img
[    0.000000] x86/split lock detection: disabled
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000407cdfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000407ce000-0x00000000407cefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000407cf000-0x000000004244dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000004244e000-0x000000004244efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000004244f000-0x0000000071ca8fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000071ca9000-0x000000007544bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007544c000-0x000000007553dfff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007553e000-0x0000000075619fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007561a000-0x0000000075ffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000075fff000-0x0000000075ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000076000000-0x0000000079ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007a600000-0x000000007a7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ac00000-0x00000000803fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fbfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=3D0x755b6000 ACPI 2.0=3D0x755b6014 TPMFinalLog=3D0=
x75585000 SMBIOS=3D0x75dae000 SMBIOS 3.0=3D0x75dad000 MEMATTR=3D0x6ecf8198 =
ESRT=3D0x6ef4a398 INITRD=3D0x6599fd98 RNG=3D0x7548a018 TPMEventLog=3D0x6660=
3018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem110: MMIO range=3D[0xc0000000-0xcfffffff] (25=
6MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Not removing mem111: MMIO range=3D[0xfe000000-0xfe010ff=
f] (68KB) from e820 map
[    0.000000] efi: Not removing mem112: MMIO range=3D[0xfec00000-0xfec00ff=
f] (4KB) from e820 map
[    0.000000] efi: Not removing mem113: MMIO range=3D[0xfed00000-0xfed00ff=
f] (4KB) from e820 map
[    0.000000] efi: Not removing mem115: MMIO range=3D[0xfee00000-0xfee00ff=
f] (4KB) from e820 map
[    0.000000] efi: Remove mem116: MMIO range=3D[0xff000000-0xffffffff] (16=
MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: Default string Default string/Default string, BIOS GLX2=
58-A V0.0.5 07/23/2022
[    0.000000] tsc: Detected 2600.000 MHz processor
[    0.000000] tsc: Detected 2611.200 MHz TSC
[    0.000351] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000352] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000358] last_pfn =3D 0x87fc00 max_arch_pfn =3D 0x400000000
[    0.000360] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000361] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000709] last_pfn =3D 0x76000 max_arch_pfn =3D 0x400000000
[    0.009371] esrt: Reserving ESRT space from 0x000000006ef4a398 to 0x0000=
00006ef4a3d0.
[    0.009374] e820: update [mem 0x6ef4a000-0x6ef4afff] usable =3D=3D> rese=
rved
[    0.009386] Using GB pages for direct mapping
[    0.009387] Incomplete global flushes, disabling PCID
[    0.009532] Secure boot enabled
[    0.009533] RAMDISK: [mem 0x61b6f000-0x62d1bfff]
[    0.009557] ACPI: Early table checksum verification disabled
[    0.009559] ACPI: RSDP 0x00000000755B6014 000024 (v02 ALASKA)
[    0.009562] ACPI: XSDT 0x00000000755B5728 000104 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009566] ACPI: FACP 0x0000000075534000 000114 (v06 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009569] ACPI: DSDT 0x00000000754BF000 074A9A (v02 ALASKA A M I    01=
072009 INTL 20200717)
[    0.009571] ACPI: FACS 0x0000000075619000 000040
[    0.009573] ACPI: SSDT 0x0000000075535000 006C41 (v02 DptfTb DptfTabl 00=
001000 INTL 20200717)
[    0.009575] ACPI: FIDT 0x00000000754BE000 00009C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.009577] ACPI: SSDT 0x000000007553D000 00038C (v02 PmaxDv Pmax_Dev 00=
000001 INTL 20200717)
[    0.009579] ACPI: SSDT 0x00000000754B8000 005D0B (v02 CpuRef CpuSsdt  00=
003000 INTL 20200717)
[    0.009581] ACPI: SSDT 0x00000000754B5000 002AA1 (v02 SaSsdt SaSsdt   00=
003000 INTL 20200717)
[    0.009583] ACPI: SSDT 0x00000000754B1000 0033D3 (v02 INTEL  IgfxSsdt 00=
003000 INTL 20200717)
[    0.009584] ACPI: HPET 0x000000007553C000 000038 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009586] ACPI: APIC 0x00000000754B0000 0001DC (v05 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009588] ACPI: MCFG 0x00000000754AF000 00003C (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009590] ACPI: SSDT 0x00000000754A6000 008384 (v02 ALASKA AdlP_Rvp 00=
001000 INTL 20200717)
[    0.009591] ACPI: SSDT 0x00000000754A4000 0019D1 (v02 ALASKA Ther_Rvp 00=
001000 INTL 20200717)
[    0.009593] ACPI: UEFI 0x000000007556C000 000048 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009595] ACPI: NHLT 0x00000000754A3000 00002D (v00 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009596] ACPI: LPIT 0x00000000754A2000 0000CC (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009598] ACPI: SSDT 0x000000007549E000 002A83 (v02 ALASKA PtidDevc 00=
001000 INTL 20200717)
[    0.009600] ACPI: SSDT 0x000000007549B000 002357 (v02 ALASKA TbtTypeC 00=
000000 INTL 20200717)
[    0.009602] ACPI: DBGP 0x000000007549A000 000034 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009603] ACPI: DBG2 0x0000000075499000 00005C (v00 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009605] ACPI: SSDT 0x0000000075498000 00078E (v02 INTEL  xh_adlLP 00=
000000 INTL 20200717)
[    0.009607] ACPI: SSDT 0x0000000075494000 003AEA (v02 SocGpe SocGpe   00=
003000 INTL 20200717)
[    0.009608] ACPI: SSDT 0x0000000075490000 0039DA (v02 SocCmn SocCmn   00=
003000 INTL 20200717)
[    0.009610] ACPI: SSDT 0x000000007548F000 000144 (v02 Intel  ADebTabl 00=
001000 INTL 20200717)
[    0.009612] ACPI: BGRT 0x000000007548E000 000038 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.009614] ACPI: TPM2 0x000000007548D000 00004C (v04 ALASKA A M I    00=
000001 AMI  00000000)
[    0.009615] ACPI: PHAT 0x000000007548C000 0004EA (v01 ALASKA A M I    00=
000005 MSFT 0100000D)
[    0.009617] ACPI: WSMT 0x00000000754A1000 000028 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.009619] ACPI: FPDT 0x000000007548B000 000044 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.009620] ACPI: Reserving FACP table memory at [mem 0x75534000-0x75534=
113]
[    0.009621] ACPI: Reserving DSDT table memory at [mem 0x754bf000-0x75533=
a99]
[    0.009622] ACPI: Reserving FACS table memory at [mem 0x75619000-0x75619=
03f]
[    0.009622] ACPI: Reserving SSDT table memory at [mem 0x75535000-0x7553b=
c40]
[    0.009623] ACPI: Reserving FIDT table memory at [mem 0x754be000-0x754be=
09b]
[    0.009624] ACPI: Reserving SSDT table memory at [mem 0x7553d000-0x7553d=
38b]
[    0.009624] ACPI: Reserving SSDT table memory at [mem 0x754b8000-0x754bd=
d0a]
[    0.009625] ACPI: Reserving SSDT table memory at [mem 0x754b5000-0x754b7=
aa0]
[    0.009625] ACPI: Reserving SSDT table memory at [mem 0x754b1000-0x754b4=
3d2]
[    0.009626] ACPI: Reserving HPET table memory at [mem 0x7553c000-0x7553c=
037]
[    0.009626] ACPI: Reserving APIC table memory at [mem 0x754b0000-0x754b0=
1db]
[    0.009627] ACPI: Reserving MCFG table memory at [mem 0x754af000-0x754af=
03b]
[    0.009627] ACPI: Reserving SSDT table memory at [mem 0x754a6000-0x754ae=
383]
[    0.009628] ACPI: Reserving SSDT table memory at [mem 0x754a4000-0x754a5=
9d0]
[    0.009628] ACPI: Reserving UEFI table memory at [mem 0x7556c000-0x7556c=
047]
[    0.009629] ACPI: Reserving NHLT table memory at [mem 0x754a3000-0x754a3=
02c]
[    0.009629] ACPI: Reserving LPIT table memory at [mem 0x754a2000-0x754a2=
0cb]
[    0.009630] ACPI: Reserving SSDT table memory at [mem 0x7549e000-0x754a0=
a82]
[    0.009630] ACPI: Reserving SSDT table memory at [mem 0x7549b000-0x7549d=
356]
[    0.009631] ACPI: Reserving DBGP table memory at [mem 0x7549a000-0x7549a=
033]
[    0.009631] ACPI: Reserving DBG2 table memory at [mem 0x75499000-0x75499=
05b]
[    0.009632] ACPI: Reserving SSDT table memory at [mem 0x75498000-0x75498=
78d]
[    0.009632] ACPI: Reserving SSDT table memory at [mem 0x75494000-0x75497=
ae9]
[    0.009633] ACPI: Reserving SSDT table memory at [mem 0x75490000-0x75493=
9d9]
[    0.009633] ACPI: Reserving SSDT table memory at [mem 0x7548f000-0x7548f=
143]
[    0.009633] ACPI: Reserving BGRT table memory at [mem 0x7548e000-0x7548e=
037]
[    0.009634] ACPI: Reserving TPM2 table memory at [mem 0x7548d000-0x7548d=
04b]
[    0.009635] ACPI: Reserving PHAT table memory at [mem 0x7548c000-0x7548c=
4e9]
[    0.009635] ACPI: Reserving WSMT table memory at [mem 0x754a1000-0x754a1=
027]
[    0.009636] ACPI: Reserving FPDT table memory at [mem 0x7548b000-0x7548b=
043]
[    0.009759] No NUMA configuration found
[    0.009760] Faking a node at [mem 0x0000000000000000-0x000000087fbfffff]
[    0.009761] NODE_DATA(0) allocated [mem 0x87fbfb000-0x87fbfffff]
[    0.009783] Zone ranges:
[    0.009784]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009785]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009786]   Normal   [mem 0x0000000100000000-0x000000087fbfffff]
[    0.009786]   Device   empty
[    0.009787] Movable zone start for each node
[    0.009787] Early memory node ranges
[    0.009788]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.009789]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.009789]   node   0: [mem 0x0000000000100000-0x00000000407cdfff]
[    0.009790]   node   0: [mem 0x00000000407cf000-0x000000004244dfff]
[    0.009790]   node   0: [mem 0x000000004244f000-0x0000000071ca8fff]
[    0.009791]   node   0: [mem 0x0000000075fff000-0x0000000075ffffff]
[    0.009791]   node   0: [mem 0x0000000100000000-0x000000087fbfffff]
[    0.009793] Initmem setup node 0 [mem 0x0000000000001000-0x000000087fbff=
fff]
[    0.009795] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009796] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009807] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.010818] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.011584] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.011674] On node 0, zone DMA32: 17238 pages in unavailable ranges
[    0.041099] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.041105] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.041125] Reserving Intel graphics memory at [mem 0x7c800000-0x803ffff=
f]
[    0.041551] ACPI: PM-Timer IO Port: 0x1808
[    0.041556] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.041557] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.041557] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.041558] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.041558] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.041559] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.041559] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.041559] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.041560] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.041560] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.041560] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.041561] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.041561] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.041562] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.041562] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.041562] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.041563] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.041563] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.041564] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.041564] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.041564] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.041565] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.041565] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.041566] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.041600] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.041602] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.041603] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.041606] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.041606] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.041611] e820: update [mem 0x6e4b1000-0x6e503fff] usable =3D=3D> rese=
rved
[    0.041618] TSC deadline timer available
[    0.041619] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[    0.041631] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.041632] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0=
x0009efff]
[    0.041633] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.041633] PM: hibernation: Registered nosave memory: [mem 0x407ce000-0=
x407cefff]
[    0.041634] PM: hibernation: Registered nosave memory: [mem 0x4244e000-0=
x4244efff]
[    0.041635] PM: hibernation: Registered nosave memory: [mem 0x6e4b1000-0=
x6e503fff]
[    0.041636] PM: hibernation: Registered nosave memory: [mem 0x6ef4a000-0=
x6ef4afff]
[    0.041637] PM: hibernation: Registered nosave memory: [mem 0x71ca9000-0=
x7544bfff]
[    0.041637] PM: hibernation: Registered nosave memory: [mem 0x7544c000-0=
x7553dfff]
[    0.041637] PM: hibernation: Registered nosave memory: [mem 0x7553e000-0=
x75619fff]
[    0.041638] PM: hibernation: Registered nosave memory: [mem 0x7561a000-0=
x75ffefff]
[    0.041638] PM: hibernation: Registered nosave memory: [mem 0x76000000-0=
x79ffffff]
[    0.041639] PM: hibernation: Registered nosave memory: [mem 0x7a000000-0=
x7a5fffff]
[    0.041639] PM: hibernation: Registered nosave memory: [mem 0x7a600000-0=
x7a7fffff]
[    0.041640] PM: hibernation: Registered nosave memory: [mem 0x7a800000-0=
x7abfffff]
[    0.041640] PM: hibernation: Registered nosave memory: [mem 0x7ac00000-0=
x803fffff]
[    0.041640] PM: hibernation: Registered nosave memory: [mem 0x80400000-0=
xfdffffff]
[    0.041641] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.041641] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.041641] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.041642] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.041642] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed00fff]
[    0.041642] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0=
xfed1ffff]
[    0.041643] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0=
xfed7ffff]
[    0.041643] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfedfffff]
[    0.041644] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.041644] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.041645] [mem 0x80400000-0xfdffffff] available for PCI devices
[    0.041646] Booting paravirtualized kernel on bare hardware
[    0.041647] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.044978] setup_percpu: NR_CPUS:320 nr_cpumask_bits:12 nr_cpu_ids:12 n=
r_node_ids:1
[    0.045331] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u262144
[    0.045335] pcpu-alloc: s225280 r8192 d28672 u262144 alloc=3D1*2097152
[    0.045336] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -=
- -- --=20
[    0.045348] Kernel command line: ro root=3DUUID=3D9bf7c08f-ded6-4cf7-864=
f-9eb6b26c33ae resume=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b26c33ae rw add_=
efi_memmap resume_offset=3D2170880 quiet split_lock_detect=3Doff loglevel=
=3D3 nowatchdog mitigations=3Doff initrd=3D\boot\initramfs-linux.img
[    0.045415] Unknown kernel command line parameters "split_lock_detect=3D=
off", will be passed to user space.
[    0.047367] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    0.048343] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    0.048422] Fallback order for Node 0: 0=20
[    0.048424] Built 1 zonelists, mobility grouping on.  Total pages: 81989=
81
[    0.048425] Policy zone: Normal
[    0.048564] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.048568] software IO TLB: area num 16.
[    0.095022] Memory: 32448620K/33317144K available (16384K kernel code, 2=
121K rwdata, 12976K rodata, 3456K init, 3732K bss, 868264K reserved, 0K cma=
-reserved)
[    0.095157] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12, =
Nodes=3D1
[    0.095173] ftrace: allocating 49113 entries in 192 pages
[    0.099437] ftrace: allocated 192 pages with 2 groups
[    0.099486] Dynamic Preempt: full
[    0.099518] rcu: Preemptible hierarchical RCU implementation.
[    0.099518] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D12.
[    0.099519] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.099520] 	Trampoline variant of Tasks RCU enabled.
[    0.099520] 	Rude variant of Tasks RCU enabled.
[    0.099520] 	Tracing variant of Tasks RCU enabled.
[    0.099521] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.099522] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D12
[    0.100816] NR_IRQS: 20736, nr_irqs: 2152, preallocated irqs: 16
[    0.101096] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.101337] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.101357] Console: colour dummy device 80x25
[    0.101359] printk: legacy console [tty0] enabled
[    0.101384] ACPI: Core revision 20230628
[    0.101575] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.101576] APIC: Switch to symmetric I/O mode setup
[    0.102880] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.103219] APIC: Switched APIC routing to: physical flat
[    0.107638] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x25a39079a08, max_idle_ns: 440795310461 ns
[    0.107643] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5224.00 BogoMIPS (lpj=3D8704000)
[    0.107709] CPU0: Thermal monitoring enabled (TM1)
[    0.107710] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.107804] process: using mwait in idle threads
[    0.107805] CET detected: Indirect Branch Tracking enabled
[    0.107807] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.107808] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.107810] Spectre V2 : User space: Vulnerable
[    0.107811] Speculative Store Bypass: Vulnerable
[    0.107821] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.107821] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.107822] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.107822] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.107823] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.107823] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.107824] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.107825] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.107825] x86/fpu: Enabled xstate features 0xa07, context size is 856 =
bytes, using 'compacted' format.
[    0.110975] Freeing SMP alternatives memory: 40K
[    0.110975] pid_max: default: 32768 minimum: 301
[    0.110975] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bp=
f,integrity
[    0.110975] landlock: Up and running.
[    0.110975] Yama: becoming mindful.
[    0.110975] LSM support for eBPF active
[    0.110975] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    0.110975] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
[    0.110975] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1255U (family: =
0x6, model: 0x9a, stepping: 0x4)
[    0.110975] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.110975] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.110975] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.110975] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-base=
line,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-wid=
th counters, Intel PMU driver.
[    0.110975] core: cpu_core PMU driver:=20
[    0.110975] ... version:                5
[    0.110975] ... bit width:              48
[    0.110975] ... generic registers:      8
[    0.110975] ... value mask:             0000ffffffffffff
[    0.110975] ... max period:             00007fffffffffff
[    0.110975] ... fixed-purpose events:   4
[    0.110975] ... event mask:             0001000f000000ff
[    0.110975] signal: max sigframe size: 3632
[    0.110975] Estimated ratio of average max frequency by base frequency (=
times 1024): 1614
[    0.110975] rcu: Hierarchical SRCU implementation.
[    0.110975] rcu: 	Max phase no-delay instances is 1000.
[    0.110975] smp: Bringing up secondary CPUs ...
[    0.110975] smpboot: x86: Booting SMP configuration:
[    0.110975] .... node  #0, CPUs:        #2  #4  #5  #6  #7  #8  #9 #10 #=
11
[    0.009700] core: cpu_atom PMU driver: PEBS-via-PT=20
[    0.009700] ... version:                5
[    0.009700] ... bit width:              48
[    0.009700] ... generic registers:      6
[    0.009700] ... value mask:             0000ffffffffffff
[    0.009700] ... max period:             00007fffffffffff
[    0.009700] ... fixed-purpose events:   3
[    0.009700] ... event mask:             000000070000003f
[    0.114375]   #1  #3
[    0.115523] smp: Brought up 1 node, 12 CPUs
[    0.115523] smpboot: Max logical packages: 1
[    0.115523] smpboot: Total of 12 processors activated (62693.00 BogoMIPS)
[    0.118296] devtmpfs: initialized
[    0.118296] x86/mm: Memory block size: 128MB
[    0.118797] ACPI: PM: Registering ACPI NVS region [mem 0x7553e000-0x7561=
9fff] (901120 bytes)
[    0.118797] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.118797] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.118797] pinctrl core: initialized pinctrl subsystem
[    0.118797] PM: RTC time: 09:17:56, date: 2024-05-31
[    0.118797] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.118797] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.118806] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.121086] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.121091] audit: initializing netlink subsys (disabled)
[    0.121094] audit: type=3D2000 audit(1717147076.013:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.121094] thermal_sys: Registered thermal governor 'fair_share'
[    0.121094] thermal_sys: Registered thermal governor 'bang_bang'
[    0.121094] thermal_sys: Registered thermal governor 'step_wise'
[    0.121094] thermal_sys: Registered thermal governor 'user_space'
[    0.121094] thermal_sys: Registered thermal governor 'power_allocator'
[    0.121094] cpuidle: using governor ladder
[    0.121094] cpuidle: using governor menu
[    0.121094] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.121094] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for =
domain 0000 [bus 00-ff]
[    0.121094] PCI: not using ECAM ([mem 0xc0000000-0xcfffffff] not reserve=
d)
[    0.121094] PCI: Using configuration type 1 for base access
[    0.121136] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.121139] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.121139] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.121139] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.121139] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.121206] ACPI: Added _OSI(Module Device)
[    0.121206] ACPI: Added _OSI(Processor Device)
[    0.121206] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.121206] ACPI: Added _OSI(Processor Aggregator Device)
[    0.192887] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS01], AE_NOT_FOUND (20230628/dswload2-162)
[    0.192893] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.192895] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.192898] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS02], AE_NOT_FOUND (20230628/dswload2-162)
[    0.192900] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.192901] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.192904] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS03], AE_NOT_FOUND (20230628/dswload2-162)
[    0.192906] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.192907] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.192909] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS04], AE_NOT_FOUND (20230628/dswload2-162)
[    0.192911] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.192912] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.194606] ACPI: 14 ACPI AML tables successfully acquired and loaded
[    0.210268] ACPI: Dynamic OEM Table Load:
[    0.210268] ACPI: SSDT 0xFFFF9DE80133D400 000394 (v02 PmRef  Cpu0Cst  00=
003001 INTL 20200717)
[    0.210268] ACPI: Dynamic OEM Table Load:
[    0.210268] ACPI: SSDT 0xFFFF9DE80136F800 000605 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20200717)
[    0.210814] ACPI: Dynamic OEM Table Load:
[    0.210818] ACPI: SSDT 0xFFFF9DE8012A0200 0001AB (v02 PmRef  Cpu0Psd  00=
003000 INTL 20200717)
[    0.211690] ACPI: Dynamic OEM Table Load:
[    0.211695] ACPI: SSDT 0xFFFF9DE801368800 0004BA (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20200717)
[    0.212919] ACPI: Dynamic OEM Table Load:
[    0.212928] ACPI: SSDT 0xFFFF9DE801376000 001BAF (v02 PmRef  ApIst    00=
003000 INTL 20200717)
[    0.214496] ACPI: Dynamic OEM Table Load:
[    0.214502] ACPI: SSDT 0xFFFF9DE801372000 001038 (v02 PmRef  ApHwp    00=
003000 INTL 20200717)
[    0.215841] ACPI: Dynamic OEM Table Load:
[    0.215847] ACPI: SSDT 0xFFFF9DE801370000 001349 (v02 PmRef  ApPsd    00=
003000 INTL 20200717)
[    0.217238] ACPI: Dynamic OEM Table Load:
[    0.217244] ACPI: SSDT 0xFFFF9DE801342000 000FBB (v02 PmRef  ApCst    00=
003000 INTL 20200717)
[    0.221921] ACPI: _OSC evaluated successfully for all CPUs
[    0.221957] ACPI: EC: EC started
[    0.221958] ACPI: EC: interrupt blocked
[    0.227545] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.227547] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC used to handle tran=
sactions
[    0.227548] ACPI: Interpreter enabled
[    0.227590] ACPI: PM: (supports S0 S3 S4 S5)
[    0.227591] ACPI: Using IOAPIC for interrupt routing
[    0.228749] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for =
domain 0000 [bus 00-ff]
[    0.230583] PCI: ECAM [mem 0xc0000000-0xcfffffff] reserved as ACPI mothe=
rboard resource
[    0.230591] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.230592] PCI: Using E820 reservations for host bridge windows
[    0.232041] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.232830] ACPI: \_SB_.PC00.PEG1.PXP_: New power resource
[    0.233385] ACPI: \_SB_.PC00.PEG2.PXP_: New power resource
[    0.234576] ACPI: \_SB_.PC00.PEG0.PXP_: New power resource
[    0.366359] ACPI: \_SB_.PC00.RP05.PXP_: New power resource
[    0.374987] ACPI: \_SB_.PC00.PAUD: New power resource
[    0.384144] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.396016] ACPI: \PIN_: New power resource
[    0.396274] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.396279] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.397968] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.399388] PCI host bridge to bus 0000:00
[    0.399389] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.399391] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.399392] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.399394] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000ffff=
f window]
[    0.399395] pci_bus 0000:00: root bus resource [mem 0x80400000-0xbffffff=
f window]
[    0.399396] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7ffff=
fffff window]
[    0.399397] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.399560] pci 0000:00:00.0: [8086:4601] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.399684] pci 0000:00:02.0: [8086:46a8] type 00 class 0x030000 PCIe Ro=
ot Complex Integrated Endpoint
[    0.399692] pci 0000:00:02.0: BAR 0 [mem 0x6001000000-0x6001ffffff 64bit]
[    0.399697] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit=
 pref]
[    0.399700] pci 0000:00:02.0: BAR 4 [io  0x4000-0x403f]
[    0.399713] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.399714] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.399717] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.399740] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.399741] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]=
: contains BAR 0 for 7 VFs
[    0.399746] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit =
pref]
[    0.399747] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit =
pref]: contains BAR 2 for 7 VFs
[    0.399874] pci 0000:00:04.0: [8086:461d] type 00 class 0x118000 convent=
ional PCI endpoint
[    0.399886] pci 0000:00:04.0: BAR 0 [mem 0x6002100000-0x600211ffff 64bit]
[    0.400233] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.400263] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.400270] pci 0000:00:06.0:   bridge window [mem 0x80500000-0x805fffff]
[    0.400342] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.400380] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.400992] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330 convent=
ional PCI endpoint
[    0.401013] pci 0000:00:14.0: BAR 0 [mem 0x6002120000-0x600212ffff 64bit]
[    0.401099] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.402860] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000 convent=
ional PCI endpoint
[    0.402881] pci 0000:00:14.2: BAR 0 [mem 0x6002134000-0x6002137fff 64bit]
[    0.402894] pci 0000:00:14.2: BAR 2 [mem 0x600213b000-0x600213bfff 64bit]
[    0.403010] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.403032] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.403407] pci 0000:00:16.0: [8086:51e0] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.403430] pci 0000:00:16.0: BAR 0 [mem 0x6002139000-0x6002139fff 64bit]
[    0.403517] pci 0000:00:16.0: PME# supported from D3hot
[    0.403817] pci 0000:00:17.0: [8086:51d3] type 00 class 0x010601 convent=
ional PCI endpoint
[    0.403833] pci 0000:00:17.0: BAR 0 [mem 0x80600000-0x80601fff]
[    0.403842] pci 0000:00:17.0: BAR 1 [mem 0x80603000-0x806030ff]
[    0.403851] pci 0000:00:17.0: BAR 2 [io  0x4090-0x4097]
[    0.403860] pci 0000:00:17.0: BAR 3 [io  0x4080-0x4083]
[    0.403868] pci 0000:00:17.0: BAR 4 [io  0x4060-0x407f]
[    0.403877] pci 0000:00:17.0: BAR 5 [mem 0x80602000-0x806027ff]
[    0.403925] pci 0000:00:17.0: PME# supported from D3hot
[    0.404222] pci 0000:00:1d.0: [8086:51b0] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.404249] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.404254] pci 0000:00:1d.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.404331] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.404362] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.404908] pci 0000:00:1d.1: [8086:51b1] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.404935] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.404939] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
[    0.404950] pci 0000:00:1d.1:   bridge window [mem 0x6000000000-0x60000f=
ffff 64bit pref]
[    0.405018] pci 0000:00:1d.1: PME# supported from D0 D3hot D3cold
[    0.405048] pci 0000:00:1d.1: PTM enabled (root), 4ns granularity
[    0.405612] pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.406003] pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040100 convent=
ional PCI endpoint
[    0.406044] pci 0000:00:1f.3: BAR 0 [mem 0x6002130000-0x6002133fff 64bit]
[    0.406098] pci 0000:00:1f.3: BAR 4 [mem 0x6002000000-0x60020fffff 64bit]
[    0.406203] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.406500] pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.406521] pci 0000:00:1f.4: BAR 0 [mem 0x6002138000-0x60021380ff 64bit]
[    0.406543] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.406826] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.406845] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.407665] pci 0000:01:00.0: [1987:5013] type 00 class 0x010802 PCIe En=
dpoint
[    0.407681] pci 0000:01:00.0: BAR 0 [mem 0x80500000-0x80503fff 64bit]
[    0.408606] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.408856] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000 PCIe En=
dpoint
[    0.408943] pci 0000:02:00.0: BAR 0 [mem 0x80400000-0x80401fff 64bit]
[    0.409280] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.410264] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.410334] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.410353] pci 0000:03:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.410377] pci 0000:03:00.0: BAR 2 [mem 0x6000004000-0x6000004fff 64bit=
 pref]
[    0.410393] pci 0000:03:00.0: BAR 4 [mem 0x6000000000-0x6000003fff 64bit=
 pref]
[    0.410505] pci 0000:03:00.0: supports D1 D2
[    0.410506] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.410672] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.414701] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.414789] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.414874] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.414959] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.415045] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.415130] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.415215] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.415300] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.422696] ACPI: EC: interrupt unblocked
[    0.422697] ACPI: EC: event unblocked
[    0.422719] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.422720] ACPI: EC: GPE=3D0x6e
[    0.422721] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC initialization comp=
lete
[    0.422723] ACPI: \_SB_.PC00.LPCB.H_EC: EC: Used to handle transactions =
and events
[    0.424353] iommu: Default domain type: Translated
[    0.424353] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.424415] SCSI subsystem initialized
[    0.424419] libata version 3.00 loaded.
[    0.424419] ACPI: bus type USB registered
[    0.424419] usbcore: registered new interface driver usbfs
[    0.424419] usbcore: registered new interface driver hub
[    0.424419] usbcore: registered new device driver usb
[    0.424419] EDAC MC: Ver: 3.0.0
[    0.425321] efivars: Registered efivars operations
[    0.425321] NetLabel: Initializing
[    0.425321] NetLabel:  domain hash size =3D 128
[    0.425321] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.425321] NetLabel:  unlabeled traffic allowed by default
[    0.425321] mctp: management component transport protocol core
[    0.425321] NET: Registered PF_MCTP protocol family
[    0.425321] PCI: Using ACPI for IRQ routing
[    0.447194] PCI: pci_cache_line_size set to 64 bytes
[    0.451173] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't c=
laim; no compatible bridge window
[    0.452108] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.452109] e820: reserve RAM buffer [mem 0x407ce000-0x43ffffff]
[    0.452110] e820: reserve RAM buffer [mem 0x4244e000-0x43ffffff]
[    0.452111] e820: reserve RAM buffer [mem 0x6e4b1000-0x6fffffff]
[    0.452112] e820: reserve RAM buffer [mem 0x6ef4a000-0x6fffffff]
[    0.452112] e820: reserve RAM buffer [mem 0x71ca9000-0x73ffffff]
[    0.452113] e820: reserve RAM buffer [mem 0x76000000-0x77ffffff]
[    0.452114] e820: reserve RAM buffer [mem 0x87fc00000-0x87fffffff]
[    0.452138] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.452138] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.452138] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.452138] vgaarb: loaded
[    0.452138] clocksource: Switched to clocksource tsc-early
[    0.452138] VFS: Disk quotas dquot_6.6.0
[    0.452138] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.452138] pnp: PnP ACPI init
[    0.452953] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.452955] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.453068] system 00:01: [io  0x1854-0x1857] has been reserved
[    0.454816] pnp 00:02: disabling [mem 0xc0000000-0xcfffffff] because it =
overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.454836] system 00:02: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.454838] system 00:02: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.454839] system 00:02: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.454841] system 00:02: [mem 0xfed20000-0xfed7ffff] could not be reser=
ved
[    0.454842] system 00:02: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.454843] system 00:02: [mem 0xfed45000-0xfed8ffff] could not be reser=
ved
[    0.454844] system 00:02: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.455533] system 00:04: [io  0x2000-0x20fe] has been reserved
[    0.455921] system 00:05: [mem 0xfe03e008-0xfe03efff] has been reserved
[    0.455923] system 00:05: [mem 0xfe03f000-0xfe03ffff] has been reserved
[    0.456290] pnp: PnP ACPI: found 6 devices
[    0.461569] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.461637] NET: Registered PF_INET protocol family
[    0.461843] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.472515] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    0.472544] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.472693] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    0.473005] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.473118] TCP: Hash tables configured (established 262144 bind 65536)
[    0.473214] MPTCP token hash table entries: 32768 (order: 7, 786432 byte=
s, linear)
[    0.473277] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    0.473352] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    0.473410] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.473416] NET: Registered PF_XDP protocol family
[    0.473428] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64=
bit pref]: assigned
[    0.473433] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64=
bit]: assigned
[    0.473436] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit=
]: assigned
[    0.473451] resource: avoiding allocation from e820 entry [mem 0x000a000=
0-0x000fffff]
[    0.473453] resource: avoiding allocation from e820 entry [mem 0x000a000=
0-0x000fffff]
[    0.473454] pci 0000:00:1f.5: BAR 0 [mem 0x80604000-0x80604fff]: assigned
[    0.473466] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.473481] pci 0000:00:06.0:   bridge window [mem 0x80500000-0x805fffff]
[    0.473500] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.473505] pci 0000:00:1d.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.473511] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.473513] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
[    0.473519] pci 0000:00:1d.1:   bridge window [mem 0x6000000000-0x60000f=
ffff 64bit pref]
[    0.473524] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.473525] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.473526] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.473528] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000fffff windo=
w]
[    0.473529] pci_bus 0000:00: resource 8 [mem 0x80400000-0xbfffffff windo=
w]
[    0.473529] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff w=
indow]
[    0.473531] pci_bus 0000:01: resource 1 [mem 0x80500000-0x805fffff]
[    0.473532] pci_bus 0000:02: resource 1 [mem 0x80400000-0x804fffff]
[    0.473533] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    0.473533] pci_bus 0000:03: resource 2 [mem 0x6000000000-0x60000fffff 6=
4bit pref]
[    0.474875] PCI: CLS 64 bytes, default 64
[    0.474881] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.474882] software IO TLB: mapped [mem 0x000000005db6f000-0x0000000061=
b6f000] (64MB)
[    0.474940] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25a=
39079a08, max_idle_ns: 440795310461 ns
[    0.474978] Trying to unpack rootfs image as initramfs...
[    0.475036] clocksource: Switched to clocksource tsc
[    0.475061] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.480683] Initialise system trusted keyrings
[    0.480692] Key type blacklist registered
[    0.480749] workingset: timestamp_bits=3D41 max_order=3D23 bucket_order=
=3D0
[    0.480755] zbud: loaded
[    0.480829] fuse: init (API version 7.39)
[    0.480885] integrity: Platform Keyring initialized
[    0.480886] integrity: Machine keyring initialized
[    0.488412] Key type asymmetric registered
[    0.488414] Asymmetric key parser 'x509' registered
[    0.488426] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.488492] io scheduler mq-deadline registered
[    0.488493] io scheduler kyber registered
[    0.488499] io scheduler bfq registered
[    0.488853] pcieport 0000:00:06.0: PME: Signaling with IRQ 120
[    0.489058] pcieport 0000:00:1d.0: PME: Signaling with IRQ 121
[    0.489243] pcieport 0000:00:1d.1: PME: Signaling with IRQ 122
[    0.489312] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.490386] ACPI: AC: AC Adapter [ADP1] (on-line)
[    0.490421] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A0=
8:00/device:0b/PNP0C09:00/PNP0C0D:00/input/input0
[    0.490432] ACPI: button: Lid Switch [LID0]
[    0.490456] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.490467] ACPI: button: Power Button [PWRB]
[    0.490483] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    0.490492] ACPI: button: Sleep Button [SLPB]
[    0.490511] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[    0.490544] ACPI: button: Power Button [PWRF]
[    0.493115] thermal LNXTHERM:00: registered as thermal_zone0
[    0.493116] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.493293] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.497819] hpet_acpi_add: no address or irqs in _CRS
[    0.497853] Non-volatile memory driver v1.3
[    0.497854] Linux agpgart interface v0.103
[    0.505082] ACPI: bus type drm_connector registered
[    0.505990] ahci 0000:00:17.0: version 3.0
[    0.506008] Freeing initrd memory: 18100K
[    0.506191] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x=
2 impl SATA mode
[    0.506194] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio=
 slum part deso sadm sds=20
[    0.506639] scsi host0: ahci
[    0.506867] scsi host1: ahci
[    0.506894] ata1: DUMMY
[    0.506899] ata2: SATA max UDMA/133 abar m2048@0x80602000 port 0x8060218=
0 irq 123 lpm-pol 0
[    0.506951] usbcore: registered new interface driver usbserial_generic
[    0.506954] usbserial: USB Serial support registered for generic
[    0.507218] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.508093] rtc_cmos rtc_cmos: registered as rtc0
[    0.508273] rtc_cmos rtc_cmos: setting system clock to 2024-05-31T09:17:=
57 UTC (1717147077)
[    0.508297] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.508874] intel_pstate: Intel P-state driver initializing
[    0.509854] intel_pstate: HWP enabled
[    0.509905] ledtrig-cpu: registered to indicate activity on CPUs
[    0.510026] [drm] Initialized simpledrm 1.0.0 20200625 for simple-frameb=
uffer.0 on minor 0
[    0.510127] fbcon: Deferring console take-over
[    0.510128] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.510147] hid: raw HID events driver (C) Jiri Kosina
[    0.510194] drop_monitor: Initializing network drop monitor service
[    0.510254] NET: Registered PF_INET6 protocol family
[    0.514689] Segment Routing with IPv6
[    0.514689] RPL Segment Routing with IPv6
[    0.514692] In-situ OAM (IOAM) with IPv6
[    0.514704] NET: Registered PF_PACKET protocol family
[    0.515316] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.515578] microcode: Current revision: 0x00000433
[    0.515579] microcode: Updated early from: 0x0000041b
[    0.515955] resctrl: L2 allocation detected
[    0.515964] IPI shorthand broadcast: enabled
[    0.516848] sched_clock: Marking stable (510001376, 6367216)->(537944750=
, -21576158)
[    0.516977] registered taskstats version 1
[    0.517442] Loading compiled-in X.509 certificates
[    0.520235] Loaded X.509 cert 'Build time autogenerated kernel key: 4183=
282d70f116b65f2696270db916493ab86dc2'
[    0.522909] zswap: loaded using pool zstd/zsmalloc
[    0.523053] Key type .fscrypt registered
[    0.523053] Key type fscrypt-provisioning registered
[    0.523379] integrity: Loading X.509 certificate: UEFI:db
[    0.523392] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.523393] integrity: Loading X.509 certificate: UEFI:db
[    0.523401] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.523401] integrity: Loading X.509 certificate: UEFI:db
[    0.523686] integrity: Loaded X.509 cert 'my Signature Database key: f55=
742b17ee4c75ecb4f66293e2fbceddefed102'
[    0.524522] PM:   Magic number: 8:995:273
[    0.524546] tty tty10: hash matches
[    0.524549] net lo: hash matches
[    0.524568] acpi device:7b: hash matches
[    0.526100] RAS: Correctable Errors collector initialized.
[    0.529420] ACPI: battery: Slot [BAT0] (battery present)
[    0.818515] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.821585] ata2.00: ATA-10: Hanstor M.2 1TB, U0510A0, max UDMA/133
[    0.823267] ata2.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    0.829960] ata2.00: configured for UDMA/133
[    0.830986] scsi 1:0:0:0: Direct-Access     ATA      Hanstor M.2 1TB  0A=
0  PQ: 0 ANSI: 5
[    0.835140] sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)
[    0.835191] sd 1:0:0:0: [sda] Write Protect is off
[    0.835203] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.835257] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.835330] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.838962]  sda: sda1
[    0.839290] sd 1:0:0:0: [sda] Attached SCSI disk
[    0.839578] clk: Disabling unused clocks
[    0.852147] Freeing unused decrypted memory: 2028K
[    0.852577] Freeing unused kernel image (initmem) memory: 3456K
[    0.852578] Write protecting the kernel read-only data: 30720k
[    0.853216] Freeing unused kernel image (rodata/data gap) memory: 1360K
[    0.859562] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.859566] rodata_test: all tests were successful
[    0.859569] Run /init as init process
[    0.859570]   with arguments:
[    0.859571]     /init
[    0.859571]   with environment:
[    0.859572]     HOME=3D/
[    0.859572]     TERM=3Dlinux
[    0.859573]     split_lock_detect=3Doff
[    0.878552] systemd[1]: systemd 255.7-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    0.878557] systemd[1]: Detected architecture x86-64.
[    0.878558] systemd[1]: Running in initrd.
[    0.878652] systemd[1]: Initializing machine ID from random generator.
[    0.909854] systemd[1]: Queued start job for default target Initrd Defau=
lt Target.
[    0.912361] systemd[1]: Expecting device /dev/disk/by-uuid/9bf7c08f-ded6=
-4cf7-864f-9eb6b26c33ae...
[    0.912392] systemd[1]: Reached target Path Units.
[    0.912398] systemd[1]: Reached target Slice Units.
[    0.912405] systemd[1]: Reached target Swaps.
[    0.912411] systemd[1]: Reached target Timer Units.
[    0.912455] systemd[1]: Listening on Journal Socket (/dev/log).
[    0.912483] systemd[1]: Listening on Journal Socket.
[    0.912521] systemd[1]: Listening on udev Control Socket.
[    0.912545] systemd[1]: Listening on udev Kernel Socket.
[    0.912551] systemd[1]: Reached target Socket Units.
[    0.912565] systemd[1]: Create List of Static Device Nodes was skipped b=
ecause of an unmet condition check (ConditionFileNotEmpty=3D/lib/modules/6.=
8.9-arch1-2/modules.devname).
[    0.913047] systemd[1]: Starting Check battery level during early boot...
[    0.913898] systemd[1]: Starting Journal Service...
[    0.914402] systemd[1]: Starting Load Kernel Modules...
[    0.914425] systemd[1]: TPM2 PCR Barrier (initrd) was skipped because of=
 an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    0.914825] systemd[1]: Starting Create Static Device Nodes in /dev...
[    0.915217] systemd[1]: Starting Coldplug All udev Devices...
[    0.918863] systemd[1]: Finished Load Kernel Modules.
[    0.919057] systemd[1]: Finished Check battery level during early boot.
[    0.919597] systemd[1]: Started Displays emergency message in full scree=
n..
[    0.920385] systemd[1]: Finished Create Static Device Nodes in /dev.
[    0.920998] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[    0.923687] systemd-journald[155]: Collecting audit messages is disabled.
[    0.931647] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[    0.936499] systemd[1]: Started Journal Service.
[    0.985706] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.985714] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.986828] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x1=
20 quirks 0x0000100200009810
[    0.987110] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.987113] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.987117] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.987303] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.08
[    0.987306] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.987307] usb usb1: Product: xHCI Host Controller
[    0.987308] usb usb1: Manufacturer: Linux 6.8.9-arch1-2 xhci-hcd
[    0.987310] usb usb1: SerialNumber: 0000:00:14.0
[    0.987818] hub 1-0:1.0: USB hub found
[    0.987845] hub 1-0:1.0: 12 ports detected
[    0.991127] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.08
[    0.991132] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.991134] usb usb2: Product: xHCI Host Controller
[    0.991135] usb usb2: Manufacturer: Linux 6.8.9-arch1-2 xhci-hcd
[    0.991136] usb usb2: SerialNumber: 0000:00:14.0
[    0.991245] hub 2-0:1.0: USB hub found
[    0.991263] hub 2-0:1.0: 4 ports detected
[    0.991899] usb: port power management may be unreliable
[    0.992334] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    0.992407] nvme nvme0: pci function 0000:01:00.0
[    1.015971] nvme nvme0: missing or invalid SUBNQN field.
[    1.064010] nvme nvme0: allocated 128 MiB host memory buffer.
[    1.065226] nvme nvme0: 8/0/0 default/read/poll queues
[    1.067973]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9
[    1.114235] PM: Image not found (code -22)
[    1.243046] usb 1-4: new full-speed USB device number 2 using xhci_hcd
[    1.293091] EXT4-fs (nvme0n1p8): mounted filesystem 9bf7c08f-ded6-4cf7-8=
64f-9eb6b26c33ae r/w with ordered data mode. Quota mode: none.
[    1.306721] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.306772] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    1.307178] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.309025] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/=
adlp_dmc.bin (v2.20)
[    1.323457] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.=
bin version 70.20.0
[    1.323461] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin =
version 7.9.3
[    1.340029] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all wor=
kloads
[    1.340800] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[    1.340801] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[    1.341346] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[    1.342092] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected c=
ontent support initialized
[    1.389159] usb 1-4: New USB device found, idVendor=3D8087, idProduct=3D=
0a2a, bcdDevice=3D 0.01
[    1.389172] usb 1-4: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    1.513248] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    1.679168] usb 1-5: New USB device found, idVendor=3D0c45, idProduct=3D=
6711, bcdDevice=3D40.24
[    1.679184] usb 1-5: New USB device strings: Mfr=3D2, Product=3D1, Seria=
lNumber=3D0
[    1.679189] usb 1-5: Product: USB 2.0 Camera
[    1.679193] usb 1-5: Manufacturer: Sonix Technology Co., Ltd.
[    2.537886] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on mi=
nor 1
[    2.541140] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  =
post: no)
[    2.542192] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input4
[    2.542781] i915 display info: display version: 13
[    2.542791] i915 display info: cursor_needs_physical: no
[    2.542794] i915 display info: has_cdclk_crawl: yes
[    2.542797] i915 display info: has_cdclk_squash: no
[    2.542799] i915 display info: has_ddi: yes
[    2.542801] i915 display info: has_dp_mst: yes
[    2.542803] i915 display info: has_dsb: yes
[    2.542805] i915 display info: has_fpga_dbg: yes
[    2.542807] i915 display info: has_gmch: no
[    2.542809] i915 display info: has_hotplug: yes
[    2.542811] i915 display info: has_hti: no
[    2.542813] i915 display info: has_ipc: yes
[    2.542815] i915 display info: has_overlay: no
[    2.542817] i915 display info: has_psr: yes
[    2.542819] i915 display info: has_psr_hw_tracking: no
[    2.542821] i915 display info: overlay_needs_physical: no
[    2.542823] i915 display info: supports_tv: no
[    2.542825] i915 display info: has_hdcp: yes
[    2.542827] i915 display info: has_dmc: yes
[    2.542829] i915 display info: has_dsc: yes
[    2.549159] fbcon: i915drmfb (fb0) is primary device
[    2.549167] fbcon: Deferring console take-over
[    2.549173] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    2.766618] systemd-journald[155]: Received SIGTERM from PID 1 (systemd).
[    2.848294] systemd[1]: systemd 255.7-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    2.848298] systemd[1]: Detected architecture x86-64.
[    2.849074] systemd[1]: Hostname set to <FIRE>.
[    3.233388] systemd[1]: bpf-lsm: LSM BPF program attached
[    3.371268] systemd[1]: initrd-switch-root.service: Deactivated successf=
ully.
[    3.371324] systemd[1]: Stopped Switch Root.
[    3.371735] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.
[    3.371974] systemd[1]: Created slice Slice /system/dirmngr.
[    3.372102] systemd[1]: Created slice Slice /system/getty.
[    3.372218] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.372333] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.372449] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.372560] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.372673] systemd[1]: Created slice Slice /system/keyboxd.
[    3.372794] systemd[1]: Created slice Slice /system/modprobe.
[    3.372914] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.372994] systemd[1]: Created slice User and Session Slice.
[    3.373027] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    3.373047] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    3.373134] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    3.373141] systemd[1]: Expecting device /dev/disk/by-uuid/d3fa04da-cb55=
-4ff4-a93b-92256084412c...
[    3.373147] systemd[1]: Reached target Local Encrypted Volumes.
[    3.373158] systemd[1]: Stopped target Switch Root.
[    3.373164] systemd[1]: Stopped target Initrd File Systems.
[    3.373169] systemd[1]: Stopped target Initrd Root File System.
[    3.373174] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.373187] systemd[1]: Reached target Remote File Systems.
[    3.373193] systemd[1]: Reached target Slice Units.
[    3.373205] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.373232] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.374937] systemd[1]: Listening on Process Core Dump Socket.
[    3.374955] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because=
 of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.375063] systemd[1]: Listening on udev Control Socket.
[    3.375091] systemd[1]: Listening on udev Kernel Socket.
[    3.396738] systemd[1]: Mounting Huge Pages File System...
[    3.397847] systemd[1]: Mounting POSIX Message Queue File System...
[    3.398904] systemd[1]: Mounting Kernel Debug File System...
[    3.399718] systemd[1]: Mounting Kernel Trace File System...
[    3.400667] systemd[1]: Starting Create List of Static Device Nodes...
[    3.401541] systemd[1]: Starting Load Kernel Module configfs...
[    3.402567] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.403884] systemd[1]: Starting Load Kernel Module drm...
[    3.405154] systemd[1]: Starting Load Kernel Module fuse...
[    3.405696] systemd[1]: Starting Load Kernel Module loop...
[    3.406921] systemd[1]: Starting Journal Service...
[    3.407848] systemd[1]: Starting Load Kernel Modules...
[    3.407869] systemd[1]: TPM2 PCR Machine ID Measurement was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.408394] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.408433] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an=
 unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.408961] systemd[1]: Starting Coldplug All udev Devices...
[    3.409849] systemd[1]: Mounted Huge Pages File System.
[    3.409945] systemd[1]: Mounted POSIX Message Queue File System.
[    3.410018] systemd[1]: Mounted Kernel Debug File System.
[    3.410085] systemd[1]: Mounted Kernel Trace File System.
[    3.410239] systemd[1]: Finished Create List of Static Device Nodes.
[    3.410428] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.410523] systemd[1]: Finished Load Kernel Module configfs.
[    3.410704] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.410788] systemd[1]: Finished Load Kernel Module drm.
[    3.410956] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.411041] systemd[1]: Finished Load Kernel Module fuse.
[    3.411692] systemd[1]: Mounting FUSE Control File System...
[    3.411826] loop: module loaded
[    3.412206] systemd[1]: Mounting Kernel Configuration File System...
[    3.412741] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    3.412966] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.413072] systemd[1]: Finished Load Kernel Module loop.
[    3.416524] systemd[1]: Mounted FUSE Control File System.
[    3.417461] systemd[1]: Mounted Kernel Configuration File System.
[    3.418830] systemd-journald[281]: Collecting audit messages is disabled.
[    3.420246] device-mapper: uevent: version 1.0.3
[    3.420396] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@redhat.com
[    3.421313] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    3.421418] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.421523] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    3.422482] systemd[1]: Started Journal Service.
[    3.426214] i2c_dev: i2c /dev entries driver
[    3.439980] EXT4-fs (nvme0n1p8): re-mounted 9bf7c08f-ded6-4cf7-864f-9eb6=
b26c33ae r/w. Quota mode: none.
[    3.446724] systemd-journald[281]: Received client request to flush runt=
ime journal.
[    3.550443] systemd-journald[281]: /var/log/journal/bd024c881a1f4958a55e=
8145fab6de4c/system.journal: Journal file uses a different sequence number =
ID, rotating.
[    3.550459] systemd-journald[281]: Rotating system journal.
[    4.166128] Adding 4194300k swap on /swapfile.  Priority:-2 extents:192 =
across:59072512k SSDsc
[    4.220584] Consider using thermal netlink events interface
[    4.225598] input: Intel HID events as /devices/platform/INTC1070:00/inp=
ut/input5
[    4.225786] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.L=
PCB.H_EC.CHRG.PPSS.FCHG], AE_NOT_FOUND (20230628/psargs-330)
[    4.225796] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.CHRG.PPSS du=
e to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    4.226891] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    4.226894] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp
[    4.227693] intel-hid INTC1070:00: platform supports 5 button array
[    4.229692] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.230698] input: Intel HID 5 button array as /devices/platform/INTC107=
0:00/input/input6
[    4.233780] intel_pmc_core INT33A1:00:  initialized
[    4.249354] resource: resource sanity check: requesting [mem 0x00000000f=
edc0000-0x00000000fedcffff], which spans more than pnp 00:02 [mem 0xfedc000=
0-0xfedc7fff]
[    4.249360] caller igen6_probe+0x15e/0x890 [igen6_edac] mapping multiple=
 BARs
[    4.253677] EDAC MC0: Giving out device to module igen6_edac controller =
Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[    4.254167] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    4.254327] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.254364] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.258801] i2c i2c-10: 2/2 memory slots populated (from DMI)
[    4.259502] EDAC MC1: Giving out device to module igen6_edac controller =
Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[    4.259517] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[    4.259518] EDAC igen6 MC0: ADDR 0x7fffffffe0=20
[    4.259524] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
[    4.259525] EDAC igen6 MC1: ADDR 0x7fffffffe0=20
[    4.259789] i2c i2c-10: Successfully instantiated SPD at 0x50
[    4.259796] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.260088] EDAC igen6: v2.5.1
[    4.272855] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    4.273197] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.278843] mei_me 0000:00:16.0: hbm: dma setup response: failure =3D 3 =
REJECTED
[    4.319872] mc: Linux media interface: v0.10
[    4.321628] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: b=
ound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[    4.321967] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    4.322973] ee1004 10-0050: 512 byte EE1004-compliant SPD EEPROM, read-o=
nly
[    4.327036] Creating 1 MTD partitions on "0000:00:1f.5":
[    4.327044] 0x000000000000-0x000002000000 : "BIOS"
[    4.332281] EXT4-fs (nvme0n1p9): mounted filesystem d3fa04da-cb55-4ff4-a=
93b-92256084412c r/w with ordered data mode. Quota mode: none.
[    4.337376] Bluetooth: Core ver 2.22
[    4.337389] NET: Registered PF_BLUETOOTH protocol family
[    4.337390] Bluetooth: HCI device and connection manager initialized
[    4.337393] Bluetooth: HCI socket layer initialized
[    4.337395] Bluetooth: L2CAP socket layer initialized
[    4.337398] Bluetooth: SCO socket layer initialized
[    4.353718] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    4.353823] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.353905] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    4.365267] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/261)
[    4.366283] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/33030)
[    4.367267] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/1157)
[    4.368261] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/2309)
[    4.369268] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/405)
[    4.370266] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/661)
[    4.371248] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/4213)
[    4.372265] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/9474)
[    4.373249] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/897)
[    4.374265] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/49154)
[    4.375247] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/33105)
[    4.376248] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/9731)
[    4.377255] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/38160)
[    4.378250] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/1941)
[    4.379233] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/38145)
[    4.380252] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/49154)
[    4.381237] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/3593)
[    4.568024] intel_rapl_msr: PL4 support detected.
[    4.571307] input: XXXX0000:01 0911:5288 Mouse as /devices/pci0000:00/00=
00:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/inpu=
t/input7
[    4.571378] input: XXXX0000:01 0911:5288 Touchpad as /devices/pci0000:00=
/0000:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/i=
nput/input8
[    4.571421] hid-generic 0018:0911:5288.0001: input,hidraw0: I2C HID v1.0=
0 Mouse [XXXX0000:01 0911:5288] on i2c-XXXX0000:01
[    4.575739] Intel(R) Wireless WiFi driver for Linux
[    4.575759] r8169 0000:03:00.0: enabling device (0000 -> 0003)
[    4.577928] intel_rapl_common: Found RAPL domain package
[    4.577930] intel_rapl_common: Found RAPL domain core
[    4.577931] intel_rapl_common: Found RAPL domain uncore
[    4.577932] intel_rapl_common: Found RAPL domain psys
[    4.578817] r8169 0000:03:00.0 eth0: RTL8168evl/8111evl, 00:00:00:00:00:=
03, XID 2c9, IRQ 136
[    4.578822] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    4.580118] videodev: Linux video capture interface: v2.00
[    4.580536] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360=
 ms ovfl timer
[    4.580538] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.580539] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.580540] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    4.580540] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    4.581102] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    4.582565] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input9
[    4.583087] cryptd: max_cpu_qlen set to 1000
[    4.587041] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[    4.589224] iwlwifi 0000:02:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm i=
d 0x0
[    4.589282] iwlwifi 0000:02:00.0: PCI dev 095a/5410, rev=3D0x210, rfid=
=3D0xd55555d5
[    4.593772] proc_thermal_pci 0000:00:04.0: enabling device (0000 -> 0002)
[    4.593943] intel_rapl_common: Found RAPL domain package
[    4.594731] iwlwifi 0000:02:00.0: Found debug destination: EXTERNAL_DRAM
[    4.594732] iwlwifi 0000:02:00.0: Found debug configuration: 0
[    4.594826] iwlwifi 0000:02:00.0: loaded firmware version 29.4063824552.=
0 7265D-29.ucode op_mode iwlmvm
[    4.595713] AVX2 version of gcm_enc/dec engaged.
[    4.595748] AES CTR mode by8 optimization enabled
[    4.600149] pps_core: LinuxPPS API ver. 1 registered
[    4.600151] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    4.605464] PTP clock support registered
[    4.605696] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subc=
lass/prog-if info 0x040100
[    4.605780] usb 1-5: Found UVC 1.00 device USB 2.0 Camera (0c45:6711)
[    4.605790] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    4.605962] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[    4.633756] usbcore: registered new interface driver uvcvideo
[    4.639919] input: XXXX0000:01 0911:5288 Mouse as /devices/pci0000:00/00=
00:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/inpu=
t/input10
[    4.639959] input: XXXX0000:01 0911:5288 Touchpad as /devices/pci0000:00=
/0000:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/i=
nput/input11
[    4.639991] hid-multitouch 0018:0911:5288.0001: input,hidraw0: I2C HID v=
1.00 Mouse [XXXX0000:01 0911:5288] on i2c-XXXX0000:01
[    4.689998] mousedev: PS/2 mouse device common for all mice
[    4.690495] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless A=
C 7265, REV=3D0x210
[    4.690549] thermal thermal_zone4: failed to read out thermal zone (-61)
[    4.692199] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: =
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    4.692202] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    4.692204] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    4.692206] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    4.692207] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.692208] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x18
[    4.692209] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x19
[    4.692210] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12
[    4.706677] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    4.706701] usbcore: registered new interface driver btusb
[    4.707233] iwlwifi 0000:02:00.0: Allocated 0x00400000 bytes for firmwar=
e monitor.
[    4.713841] iwlwifi 0000:02:00.0: base HW address: 18:5e:0f:5e:3b:66, OT=
P minor version: 0x0
[    4.717226] intel_tcc_cooling: TCC Offset locked
[    4.722175] Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17=
 2014
[    4.722186] Bluetooth: hci0: Intel device is already patched. patch num:=
 39
[    4.727329] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3=
/sound/card0/input12
[    4.727360] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input13
[    4.727384] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input14
[    4.727407] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input15
[    4.727429] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input16
[    4.727451] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    4.739329] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.739332] Bluetooth: BNEP filters: protocol multicast
[    4.739335] Bluetooth: BNEP socket layer initialized
[    4.773439] Bluetooth: MGMT ver 1.22
[    4.773638] Bluetooth: ISO socket layer initialized
[    4.775408] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    4.779019] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[    4.780639] NET: Registered PF_ALG protocol family
[    4.887647] RTL8211E Gigabit Ethernet r8169-0-300:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
[    5.135632] r8169 0000:03:00.0 enp3s0: Link is Down
[    5.166640] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.248543] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.250902] iwlwifi 0000:02:00.0: FW already configured (0) - re-configu=
ring
[    5.260894] iwlwifi 0000:02:00.0: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[    5.312466] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.392490] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.394666] iwlwifi 0000:02:00.0: FW already configured (0) - re-configu=
ring
[    5.661045] fbcon: Taking over console
[    5.673796] Console: switching to colour frame buffer device 240x67
[    8.189111] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   11.402189] systemd-journald[281]: /var/log/journal/bd024c881a1f4958a55e=
8145fab6de4c/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.
[   16.270271] ntfs3: Max link count 4000
[   16.270283] ntfs3: Enabled Linux POSIX ACLs support
[   16.270286] ntfs3: Read-only LZX/Xpress compression included
[   16.345144] Bluetooth: RFCOMM TTY layer initialized
[   16.345151] Bluetooth: RFCOMM socket layer initialized
[   16.345153] Bluetooth: RFCOMM ver 1.11
[   16.544923] warning: `crow' uses wireless extensions which will stop wor=
king for Wi-Fi 7 hardware; use nl80211
[   18.946818] input: Baseus F02 Mouse  Keyboard as /devices/virtual/misc/u=
hid/0005:045E:0040.0002/input/input18
[   18.947038] input: Baseus F02 Mouse  Mouse as /devices/virtual/misc/uhid=
/0005:045E:0040.0002/input/input19
[   18.947286] hid-generic 0005:045E:0040.0002: input,hidraw1: BLUETOOTH HI=
D v3.00 Keyboard [Baseus F02 Mouse ] on 18:5e:0f:5e:3b:6a
[   34.911496] systemd-journald[281]: Time jumped backwards, rotating.

--hnvnxajk7nx6tppr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cat_debug.log"

online:              1
initial_apicid:      0
apicid:              0
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             0
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              0
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      1
apicid:              1
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             0
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              0
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      1c
apicid:              1c
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             14
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              24
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      1e
apicid:              1e
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             15
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              24
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      8
apicid:              8
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             4
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              8
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      9
apicid:              9
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             4
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              8
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      10
apicid:              10
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             8
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              16
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      12
apicid:              12
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             9
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              16
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      14
apicid:              14
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             10
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              16
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      16
apicid:              16
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             11
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              16
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      18
apicid:              18
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             12
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              24
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2
online:              1
initial_apicid:      1a
apicid:              1a
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             13
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              24
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         12
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2

--hnvnxajk7nx6tppr--

--jazhwfw32z5ykiyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZZy+QACgkQwEfU8yi1
JYWTYxAArQdLM3OuXYclogLT/D/1QaDX1IJTNYiuM25kraNhpEz9pjEzcitzblmr
+zj/Ev2RKQFkjkVSVO1EkkQhhrQ0k5e5OW90BEk7Ik0Nn1TTmcHPT7GaxcgCObgh
fSbB0wbqGqwdNbQg8PcFCQg+AG54uv+4qMU0PrIsLY2POdFwADRp0uiHHB8MVhtj
t7cXWQ5aWwSzrIEl4A6DJaFAeeTsOMawEbNxDhlBCoZunNcnoj/74PCu2qz/5N2w
IKWcXlI27ibYrZufDk3hHwcK2NEjtlFNQzAd2faXYDQwJnt4DT3A46pqf35gccCj
bVb0efIgWhF3EhGi7ykwH2Z8A6ZIJS91LHgjlyTGzqF5hA3wRqLUfGGjDuDiWBOl
QhcqzZhwVRQifcnlKZo4OSIsQnr+DTp8xoqWVfEOkZGd5PuUKg9ZSjsdwVjHqyoC
Lma58gcEshfboyzcUum20pWq8k35quS/Ca+o9EF/LlC6dm3AokNgfUiqRPTHvjiR
jGcnEZGhrWCEZHNBTKPy/svMbyxb+Bkqo1Q3WepWAXcsd3JWfvAHyCSKe8YMhhhf
zfyrBonYKKeP6beUc8m66R/F8iehIUA9u0PuGSEGyPBUcFN8uDEv0j/GXU2pxVBa
TiBCYh2dc7W4tn0HOzbnxkSZq3uvmFI2muyacupkoKznibWEZuU=
=kNsb
-----END PGP SIGNATURE-----

--jazhwfw32z5ykiyn--

