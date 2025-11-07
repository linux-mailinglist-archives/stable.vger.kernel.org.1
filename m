Return-Path: <stable+bounces-192749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F4C417B5
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 20:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE2F034F4D6
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 19:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5766832AABD;
	Fri,  7 Nov 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aijEOupB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D853009DA;
	Fri,  7 Nov 2025 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545344; cv=none; b=DcxTeULJAa/lybIHQ+Vw6nB7vXB6davqaPmh7cCkQs8KT0V4E0aqDJ+U8oiTR5Vnsi4Rk77TG2+Od9LtMHbDrQKpj31bMywtc4W0lYhDh+6vvDBN3xRpKs1Djev7HLRiVHwYjYVPyk8nfq70sAiLgBYKWI7zQgRXwW5B7hzyd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545344; c=relaxed/simple;
	bh=M90qio2q2Tipd7ZAbCDj4FfpWg8WnNV9xphFskIDfMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLEP2uDZgO/UPyXEb10AUiXd0+nbpfTnuY5PROkoifrNkKeCpVSUbKWUpXlu9NqJBcvzDGldWKorN7PjI72TP+HK/xTg3P8tmg1Cbl0MsaDkkUGUNZOJEiqUV4g5gLxQ14BZco8Rl9VnXEXgsC8tQcSHz05YSLXZA1lz5Y7RvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aijEOupB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762545343; x=1794081343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=M90qio2q2Tipd7ZAbCDj4FfpWg8WnNV9xphFskIDfMs=;
  b=aijEOupB67CuPJldSrctNpUmfrMCn4mrDfk6ZddxdkmiOACYeM5E6m62
   DhxhQokmQS+jQYt1xITqC89OQBhK+jPxr2WgJQl2qp07C5lmBG2wsE22q
   tX2aa7kJNMXvprWFBBKODDLHuHwgxnCnU+m3/9w7RD0ajJcZsRO+sxBxO
   e5Exu5C8y1+8n6owTlanLxFhPHE1WqYPAz+5klpeESyl8+ifOSHB/sOwC
   DAzys0HeIjL4GYYQATM8bv+Id5BeEInz8UkwvV+aWRCZMA9h8gxUT0aY/
   tptsMErZLCTaIOAM0EMa/nog3Ro+zenBomaM7epVyeLgJ44M8zCYdIkOl
   g==;
X-CSE-ConnectionGUID: DkF8t37qSW6CC5uampQY6A==
X-CSE-MsgGUID: ReJcGrNeRIa1sPGjn6Vwtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="75391013"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="p7s'346?scan'346,208,346";a="75391013"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 11:55:42 -0800
X-CSE-ConnectionGUID: lCRAJXZfQL2Pb1l3lbn3Aw==
X-CSE-MsgGUID: tJd97CxMQrilUqTvy2THQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="p7s'346?scan'346,208,346";a="187370495"
Received: from tjmaciei-mobl5.jf.intel.com (HELO tjmaciei-mobl5.localnet) ([10.24.81.83])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 11:55:42 -0800
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
Date: Fri, 07 Nov 2025 11:55:35 -0800
Message-ID: <2790505.9o76ZdvQCi@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <aQ5E2ArhkmziwWA8@zx2c4.com>
References:
 <aPT9vUT7Hcrkh6_l@zx2c4.com> <1903914.sHLxoZxqIA@tjmaciei-mobl5>
 <aQ5E2ArhkmziwWA8@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3363618.vuYhMxLoTh";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart3363618.vuYhMxLoTh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 7 November 2025 11:13:28 Pacific Standard Time Jason A. Donenfeld 
wrote:
> > But consider people who haven't upgraded Linux (yes, we get people asking
> > to keep everything intact in their system, but upgrade Qt only, then
> > complain when our dependency minimums change). How much of an impact
> > would they have?
> I suppose you could benchmark it and see if it matters. The syscall is
> obviously slower than the megafast vDSO code, so it will probably also
> be a bit slower than the MT code. But I suspect for most use cases maybe
> it doesn't matter that much? It's worth a try and seeing if anybody
> complains.

I'm not asking about the performance of generating new random numbers in this 
process.

I am asking about the system-wide impact that draining the entropy source 
would have. Is that a bad thing?

I suspect the answer is "no" because it's the same as /dev/urandom anyway.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCG - Platform & Sys. Eng.

--nextPart3363618.vuYhMxLoTh
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTA3MTk1NTM1WjAvBgkqhkiG9w0BCQQxIgQg
b9nXlXOCcX04IAvxkM7yfoQgPy2ejMqxNsPs2770cYwwNQYJKoZIhvcNAQkPMSgwJjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBADp9Xi8TQROh
a29BB+uzKcMRly0bB0SnmTbe1v7Yd2w128+UZKTLXs02Ev3EGWwUXbonRljC+BaToy5/rzfmwuOb
xyb2CtGI+F3bJF0R1kocwKRWUgk585SeLH0LURXMQn7iZrA/aceK1qN06HQs2UL0Cs9I7QYVjhTc
DmoHHN07CAopPJQQG1DePwKonrdnt3BINJLaW0eL2K1FMgul/MsqKnIEMNq5hxF8yQ+8yXFGQVXZ
3XSxIfAEFTu9AJQaInXq2PEheVSbPtbU2g7MfpaN+5Q1ViUjL9W1uVbc376OIbmIqjTkFZr1wZk8
j4YjyHs4GST6yGw6KP1MuVTmWh0=


--nextPart3363618.vuYhMxLoTh--




