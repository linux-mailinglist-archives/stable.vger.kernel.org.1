Return-Path: <stable+bounces-92785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0BF9C58D8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 14:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C62B32577
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F81F7787;
	Tue, 12 Nov 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tKgqABPx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C17C84D2B;
	Tue, 12 Nov 2024 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414122; cv=none; b=V0S+u/hK5iyjctFxAiXov843kChkam/Ez/yJgkmWOd5i+mw5ISQgs5xNC7q4PbAtScpcLi2+zJ1d2pwn4qCr7mxK5ue3lm7Z8dVoxO670Y6RObPag+/s4T2en46man08v073um7jrCoABUPfrwzkbISCyKHk3B3NMWqrn5Ossyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414122; c=relaxed/simple;
	bh=xlgvVpjsX5/+oAlaCA5cgt8YhtNFrJrCQ7rl3I/yTjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVsEvCHRUbuN1HgNdwSMFpiE/zACopTl7ql6ISgXhywGnksTyo1CM2WB1IVUkGxEm28LlEjoZe611JGYUnATWIAKEkPenrTb9QUXkMZAsiQotAEEfWMv5dJTG7owqB0E3UaFf8lhOWbQWIKKyrXqHhEqzNjRNnRkkImtqmjvJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tKgqABPx; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.1.174] (82-65-169-98.subs.proxad.net [82.65.169.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D489E40277;
	Tue, 12 Nov 2024 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731414118;
	bh=BePidp//2SC1rtIUXxhuJ8vtRas+5ftGdYKc1AmunRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=tKgqABPxGWQPOgdshhkGyOjaAhVWg0P0m9NOozau9JR9rGm98TAozA7y3BlFOlzs9
	 4iHkiOTnN04p9xi+Sc9CiLnNn0JrWhAItF8iE3VcPQeto8JDSXB4yC0r18KSZSPv5R
	 MHZFYQx9Sp5GSWdIVBJ0aRPfTZI3dmErH0LZKknHrrZB0hVvZp5AjihetzvnrDLHX8
	 Dzx2Dhd+Eg1JYetmaV4ff+trm2il0qvPwzD3fGohemasLD8JR787PvMWjGdSzP1ZEj
	 tiTN6+LY0X2y8TMZAO1OqTqLHcY/L21N4LdJEfsH9z1kkWRgNsHsMvRw6oTBRVvAS5
	 xs6ZDTdvdvpJQ==
Message-ID: <32e68c66-86e9-483e-a53e-3a7bab5ed387@canonical.com>
Date: Tue, 12 Nov 2024 13:21:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ufs: ufs_sb_private_info: remove unused s_{2,3}apb
 fields
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <20241112120304.32452-1-agathe.porte@canonical.com>
 <20241112120304.32452-2-agathe.porte@canonical.com>
 <2024111251-buggy-scarily-38dd@gregkh>
Content-Language: en-US
From: Agathe Porte <agathe.porte@canonical.com>
In-Reply-To: <2024111251-buggy-scarily-38dd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 13:12, Greg KH wrote:
> On Tue, Nov 12, 2024 at 01:01:54PM +0100, Agathe Porte wrote:
>> These two fields are populated during and stored as a "frequently used
>> value" in ufs_fill_super, but are not used afterwards in the driver.
>>
>> Moreover, one of the shifts triggers UBSAN: shift-out-of-bounds when
>> apbshift is 12 because 12 * 3 = 36 and 1 << 36 does not fit in the 32
>> bit integer used to store the value.
>>
>> Cc: stable@vger.kernel.org
>> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2087853
> As these values are not used, even if the shift goes off in the wild
> it's not needed to backport this as it's not actually causing any
> problems.  So I'd drop the cc: stable@ please.

OK, sent a v3 that drops the stable cc: 
https://lore.kernel.org/linux-kernel/20241112122000.35610-1-agathe.porte@canonical.com/T/#t


