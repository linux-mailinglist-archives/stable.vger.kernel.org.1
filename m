Return-Path: <stable+bounces-223842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLFpIu7nr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:44:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DEA248BA4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE643189747
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A001543DA52;
	Tue, 10 Mar 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YMZh7USv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18643DA2D
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135199; cv=none; b=qn1zJIEH46V4PbjL3SXX9HZdxOMa118d5x+5mBbnTla8fvulTx1kuFjY6OKTbDCix1HAEzL8Yadd7ypqqjj6964QOigiYqQhbt2DXy96Qe5RYx5sFjixRfAod6AUeYbC7rxXFUNoCIzCw5FiJYoUUDVCC54mNMbOtLbDUnmep3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135199; c=relaxed/simple;
	bh=KOIuNgSbupOv7gvwTkUc4J3oQgG2zGapfap5O9rcRuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPX2JrxCPt6A+tA5DL2copcpqzl2skHf6+5KPaCZEhK24jX/Q++gGr3pU0iQcjrRUBDRut1OxbgjekmMmsaMU7eHXHOfc5bwrJA+QWRsHdqeFi5ads41PY4BYoX2p8WvRx26+cXZ2RcON9M69mw0TtPBO9Cxo/EzKMKAXUTZvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YMZh7USv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so19296355e9.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773135196; x=1773739996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv2lrhsCrsUoh1EEKIuTOwrnRpVoGN4jlExUbcg46p8=;
        b=YMZh7USv9+/X8FPnCKKtvc2Zse3dspUOnL1Tdldy13zy1mf6DL2GEU/1BRlD/rrdSM
         mMFI6vLg3PtzpJWkp/ym50hYEZOiO5NFgaWAYkKZ3xzKI9YECZUqzlvY0zAX+7gFLzuB
         OmdzYs7AfZ9aRSgTpeYgeYduRNSGcXbRd3lZr0R2HBBekbF0Ixlt4ONmS/4i0Ve6YYdq
         QMmnlY2zxV5Y8qD/nZceuYcpkWGdJS1YqeWAnGvN0sTLdNcEwf7rLLAeoXnGtTkmi0wa
         ks/vSDlIBtwPtDoObkhNt5ntZjS24wukB/h52mJIp4tLAg5Z9T9SPXZSu9LdvoGmvimx
         agXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773135196; x=1773739996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv2lrhsCrsUoh1EEKIuTOwrnRpVoGN4jlExUbcg46p8=;
        b=mtW2UdE35wewtaqQf5mFfFgC/nvCNhRgIjpwgB614Fq2X8ZqhnkLK6TWQ2PjSP1kuC
         UbzpZBLZ3UZv6QAOUKIzlXhXb00DMHdfDbZk/Qlt+7Dso7PlU61Wi6FxSLQsG8KLJdHR
         qu8iKjQaAxBXYon04zh/+fBOrroc9+kANCjSX6beEsT3hJT/ei0jObvUDW86D00ViqbP
         aSASjlkiiQJtKL8iSJQE7kMdaTsd1QYEeLMZk3VrMyv+dbJ1TQcEwLN3UFtotXOjkZnC
         aFzo7WfgT0vbxq17iuPBdrE7U9OqlzQ8WF+GBAfNu30k79Xfe9Bi0UPkwHZSt4n/sIL4
         PgyA==
X-Forwarded-Encrypted: i=1; AJvYcCVr9QZySsj6KK/NlCoE060CyxzUMBMOf3Gb0yqx/BCw+n76wkPYzhPtmWTIY72WQjmM+JHC3nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySCQrp9lqedaYfyJOD+aCfTxmx6rxRZ4sYh5mF0HjEXEeU11yJ
	WcxOrUJXJRewpG2nVjDHRUSyLFantrc5T9VF7gonZPld2PDoyJj2GOJEjHs5aZgJeEc=
X-Gm-Gg: ATEYQzw0nSv5HsL0tqbq+QMmiDetHnEey2LLnHuUZXVaisN5vGmw90pus+k+BK7kN3c
	GBbeWL0da947ZHsh8y3Bbq0158bPbVLRWHOTXtfwfIY8T3o8KsfarF2jLmeN5P/EiQy27FRtSr3
	bKlhENBZB/PbTXpuMMzNxFR1ahNCGRs0xWH6osvhnGb/rirz4cR0YPBZ71OD8RYNp7Hj4Adugkp
	izEsH2NTxOG7kkeTgKjXNycZ9VhCPcRR0QHke2dmwhLxEFL7UC720slmdiT4jpLAyph6UT/CTFL
	cNtVUKf6Ahz1nwr7sPvxN+2Qm0l+ZJ+Vzrf3Nxlyv5zJzOdPvHplsfzIhPB8o/sZYCJRmn8hAzs
	iOryAJ9o1uWUq7E3uINPBn0MVsq4eTG2apKsiBlDjF+dnS4gEnTwbO5k2XXMn8En6uu+GoTtdEu
	9ZBgHtCInr/ykskJzbQlr4PAfN6YGxXHWB6iSgMD0OZBQXcmFWH3Y=
X-Received: by 2002:a05:600c:3b0c:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-48526918944mr246294685e9.6.1773135196368;
        Tue, 10 Mar 2026 02:33:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f17a0609sm2063239a91.14.2026.03.10.02.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:33:15 -0700 (PDT)
Message-ID: <4e697f30-1057-451c-9238-5ea748dd3236@suse.com>
Date: Tue, 10 Mar 2026 20:03:06 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reloc: unlink orphan reloc roots before dropping
 them
To: ZhengYuan Huang <gality369@gmail.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com,
 zzzccc427@gmail.com, stable@vger.kernel.org
References: <20260310075447.2088205-1-gality369@gmail.com>
 <19e81a86-a8ce-42df-8cf7-da74205584ce@suse.com>
 <CAOmEq9Umi=3AA+0DkmHrfFjj2hBnkq4xGSFdfS40x5F7DpEtuw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <CAOmEq9Umi=3AA+0DkmHrfFjj2hBnkq4xGSFdfS40x5F7DpEtuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03DEA248BA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,fb.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-223842-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action



在 2026/3/10 19:11, ZhengYuan Huang 写道:
> On Tue, Mar 10, 2026 at 4:13 PM Qu Wenruo <wqu@suse.com> wrote:
>>>   [...]
>>
>> Put this important info into changelog, and this is not the first time I
>> or other reviewing asking you to do it.
> 
> Thanks a lot for the detailed review and for being patient with my patch
> submissions. I'm still learning the kernel patch submission style,
> especially how much detail should go into the changelog above the "---" line
> versus what should stay below it.
> 
> I think part of my confusion comes from seeing many patches with very concise
> changelogs, so I have been trying to keep that part short, but I may
> have overdone it and moved too much useful information below the separator.

If you know the bug/cause/fix well, and pretty sure it will not affect 
most users, sure short changelogs are good as long as you explained it well.

But if you already hit a KASAN/crash, paste the info itself will help 
explaing the situation well enough, and such calltrace will help a lot 
in the future for the following cases:

- The end user who hits a crash with similar call trace
   Who want to know if it's already fix or some one else hits the same
   problem.
   If the call trace is included, one can determine if it's the same thus
   if it's already fixed in the latest kernel.

- The engineer who is responsible for backporting
   Such call trace will help him/her to determine if it's needed for
   backport.

   A KASAN report/crash with call trace will definitely be more obvious.


> 
>  From your feedback, my understanding is that the changelog should include
> the essential root cause, the fix rationale, and the key crash symptom
> (for example
> a concise KASAN summary), while the material below "---" should be limited to
> supplementary information such as full reproduction details or longer
> logs. Is that
> the right interpretation?

Yes.

> 
> If there is a patch or changelog example that you think is a good reference
> for this style, I would really appreciate it. I'd like to study it carefully
> and improve how I write future submissions.

I just grabbed one from Johannes:

https://lore.kernel.org/linux-btrfs/20260224125113.14831-1-johannes.thumshirn@wdc.com/

And from Filipe:

https://lore.kernel.org/linux-btrfs/b99cee6ce652b926463a080ef052a2e8e37bff33.1772105193.git.fdmanana@suse.com/

And myself, which is more aligned to your style:

https://lore.kernel.org/linux-btrfs/4170e39bac4a2559ad0535f9bd74a89bc44a36d4.1771488629.git.wqu@suse.com/

Thanks,
Qu

> 
> Thanks again for the guidance.
> 
> Thanks,
> ZhengYuan Huang


