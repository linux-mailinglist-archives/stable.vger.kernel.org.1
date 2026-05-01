Return-Path: <stable+bounces-242567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHs2B2BN9WnXKAIAu9opvQ
	(envelope-from <stable+bounces-242567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 03:03:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E1F4B08C1
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFBD30226B9
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDCB21B191;
	Sat,  2 May 2026 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm1NMIUV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79F28689B
	for <stable@vger.kernel.org>; Sat,  2 May 2026 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777683787; cv=none; b=LsxcI7LmLp9elAoyCFqEIARKGeq8V6BlaxBJn/XoEaUo16hQTEQyAOvaPnVWmV8UUakw4J7ncZul3UFzxyfymbnkCHZBnb/Y1DMvF3200w4WoZsiUGSfACqXI7fVx2w7BErrAFBJP4uCCVifxL6nbIfCfPgiwevN18hT+HDhAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777683787; c=relaxed/simple;
	bh=vAVMoN9ChhomV8WgcMM6gyYG9pZECki3XI5fEfP7NhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMXzFzOlaffAsGwzQQ9VOI7x0OS1vk/eWs3FMJrp1pfmdJVyfn74rN9XlEcuzIOYyPYr/vnksWHUIQkB334qBUTK2hbWi6XUlpt2902Eyul105vXiSWpTuC1EpYD5M/o3XFuRUUPQTSM234WDqnN3dZ6Ob/pHYG+0Nt9zg8xFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm1NMIUV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso1348083b3a.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 18:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777683785; x=1778288585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n0E83EgdT3ony/VkYAJeXhWQa6c3+LcyfrsSsEshuFA=;
        b=Lm1NMIUVY+GL2HLQcdsyK2JP1Laz9KFgw98+9BRmNaqpeM55PPmv5G2LCYoIlZeKoH
         3t48BxccXb9aidf8XfjpvAIAdnpEqlRk7FqAv1fwQf+vk3N0m0UslLvXKTURlD3uqYQU
         d8dwH1RJnXM5P6Cif5UmUrE+BDl3zq5CepjnUqRakVjGnmInQM9CPfekF4fov55WvFcr
         8Ph8aqpOBjAA/GmRN5hNpz+h+XxWF2LlWMSUHwcE0ETNHwvmjT490LCJNR3ei7LQbdoB
         PbXprAdGMHdti+uCdNdiMe5pXrEkmXKIztcs3uLi8vMv8yhGOove3iCOGC4lI3+h4ehc
         13Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777683785; x=1778288585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0E83EgdT3ony/VkYAJeXhWQa6c3+LcyfrsSsEshuFA=;
        b=d1ULoMz0Lqqse9NTEC4qy+E00Rlr+1xfZKEfBQsbmU6DhSna7MZHUqbZxyFI3TDOTE
         9OnO9/y6FT2qbspU8d0f5Cft8Vhh696V4TTDBuWmHvyrerf9O8GxL36yIIAca4Ng0XeX
         aRWEM2qlqBaDeLZ7/FATlEvYNC990rQK2we6yY/+f/HyNSb9tUITTshyfKEG6btu/PBV
         xAoPdxC4tNhMtuTtkg9sXOAxDskoNGXgb526FGHS/TYr8rgUfEhWq45PJlMLw5S922X8
         6OZhJ1tR5qDWc3gVJfMnUXba3q6JckI5a5mfkVnnUWhV6oSlRBusE7whjewlXnWoliV6
         q0qw==
X-Forwarded-Encrypted: i=1; AFNElJ+pme087ID19p0s52XQinZnVIoobfJDbzcDDdJVTQQDMPxUIbjgSAwCPVRIkbI8JOIeY84E99s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLp4S6DqnIscogSoYefY+COO4JHO3vO344FzJS6Hpvv6ipamv0
	PjdudZAty8H7IjUrtuUILysAuYkS0qPBL+6M3SwaNNh0DLYYNa69vknzaPC4o5n9BrnfcQ==
X-Gm-Gg: AeBDievozzr3vs4pshbliy/DJODqWXEnDFC0RbAUPcZlHT6Erc6vGV7axcRCxsol3Q4
	un7Ew+OEpcoB3a5/m1yBuZyC9QtFf507UJlmTJ92ebrjQCiPxF6Ukc3BnnDPnDRKWZRCMRq/1t9
	jqvui8HpX7EI1lmos2HP1lDuJZw7NGJJhKe3wtNJXfMdXHmWh3n6aurUaEOlAXrWL2zYgAUD4Xd
	SF2qAO7wsBiJygS7aeAdq6k+LGV0wJH0mvuQYOx2Bjn9+2G/80WU1972rQ7szOkOmNmAtAw8TRN
	QTRc0YEEdPyM9hJF79SBUYTxG0eJ9F4ESiiq3RVSpXqVsvzd9aZx8FKjZFw2IT0gJ8hJAH6ustj
	v5JS9P4M+iEsQZESA6IV3GGkE7KrBXiw2XforT707aj/xloSZ4l2cVu53HuaeQT+VEngz5ilLFk
	/m7rWDg9xzb97ba4zCU/QAaeku0JqisFOHMIJLRtu2
X-Received: by 2002:a05:6a00:9515:b0:82f:aae5:c7a9 with SMTP id d2e1a72fcca58-8352d26c18dmr1257773b3a.27.1777683785129;
        Fri, 01 May 2026 18:03:05 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b73affsm3743556b3a.55.2026.05.01.18.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 18:03:04 -0700 (PDT)
Date: Sat, 2 May 2026 07:54:05 +0800
From: Coiby Xu <coiby.xu@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <afU8HsdlkQo0oM00@Rk>
References: <20260403100126.1468200-1-coxu@redhat.com>
 <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
 <adRIwaLxqIoIDkTF@Rk>
 <401693ba-1455-4b45-8596-b81625f01201@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <401693ba-1455-4b45-8596-b81625f01201@linux.ibm.com>
X-Rspamd-Queue-Id: 57E1F4B08C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242567-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coibyxu@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 07, 2026 at 03:29:18PM +0530, Sourabh Jain wrote:
>
[...]
>>>As per kdump.rst, restore was introduced to handle CPU and
>>>memory hotplug cases. Is it needed when there is no in-kernel
>>>update to the kdump image on CPU or memory hotplug events?
>>>
>>>But in that case, we rely on a udev rule to reload the kdump image
>>>again.
>>>
>>>I am confused about when exactly we need to restore.
>>
>>To clarify, reuse other than restore is needed for non in-kernel update
>>when handing CPU/memory hotplugging. Yes, a udev rule is also needed in
>>this case.
>
>Below commit explains how the reuse is utilized:
>
>commit 9ebfa8dcaea77a8ef02d0f9478717a138b0ad828
>Author: Coiby Xu <coxu@redhat.com>
>Date:   Fri May 2 09:12:38 2025 +0800
>
>    crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
>
>It got it now. This is helpful when kdump needs to be reloaded due to
>CPU/memory hotplug events using the kexec_file_load system call,
>but only when CONFIG_CRASH_HOTPLUG is not enabled.


>
>IIUC this feature is not support on crash image loaded using 
>kexec_load syscall, right?

Glad you've figured it out!  Yes, you are correct. If
CONFIG_CRASH_HOTPLUG is enabled, there is no need for configfs/reuse. In
v2, I've improved the doc and also added a patch to prevented using this
API when CONFIG_CRASH_HOTPLUG is enabled.


-- 
Best regards,
Coiby

