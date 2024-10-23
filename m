Return-Path: <stable+bounces-87812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541DC9AC07A
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 09:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C191C237D5
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9887615533B;
	Wed, 23 Oct 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSzKOuQ+"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E10154BFF;
	Wed, 23 Oct 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669197; cv=none; b=Jo4px7DBSsZzbjkPB7gtc2XncCuEB0zf89PfULHa1rsPlNX1stGGnMFoRdnvX43J0hM683fY+PqH1ilmItTK9CcQpnQV4JPz0nTSenQ5BilXawWEuHfe+xCk6Pao3FvrgRrpPPC5Y8bs2U3YhPHXhhUXWgydkzY7L0Tq6/m6wco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669197; c=relaxed/simple;
	bh=NiMmh72K4ybr1VX887bIwahdibQwfr9RTXRgsXdljkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHL8B++fLzs4ztowfgMuxkH5qwoT/v10X/DWFbIXizBZtbsvKhx5nCcH7d4zhOvHBRzgdJu8br8Si2xCCuvn3ZAlBfOpbU8RQ++bZuHJrYI+WxgF+u2BHKr2I9IlyfcnfMuQZSYZwK0btNDDIpAv1YM9FawQX2m2l0kNPELIa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WSzKOuQ+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NiMmh72K4ybr1VX887bIwahdibQwfr9RTXRgsXdljkQ=; b=WSzKOuQ+CFjwod0w/acFJibNSt
	I/eifxK2H/LTtxb6s45jdgsFQ7VGM7BuRMooTx0slm4XlGlr1gcJVXNglEFfMucsIX9zyUu3J/nAh
	lU+w+7NIXvZl58yV8OOfJnwEk280GFYTaDMSgb2B4jhXlNGKWsdkTAmGULasDsXz26LCzESGJI6nr
	y1E+t1sLgV2GC3TcOzTrVmABtO41OYtOZD3WZAI+5Q5SkbaGEyxHlUpYj45qdoXaQ3aXI74PsSLvY
	oV6dLJVjCG3gl19YDPpG42qInbRf3mYPF0Z31bY2g4f2higabWVt8/xvQulqQr6UUJoj00gcCH66u
	qTyXfmLw==;
Received: from [2001:8b0:10b:5:51f6:cefc:4e76:679f] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Vy0-00000002aDB-40fT;
	Wed, 23 Oct 2024 07:39:41 +0000
Message-ID: <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
From: David Woodhouse <dwmw2@infradead.org>
To: Steve Wahl <steve.wahl@hpe.com>, Tom Lendacky <thomas.lendacky@amd.com>,
  "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc: Dave Young <dyoung@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>,  Pavin Joseph <me@pavinjoseph.com>, Simon Horman
 <horms@verge.net.au>, kexec@lists.infradead.org, Eric Hagberg
 <ehagberg@gmail.com>, dave.hansen@linux.intel.com,
 regressions@lists.linux.dev,  stable@vger.kernel.org
Date: Wed, 23 Oct 2024 08:39:40 +0100
In-Reply-To: <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
References: 
	<CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
	 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
	 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
	 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
	 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
	 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
	 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
	 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
	 <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
	 <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
	 <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-X8ZWnF9+yFBtvmRhmKWl"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-X8ZWnF9+yFBtvmRhmKWl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-10-22 at 17:06 -0500, Steve Wahl wrote:
> On Tue, Oct 22, 2024 at 07:51:38PM +0100, David Woodhouse wrote:
> > I spent all of Monday setting up a full GDT, IDT and exception handler
> > for the relocate_kernel() environment=C2=B9, and I think these reports =
may
> > have been the same as what I've been debugging.
>=20
> David,
>=20
> My original problem involved UV platform hardware catching a
> speculative access into the reserved areas, that caused a BIOS HALT.
> Reducing the use of gbpages in the page table kept the speculation
> from hitting those areas.=C2=A0 I would believe this sort of thing might =
be
> uniqe to the UV platform.
>=20
> The regression reports I got from Pavin and others were due to my
> original patch trimming down the page tables to the point where they
> didn't include some memory that was actually referenced, not processor
> speculation, because the regions were not explicitly included in the
> creation of the kexec page map.=C2=A0 This was fixed by explicitly
> including those regions when creating the map.

Hm, I didn't see that part of the discussion. I saw that such was a
theory, but haven't seen specific confirmation and fixes. And your
original patch was reverted and still not reapplied, AFAICT.

I did note that the victims all seemed to be using AMD CPUs, so it
seemed likely that at least *some* of them were suffering the same
problem that I've found.

Do you have references please?=20

If anyone is still seeing such problems either with or without your
patch, they can run with my exception handler and get an actual dump
instead of a triple-fault.

(I'm also pushing CPU vendors to give us information from the triple-
fault through the machine check architecture. It's awful having to do
this blind. For VMs, I also had plans to register a crashdump kernel
entry point with the hypervisor, so that on a triple fault the
*hypervisor* could jump state of all the vCPUs to the configured
location, then restart one CPU in the crash kernel for it to do its own
dump).=20

> Can you dump the page tables to see if the address you're referencing
> is included in those tables (or maybe you already did)?=C2=A0 Can you giv=
e
> symbols and code around the RIP when you hit the #PF?=C2=A0 It looks like
> this is in the region metioned as the "Control page", so it's probably
> trampoline code that has been copied from somewhere else.=C2=A0 I'm using
> my copy of perhaps different kernel source than you have, given your
> exception handler modification.
>=20
> Wait, I can't make sense of the dump. See more below.
>=20
> What platform are you running on?=C2=A0 And under what conditions (is thi=
s
> bare metal)? Is it really speculation that's causing your #PF?=C2=A0 If s=
o,
> you could cause it deterministically by, say, doing a quick checksum
> on that area you're not supposed to touch (0xc142000000 -
> 0xC1420fffff) and see if it faults every time.=C2=A0 (As I said, I was
> thinking faults from speculation might be unique to the UV platform.)

Yes, it's bare metal. AMD Genoa. No, it's not speculation. It's because
we have a single 2MiB page which covers *both* the RMP table (1MiB
reserved by BIOS in e820 as I showed), and a page that was allocated
for the kimage. If I understand correctly, the hardware raises that
fault (with bit 31 in the error code) when refusing to populate that
TLB entry for writing.

According to the AMD manual we're allowed to *read* but not write.

> > We end up taking a #PF, usually on one of the 'rep mov's, one time on
> > the 'pushq %r8' right before using it to 'ret' to identity_mapped. In
> > each case it happens on the first *write* to a page.
> >=20
> > Now I can print %cr2 when it happens (instead of just going straight to
> > triple-fault), I spot an interesting fact about the address. It's
> > always *adjacent* to a region reserved by BIOS in the e820 data, and
> > within the same 2MiB page.
>=20
> I'm not at all certain, but this feels like a red herring.=C2=A0 Be cauti=
ous.

It wouldn't be our first in this journey, but I'm actually fairly
confident this time. :)

> > [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000bfbe000000-0x0000=
00c1420fffff] reserved
> > [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000c142100000-0x0000=
00fc7fffffff] usable
> >=20
> >=20
> > 2024-10-22 17:09:14.291000 kern NOTICE [=C2=A0=C2=A0 58.996257] kexec: =
Control page at c149431000
> > 2024-10-22 17:09:14.291000 Y
> > 2024-10-22 17:09:14.291000 rip:000000c1494312f8
> > 2024-10-22 17:09:14.291000 rsp:000000c149431f90
> > 2024-10-22 17:09:14.291000 Exc:000000000000000e
> > 2024-10-22 17:09:14.291000 Err:0000000080000003
> > 2024-10-22 17:09:14.291000 rax:000000c142130000
> > 2024-10-22 17:09:14.291000 rbx:000000010d4b8020
> > 2024-10-22 17:09:14.291000 rcx:0000000000000200
> > 2024-10-22 17:09:14.291000 rdx:000000000009c000
> > 2024-10-22 17:09:14.291000 rsi:000000000009c000
> > 2024-10-22 17:09:14.291000 rdi:000000c142130000
> > 2024-10-22 17:09:14.291000 r8 :000000c149431000
> > 2024-10-22 17:09:14.291000 r9 :000000c149430000
> > 2024-10-22 17:09:14.291000 r10:000000010d4bc000
> > 2024-10-22 17:09:14.291000 r11:0000000000000000
> > 2024-10-22 17:09:14.291000 r12:0000000000000000
> > 2024-10-22 17:09:14.291000 r13:0000000000770ef0
> > 2024-10-22 17:09:14.291000 r14:ffff8c82c0000000
> > 2024-10-22 17:09:14.291000 r15:0000000000000000
> > 2024-10-22 17:09:14.291000 cr2:000000c142130000
> > >=20
> >=20
> > And bit 31 in the error code is set, which means it's an RMP
> > violation.=C2=A0
>=20
> RMP is AMD SEV related, right?=C2=A0 I'm not familiar with SEV operation,
> but I have an itchy feeling it's involved in this problem.
>=20
> I am having a hard time with the RIP listed above.=C2=A0 Maybe your
> exception handler has affected it?=C2=A0 My disassembly seems to show thi=
s
> address should be in a sea of 0xCC / int3 bytes past the end of swap
> pages.

You'd have to have access to my kernel binary to have a hope of knowing
that, surely? I don't think I checked that particular one, but it's
normally one of the 'rep mov's in relocate_kernel_64.S.

> > Looks like we set up a 2MiB page covering the whole range from
> > 0xc142000000 to 0xc142200000, but we aren't allowed to touch the first
> > half of that.
>=20
> Is it possible that, instead, some SEV tag is hanging around (TLB not
> completely cleared?) and a page that was otherwise free is causing the
> problem.=C2=A0 Are you using SEV/SME in your system, and if you stop usin=
g
> it does it go away?=C2=A0 (Although I have a feeling the answer is no and
> I'm barking up the wrong tree.)
>=20
> The target of the pages above is c1421300000.=C2=A0 Have you checked to
> make sure that's a valid address in the page map?

Yeah, we dumped the page tables and it's present.

> > For me it happens either with or without Steve's last patch, *but*
> > clearing direct_gbpages did seem to make it go away (or at least
> > reduced the incident rate far below the 1-crash-in-1000-kexecs which I
> > was seeing before).
>=20
> I assume you're referring to the "nogbpages" kernel option?=C2=A0=C2=A0

Nah, I just commented out the lines in init_pgtable() which set
info.direct_gbpages=3Dtrue.


> My patch
> and the nogbpages option should have the exact same pages mapped in
> the page table.=C2=A0 The difference being my patch would still use gbpag=
es
> in places where a whole gbpage region is included in the map,
> nogbpages would use 2M pages to fill out the region.=C2=A0 This *would*
> allocate more pages to the page table, which might be shifting things
> around on you.

Right. In fact the first trigger for this, in our case, was an
innocuous change to the NMI watchdog period =E2=80=94 which sent us on a *l=
ong*
wild goose chase based on the assumption that it was a stray perf NMI
causing the triple-faults, when in fact that was just shifting things
around on us too, and causing pages in that dangerous 1MiB to be chosen
for the kimage.

> > I think Steve's original patch was just moving things around a little
> > and because it allocate more pages for page tables, just happened to
> > leave pages in the offending range to be allocated for writing to, for
> > the unlucky victims.
> >=20
> > I think the patch was actually along the right lines though, although
> > it needs to go all the way down to 4KiB PTEs in some cases. And it
> > could probably map anything that the e820 calls 'usable RAM', rather
> > than really restricting itself to precisely the ranges which it's
> > requested to map.=20
> >=20
> >=20
> >=20
> > =C2=B9 I'll post that exception handler at some point once I've tidied =
it
> > up.
>=20
> I hope this might be of some help.=C2=A0 Good luck, I'll pitch in any way=
 I
> can.

Thanks.


--=-X8ZWnF9+yFBtvmRhmKWl
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMDIzMDczOTQwWjAvBgkqhkiG9w0BCQQxIgQgW5mm4GTO
QzS/swt0xXClU5mN/tVUs1CgRHJ7tXx3LAIwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCj8z8hWT2fdZ2+EH0gISakUwxYGCusW5qH
sORF+Eb6j1pQLL8JQr0rQaMFHNqx5B2frYuaUv+PJaomA2qC7SSDK3mBTYU9ooMNRVf4nwcgtVeS
R2mUK9W/YaATXJ900MFTjmtuV30CGve93uYEbMeHkygSE5721hZNhjyXaAnm8KMWAQ6jf+JhTJJY
w2DIU/6D4CsOO7fGkaUzJ21MZU64PP8kt2nTVE9mrRDND18EmSGzyJaW92dccpW0HLjUOetgrmKm
c50Flm7mOEnWgKnEmv/6HXJ988iZMcIp85QhJ0qnxHANidVECa6XC2rs8mp9ZRfIyj/EmYwyIsqG
ast6eSdCZKCG5eOQIoOrE67CxUXS81rPVUnEWoOQCLqZZm3dg5dJR3KHGed11qzF+BBkz2HDC7gb
DK8IjsCskeI28FJC0oP+BFn4Yya8cbKKKJekgp8vpEBgBWUtNiegkUxTMLeoy5ccClhioCnwCXYZ
hSwpawv3sKv42zpLtOtSKy7w59InanwfUdHdHb08SOuz2jAAnVXff7VPE1s9bLzK0bU1brlUEPe2
r3TSAG55jbV2PIkI+bHX54sszdBiz2rZcz3avaxU0NWjEiV/FqOYxUEvnJl91qQ0eJTLkFcUyHlm
BKfa7EyjTS8GmD6546Y0GJBwGkZWUmZgyp1Q+kP7dAAAAAAAAA==


--=-X8ZWnF9+yFBtvmRhmKWl--

