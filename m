Return-Path: <stable+bounces-238564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UATBNVc+42lCDwEAu9opvQ
	(envelope-from <stable+bounces-238564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:18:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B742068E
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4276C302BA26
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CA32779D;
	Sat, 18 Apr 2026 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="wVvYnAT/"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FD1A9F97;
	Sat, 18 Apr 2026 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776500300; cv=none; b=n5sRUFybbk5OEtvwmHN/hHSBbyiyn/1vbZJUfOe50m8W2FIosLr5rB7ze6OzNyQiXuGrkCQkrgp1R8YvYgyRXGyi45K3/a0Ze0X58NZQLeW2azn4jhRTjrMfsBmMBvQExhTR8exnn9o6w2Y9kgFBA31XAtseO7SnQQAXP3tb2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776500300; c=relaxed/simple;
	bh=58Nx2v93ZA9eXYiI50qfWyPHnr1szniOI9LR9Uu8Kew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMKriFj7lpls/e+tMLGquKkK9oMLYxJrkXn1H0vqA31ndnUFa9Wcj2b6bVwtSmazPoSt/t+p2JudEZjUtZ0QyJ5ph2lrcYm2c3zgKmj73MXyKcjGNGjlz3JODWIzkKHZmafB0YKlQ0p2u6pB3PjI5kQtyCced1t6DIHsjBpDi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=wVvYnAT/; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776500293;
	bh=XqHVvN9NgOpGdVbOEEz4CdTo9qs3KQsa5VhgG3V11dM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=wVvYnAT/Ct2vhwzn6DlB2z2FhjiCjRzDy1A9sAtD1uzMwgiV5rUQQsJqsZJZxwto4
	 KA9Mw0pfhhi3vFxzv1mfmDAn06H8P5b5/H8D8d9e23lbOeQyiPXauN065ZqSM6uAV8
	 vYZFJUZyryPEaeTSfkzXYZyR2rpVTbFWPwU6Emqg=
Received: from [192.168.0.140] ([223.73.200.58])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 489B8065; Sat, 18 Apr 2026 16:18:09 +0800
X-QQ-mid: xmsmtpt1776500289t8llrmd2e
Message-ID: <tencent_EA958964799F4CF9F76BA2D10149C4E9720A@qq.com>
X-QQ-XMAILINFO: MpSLeT6aCErCMxBGA9j/hZxPKKY/QmpJ440tQWs+HfEzdlrGV8kb7XCCTdET6w
	 fn/+rLztR9v0sIR3skxw/b4Krmls1JZ8Th8MJhLD2HPS98Nmtw9FU8mZILm/0VQpUA8G1nsR7gil
	 42ujmgL+TWh60abOX7xvR+imhrEHwVSD/djMBche/ibkw/IDOmYcFMSsooMNyN9+xaiFbw4NQRlw
	 X4g7YoeWDX+lRRKMdZPdnM4P1psXvWWKPrUk84TfJd2gtPXWZ6e4JbrmyZ1+9900oJ+jUr/vvmxx
	 aBLnFo8p0Hw47yooiiJWu3gZqnUO7EVEOo/9gzd6kcnmJcMpycYCdwvfH/XV/SelPRebAOsrOAvL
	 hmNb6A0weMhiqccJ08hy/BnU7N8dIWSH9Ins+joKoEXx6PgJ+KG2dDf2Ti3elu/Od4656+k8Kyx+
	 RgwTxv51WasqrtzQsdWkLJ61RTLenFhWIbgLhEE2RGZbhnBM4+lewsaKiTW3DT+koP3A0LiP25nZ
	 pk2qk8v4n5G932LhwRy6gapqG3KfB3laAdagETjQH9JuifAKERMOOAR4DE355iDcDkURrPGO1cMe
	 n4Igj1GyudKUXsJ/O0+gBg0Q+fB1GN+9BY3q3b2vBkhVxmRnxbwbj1Q58i60ak+UWQE3s6H4vuor
	 QsYnbH7lNpCDv+Tw/dyd0kdm9YMbES9zQ1SNw4Cq9kjmPR0WLOrb0HSC1ozpteC+m75U50vl01/n
	 GmkhGF7sQ1q/S3mnYOrxMBWMXZovVK+k1//ifVWj/65sCCrITeSABwHeQqBIhDT43T99EKi0CIke
	 4DK6OD5PWUbpaHpqy/iMS2FvuLVOtRD9lXzmUo5p420JUKetZNmETG7wnakGXlA6Oan3VdbwM8M6
	 fOJkMJuqiyTAvzY10q2RjbzoXfKuI79qJaFGINGVeBuBdsPRJu5IEul2eM9moePEXWbpdXJ4/zKW
	 XdiQzbooe2gNeHWMkehbPpg0K7izMa5nN66Uf9PclgIowNBu38GdtzLsL9XhWmaKGPjx0UP1Wy7g
	 ASgninm1lGsWyHPOMWjGQ2g3JtEr+aXQ8gm8MV7NTjiGlpoHfmDLmo2poC+Go+dmDAM2yV2Q==
X-QQ-XMRINFO: MSVp+SPm3vtShu+46Gs5K85TYnOxPINDVg==
X-OQ-MSGID: <babe3723-b9b7-45b6-af5c-1b586200504c@foxmail.com>
Date: Sat, 18 Apr 2026 16:18:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to get
 clock
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 loongarch@vger.kernel.org, chenhuacai@loongson.cn, zhoubinbin@loongson.cn,
 jeffbai@aosc.io, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Zhang Yi <zhangyi@everest-semi.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Alexandru Ardelean <aardelean@deviqon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org
References: <tencent_7C78374FB9F4B3A37101E5C719715D8BC40A@qq.com>
 <aeI1_C5WGY5SzzcD@monoceros>
From: Li Jian <lazycat-xiao@foxmail.com>
In-Reply-To: <aeI1_C5WGY5SzzcD@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238564-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_MUA_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[foxmail.com:?];
	DMARC_DNSFAIL(0.00)[foxmail.com : SPF/DKIM temp error,none];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lazycat-xiao@foxmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,loongson.cn,aosc.io,kernel.org,perex.cz,suse.com,everest-semi.com,opensource.cirrus.com,renesas.com,deviqon.com,huawei.com];
	NEURAL_HAM(-0.00)[-0.806];
	R_DKIM_TEMPFAIL(0.00)[foxmail.com:s=s201512];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:mid]
X-Rspamd-Queue-Id: 878B742068E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe

在 2026/4/17 21:34, Uwe Kleine-König 写道:

> Hello,
> 
> On Fri, Apr 17, 2026 at 06:53:14PM +0800, Li Jian wrote:
>> When enabling ES8390 via ACPI description, es8389 would fail to
>> obtain a clock source, causing the driver to fail to initialize.
>> This was not an issue with older kernels, but since commit
>> abae8e57e49a ("clk: generalize devm_clk_get() a bit"),
>> devm_clk_get() would return an error pointer when a clock source
>> was not detected (instead of falling back to a static clock),
>> causing the driver to fail early.
>>
>> Use devm_clk_get_optional() instead to return to the previous
>> behaviour, allowing the use of a static clock source.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
> 
> Are you sure you identified the breaking commit correctly? I intended
> the patch not to introduce any semantic change, and even with your claim
> I don't spot the issue in abae8e57e49a.
> 


There was a misunderstanding on how the Fixes: tag should be used - I 
meant to say that your commit changed a behaviour, not that it was 
broken. I should have pointed to a commit to this driver instead.

In my case, since the device was described in ACPI and it does not 
export a clock to the operating system, it was then necessary to utilize 
a fallback. Before your commit, missing clocks returned a NULL pointer. 
However, your commit correctly makes it return an error pointer instead 
- now, since the driver initialization checks for error pointers, so I 
switched to devm_clk_get_optional(), which falls back to a static clock 
source to avoid this issue on ACPI platforms.

Again, your commit is correct, but I was not using the Fixes: tag 
correct - indeed, a missing clock should return an error pointer, not 
NULL. Sorry about that and I will submit v2 to fix this.

Best regards,
Li Jian

 > Best regards
 > Uwe


