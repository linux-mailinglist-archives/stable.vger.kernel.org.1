Return-Path: <stable+bounces-124625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24356A649C4
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 11:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EF77A55A1
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B542356B5;
	Mon, 17 Mar 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm1M07ud"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDF143748
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207154; cv=none; b=Fmv1y+2PqjxO1/A107aCy/Ll3kP76NXMIWzn1gHFXqZyqyErC2+EUvMdHMUv7CZMw0y2cEEdQ6asiY+ES0yhG7+nX67VQhVW8QElX9uoh2tKBxFeLlJc/ynIoj7iq/CCYi4DjYEWmZ1wY6f7nVgp2ItNiJfqFTP1fYtnAI+I7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207154; c=relaxed/simple;
	bh=TVV/g7mnMh4ma/5PIAWd23Snq3d+CIKvT6sV5VMB6BQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NYGTDRm/SQpiAff1QtXvDt8OEoTy1VSOT/L41ULJWlinyeptK14gZXZAlCmyYkJzVmmrXblLpUK73sKk8YQKbHU9AYuMAqETQqE3I+WQ6F1spWqNo1ZflXHbr/31es8IOpXY9ot5ypVfrfF9mhtj7Qbd2AYHiFgiTm5u8JOqwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bm1M07ud; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742207151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLH7z2QoqEx9Vh2g5JBXd7g+iZGFjbWAGXHeJsAe2S4=;
	b=Bm1M07udYmR58fsX1n45g8O86MLvmf7l/pRIQ6TTTVc5gYJZ7oJpBtxLZ1wKmcWRYgl8E+
	6D0wuicfmfjiJSwV5bbmLqKnU7/bOg/vnpCYFL9w8ITLEgLl7X5iG1GR+U7Q2ZP2QhyjeJ
	C2TeHBPHuxieHTb0eUoxKYqJIT6vDyU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-j3QIsQFiOt2y91E0cllIGQ-1; Mon, 17 Mar 2025 06:25:50 -0400
X-MC-Unique: j3QIsQFiOt2y91E0cllIGQ-1
X-Mimecast-MFC-AGG-ID: j3QIsQFiOt2y91E0cllIGQ_1742207149
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so11366845e9.3
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 03:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207149; x=1742811949;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLH7z2QoqEx9Vh2g5JBXd7g+iZGFjbWAGXHeJsAe2S4=;
        b=m3PDTDrHMer9j6llT+X5cK0SQO1PDvZXFktjC8jazrvjS6dH3myrvf949UV+LBLpXI
         SmfxsvxXFyM2NTXFgb0ZCoGdjRDf6nHmahOCGoKq2WRqqQktvB+jMrtg1gESS97cH7fg
         3fpqqp6pux96eUvyheZjIphQuJ8xlbAMHYOjWNmpz7ULQpCuIPUiv3I+rLEpcSRibou3
         zF6iOemafcyP50HR9d0H6+8LKpkocYsLgYvfQHLfikAiGqadQ3wCeZ+FbokX2tCVUtxC
         cWXigUXi4bR8glwvbOXmVmaAfOp+hfvKUTi0JsBKS1JdXuL+aWSufUSvLxzehXm5wYu3
         wSLA==
X-Gm-Message-State: AOJu0YypTCv2HcmV6U+OulhmHX/tiGqBpy6MQWaZyp8TpHFhRiSxL+9W
	zensrsymtz8pz59Ufgr2uasXuSBgEG/40NqPDO/BPX954wagUO+dppdd5DN9r7MYA277FD/KDl7
	HZ6iOZJT+R2E1trNUG0A7Pl7S2va3LBph/1BES7tmgx2KRsIRP9M2Sw==
X-Gm-Gg: ASbGnctu1OgdzWAI/DLv3McsPJ9OCqJolQ7c/FbdvpYo0XhpWhLU1ec9gBBEIxbK3U4
	8S7NUiufdVeS11Q6yQBYtSPiU0L2nPzcMbLlScr/I1JqWoSMh82MPJrdBVHNUl5jQTpvm6NwEir
	eLQuwNrE/gAPOpehU4dIzl2VGTGk5MejF73K6ZAKdHcXLqqM7prAZ3bRdQL5iDHU4rn6tSTPWYx
	+w/ioNb/sjRr0mEa5nqC8lzVN947rJa7/rRxGhzBDKpO32x0ZrhIadUcNrs1wXIPcyCZBha6DAW
	yhK9sGWyYj4JmIL7Uj3OadieAstoHYzOFsrlSr30wbJ73dcK0BGovRvhNPTe/9zk1nAe8/RLqdZ
	H9f+og/HAUKHP/3/1sU7dEmwcbRaqyVFT
X-Received: by 2002:a05:600c:4690:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43d1ec765b7mr126094815e9.7.1742207149376;
        Mon, 17 Mar 2025 03:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAnSw5ZT58xJ/dgfRjmLNJ5BroXQ6ni/M8VeoavvBu5a/wEIL8St5bHo/p2XpRENGbjVMDwA==
X-Received: by 2002:a05:600c:4690:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43d1ec765b7mr126094445e9.7.1742207148805;
        Mon, 17 Mar 2025 03:25:48 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (106.15.202.62.static.wline.lns.sme.cust.swisscom.ch. [62.202.15.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e2d6sm100039075e9.38.2025.03.17.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:25:48 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 srivatsa@csail.mit.edu, K Prateek Nayak <kprateek.nayak@amd.com>, Michael
 Kelley <mhklinux@outlook.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v5] sched/topology: Enable topology_span_sane check only
 for debug builds
In-Reply-To: <8c2c67cc-d8a0-42cf-b9fe-c5e5c4f627c6@linux.microsoft.com>
References: <20250310052509.1416-1-namjain@linux.microsoft.com>
 <xhsmh34fjr3av.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <8c2c67cc-d8a0-42cf-b9fe-c5e5c4f627c6@linux.microsoft.com>
Date: Mon, 17 Mar 2025 11:25:47 +0100
Message-ID: <xhsmha59koswk.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 17/03/25 15:27, Naman Jain wrote:
> On 3/11/2025 9:02 PM, Valentin Schneider wrote:
>> On 10/03/25 10:55, Naman Jain wrote:
>>> From: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>
>>> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
>>> around 8 seconds cumulatively for all the iterations. It is an expensive
>>> operation which does the sanity of non-NUMA topology masks.
>>>
>>> CPU topology is not something which changes very frequently hence make
>>> this check optional for the systems where the topology is trusted and
>>> need faster bootup.
>>>
>>> Restrict this to sched_verbose kernel cmdline option so that this penalty
>>> can be avoided for the systems who want to avoid it.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> ---
>>> Changes since v4:
>>> https://lore.kernel.org/all/20250306055354.52915-1-namjain@linux.microsoft.com/
>>>        - Rephrased print statement and moved it to sched_domain_debug.
>>>          (addressing Valentin's comments)
>>> Changes since v3:
>>> https://lore.kernel.org/all/20250203114738.3109-1-namjain@linux.microsoft.com/
>>>        - Minor typo correction in comment
>>>        - Added Tested-by tag from Prateek for x86
>>> Changes since v2:
>>> https://lore.kernel.org/all/1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com/
>>>        - Use sched_debug() instead of using sched_debug_verbose
>>>          variable directly (addressing Prateek's comment)
>>>
>>> Changes since v1:
>>> https://lore.kernel.org/all/1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com/
>>>        - Use kernel cmdline param instead of compile time flag.
>>>
>>> Adding a link to the other patch which is under review.
>>> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
>>> Above patch tries to optimize the topology sanity check, whereas this
>>> patch makes it optional. We believe both patches can coexist, as even
>>> with optimization, there will still be some performance overhead for
>>> this check.
>>>
>>> ---
>>>   kernel/sched/topology.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index c49aea8c1025..d7254c47af45 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -132,8 +132,11 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>>>   {
>>>        int level = 0;
>>>
>>> -	if (!sched_debug_verbose)
>>> +	if (!sched_debug_verbose) {
>>> +		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
>>> +			     __func__);
>>>                return;
>>> +	}
>>>
>> 
>> Nit: I've been told not to break warnings over multiple lines so they can
>> be grep'ed, but given this has the "sched_domain_debug:" prefix I think we
>> could get away with the below.
>> 
>> Regardless:
>> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>> 
>> ---
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index d7254c47af455..b4dc7c7d2c41c 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -133,7 +133,8 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>>   	int level = 0;
>>   
>>   	if (!sched_debug_verbose) {
>> -		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
>> +		pr_info_once("%s: Scheduler topology debugging disabled, "
>> +			     "add 'sched_verbose' to the cmdline to enable it\n",
>>   			     __func__);
>>   		return;
>>   	}
>
>
> Hi Valentin,
> Splitting the warning to different lines give checkpatch error with 
> --strict option. --fix option suggests we keep it like we have it 
> originally(single line). Please let me know if you feel we can change it 
> to something else or if you are fine with picking the change for next 
> iteration. Thanks again.
>

Hah, didn't know that was in checkpatch :-) As I said before that really
was more of a nitpick, consider me OK with the current patch.


