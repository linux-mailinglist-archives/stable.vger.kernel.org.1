Return-Path: <stable+bounces-192457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C2C336E1
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 00:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F31463613
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058BB34B405;
	Tue,  4 Nov 2025 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpUcSfSF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A634B418;
	Tue,  4 Nov 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300246; cv=none; b=qbA2KKT8LkWXM9bjfRW7DAAxkE/aePXsgXbgqUX06knwDiUzCQ8mta036kEeasm5/Ox5dnXO0133OOFUa7slwSUSRfyzI6qzbDdx43o59Vmanuh2JHlCTko41Rk7OPnGYCWxL5icpYb9O3uinVgmgfqqjnHxvm4Z4d7wR/cwENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300246; c=relaxed/simple;
	bh=LkvWov5GrvG76lwDGpWLDBSS8izSLLNjD3Y5Lghmdg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8DFojfAeuFzCFpepQNqbFPZH4TCHrs4LDZCBATYVZ093IG8j+95rZqrtsXA3rmYEYCoH/chIo5fois7Oyii9RgUEqbs41eqGYw8xw/RLSGr6bTYO4do8BxVZ9n/enN3SUQgtj9KBQ2jXuLeFtOI1tv9uGthJ7qCCMKeMwqCMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpUcSfSF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762300245; x=1793836245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LkvWov5GrvG76lwDGpWLDBSS8izSLLNjD3Y5Lghmdg8=;
  b=VpUcSfSFdKx6Tja2vr5FOgynZNhDrHuwm7yuZ3bAFuMDkg7hswZRPXAs
   eNnWTsnI2AgzxFXq5iLkl7MBP2kQPioyri/MsYeEQGpDF+My9+lD8YxQE
   /5qzaz7ZAC0hkx/06lLVNph+jSSUi3Chq7FhbEjJqDyw9qnSaJXllrb8M
   tS25vcfpRNz8SwHwvXzQczUZHRd36+J6xK36o6jVjmGIC8mAJW/cQ2TqL
   4J2O74DdjNHnSeu6CvKskJeKYaz/PqfXFcCBnT2gM1Aioa6qOZq7bbVnk
   BZhAH+v+l9y8dR9LhJoyGcmcYsDgfutlH6zR+Gyp7XHfPeFeVit5guhqT
   Q==;
X-CSE-ConnectionGUID: 4IAGgtxARm+SG5rC0MRkqg==
X-CSE-MsgGUID: udvApQ0ST2q7H08VKux8sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75756295"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="p7s'346?scan'346,208,346";a="75756295"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:50:44 -0800
X-CSE-ConnectionGUID: XydqqxGxQTGLba4Q8gTerA==
X-CSE-MsgGUID: S5voIT8kRxqRiz9NgcCVxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="p7s'346?scan'346,208,346";a="186969667"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.125.110.187])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:50:43 -0800
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
Date: Tue, 04 Nov 2025 15:50:37 -0800
Message-ID: <4632322.0HT0TaD9VG@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To:
 <CAHmME9o+Sc7kh8NAxQ6Kr49-58hNXbvSkw_7JTLhObOLgEavBA@mail.gmail.com>
References:
 <aPT9vUT7Hcrkh6_l@zx2c4.com> <1964951.LkxdtWsSYb@tjmaciei-mobl5>
 <CAHmME9o+Sc7kh8NAxQ6Kr49-58hNXbvSkw_7JTLhObOLgEavBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2030169.gy9Pd6rRys";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart2030169.gy9Pd6rRys
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 4 November 2025 13:56:11 Pacific Standard Time Jason A. Donenfeld 
wrote:
> I didn't see that SkipHWRNG thing being set anywhere. That looked like
> it was internal/testing only. So #1 and #2 will always be tried first.
> At least I think so, but it's a bit hard to follow.

It is an internal thing. It's meant for the unit testing only, where we force 
the generator to generate specific values, so we can test the functions that 
use it.

> > #3 is mutually exclusive with #4 and #5. We enable getentropy() if your
> > glibc has it at compile time, or we use /dev/urandom if it doesn't.
> > There's a marker in the ELF header then indicating we can't run in a
> > kernel without getrandom().
> 
> That's good. You can always call getrandom via the syscall if libc
> doesn't have it, but probably that doesn't matter for you, and what
> you're doing is sufficient.

I know, but I preferred to use getentropy() because it's the same API as 
OpenBSD and others. It's one fewer option to maintain and shared with other 
platforms.

> > #6 will never be used on Linux. That monstrosity is actually compiled out
> > of existence on Linux, BSDs, and Windows (in spite of mentioning Linux in
> > the source). It's only there as a final fallback for systems I don't
> > really care about and can't test anyway.
> 
> That's good. Though I see this code in the fallback:
> 
>     // works on Linux -- all modern libc have getauxval
>     #  ifdef AT_RANDOM
> 
> Which makes me think it is happening for Linux in some cases? I don't
> know; this is hard to follow; you know best.

I added that while developing the fallback. But if you scroll up, you'll see:

#elif QT_CONFIG(getentropy)
static void fallback_update_seed(unsigned) {}
static void fallback_fill(quint32 *, qsizetype) noexcept
{
    // no fallback necessary, getentropy cannot fail under normal 
circumstances
    Q_UNREACHABLE();
}


Strictly speaking, if you don't have getentropy(), the fallback will be 
compiled in, in case someone runs the application is a messed up environment 
with /dev improperly populated. In practice, that never happens and 
getentropy() appeared in glibc 2.25, which is now older than the oldest distro 
we still support.

> It'd probably be a good idea to just remove this code entirely and
> abort. If there's no cryptographic source of random numbers, and the
> user requests it, you can't just return garbage... Or if you're going
> to rely on AT_RANDOM, look at the (also awful fallback) code I wrote
> for systemd. But I dunno, just get rid of it...

For Linux, I agree. Even for the BSDs. And effectively it is (see above).

But I don't want to deal with bug reports for the other operating systems Qt 
still supports (QNX, VxWorks, INTEGRITY) for which I have no SDK and for which 
even finding man pages is difficult. I don't want to spend time on them, 
including that of checking if they always have /dev/urandom. There are people 
being paid to worry about those. They can deal with them.

> RDRAND and RDSEED are slow! Benchmark filling a buffer or whatever,
> and you'll find that even with the syscall, getrandom() and
> /dev/urandom are still faster than RDRAND and RDSEED.

Interesting!

I know they're slow. On Intel, I believe they make an uncore request so the 
SoC generates the random numbers from its entropy cache. But I didn't expect 
them to be *slower* than the system call.

> Here are timings on my tiger lake laptop to fill a gigabyte:
> 
> getrandom vdso: 1.520942015 seconds
> getrandom syscall: 2.323843614 seconds
> /dev/urandom: 2.629186218 seconds
> rdrand: 79.510470674 seconds
> rdseed: 242.396616879 seconds
> 
> And here are timings to make 25000000 calls for 4 bytes each -- in
> case you don't believe me about syscall transitions:
> 
> getrandom vdso 0.371687883 seconds
> getrandom syscall: 5.334084969 seconds
> /dev/urandom: 5.820504847 seconds
> rdrand: 15.399338418 seconds
> rdseed: 45.145797233 seconds

Thanks for providing the 4-byte numbers. We ask for a minimum of 16 to 
amortise syscall transitions, so the numbers will be better than your 5.3-5.8 
seconds.

> Play around yourself. But what's certain is that getrandom() will
> always be *at least as secure* as rdrand/rdseed, by virtue of
> combining those with multiple other sources, and you won't find
> yourself in trouble viz buggy CPUs or whatever. And it's faster too.
> There's just no reason to use RDRAND/RDSEED in user code like this,
> especially not in a library like Qt.

I'm coming around to your point of view.

> The right thing to do is to call each OS's native RNG functions. On
> Linux, that's getrandom(), which you can access via getentropy(). On
> the BSDs that's getentropy(). On Windows, there's a variety of ways
> in, but I assume Qt with all its compatibility concerns is best off
> using RtlGenRandom. Don't try to be too clever and use CPU features;
> the kernel already takes care of abstracting that for you via its RNG.
> And especially don't be too clever by trying to roll your own RNG or
> importing some mt19937 madness.

Indeed. Linux is *impressively* fast in transitioning to kernel mode and back. 
Your numbers above are showing getrandom() taking about 214 ns, which is about 
on par what I'd expect for a system call that does some non-trivial work. 
Other OSes may be an order of magnitude slower, placing them on the other side 
of RDRAND (616 ns).

Then I have to ask myself if I care. I've been before in the situation where I 
just say, "Linux can do it (state of the art), so complain to your OS vendor 
that yours can't". Especially as it also simplifies my codebase.

> I'd recommend that you fix the documentation, and change the function
> names for Qt7. You have a cryptographic RNG and a deterministic RNG.
> These both have different legitimate use cases, and should be
> separated cleanly as such.

QRandomGenerator *can* be used as a deterministic generator, but that's 
neither global() nor system(). Even though global() uses a DPRNG, it's always 
seeded from system(), so the user can never control the initial seed and thus 
should never rely on a particular random sequence.

The question remaining is whether we should use the system call for global() 
or if we should retain the DPRNG. This is not about performance any more, but 
about the system-wide impact that could happen if someone decided to fill in a 
couple of GB of of random data. From your data, that would only take a couple 
of seconds to achieve.

> For now, you can explain the global() one as giving insecure
> deterministic random numbers, but is always seeded properly in a way
> that will always be unique per process. And system() as giving
> cryptographically secure random numbers. Don't try to call anything
> involving std::mersenne_twister_engine "secure"; instead say,
> "uniquely seeded" or something like that, and mention explicitly that
> it's insecure and deterministic.

From everything I could read at the time, the MT was cryptographically-secure 
so long as it had been cryptographically-securely seeded in the first place. I 
have a vague memory of reading a paper somewhere that the MT state can be 
predicted after a few entries, but given that it has a 624*32 = 10368 bit 
internal state I find that hard to believe.


Anyway, from the original point of the thread:

Christopher Snowhill wrote:
> Anyway. A bug report was sent here:
> 
> https://lore.kernel.org/lkml/9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.or
> g/
> 
> Qt is built with -march=znver4, which automatically enables -mrdseed.
> This is building rdseed 64 bit, but then the software is also performing
> kernel feature checks on startup. There is no separate feature flag for
> 16/32/64 variants.

Borislav Petkov wrote:
> And the problem here is that, AFAICT, Qt is not providing a proper fallback
> for !RDSEED. Dunno, maybe getrandom(2) or so. It is only a syscall which has
> been there since forever. Rather, it would simply throw hands in the air.

There is a fallback, but it was disabled for those builds. It was a choice, 
even if not a conscious choice.

From my point of view as QtCore maintainer, if you pass -mxxx to the compiler 
(like -msse3, -mavx512vbmi2, etc.), you're telling the compiler and the 
library that they're free to generate code using that ISA extension without 
runtime checking and expect it to work. If you want runtime detection, then 
don't pass it or pass -mno-xxx after the -march. RDRAND and RDSEED are no 
different, nor AESNI,  VAES or SHANI, which the compiler does not currently 
ever generate. I'm not going to change my opinion on this, even if I remove 
the code that depended on the particular feature.

I can't change the past. Disabling the instruction now will either generate a 
SIGABRT on start or a SIGILL when it's used. It's no different than if we 
detected the VPSHUFBITQMB instruction is broken and decided to turn off 
AVX512BITALG.  I concur with Thomas Gleixner's summary at 
https://lore.kernel.org/all/878qgnw0vt.ffs@tglx/:

>       1) New microcode
>       
>       2) Fix all source code to either use the 64bit variant of RDSEED
>          or check the result for 0 and treat it like RDSEED with CF=0
>          (fail) or make it check the CPUID bit....

Or 3) recompile the code with the runtime detection enabled.

It's a pity that Qt always uses the 64-bit variant, so it would have worked 
just fine.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCG - Platform & Sys. Eng.

--nextPart2030169.gy9Pd6rRys
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTA0MjM1MDM3WjAvBgkqhkiG9w0BCQQxIgQg
LRZm+yWaJzQWTHZTOspMEEFjISEWD9YUGS5QTFnNmHowNQYJKoZIhvcNAQkPMSgwJjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBACpUjzQIqEW8
/b5CtjPaDGBzRlfiWhVFiX/ysAE0ZL5aNlvdrqQyoCYvACUQOnDqdLq6wSqQ/9QqW9Sdvj7iLjMj
BCtQPwG7F6ERrY4VoFtALjuThVh9eF4jbHXEgb43TCuXRH+IF6GVAtJ+ld0WQs5w4Ismz17/RAtV
L2mWhyyxTzUb+tHV8z9o8XR0s+QjWcv3zZIM7NXc9X0rjhE9umfGT+xEl2PnZEeZKTCct1nY73H9
uKgS+xSZvABpunzCaPQS3nXDinZt7jfM5pvdZNONmwhtpGNuchep1iLF195L3A7Jc0Tl9xs4adaq
IHMUUhecG7wDTQ6IHD1OLcMwpb8=


--nextPart2030169.gy9Pd6rRys--




