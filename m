Return-Path: <stable+bounces-186196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73B1BE5348
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F29D1A68416
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502B23A9B0;
	Thu, 16 Oct 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLzqCxA4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6313B7A3
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642114; cv=none; b=ghsYan3WjsZ2vMizlZgeulflCfn3Hf2iU276nZYwXZRo1pQIG36IJlkTbBp6bOija0FTo7mWP2bVryu4WFd3EE64qyEjE/56HsD9Y/NqLh4q166/CUvq9WpZ1AAutQIfWrFA3QiGbvXk3bTNniAv4+sInoYckQOiNl9p9KtbdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642114; c=relaxed/simple;
	bh=2wIoqQOKViyJzI5mST31nnZOq2eejB4i2v9JaxIh2po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwx9xphBNFSxrlbQQ4VFJK0aMXROA8IvKEhVUv13dh1dSFeuVHAP75cyRT9zDt6NOTaS/MuzEhSoRuHxK9f7eS4PUDs7anWH+EpA9LMq5W9S0qKBWJar5Hvq65i3gQLwyc6hr6c/tWbj+dOAkijiO8vIPIC2Kr7ul0+IBrWaBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLzqCxA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760642111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hVHh5PR4TvqqguUhfaerHBEOYknHgUGYrVSqECH8sUI=;
	b=DLzqCxA4GoAi534zS1kF78egJhMKDAdTdHIWTZ4sU0/ZSJLNmxVu5bjpO0+xzaOpmLZF77
	c/4mHId4MVoH9X/w44EhTzHo4Qnr6yADxua2k+29BDlvTcdTIOvl2UHBFgxrJx73BoRF/+
	7LiK6jXd7LTYeW0+6dLSodIJ8JcxXec=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-VdYUNCsmN06v7O39lUD7IA-1; Thu, 16 Oct 2025 15:15:10 -0400
X-MC-Unique: VdYUNCsmN06v7O39lUD7IA-1
X-Mimecast-MFC-AGG-ID: VdYUNCsmN06v7O39lUD7IA_1760642109
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426feed0016so549912f8f.3
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642109; x=1761246909;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVHh5PR4TvqqguUhfaerHBEOYknHgUGYrVSqECH8sUI=;
        b=udCYn+9g9n37IPsyhMgE+mVWM4nQO7FqrcB6/gcQOO/2gSci3+TdLpY8F1P2PYX/5X
         vaCnn9ETk7sDS/0HGtVWVdA+yNwMK8N4mlq3AIRQsCMS5azB29HIxNAuFYjBhscx4Duo
         DgxiMHjE9YY8sUWidvhitO7bk2TlLvaPJ1EHr25ql+rkEA1SUl1LGY10ISqmBub9AWTs
         oUxSCu5J+z24F2w6P4i38LFrbI3LmXiYf5cctiRZVz3EjVDPvU93fEA7zpmlXBansQwl
         YSeEoAVdC1fkHRVg4qpvnVJrsnTZ+6T2I31WFb0mcw73SwGIhHqQmgGewr87d75uOOt6
         VgpA==
X-Forwarded-Encrypted: i=1; AJvYcCUtGc94C+KNiNT/6UCJtaxtoILGdrZJ2jF2faM4hUUm8OV6jAeomUh/uMbp8PKf/djO3fB0euo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIn1BaUp4XALpjD/wjnbqW/cigWDaAoqzjfMHbCZcqef73DYH
	Yi1hG9dQFzU7QOtGzqQm85laV2u9dVl7AjeafZnxCd8ELHZma+UzEmdhhNIOSqEgZVKgRzhGpI0
	NUngeHcQtXWj9lqQfeauXNRUt/2Jn1R5aUxMOjQ+Ejk7uil3aSX8tuTH/oA==
X-Gm-Gg: ASbGncvPXCfwubAYn9XaHJS50QJKoLXp36oPhS2Ogl4WO91ABBf7TSk8cCfu4UxdJ51
	i+k4gjpgJ37NGgJOajR4nsOOSoILudOPFQBYVRa7g4LOj12wzivQgzKAG7gHG03w/jcTsiAgHAd
	1ZNCxW8szMGyGD7An9GSqtn9AFlsyjerYRnfTdUWGHYfo56mmTEY+AmfenFpfWl6/VDshRVGnyR
	D/qE3QC2pTFgny//sOlp1j/IqZQa6pfaluq9f97/eHM1Z64MiGsj+FDIW4npwf5Z9qqiqM3TDKL
	LVYmcTT18pE4g9NR3RRPNdMpLyXUR2AuGBHdaXzplgPP8BlK0bYwTPGhHHtBNK6ivVRDGZBwszI
	h+B6h+24AewA7HmY3GHFGgMoNwxVpK8GeLamPuawkEXqXvIkr5jxXXcDMIFyABZ20HZcq+CT/b4
	BY8dH8G4wTwfQTjicK7LI73WMBIAI=
X-Received: by 2002:a05:6000:1446:b0:40b:c42e:fe39 with SMTP id ffacd0b85a97d-42704d963b3mr855940f8f.40.1760642109039;
        Thu, 16 Oct 2025 12:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTwjlQtEo8QmL86bVhgI5H+nKBsihjFtBhqqdNCCeLESucnFPVLdDF1Syd2/2TIS9wcEA8jg==
X-Received: by 2002:a05:6000:1446:b0:40b:c42e:fe39 with SMTP id ffacd0b85a97d-42704d963b3mr855922f8f.40.1760642108544;
        Thu, 16 Oct 2025 12:15:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm64839695e9.3.2025.10.16.12.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:15:08 -0700 (PDT)
Message-ID: <dc14c183-d93e-405a-831a-dca69ede3cd2@redhat.com>
Date: Thu, 16 Oct 2025 21:15:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
To: Kalesh Singh <kaleshsingh@google.com>, Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 pfalcato@suse.de, kernel-team@android.com, android-mm@google.com,
 stable@vger.kernel.org, SeongJae Park <sj@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com>
 <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
 <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
 <af0618c0-03c5-9133-bb14-db8ddb72b8de@google.com>
 <CAC_TJvdy4qCaLAW09ViC5vPbj4XC7_P+9Jjj_kYSU6d+=r70yw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAC_TJvdy4qCaLAW09ViC5vPbj4XC7_P+9Jjj_kYSU6d+=r70yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> Would this be an acceptable path forward?
>>
>> Possibly, if others like it: my concern was to end a misunderstanding
>> (I'm generally much too slow to get involved in cleanups).
>>
>> Though given that the sysctl is named "max_map_count", I'm not very
>> keen on renaming everything else from map_count to vma_count
>> (and of course I'm not suggesting to rename the sysctl).
> 
> I still believe vma_count is a clearer name for the field, given some
> existing comments already refer to it as vma count. The inconsistency
> between vma_count and sysctl_max_map_count can be abstracted away; and
> the sysctl made non-global.

Yes, to me that part makes perfect sense (taste differs as we know).

-- 
Cheers

David / dhildenb


