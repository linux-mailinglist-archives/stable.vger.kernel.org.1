Return-Path: <stable+bounces-25918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC964870294
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8378EB25973
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD83D578;
	Mon,  4 Mar 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DD1UAvfe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F33D560
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558649; cv=none; b=HfuAzGXu5nczBTJxNB4KUX6f4sbwR7lkORUl7MYN8xSRcJYSswc/sXF2wmIjNaQlQQ6eI6qIndwUHGRLNm5eRId+Sa6+nilmm38u7cbZZYYDFw4Y1EmSPo8JlLwZTTZDLfR4Zax7Ogg7Lf9uoH2rGp/8yxZmxmmwI/gnjhwNFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558649; c=relaxed/simple;
	bh=bxq3CiHzJRGANTeCS3Lik8MxNKEU5wk57JGAtLp6kt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqzPn6u3EHQCVdBqLpo55H6loloBXx/BEMymIVzwQszxqnMAdiG8F0wFQt7O/yc75nUoTWNM7qeAJ118tbn+Y2IP3dgxuAmdj94Gg1Uc2qsP3NTu8SNwl7mkgXQ04vGk77ifP3CABeXbUQkYvEMHZVdwNAgcdYWI82mQ0fdbPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DD1UAvfe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709558646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e0aVBH8Bbwp/svtEKmKZLJTI4f+E4WaUIjl97DqXSU=;
	b=DD1UAvfe0mIT2qFZ6BjAvXaU3R8Md++tSasDA4F0JRXvwdcl8Z9sCP5a6ul7WKdezOMdNY
	Wy1DQ/yPb1cAAMRAEdYAN+8HwnEkGH3F5pQA85wGXoDiOHMdVan62I0p5ntU88ikp9/JLd
	hVYmTj1/7ck4DtOPcC7z0EEQWOh+Bv4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-QJAY1Go8PzO87LZmzyXvyA-1; Mon, 04 Mar 2024 08:24:04 -0500
X-MC-Unique: QJAY1Go8PzO87LZmzyXvyA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dbe41ad98cso45622035ad.3
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 05:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558643; x=1710163443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0e0aVBH8Bbwp/svtEKmKZLJTI4f+E4WaUIjl97DqXSU=;
        b=TxzVTQA8VlTr6jR/UEV2ZXUc/exQyLCEM2EPRxoom5xz4E0sArt/OHGWhXgXKI400f
         SrkrHD/+xk9JV3UTyOToizyL1ngpM9tsDejm//8RermVCRODFOXXcSPkrorYy4901d+U
         zEnVO0kOsGEq+FG1Z+GIyTYpX5KPf63WQbO2PBlExXj/+GoyGjh7y+qaeNiEvvthTGSO
         gwUYzUFn9Cd4HLC1TGcG+XVzlq8XDY7M46oqYQ2yziRlo6RCS8blXeYRt382g6GC2Vng
         +N8lM9Q9ANYEUqrYnzENn8wot4wxOHlvmQfK33Cq3EeH1U2F5LtY/x45FHkOCc26L3bo
         MF8g==
X-Forwarded-Encrypted: i=1; AJvYcCWo7TDCEAEcbra/OxHoh0CGI6iWu+zzuEIX9lS1zMO4pTnlIQ2usz0jEfplucPN6jFnDWTrf6/jCnnZw4tI57G/QVJXhvT3
X-Gm-Message-State: AOJu0Yx57Lm4JdegzOnCWyvdf1Nhicn/7HNR8OPo+LuVqGX4pybygV/C
	MaU40OUWDFUrcNQlc+UXvJ3Sg4TlnkYQHmmPZmc443S8FAY/OsRprS+aoiUT1bnp+HWrog0XBvp
	/ktGKnRw/K/9qClR5tNfrIqt4r4YycsChPJv8/Wui/mMrfIqzPyYciQ==
X-Received: by 2002:a17:902:fe82:b0:1db:8fd9:ba0d with SMTP id x2-20020a170902fe8200b001db8fd9ba0dmr6802820plm.23.1709558643336;
        Mon, 04 Mar 2024 05:24:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJv5/sMWjUl805F2QTGqPcxSDc7h/6Kqp1/yxqlGlU3EtvZznDtzI9+Zpf8qSHe+ESsR2KWQ==
X-Received: by 2002:a17:902:fe82:b0:1db:8fd9:ba0d with SMTP id x2-20020a170902fe8200b001db8fd9ba0dmr6802808plm.23.1709558643049;
        Mon, 04 Mar 2024 05:24:03 -0800 (PST)
Received: from [10.72.112.93] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001dc944299acsm8464378plh.217.2024.03.04.05.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 05:24:02 -0800 (PST)
Message-ID: <4db59457-d2d7-42f9-b0d9-6719a10e2a3b@redhat.com>
Date: Mon, 4 Mar 2024 21:23:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: init the cursor when preparing the sparse read
Content-Language: en-US
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, jlayton@kernel.org, vshankar@redhat.com,
 mchangir@redhat.com, stable@vger.kernel.org,
 Luis Henriques <lhenriques@suse.de>
References: <20240229041950.738878-1-xiubli@redhat.com>
 <CAOi1vP-n34TCcKoLLKe3yXRqS93qT4nc5pkM8Byo-D4zH-KZWA@mail.gmail.com>
 <6c3f5ef9-e350-4a1e-81dd-6ab63e7e5ef3@redhat.com>
 <CAOi1vP_WGs4yQz62UaVBDWk-vkcAQ7=SgQG37Zu86Q2QusMgOw@mail.gmail.com>
 <256b4b68-87e6-4686-9c51-e00712add8b3@redhat.com>
 <CAOi1vP-LFKzij5pYz+HLWAUiBZ-6+UYpoND08ceDofhN7xN-zw@mail.gmail.com>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP-LFKzij5pYz+HLWAUiBZ-6+UYpoND08ceDofhN7xN-zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/4/24 19:12, Ilya Dryomov wrote:
> On Mon, Mar 4, 2024 at 1:43 AM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 3/2/24 01:15, Ilya Dryomov wrote:
>>> On Fri, Mar 1, 2024 at 2:53 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>> On 2/29/24 18:48, Ilya Dryomov wrote:
>>>>> On Thu, Feb 29, 2024 at 5:22 AM <xiubli@redhat.com> wrote:
>>>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>>>
>>>>>> The osd code has remove cursor initilizing code and this will make
>>>>>> the sparse read state into a infinite loop. We should initialize
>>>>>> the cursor just before each sparse-read in messnger v2.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> URL: https://tracker.ceph.com/issues/64607
>>>>>> Fixes: 8e46a2d068c9 ("libceph: just wait for more data to be available on the socket")
>>>>>> Reported-by: Luis Henriques <lhenriques@suse.de>
>>>>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>>>>> ---
>>>>>>     net/ceph/messenger_v2.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
>>>>>> index a0ca5414b333..7ae0f80100f4 100644
>>>>>> --- a/net/ceph/messenger_v2.c
>>>>>> +++ b/net/ceph/messenger_v2.c
>>>>>> @@ -2025,6 +2025,7 @@ static int prepare_sparse_read_cont(struct ceph_connection *con)
>>>>>>     static int prepare_sparse_read_data(struct ceph_connection *con)
>>>>>>     {
>>>>>>            struct ceph_msg *msg = con->in_msg;
>>>>>> +       u64 len = con->in_msg->sparse_read_total ? : data_len(con->in_msg);
>>>>>>
>>>>>>            dout("%s: starting sparse read\n", __func__);
>>>>>>
>>>>>> @@ -2034,6 +2035,8 @@ static int prepare_sparse_read_data(struct ceph_connection *con)
>>>>>>            if (!con_secure(con))
>>>>>>                    con->in_data_crc = -1;
>>>>>>
>>>>>> +       ceph_msg_data_cursor_init(&con->v2.in_cursor, con->in_msg, len);
>>>>>> +
>>>>>>            reset_in_kvecs(con);
>>>>>>            con->v2.in_state = IN_S_PREPARE_SPARSE_DATA_CONT;
>>>>>>            con->v2.data_len_remain = data_len(msg);
>>>>>> --
>>>>>> 2.43.0
>>>>>>
>>>>> Hi Xiubo,
>>>>>
>>>>> How did this get missed?  Was generic/580 not paired with msgr2 in crc
>>>>> mode or are we not running generic/580 at all?
>>>>>
>>>>> Multiple runs have happened since the patch was staged so if the matrix
>>>>> is set up correctly ms_mode=crc should have been in effect for xfstests
>>>>> at least a couple of times.
>>>> I just found that my test script is incorrect and missed this case.
>>>>
>>>> The test locally is covered the msgr1 mostly and I think the qa test
>>>> suite also doesn't cover it too. I will try to improve the qa tests later.
>>> Could you please provide some details on the fixes needed to address
>>> the coverage gap in the fs suite?
>> Mainly to support the msgr v2 for fscrypt, before we only tested the
>> fscrypt based on the msgr v1 for kclient. In ceph upstream we have
>> support this while not backport it to reef yet.
> I'm even more confused now...  If the fs suite in main covers msgr2 +
> fscrypt (I'm taking your "in ceph upstream we have support" to mean
> that), how did this bug get missed by runs on main?  At least a dozen
> of them must have gone through in the form of Venky's integration
> branches.

Maybe some other known issues have masked this bug, before the qa tests 
didn't behave well for a long time for some reasons.

And many test will run base on reef branch, which hasn't backport it yet.

Thanks

- Xiubo

> Thanks,
>
>                  Ilya
>


