Return-Path: <stable+bounces-61808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9912893CC88
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 03:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0AC1C20FB7
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C6BA4B;
	Fri, 26 Jul 2024 01:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK2blC56"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B64C99
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721958109; cv=none; b=bM+WtYM5iCp27Y0HnyLlPOjFdzikIgKLOYVr3+DCocPG6S9itoAw0HZwcIMNPbKi077bTiauoUcn+kyTtfIZ/jj54i38NmcUvr71IBBP5c0LHXDi3xtRDjnlAkfqQqr0n3nHV5taEDLjXzSMN1Be0LQ/xThgtNPerAwR+79QNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721958109; c=relaxed/simple;
	bh=o3HnjrWlITcEfZpqbTHl4tyfWAfMWz6+riSbKTagLco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WopCBRymiUj3YWHkibMhCKJjkzCYEVxCRtvjDrkcRdgtx+bDvY0dbytLOigiEMY/Wd67WWBnf4TOEqduhROeTIbBpQgI2f6Hb7F4r/oJ1V7MyoTSBHwxH1TY4yNS6UYrpCAKs3AMH7O3eNT1u3sHEAOptAvLPWX9AxV2DfGtdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aK2blC56; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721958105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaOMRhY/gRejCiB3H5KoMMK1aCX64UdyNisj6DkIbYc=;
	b=aK2blC56IjVGSofLuZStUMBja/4+jxn/tZsnPMbdIrtUv2fbgkImGrWwWJuNy7eZu2y6Ay
	1hc1HM4homSLXxjC0KsBa2JR0rFUJEs+7DEo4aEQacehRL/47nMVGW/f9I+oNiCCkKwRCf
	jl9xMpvR8MTmpkelgFxIu5U5VY/deSM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-LyVjleDWPwqBHM1Rfo7Lfg-1; Thu, 25 Jul 2024 21:41:44 -0400
X-MC-Unique: LyVjleDWPwqBHM1Rfo7Lfg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fc53227f21so2021665ad.2
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 18:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721958103; x=1722562903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaOMRhY/gRejCiB3H5KoMMK1aCX64UdyNisj6DkIbYc=;
        b=g9I3NtwXadZduKgFcq1xpFM8Rb1U6qTaoTX21Ay2foJIMdqxgj+tk0sKrMTLysrrbj
         rKOq5WxJEb+iOy8oUJmIobDrJSjHf3Gid+VoXC5MghY6vRbVksBPgyQyr7F10fPzS/I+
         KtvmnfaHyWNsHylwrKGCmRPTqqqqCtrwGO9zBCaEjrhjcopkD6Ri1v0Wltvi5bcudGmY
         fyYHeHSKvo1oQitPZttji8sWk3oqlFrIa9ag7SrwBrYVjli6XR07L4VnMuElkgrSzQr6
         TtsPx9dZu/wvWIUlm8B7tbVQ2K0cGV1H0JjY3gtv/a6+jBcS/J7K2/FG30A3/EwwOH2e
         +s5g==
X-Forwarded-Encrypted: i=1; AJvYcCXL8eRpFR6ojDdrzIEaRX8dh8H4G2X/d7iEAXinvuNy8xTLLJvWQLAln6mvppfG3B2E816WGDqIMbr+5n+UNf6cYLKmFalz
X-Gm-Message-State: AOJu0Yz0NOaOVPWIf73TQ4pzcgE4Am541KG40joX6T6nI8wyDVXZ+3b6
	D2J9INOY2uA8a/KUC/wvP5bq6R0mNWSPlqPW5u9yZ6GP8mjMATv4/tF2vVUMM5Oe005l0wepgvu
	Cdogp9MyK/Q93v8UNU3cSPx5rL1P7QJ1X0bHnrw4qHxsiyafETl1xXJLKPiTtnxbB
X-Received: by 2002:a17:903:32ce:b0:1fc:71fb:10d6 with SMTP id d9443c01a7336-1fed352fd44mr52630265ad.6.1721958102840;
        Thu, 25 Jul 2024 18:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVwes48W5IHUAfJqPQlO+VKA3ekAdkvW4TtjeJ+ONnDUCYG2nahUGE/QByRqvVcriyAyh9LQ==
X-Received: by 2002:a17:903:32ce:b0:1fc:71fb:10d6 with SMTP id d9443c01a7336-1fed352fd44mr52630075ad.6.1721958102367;
        Thu, 25 Jul 2024 18:41:42 -0700 (PDT)
Received: from [10.72.116.41] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm20741095ad.87.2024.07.25.18.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 18:41:42 -0700 (PDT)
Message-ID: <c69c688b-98ba-4c45-a45a-eefdf1fa467e@redhat.com>
Date: Fri, 26 Jul 2024 09:41:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ceph: force sending a cap update msg back to MDS for
 revoke op
To: Venky Shankar <vshankar@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, stable@vger.kernel.org
References: <20240716120724.134512-1-xiubli@redhat.com>
 <CACPzV1=3m3zKcBuUKTYD6JfkSvo9dTuPU_8shrNBOEdBeSZDuA@mail.gmail.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CACPzV1=3m3zKcBuUKTYD6JfkSvo9dTuPU_8shrNBOEdBeSZDuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/25/24 19:41, Venky Shankar wrote:
> On Tue, Jul 16, 2024 at 5:37 PM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> If a client sends out a cap update dropping caps with the prior 'seq'
>> just before an incoming cap revoke request, then the client may drop
>> the revoke because it believes it's already released the requested
>> capabilities.
>>
>> This causes the MDS to wait indefinitely for the client to respond
>> to the revoke. It's therefore always a good idea to ack the cap
>> revoke request with the bumped up 'seq'.
>>
>> Currently if the cap->issued equals to the newcaps the check_caps()
>> will do nothing, we should force flush the caps.
>>
>> Cc: stable@vger.kernel.org
>> Link: https://tracker.ceph.com/issues/61782
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>
>> V3:
>> - Move the force check earlier
>>
>> V2:
>> - Improved the patch to force send the cap update only when no caps
>> being used.
>>
>>
>>   fs/ceph/caps.c  | 35 ++++++++++++++++++++++++-----------
>>   fs/ceph/super.h |  7 ++++---
>>   2 files changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 24c31f795938..672c6611d749 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -2024,6 +2024,8 @@ bool __ceph_should_report_size(struct ceph_inode_info *ci)
>>    *  CHECK_CAPS_AUTHONLY - we should only check the auth cap
>>    *  CHECK_CAPS_FLUSH - we should flush any dirty caps immediately, without
>>    *    further delay.
>> + *  CHECK_CAPS_FLUSH_FORCE - we should flush any caps immediately, without
>> + *    further delay.
>>    */
>>   void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>>   {
>> @@ -2105,7 +2107,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>>          }
>>
>>          doutc(cl, "%p %llx.%llx file_want %s used %s dirty %s "
>> -             "flushing %s issued %s revoking %s retain %s %s%s%s\n",
>> +             "flushing %s issued %s revoking %s retain %s %s%s%s%s\n",
>>               inode, ceph_vinop(inode), ceph_cap_string(file_wanted),
>>               ceph_cap_string(used), ceph_cap_string(ci->i_dirty_caps),
>>               ceph_cap_string(ci->i_flushing_caps),
>> @@ -2113,7 +2115,8 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>>               ceph_cap_string(retain),
>>               (flags & CHECK_CAPS_AUTHONLY) ? " AUTHONLY" : "",
>>               (flags & CHECK_CAPS_FLUSH) ? " FLUSH" : "",
>> -            (flags & CHECK_CAPS_NOINVAL) ? " NOINVAL" : "");
>> +            (flags & CHECK_CAPS_NOINVAL) ? " NOINVAL" : "",
>> +            (flags & CHECK_CAPS_FLUSH_FORCE) ? " FLUSH_FORCE" : "");
>>
>>          /*
>>           * If we no longer need to hold onto old our caps, and we may
>> @@ -2188,6 +2191,11 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>>                                  queue_writeback = true;
>>                  }
>>
>> +               if (flags & CHECK_CAPS_FLUSH_FORCE) {
>> +                       doutc(cl, "force to flush caps\n");
>> +                       goto ack;
>> +               }
>> +
>>                  if (cap == ci->i_auth_cap &&
>>                      (cap->issued & CEPH_CAP_FILE_WR)) {
>>                          /* request larger max_size from MDS? */
>> @@ -3518,6 +3526,8 @@ static void handle_cap_grant(struct inode *inode,
>>          bool queue_invalidate = false;
>>          bool deleted_inode = false;
>>          bool fill_inline = false;
>> +       bool revoke_wait = false;
>> +       int flags = 0;
>>
>>          /*
>>           * If there is at least one crypto block then we'll trust
>> @@ -3713,16 +3723,18 @@ static void handle_cap_grant(struct inode *inode,
>>                        ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
>>                        ceph_cap_string(revoking));
>>                  if (S_ISREG(inode->i_mode) &&
>> -                   (revoking & used & CEPH_CAP_FILE_BUFFER))
>> +                   (revoking & used & CEPH_CAP_FILE_BUFFER)) {
>>                          writeback = true;  /* initiate writeback; will delay ack */
>> -               else if (queue_invalidate &&
>> +                       revoke_wait = true;
>> +               } else if (queue_invalidate &&
>>                           revoking == CEPH_CAP_FILE_CACHE &&
>> -                        (newcaps & CEPH_CAP_FILE_LAZYIO) == 0)
>> -                       ; /* do nothing yet, invalidation will be queued */
>> -               else if (cap == ci->i_auth_cap)
>> +                        (newcaps & CEPH_CAP_FILE_LAZYIO) == 0) {
>> +                       revoke_wait = true; /* do nothing yet, invalidation will be queued */
>> +               } else if (cap == ci->i_auth_cap) {
>>                          check_caps = 1; /* check auth cap only */
>> -               else
>> +               } else {
>>                          check_caps = 2; /* check all caps */
>> +               }
>>                  /* If there is new caps, try to wake up the waiters */
>>                  if (~cap->issued & newcaps)
>>                          wake = true;
>> @@ -3749,8 +3761,9 @@ static void handle_cap_grant(struct inode *inode,
>>          BUG_ON(cap->issued & ~cap->implemented);
>>
>>          /* don't let check_caps skip sending a response to MDS for revoke msgs */
>> -       if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
>> +       if (!revoke_wait && le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
>>                  cap->mds_wanted = 0;
>> +               flags |= CHECK_CAPS_FLUSH_FORCE;
>>                  if (cap == ci->i_auth_cap)
>>                          check_caps = 1; /* check auth cap only */
>>                  else
>> @@ -3806,9 +3819,9 @@ static void handle_cap_grant(struct inode *inode,
>>
>>          mutex_unlock(&session->s_mutex);
>>          if (check_caps == 1)
>> -               ceph_check_caps(ci, CHECK_CAPS_AUTHONLY | CHECK_CAPS_NOINVAL);
>> +               ceph_check_caps(ci, flags | CHECK_CAPS_AUTHONLY | CHECK_CAPS_NOINVAL);
>>          else if (check_caps == 2)
>> -               ceph_check_caps(ci, CHECK_CAPS_NOINVAL);
>> +               ceph_check_caps(ci, flags | CHECK_CAPS_NOINVAL);
>>   }
>>
>>   /*
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index b0b368ed3018..831e8ec4d5da 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -200,9 +200,10 @@ struct ceph_cap {
>>          struct list_head caps_item;
>>   };
>>
>> -#define CHECK_CAPS_AUTHONLY   1  /* only check auth cap */
>> -#define CHECK_CAPS_FLUSH      2  /* flush any dirty caps */
>> -#define CHECK_CAPS_NOINVAL    4  /* don't invalidate pagecache */
>> +#define CHECK_CAPS_AUTHONLY     1  /* only check auth cap */
>> +#define CHECK_CAPS_FLUSH        2  /* flush any dirty caps */
>> +#define CHECK_CAPS_NOINVAL      4  /* don't invalidate pagecache */
>> +#define CHECK_CAPS_FLUSH_FORCE  8  /* force flush any caps */
>>
>>   struct ceph_cap_flush {
>>          u64 tid;
>> --
>> 2.45.1
>>
> v3 pathset looks good.
>
> Reviewed-by: Venky Shankar <vshankar@redhat.com>
> Tested-by: Venky Shankar <vshankar@redhat.com>
Thanks Venky.
>


