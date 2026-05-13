Return-Path: <stable+bounces-246761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFVpN0EcBGpyEAIAu9opvQ
	(envelope-from <stable+bounces-246761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:37:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D20F252E268
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C7AD3016B03
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15133D45E6;
	Wed, 13 May 2026 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFyIgCRY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A143D45D4
	for <stable@vger.kernel.org>; Wed, 13 May 2026 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654258; cv=none; b=ruuPdjD6nZBa409+oDLiKINReogKqAV+fflbOEeAVBPaGftVVrVkNCHDMY/hxQA6Hrj0WqD4MBbhaAgGqAsk6cHhU+cVWf2/EXKFLtZ406Iqr56A7CAA8e/crduyTYfjy50QbwSYmqp5KAwId3qn9kUeX+8fZvQIClSuxx+Rr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654258; c=relaxed/simple;
	bh=23nRyB6EeCiLbuphx27oCth+e7CyIUQIhmUlPJEO9V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdkIHswQDoHGk5Dtep2toQQclp90j6wGC+qTe1ivhCUq5yE1zOGFmwqu1mSmJH85WuhgtvMmnhTf9y7q/Cep99JV1FSbHc1rur2O2X94KY+BQss2f49J/U98Togwb1qd8uaTJzYBKbuUscD/3QJ5dNUDtU/sInaxhbvcjbkzjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFyIgCRY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-366070f71adso5750850a91.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 23:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778654256; x=1779259056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZA44Oj1Ru1vNN5fRaQe05rAsggrRQftNF5X+ITnNbuA=;
        b=OFyIgCRYl4Pjbu+RlG2rZJ72tuMJqa6zBvOo1TKoOY6Ofm9/8EFPoSLVmzVV5eva6h
         7PbsPx/S+CE5LnTDAF1dvTF7RsthMupRkI3X93RXfA8ViWx5KJPQqmgZMELk6RlgD7t4
         XBtUgaoIey/A27aYX1Xo9/9EfzoKpsCXpmYcV7pEb81JQ2S5BwyVRQojxlLLvPnb/aKg
         8C7pwAV6NjquOnIHYZN0NxVUwuM7a8SRn/Hqh5HZwx3amMyPAOQtgZMuAJKNeWciyFPZ
         R1/Zn7IyNXvqsVBJCtj2MKPoj3/k62JWO8QjRa3/OL1PPoJ+mM3TqJfU6+/lHtJt5tF2
         rwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778654256; x=1779259056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZA44Oj1Ru1vNN5fRaQe05rAsggrRQftNF5X+ITnNbuA=;
        b=YMcwILVN0gY8ajD3DouDRFu/KxAVDX0pAdUKKRwjXG5ZLUoXJ4dSiAY66eCx3HRouw
         HDZrCSaiDwiD1u9u/XagHXXyKVSVJPiPS6AOuf2gwd/JMG1RUwa3Z6azEkYVOcvkL+gk
         2KH98AYhWqyek+np75sfZ4HXMTO1Cp7vbpD7YBdnDm+dlHeeJpDON4kZNDoWplEGZN+E
         +1Y2nmI+fvf9ntGbxSLgSh18YH9cuZXlGB+hjI4Fz79b4MH6YbQ7NIftqGLiQ3FIQB5A
         8uK0cB79PPU7IRxs7YaPzCgURsLKGDMDQo/SeQXIRLjH2n5HTI+gZuGkbLh0SoZyiq4T
         X1tA==
X-Forwarded-Encrypted: i=1; AFNElJ9MewN4GgY482IynwysAIVyx1cw3PEFzhXcxkzXrpupwy2Dwj2BSdID7dTynfTVhoMXoAVHHBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXQWYTk7U9shAKGleB6IiUJR41OyqHikvUeSD5Fkp9dG5CCZC
	RuUaZP8kN28xWvqu6BoCsiczJo/xaSwnJ66yOXWzs3FO5r4LYLx8hOyD
X-Gm-Gg: Acq92OHFvujK8mV1+SyvxKO0fjofCOhBSI6Y/nia5x+kXUgBpDCYL7uJ7YrNXo6N01c
	d0vK4Q+G36MKwInvLtv2DWatIQUYEbSWKHvHo26UOvWxtF3QXxX9axefuohxRyxrhJ9lDpp+1Z5
	JKHg36A9ZZHPw1HAP8JCosIvNRIa9ay3lvv0w3bA1pwHawd2lUuOVkE2mynrb7vVS/l5kMLM5g1
	QjS8RIFeZakKRvAKyPxUFwc/LmePjCMKOVKhby6D8Dxk0sk+mkuWSKKrxsNxIDXwLLgVmwKLzzU
	qP3MHAhDBByRSTa86P7Nepf7Zs/mo3INI+8fqqAlOnbU6gs7nKBtrjBMg8Nfvd13lmvrn717lku
	urajI2KZFgGS0MlLDpEXg/BAo5l82Ik6kOQV+CRZ38uM/0TJvGjDVGd6Lwx4YvvCL3aIChkCS7g
	JDwriGuAY2ss8/3RTbgkN0Z/bGGI6K7lgBjblzFz/W1jgtTae8tEWLWAOweXk/ilqcI/lsAfTS/
	AErNr3m2/9S1PRihDUVCu7/xUleKHTm
X-Received: by 2002:a17:903:bcb:b0:2b9:cd2d:6f14 with SMTP id d9443c01a7336-2bd2f4f740fmr12353835ad.2.1778654256516;
        Tue, 12 May 2026 23:37:36 -0700 (PDT)
Received: from ?IPV6:2401:4900:883a:c989:e9ef:3e82:226d:3f46? ([2401:4900:883a:c989:e9ef:3e82:226d:3f46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebea72sm159054275ad.77.2026.05.12.23.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 23:37:36 -0700 (PDT)
Message-ID: <369f39de-e013-4b60-9b24-831a72af4ff6@gmail.com>
Date: Wed, 13 May 2026 12:07:30 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y v2 00/18] Backport fixes for -Wdiscarded-qualifiers
 and -Wnonnull with newer glibc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: acme@kernel.org, linux@treblig.org, mikhail.v.gavrilov@gmail.com,
 stable@vger.kernel.org
References: <20260511071051.537859-1-yesshedi@gmail.com>
 <2026051124-wildlife-entrust-5690@gregkh>
Content-Language: en-US
From: Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <2026051124-wildlife-entrust-5690@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D20F252E268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246761-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,treblig.org,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 11/05/26 13:46, Greg KH wrote:
> On Mon, May 11, 2026 at 12:40:33PM +0530, Shreenidhi Shedi wrote:
>> Hi all,
>>
>> This patch series backports a number of patches from master to 6.1.y
>> to fix `-Wdiscarded-qualifiers` and `-Wnonnull` build issues with
>> newer glibc versions.
>>
>> I will port these changes to other stable trees once this gets reviewed.
> 
> You need to do this first for newer kernel trees, and only if they are
> accepted there, should you do this for older ones as you do not want to
> have regressions moving to newer kernels, right?
> 
> But first, why do this at all?  You should always be using the latest
> kernel version of perf on older kernels, especially if you are updating
> glibc.
> 
> And if you update glibc, WHY ARE YOU NOT UPDATING YOUR KERNEL?
> 
> Why would you be using an old kernel tree like this?  That's very odd,
> please do not do that.
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thanks for the response. We have our own distro with 6.1.y kernel and we 
are trying to upgrade glibc to 2.43. As 6.1.y is well within support 
period I thought it would be good to keep it working with glibc-2.43 as 
these are harmless fixes and would help many (if someone is building 
6.1.y tree in Fedora rawhide for example).

Updating kernel to latest LTS is not feasible for us at the moment.

I will send a patch series to newer LTS releases soon. Thanks for the 
advice.

-- 
Shedi

