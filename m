Return-Path: <stable+bounces-176394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0CCB36F04
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439848E61D9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7B36CC98;
	Tue, 26 Aug 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ddRhb/k2"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB5136CC8F;
	Tue, 26 Aug 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223345; cv=none; b=iBZCpx2nKC9/o0IStJUSAuEseGbfMK+jdNspeSRiwZyUhTo0BYxHfAbJjBS50y4OqOkdsqs3S3Qg2zU0qW7JQj9p81nTW3+vSudOFiCcGYF8Fin9hLNeXf5ZJfoREy0Ge5YKckgNvSHF8SAlpw5UmOm2jjbUekxxZLrnJikf2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223345; c=relaxed/simple;
	bh=0LmQhv9Q0ton4ODa84rIaQP9cdqSCUOJ7KlcLOy+afk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJ5pZSTqGM04B7lYxzyAsxdaUgtaLp4bx1WT+tqh8ULURR5BBmn5W8Qx3cTi6kfE0aSFoPWpBC9l3ZKb33k3nffcO7dELjKTvB5QWyek31nhom6cPaYoTOMOQzSkpdeffwceKaiqmw+iy3Xc3Kc6PBoQwGwC4H/jwTtaQ18f2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ddRhb/k2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HKfMf0J2VOT7G6Ud9haPGvWQeKBns+KncbxAImnpDZU=; b=ddRhb/k258x/605MjMoRCCGddu
	qcTJeEMI/RJK5N8bKk0NA6RFDPFOFLCFJFxPcAogjK2HoN+a/RWMrMiwROW6GjnHGWRX708QYAubd
	CIl4967BGrBMqUkybbX9vK3bOYhKqG9NPg8cOe/ior7t2ZlL1ZpRqUmpmUsKZSQMdn0W9aw36uGYB
	0LetN72zrVLKvbOgyfMkZh1mM8TzeBecj8QJUbTxFg2Iqm7gLQrhpR206V1pDr5OBf8HShKB3fxOy
	JuMj/tHtMUU6skb5ddRtIjsVpjlBC9WBftAGI9z6M0VfBY/8LpKmhLiQLSxZ3c5ftooQIiGXd2WMp
	SOL7mhsw==;
Received: from [54.240.197.239] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqvuq-00000004tJD-4B7w;
	Tue, 26 Aug 2025 15:48:57 +0000
Message-ID: <37c9ae89eb6cf879e5b984d53d590a69bcf1666a.camel@infradead.org>
Subject: Re: [PATCH] iommu/intel: Fix __domain_mapping()'s usage of
 switch_to_super_page()
From: David Woodhouse <dwmw2@infradead.org>
To: Eugene Koira <eugkoira@amazon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, longpeng2@huawei.com, graf@amazon.de,
 nsaenz@amazon.com,  nh-open-source@amazon.com, stable@vger.kernel.org
Date: Tue, 26 Aug 2025 16:48:39 +0100
In-Reply-To: <20250826143816.38686-1-eugkoira@amazon.com>
References: <20250826143816.38686-1-eugkoira@amazon.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-yDkzNHrAmbkB4YH4AJZP"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-yDkzNHrAmbkB4YH4AJZP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-08-26 at 14:38 +0000, Eugene Koira wrote:
> switch_to_super_page() assumes the memory range it's working on is aligne=
d
> to the target large page level. Unfortunately, __domain_mapping() doesn't
> take this into account when using it, and will pass unaligned ranges
> ultimately freeing a PTE range larger than expected.
>=20
> Take for example a mapping with the following iov_pfn range [0x3fe400,
> 0x4c0600], which should be backed by the following mappings:

The range is [0x3fe400, 0x4c0600) ?=20

> =C2=A0=C2=A0 iov_pfn [0x3fe400, 0x3fffff] covered by 2MiB pages
> =C2=A0=C2=A0 iov_pfn [0x400000, 0x4bffff] covered by 1GiB pages
> =C2=A0=C2=A0 iov_pfn [0x4c0000, 0x4c05ff] covered by 2MiB pages
>=20
> Under this circumstance, __domain_mapping() will pass [0x400000, 0x4c05ff=
]
> to switch_to_super_page() at a 1 GiB granularity, which will in turn
> free PTEs all the way to iov_pfn 0x4fffff.
>=20
> Mitigate this by rounding down the iov_pfn range passed to
> switch_to_super_page() in __domain_mapping()
> to the target large page level.
>=20
> Additionally add range alignment checks to switch_to_super_page.
>=20
> Fixes: 9906b9352a35 ("iommu/vt-d: Avoid duplicate removing in __domain_ma=
pping()")
> Signed-off-by: Eugene Koira <eugkoira@amazon.com>
> Cc: stable@vger.kernel.org
> ---
> =C2=A0drivers/iommu/intel/iommu.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9c3ab9d9f69a..dff2d895b8ab 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1575,6 +1575,10 @@ static void switch_to_super_page(struct dmar_domai=
n *domain,
> =C2=A0	unsigned long lvl_pages =3D lvl_to_nr_pages(level);
> =C2=A0	struct dma_pte *pte =3D NULL;
> =C2=A0
> +	if (WARN_ON(!IS_ALIGNED(start_pfn, lvl_pages) ||
> +		=C2=A0=C2=A0=C2=A0 !IS_ALIGNED(end_pfn + 1, lvl_pages)))
> +		return;
> +
> =C2=A0	while (start_pfn <=3D end_pfn) {
> =C2=A0		if (!pte)
> =C2=A0			pte =3D pfn_to_dma_pte(domain, start_pfn, &level,
> @@ -1650,7 +1654,8 @@ __domain_mapping(struct dmar_domain *domain, unsign=
ed long iov_pfn,
> =C2=A0				unsigned long pages_to_remove;
> =C2=A0
> =C2=A0				pteval |=3D DMA_PTE_LARGE_PAGE;
> -				pages_to_remove =3D min_t(unsigned long, nr_pages,
> +				pages_to_remove =3D min_t(unsigned long,
> +							round_down(nr_pages, lvl_pages),
> =C2=A0							nr_pte_to_next_page(pte) * lvl_pages);
> =C2=A0				end_pfn =3D iov_pfn + pages_to_remove - 1;
> =C2=A0				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);

I'm mildly entertained by the fact that the *only* comment in this
block of code is a lie. Would you care to address that while you're
here? Maybe the comment could look something like...

			/* If the new mapping is eligible for a large page, then
			 * remove all smaller pages that the existing pte at this
			 * level references.
			 * XX: do we even need to bother calling switch_to_super_page()
			 * if this PTE wasn't *present* before?
			 */

I bet it would benefit from one or two other one-line comments to make
it clearer what's going on, too...

But in general, I think this looks sane even though this code makes my
brain hurt. Could do with a test case, in an ideal world. Maybe we can
work on that as part of the generic pagetable support which is coming?

--=-yDkzNHrAmbkB4YH4AJZP
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgyNjE1NDgz
OVowLwYJKoZIhvcNAQkEMSIEIBY8Q4x+x4JZculH7e+zyZC4il1jGOLt6WKaRI7kThSPMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAyLxniW2Q/h4/
tdWDw1aAL3NhOYr9AJQnfOteND86sPDVVgfe0ue7t5SAXhGvhp8skpOLb02O62p+BHWQAo0LqQyE
mDfrt/4wdIKnvKW2oqvcVrA3mBGONYVXXy8Uye+s3QtfMF4WwB8PStMh1pskAWi8OZtB0FSjJOFR
rvID5Vde0wE6vyJ1cBhhmSOBTjQvsN9N2wAvD1TpvDAgABTaH1oFuXZK9TPaJYlOKP2wY9TVEqyM
aV2GhKf+YK42V+FgRUTxlUzqmSE6i52kYOrxSLff+oYBXOmyjXwlIryM/Cy2rWyHEEswnNEiV/jS
3wcMX8dbGRymSz/7hpMpdQ8d0OoedhUjwckT2eOHNOvm9VrPqqZyju0s6WAo18j0REYdhNMS9rI2
S0Y35YGWf9hXVh1i38cHbLHi7QUmaNjTHUOqmmeSEnHE9JTNoVwx4Bnji1gvhKMSKuzyfZdMv/QX
RibqiQxBSfs2nfDzb2ozSW3bX31gUHo+N0SR0qvybgv5LfJOwM/Rv/2cXlGFwxiwNBvWe1u+cMMy
f+8TAqyJh52lzgbQLAf43DrSZkWSEg7fnlvtkQUcFXIv13fPztBWhtnumU/aqv4zO5ugVPK1KiI1
dDGDgcf5D1+qSEfRbb0YxjUyWKHU7JQTPJfV7/sRZxR/3nASMNzJy/GjBdtYflMAAAAAAAA=


--=-yDkzNHrAmbkB4YH4AJZP--

