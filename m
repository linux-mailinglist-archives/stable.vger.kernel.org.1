Return-Path: <stable+bounces-192754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAFC41EB3
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 00:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261D63A5447
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E664305940;
	Fri,  7 Nov 2025 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEHlKlLj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3771212562;
	Fri,  7 Nov 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557126; cv=none; b=J5AWIxOIKYwRZuGh7RJ2XRa+l26QvyjXDryr80rda3WC/o+owIlZ9XaNOAJS0Ymrlxaw58xRSQ9olIf9XHG0vCynWUlOvvgAaMm3lkGuO/RVqFlqKuMQoegxrMJ9lOjVLxyYHzKTQ860C1aLCKl1tMUFALyo/Brt46iOC4VUxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557126; c=relaxed/simple;
	bh=2i8f9EjSdzRu4LV6A6uVDjCNUKpyJPEneCa+nZl+mUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIH23Hcu5GYBoPnWfMYrsGjMviGLfMZ+hUgxEl8D+C3hjMFUy+VTudeJwrgrYdNewUIclkLeUTUP0eZlukijAoJzfC39YWhQ62LifHA7XwcgCETfqT8g45GsoNpojAfUnqRIkFmLivflgtc79Ot9OWffOvKUnSURdbGztjSOPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEHlKlLj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762557125; x=1794093125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2i8f9EjSdzRu4LV6A6uVDjCNUKpyJPEneCa+nZl+mUI=;
  b=cEHlKlLjr82S/9y9a/9RynsuG6fsDKqDEe3LMABKutHd6+0/aIG4UzJd
   bU1TZiqPfoJJ0mVLPMnzI3+hiH3IuJ2SGTH5WLYu3cRSI055gNekjfuXq
   pQg+gyjZtKaiYn197OBJASKO1q3vI1i+SQhUqtOXSyDyA+Dd28Z64eo8h
   g1LO8pdIsLVRR/36SpcAnUpTprBazIUNNMV91SFXfN6b6PpVSDa4+fjCg
   miwm3itq479ueWVJg8imodvSFo/DClIheXrQxmmwMJAN+7D9YkXdVq2fm
   UEtGOeKsNTBZcKgt0+Fw/0LegWxmni8sx9irtCtnL0DIsmRh78Yc1JEY/
   w==;
X-CSE-ConnectionGUID: qaDfylIVRpOcFz1Jnj1odg==
X-CSE-MsgGUID: NxyztvyFQlqdiVYfTq3S5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90180561"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="p7s'346?scan'346,208,346";a="90180561"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:12:04 -0800
X-CSE-ConnectionGUID: oXsBNvd5R2WovvxbGxjkkw==
X-CSE-MsgGUID: xAPzdHU8REuemVXQck2xCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="p7s'346?scan'346,208,346";a="188319735"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.125.111.148])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:12:04 -0800
From: Thiago Macieira <thiago.macieira@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Borislav Petkov <bp@alien8.de>, Christopher Snowhill <chris@kode54.net>,
 Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
 mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
 me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
 darwi@linutronix.de, stable@vger.kernel.org
Subject:
 Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an error.
Date: Fri, 07 Nov 2025 15:11:51 -0800
Message-ID: <27717271.1r3eYUQgxm@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <aQ57ofElS-N0gEco@zx2c4.com>
References:
 <aPT9vUT7Hcrkh6_l@zx2c4.com> <2790505.9o76ZdvQCi@tjmaciei-mobl5>
 <aQ57ofElS-N0gEco@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2917114.vFx2qVVIhK";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart2917114.vFx2qVVIhK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 7 November 2025 15:07:13 Pacific Standard Time Jason A. Donenfeld 
wrote:
> Oh. "Entropy source draining" is not a real thing. There used to be
> bizarre behavior related to /dev/random (not urandom), but this has been
> gone for ages. And even the non-getrandom Linux fallback code uses
> /dev/urandom before /dev/random. So not even on old kernels is this an
> issue. You can keep generating random numbers forever without worrying
> about running out of juice or irritating other processes.

Thank you. This probably seals the deal. I'll prepare a patch removing the 
direct use of the hardware instructions in the coming days.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCG - Platform & Sys. Eng.

--nextPart2917114.vFx2qVVIhK
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIUGgYJKoZIhvcNAQcCoIIUCzCCFAcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghFkMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYD
VQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRow
GAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZp
Y2VzMB4XDTE5MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJU
UlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9y
aXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00yt
UINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfji
b9DsFiCQCT7i6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+
fmyc/xadGL1RjjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcS
Ok2uTIq3XJq0tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97E
xwzf4TKuzJM7UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkT
rNN9N6frXTpsNVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4
Z+LoE53MW4LTTLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlE
RPSZ51eHnlAfV1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4P
Y9bpYrrWX1Uu6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAW
gBSgEQojPpbxB+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYD
VR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8
MDowOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMDQGCCsGAQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29t
MA0GCSqGSIb3DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+c
li3vA0p+rvSNb3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czS
AaF9ffgZGclCKxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ
7Tvx5Dq2+UUTJnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7o
BmF0Ixa1DVBzJ0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIGEDCCA/ig
AwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzAR
BgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNF
UlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UEBhMCR0IxGzAZ
BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2Vj
dGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24g
YW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQK
Qf/e+Ua56NY75tqSvysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6n
BEibivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHKRhBhVFHd
JDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFbme/SoY9WAa39uJORHtbC
0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManRy6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2
ZebtQdHnKav7Azf+bAhudg7PkFOTuRMCAwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rP
VIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMC
AYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYD
VR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNv
bS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgw
PwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVz
dENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0B
AQwFAAOCAgEAQUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFTvSB5PelcLGnC
LwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwpTf64ZNnXUF8p+5JJpGtkUG/X
fdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQS
qXh3TbjugGnG+d9yZX3lB8bwc/Tn2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6l
DFqkXVsp+3KyLTZGXq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhA
mtMGquITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmdWC+XszE1
9GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4hYbDOO6qHcfzy/uY0fO5
ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svqw1o5A2HcNzLOpklhNwZ+4uWYLcAi14AC
HuVvJsmzNicwggXHMIIEr6ADAgECAhB5Fup2DPWjD9zM9vPLEI/OMA0GCSqGSIb3DQEBCwUAMIGW
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTI1MDIwMzAwMDAwMFoXDTI2
MDIwMzIzNTk1OVowgcExCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRowGAYDVQQK
ExFJbnRlbCBDb3Jwb3JhdGlvbjEZMBcGA1UEYRMQTlRSVVMrQ0EtMTYzNjAzMjEoMCYGCSqGSIb3
DQEJARYZdGhpYWdvLm1hY2llaXJhQGludGVsLmNvbTERMA8GA1UEBBMITWFjaWVpcmExDzANBgNV
BCoTBlRoaWFnbzEYMBYGA1UEAxMPVGhpYWdvIE1hY2llaXJhMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAvGzZ7P6juSIbkg/71EACJs6qOOGPf0jjkhRFlX1ICHNOkecK5ZtwVspesN0z
NLYqJspnhiWHxx1GU3LlPBSrV9ob52EzIvpEyhYo0PzsURb4jrl7pqpRbjaxyD+nizPfpebf1VFi
/EP+4+uUJWGxYM92L50IysMAHXmKdpDTergytHAv2l1RxjA/UKbmNEUZmZVhSDQIbHR2qmhvF1WK
tF7H4GkYveLjnoshWstfpeoo///m1V3AZJZKYqQkagAUOV92mAYyaIjWSobvGhmMs9vhEDxDrSJC
30tS+ZdgHJmDXoDrn5EstK0/6nSreN/Ho2Fjj+srnoPHmTfQUv+bHQIDAQABo4IB4jCCAd4wHwYD
VR0jBBgwFoAUCcDy/AvalNtf/ivfqJlCz8ngrQAwHQYDVR0OBBYEFE8TK2yVtInDUMuJErSQr3/9
MTdEMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggr
BgEFBQcDAjBQBgNVHSAESTBHMDoGDCsGAQQBsjEBAgEKBDAqMCgGCCsGAQUFBwIBFhxodHRwczov
L3NlY3RpZ28uY29tL1NNSU1FQ1BTMAkGB2eBDAEFAwIwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDov
L2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVF
bWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3Rp
Z28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0
MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAkBgNVHREEHTAbgRl0aGlhZ28u
bWFjaWVpcmFAaW50ZWwuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQATbpusBsTbhmdZarvRAIrd+CXY
WrWfXSlxLpObWEVYjKw3+vHYDc9RXWGQRv1Q2issn1yUQDAYaUv8d+4KHv3I6KZtLpHmhaXKZhM2
pEeXc5J//YGBYUWNvJyl0XqD/2vnZYm/FInYPKzE6PbUx3E+tCyHwyjWX7R6K/5WrmLqS0b0PkjO
MbgifvmYKWLtP40pmG65c0bYobeIVH9BFuqW2YVDdr88gWQnQoVxpEhU2UzjuF0NHqf41ZUTiHeX
uCFWyMwELPoj7mOyS3clDS0ETnrnBn9c8/pVpvFc6ipcmGCTjBd2Z8zsVr9YEVIBcxa0DK0M3gnZ
ZW55dVJiKHrvMYICejCCAnYCAQEwgaswgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVy
IE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+
MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEHkW6nYM9aMP3Mz288sQj84wDQYJYIZIAWUDBAIBBQCggaAwGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTA3MjMxMTUxWjAvBgkqhkiG9w0BCQQxIgQg
DDdrNC5bqAB1L5bdXRhlsGNqwGEdmLbX82UsDuQw0DIwNQYJKoZIhvcNAQkPMSgwJjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAF5NvUgRlpZE
GcEgx6TnzlyQgkxknvN20XHH9PlhrbvLIs7imLkBOKchzMjB5l2Nd2vV/6kfg4SGKPPjDGRhxWFt
awgItHQBV6E5jnMw8306/AzaqTZYN3F0R71ausM1RfPz++UJGTyre7d7RQhV8ya2qhCROiTHCxAY
68LFPRBCPZ5hGEgTiPmkJe5eWtLg960l61TfdV/AFx1k7PCzXu4Z9RAMN9G1BbJBLTcvw7n7Ldz0
TFw2dX2bbSpN/fcIRjZE7xzCjNfFS/4BkBaK5Xpr6+pBrN/mhP8lQY+BdOHJ9mkWKzYQD0B6B24j
axdKcs63zNWxtOd+MswRQRDOYVo=


--nextPart2917114.vFx2qVVIhK--




