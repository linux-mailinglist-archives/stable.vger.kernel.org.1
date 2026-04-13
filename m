Return-Path: <stable+bounces-237059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFOXFsAf3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:54:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684663F02DD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BABF309F07D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8622311C2F;
	Mon, 13 Apr 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="qZc2ZzKg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlI80Wvq"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09EC30E0FD;
	Mon, 13 Apr 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098482; cv=none; b=tKhnVdMQUHX++q5qVK4uC8bFMgBYV7dClK9XxnfaJlvneBjllpSDyRcAF7ZXEl2UZZL/YU38J/AXQz6Ryt6eXwd9k10e9mgntveZ4hxqlvoOgPE7e4i7KxNyAqoMepUtC2yMclruGGlR/VB2pU16DsLI/69/VjnxRJ2U6EDWbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098482; c=relaxed/simple;
	bh=z5cNSyyxABqLMNA+BawZ7B04J0k2CSHrbB2aQOtRLpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4u3HuoXa0k65R5DVfYBJhHjsPw/RLu1Cn/KBtYNcEldOxqv7NUnoNXK8p2QDrqyP2fS1NC+lPoZ3S7ZCu7wbmpAapzbxF4JdtLBiJia2hH2d4AovHtM5qraiQePqMTv+NmpaUrioebLFtUFnfRWIVHETQmSvvmj9rdHfpcuECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=qZc2ZzKg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YlI80Wvq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C4A1140000F;
	Mon, 13 Apr 2026 12:41:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 12:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776098479;
	 x=1776184879; bh=aHQ5alJMCd2Xb2Ed40tjkOeQUkxlFYUdfhJaHmP5WtU=; b=
	qZc2ZzKgcIvI2djzzrK9oO3G7OwactcPq7eJk/KhSwtVWHWiuo9PZArUh06j8zyF
	T1Z2ECo367AdxIKmf60xMnjNZBA0RyXZydRHpz2v6LmpB6tNzzr0lIgtpg7z/EH5
	I1s6JruJhD2EA26589CiyCAUvyeU08owsvUXSQJOjSIpLVAB8yHV1QmjnNmYXbo1
	OfUpDJx/C87V1qdPm769pLaOYaWw8zKT/a+Imps2qmT2CCYTpLw7E9PdPCv+lioV
	OLdS8THyOFGUt3VUzbrU6i25r/5ju24HrQeOJRxRrW1nwfHq2wrPEoy4O6BqEvTn
	pJIb78GxPul7byyyPvj+3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776098479; x=
	1776184879; bh=aHQ5alJMCd2Xb2Ed40tjkOeQUkxlFYUdfhJaHmP5WtU=; b=Y
	lI80WvqscSRKgatedUOLjNBFaX8aYF96s654Ro2VY3JwMYlflkpvgetkfuCy9es2
	Qwme1CxwBIBZbitPRyWVX5Tou/xOWw4iwOpayoyO+Fd52VEOP3dc3XLFcN0JlaXY
	MF9bctEQVXfeaPEHpmAlJQHuU1ojCNxRIhlkbIsVThmzSFmNbv76Wh6/V6/VgH66
	m5WuLDdTk0uTj6JNlk+NtArjh+Ay8cBXRzHkerRl84R94iYRxfIV1hJvvrMHTuMx
	LVP1kPpjpN2ae35A8FaQazvXwomQHdsSt3tx0nzH/GTjINZiUhpzXsaAz7+DW9mj
	cUyxtWOgk0LdHJuCWFSmQ==
X-ME-Sender: <xms:rhzdaUPN-JWlmJypku9WKfL_g0WN0V29qwsQVPyzL_zrmOnVCDw1Tw>
    <xme:rhzdabZNv8gyTAgt748nJTZIwfQPFFME3dUnCrWlEX9krpjeKyW9DP0bFAi3ceKmQ
    l7yScnlkBaQ7zkjG2S-2f7CDI816qGJIAhpsPU6S6vMQR9QSeTc>
X-ME-Received: <xmr:rhzdab-WFJpHweBhfrDAdTDkoTSKDgom6H_yaSZBktkdVaLQ0DnRUXnT9Et8gAbN9-D6RUyn1LBPqtTaP7UVYCybcBye7oA-5tvZN3IJNxzIE6HVYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohephhhorhhsthessghirhhthhgvlhhmvghrrdguvgdprhgtphhtthho
    pegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsii
    gvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihesuggunhdrtghomhdprhgtphhtth
    hopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhsghi
    rhhthhgvlhhmvghrseguughnrdgtohhmpdhrtghpthhtohepfhhushgvqdguvghvvghlse
    hlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:rhzdaUSwEyzULpY_M73tuJ-ni1ueQj7u3TOTQ7HJDIGULpKckokMsw>
    <xmx:rhzdadddFV8_IoUbXNh5bICmd1L80K1Km9yH-uluP6CKXwvG_n3QGw>
    <xmx:rhzdaeQfEdOqYMvw18YryUr74w4GWF8x62OLi-dVsHBMVzRCinhdVw>
    <xmx:rhzdaRJEP7u6ziifTSFUlArl65tvmnl0iHskTMuglmyHlwPz05zqVw>
    <xmx:rxzdaVWK71TMRfSlShFhw9DMkdEkQUsbPxsTpBCtgKQYtxIqCGEVvFJU>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:41:17 -0400 (EDT)
Message-ID: <33b4048c-e940-4cf4-80b4-88bc1adbd4a9@bsbernd.com>
Date: Mon, 13 Apr 2026 18:41:16 +0200
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
Cc: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert
 <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Jian Huang Li <ali@ddn.com>,
 stable@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>,
 fuse-devel@lists.linux.dev
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com>
 <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
 <adlyjDaxLZyHcSun@fedora>
 <CAJnrk1Yb2ABBKFK=KMaU+W10FNazt+h93P445i1USXcN2W45Xw@mail.gmail.com>
 <f27651af-e5c0-4c3e-8baa-fa2d7232cb4d@bsbernd.com>
 <CAJnrk1YPrPXN74fgesg1dbqJJsmjPOJ_My_mYMUevJfSrmrECg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <CAJnrk1YPrPXN74fgesg1dbqJJsmjPOJ_My_mYMUevJfSrmrECg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-237059-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birthelmer.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bsbernd.com:dkim,bsbernd.com:email,bsbernd.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 684663F02DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/13/26 17:56, Joanne Koong wrote:
> On Sat, Apr 11, 2026 at 12:22 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 4/11/26 20:11, Joanne Koong wrote:
>>> On Fri, Apr 10, 2026 at 3:08 PM Horst Birthelmer <horst@birthelmer.de> wrote:
>>>>
>>>> On Fri, Apr 10, 2026 at 02:24:08PM -0700, Joanne Koong wrote:
>>>>> On Fri, Apr 10, 2026 at 4:26 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>
>>>>> Hi Bernd,
>>>>>
>>>>>> Hi Joanne,
>>>>>>
>>>>>> On 4/10/26 01:09, Joanne Koong wrote:
>>>>>>> On Thu, Apr 9, 2026 at 4:02 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 10/21/25 23:33, Bernd Schubert wrote:
>>>>>>>>> Do not merge yet, the current series has not been tested yet.
>>>>>>>>
>>>>>>>> I'm glad that that I was hesitating to apply it, the DDN branch had it
>>>>>>>> for ages and this patch actually introduced a possible fc->num_waiting
>>>>>>>> issue, because fc->uring->queue_refs might go down to 0 though
>>>>>>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
>>>>>>>> flush the queues without another addition.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Bernd and Jian,
>>>>>>>
>>>>>>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
>>>>>>> from fuse_uring_cancel" email was never delivered to my inbox, so I am
>>>>>>> just going to write my reply to that patch here instead, hope that's
>>>>>>> ok.
>>>>>>>
>>>>>>> Just to summarize, the race is that during unmount, fuse_abort() ->
>>>>>>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
>>>>>>> fuse_uring_entry_teardown() gets run but there may still be sqes that
>>>>>>> are being registered, which results in new ents that are created (and
>>>>>>> leaked) after the teardown logic has finished and the queues are
>>>>>>> stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
>>>>>>> never gets scheduled because at the time of teardown, queue->refs is 0
>>>>>>> as those sqes have not fully created the ents and grabbed refs yet.
>>>>>>> fuse_uring_destruct() runs during unmount, but this doesn't clean up
>>>>>>> the created ents because those registered ents got put on the
>>>>>>> ent_in_userspace list which fuse_uring_destruct() doesn't go through
>>>>>>> to free, resulting in those ents being leaked.
>>>>>>>
>>>>>>> The root cause of the race is that ents are being registered even when
>>>>>>> the queue is already stopped/dead. I think if we at registration time
>>>>>>> check the queue state before calling fuse_uring_prepare_cancel(), we
>>>>>>> eliminate the race altogether. If we see that the abort path has
>>>>>>> already triggered (eg queue->stopped == true), we manually free the
>>>>>>> ent and return an error instead of adding it to a list, eg
>>>>>>>
>>>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>>>>> index d88a0c05434a..351c19150aae 100644
>>>>>>> --- a/fs/fuse/dev_uring.c
>>>>>>> +++ b/fs/fuse/dev_uring.c
>>>>>>> @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
>>>>>>> int current_qid)
>>>>>>>  /*
>>>>>>>   * fuse_uring_req_fetch command handling
>>>>>>>   */
>>>>>>> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>>>>>>> +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
>>>>>>>                                    struct io_uring_cmd *cmd,
>>>>>>>                                    unsigned int issue_flags)
>>>>>>>  {
>>>>>>> @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
>>>>>>> fuse_ring_ent *ent,
>>>>>>>         struct fuse_conn *fc = ring->fc;
>>>>>>>         struct fuse_iqueue *fiq = &fc->iq;
>>>>>>>
>>>>>>> +       spin_lock(&queue->lock);
>>>>>>> +       /* abort teardown path is running or has run */
>>>>>>> +       if (queue->stopped) {
>>>>>>> +               spin_unlock(&queue->lock);
>>>>>>> +               atomic_dec(&ring->queue_refs);
>>>>>>> +               kfree(ent);
>>>>>>> +               return -ECONNABORTED;
>>>>>>> +       }
>>>>>>> +       spin_unlock(&queue->lock);
>>>>>>> +
>>>>>>>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
>>>>>>>
>>>>>>>         spin_lock(&queue->lock);
>>>>>>> @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
>>>>>>> fuse_ring_ent *ent,
>>>>>>>                         wake_up_all(&fc->blocked_waitq);
>>>>>>>                 }
>>>>>>>         }
>>>>>>> +       return 0;
>>>>>>>  }
>>>>>>>
>>>>>>>  /*
>>>>>>> @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>>>>>>>         if (IS_ERR(ent))
>>>>>>>                 return PTR_ERR(ent);
>>>>>>>
>>>>>>> -       fuse_uring_do_register(ent, cmd, issue_flags);
>>>>>>> -
>>>>>>> -       return 0;
>>>>>>> +       return fuse_uring_do_register(ent, cmd, issue_flags);
>>>>>>>  }
>>>>>>>
>>>>>>> There's the scenario where the abort path's "queue->stopped = true"
>>>>>>> gets set right between when we drop the queue lock and before we call
>>>>>>> fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
>>>>>>> logic that was called before fuse_uring_do_register() has already
>>>>>>> grabbed the ref on ring->queue_refs, which means in the abort path,
>>>>>>> the async teardown (fuse_uring_async_stop_queues()) work is guaranteed
>>>>>>> to run and clean up / free the entry.
>>>>>>
>>>>>>
>>>>>> I don't think your changes are needed, it should be handled by
>>>>>> IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where the
>>>>>> initial leak was - these commands came after abort and
>>>>>> fuse_uring_cancel() in linux upstream then puts the entries onto the
>>>>>> &queue->ent_in_userspace list.
>>>>>
>>>>> I think there are still races if we handle it in fuse_uring_cancel()
>>>>> that still leak the ent, eg even with the fuse_uring_abort()
>>>>> queue_refs gating taken out in the original (jian's) patch:
>>>>> * thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() ->
>>>>> kzalloc, sets up the entry but hasn't called
>>>>> atomic_inc(&ring->queue_refs) yet
>>>>>   concurrently on another thread, thread B: fuse_uring_cancel()
>>>>> ->fuse_uring_entry_teardown() ->
>>>>> atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs down
>>>>> to 0
>>>>>   At this instant, queue_Refs == 0. fuse_uring_stop_queues() ->
>>>>> teardown entries (nothing left) -> checks "if
>>>>> atomic_read(&ring->queue_refs) > 0", sees this is false, and skips
>>>>> scheduling any async teardown work
>>>>>   thread A calls atomic_inc(&ring->queue_refs) for the new ent,
>>>>> queue_refs is now 1, the ent is now placed on the ent_avail_queue, but
>>>>> it's never torn down.
>>>>>   the ent is leaked and there's also a hang now when we hit
>>>>> fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queues()
>>>>> where it sleeps and is never woken since it's waiting for queue refs
>>>>> to drop to 0
>>>>>
>>>>> imo, the change proposed in my last message is more robust and handles
>>>>> this case since it guarantees the async teardown worker will be
>>>>> running (since it does the queue state check after the ent has grabbed
>>>>> the queue ref).
>>>>
>>>> Ok so you rely on the fact that fuse_abort_conn() will call
>>>> fuse_uring_abort() and that sets queue->stopped.
>>>> This could work, but I would still remove the check for
>>>> queue_refs > 0 in fuse_uring_abort(), since it just complicates things
>>>> for no real reason.
>>>>
>>>>>
>>>>> btw, there's also another (separate) race, which neither of our
>>>>> approaches solve lol. This is the situation where fuse_uring_cancel()
>>>>> runs right after we call fuse_uring_prepare_cancel() in
>>>>> fuse_uring_do_register() but before we have set the ent state to
>>>>> FRRS_AVAILABLE. The ent gets leaked and continues to be used even
>>>>> though it's canceled, which may lead to use-after-frees. This probably
>>>>> requires a separate fix, I haven't had time to look much at it yet.
>>>>> Maybe Horst or Jian has looked at this?
>>>>>
>>>> Interesting scenario ... haven't seen that one so far.
>>>
>>> Looking at the io-uring code for how cancels are handled
>>> (io_uring_try_cancel_uring_cmd()), I was wrong in my prevoius message
>>> about these two races. io-uring already serializes this for us, the
>>> io-uring code unconditionally grabs the uring lock before invoking
>>> file->f_op->uring_cmd() in the cancel path, which means there's no
>>> interweaving between the fuse registration logic and the cancel logic.
>>>
>>> But I still think the more robust/resilient fix for the memleak is to
>>> do the preemptive checking at registration time. I think this fixes
>>> races in the force unmount case between registration and abort that is
>>> unresolved with the original patch. With the original patch w/
>>> fuse_uring_abort()'s queue_refs check removed, I think we can still
>>> hit this:
>>
>> I need to go through the other messages, but I still do not see any
>> registration time leak. At least not with the additional patch we have
>> here to tear down entries through IO_URING_F_CANCEL
> 
> The issue is the hang, not the leak.
> 
>>
>>
>> Sorry, besides also looking into ublk now (for main work), also in
>> progress to fix an issue with reduced queues and also still on the
>> libfuse part of sync-init....
>>
>>>
>>> registration vs abort:
>>>   - thread a: io_uring_enter -> register sqe ->
>>> fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
>>> yet
>>>   - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
>>> fuse_uring_abort() -> fuse_uring_stop_queues() ->
>>> fuse_uring_teardown_entries(), skips scheduling async teardown work
>>> since queue_refs == 0, returns
>>>   - thread a: grabs the queue_ref, queue_ref is now 1, rest of
>>> fuse_uring_do_register() logic executes, ent is now marked cancelable,
>>> ent state is now available, ent is placed on available queue
>>>   - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
>>> and does a "wait_event(ring->stop_waitq,
>>> atomic_read(&ring->queue_refs) == 0);" which hangs since the waiter
>>> never gets woken
>>>
>>> whereas if we check preemptively at registration time, we explicjtly
>>> free the ent and release the queue_ref. I think the preemptive check
>>> needs to check ring->fc->connected though instead of queue->stopped,
>>> because there's the race where abort and stop_queues() may have been
>>> triggered before the register sqe path does queue creation. I'm hoping
>>> there's a better solution than having to grab the fc lock and checking
>>> fc->connected though, will try to look more at this next week.
>>>
>>> I think we can hit this hang on a ring creation vs abort race as well:
>>> * thread a: fuse_uring_cmd() gets called, passes fc->aborted check (not set yet)
>>> * thread b: abort is called, calls fuse_uring_abort(),
>>> fuse_uring_abort() is a no-op since ring == NULL right now
>>> * thread a: creates ring, creates queue, creates entry
>>> - if thread a takes the queue_ref count before the rest of the abort
>>> logic, we end up with the same hang as the situation above.
>>
>> IO-uring sends IO_URING_F_CANCEL for every registred command. We never
>> had a leak you describe. Upstream has a leak because it does not free
>> 'queue->ent_in_userspace' in fuse_uring_destruct. I'm fine with the
>> addition in fuse_uring_cancel() (although the just freeing the entries
>> in the list is much simpler and race free).
>>
>> Please let's not make it anymore complex.
> 
> The issue is the hang, not the ent leak. What I'm trying to say is
> that the original patch submitted fixes one issue (kfreeing the ents)
> but doesn't fix the registration vs abort race, whereas the preemptive
> registration check fixes the leaked ents and the race.
> 
> With the original patch, the umount thread still gets stuck
> permanently in TASK_UNINTERRUPTIBLE during the race. Even if the admin
> kills the daemon, the umount thread still holds the mount ref, which
> means delayed_release -> fuse_uring_destruct() will never get called
> and the entire ring gets leaked. If the original patch adds a
> wake_up_all() when queue_refs hits 0 in teardown, then killing the
> daemon does resolve it (as it'll wake up the umount thread), but the
> force-unmount still blocks in TASK_UNINTERRUPTIBLE state until the
> admin kills the server. The preemptive registration check is the more
> robust fix imo.

Hmm, I think you are right for normal umount, for daemon kill
IO_URING_F_CANCEL handles it with the patch in this discussion - io-uring 
will send IO_URING_F_CANCEL in a loop until io_uring_cmd_done() done is
called. 
For plain umount I think it better to check for connection abort after
ring->queue_refs was increased, i.e. up to the last moment when
fuse_abort_conn() / fuse_wait_aborted() would wait. With the patch you 
suggested, I think the connection could be aborted after the check and
the ring entry might not be in any list yet, when fuse_uring_stop_queues()
gets called and queue stop would be a no-op.

How about this

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 46812149bb2e..575b1042719c 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1445,6 +1445,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
                           struct fuse_ring_queue *queue)
 {
        struct fuse_ring *ring = queue->ring;
+       struct fuse_conn *fc = ring->fc;
        struct fuse_ring_ent *ent;
        size_t payload_size;
        struct iovec iov[FUSE_URING_IOV_SEGS];
@@ -1487,6 +1488,19 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
        ent->payload = iov[1].iov_base;
 
        atomic_inc(&ring->queue_refs);
+
+       spin_lock(&fc->lock);
+       atomic_inc(&ring->queue_refs);
+
+       /* check if the disconnected while creating the entry */
+       if (!fc->connected) {
+               atomic_dec(&ring->queue_refs);
+               err = -ENOTCONN;
+               wake_up_all(&ring->stop_waitq);
+       }
+       spin_unlock(&fc->lock);
+       if (err)
+               goto error;
        return ent;
 
 error:



Thanks,
Bernd


