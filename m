Return-Path: <stable+bounces-87545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA99A67B2
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C94C1F2178D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE861F1312;
	Mon, 21 Oct 2024 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RnwIEPm8"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D751E767C
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512799; cv=none; b=mu+J4WgkOpqATU40PvSNxOf22VPnuhR/LFHlSypmsdV4tj+07c6S04IYjACYkD7Bzxr74JfpLnGfdlLGkFW/5Kz3TjLcsC825XiiVQUw6xM22Wacsj665h/s5+Uu0TlU9sxHz03RU/GBvzR8aRCfsX6+rINFf7W1p/Ayutx5nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512799; c=relaxed/simple;
	bh=RWy+RnuR63Ha+i96p3Pohnrz/9sTcs4L21KcDfugUh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d/LImeSRB5eLYFstPA3efg65w78aCgDFhRBpz0VY/xjAgoaqjoWrGBbWbWDdJNNQKaZ23uRFsSq+q3lz6XfUqQyEDzT2z/wmcMiFRqopIr0lnlaT+Ggkl0ixqGCSTShjOZZgBWql1Y3hWiuuP8CG8EBwonjNXiKhapqgSjxKQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RnwIEPm8; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8ttHS002419;
	Mon, 21 Oct 2024 14:12:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	PJnOHHjyXC7os1xqeKKyo2sRQW8Q3jGYpH5EQHo1pG0=; b=RnwIEPm8XzQ382Kp
	lxCg6YN54WjZMg8nEys+zHqWkKPJNhljaPTXlBtAUkOcpJTf4HEBfyT/GBwdDIot
	ELKZphKTokkszzFxqIb5I8D23ppYYTIkmeVUUW4NSk4esAxV896lfGJikS9RZKR3
	dm8MGPpo/1IPCAaeCeEYv7tEmPR+Yr7nGFfvt8M59p9wVKfjF3yeQcTRwvLRRV6W
	hJwAy6jb/vHdYnxkFVe8gtg1wT2+wTzNL5cwr9DZwYwaXeSZlycJFmm/H1voBu9+
	oh7LiJRtxBls/1s2KFesz9mkqp0m21iehWfUUbAea9X7GYLWojbrf7BELrTSkUSi
	xylI0g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42c6w6qnct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 14:12:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1C5D340064;
	Mon, 21 Oct 2024 14:10:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 293792232E4;
	Mon, 21 Oct 2024 14:09:50 +0200 (CEST)
Received: from [10.48.86.107] (10.48.86.107) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 21 Oct
 2024 14:09:46 +0200
Message-ID: <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com>
Date: Mon, 21 Oct 2024 14:09:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Linus Walleij <linus.walleij@linaro.org>,
        Andrey Ryabinin
	<ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey
 Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev
	<kasan-dev@googlegroups.com>
CC: Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Mark
 Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ard
 Biesheuvel <ardb@kernel.org>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
 <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com>
 <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 10/17/24 21:00, Linus Walleij wrote:
> On Thu, Oct 17, 2024 at 4:22 PM Clement LE GOFFIC
> <clement.legoffic@foss.st.com> wrote:
>>
>> On 10/17/24 14:59, Linus Walleij wrote:
>>> [...]
>>>
>>> +static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
>>> +{
>>> +     return (unsigned long)kasan_mem_to_shadow((void *)addr);
>>> +}
>>> +
>>
>> `kasan_mem_to_shadow` function symbol is only exported with :
>> CONFIG_KASAN_GENERIC or defined(CONFIG_KASAN_SW_TAGS) from kasan.h
>>
>> To me, the if condition you added below should be expanded with those
>> two macros.
> (...)
>>> +             if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> 
> Let's check this with the KASAN authors, I think looking for
> CONFIG_KASAN_VMALLOC
> should be enough as it is inside the if KASAN clause in
> lib/Kconfig.kasan, i.e. the symbol KASAN must be enabled for
> CONFIG_KASAN_VMALLOC to be enabled, and if KASAN is enabled
> then either KASAN_GENERIC or KASAN_SW_TAGS is enabled
> (the third option KASAN_HW_TAGS, also known as memory tagging
> is only available on ARM64 and we are not ARM64.)
> 
> But I might be wrong! Kconfig regularly bites me in the foot...
> 
> Yours,
> Linus Walleij

Hi Linus,

I saw your email about Melon's patch targeting the same subject.
If we don't enable KASAN either you patch or Melon's one do not compile.

[...]
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
[...]

Should be replaced with an #ifdef directive.
`kasan_mem_to_shadow` symbol is hiden behind :

include/linux/kasan.h:32:#if defined(CONFIG_KASAN_GENERIC) || 
defined(CONFIG_KASAN_SW_TAGS)

So symbol doesn't exist without KASAN enabled.

I don't know how to submit a comment on Melon's patch inside Russel's 
website.

No issue with KASAN enabled so I did some tests with your serie on a 
stm32mp157f-dk2 board and qemu.
I only get an issue on my board while testing with an ext4 fs on a 
sdcard and I'm unable to reproduce it with qemu.

Perhaps not related with this topic but as in the backtrace I am getting 
some keyword from our start exchange, I dump the crash below.
If this backtrace is somehow related with our issue, please have a look.

[ 1439.267852] 8<--- cut here ---
[ 1439.269570] Unable to handle kernel paging request at virtual address 
809b8480 when read
[ 1439.277631] [809b8480] *pgd=00000000
[ 1439.281287] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[ 1439.286534] Modules linked in: aes_arm aes_generic cmac algif_hash 
algif_skcipher af_alg stm32_adc stm32_timer_trigger 
stm32_lptimer_trigger snd_soc_stm32_sai_sub snd_soc_audio_graph_card 
snd_soc_simple_card_utils usb_f_ncm stusb160x u_ether brcmfmac_wcc typec 
hci_uart btbcm stm32_hash stm32_cryp crypto_engine snd_soc_cs42l51_i2c 
libdes snd_soc_stm32_i2s snd_soc_cs42l51 brcmfmac snd_soc_hdmi_codec 
bluetooth brcmutil stm32_vrefbuf snd_soc_core libcomposite 
stm32_adc_core snd_pcm_dmaengine ac97_bus snd_pcm cfg80211 snd_timer 
snd_soc_stm32_sai ecdh_generic ecc snd libaes stm32_cec soundcore 
stm32_ddr_pmu stm32_crc32
[ 1439.340928] CPU: 0 PID: 20797 Comm: grep Not tainted 6.6.48 #1
[ 1439.346767] Hardware name: STM32 (Device Tree Support)
[ 1439.351945] PC is at __read_once_word_nocheck+0x0/0x8
[ 1439.356965] LR is at unwind_exec_insn+0x364/0x658
[ 1439.361662] pc : [<c011369c>]    lr : [<c0113bb0>]    psr: 600f0193
[ 1439.367953] sp : de803358  ip : c20584b8  fp : bad0067c
[ 1439.373135] r10: de80344c  r9 : 0000000b  r8 : de80342c
[ 1439.378416] r7 : 00000009  r6 : c20584b8  r5 : 809b8480  r4 : de803400
[ 1439.384911] r3 : 00000007  r2 : 00000000  r1 : 00000000  r0 : 809b8480
[ 1439.391405] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[ 1439.398717] Control: 10c5387d  Table: c222c06a  DAC: 00000051
[ 1439.404398] Register r0 information: non-paged memory
[ 1439.409505] Register r1 information: NULL pointer
[ 1439.414197] Register r2 information: NULL pointer
[ 1439.418888] Register r3 information: non-paged memory
[ 1439.423881] Register r4 information: 4-page vmalloc region starting 
at 0xde800000 allocated at start_kernel+0x1a8/0x334
[ 1439.434669] Register r5 information: non-paged memory
[ 1439.439764] Register r6 information: non-slab/vmalloc memory
[ 1439.445466] Register r7 information: non-paged memory
[ 1439.450459] Register r8 information: 4-page vmalloc region starting 
at 0xde800000 allocated at start_kernel+0x1a8/0x334
[ 1439.461236] Register r9 information: non-paged memory
[ 1439.466330] Register r10 information: 4-page vmalloc region starting 
at 0xde800000 allocated at start_kernel+0x1a8/0x334
[ 1439.477207] Register r11 information: non-paged memory
[ 1439.482302] Register r12 information: non-slab/vmalloc memory
[ 1439.488103] Process grep (pid: 20797, stack limit = 0xd736559a)
[ 1439.494000] Stack: (0xde803358 to 0xde804000)
[ 1439.498385] 3340: 
   de803480 c01137f0
[ 1439.506512] 3360: c0100ff4 df113fb0 de803448 00000000 bad00678 
809b8480 de8034a0 de8034c8
[ 1439.514739] 3380: 00000001 809b8480 de803400 c1241d90 bad0067c 
c0114114 00004e20 de8034b0
[ 1439.522966] 33a0: de8034d4 de8034cc de803400 809b8480 c1241da8 
c1241da8 809b8480 de8034d0
[ 1439.531093] 33c0: 41b58ab3 c194f7f4 c0113ea4 c5349bc0 da2ee5c0 
da2ee604 dd811334 c034a6e4
[ 1439.539318] 33e0: 41b58ab3 c194f7f4 c0113ea4 00000000 00000000 
00000000 00000000 00000000
[ 1439.547440] 3400: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1439.555664] 3420: 00000000 00000000 00000000 809b8480 00000000 
809b8480 c1241da8 00000000
[ 1439.563887] 3440: c1ae9dc8 809bc000 00000000 00000000 00000000 
00000003 00000000 c2047e40
[ 1439.572011] 3460: 00000003 bad0069c 000002c2 00000000 c2048988 
00000003 c2047e40 8bf8f8ba
[ 1439.580238] 3480: de803500 c01f5200 de803500 00000000 c3020900 
00000001 00000000 faacd85f
[ 1439.588363] 34a0: de8034cc c01f5200 de803520 00000000 c3020900 
00000001 00000000 de803720
[ 1439.596591] 34c0: de8034ec c010ed7c 809b8480 de803abc c1241da8 
c1241da8 de803ab8 faacd85f
[ 1439.604818] 34e0: de803560 bad006a0 c207c280 c01f539c 00000000 
bad006a8 de8035a0 c01f52c4
[ 1439.612944] 3500: 41b58ab3 c195e47c c01f530c de803560 00000001 
00000000 de803700 c01736fc
[ 1439.621169] 3520: de803580 00000040 00000000 00000011 00000000 
d0c85340 00000000 de8036a0
[ 1439.629296] 3540: bad006b4 c01f0328 d0b58f00 c1c06cc0 de8036a0 
c07aa568 da2eae80 0000281e
[ 1439.637521] 3560: 00000005 bad006b4 de803600 faacd85f 00000000 
00000001 00000001 c036bcb8
[ 1439.645649] 3580: c036bcb8 c036d268 c015f29c c01803e4 c01fceb4 
c0218570 c0218bd0 c01fe05c
[ 1439.653876] 35a0: c01ffe5c c0eb80d8 c01bd890 c01b463c c01012c4 
c12a6bc4 c0100bc8 c0113850
[ 1439.662098] 35c0: c1241da8 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1439.670219] 35e0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1439.678441] 3600: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1439.686563] 3620: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1439.694786] 3640: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1439.703008] 3660: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1439.711134] 3680: 00000001 c5419b40 dd805360 c036d268 c5419904 
c54199dc bad006d8 c5419280
[ 1439.719360] 36a0: 00000001 c015f29c c65e7f00 1b0aeebb 0000014f 
c0e463fc d07d3800 faacd85f
[ 1439.727586] 36c0: 41b58ab3 c1955000 c015f20c 00000000 c0e46390 
c01a28b0 0000014f c5419580
[ 1439.735711] 36e0: 00000000 c195849c c01a282c c5419280 da2eae40 
00000000 0016e360 00000000
[ 1439.743937] 3700: 00000000 c01fd6f0 c5419280 da2eae40 da2eae80 
da2eae40 c5419288 00000000
[ 1439.752063] 3720: 00000000 c01850f0 1b0aeebb faacd85f c1b8be40 
da2eae40 c1b8be40 00000000
[ 1439.760289] 3740: c1c07144 c5419280 00000000 c1c07144 de803794 
c01803e4 00000000 00000000
[ 1439.768414] 3760: da2eb640 00000000 c207dac0 c1a3750c 1875f000 
da2e3940 bad006f4 ffffffae
[ 1439.776640] 3780: 00000000 c5419280 fffffff7 de803800 00000000 
c01fceb4 bad006f8 c1b8be40
[ 1439.784866] 37a0: 41b58ab3 c195ea00 c01fcd90 c1b8be40 00000000 
00000000 c01362fc c1241da8
[ 1439.792992] 37c0: 41b58ab3 c1956708 c017f024 c01736fc 00000000 
00000000 00000000 c01728b0
[ 1439.801219] 37e0: 00000000 c1c05d80 c20925e0 c5419280 c20925e0 
1b2d5580 da2e4a80 faacd85f
[ 1439.809344] 3800: c1c05d80 da2e4da0 c1c06e40 00000000 0000014f 
1a952e8f da2e4a40 da2e4da0
[ 1439.817571] 3820: de803a30 de803a30 da2e4da0 1a952e8f da2e4a40 
da2e4db0 da2e4a80 c0218570
[ 1439.825698] 3840: 0000014f da2e4db0 de803a30 c0218bd0 600f0193 
da2e4a40 c0218b70 da2e4a90
[ 1439.833925] 3860: da2e4a40 00000000 da2e4a40 c01fe05c da2e4a8c 
da2e4dd8 de803920 da2e4a98
[ 1439.842151] 3880: 00000050 c5419280 da2e4a94 00000006 de8039e8 
1a94faa3 0000014f bad00718
[ 1439.850277] 38a0: 41b58ab3 c195f258 c01fdd98 c01b5444 60010193 
c02024c8 c66e23cc 0000014f
[ 1439.858504] 38c0: 41b58ab3 c195f258 c01fdd98 0000014f 00000000 
1875f000 da2ee000 00023f1b
[ 1439.866630] 38e0: 1a94faa3 0000014f 7fffffff da2e4a68 da2ee000 
00000000 0000014f 1a94bf00
[ 1439.874857] 3900: 1875f000 7fffffff da2e4a50 c020540c 05fd815f 
1a94bf00 da2e4b18 faacd85f
[ 1439.883084] 3920: da2e4b18 da2e4a40 1a94faa3 0000014f 600f0193 
ffffffff 7fffffff da2e4a50
[ 1439.891212] 3940: da2e4b90 c01ffe5c 600f0193 0000000f da2e4b68 
da2e4a60 da2e4af0 da2e4b18
[ 1439.899438] 3960: 00000003 da2e4a70 da2e4b68 da2e4ac8 da2e4a4c 
da2e4bb8 da2e4b70 da2e4bc0
[ 1439.907565] 3980: 1a94faa3 0000014f 0000001a da2ee000 c0eb80a4 
c146d9e0 c30c3c00 c30b7428
[ 1439.915791] 39a0: 0000001a 1875f000 de8039b8 c0eb80d8 c30b7400 
c01bd890 c30b7400 c02b9c30
[ 1439.923918] 39c0: c1b8aab0 c30b7400 c5419280 c1b8aab0 c1c07538 
c1dbae00 de80e000 de80e00c
[ 1439.932145] 39e0: bad0075c c01b463c 0000001b 0000001b c1b8aab0 
c01012c4 c1b8ba74 de8039f8
[ 1439.940373] 3a00: de803a30 00000000 200f0013 ffffffff de803a64 
e5333f40 c5419280 c1241d90
[ 1439.948498] 3a20: bad0075c c12a6bc4 c0113850 c0100bc8 de803b00 
00000000 00000001 000000c0
[ 1439.956725] 3a40: e5333f40 de803ba0 de803bd0 00000001 e5333f40 
de803b00 c1241d90 bad0075c
[ 1439.964851] 3a60: c20584b8 de803a7c c0114114 c0113850 200f0013 
ffffffff 00000051 e5333f40
[ 1439.973078] 3a80: de803ba0 de803bd0 00000001 e5333f40 de803b00 
c1241d90 bad0075c c0114114
[ 1439.981305] 3aa0: de803ae0 00000001 de803bdc de803bd4 de803b00 
809b8480 c1241da8 c1241da8
[ 1439.989432] 3ac0: e5333f40 de803bd8 c0113ea4 c07aa5e8 da2eae80 
b778d32a ffffffff bad00760
[ 1439.997656] 3ae0: 41b58ab3 c194f7f4 c0113ea4 00000000 00000000 
00000000 00000000 00000000
[ 1440.005778] 3b00: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1440.014002] 3b20: 00000000 00000000 00000000 e5333f40 00000000 
e5333f40 c1241da8 00000000
[ 1440.022127] 3b40: c1ae9dc4 e5334000 00000000 00000000 00000001 
00000001 c015f29c c01803e4
[ 1440.030354] 3b60: c01fceb4 c0218570 c0218bd0 c01fe05c c01ffe5c 
c0eb80d8 c01bd890 891bf569
[ 1440.038580] 3b80: c01012c4 c01f5200 de803c00 891bf569 00000000 
faacd85f de803c20 c01f5200
[ 1440.046705] 3ba0: de803c20 faacd85f 00000000 c01f5200 de803c20 
00000000 00000000 c01d8bb4
[ 1440.054932] 3bc0: c62ff600 c1253858 de803bf4 c010ed7c e5333f40 
de804000 c1241da8 c1241da8
[ 1440.063059] 3be0: de803ffc faacd85f de803c60 bad00780 c204e68c 
c01f539c 0000000d c01f52c4
[ 1440.071285] 3c00: 41b58ab3 c195e47c c01f530c c01f52c4 c45904b4 
c01f52c4 c507a104 00000000
[ 1440.079510] 3c20: de803c88 00000040 00000000 00000008 c3020000 
de803c88 00000001 c62ff400
[ 1440.087635] 3c40: c1253858 c0887230 00000000 00000000 83b6dbea 
c507a104 00000000 faacd85f
[ 1440.095860] 3c60: 00000000 c62ff404 00000000 c3020000 00000000 
faacd85f c62ff604 00000000
[ 1440.103987] 3c80: c3020000 c036bd10 c036bd10 c036d64c c036bfb4 
c0369864 c01d8bb4 c01de580
[ 1440.112211] 3ca0: c0135ac4 c1241da8 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1440.120333] 3cc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1440.128555] 3ce0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1440.136777] 3d00: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1440.144899] 3d20: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1440.153121] 3d40: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1440.161343] 3d60: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1440.169469] 3d80: 00000000 00000000 c3020000 b7c5fec0 c62ff600 
c036d64c dd826bb8 c036bfb4
[ 1440.177696] 3da0: c3020000 c62ff600 c01d8bb4 dd826bb8 00000000 
c62ff604 c1253858 c0369864
[ 1440.185823] 3dc0: da2eb640 d19ca500 d19ca500 d19cad20 da2eb640 
c5419280 0000000a da2eb640
[ 1440.194049] 3de0: c1c70940 c62ff608 c62ff604 c1253858 c204e68c 
c01d8bb4 c3130000 00000000
[ 1440.202174] 3e00: 00000000 de803ee0 c31306ac c5419284 de803e80 
00000009 00000000 0000000a
[ 1440.210400] 3e20: da2eb680 c541948c bad007cc c1c06d14 00000001 
c31306ac c5419288 da2eb6a4
[ 1440.218627] 3e40: da2eb6c8 de803ec0 de803f2c 00000000 c3130200 
d0721280 de803f2c c017f120
[ 1440.226754] 3e60: 41b58ab3 c195cd48 c01d8858 80080093 c206f70c 
c01dd1a0 bad007d4 c01dd8c4
[ 1440.234980] 3e80: c62fea04 c2b8a004 00000055 c01e3e48 00000000 
00000001 00020330 c206f70c
[ 1440.243106] 3ea0: 41b58ab3 c1956708 c1b8ba80 00000009 c1c06d14 
c5419280 c204e44c c0136398
[ 1440.251333] 3ec0: c5419280 faacd85f c1b8c649 da2eb640 da2eb680 
c1c06d14 c5419280 c204e44c
[ 1440.259460] 3ee0: c206f70c da2eb650 c1331e80 c01de580 da2e4a50 
1875f000 c1c70940 da2eb64a
[ 1440.267686] 3f00: c5419284 c01736fc 00400000 c1c050a4 00000200 
c5419280 c5419284 00000101
[ 1440.275911] 3f20: 1875f000 c204dc48 0000000a c0135ac4 00000009 
00000009 c1b843d8 c1c05080
[ 1440.284037] 3f40: de803f30 c1b843b0 00000009 00000001 c1b8ba80 
00400000 00000000 0001bd06
[ 1440.292264] 3f60: de803fc0 c1c05d40 c30c3c00 00400000 c541948c 
bad007f0 de803f88 c0eb80d8
[ 1440.300391] 3f80: 41b58ab3 c1952a48 c01358f4 c02b9c30 00000000 
c30b7400 d0c85340 c088be94
[ 1440.308618] 3fa0: 00000000 c02b9c30 c1b8aab0 c1c07538 c1dbae00 
c1b8a2f4 c1b8a2fc de803fd8
[ 1440.316745] 3fc0: c1b8a2f4 c1b8a2fc de803fd8 1875f000 da2e92f4 
c12a7030 c1c0d940 c1b8ba80
[ 1440.324973] 3fe0: 1875f000 600f0013 1875f000 c20795c0 c5419360 
c5419470 e5333f40 c1241da8
[ 1440.333183]  __read_once_word_nocheck from unwind_exec_insn+0x364/0x658
[ 1440.339726]  unwind_exec_insn from unwind_frame+0x270/0x618
[ 1440.345352]  unwind_frame from arch_stack_walk+0x6c/0xe0
[ 1440.350674]  arch_stack_walk from stack_trace_save+0x90/0xc0
[ 1440.356308]  stack_trace_save from kasan_save_stack+0x30/0x4c
[ 1440.362042]  kasan_save_stack from __kasan_record_aux_stack+0x84/0x8c
[ 1440.368473]  __kasan_record_aux_stack from task_work_add+0x90/0x210
[ 1440.374706]  task_work_add from scheduler_tick+0x18c/0x250
[ 1440.380245]  scheduler_tick from update_process_times+0x124/0x148
[ 1440.386287]  update_process_times from tick_sched_handle+0x64/0x88
[ 1440.392521]  tick_sched_handle from tick_sched_timer+0x60/0xcc
[ 1440.398341]  tick_sched_timer from __hrtimer_run_queues+0x2c4/0x59c
[ 1440.404572]  __hrtimer_run_queues from hrtimer_interrupt+0x1bc/0x3a0
[ 1440.411009]  hrtimer_interrupt from arch_timer_handler_virt+0x34/0x3c
[ 1440.417447]  arch_timer_handler_virt from 
handle_percpu_devid_irq+0xf4/0x368
[ 1440.424480]  handle_percpu_devid_irq from 
generic_handle_domain_irq+0x38/0x48
[ 1440.431618]  generic_handle_domain_irq from gic_handle_irq+0x90/0xa8
[ 1440.437953]  gic_handle_irq from generic_handle_arch_irq+0x30/0x40
[ 1440.444094]  generic_handle_arch_irq from __irq_svc+0x88/0xc8
[ 1440.449920] Exception stack(0xde803a30 to 0xde803a78)
[ 1440.454914] 3a20:                                     de803b00 
00000000 00000001 000000c0
[ 1440.463141] 3a40: e5333f40 de803ba0 de803bd0 00000001 e5333f40 
de803b00 c1241d90 bad0075c
[ 1440.471262] 3a60: c20584b8 de803a7c c0114114 c0113850 200f0013 ffffffff
[ 1440.477959]  __irq_svc from unwind_exec_insn+0x4/0x658
[ 1440.483078]  unwind_exec_insn from call_with_stack+0x18/0x20
[ 1440.488722] 8<--- cut here ---

