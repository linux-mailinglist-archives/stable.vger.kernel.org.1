Return-Path: <stable+bounces-235619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJHGA5Pe2GnHjAgAu9opvQ
	(envelope-from <stable+bounces-235619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 13:27:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D853D625B
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FD3F3033208
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033339E197;
	Fri, 10 Apr 2026 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="GRkoHqEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tne5brQ6"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF53B9613;
	Fri, 10 Apr 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820420; cv=none; b=QJ5/AYC1np068eFTots4Kt5VKYMutiGBV47VDZZcF8tkJV78DmvzLXsMpwMGZx2NtaBPM6P3bc0LKDAbJHy2CVnAbTMMvDo+zjlLRsLj+gAgsLcR4vFcg5vWJgprPrg0lO6nqdW/MuIZ9/7Re8JfMuTRjqDZ2yeUaXxApjRt3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820420; c=relaxed/simple;
	bh=t3sydj9RC0hGhyZ/c6JaM+nYJwCW1IuLr5C1AiYuufk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHINUcXxDwJmCKTT3IkxGef2JmCqaw8dGf5DhswbGrJOBOlpspi6sQpgOmuDnNTZk5L6QuclREJBx0r5a1bOIuTmjxiI91920EasH/RKSLKB0BHJli2JXY0TD5HkORrQAVOSEFyRmTU3YQBSwm9wiPueiPDAMJ565fZ+CHFmC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=GRkoHqEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tne5brQ6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CAD591400143;
	Fri, 10 Apr 2026 07:26:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Apr 2026 07:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775820417;
	 x=1775906817; bh=CFIuDoJP1rz4n9s/VPto6c+bmWc9hheKSJdyP8Mn2/s=; b=
	GRkoHqEcbux1ZUjLcUtPR5+5E1o6+NE64G8vH4+yJB3pqLe+3jrCdz95NhI/nyyK
	F6pJsrTZNj9M07yx3xjfyb4s95pTRUm6G3nyEYijOOJUbGbFW63pfdht8gGUwoXY
	kR6wzn4OFifLKwOcvZOvpRNNOX2347FUpVqwF7AyAPHkQ1ZqnNL/4WX9eql4pvO9
	X5o7+zE4K+1UNMU2Dj91bYYKkb8QjUptbj0CwXoQ+b2/FPxHzjD/fjN4rve/OGFR
	tblPzcn/Imd+OzxihobNrQfODMi3lUDUxVvQCNbjp6uLAs7ZawPE57gp7KWAYGQS
	WykVdqALHigeAtYuR9wiUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775820417; x=
	1775906817; bh=CFIuDoJP1rz4n9s/VPto6c+bmWc9hheKSJdyP8Mn2/s=; b=T
	ne5brQ6VOluwXXjjsZ0Zozk55zd9ZC2QY9G8rCGGCnm8ZpZ8w9PR6A2fwoG8dkVa
	4nct25LE7HFLTAnoLSm3e5HdE6l+5EhHOJKdQdAnYD4HYOzWw9OpOihrg95A7jhG
	V0MbxkgnJQyDWEhZvVHsHOG7L8rFG0awSYbW0KS3VfeLpdy+A95PO5DxT3aTFvsJ
	VMvmqQZS3qV7kj5r7ojU8537ly55T2UMaV+ONhC32sAsuMnHAw4m8Wb7IoLY4X5q
	HakbAZHI6jD/H8UR6OsDqVSQVFU0O29IS21pceN+W0uk+8N47/INbG07eES3Ch1W
	6DCIL/taZz2Y9T13c6Hcw==
X-ME-Sender: <xms:gd7YaeZUukWF3tfFcrcmOrwaDNunKQHhtqJUfIkaUvVMBSN2N3WTkA>
    <xme:gd7YaSE4VF8vTh_hU9UOmM7Nxfcyll4SLCc7T26NiSewOZ6YjeFBAJx1NfTOlhw7M
    MD_fQvs8_AqJt_f-D-jvi9u6iNZctSixakS3CcGaB6W0dd7pyPU>
X-ME-Received: <xmr:gd7YaXJgauVOjSbPC_m9ZcIZskg3V_VxW4t5dEUxx-j4nCcK-Wb_RHWKBs9-JRYD8uH8ddM0elRTJbtBvWudG4chNH2OVtJ--y4VvJNPTUBMRT2Z1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvledvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeuvdeuudeltddukefhueeludduieejvdevveevteduvdefuedvkeffjeel
    ueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    grnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopegsshgthhhusggv
    rhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlihesuggunhdrtghomhdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhsghirhhthhgvlhhmvghr
    seguughnrdgtohhm
X-ME-Proxy: <xmx:gd7YaVPcVliCSvnY16WM9ZnW2MBcq-K4EFM5H5ocfXKR9ci93m3u7w>
    <xmx:gd7Yafm8TDGiGPgRiqTyWWtjZMIVXzj2BsDs1PNqNG9ZIuJxKwUVgg>
    <xmx:gd7YaR4naaHlN54bgKF3Yzu75o38Hs2qxeLJ1HPRhjLS7By0l_xLkg>
    <xmx:gd7Yab1ZH9oLysakvN0-h2fuEiqd-LfykuHEowLCFonlDVtz2gqZOQ>
    <xmx:gd7YaRoENormQipKriJrJvsIxvzwxubpDPRT0jt17mKKL1YTh80bMenw>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 07:26:56 -0400 (EDT)
Message-ID: <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com>
Date: Fri, 10 Apr 2026 13:26:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate
 teardown
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Jian Huang Li <ali@ddn.com>,
 stable@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
In-Reply-To: <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-235619-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64D853D625B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Joanne,

On 4/10/26 01:09, Joanne Koong wrote:
> On Thu, Apr 9, 2026 at 4:02 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 10/21/25 23:33, Bernd Schubert wrote:
>>> Do not merge yet, the current series has not been tested yet.
>>
>> I'm glad that that I was hesitating to apply it, the DDN branch had it
>> for ages and this patch actually introduced a possible fc->num_waiting
>> issue, because fc->uring->queue_refs might go down to 0 though
>> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
>> flush the queues without another addition.
>>
> 
> Hi Bernd and Jian,
> 
> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> from fuse_uring_cancel" email was never delivered to my inbox, so I am
> just going to write my reply to that patch here instead, hope that's
> ok.
> 
> Just to summarize, the race is that during unmount, fuse_abort() ->
> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
> fuse_uring_entry_teardown() gets run but there may still be sqes that
> are being registered, which results in new ents that are created (and
> leaked) after the teardown logic has finished and the queues are
> stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
> never gets scheduled because at the time of teardown, queue->refs is 0
> as those sqes have not fully created the ents and grabbed refs yet.
> fuse_uring_destruct() runs during unmount, but this doesn't clean up
> the created ents because those registered ents got put on the
> ent_in_userspace list which fuse_uring_destruct() doesn't go through
> to free, resulting in those ents being leaked.
> 
> The root cause of the race is that ents are being registered even when
> the queue is already stopped/dead. I think if we at registration time
> check the queue state before calling fuse_uring_prepare_cancel(), we
> eliminate the race altogether. If we see that the abort path has
> already triggered (eg queue->stopped == true), we manually free the
> ent and return an error instead of adding it to a list, eg
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index d88a0c05434a..351c19150aae 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
> int current_qid)
>  /*
>   * fuse_uring_req_fetch command handling
>   */
> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
>                                    struct io_uring_cmd *cmd,
>                                    unsigned int issue_flags)
>  {
> @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
> fuse_ring_ent *ent,
>         struct fuse_conn *fc = ring->fc;
>         struct fuse_iqueue *fiq = &fc->iq;
> 
> +       spin_lock(&queue->lock);
> +       /* abort teardown path is running or has run */
> +       if (queue->stopped) {
> +               spin_unlock(&queue->lock);
> +               atomic_dec(&ring->queue_refs);
> +               kfree(ent);
> +               return -ECONNABORTED;
> +       }
> +       spin_unlock(&queue->lock);
> +
>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> 
>         spin_lock(&queue->lock);
> @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
> fuse_ring_ent *ent,
>                         wake_up_all(&fc->blocked_waitq);
>                 }
>         }
> +       return 0;
>  }
> 
>  /*
> @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>         if (IS_ERR(ent))
>                 return PTR_ERR(ent);
> 
> -       fuse_uring_do_register(ent, cmd, issue_flags);
> -
> -       return 0;
> +       return fuse_uring_do_register(ent, cmd, issue_flags);
>  }
> 
> There's the scenario where the abort path's "queue->stopped = true"
> gets set right between when we drop the queue lock and before we call
> fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
> logic that was called before fuse_uring_do_register() has already
> grabbed the ref on ring->queue_refs, which means in the abort path,
> the async teardown (fuse_uring_async_stop_queues()) work is guaranteed
> to run and clean up / free the entry.


I don't think your changes are needed, it should be handled by
IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where the
initial leak was - these commands came after abort and
fuse_uring_cancel() in linux upstream then puts the entries onto the
&queue->ent_in_userspace list.
Issue in master is, fuse_uring_stop_queues() might have been run already
- entries then get leaked and fuse_uring_destruct() later might give a
warning. That part can be reproduced with xfstests, before it starts any
of the tests it does some funny start stop actions.

Initial *simple* patch was to either add a new list or to just remove
the warning and to also handle either that new list or
queue->ent_in_userspace list  in fuse_uring_destruct(). The comment
explaining why it is needed was much longer than the rest of the patch.
The hard part in the long term would be tranfer the knowledge for that
requirement.

You then asked to handle the release directly in fuse_uring_cancel()
without another list
https://lore.kernel.org/r/CAJnrk1YaRRKHA-jVPAKZYpydaKcdswLG0XO7pUQZZ4-pTewkHQ@mail.gmail.com

Yes possible and this is what the next patch version does. However,
given fuse_uring_cancel() runs outside of all the fuse locks, it is racy
and I therefore asked in the introduction patch not to merge it yet.

https://lore.kernel.org/all/20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com/


Turns out my suspicion was right ;)

Queue references might go to 0 when nothing is in flight and then
fuse_uring_abort(), which _might_ race and come a little later, then
might not doing anything.

        if (atomic_read(&ring->queue_refs) > 0) {
                fuse_uring_abort_end_requests(ring);
                fuse_uring_stop_queues(ring);
        }

As Horst figure out, removing this check for queue_refs avoids the
issue. I'm rather sure that the check was needed during development and
avoided some null pointer derefs, as that is what I remember. But I
don't think it is needed anymore.


Thanks,
Bernd

