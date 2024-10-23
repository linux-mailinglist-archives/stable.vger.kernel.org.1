Return-Path: <stable+bounces-87832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE99ACBA9
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 15:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A25B23BD6
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC61B4F15;
	Wed, 23 Oct 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AP6jrL/Y"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028761AB6CB;
	Wed, 23 Oct 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691493; cv=none; b=SXNeIa0teZ8saCSBP9CYo/IxcM5HhoaNkflftrnlxEVRSxMXR24iSeJkBdAv9y+gaoqvfFt0P9U4YW7KVDJE0p7LXtpi5gqK2IFQQra8MVyDzil0b25lKFSKrhYI0CxjUSbSgl4uRt9JR8vktw5duzIOrQACD24/y7mQJAp/WtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691493; c=relaxed/simple;
	bh=ZNJn3panyvg/EoDDrxfQnbRFi1DPPclEwf++b4l43OM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PafTdt7dbuBsWAwJP1bet4i/ZlnRJ01Zh2PPTdggBP6kwSFsVcnLDvWNoQs7QAhJlP9fV61ki/kzYsb5fZr1Fl6q/XuJ1FsGAFFLRTdD5GpiogXRdUN5tDNGr97mY0NZMET42YSFGnc7X5kCIVSTdNeqBmfJmPntDFATDKBh2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AP6jrL/Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n9tneMJ/Y/IYaJTnCNJsqNTUCTaZPZV+NJonxReh+Dk=; b=AP6jrL/YJgISvNuASs5/ckmqMl
	+iN0ZLBh/OKo3dLfMfF9YeNc6fF8OM6BFZy26G2YrnILzdhQHQY9I5c5I9zPlFvEcsRKtFywq1UdO
	VNtMU/d/tMBl67lF7xuEEzLnOKw68zWKEmQ8fsH6CxP9LWtGqHF9wPX0ACJXzRbMq+DhlZCUOD30f
	BXyCtsPxXIN9Y9Z4/JzPk7/5mwpsjCvqWBuxKwNxGVIo0jpQHVfpJsB/i4UrQFDZLekPu4KdWCW3t
	CsUDFQf9NX5s3XVIA2SRpC3Gph/h4jy6WBDoWfWVd6+WtAborYD+2VMmEMXBulW2p4fQTkGX/m9P9
	I647fBdA==;
Received: from [2001:8b0:10b:5:51f6:cefc:4e76:679f] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3blI-00000002xo3-3aRR;
	Wed, 23 Oct 2024 13:50:59 +0000
Message-ID: <707cd3ee6ca042d67fb506ddc8a01ad801dc262a.camel@infradead.org>
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
From: David Woodhouse <dwmw2@infradead.org>
To: "Kalra, Ashish" <ashish.kalra@amd.com>, Steve Wahl <steve.wahl@hpe.com>,
  Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>,  Pavin Joseph <me@pavinjoseph.com>, Simon Horman
 <horms@verge.net.au>, kexec@lists.infradead.org, Eric Hagberg
 <ehagberg@gmail.com>, dave.hansen@linux.intel.com,
 regressions@lists.linux.dev,  stable@vger.kernel.org
Date: Wed, 23 Oct 2024 14:50:56 +0100
In-Reply-To: <229dd4f4-b556-41ef-bea9-9fafe07180c5@amd.com>
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
	 <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
	 <1f6feded-066d-4207-9645-f2bbed5ebfee@amd.com>
	 <e4cc1e0cfca0d954ca22d850ac771c4bf7406902.camel@infradead.org>
	 <229dd4f4-b556-41ef-bea9-9fafe07180c5@amd.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-2Shy5YoJEBRiLeBdUnC1"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-2Shy5YoJEBRiLeBdUnC1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-10-23 at 08:29 -0500, Kalra, Ashish wrote:
>=20
> On 10/23/2024 6:39 AM, David Woodhouse wrote:
> > On Wed, 2024-10-23 at 06:07 -0500, Kalra, Ashish wrote:
> > >=20
> > > As mentioned above, about the same 2MB page containing the end portio=
n of the RMP table and a page allocated for kexec and=20
> > > looking at the e820 memory map dump here:=20
> > >=20
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000bfbe00000=
0-0x000000c1420fffff] reserved
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000c14210000=
0-0x000000fc7fffffff] usable
> > >=20
> > > As seen here in the e820 memory map, the end range of the RMP table i=
s not
> > > aligned to 2MB and not reserved but it is usable as RAM.
> > >=20
> > > Subsequently, kexec-ed kernel could try to allocate from within that =
chunk
> > > which then causes a fatal RMP fault.
> >=20
> > Well, allocating within that chunk would be just fine. It *is* usable
> > as RAM, as the e820 table says. It works fine most of the time.
> >=20
> > You've missed a step out of the story. The problem is that for kexec we
> > map it with an "overreaching" 2MiB PTE which also covers the reserved
> > regions, and *that* is what causes the RMP violation fault.
> >=20
>=20
> Actually, the RMP entry covering the end range of the RMP table will be a=
 2MB/large entry=20
> which means that the whole 2MB including the usable 1MB memory range here=
 will also be marked
> as reserved in the RMP table and hence any host writes into this memory r=
ange will trigger
> the RMP violation.

Hm, that does not match our testing. We tried writing to the
"offending" area from the main kernel (which I assume was using 4KiB
pages for it, but didn't verify), and that was fine.=20

It also doesn't match what Tom says in the email you linked to:

"There's no requirement from a hardware/RMP usage perspective that=20
requires a 2MB alignment, so BIOS is not doing anything wrong.  The=20
problem occurs because kexec is initially using 2MB mappings that=20
overlap the start and/or end of the RMP which then results in an RMP=20
fault when memory within one of those 2MB mappings, that is not part of
the RMP, is referenced."

Tom's words precisely match my understanding of the situation (with the
exception that he keeps saying 2MB when he means 2MiB).

I believe we *can* use that extra 1MiB which is marked as 'usable RAM'
as usable RAM if we want to, as *long* as we don't use a 2MiB (or
larger) PTE for it which would overlap the RMP table.

And the only case where the kernel uses an "overreaching" 2MiB mapping
is the kexec identmap code, so we should just fix that.

> > We could take two possible viewpoints here. I was taking the viewpoint
> > that this is a kernel bug, that it *shouldn't* be setting up 2MiB pages
> > which include a reserved region, and should break those down to 4KiB
> > pages.
> >=20
> > The alternative view would be to consider it a BIOS bug, and to say
> > that the BIOS really *ought* to have reserved the whole 2MiB region to
> > avoid the 'sharing'.=C2=A0 Since the hardware apparently already breaks=
 down
> > 1GiB pages to 2MiB TLB entries in order to avoid triggering the problem
> > on 1GiB mappings.
> >=20
> > > This issue has been fixed with the following patch:=20
> > > https://lore.kernel.org/lkml/171438476623.10875.16783275868264913579.=
tip-bot2@tip-bot2/
> >=20
> > Thanks for pointing that patch out! Should it have been Cc:stable?
> >=20
>=20
> This thing can happen after SNP host support got merged in 6.11 and SNP s=
upport is enabled, therefore
> the patch does not mark it Cc:stable.
>=20
> I am trying to understand the scenario here: you have SNP enabled in the =
BIOS and you also
> have SNP support added in the host kernel, which means that the following=
 logs are seen:
> ..
> SEV-SNP: RMP table physical range [0x000000xxxxxxxxxx - 0x000000yyyyyyyyy=
y]
> ..

Ah yes. SEV-SNP isn't actually being *used* on these Genoa platforms at
the moment, but I do think it's enabled in the kernel.

If this problem only happens when the kernel actually *enables* SEV-
SNP, then it seems this fix was missed in our backporting of SEV-SNP
support to, ahem, a slightly older kernel.

But I still don't like it :)

> > It seems to be taking the latter of the above two viewpoints, that this
> > is a BIOS bug and that the BIOS *should* have reserved the whole 2MiB.
> >=20
> > In that case are fixed BIOSes available already?=20
>=20
> We have been of the view that it is easier to get it fixed in kernel, by =
fixing/aligning the e820 range
> mapping the start and end of RMP table to 2MB boundaries, rather than tru=
sting a BIOS to do it
> correctly.=20
>=20
> Here is a link to a discussion on the same:
> https://lore.kernel.org/all/2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com/

As noted above, that message clearly states that the BIOS isn't doing
anything wrong, and the problem is the kernel using large page mappings
that overlap reserved ranges.

In that case, shouldn't we fix the kernel *not* to do that?

I suppose we can be OK with "let's just avoid using that memory to
workaround the kexec/identmap bug", but in that case let's not claim
that we're working around a BIOS bug?


--=-2Shy5YoJEBRiLeBdUnC1
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMDIzMTM1MDU2WjAvBgkqhkiG9w0BCQQxIgQgvIKKaRsF
bRQ+lgBmvPsdI1F/xuCwK5snyNxDzRapcscwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAVzGCZqmQkar8bdt35wChjCRB/BzYemBwJ
S5WVYvG5akL2QKTFai9TUFPpJbfs8Ee7w+1cZs0cI3HBYa186sN64G2JkqXIoeZfISkVK+UA7HEa
+2979JXE4Osp6UY8lGzLv7N8pWIxjmzsD8pAit0YeTm3TgJLb+xmdzaD7SWISnxMmU7PeAt8Xc0N
jcnYW2QlZSBVpz9eSKLczHt04h9Mptb8MR8H0JilLu1YcHLtXITd+cs0gayVCEYUbE8iycLYMfhH
IF59hGDV7EiZoTHqA79OEkw6YRpLqsxNKlqBgPBaAlGQrlYDBSp+xM0jCIWb9X9uzqBWC2j2fCe7
L2tA1TTjrWey+Jw6G0JoW2k+JpPKYrhTFh4pjgN/E72PjHpsqBRUIs85AH0vnQ2bbDk8W4+a6a74
DsIGlP1C9/R2UecRc3Fl30iyykqeYcrc6APTxKkIKVatIYknsXaArI7x0gUhoBQisv0WPzWRL9d9
rdWrPf16ZhrRMtQb1igP01cvZ+LzpxINyNNlUJzV+h6ah3piYwpLeaK17HGc9bI05mED30kbb5qC
q1WH27PlfsdDoZL37eEVBrIWcwsbuRoowFaQufmAKAd8m2Qlkybn6A8Y8aJdSrKGo1ZkPZKN+q+q
0lYI8PBrYhwP8Zgb3/jA5x5gwq2SyVwnlp/yvALtYgAAAAAAAA==


--=-2Shy5YoJEBRiLeBdUnC1--

