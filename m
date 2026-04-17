Return-Path: <stable+bounces-238433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCbEOE3a4WkXzAAAu9opvQ
	(envelope-from <stable+bounces-238433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:59:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5A4179CE
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACAA23108C52
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D836CDF3;
	Fri, 17 Apr 2026 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AYoeXQN2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F634D922
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408977; cv=none; b=WaY9gZBGCSOjFvHkGlXgh5QUhD7S4n/SKa+6ztDZG18vTj6HqMF+QqPRhcFdI+PWvLNVPmCOgLqXyUB54LTdgyNSzTYC4Wx0cpX0YqZ7YyY3Bgw4nE3VTR5+H10vX9qRhGb6pavxEcuLvPqw8hLmAdoerxoVvoiY+ptjHrvhu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408977; c=relaxed/simple;
	bh=wDxHhAHlIyoXxfnkRr9SdUl0bEA3unu7hXdUWxP33/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+g7s8JusFfo/CEuxVIr0GiiMRJtGhlOkGiOSicuoexZy1QvVgT57Nn9ssv3QLKU5gUg/cfRkf5lI9ak2xH70FX9x/cCRRX6t7man+/gSmPIzMNQ7heh5pH7SHK/AuAiOkQ/cOPTRhsjPAW2Wkk2Yr+hmN0hP0uMspH5UlQ5utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AYoeXQN2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so2521615e9.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776408975; x=1777013775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Joo3YULEg4XAiWGz4cE4Xxni1DieVC2g4vJjbCxQH00=;
        b=AYoeXQN21qq4ocVNwmtQgqnkJ08eS+rq0LiXH/0SoJVHJT7mKu4HSwXSqXKlMP9KkQ
         pU0pAISinpMUhKiuC2wWOH43bGldYw+LfeGhoGeZMDZVeEFYPtRHcb/YSCzx52J3fY/U
         T+G/s2/MI1Eo0/fQnN89knz8tsDGHjwDTFbqY3H5nfE1OkuGZLhwuPZDnDiMXsMTJNNv
         xU2O4bQGwnzkFyhy7gM+5d6DZWhIwW4h9NdODWLKG5Y8YHZEU6alOcqNwCZUAfxww3TG
         NIfI05w1yhICr1LB/EGPwRWDAkTKrW+t1DcJ6PpmfMWn2Ge585zxOagV9MxWzftovWz6
         nINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776408975; x=1777013775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Joo3YULEg4XAiWGz4cE4Xxni1DieVC2g4vJjbCxQH00=;
        b=fBC/ylKngtZVFwrGfokm2O8CtDlFR0R6rkuMhJOrZrbyQo8xd5GTCc9I0sPGUXEPJm
         WAZWqsECrZNjANwm8Asiu2jwpVZZiQa+2UzgqPj9SHvgHZ+cGjpnQPAKTi8daP21tOuw
         BaI2MbDe0s0OU+bNdwzslXlNhMj/MJBGyqlH0MFc4+l4WRoiEwly6xu1VWrJLfmXx/su
         A0OAoI/uTy7i6WSA4K3boRC8ilyHE7vMPjZytfGjidqWOGB3ptHr0481RL2jMPBJolch
         gtiH13nibdbFKSUcuyjvj1V7riICv6x7mFoIaw10rRzzoJ9GFZKCUmccFU7j596+NZF0
         Wxmw==
X-Forwarded-Encrypted: i=1; AFNElJ/AQofI69W68ve6hKhWmgvH7twC5ocTbENS3s3BqFZgzF5FVvk7OFLQ1Q2QG9CxdUEuKFKVzek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2HFGCiE10o1qd/m+/Oe1xSMuSpq2hbYVfDmbbtTjWVxvABtG
	MzNl2XuF1z2+6ivdVTGeXpgV8GlPqai888OYYSWpDmY0P85bi3mTGJi7F9R4j3xStVs=
X-Gm-Gg: AeBDieu3/z/fWtTK2tce9VANpEbdNoUDUMdE/k4ZKCYqSNdhTJhDxBWHNymeWF87gRf
	Kn5PNfthjkXRUmV2ux6HEnn7UJ85brRnLDsXtlS1RPEoeH8RWz7irVUNaEOOOrSs2S8lo6FiKbi
	RdhgJeAoxELs8qgmBbE9um3UYAxEQqdWc4w5dio3S7I+AK6iwcCQ/AjvBAPm499wY9CDi9gNr+4
	srovNJi6VHiykqMs307nbUik2jM+aALqfi7yUCxOl6QyBKMVFBsyVyxZxCIQ4adFJH2VREyRc7R
	jxgvUsOQZokgMud7ILnjYaMme9JoqfYEhrAFhXNKvV05cApDzXxFW8Q/POfscNb2pi02TAuUu0I
	gEn40Vce/knnLg/Q4Y3rDXzLISvmRCnY4m48p28M8hEVzHkP6se+o7L08Vp6Lk9c2kveb0qjQMS
	BuQCn+bHvEL1LHbjnlJAlUEUdd7JKBzClY7tle0izjhXMGrXoa6ZsWHyoqWT85WO5Rtkch25DLE
	yyh1AU=
X-Received: by 2002:a05:600d:8451:b0:487:20ee:bef6 with SMTP id 5b1f17b1804b1-488fb745684mr17367155e9.11.1776408974807;
        Thu, 16 Apr 2026 23:56:14 -0700 (PDT)
Received: from ?IPV6:2001:a61:2ae4:301:12fa:de76:8d51:fc21? ([2001:a61:2ae4:301:12fa:de76:8d51:fc21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb6dfa33sm14975665e9.0.2026.04.16.23.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 23:56:14 -0700 (PDT)
Message-ID: <5028645d-e91c-4196-b118-81fd513f5d31@suse.com>
Date: Fri, 17 Apr 2026 08:56:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [SCSI] advansys: fix host resource leak in EISA probe
 error path
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260416165935.3958686-1-lgs201920130244@gmail.com>
 <b1a6b96d-07d2-4a19-b9db-2cd8d878895c@suse.com>
 <CANUHTR_qm94JQn-FKa9BfRgxadXKbXJmJEof6ZdE070=Xi4mGw@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <CANUHTR_qm94JQn-FKa9BfRgxadXKbXJmJEof6ZdE070=Xi4mGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238433-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 91D5A4179CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 08:29, Guangshuo Li wrote:
> Hi Hannes,
> 
> Thanks for the feedback.
> 
> On Fri, 17 Apr 2026 at 13:56, Hannes Reinecke <hare@suse.com> wrote:
>>
>>
>> You must be kidding ... EISA is died over a decade ago.
>>
>> If you _really_ are concerned about this please remove EISA support
>> completely from the driver.
>>
> 
> I agree that EISA is obsolete, and I understand that this path is
> unlikely to matter on modern systems. My intent was simply to clean up
> an inconsistency I noticed while reviewing the existing error handling
> code.
> 
> If maintaining the EISA path is not worthwhile, I’m fine with dropping
> this patch. I can also take a look at what removing the EISA support
> would involve.
> 
Please, drop the patch, and rather invest time to check how to drop
EISA support. Fixing issues for code paths which are never exercised
is a bit pointless.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

