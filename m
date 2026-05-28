Return-Path: <stable+bounces-254697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHIaLVmaF2qcKwgAu9opvQ
	(envelope-from <stable+bounces-254697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 03:28:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 316CB5EB8DC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 03:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70012304A873
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 01:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35B26A08F;
	Thu, 28 May 2026 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="JFXn0udX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15743233923
	for <stable@vger.kernel.org>; Thu, 28 May 2026 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931733; cv=none; b=QL9fo60bBwHiyJF9m0oYxjB8LaavEEgllCmX7947iJEahsYbpngsy4xq30+aL2u6m4GgLqRz1HrR5TUz3ShdekwBGVHCbWG8BceVhWtCsmDguEMIGeML7kIGhHnZx0iULZ7Vfyd/xslL1VLKxT+Jm406LmVKQJyBKzdRae5yENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931733; c=relaxed/simple;
	bh=JSqiNeeN9IXBAP7IJHdz2newQgiqeppexCoOhqJ0Axg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgvvFRUOQsdWCdiJmQ6RQsWQcV0gE4mQNZ4bD55qixnwEQo5Zendd/NbcxH7sLVIX7Bit7PyCdXzxYE1raw5KXJpz5uGc84yXzPXCIlK5TG0bEQl+jkzqVDQgckjcoAAnvgBNh/LmfB/Y7jOkUpnaxsoo+c8DKHxJPTNIDXq5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=JFXn0udX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 560F03F641
	for <stable@vger.kernel.org>; Thu, 28 May 2026 01:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779931729;
	bh=UCnKVaHQJJh/ARo0G2c2/7dFzxB5grxc7vN4qZbuDYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=JFXn0udXhhfuFi7NQE4AOWzreKltw177zuWGSw9f4Se3j4EwUpZjP21389CHdCSAL
	 lFgnILX43ZKVz1XwzZBsqX4Rswto5sVnWI57fuevMTLP34xG3Y5yIU/sFB159RjKMK
	 awk61QeS4qvkJm8Q3ozNNZ4bJh88JNysvD498JL1aUTzrZhHuKC8SG7Q29frvJbcOW
	 OFdTBCKILVJUl9vF9WxIE/+HqsbtjOBdiblld1zt7TYnMANI0PH1XbuQCkgkaQ8tdj
	 1MyqBoJK6rVkHHNEpGCJ7PV2g+IoQqrAL4Y4efS1ufVFX4Ojnpz3NR7bJwOX0mereM
	 A+zhOrOSNyOUPHS72pjh+UBm6rPiIuAIpYNxqLjR2Up3yP0FY4abrFF2WxJTnkELGx
	 81naMtCnpuGGA0G1i2QrK4y5sE+HVcRR6UR60Sb0xVFciPp6WRbsYYsC1mVSxOcESh
	 fO6Yup5ex+WJnQcRQ/ArZCZdVHDR5qYbmOH7mpY4908WfW9Lfoa/E0luxRuwHE/81G
	 U7HOAELLlICwf3DFHldq/Hlcnl9DLbPjHK2USUA98HyutYB6gKcEC2ZqssApw9Pruq
	 TGL7r22aVnpp3PDhc2zdJhM5dAdERZnZU3DLKkiU5g69ObTKzXqo2i8lqGOpca5wmV
	 bjqKz1JAp7SrglBW7G8fGSWI=
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8561bfbb16so129329a12.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 18:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779931727; x=1780536527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCnKVaHQJJh/ARo0G2c2/7dFzxB5grxc7vN4qZbuDYc=;
        b=hl7fUitu69RVSkXw43mdOgQQ7LaCg8fYrjm2Wxrkyh+KgoqJniDeUT9DzICjQJuSnm
         awFK8l3owxJ2EvO5hH+hDX59TlTdaUSGww8TkUfxUpo/C6XCV6kDDY9UcFPpX13PS8GG
         SbiXMJg/DjH2u8qGHhilh1EIVdrE/zqyCUgAOHjNo/ZxxuCGf+LX0L9khxLCQihXEqqN
         u6Pjybf3HjHWusLpMh50JfGrJIKpk49HEt4yvZS9Ifxkuc+35xVHn7BQrj1ioXN/HdjO
         /UmNeGZwddzTPhAFYkQ//0QaBRMoMt5cxKLA4l50A3tWu4rme/hq+63fKghivYBbM0px
         6h1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+RQbFnpqxWSeRvD+pBsl3xchP1g+ww+bNd2/kZ0W3IqBJVia+V78jGiT1wd5uQOm0VG8RVSD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwGvoWOgc0FbcmUnfd6JLmMS+SWqnsuW1Gn4HIyOyD8VwcGSsC
	hk6Ygql6LMrIFljzr1WQ2izVD3NSWcmP7Y+QFmitTh9rN1+8AvpKORoYw5Adk6jANxIbIxYtylO
	/UeTp610n6Sup3Ba4s5DwcH/aEDLIhADhvmCXmfK+P026zZL51vYpg0yKF7SQv65czjcMdiZQng
	==
X-Gm-Gg: Acq92OEyGFbpraUdokVE91TxsSTLUqmi98uED3HfxPTuZBXo3oRVRM32J4IuqCIqsAf
	NQEbBXZXuDj2++hPNBnBUBGFNSIcH4reqiFoeP4SLfOQMblxBRbhqIDJM9dCrXs3BOQe9dopPn2
	tLM2bjN6syaTs70iYHGXXeW4ntVkLIAI57ILcYFxI7KrHbFyohuotms3trpH2ebxTNYs0EDZuIS
	h+phTnWOuBcyCWpuagDYNULAtnfNUZgrGJzNMkUJyte/r/YUwO9P+kqmK8Gs0xXUyUz5c05R6yN
	0QXoiV0j5hb04xxD8Qj70R9scJWvGktMS5yDNj55N8WiS/WWjAVuWg25VwisdFv12yQEYk5zpVR
	2i0Qdk6YmHaYj3k8xwDQ0jR+W24x9XHaG2SYRZqby0C6z5KOY9K4bUc2Yaux1oMUUhd85OeEkgA
	yUeSz0kDRiNRk=
X-Received: by 2002:a05:6a00:bc8d:b0:838:127d:a16a with SMTP id d2e1a72fcca58-8415f331df4mr24709800b3a.19.1779931727431;
        Wed, 27 May 2026 18:28:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc8d:b0:838:127d:a16a with SMTP id d2e1a72fcca58-8415f331df4mr24709778b3a.19.1779931726966;
        Wed, 27 May 2026 18:28:46 -0700 (PDT)
Received: from ?IPV6:2409:8a00:48c4:9120:7fb6:5466:f3e6:e2bd? ([2409:8a00:48c4:9120:7fb6:5466:f3e6:e2bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eae727sm4437404b3a.19.2026.05.27.18.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 18:28:46 -0700 (PDT)
Message-ID: <44661430-2daf-42bb-8a83-eb8607f8df25@canonical.com>
Date: Thu, 28 May 2026 09:28:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: kgdb: Fix a missing irq restore issue on an
 early-return path
To: Paul Walmsley <pjw@kernel.org>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, vincent.chen@sifive.com,
 stable@vger.kernel.org
References: <20260526113829.115007-1-hui.wang@canonical.com>
 <994d9b89-b1d9-e642-0ef0-66a8cad538d5@kernel.org>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <994d9b89-b1d9-e642-0ef0-66a8cad538d5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254697-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.wang@canonical.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,canonical.com:mid,canonical.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 316CB5EB8DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 08:20, Paul Walmsley wrote:
> Hi,
>
> On Tue, 26 May 2026, Hui Wang wrote:
>
>> If kgdb_handle_exception() fails, the local_irq_restore() is not
>> called and the function returns to the caller with interrupts still
>> disabled. To fix it, add the missing irq restore here.
>>
>> Fixes: fe89bd2be866 ("riscv: Add KGDB support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> Was this found using an LLM or some other static analysis tool?  If so,
> please add an Assisted-by: tag, according to the directions documented
> here:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n637
>
> and here:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-assistants.rst

Thanks for the reminder. This was found by myself, not by AI or other 
static analysis tool.

Thanks,

Hui.

>
> - Paul
>
>
>

