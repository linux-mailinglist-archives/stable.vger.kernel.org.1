Return-Path: <stable+bounces-151303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCB7ACD996
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 10:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF3918953CF
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 08:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D652E28C2CA;
	Wed,  4 Jun 2025 08:19:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD428C2C2;
	Wed,  4 Jun 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025190; cv=none; b=L4BGWXaERzRWPmScJgqvNOIqPmZw0qF1pdGVldIodUx1fT7cc+/Z+TLh0j+K7CC1pLZi0/GQWY8LSBAGVLrzOGIRekSUeHiQsH1ERAr5uYNOS15hEh2Fdl2+/Yai0qX4ENMmVG6AnR/Tci2FSKEDsoWqO26ex3X3gSFxGERnPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025190; c=relaxed/simple;
	bh=bQ84DRDUGM/vrrvXX6yLgAEmZ08XaYJyEV3UqK7L0rc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CIzLyFv88f7F9iM3lFK4WYiRcq9qUExYVRHn1B9QVxwh/A+LSvdP8Ve6z2wI2VIoLmV9TbsxcfNcpEXV+2e+jzW2n2y38FwsCJfCf97gS36CCjenyOt82Q1Ioe5wtbMIxzDJa9rKCbd+2515CnylJ5UMz7FLxiWYUQ7moBoVslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad51ba0af48so128060466b.0;
        Wed, 04 Jun 2025 01:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025187; x=1749629987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfVmh22uH/XY6fu0DSGOy+Uf3o1rAERV70DDOSVnSfM=;
        b=TYJyUJGAEto3YxxcgOlD+2EOp+MToNu+BTXoWRhunu1vZ4VlFcNe9XdUr4boLvW6Q4
         sUmurRLaFShUKVzAlGUyiFsOkXF9hRG8HkrwbyH56t6F4mloTV+g0mc1hsmHf2pOGQIL
         l897KrWgROLyt/kVdBPlz0U0Vpzud1PAE48s5aXckxw4v0+PLCuHfhrUMy+G4UNJsQiX
         Cmj8H26mqJT33+C5WoMEkqw4jf3zyOoyi3jNou4rlVJfG9arwHencpgRix058dUK2rFZ
         jCh+/JBoMwLbzAynL5mdvYWLQoe3o6KaMkQ44FA2tnUqW5aiXNf6UXxZABMtNHSCpvdo
         fSbg==
X-Forwarded-Encrypted: i=1; AJvYcCUnf7qMgLUW+rScYMdCoxus6zsciZW/7g8c1dr5WCkNFxv8YMKEtdgu4GvHFC2HSuQEhUO8oCc=@vger.kernel.org, AJvYcCXleCe19/D1JNvklNBlCXZIPbwSSXKPs0UqoI3tTE1eiZf1Eq6keaezfWz2h3osyycbWsFFhprR@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTTjE/J+BQ1MBKToz5BBEqcQSb9H0Dh/LFYoPMVu/ZY8U8Zro
	R+Vzu7hFOjhd0QD0zLeGjVOvd/ItwKDzhHMc+tvZ6PlLL4X1sPUgivLk
X-Gm-Gg: ASbGncvPpBe3Jk+WWWq9iaoAYGXtd9WfoZRglOLka/wWHm1P9dQ0oaKLSs4dRCPL2rJ
	QjUZaVLi6Iv/jLqOirl2WxYjazna1OR5fIcURxLf7H/bL4NgPXBBSKMLzj5r2Kyfo3vw0WJnFzp
	1jQ8StkJf4/bZDtZzh1x7LDR5t/+FKk/B2aOwrb3FGJBauFtMyJtbZ306Os9J9Ra0JYmxOirR+h
	MO1yPXomkgiC15KkkccT4d1qU7zlrbZhkXdIz5AoDy9whNVAl3/Kx7R3kbv2Oxft7gcSq3xbmw5
	quH/beai5y6mDsazZKxk68nu9HnL6z2HAHFc1bbZTvhWg0fSL0iQlgzT+RGERl54z4TYDLjPU6z
	NbGjLpnM=
X-Google-Smtp-Source: AGHT+IGN3HuQKjDfNVbbLBxgr9tEQkbEtev931mQhDwMH68L54z6vS4HwKR1dgmRBxaH1xXJp8ilCw==
X-Received: by 2002:a17:907:7ba7:b0:ad8:5850:7332 with SMTP id a640c23a62f3a-addf6ea12abmr173934666b.9.1749025186577;
        Wed, 04 Jun 2025 01:19:46 -0700 (PDT)
Received: from [192.168.88.252] (78-80-16-19.customers.tmcz.cz. [78.80.16.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82de8fsm1080057066b.66.2025.06.04.01.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 01:19:46 -0700 (PDT)
Message-ID: <7bc258ad-3f65-4d6e-a9f5-840a6c174d90@ovn.org>
Date: Wed, 4 Jun 2025 10:19:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Sasha Levin <sashal@kernel.org>,
 patches@lists.linux.dev, stable@vger.kernel.org,
 Eelco Chaudron <echaudro@redhat.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, aconole@redhat.com,
 netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH AUTOSEL 6.15 044/118] openvswitch: Stricter validation for
 the userspace action
To: Greg KH <greg@kroah.com>
References: <20250604005049.4147522-1-sashal@kernel.org>
 <20250604005049.4147522-44-sashal@kernel.org>
 <38ef1815-5bc1-4391-b487-05a18e84c94e@ovn.org>
 <2025060449-arena-exceeding-a090@gregkh>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <2025060449-arena-exceeding-a090@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 10:03 AM, Greg KH wrote:
> On Wed, Jun 04, 2025 at 09:57:20AM +0200, Ilya Maximets wrote:
>> On 6/4/25 2:49 AM, Sasha Levin wrote:
>>> From: Eelco Chaudron <echaudro@redhat.com>
>>>
>>> [ Upstream commit 88906f55954131ed2d3974e044b7fb48129b86ae ]
>>>
>>> This change enhances the robustness of validate_userspace() by ensuring
>>> that all Netlink attributes are fully contained within the parent
>>> attribute. The previous use of nla_parse_nested_deprecated() could
>>> silently skip trailing or malformed attributes, as it stops parsing at
>>> the first invalid entry.
>>>
>>> By switching to nla_parse_deprecated_strict(), we make sure only fully
>>> validated attributes are copied for later use.
>>>
>>> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>> Acked-by: Ilya Maximets <i.maximets@ovn.org>
>>> Link: https://patch.msgid.link/67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com
>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>
>>> **YES** This commit should be backported to stable kernel trees. ##
>>> Analysis **Commit Overview:** The commit changes `validate_userspace()`
>>> function in `net/openvswitch/flow_netlink.c` by replacing
>>> `nla_parse_nested_deprecated()` with `nla_parse_deprecated_strict()` to
>>> ensure stricter validation of Netlink attributes for the userspace
>>> action. **Specific Code Changes:** The key change is on lines 3052-3054:
>>> ```c // Before: error = nla_parse_nested_deprecated(a,
>>> OVS_USERSPACE_ATTR_MAX, attr, userspace_policy, NULL); // After: error =
>>> nla_parse_deprecated_strict(a, OVS_USERSPACE_ATTR_MAX, nla_data(attr),
>>> nla_len(attr), userspace_policy, NULL); ``` **Why This Should Be
>>> Backported:** 1. **Security Enhancement:** This commit addresses a
>>> parsing vulnerability where malformed attributes could be silently
>>> ignored. The original `nla_parse_nested_deprecated()` stops parsing at
>>> the first invalid entry, potentially allowing trailing malformed data to
>>> bypass validation. 2. **Robustness Fix:** The change ensures all netlink
>>> attributes are fully contained within the parent attribute bounds,
>>> preventing potential buffer over-reads or under-reads that could lead to
>>> security issues. 3. **Pattern Consistency:** Looking at the git blame
>>> output (lines 3085-3087), we can see that
>>> `nla_parse_deprecated_strict()` was already introduced in 2019 by commit
>>> 8cb081746c031 and is used elsewhere in the same file for similar
>>> validation (e.g., `validate_and_copy_check_pkt_len()` function). 4.
>>> **Low Risk:** This is a small, contained change that only affects input
>>> validation - it doesn't change functionality or introduce new features.
>>> The change is defensive and follows existing patterns in the codebase.
>>> 5. **Similar Precedent:** This commit is very similar to the validated
>>> "Similar Commit #2" which was marked for backporting (status: YES). That
>>> commit also dealt with netlink attribute validation safety in
>>> openvswitch (`validate_set()` function) and was considered suitable for
>>> stable trees. 6. **Critical Subsystem:** Open vSwitch is a critical
>>> networking component used in virtualization and container environments.
>>> Input validation issues in this subsystem could potentially be exploited
>>> for privilege escalation or denial of service. 7. **Clear Intent:** The
>>> commit message explicitly states this "enhances robustness" and ensures
>>> "only fully validated attributes are copied for later use," indicating
>>> this is a defensive security improvement. **Risk Assessment:** - Very
>>> low regression risk - No API changes - Only affects error handling paths
>>> - Follows established validation patterns in the same codebase This
>>> commit fits perfectly into the stable tree criteria: it's an important
>>> security/robustness fix, has minimal risk of regression, is well-
>>> contained, and addresses a clear validation vulnerability in a critical
>>> kernel subsystem.
>>
>> This change is one of two patches created for userspace action.  With an
>> intentional split - one for net and one for net-next  First one was the
>> actual fix that addressed a real bug:
>>   6beb6835c1fb ("openvswitch: Fix unsafe attribute parsing in output_userspace()")
>>   https://lore.kernel.org/netdev/0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com/
>>
>> This second change (this patch) was intended for -next only as it doesn't
>> fix any real issue, but affects uAPI, and so should NOT be backported.
> 
> Why would you break the user api in a newer kernel?  That feels wrong,
> as any change should be able to be backported without any problems.
> 
> If this is a userspace break, why isn't it reverted?

It doesn't break existing userspace that we know of.  However, it does make
the parsing of messages from userspace a bit more strict, and some messages
that would've worked fine before (e.g. having extra unrecognized attributes)
will no longer work.  There is no reason for userspace to ever rely on such
behavior, but AFAICT, historically, different parts of kernel networking
(e.g. tc-flower) introduced similar changes (making netlink stricter) on
net-next without backporting them.  Maybe Jakub can comment on that.

All in all, I do not expect any existing applications to break, but it seems
a little strange to touch uAPI in stable trees.

Best regards, Ilya Maximets.

