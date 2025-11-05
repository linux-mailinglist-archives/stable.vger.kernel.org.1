Return-Path: <stable+bounces-192526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD6C36C02
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 17:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D68F34F3DA
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86310337103;
	Wed,  5 Nov 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fc6B7lBd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FD33372C;
	Wed,  5 Nov 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360870; cv=none; b=HyaTHkVl1m1HCl/woZkV7a78tkQ3gi5q+7xuKU+zIfwJBh3jduCV+F1kcZQKVDbqExAoT5m9r7ETuAGgoTz3/XLsuP88g7N/pq4Om4j4WBfcBxNTbwFiFs7v+EyXt6IziVnSPf1wEWVTdC7OPr7CqjbqJc5wHfhRCvYF3/BGRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360870; c=relaxed/simple;
	bh=rKlzpVJgeI+bwEZWIDnxrGagt0vtajR32ZBDox2M8fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4jo0deeerWDqzpltS/l5G+574/ButoqyY6fxw9nS4XQorjOhN4avlo7bc39r4M6fs+wkBNz7B7vUlXVQaDwz8jvdsid25OqCYl/E/BrGP44ZRAx3YwcpcGvbt62UxiOly8xHw/v5EayagQ9TN7F3kqghiJgb7sHO/75zDiWn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fc6B7lBd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762360868; x=1793896868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rKlzpVJgeI+bwEZWIDnxrGagt0vtajR32ZBDox2M8fA=;
  b=fc6B7lBdwNVcuglOr5jdwx2PlJeNb8LJ9Gxjtddazf8RfkmR9FWZv8bm
   pBWPfcQeogMvi1GveZFTYdvCnUjALuhmXD/jSaj/XFXR0DwxkZzZbmbWC
   SS5t2XFzV4pl7lMUKQbdCnxygob5+7WXA88cAxrHrDwTsoTcZ/hYcOLwj
   XEIwrfhgH4Sq3O7wgJBjKHpf0Gg0rEJT/gwSAg+MTkRIQ8ZNCvL/PdoNZ
   1YjA0nHtxruJaXGjaJe+bGckbvQO7Bs3rK5z76POw+xo6h8Cpdk7TJvyG
   Y5UGygERYcKyhzNq6rudxMIB2npULG2YlMsSR4KmozFX7Sc8keY7p4BtP
   g==;
X-CSE-ConnectionGUID: exy6GvIXT2yDH/eKBnbNIw==
X-CSE-MsgGUID: cPYd7JreRXaGjdqhC5ESJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68319848"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="p7s'346?scan'346,208,346";a="68319848"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:41:06 -0800
X-CSE-ConnectionGUID: ZCrRc2diRRSr1yTpJjGtvQ==
X-CSE-MsgGUID: hgCJPSSCSxCg33Y+DWrCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="p7s'346?scan'346,208,346";a="186754739"
Received: from tjmaciei-mobl5.jf.intel.com (HELO tjmaciei-mobl5.localnet) ([10.24.81.83])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:41:07 -0800
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
Date: Wed, 05 Nov 2025 08:41:01 -0800
Message-ID: <1903914.sHLxoZxqIA@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <aQqvTGblMoKkRK1j@zx2c4.com>
References:
 <aPT9vUT7Hcrkh6_l@zx2c4.com> <4632322.0HT0TaD9VG@tjmaciei-mobl5>
 <aQqvTGblMoKkRK1j@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4315813.0KrE1Onz32";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart4315813.0KrE1Onz32
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 4 November 2025 17:58:36 Pacific Standard Time Jason A. Donenfeld 
wrote:
> Hi Thiago,
> 
> On Tue, Nov 04, 2025 at 03:50:37PM -0800, Thiago Macieira wrote:
> > Strictly speaking, if you don't have getentropy(), the fallback will be
> > compiled in, in case someone runs the application is a messed up
> > environment with /dev improperly populated. In practice, that never
> > happens and getentropy() appeared in glibc 2.25, which is now older than
> > the oldest distro we still support.
> 
> Great, so I suppose you can entirely remove /dev/[u]random support then.

It's already compiled out if your glibc has 2.25. Likewise, it gets compiled 
out for the BSDs (including macOS). That has been the case since the 
inception.

The /dev/[u]random code needs to remain for QNX and other OSes.
https://www.qnx.com/developers/docs/8.0/search.html?searchQuery=getentropy

> > Indeed. Linux is *impressively* fast in transitioning to kernel mode and
> > back. Your numbers above are showing getrandom() taking about 214 ns,
> > which is about on par what I'd expect for a system call that does some
> > non-trivial work. Other OSes may be an order of magnitude slower, placing
> > them on the other side of RDRAND (616 ns).
> > 
> > Then I have to ask myself if I care. I've been before in the situation
> > where I just say, "Linux can do it (state of the art), so complain to
> > your OS vendor that yours can't". Especially as it also simplifies my
> > codebase.
> 
> Well, if you want performance consistency, use arc4random() on the BSDs,
> and you'll avoid syscalls. Same for RtlGenRandom on Windows. These will
> all have similar performance as vDSO getrandom() on Linux, because they
> live in userspace. Or use the getentropy() syscall on the BSDs and trust
> that it's still probably faster than RDRAND, and certainly faster than
> RDSEED.

Thanks for the info.

> > QRandomGenerator *can* be used as a deterministic generator, but that's
> > neither global() nor system(). Even though global() uses a DPRNG, it's
> > always seeded from system(), so the user can never control the initial
> > seed and thus should never rely on a particular random sequence.
> > 
> > The question remaining is whether we should use the system call for
> > global() or if we should retain the DPRNG. This is not about performance
> > any more, but about the system-wide impact that could happen if someone
> > decided to fill in a couple of GB of of random data. From your data, that
> > would only take a couple of seconds to achieve.
> 
> Oh yea, good question. Well, with every major OS now having a mechanism
> to skip syscalls for random numbers, I guess you could indeed just alias
> global() to system() and call it a day. Then users really cannot shoot
> themselves in the foot. That would be simpler too. Seems like the best
> option.

Indeed.

But consider people who haven't upgraded Linux (yes, we get people asking to 
keep everything intact in their system, but upgrade Qt only, then complain 
when our dependency minimums change). How much of an impact would they have?

> > >       1) New microcode
> > >       
> > >       2) Fix all source code to either use the 64bit variant of RDSEED
> > >       
> > >          or check the result for 0 and treat it like RDSEED with CF=0
> > >          (fail) or make it check the CPUID bit....
> > 
> > Or 3) recompile the code with the runtime detection enabled.
> > 
> > It's a pity that Qt always uses the 64-bit variant, so it would have
> > worked
> > just fine.
> 
> 4) Fix Qt to use getrandom().

That's recompiling Qt anyway. I can't change existing deployments and I can't 
affect much of past, stable releases.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCG - Platform & Sys. Eng.

--nextPart4315813.0KrE1Onz32
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTA1MTY0MTAxWjAvBgkqhkiG9w0BCQQxIgQg
S9EAhranTO8+00NeZ/CJ8R42IljArRDJglKVBu6tbbEwNQYJKoZIhvcNAQkPMSgwJjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAHNuOS1JLwlh
/AzeoFfMf5m2XrdCTElL9E88V85bAgVmhSbKqS0NV8tfgWU7o8spyVBNGNKCSkvW35EuPjS3WHA8
oLBOG9NIE12H1Es8zmm1RL+LKA5D1wy94J57xf9umsGVA4/jyXIbCKyvW5X1TKXlJnDt3lT5hYTl
/M17OhJCqjeyv5tvNobUhU45AtLH4qIPanowyfFtTLTioeKO0jpDpclbWH2IoWzjZmQ1aup68o0n
vfcknt6KfH+H1pxYtt3w2/vRSJLLvelDc9TpurAx0AogI0TAUTFTHli46TtiI8Q6b2k5bOcDUFdi
YpYVHwEV0zZJZBF/Z7Hc1/JVdG4=


--nextPart4315813.0KrE1Onz32--




