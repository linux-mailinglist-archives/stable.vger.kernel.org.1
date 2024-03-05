Return-Path: <stable+bounces-26715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC148715DE
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 07:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020E21C22200
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E617BAEF;
	Tue,  5 Mar 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RKoy6I5L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2824346521
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620142; cv=none; b=CWAz+7+/P7BdU3FfPH56zbN7vXAiI4J9GQYAUIK8dlXV3i1lJXDDpcjAgR9+iRNdyI5JYRiDuS4a576Wybpa1bzArGg5rECu4U9aak6zoTc6X++Th9WadosUwMeorwT5QYLondmNehknIcGkDpBR8LB4BSBur9pLXJKxxCdGly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620142; c=relaxed/simple;
	bh=o3KsW+grwbRLP0L8ir10pxJE6eacl9GOV2jpfSyH2oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSRXrm4owl3p2Mc4w97UDTqk1cC4HFNkcVD+78Lj5gA9tDp3C1EjC4IfQG10BA9Ht6ZB+Uy6xM+kKqekKh9x8dsu71298XGw1v637hOcphu6/ND3vrCDDA5GoNfFncpPezHI4T9/k7y1nmj6EWwh07PJ8JCIFS3n9FLwmiKMbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RKoy6I5L; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e627596554so1232918b3a.2
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 22:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709620140; x=1710224940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wChtguQxSNCTRzk80gzhwJdbsMA0F9ZUi14KNNY0h4c=;
        b=RKoy6I5LZC3dSNnT7PafCQyurdXMZks/JiReyh+qsC+SJJNoJN+pfwX0QqN8zuhxsY
         AspWA+vJqnawlda4GEg59cx0qRkKwWriAYzeO0gmDGEnFaxx6jw2KC5yP9YfaQErSqLy
         LkxtHOf4fgWhYjEMcpeCvQej/jNPS8s5EccrK7lQhU5WvG4+udSnVrzvucUtpGk2Gx96
         jc148/Cd6cWmJr9YWIk9KvCXDijstPxX29JvjhcVVqWxke/0WLwrP5SwJ6ES1BbNdibU
         rwloxzvuHjNznv96lyzCovAGk85nwGBVzyPdi0agOiyZcSqcoX1epXD+jGphd5JjTxA4
         neAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709620140; x=1710224940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wChtguQxSNCTRzk80gzhwJdbsMA0F9ZUi14KNNY0h4c=;
        b=lnJbaFff/WFxMeRKCnEyuWe3CY6XbQONsF0ob83YxchPa2kpu3OIiDRoJG8hLbUMaw
         aWz4LpKMJIUsVzaB49CiKqy7N0FZfjorryWehm9OmQoykPheCjLcUB9vIYw2aQRxnH7u
         8Nd47f9q4Wdcy4GlbEiVuCwM5ALmwxZVu8MH/BKA1pc7o4+5vVoRMXIs2UV6/4RVV2iS
         vjfZggwnYkRSCFnvsasi3BB988xgTcS2ica5e3mTWLq0vYChk+3muBgiJYJ9AWySQV25
         gv9ptrg4D5AVoW7qvf6AzcBwr5RFewgF2ZLs/MHmC+RBynaTI27dh3FSTEp/5mj7kajr
         1UPg==
X-Forwarded-Encrypted: i=1; AJvYcCWA8CXfGnyjR0LPLvSGeHTu4XNYXRGvvWW7IIXzbz/U3FB2qEXt0wQ8+633wN9VZY8O1YOiG1jS0DxkMKSsPUTA56PvuOlk
X-Gm-Message-State: AOJu0YwzvZr0Cv0Q2swfLYSglITA15CWjNw4DhnZdj1FNoFr3CMe/67n
	giRR2JBA0rGG6itDXNNDanHT0KTzUorITBpLTCLkeh3wyKWZWR1pZvD7LxF/tAY=
X-Google-Smtp-Source: AGHT+IFfP68TO+3mNgmUFoS71/glbTqNBbe7+yPa5myxCx7SqgEUehYFKFjvkYzR+1kMtgEoiuNSmA==
X-Received: by 2002:a05:6a20:c90c:b0:1a0:df5a:c689 with SMTP id gx12-20020a056a20c90c00b001a0df5ac689mr881206pzb.48.1709620140494;
        Mon, 04 Mar 2024 22:29:00 -0800 (PST)
Received: from [10.254.214.186] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id se3-20020a17090b518300b00296fd5e0de1sm10963503pjb.34.2024.03.04.22.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 22:29:00 -0800 (PST)
Message-ID: <7d8c1898-85e0-4291-8023-c17d80c75c94@bytedance.com>
Date: Tue, 5 Mar 2024 14:28:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 0/3] Support intra-function call
 validation
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
 stable@vger.kernel.org, alexandre.chartre@oracle.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, yuanzhu@bytedance.com
References: <20240228024535.79980-1-qirui.001@bytedance.com>
 <2024030438-dropout-satisfy-b4c4@gregkh>
 <2024030404-conjoined-unlined-05c0@gregkh>
 <c98aa910-7b14-401d-a257-274682bb7486@bytedance.com>
 <2024030506-observant-clamor-1c8f@gregkh>
From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <2024030506-observant-clamor-1c8f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

No problem with make allmodconfig, the compiler I use is gcc version 8.3.0 (Debian 8.3.0 -6).

On 3/5/24 2:13 PM, Greg KH wrote:
> On Tue, Mar 05, 2024 at 11:28:01AM +0800, Rui Qi wrote:
>> Hi Greg,
>> I checked out commit e133c1ee6d7271007fdba3dbe78818afd88943f9 (Linux 5.4.270), applied my patche set on top, enabled CONFIG_LIVEPATCH based on x86 defconfig, compiled without any issues. I couldn't even grep unwind_hint_empty in the codebase, so I'm quite puzzled about how this phenomenon occurred. Can you tell me how to reproduce this compilation error?
> 
> Try building with 'make allmodconfig'.  Also, what compiler and version are you using?
> 
>> In addition, my patchset only applies to the LTS branch of 5.4, not to other branches. Please be careful not to merge it into other branches.Other stable branches do not have the problem of such kernel livepatch issue.
> 
> It just broke this branch, I didn't apply it anywhere else.
> 
> thanks,
> 
> greg k-h

