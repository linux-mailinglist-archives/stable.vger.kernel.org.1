Return-Path: <stable+bounces-192438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43018C32868
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 19:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C573460B4D
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 18:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76B33E345;
	Tue,  4 Nov 2025 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEpVbmQT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4B33DEE3;
	Tue,  4 Nov 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279737; cv=none; b=KWGTwnJPNVspfwMdfVef0hu3imbw1e43wd0z7n+XBFf+Xk/OlgGoKJ6ezHYzTipp1cnubpejZRtf0ideKzjHLSc4BWEJ088nTqt8cwVE6/3ID7aKPB5arrs9jUyweXBiX6Qk1VmSxAeALXXy2c+/ScB8sLruWfSTibuyzjmD3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279737; c=relaxed/simple;
	bh=aTa9GE+/22bLrhS470IyutAtfT1shHIprrRqIkjbpf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRM3afAxLajTGF77fdEfHn6INBOnTzN1hJ88peqBxs2hGMhp76t9T/cc1AB0eBN4lre0q6Kn0fEuWGqnWKKcmNsQMhyRnvcf43XXXCisDckdGGL7OaqwuV/6vxt6dYcDNlGos67CrbS+BNILh1hmr11v7+ENdxtgK8D2cUvdOe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEpVbmQT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762279735; x=1793815735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aTa9GE+/22bLrhS470IyutAtfT1shHIprrRqIkjbpf8=;
  b=dEpVbmQTtHVTZiEDP8EQD6Vs+BI+nRb7UBevBwUZggz60qyF7xJd4oGh
   OMd2ue3N0mu9MCSgylZDx55h2x2fot9d2Hfb/QUuxRUW8iiUqKI7+X5mU
   wNK2vQaIpgqyA40DlBo9ywqtyeKh/2QqWLxoD123bSQNLqgGOtb3/9FfW
   Vwo0WtmFd0CDxp1A0iZpRhilcxXWpqAlLKKH8mNhRoM0TnGhBOHFnBZGc
   Ny17sa8wupMHgGkqLAbBX0BGS13WVqVDqFJmJLNtnv73lWjXTs+qefcVh
   dAPIHTXhwU/uEyNe//YB/h/fY5zYdEddBEISsPdB7qLwUHGFCTXlVLzxR
   w==;
X-CSE-ConnectionGUID: ZVWWO4n9S5aDLtLO9Y903Q==
X-CSE-MsgGUID: QyNlJsB6SZmP5hU27Vk23g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64415751"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="p7s'346?scan'346,208,346";a="64415751"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:08:54 -0800
X-CSE-ConnectionGUID: qgDB9Ep5T/24Gx5jEEy0iw==
X-CSE-MsgGUID: pGV0HIBlRficJiB9fZCSgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="p7s'346?scan'346,208,346";a="192312020"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.125.110.187])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:08:53 -0800
From: Thiago Macieira <thiago.macieira@intel.com>
To: Borislav Petkov <bp@alien8.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christopher Snowhill <chris@kode54.net>,
 Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
 mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
 me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
 darwi@linutronix.de, stable@vger.kernel.org
Subject:
 Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an error.
Date: Tue, 04 Nov 2025 10:08:48 -0800
Message-ID: <1964951.LkxdtWsSYb@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To:
 <CAHmME9o+cVsBzkVN9Gnhos+4hH7Y7N6Sfq9C5G=bkkz=jzRUUA@mail.gmail.com>
References:
 <aPT9vUT7Hcrkh6_l@zx2c4.com>
 <20251104132118.GCaQn9zoT_sqwHeX-4@fat_crate.local>
 <CAHmME9o+cVsBzkVN9Gnhos+4hH7Y7N6Sfq9C5G=bkkz=jzRUUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3846252.MLUfLXkozy";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart3846252.MLUfLXkozy
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 4 November 2025 06:28:07 Pacific Standard Time Jason A. Donenfe=
ld=20
wrote:
> On Tue, Nov 4, 2025 at 2:21=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
> > And the problem here is that, AFAICT, Qt is not providing a proper
> > fallback
> > for !RDSEED. Dunno, maybe getrandom(2) or so. It is only a syscall which
> > has been there since forever. Rather, it would simply throw hands in the
> > air.
> Qt seems to be kinda wild.

Hello Jason

> When you use -mcpu=3D, you generally can then omit cpuid checks. That's
> the whole idea. But then Qt checks cpuid anyway and compares it to the
> -mcpu=3D feature set and aborts early. This mismatch happens in the case
> Christopher is complaining about when the kernel has masked that out
> of the cpuid, due to bugs. But I guess if it just wouldn't check the
> cpuid, it would have worked anyway, modulo the actual cpu bug. But
> regarding rdseed/rand bugs, there's a workaround for earlier AMD
> rdrand bugs:
> https://github.com/qt/qtbase/blob/dev/src/corelib/global/qsimd.cpp#L781 B=
ut
> then it skips that for -mcpu=3D with `(_compilerCpuFeatures &
> CpuFeatureRDRND)`. Weird.

The general theory is that if you ask the compiler to enable a feature, it'=
s=20
because you know you're going to run on a CPU with that particular feature =
and=20
therefore we can remove the check.

That includes RDRND: checkRdrndWorks() has:

    // But if the RDRND feature was statically enabled by the compiler, we
    // assume that the RNG works. That's because the calls to qRandomCpu()=
=20
will
    // be guarded by qCpuHasFeature(RDRND) and that will be a constant true.
    if (_compilerCpuFeatures & CpuFeatureRDRND)
        return true;

The code you pointed out above is guarded by this particular piece of code:

    if (features & CpuFeatureRDRND && !checkRdrndWorks(features))
        features &=3D ~(CpuFeatureRDRND | CpuFeatureRDSEED);

As you said, we do have some code to print the CPU feature mismatch on load=
,=20
so as to avoid crashing with SIGILL. But it won't apply for the broken RDRN=
D=20
case, because the side effect of that code is we assume it isn't broken in =
the=20
first place. That's because we're optimising for the case where it isn't=20
broken, which I find reasonable.

> Another strange thing, though, is the way this is actually used. As
> far as I can tell from reading this messy source,
> QRandomGenerator::SystemGenerator::generate() tries in order:
>=20
> 1. rdseed
> 2. rdrand
> 3. getentropy (getrandom)
> 4. /dev/urandom
> 5. /dev/random
> 6. Something ridiculous using mt19937

#1 and #2 are a runtime decision. If they fail due to lack of entropy or ar=
e=20
unavailable, we will use getentropy().

#3 is mutually exclusive with #4 and #5. We enable getentropy() if your gli=
bc=20
has it at compile time, or we use /dev/urandom if it doesn't. There's a mar=
ker=20
in the ELF header then indicating we can't run in a kernel without=20
getrandom().

#6 will never be used on Linux. That monstrosity is actually compiled out o=
f=20
existence on Linux, BSDs, and Windows (in spite of mentioning Linux in the=
=20
source). It's only there as a final fallback for systems I don't really car=
e=20
about and can't test anyway.

> In addition to rdseed really not being appropriate here, in order to
> have seeds for option (6), no matter what happens with 1,2,3,4,5, it
> always stores the first 4 bytes of output from previous calls, just in
> case at some point it needs to use (6). Goodbye forward secrecy? And
> does this mt19937 stuff leak? And also, wtf?

See above.

What do you mean about RDSEED? Should it not be used? Note that=20
QRandomGenerator is often used to seed a PRNG, so it seemed correct to me t=
o=20
use it.

> This is totally strange. It should just be using getrandom() and
> falling back to /dev/urandom for old kernels unavailable. Full stop.
> Actually, src/corelib/global/minimum-linux_p.h suggests 4.11 is
> required ("We require the following features in Qt (unconditional, no
> fallback)"), so it could replace basically this entire file with
> getentropy() for unix and rtlgenrandom for windows.

When this was originally written, getrandom() wasn't generally available an=
d=20
the glibc wrapper even less so, meaning the code path usually went through =
the=20
read() syscall. Using RDRAND seemed like a good idea to avoid the transitio=
n=20
into kernel mode.

I still think so, even with getrandom(). Though, with the new vDSO support =
for=20
userspace generation, that bears reevaluation.=20

There's also the issue of being cross-platform. Because my primary system i=
s=20
Linux, I prefer to have as little differentiation from it as I can get away=
=20
with, so I can test what other users may see. However, I will not hesitate =
to=20
write code that is fast only on Linux and let other OSes deal with their ow=
n=20
shortcomings (q.v. qstorageinfo_linux.cpp, qnetworkinterface_linux.cpp,=20
support for glibc-hwcaps). In this case, I'm not convinced there's benefit =
for=20
Linux by bypassing the RDRND check and going straight to getentropy()/
getrandom().

> Sounds great, like we should just use QRandomGenerator::global() for
> everything, right? Wrong. It turns out QRandomGenerator::system() is
> the one that uses 1,2,3,4,5,(6godforbid) in my email above.
> QRandomGenerator::global(), on the contrary uses
> "std::mersenne_twister_engine<quint32,32,624,397,31,0x9908b0df,11,0xfffff=
fff
> ,7,0x9d2c5680,15,0xefc60000,18,1812433253>".

The separation is because I was convinced, at the time of developing the co=
de,=20
that advocating that people use a system-wide resource like the RDRND or=20
getrandom() entropy for everything was bad advice. So, instead, we create o=
ur=20
own per-process PRNG, securely seed it from that shared resource, and then =
let=20
people use it for their own weird needs. Like creating random strings.

And it's also expected that if you know you need something more than baseli=
ne,=20
you'll be well-versed in the lingo to understand the difference between=20
global() and system().

=2D-=20
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCG - Platform & Sys. Eng.

--nextPart3846252.MLUfLXkozy
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTA0MTgwODQ4WjAvBgkqhkiG9w0BCQQxIgQg
a8IsTOWH0wk86fzeJOOYUaE9dK3VHntfon+okgU19NAwNQYJKoZIhvcNAQkPMSgwJjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAJWkR1zuRbZg
M9uygqF1d7fGIsa0UJxRlmVzdSk30VqYC4flTEFI7SWY+4jsUP4LaDFGYd0Prc00+1tmZl1qShFQ
Np796ICnORHlUa8SjG8EmnfkrdgC/1Y6t7c1B3oRK60H745lnhOV3p7dcbZ+kyF6eVWynBvVlpiU
jAWD3hF9gEmqY4PMBMuXV/wJrSKnpaeT6WCe2x8O8+VWFkipdBbNT4xi6zJFKfrUBYNFbdOd6nB8
rcgRZMAkoa98tCyFIDou7plOzPSBfE/n/wqvV2G+pkuHn8e388b9SobMPYVvsp2X1lBbNEtjGZTK
nngH4C5+3syMDC/erom/yrJPWOg=


--nextPart3846252.MLUfLXkozy--




