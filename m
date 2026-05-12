Return-Path: <stable+bounces-245433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIOHEzT2AmqvzAEAu9opvQ
	(envelope-from <stable+bounces-245433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:43:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02C51DF9F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA2103031336
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C6480345;
	Tue, 12 May 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR3Gk2KQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606A39E175
	for <stable@vger.kernel.org>; Tue, 12 May 2026 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578665; cv=none; b=bCY+Vvk68/4lh85K9Fs0nyFmvsIgPy5GX/8+iMiG0PpEo9nGhb0eUN/p1PsUlY6REfhV0nOFKjexCtXgRdBkVU4CiFtY1QgM5h1qHOq8a3smqY5+D61+EeXWuXEvcg9dRKQAUqYaN4B7hm4ybbH2uV3jui7xUp2TcZNx+GtrBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578665; c=relaxed/simple;
	bh=SAbFbAxhM4r1Wa7+KTHFhNb0x4H3P69DT4qmPHd3Vfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zc8Mirp4fcKjbwlsFJEA4FnnhU01sZ6AHdaVwsEgRKeHREkjMJC/5M/tv+0LvtVN5xLFdjKvZPCrXmjUbESIL3D3SYiRneMccBopTsXOM31B+4FrjlIe2vVrIo6GxGakD+TmTosa+T7yd1LqUASNCuwc/TMFGnRQeX9N+tTCKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR3Gk2KQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso48562335e9.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578661; x=1779183461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4D3PparkJF/1QcwiWv94EJLc0/A78G5Dvf9A+oS11+Y=;
        b=AR3Gk2KQuPxfhiVlTUydGl0+4UeJ/NLAEpxmAmBL9RknvFmAUBupwvQ9oRYn5In8ft
         eupDzwCyXZ7NVCqGkkO4lSdCMW6mXQP7KQH4LO3kEvJTdpJBKDrv2enfUGNP22hj4M8j
         xZOLglhG7rkJMFvkcciTR96wdKUtKGYUWw+SQQpp8XVy3xFMUxaw36LhVF8ln1DgSKeg
         xjsxuaEzyTkc4ojjILi5YwkP+wS5Je1+HVhP5GVv8WxcZQdY6DC8FZ7/yev4pSc2mcmd
         tEW1i+SBikuHW2GICxn0ASGLnjVXBZaatrbpxihz4E4S4Qufr2tcijyAiTEYmxV6Q0TV
         HJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578661; x=1779183461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4D3PparkJF/1QcwiWv94EJLc0/A78G5Dvf9A+oS11+Y=;
        b=hfQ9STJuIeJR8pci5YCjpZaXP0wFTZQ9drZ0AhtdYn5tg5SHJ1j3rDw2DL7kWakVxE
         9p8ORklHUA7dC19G1e7ZO4Mc4U26Z5xIkkadftXWWoWu8SlPBNIMkOMt42LCuTgxiC2k
         JXF7Pcbdniwkfd5I+h//YRysdz0iYxVPoad4AT++zLu1LTQzo+hmszp+gdVlVDrKr4jM
         RVTaV0KRfDyYnYCBiFobFU1ONxH6crNBi11UiN9MY6lxkQTNpwJFfpoOITawmVMkjKh1
         Eu57Am9Y1CSqYok7lp+NCm93vn6I0N0G7edkKDheEvEfnRtzWmGB/2UvEIryFh+k5rmT
         GK7w==
X-Forwarded-Encrypted: i=1; AFNElJ/rYU72r7ZF0AQFYfvwOYtmNZxhM5oxOwBUijA0nh2XvEunffmbxu+lbJWgltj5GCdEvKwaQM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlGBwRf9XWlW6/QCbyUet+cNngCKrX4AU4EmjDp7DATSve3HT
	s521g1tCxdlD6UzQzCNSI7MeNcZWACGAjc/FtsCFZSnj1P5N5mBZTlYT
X-Gm-Gg: Acq92OHH3raWm0lowVoWvcHQxqK0y/n69MAY379XmSoWIO94631Ic3U0P3sKgyxl9b0
	6ITrKQhEFdcl+eDz9jNoYcjSckFk8mjSexmLxw0tJgwyd1xmRduYPz8sLhrkjv/SxT3K85H9chr
	YtQUJpQBmZhEv6FKPntwQJ2JyuxrlljZtfBpoAEhVQLlCKZ3DqQij457AVtvrihEbS4YLgGGDKN
	mf6baPKgJZtIsRVa1WhZYQHLto1r082O+g7NMi/EekNSg7bCfnmD7lzUpzbmSPx6D+X+gZ6UOPQ
	DI7pqCnJ3z1Es4wEEvPFUTAepT9FrYpzyUkXtjDXUjt1GvNRQRYIAoH8fUXL8suEQQ4aDWiix0u
	wcZ2ZP5QEbXi43FVSGp22rKtIOnAHYs9w6ICdwp+8HfQ+Vq33zsSd963u+oTz8220BYerT3PonC
	HR5mAq4RigEsQGUSCu/Nv8gAdVO5NqHKrr+prI8KGLXZx0Mg2Dtmub73X1/WehjGeYtZIAIIgCt
	80TA5MQuCmCXd0NSbEoeW23pf0Q/u1652aegRc=
X-Received: by 2002:a05:600c:5296:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48e706932d5mr197488255e9.11.1778578661525;
        Tue, 12 May 2026 02:37:41 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906a06d1sm35932315e9.1.2026.05.12.02.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:37:40 -0700 (PDT)
Message-ID: <ca57936a-4ac3-4c58-89a9-2a768401839f@gmail.com>
Date: Tue, 12 May 2026 10:37:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0.y,6.18.y 0/2] Backport io_uring commit to affected
To: Jens Axboe <axboe@kernel.dk>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org
References: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
 <5fed66f0-ea72-4f36-bf50-2d7c39c4fdeb@kernel.dk>
 <12c809f5-1326-4cd3-9d4d-2bfb011b23e4@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <12c809f5-1326-4cd3-9d4d-2bfb011b23e4@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AC02C51DF9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245433-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 23:46, Jens Axboe wrote:
> On 5/7/26 4:41 PM, Jens Axboe wrote:
>> On 5/7/26 6:42 AM, Harshit Mogalapalli wrote:
>>> Hi Jens and stable maintainers,
>>>
>>> The intent of this series is to backport commit: 770594e78c39
>>> ("io_uring/zcrx: warn on freelist violations") to 6.18.y and 7.0.y.
>>>
>>> This above commit likely is fixing commit: 34a3e60821ab ("io_uring/zcrx:
>>> implement zerocopy receive pp memory provider") in 6.18.y and 7.0.y.
>>>
>>> Pulled in a prerequisite to cleanly apply the fix. Only build tested.
>>
>> I don't think these are actually required, but at the same time it does
>> not hurt to add them. I'll leave that to Pavel to decide.
>>
>> In any case, thanks for doing the backports!
> 
> Adding Pavel, I had assumed he was already on the email, as he's the
> maintainer for that file.

Looks good to apply to stable as a hardening measure, thanks

-- 
Pavel Begunkov


