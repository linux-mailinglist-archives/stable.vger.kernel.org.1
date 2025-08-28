Return-Path: <stable+bounces-176569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDBAB3952A
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D0D7A515F
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4312877E2;
	Thu, 28 Aug 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GyiyehtX"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366030CDA9;
	Thu, 28 Aug 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366195; cv=none; b=S1OPXajuSwJtbRPEe9hoMrHjSOSccZpKD2g+KbrVfwq3yjfRgT0QV9cvJYLvBNX/i3eUGteJwZ/+QeuCMy0bwbQjgx4iATbQzm8UbQ6is9FD8P8JFOGGb56zCDiH2T5GCmHbJiRzh3vj0hlnTQAIFCbp3AxedFUbaDsLuCo/cIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366195; c=relaxed/simple;
	bh=cvWm9M27h+7aDZ33E9rYg655VODr+A3HSiuqjXT2qv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DWU5tcmkBQ/nK4AnIQ6m/5mAKN9HCW9bV2kBpFk6ES7VzkSlt5OD4SlfOKcFusEhWuzJllOMCDIPIAt+w/ynq1VWmo65C+Ea82afCHSaB/pqTmKg7PKwV4QjEfRNd3dq4ryhWQdArHcUKrIiPcY5I942pUWLToBeKUwyGH/TkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GyiyehtX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9KcXOAU3ZsWVGIC8Rt2diVecJ+Gq0OtDN/9ng5j+6/A=; b=GyiyehtXHVsyLGDTKxPLKtNEY0
	cPu/uKqmDOSNpYl4EbGJF2l0IYlragFOo1k7TmqxigneMLo+dihp1BfSogTC8bBjtqJeBDR4AHOI1
	lh9T9dFHKOHU03HwcuuIAtd47L/BLF22ICLCITlp6q1kdgikR0Y1jstf7tWEH/3jFnY1p+Xfy2AsE
	LhKqc41CG5vTvQAktTStVDKr+8QD5sWp4RbAABGY8FCT8yC/EuFiWlPqnjfEPr7xc7c7VCjLQSoa4
	yI1qXS0AUl7hCAh4jrOoahTzDLy5tPRnXq33wGXvbf1e8aqp/aEGMlriUSnGd9W/EJ73BV4xISWFe
	UhYE/f3w==;
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=iad51-en-hct-f1c2-r2.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urX4n-00000004fwA-0hEa;
	Thu, 28 Aug 2025 07:29:42 +0000
Message-ID: <e119e295535deafd93e283db143e9f17b1148169.camel@infradead.org>
Subject: Re: [PATCH] iommu/intel: Fix __domain_mapping()'s usage of
 switch_to_super_page()
From: David Woodhouse <dwmw2@infradead.org>
To: Baolu Lu <baolu.lu@linux.intel.com>, Eugene Koira <eugkoira@amazon.com>,
  iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 longpeng2@huawei.com,  graf@amazon.de, nsaenz@amazon.com,
 nh-open-source@amazon.com,  stable@vger.kernel.org
Date: Thu, 28 Aug 2025 08:29:40 +0100
In-Reply-To: <0b9492bc-b033-46c3-acf2-6fca3d19148b@linux.intel.com>
References: <20250826143816.38686-1-eugkoira@amazon.com>
	 <37c9ae89eb6cf879e5b984d53d590a69bcf1666a.camel@infradead.org>
	 <0b9492bc-b033-46c3-acf2-6fca3d19148b@linux.intel.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-/7iGcOUW4Sqx1P03whoF"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-/7iGcOUW4Sqx1P03whoF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-28 at 14:33 +0800, Baolu Lu wrote:
> On 8/26/25 23:48, David Woodhouse wrote:
> > On Tue, 2025-08-26 at 14:38 +0000, Eugene Koira wrote:
> > > switch_to_super_page() assumes the memory range it's working on is al=
igned
> > > to the target large page level. Unfortunately, __domain_mapping() doe=
sn't
> > > take this into account when using it, and will pass unaligned ranges
> > > ultimately freeing a PTE range larger than expected.
> > >=20
> > > Take for example a mapping with the following iov_pfn range [0x3fe400=
,
> > > 0x4c0600], which should be backed by the following mappings:
> >=20
> > The range is [0x3fe400, 0x4c0600) ?
> >=20
> > > =C2=A0=C2=A0=C2=A0 iov_pfn [0x3fe400, 0x3fffff] covered by 2MiB pages
> > > =C2=A0=C2=A0=C2=A0 iov_pfn [0x400000, 0x4bffff] covered by 1GiB pages
> > > =C2=A0=C2=A0=C2=A0 iov_pfn [0x4c0000, 0x4c05ff] covered by 2MiB pages
> > >=20
> > > Under this circumstance, __domain_mapping() will pass [0x400000, 0x4c=
05ff]
> > > to switch_to_super_page() at a 1 GiB granularity, which will in turn
> > > free PTEs all the way to iov_pfn 0x4fffff.
> > >=20
> > > Mitigate this by rounding down the iov_pfn range passed to
> > > switch_to_super_page() in __domain_mapping()
> > > to the target large page level.
> > >=20
> > > Additionally add range alignment checks to switch_to_super_page.
> > >=20
> > > Fixes: 9906b9352a35 ("iommu/vt-d: Avoid duplicate removing in __domai=
n_mapping()")
> > > Signed-off-by: Eugene Koira <eugkoira@amazon.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > > =C2=A0=C2=A0drivers/iommu/intel/iommu.c | 7 ++++++-
> > > =C2=A0=C2=A01 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.=
c
> > > index 9c3ab9d9f69a..dff2d895b8ab 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -1575,6 +1575,10 @@ static void switch_to_super_page(struct dmar_d=
omain *domain,
> > > =C2=A0=C2=A0	unsigned long lvl_pages =3D lvl_to_nr_pages(level);
> > > =C2=A0=C2=A0	struct dma_pte *pte =3D NULL;
> > > =C2=A0=20
> > > +	if (WARN_ON(!IS_ALIGNED(start_pfn, lvl_pages) ||
> > > +		=C2=A0=C2=A0=C2=A0 !IS_ALIGNED(end_pfn + 1, lvl_pages)))
> > > +		return;
> > > +
> > > =C2=A0=C2=A0	while (start_pfn <=3D end_pfn) {
> > > =C2=A0=C2=A0		if (!pte)
> > > =C2=A0=C2=A0			pte =3D pfn_to_dma_pte(domain, start_pfn, &level,
> > > @@ -1650,7 +1654,8 @@ __domain_mapping(struct dmar_domain *domain, un=
signed long iov_pfn,
> > > =C2=A0=C2=A0				unsigned long pages_to_remove;
> > > =C2=A0=20
> > > =C2=A0=C2=A0				pteval |=3D DMA_PTE_LARGE_PAGE;
> > > -				pages_to_remove =3D min_t(unsigned long, nr_pages,
> > > +				pages_to_remove =3D min_t(unsigned long,
> > > +							round_down(nr_pages, lvl_pages),
> > > =C2=A0=C2=A0							nr_pte_to_next_page(pte) * lvl_pages);
> > > =C2=A0=C2=A0				end_pfn =3D iov_pfn + pages_to_remove - 1;
> > > =C2=A0=C2=A0				switch_to_super_page(domain, iov_pfn, end_pfn, largep=
age_lvl);
> >=20
> > I'm mildly entertained by the fact that the *only* comment in this
> > block of code is a lie. Would you care to address that while you're
> > here? Maybe the comment could look something like...
> >=20
> > 			/* If the new mapping is eligible for a large page, then
> > 			 * remove all smaller pages that the existing pte at this
> > 			 * level references.
> > 			 * XX: do we even need to bother calling switch_to_super_page()
> > 			 * if this PTE wasn't *present* before?
> > 			 */
> >=20
> > I bet it would benefit from one or two other one-line comments to make
> > it clearer what's going on, too...
> >=20
> > But in general, I think this looks sane even though this code makes my
> > brain hurt. Could do with a test case, in an ideal world. Maybe we can
> > work on that as part of the generic pagetable support which is coming?
>=20
> Agreed. The generic pagetable work will replace this code, so this will
> be removed. Therefore, we need a fix patch that can be backported before
> the generic pagetable for vt-d lands.

Yep. And since Jason has in fact already posted the patches which
*delete* all this code, I don't think I even care about fixing the
comments. Eugene's patch is fine as-is.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

--=-/7iGcOUW4Sqx1P03whoF
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgyODA3Mjk0
MFowLwYJKoZIhvcNAQkEMSIEIKsGi+ou5UQwobdbSws+XBS3XMMOJdLqQgJhjS5blLUwMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAJ4TCly/ztGWG
W2m7AHrUGSX0UPrhpfDOUSXcUFxg088+0Qjtjf0VBYrj4Kwc+ZsX5LY21rBWQ/eiAKP8NrDXTzoT
vnzkYGPyxNhZ6fEI8h1l3wHzmaH1rpmRefKxdrZBZP9qx6A1OGjp49ctShjr2HtjwPeZljJXSE88
FNT2m6PSfKSlHfcKa/4bu62Y0TxIIApjer3aIvcd4BdVfQF5Vu+tS6SfmhyLho8s5JpN7evDKZfm
W3Lku/6WQDMjLILlbqKwpPao7p+cQvgFYmd4hzcx1m6yt95hrfAhRN5rSjBlwIQ7CqKytZio8ybf
c4+F2IU0g0Z4tD1+JxvSRnVJy/jZCDNxENu6AqYkoEx5xr80mavn7JEqC6FQ3XSK3tfEZXDgufjk
2FPCPvAt0Ftt4Lietq4EMrDhT0kcpwUib/uj3KnOPl0xPYNKSAidXxvYZ2F+ErY4gFfNTe59r8KC
i81cRQXg3oDEPzoIQpdWyctMxX+HQcFYl61x0w5DIAh7Yk2Qw/8bn6SqLVz6Y+De4kgESZJStDRj
xgZ5cmhBBy8RgR7PDEy6iSmvJUlPg+Fi8NMficyX1LxO8dLZe6AkR4f4cqNSti/4QP3GFyaCNRMW
a/Zx3ofQohTEvLgaHnx+Z1ShoOhLdbEc1LNN7Djc2V5eZEGtpjKHTxG+JF/knqsAAAAAAAA=


--=-/7iGcOUW4Sqx1P03whoF--

