Return-Path: <stable+bounces-164460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B886B0F4F6
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33DC1C24B3A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5EE2EB5C5;
	Wed, 23 Jul 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JPOS8cZ5"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B52EA14D;
	Wed, 23 Jul 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279799; cv=none; b=m64mSaXBhaflUJ4jGPJB8twETR7z3ROUNVVNUJp8Qrtuds/tW+SZCx4wcF6I+mKZH3+jENVrXn7Cw6qbBoW3G06Vo5uyT5Pz9G4bj1Bq7gVi+gKvagMx6AiYytAqOvWk5vkqErl9WNMxneJMeqQoIbToOZTqfJ8xPHibiq6WNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279799; c=relaxed/simple;
	bh=rHLzR3DWuoPsjoOUS5tpuu2jYPcAk5V3uu/hjvz8CKA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=nkTdvR4SaYRYnAPu8zfwgOB+PgpfxiT1xd2ACTtojQMP12tGpwtzBxYpbi4wTIqfPv4BDAJVwWkXFb3vpplb9WV+ec2ebFTq/RrCwO6N4lOuWRUDg5QO7xSMR+AO3ImFWJ9OLtwD6aZS43Draz6ghQmDJhkI5O9kicprWgtsTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JPOS8cZ5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:5fd2:1bb4:fa29:737] ([IPv6:2601:646:8081:9484:5fd2:1bb4:fa29:737])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56NE8mPJ1176164
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 23 Jul 2025 07:08:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56NE8mPJ1176164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753279730;
	bh=Z525S9Hljk1kFHZ9q9qjWOfnEkBN+CVsXAzilr8qm8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JPOS8cZ5fW0b4s+xjjHBXjfIygt93132qJ8IiQ0ZwGxq7y3YD5AApbSPOJSIuWsrL
	 7XfpVUFfE24wF63EQLvHbBfPtxbIFJnUhUXYyFCxrgS1cTKqJ3HhkNE+dZanVVEHjc
	 wuexfGxvCRzKxBPRtYIwOMUeE0YgnMzzTMc4Jdz0eILK0N2COgEn4Twqh94ejaGit9
	 3M+dFT5r5k3LVnlJnXb3e7a8H+WuhJL0Bg2r/nFIzwowHtsG+rRZBL7S+16T7SXXK5
	 cCQWzvxzaYKlHf8lZSX3IBFZKLU8vOgMH7VsHPXuZsPoJZi77FLeohJ9TgNpoJfuw1
	 pwtuTY3TO8ZaQ==
Content-Type: multipart/mixed; boundary="------------nCXPrGAbh2CIXtJ1Z1dwRDgB"
Message-ID: <641393bd-c3d7-4bd0-a3c7-da600685be1b@zytor.com>
Date: Wed, 23 Jul 2025 07:08:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Xin Li <xin3.li@intel.com>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>

This is a multi-part message in MIME format.
--------------nCXPrGAbh2CIXtJ1Z1dwRDgB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-07-23 02:22, Maciej Wieczor-Retman wrote:
> 
>  arch/x86/kernel/cpu/common.c       | 12 ++++++++++++
>  arch/x86/tools/cpufeaturemasks.awk |  8 ++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 77afca95cced..ba8b5fba8552 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1709,6 +1709,16 @@ static void __init cpu_parse_early_param(void)
>  	}
>  }
>  
> +static __init void init_cpu_cap(struct cpuinfo_x86 *c)
> +{
> +	int i;
> +
> +	for (i = 0; i < NCAPINTS; i++) {
> +		cpu_caps_set[i] = REQUIRED_MASK(i);
> +		cpu_caps_cleared[i] = DISABLED_MASK(i);
> +	}
> +}
> +

No... just use an static array initializer for cpu_caps_cleared[].  You
don't even need to add any code at all.

Ironically enough, I actually had those macros generated in the original
awk script version, but they weren't used.

And you MUST NOT initialize cpu_caps_set[].  What we *can* and probably
should do is, at the very end of the process, verify that the final mask
conforms to cpu_caps_set[] and print a nasty message and set the
TAINT_CPU_OUT_OF_SPEC flag:

	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK)

... but that is a separate patch, and doesn't need to be backported.

Xin send me a patch privately (attached) but it needs to have the
REQUIRED_MASK_INIT_VALUES part removed and made into a proper patch.

Xin didn't add an SoB on it, but you can use mine:

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>

	-hpa

--------------nCXPrGAbh2CIXtJ1Z1dwRDgB
Content-Type: text/x-patch; charset=UTF-8; name="xin.patch"
Content-Disposition: attachment; filename="xin.patch"
Content-Transfer-Encoding: base64

UmV0dXJuLVBhdGg6IDx4aW5Aenl0b3IuY29tPgpSZWNlaXZlZDogZnJvbSBbMTkyLjE2OC43
LjIwMl0gKFs3MS4yMDIuMTY2LjQ1XSkKCShhdXRoZW50aWNhdGVkIGJpdHM9MCkKCWJ5IG1h
aWwuenl0b3IuY29tICg4LjE4LjEvOC4xNy4xKSB3aXRoIEVTTVRQU0EgaWQgNTZNSU1rU2o2
OTI1OTAKCSh2ZXJzaW9uPVRMU3YxLjMgY2lwaGVyPVRMU19BRVNfMTI4X0dDTV9TSEEyNTYg
Yml0cz0xMjggdmVyaWZ5PU5PKQoJZm9yIDxocGFAenl0b3IuY29tPjsgVHVlLCAyMiBKdWwg
MjAyNSAxMToyMjo0NyAtMDcwMApES0lNLUZpbHRlcjogT3BlbkRLSU0gRmlsdGVyIHYyLjEx
LjAgbWFpbC56eXRvci5jb20gNTZNSU1rU2o2OTI1OTAKREtJTS1TaWduYXR1cmU6IHY9MTsg
YT1yc2Etc2hhMjU2OyBjPXJlbGF4ZWQvcmVsYXhlZDsgZD16eXRvci5jb207CglzPTIwMjUw
NjIxMDE7IHQ9MTc1MzIwODU2NzsKCWJoPWR5dGVBRnNBSnk1K1ZtUS92WlZBU3E4YzdpYUor
aU1CRFo1TngrSEN6bVk9OwoJaD1EYXRlOlN1YmplY3Q6VG86UmVmZXJlbmNlczpGcm9tOklu
LVJlcGx5LVRvOkZyb207CgliPW5ub1JyUHVYOUlKK28xUjdoOUE2RzJ5VTFaNloyNUN6STI0
K3E2c1RtbGF0UFk5NUw5WXJ6WEN6eXZYbGswYk5sCgkgb2ZCNG9DaE84U1plTVI3R2RhNm1B
cTNvbmp2TFNmNElkVk51bUZhMzRUMXIzeWhqbHlRMTRIak1VU2VOTXZzYUJhCgkgM3NEdDUr
TGY0OE14TzFGRWNEZy9BTzdTV2w2cUdiZUN0QnRKTTJJUVNNV0lCYjMxZ2dxQTBCZFpjTDlK
WXNOWndsCgkgM216Q2V2Z1MwdFhCOHh6dG9Vak9kUDQyTGJhQkdyY2R5ZmxTUGtsVmFQSC9r
RFFWeDlxV0ZTS2EwekdRVktlZzBOCgkgN0l0S3BINFdlMnBsTmp1MGc2dUR3WkJRQnh5TzM4
VlFsQ3VReStsL00vaTZIbW41NnJ0Rmh6Z3ltTnNVQUY1NFBWCgkgWFBQWFdVcXVEcC9Hdz09
Ck1lc3NhZ2UtSUQ6IDw5ZmZkN2YwYi1mMTk2LTQxYTEtODNjMi00YTgzMGQxYmIwMzVAenl0
b3IuY29tPgpEYXRlOiBUdWUsIDIyIEp1bCAyMDI1IDExOjIyOjQ2IC0wNzAwCk1JTUUtVmVy
c2lvbjogMS4wClVzZXItQWdlbnQ6IE1vemlsbGEgVGh1bmRlcmJpcmQKU3ViamVjdDogUmU6
IFtQQVRDSF0geDg2OiBDbGVhciBMQU0gYW5kIEZSRUQgZmVhdHVyZSBiaXRzClRvOiAiSC4g
UGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPgpSZWZlcmVuY2VzOiA8MjAyNTA3MjIwNzQ0
MzkuNDA2OTk5Mi0xLW1hY2llai53aWVjem9yLXJldG1hbkBpbnRlbC5jb20+CiA8MzIzODJm
NjAtNzlmYi00Y2ZhLTg3YjQtNTgxZjkyYzk4MGRhQHp5dG9yLmNvbT4KIDxBNEVCMTAxNi04
Q0Y3LTQ2MDktQkJGMS05QUVDODNCNTJBNEZAenl0b3IuY29tPgogPDU2NTRiM2JjLTE1ZDQt
NDQzYi1hN2IxLTJmOWZkMWQzZTBhYUB6eXRvci5jb20+CiA8QUEzOEQ3NTQtMzE4OS00OTA1
LUFBM0ItNDVBNTYwNjVCNjhBQHp5dG9yLmNvbT4KIDw5MWRkOGI3NS0xMTkxLTRhM2QtOWY2
Mi1kOTRjMzI1NzkzZmRAenl0b3IuY29tPgpDb250ZW50LUxhbmd1YWdlOiBlbi1VUwpGcm9t
OiBYaW4gTGkgPHhpbkB6eXRvci5jb20+CkF1dG9jcnlwdDogYWRkcj14aW5Aenl0b3IuY29t
OyBrZXlkYXRhPQogeHNETkJHVVB6MWNCREFDUy85eU9KR29qQkZQeEZ0ME9mVFd1TWwwdVNn
cHdrMzd1UnJGUFRUTHc0QmF4aGxGTDBianM2cSswCiAyT2ZHMzRSK2EwWkN1ajVjOXZnZ1VN
b09MZER5QTd5UFZBSlUwT1g2bHFwZzZ6L2t5UWczdDRqdmFqRzZhQ2d3U0R4NUt6ZzUKIFJq
M0FYbDhrMndiMGpkcVJCNFJ2YU9QRmlITkdnWENzNVBrdXgvcXIwbGFlRklwek1LTW9vdEdh
NGtmVVJnUGhSelVhTTF2eQogYnNNc0w4dnBKdEdVbWl0clNxZTVkVk5CSDAwd2hMdFBGTTdJ
YnpLVVJQVU9rUlJpdXNGQXN3MGExenRDZ29GY3pxNlZmQVZ1CiByYVR5ZTBML1ZYd1pkK2FH
aTQwMVYydExzQUh4eGNrUmk5cDNtYzBqRXhQYzYwam9LK2FaUHk2YW13U0N5NWtBSi9BYm9Z
dFkKIFZtS0lHS3gxeXg4UE95Nm0rMWxaOEMwcTliOGVKOGtXUEFSNzhQZ1QzN0ZRV0tZUzF1
QXJvRzJ3TGRLN0ZpSUVwUGhDRCt6SAogd2xzbG8yRVRiZEtqckxJUE5laFFDT1dyVDMyazh2
Rk5FTUxQNUcvbW1qZk5qNXNFZjNJT0tnTVRNVmw5QUZqc0lOTEhjeEVRCiA2VDhuR2JYL24z
bXNQNkEzNkZEZmRTRUFFUUVBQWMwV1dHbHVJRXhwSUR4NGFXNUFlbmwwYjNJdVkyOXRQc0xC
RFFRVEFRZ0EKIE54WWhCSVVxL1dGU0RUaU92VUlxdjJ1OURsY2RyamRSQlFKbEQ4OVhCUWtG
bzVxQUFoc0RCQXNKQ0FjRkZRZ0pDZ3NGRmdJRAogQVFBQUNna1FhNzBPVngydU4xSFVwZ3Yv
Y00yZnNGQ1FvZExBck1UWDVudDl5cUFXZ0E1dDFzcnJpNkVnUzhXM0YrM0tpdGdlCiB0WVRC
S3U2ajVCWHVYYVgzdnlmQ20remFqREpONzdKSHVZbnBjS0tyMTNWY1ppMVN3djZKeDF1MElJ
OERPbW9EWUxiMVEyWlcKIHY4M1c1NWZPV0oyZzcyeC9ValZKQlEwc1ZqQW5nYXpVM2NrYzBU
ZU5RbGtjcFNWR2EvcUJJSExmWnJhV3Rkck5BUVQ0QTFmYQogc1dHdUpyQ2hCRmh0S2JZWGJV
Q3U5QW9ZbW1iUW5zeDJFV29KeTNoN09qdGZGYXBKYlBacWwrbm81QUozTWs5ZUU1b1d5TEgr
CiBRV3F0T2VKTTdrS3ZuL2RCdWRva0ZTTmhEVXcwNmU3RW9WUFNKeVVJTWJZdFVPN2cyK0F0
dTQ0Ry9FUFAweVYwSjRsUk82RUEKIHdZUlhmZjcrSTFqSVdFSHBqNUVGVllPNlNtQmc3ekYy
aWxsSEVXMzFKQVB0ZERMREhZY1pEZlM0MWNhRUtPUUlQc2R6UWthUQogb1cyaGNoY2pjTVBB
ZnloaFJ6VXBWSExQeExDZXRQOHZyVmhUdm5hWlVvMHhhVlliMyt3alArRDVqLzMraHdibHUy
YWdQc2FFCiB2Z1ZiWjhGeDNUVXhVUENBZHIvcDczREdnNTdvSGpnZXpzRE5CR1VQejFnQkRB
RDRNZzdoTUZSUXFsem90Y05TeGF0bEFRTkwKIE1hZExmVVRGejh3VVVhMjFMUExySEJrVXdt
OFJ1amVoSnJ6Y1ZiUFl3UFhJTzB1eUwvRi8vL0NvZ01OeDdJd282Ynk0M0tPeQogZzg5d1ZG
aHl5MjM3RVk3NmoxbFZmTHpjTVltakJvVEg5NWZKQy9sVmI1V2h4aWw2S2pTTi9SL3kzamZH
MWRQWGZ3QXVaLzROCiBjTW9Pc2xXa2ZaS0plRXV0NWFaVFJlcEtLRjU0VDVyNDlIOUY3T0ZM
eXhyQy91STlVRHR0V3FNeGNXeUNrSGgwdjFEaTgxNzYKIGpqWVJOVHJHRWZZZkd4U3ArM2pZ
TDNQb05jZUlNa3FNOWhhWGpqR2wwVzFCNEJpZEsxTFZZQk5vdjByVEV6eXIwYTFyaVVycAog
UWsrNnovTEh4Q005bEZGWG5xSDdLV2VUb1RPUFFlYkQyQi9BaDVDWmxmdDQxaThMNkxPRi9M
Q3VEQnVZbHUvZkkybnVDYzhkCiBtNHd3dGtvdTFZL2tJd2JFc0UvNlJRd1JYVVpoek82bGxm
b045NkZjenIvUnd2UElLNVNWTWl4cVdxNFFHRkF5SzBtLzFhcDQKIGJoSVJyZENMVlFjZ1U0
Z2xvMTd2cWZFYVJjVFc1U2dYK3BHczRLSVBQQkU1Si9BQkQ2cEJuVVVBRVFFQUFjTEEvQVFZ
QVFnQQogSmhZaEJJVXEvV0ZTRFRpT3ZVSXF2MnU5RGxjZHJqZFJCUUpsRDg5WkJRa0ZvNXFB
QWhzTUFBb0pFR3U5RGxjZHJqZFI0QzBMCiAvUmNqb2xFam9aVzhWc3l4V3RYYXpRUG5hUnZ6
WjR2aG1HT3NDUHIyQlB0TWxTd0R6VGxyaThCQkcxLzN0L0ROSzRKTHV3RWoKIE9BSUUzZmtr
bStVRzRLanVkNmFOZXJhREk1MkRSVkNTeDZ4ZmYzYmptSnNKSk1iMTJtV2dsTjZMamRGNksr
UEUrT1RKVWgyRgogZE9oc2xONUMya2dsMGR2VXVldndNZ1FGM0lsakxtaS82QVBLWUpIamtK
cHUxRTZsdVplYy9sUmJldEh1TkZ0YmgzeGdGSUp4CiAyUnBnVkRQNHhCM2Y4cjBJK3k2dWEr
cDdmZ09qREx5b0ZqdWJSR2VkMEJlNDVKSlFFbjdBM0NTYjZYdTdOWW9ibnhma3dBR1oKIFE4
MWEyWHR2TlM3QWo2TldWb09RQjVLYk00eW9zTzUrTWUxVjFTa1gyamxubjI2SlBFdmJWM0tS
RmN3VjVSbkR4bTRPUVRTawogUFliQWtqQmJtK3R1Si9TbSs1WXA1VC9Cbkt6MjFGb0NTOHV2
VGl6aUhqMkg3Q3Vla242RjhFWWhlZ09ObStSVmczdmlrT3BuCiBnYW84NWk0SHdRVEs5L0Qx
d2dKSVFrZHdXWFZNWjZxL09BTGFCcDgydlEyVTlzalR5RlhnRGpnbGdoMDBWUkFIUDd1MVJj
dTQKIGw3NXcxeEluc2c9PQpJbi1SZXBseS1UbzogPDkxZGQ4Yjc1LTExOTEtNGEzZC05ZjYy
LWQ5NGMzMjU3OTNmZEB6eXRvci5jb20+CkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hh
cnNldD1VVEYtODsgZm9ybWF0PWZsb3dlZApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA3
Yml0CgpPbiA3LzIyLzIwMjUgMTE6MTMgQU0sIEguIFBldGVyIEFudmluIHdyb3RlOgo+IE9u
IDIwMjUtMDctMjIgMTE6MDgsIEguIFBldGVyIEFudmluIHdyb3RlOgo+Pj4KPj4+IFllcywg
c29tZXRoaW5nIGxpa2U6Cj4+Pgo+Pj4gCXZvaWQgX19pbml0IGluaXRfY3B1X2NhcCh2b2lk
KQo+Pj4gCXsKPj4+IAkJZm9yIChpID0gMDsgaSA8IE5DQVBJTlRTOyBpKyspIHsKPj4+IAkJ
CWNwdV9jYXBzX3NldFtpXSA9IFJFUVVJUkVEX01BU0soaSk7Cj4+PiAJCQljcHVfY2Fwc19j
bGVhcmVkW2ldID0gRElTQUJMRURfTUFTSyhpKTsKPj4+IAkJfQo+Pj4gCX0KPj4+Cj4+PiBB
bmQgaXQgd291bGQgYmUgYmV0dGVyIGlmIGl0IGNvdWxkIGJlIGRvbmUgYXQgYnVpbGQgdGlt
ZSAodG8gYXZvaWQKPj4+IGNoYW5naW5nIFhlbiB3aGljaCBoYXMgYSBkZWRpY2F0ZWQgc3Rh
cnR1cCBjb2RlIHBhdGgpOgo+Pj4KPj4+IAlfX3UzMiBjcHVfY2Fwc197c2V0LGNsZWFyZWR9
W05DQVBJTlRTICsgTkJVR0lOVFNdID0gewo+Pj4gCQl7UkVRVUlSRUQsRElTQUJMRUR9X01B
U0soaSksCj4+PiAJfTsKPj4+Cj4+PiBBbmQgdGhlbiBhcHBseV9mb3JjZWRfY2FwcygpIHdp
bGwgZG8gdGhlIHJlc3QgYXV0b21hdGljYWxseSA6KQo+Pgo+PiBZZWFoOgo+Pgo+PiB1MzIg
X19pbml0IGNwdV9jYXBzX2NsZWFyZWQgPSB7IC4uLiB9Owo+Pgo+PiAuLi4gd2hpY2ggY2Fu
IGNvbWUgc3RyYWlnaHQgb3V0IG9mIHRoZSBhd2sgc2NyaXB0Lgo+Pgo+IAo+IEhlY2ssIEkg
dGhpbmsgSSBldmVuIGRpZCBzb21ldGhpbmcgbGlrZSB0aGlzIGluIHRoZSBmaXJzdCB2ZXJz
aW9uLCBidXQKPiB0Z2x4IG9yIHNvbWVvbmUgZWxzZSBhc2tlZCB0byBheGUgaXQgYmVjYXVz
ZSBpdCB3YXNuJ3QgYmVpbmcgdXNlZCAoeWV0LikgIDspCj4gCgpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva2VybmVsL2NwdS9jb21tb24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9u
LmMKaW5kZXggNTgwOTUzNGVjYzk4Li5lYjA3NWZiZjMzN2UgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvY29tbW9uLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYwpAQCAtNzAzLDggKzcwMyw4IEBAIHN0YXRpYyBjb25zdCBjaGFyICp0YWJsZV9sb29r
dXBfbW9kZWwoc3RydWN0IApjcHVpbmZvX3g4NiAqYykKICB9CgogIC8qIEFsaWduZWQgdG8g
dW5zaWduZWQgbG9uZyB0byBhdm9pZCBzcGxpdCBsb2NrIGluIGF0b21pYyBiaXRtYXAgb3Bz
ICovCi1fX3UzMiBjcHVfY2Fwc19jbGVhcmVkW05DQVBJTlRTICsgTkJVR0lOVFNdIF9fYWxp
Z25lZChzaXplb2YodW5zaWduZWQgCmxvbmcpKTsKLV9fdTMyIGNwdV9jYXBzX3NldFtOQ0FQ
SU5UUyArIE5CVUdJTlRTXSBfX2FsaWduZWQoc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKTsKK19f
dTMyIGNwdV9jYXBzX2NsZWFyZWRbTkNBUElOVFMgKyBOQlVHSU5UU10gX19hbGlnbmVkKHNp
emVvZih1bnNpZ25lZCAKbG9uZykpID0gRElTQUJMRURfTUFTS19JTklUX1ZBTFVFUzsKK19f
dTMyIGNwdV9jYXBzX3NldFtOQ0FQSU5UUyArIE5CVUdJTlRTXSBfX2FsaWduZWQoc2l6ZW9m
KHVuc2lnbmVkIApsb25nKSkgPSBSRVFVSVJFRF9NQVNLX0lOSVRfVkFMVUVTOwoKICAjaWZk
ZWYgQ09ORklHX1g4Nl8zMgogIC8qIFRoZSAzMi1iaXQgZW50cnkgY29kZSBuZWVkcyB0byBm
aW5kIGNwdV9lbnRyeV9hcmVhLiAqLwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdG9vbHMvY3B1
ZmVhdHVyZW1hc2tzLmF3ayAKYi9hcmNoL3g4Ni90b29scy9jcHVmZWF0dXJlbWFza3MuYXdr
CmluZGV4IDE3M2Q1YmYyZDk5OS4uNmIzNTgzMzA0ZWU4IDEwMDc1NQotLS0gYS9hcmNoL3g4
Ni90b29scy9jcHVmZWF0dXJlbWFza3MuYXdrCisrKyBiL2FyY2gveDg2L3Rvb2xzL2NwdWZl
YXR1cmVtYXNrcy5hd2sKQEAgLTgxLDcgKzgxLDEzIEBAIEVORCB7CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHByaW50ZiAiXHRcXFxuXHRcdCgoeCkgPj4gNSkgPT0gJTJk
ID8gCiVzX01BU0slZCA6IiwgaSwgcywgaTsKICAgICAgICAgICAgICAgICB9CiAgICAgICAg
ICAgICAgICAgcHJpbnRmICIgMFx0XFxcbiI7Ci0gICAgICAgICAgICAgICBwcmludGYgIlx0
KSAmICgxVSA8PCAoKHgpICYgMzEpKSlcblxuIjsKKyAgICAgICAgICAgICAgIHByaW50ZiAi
XHQpICYgKDFVIDw8ICgoeCkgJiAzMSkpKVxuIjsKKworICAgICAgICAgICAgICAgcHJpbnRm
ICJcbiNkZWZpbmUgJXNfTUFTS19JTklUX1ZBTFVFU1x0XHRcdFxcIiwgczsKKyAgICAgICAg
ICAgICAgIHByaW50ZiAiXG5cdHtcdFx0XHRcdFx0XHRcXCI7CisgICAgICAgICAgICAgICBm
b3IgKGkgPSAwOyBpIDwgbmNhcGludHM7IGkrKykKKyAgICAgICAgICAgICAgICAgICAgICAg
cHJpbnRmICJcblx0XHQlc19NQVNLJWQsXHRcdFx0XFwiLCBzLCBpOworICAgICAgICAgICAg
ICAgcHJpbnRmICJcblx0fVxuXG4iOwogICAgICAgICB9CgogICAgICAgICBwcmludGYgIiNl
bmRpZiAvKiBfQVNNX1g4Nl9DUFVGRUFUVVJFTUFTS1NfSCAqL1xuIjsK

--------------nCXPrGAbh2CIXtJ1Z1dwRDgB--

