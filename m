Return-Path: <stable+bounces-237681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGovHjp73WmsewkAu9opvQ
	(envelope-from <stable+bounces-237681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:24:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0803F43EB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 987BA303C4DF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316163644BE;
	Mon, 13 Apr 2026 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXc0mqfp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3A314D1F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122666; cv=pass; b=G9WLvQ8ad9dUqMLVeyxDSiyug8to9wE/OUjIRrAeYeC4SfveYZYUjrVhCOcpSi08ZE9kaI84JZqXxfeOpaEFdyi0QgYzuuY0AW8wzmCpNLOlN1qDFJxUjdGZKSSnE7C8fUQiZY5pydhHz4MlkKA19pap/o6nXpOdbx8dNC08oRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122666; c=relaxed/simple;
	bh=FVH/YpO4WAbxP79NxnxdTYSlv7qQAC/A3cb3gMfb3Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imFiS/Le27PjPMNypUfBgJZKtJyzejVO6Mr3AJdWO2aB1Ug+oybNhfqUbJDpa67AqyYCTI4YLYDkUeJyPuTWQQjd3TlWk8gBzckAOaWutmir1II9m0QlkGRBTq9vz92ac+pRiXh8VZmqWQciN0DPiSEzLWaXLp/SK+9qcGzy67E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXc0mqfp; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ad135063so47705905e9.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776122662; cv=none;
        d=google.com; s=arc-20240605;
        b=bP5qOqhtZz6D160IIOqcSKIxItTjmDXUClGlhed38TT2Y9MJ5ycLTzKTbSI3uEYBBr
         XXBGY1hKcFxHX0P9avX6k2+914LKQMbKzAj2bLC4I+WKeDhfyT0my2pzIDRduDploohT
         unV2ZxfIfdVJJTkkXMYuadWPlvhRgkIKhmfqmH93TgRI9miA0r68VePCFLVOHz8fHehO
         0o7lxjTteKEJWJlSQZULwDDaqMZT4QTRGAvbNYdnZZJeyeXYxwjqGjLhEczUTdeiO6oP
         0EQHjUZJUhSJ7aPlmXzNdlZ8Hf1HnQQqZHh7fZ4joP9pDTmi1LDeyMJQTCQ+o4I1eIUM
         cmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GVt5hKc952rgYTqxHgjnBwdZ484HaiCYH8pIIn/FsE=;
        fh=7YsDDGcO1KqPsGRmbbMxsufxT8+krgwx3rpEXtrAaFs=;
        b=gnLggem/LEelq5fLm1rXoyEVMvGK1/2/puLRrZHBdtHb6Emh8SvYTNYpnat8MTKXxM
         i7wrn0PjQKRKp7k8M5vExOYau/Z28MT9Cp8t3KtBjFppwEgR/91TvpT7g+0kNm2gYnzT
         by0s6qkjun+6lttFrx86g3S2WLF0B5TlOTHcDdOqn0nA+RniqK80V75ekySQZkuRy84X
         Bdy1QOQtOfFxPrICgrZpVgLLgiEG8msekU4Bu8yhMMKQUgmeauXr1PG+r78blQcDZgfR
         C1WnUme7i1EHrSH/BWq3iLSVCeqL4OeYt6d54U671KNZ1o3f/97A2GeYi7CWG4uai3wA
         I81w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776122662; x=1776727462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GVt5hKc952rgYTqxHgjnBwdZ484HaiCYH8pIIn/FsE=;
        b=nXc0mqfp236268GxFqpCqIkJjKwch7wkxT1Nkl43eOGn95EAAo1MayY6cq8fHO7Eh3
         6DIeHMH0emR2M7kaZSEDhJveaPyCi/y2QA42zjOqhfG3ApIj2HiIpF9hVFt7Z2UgzY7p
         JrChn4fn1d1oJZQ2w5TfilqROBaCtyoufHlJ5xo9DNlpJ3K1r9QVR+IbFItS4r0FWL4F
         mbOV+li8qML5eofzYnNicEh2sYDu9PtHvUvM6SRNWTmnIGL/09DqgN/0ZXq5gDGuSA7P
         OVgVjRRG8qEOArMYcqYJA68GoDYfNqp5eozIVZ1dIURjESKxAd8LeBmVQfcX64RTrrXZ
         0YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776122662; x=1776727462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3GVt5hKc952rgYTqxHgjnBwdZ484HaiCYH8pIIn/FsE=;
        b=bR9/9KQAlNKVYzA2+dqZOb/jnKm7UBfLRcG37rAgAsc+CsQOTSWeKrTD9YkA5Dwtzy
         DyMPiYgnbz7tKBaNvZ4AxKGpUyhsSXPNR3jp5R1+uQku5W7TZFbK5VzaIMmYCDcUgOpu
         tjt9C9K5iTyJrX9yzeBYSLF4ZMiBiLRFI344lW0FvH0edx0RzFRP/0CMuQ7PkEarSezJ
         fyWoMCB3S3kJhZZsKqjd+LG5xMHqrVa1vf334s3mrvU61tmXQ54jn0TGN9Xd9SjM7r1h
         U0DjJ7uiWMn6c5iXWSHkFaFTb4QQI9Q5U5FwWGRE+cXMCPYVCAiy7J7hz/YaxW4na5Sm
         3Hig==
X-Forwarded-Encrypted: i=1; AFNElJ8OIRSBGugiCGmtFFZx1vnG8wimWnfrTyDnleDcxPuYJ0NNrzSlg5Ow5QFghuNmekEHu6YSx6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuttW9YFBDD1S8dPP6HzTfPH3k919TnBwX4egkWXPDiDl/wVwm
	bJlD8NzJsy8F4pmZkFlItu3GaJIT8rRjcz88V9+LH4RWOlK619/OIx3+ATt8YdV+L/T3mI/r56E
	mhymB3YZacMkwbV2xlqFmUx0WMlUEkR4=
X-Gm-Gg: AeBDietd1JhxRwymii89X7uutkHj1oGp+XSRq0LjUxbxTEzvXjK1IC/y8GA4wI+Em+x
	6SuTOeZixKZ4A0Fa1OzeQJNxfJRJ4qCAVDpts86rWLoWWKNs75N6qLHW3PEjb1H8TjKpmLKgY/D
	muCmjz6Ax81FnvIdRELuOQKj60euKoWGwRRErXjVdL6dZ4MaqCQqdEzlB6c9Csx5ewW9vHLode8
	XoikHNlaLw967HzQYHQthoobMM4IiCE8d8zPj2/7h+V9VXbEP2PnCb1Enti5bFYJbYTfuHX9QWw
	jc/FXA==
X-Received: by 2002:a05:600c:a11c:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-488d67fa40fmr146742575e9.8.1776122661299; Mon, 13 Apr 2026
 16:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com> <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
 <adlyjDaxLZyHcSun@fedora> <CAJnrk1Yb2ABBKFK=KMaU+W10FNazt+h93P445i1USXcN2W45Xw@mail.gmail.com>
 <f27651af-e5c0-4c3e-8baa-fa2d7232cb4d@bsbernd.com> <CAJnrk1YPrPXN74fgesg1dbqJJsmjPOJ_My_mYMUevJfSrmrECg@mail.gmail.com>
 <33b4048c-e940-4cf4-80b4-88bc1adbd4a9@bsbernd.com>
In-Reply-To: <33b4048c-e940-4cf4-80b4-88bc1adbd4a9@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Apr 2026 16:24:09 -0700
X-Gm-Features: AQROBzCUobeaGuIhC9Hsao_JGOw1NfihVS-jrAXsH1qSHDmBfNKYFi6oDAhFo5c
Message-ID: <CAJnrk1ZxijgYVTwzgX3LHoePtyOmOz-1y7swbgquT3_rxrLpvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate teardown
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237681-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E0803F43EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 9:41=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 4/13/26 17:56, Joanne Koong wrote:
> > On Sat, Apr 11, 2026 at 12:22=E2=80=AFPM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> >>
> >>
> >>
> >> On 4/11/26 20:11, Joanne Koong wrote:
> >>> On Fri, Apr 10, 2026 at 3:08=E2=80=AFPM Horst Birthelmer <horst@birth=
elmer.de> wrote:
> >>>>
> >>>> On Fri, Apr 10, 2026 at 02:24:08PM -0700, Joanne Koong wrote:
> >>>>> On Fri, Apr 10, 2026 at 4:26=E2=80=AFAM Bernd Schubert <bernd@bsber=
nd.com> wrote:
> >>>>>>
> >>>>> Hi Bernd,
> >>>>>
> >>>>>> Hi Joanne,
> >>>>>>
> >>>>>> On 4/10/26 01:09, Joanne Koong wrote:
> >>>>>>> On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbe=
rnd.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 10/21/25 23:33, Bernd Schubert wrote:
> >>>>>>>>> Do not merge yet, the current series has not been tested yet.
> >>>>>>>>
> >>>>>>>> I'm glad that that I was hesitating to apply it, the DDN branch =
had it
> >>>>>>>> for ages and this patch actually introduced a possible fc->num_w=
aiting
> >>>>>>>> issue, because fc->uring->queue_refs might go down to 0 though
> >>>>>>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop=
 and
> >>>>>>>> flush the queues without another addition.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi Bernd and Jian,
> >>>>>>>
> >>>>>>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory le=
ak
> >>>>>>> from fuse_uring_cancel" email was never delivered to my inbox, so=
 I am
> >>>>>>> just going to write my reply to that patch here instead, hope tha=
t's
> >>>>>>> ok.
> >>>>>>>
> >>>>>>> Just to summarize, the race is that during unmount, fuse_abort() =
->
> >>>>>>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ...=
 ->
> >>>>>>> fuse_uring_entry_teardown() gets run but there may still be sqes =
that
> >>>>>>> are being registered, which results in new ents that are created =
(and
> >>>>>>> leaked) after the teardown logic has finished and the queues are
> >>>>>>> stopped/dead. The async teardown work (fuse_uring_async_stop_queu=
es())
> >>>>>>> never gets scheduled because at the time of teardown, queue->refs=
 is 0
> >>>>>>> as those sqes have not fully created the ents and grabbed refs ye=
t.
> >>>>>>> fuse_uring_destruct() runs during unmount, but this doesn't clean=
 up
> >>>>>>> the created ents because those registered ents got put on the
> >>>>>>> ent_in_userspace list which fuse_uring_destruct() doesn't go thro=
ugh
> >>>>>>> to free, resulting in those ents being leaked.
> >>>>>>>
> >>>>>>> The root cause of the race is that ents are being registered even=
 when
> >>>>>>> the queue is already stopped/dead. I think if we at registration =
time
> >>>>>>> check the queue state before calling fuse_uring_prepare_cancel(),=
 we
> >>>>>>> eliminate the race altogether. If we see that the abort path has
> >>>>>>> already triggered (eg queue->stopped =3D=3D true), we manually fr=
ee the
> >>>>>>> ent and return an error instead of adding it to a list, eg
> >>>>>>>
> >>>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>>>>>> index d88a0c05434a..351c19150aae 100644
> >>>>>>> --- a/fs/fuse/dev_uring.c
> >>>>>>> +++ b/fs/fuse/dev_uring.c
> >>>>>>> @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *r=
ing,
> >>>>>>> int current_qid)
> >>>>>>>  /*
> >>>>>>>   * fuse_uring_req_fetch command handling
> >>>>>>>   */
> >>>>>>> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> >>>>>>> +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> >>>>>>>                                    struct io_uring_cmd *cmd,
> >>>>>>>                                    unsigned int issue_flags)
> >>>>>>>  {
> >>>>>>> @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
> >>>>>>> fuse_ring_ent *ent,
> >>>>>>>         struct fuse_conn *fc =3D ring->fc;
> >>>>>>>         struct fuse_iqueue *fiq =3D &fc->iq;
> >>>>>>>
> >>>>>>> +       spin_lock(&queue->lock);
> >>>>>>> +       /* abort teardown path is running or has run */
> >>>>>>> +       if (queue->stopped) {
> >>>>>>> +               spin_unlock(&queue->lock);
> >>>>>>> +               atomic_dec(&ring->queue_refs);
> >>>>>>> +               kfree(ent);
> >>>>>>> +               return -ECONNABORTED;
> >>>>>>> +       }
> >>>>>>> +       spin_unlock(&queue->lock);
> >>>>>>> +
> >>>>>>>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> >>>>>>>
> >>>>>>>         spin_lock(&queue->lock);
> >>>>>>> @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
> >>>>>>> fuse_ring_ent *ent,
> >>>>>>>                         wake_up_all(&fc->blocked_waitq);
> >>>>>>>                 }
> >>>>>>>         }
> >>>>>>> +       return 0;
> >>>>>>>  }
> >>>>>>>
> >>>>>>>  /*
> >>>>>>> @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_ur=
ing_cmd *cmd,
> >>>>>>>         if (IS_ERR(ent))
> >>>>>>>                 return PTR_ERR(ent);
> >>>>>>>
> >>>>>>> -       fuse_uring_do_register(ent, cmd, issue_flags);
> >>>>>>> -
> >>>>>>> -       return 0;
> >>>>>>> +       return fuse_uring_do_register(ent, cmd, issue_flags);
> >>>>>>>  }
> >>>>>>>
> >>>>>>> There's the scenario where the abort path's "queue->stopped =3D t=
rue"
> >>>>>>> gets set right between when we drop the queue lock and before we =
call
> >>>>>>> fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
> >>>>>>> logic that was called before fuse_uring_do_register() has already
> >>>>>>> grabbed the ref on ring->queue_refs, which means in the abort pat=
h,
> >>>>>>> the async teardown (fuse_uring_async_stop_queues()) work is guara=
nteed
> >>>>>>> to run and clean up / free the entry.
> >>>>>>
> >>>>>>
> >>>>>> I don't think your changes are needed, it should be handled by
> >>>>>> IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where th=
e
> >>>>>> initial leak was - these commands came after abort and
> >>>>>> fuse_uring_cancel() in linux upstream then puts the entries onto t=
he
> >>>>>> &queue->ent_in_userspace list.
> >>>>>
> >>>>> I think there are still races if we handle it in fuse_uring_cancel(=
)
> >>>>> that still leak the ent, eg even with the fuse_uring_abort()
> >>>>> queue_refs gating taken out in the original (jian's) patch:
> >>>>> * thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() ->
> >>>>> kzalloc, sets up the entry but hasn't called
> >>>>> atomic_inc(&ring->queue_refs) yet
> >>>>>   concurrently on another thread, thread B: fuse_uring_cancel()
> >>>>> ->fuse_uring_entry_teardown() ->
> >>>>> atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs do=
wn
> >>>>> to 0
> >>>>>   At this instant, queue_Refs =3D=3D 0. fuse_uring_stop_queues() ->
> >>>>> teardown entries (nothing left) -> checks "if
> >>>>> atomic_read(&ring->queue_refs) > 0", sees this is false, and skips
> >>>>> scheduling any async teardown work
> >>>>>   thread A calls atomic_inc(&ring->queue_refs) for the new ent,
> >>>>> queue_refs is now 1, the ent is now placed on the ent_avail_queue, =
but
> >>>>> it's never torn down.
> >>>>>   the ent is leaked and there's also a hang now when we hit
> >>>>> fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queues(=
)
> >>>>> where it sleeps and is never woken since it's waiting for queue ref=
s
> >>>>> to drop to 0
> >>>>>
> >>>>> imo, the change proposed in my last message is more robust and hand=
les
> >>>>> this case since it guarantees the async teardown worker will be
> >>>>> running (since it does the queue state check after the ent has grab=
bed
> >>>>> the queue ref).
> >>>>
> >>>> Ok so you rely on the fact that fuse_abort_conn() will call
> >>>> fuse_uring_abort() and that sets queue->stopped.
> >>>> This could work, but I would still remove the check for
> >>>> queue_refs > 0 in fuse_uring_abort(), since it just complicates thin=
gs
> >>>> for no real reason.
> >>>>
> >>>>>
> >>>>> btw, there's also another (separate) race, which neither of our
> >>>>> approaches solve lol. This is the situation where fuse_uring_cancel=
()
> >>>>> runs right after we call fuse_uring_prepare_cancel() in
> >>>>> fuse_uring_do_register() but before we have set the ent state to
> >>>>> FRRS_AVAILABLE. The ent gets leaked and continues to be used even
> >>>>> though it's canceled, which may lead to use-after-frees. This proba=
bly
> >>>>> requires a separate fix, I haven't had time to look much at it yet.
> >>>>> Maybe Horst or Jian has looked at this?
> >>>>>
> >>>> Interesting scenario ... haven't seen that one so far.
> >>>
> >>> Looking at the io-uring code for how cancels are handled
> >>> (io_uring_try_cancel_uring_cmd()), I was wrong in my prevoius message
> >>> about these two races. io-uring already serializes this for us, the
> >>> io-uring code unconditionally grabs the uring lock before invoking
> >>> file->f_op->uring_cmd() in the cancel path, which means there's no
> >>> interweaving between the fuse registration logic and the cancel logic=
.
> >>>
> >>> But I still think the more robust/resilient fix for the memleak is to
> >>> do the preemptive checking at registration time. I think this fixes
> >>> races in the force unmount case between registration and abort that i=
s
> >>> unresolved with the original patch. With the original patch w/
> >>> fuse_uring_abort()'s queue_refs check removed, I think we can still
> >>> hit this:
> >>
> >> I need to go through the other messages, but I still do not see any
> >> registration time leak. At least not with the additional patch we have
> >> here to tear down entries through IO_URING_F_CANCEL
> >
> > The issue is the hang, not the leak.
> >
> >>
> >>
> >> Sorry, besides also looking into ublk now (for main work), also in
> >> progress to fix an issue with reduced queues and also still on the
> >> libfuse part of sync-init....
> >>
> >>>
> >>> registration vs abort:
> >>>   - thread a: io_uring_enter -> register sqe ->
> >>> fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
> >>> yet
> >>>   - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
> >>> fuse_uring_abort() -> fuse_uring_stop_queues() ->
> >>> fuse_uring_teardown_entries(), skips scheduling async teardown work
> >>> since queue_refs =3D=3D 0, returns
> >>>   - thread a: grabs the queue_ref, queue_ref is now 1, rest of
> >>> fuse_uring_do_register() logic executes, ent is now marked cancelable=
,
> >>> ent state is now available, ent is placed on available queue
> >>>   - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
> >>> and does a "wait_event(ring->stop_waitq,
> >>> atomic_read(&ring->queue_refs) =3D=3D 0);" which hangs since the wait=
er
> >>> never gets woken
> >>>
> >>> whereas if we check preemptively at registration time, we explicjtly
> >>> free the ent and release the queue_ref. I think the preemptive check
> >>> needs to check ring->fc->connected though instead of queue->stopped,
> >>> because there's the race where abort and stop_queues() may have been
> >>> triggered before the register sqe path does queue creation. I'm hopin=
g
> >>> there's a better solution than having to grab the fc lock and checkin=
g
> >>> fc->connected though, will try to look more at this next week.
> >>>
> >>> I think we can hit this hang on a ring creation vs abort race as well=
:
> >>> * thread a: fuse_uring_cmd() gets called, passes fc->aborted check (n=
ot set yet)
> >>> * thread b: abort is called, calls fuse_uring_abort(),
> >>> fuse_uring_abort() is a no-op since ring =3D=3D NULL right now
> >>> * thread a: creates ring, creates queue, creates entry
> >>> - if thread a takes the queue_ref count before the rest of the abort
> >>> logic, we end up with the same hang as the situation above.
> >>
> >> IO-uring sends IO_URING_F_CANCEL for every registred command. We never
> >> had a leak you describe. Upstream has a leak because it does not free
> >> 'queue->ent_in_userspace' in fuse_uring_destruct. I'm fine with the
> >> addition in fuse_uring_cancel() (although the just freeing the entries
> >> in the list is much simpler and race free).
> >>
> >> Please let's not make it anymore complex.
> >
> > The issue is the hang, not the ent leak. What I'm trying to say is
> > that the original patch submitted fixes one issue (kfreeing the ents)
> > but doesn't fix the registration vs abort race, whereas the preemptive
> > registration check fixes the leaked ents and the race.
> >
> > With the original patch, the umount thread still gets stuck
> > permanently in TASK_UNINTERRUPTIBLE during the race. Even if the admin
> > kills the daemon, the umount thread still holds the mount ref, which
> > means delayed_release -> fuse_uring_destruct() will never get called
> > and the entire ring gets leaked. If the original patch adds a
> > wake_up_all() when queue_refs hits 0 in teardown, then killing the
> > daemon does resolve it (as it'll wake up the umount thread), but the
> > force-unmount still blocks in TASK_UNINTERRUPTIBLE state until the
> > admin kills the server. The preemptive registration check is the more
> > robust fix imo.
>
> Hmm, I think you are right for normal umount, for daemon kill
> IO_URING_F_CANCEL handles it with the patch in this discussion - io-uring
> will send IO_URING_F_CANCEL in a loop until io_uring_cmd_done() done is
> called.
> For plain umount I think it better to check for connection abort after
> ring->queue_refs was increased, i.e. up to the last moment when
> fuse_abort_conn() / fuse_wait_aborted() would wait. With the patch you

I had mentioned this in my previous email, "the preemptive check needs
to check ring->fc->connected though instead of queue->stopped, because
there's the race where abort and stop_queues() may have been triggered
before the register sqe path does queue creation."

> suggested, I think the connection could be aborted after the check and
> the ring entry might not be in any list yet, when fuse_uring_stop_queues(=
)
> gets called and queue stop would be a no-op.

If the connection is aborted after the check and the ring ent isn't on
any list yet, I think that's fine. The async teardown worker is
already guaranteed to be scheduled (since the ring->fc->connected
check is done after the ent grabs the queue ref).

The actual problem is that if the register sqe is the first sqe for
that queue and will trigger queue creation, then if the abort logic
runs first before the queue creation, it will skip all the logic in
fuse_uring_abort_end_requests() since "queue =3D
READ_ONCE(ring->queues[qid]);" is a null queue, and consequently
queue->stopped will never have been set to true.

>
> How about this
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 46812149bb2e..575b1042719c 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1445,6 +1445,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd=
,
>                            struct fuse_ring_queue *queue)
>  {
>         struct fuse_ring *ring =3D queue->ring;
> +       struct fuse_conn *fc =3D ring->fc;
>         struct fuse_ring_ent *ent;
>         size_t payload_size;
>         struct iovec iov[FUSE_URING_IOV_SEGS];
> @@ -1487,6 +1488,19 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cm=
d,
>         ent->payload =3D iov[1].iov_base;
>
>         atomic_inc(&ring->queue_refs);
> +
> +       spin_lock(&fc->lock);
> +       atomic_inc(&ring->queue_refs);
> +
> +       /* check if the disconnected while creating the entry */
> +       if (!fc->connected) {
> +               atomic_dec(&ring->queue_refs);
> +               err =3D -ENOTCONN;
> +               wake_up_all(&ring->stop_waitq);
> +       }
> +       spin_unlock(&fc->lock);
> +       if (err)
> +               goto error;
>         return ent;
>

I don't think it matters if this is within
fuse_uring_create_ring_ent() instead of fuse_uring_do_register(). I
put the logic inside of fuse_uring_do_register() because that seemed
logically cleaner to me (eg create_ent() is only responsible for ent
allocation/initialization logic, any race checks to halt rest of sqe
registration flow are outside that), though if you have a preference
to have it inside fuse_uring_create_ring_ent() that's fine by me. This
is waht I have locally:

Subject: [PATCH] fuse/uring: fix abort races with ring creation and ent
 registration

This fixes the following races:
registration vs. abort:
  - thread a: io_uring_enter -> register sqe ->
fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
yet
  - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
fuse_uring_abort() -> fuse_uring_stop_queues() ->
fuse_uring_teardown_entries(), skips scheduling async teardown work
since queue_refs =3D=3D 0, returns
  - thread a: grabs the queue_ref, queue_ref is now 1, rest of
fuse_uring_do_register() logic executes, ent is now marked cancelable,
ent state is now available, ent is placed on available queue
  - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
and does a "wait_event(ring->stop_waitq,
atomic_read(&ring->queue_refs) =3D=3D 0);" which hangs since the waiter
never gets woken

ring creation vs abort:
- thread a: fuse_uring_cmd() gets called, passes fc->aborted check (not
  set yet)
- thread b: abort is called, calls fuse_uring_abort(),
fuse_uring_abort() is a no-op since ring =3D=3D NULL right now
- thread a: creates ring, creates queue, creates entry
- if thread a takes the queue_ref count before the rest of the abort
logic, we end up with the same hang as the situation above.

This additionally addresses the ent memleak in the registration vs
cancel race in [1].

[1] https://lore.kernel.org/linux-fsdevel/20251021-io-uring-fixes-cancel-me=
m-leak-v1-0-26b78b2c973c@ddn.com/
---
 fs/fuse/dev_uring.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..4bbc71755cb8 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -243,6 +243,10 @@ static struct fuse_ring *fuse_uring_create(struct
fuse_conn *fc)
        max_payload_size =3D max(max_payload_size, fc->max_pages * PAGE_SIZ=
E);

        spin_lock(&fc->lock);
+       if (!fc->connected) {
+               spin_unlock(&fc->lock);
+               goto out_err;
+       }
        if (fc->ring) {
                /* race, another thread created the ring in the meantime */
                spin_unlock(&fc->lock);
@@ -974,7 +978,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
int current_qid)
 /*
  * fuse_uring_req_fetch command handling
  */
-static void fuse_uring_do_register(struct fuse_ring_ent *ent,
+static int fuse_uring_do_register(struct fuse_ring_ent *ent,
                                   struct io_uring_cmd *cmd,
                                   unsigned int issue_flags)
 {
@@ -983,6 +987,16 @@ static void fuse_uring_do_register(struct
fuse_ring_ent *ent,
        struct fuse_conn *fc =3D ring->fc;
        struct fuse_iqueue *fiq =3D &fc->iq;

+       spin_lock(&fc->lock);
+       /* abort teardown path is running or has run */
+       if (!fc->connected) {
+               spin_unlock(&fc->lock);
+               atomic_dec(&ring->queue_refs);
+               kfree(ent);
+               return -ECONNABORTED;
+       }
+       spin_unlock(&fc->lock);
+
        fuse_uring_prepare_cancel(cmd, issue_flags, ent);

        spin_lock(&queue->lock);
@@ -999,6 +1013,7 @@ static void fuse_uring_do_register(struct
fuse_ring_ent *ent,
                        wake_up_all(&fc->blocked_waitq);
                }
        }
+       return 0;
 }

 /*
@@ -1114,9 +1129,7 @@ static int fuse_uring_register(struct io_uring_cmd *c=
md,
        if (IS_ERR(ent))
                return PTR_ERR(ent);

-       fuse_uring_do_register(ent, cmd, issue_flags);
-
-       return 0;
+       return fuse_uring_do_register(ent, cmd, issue_flags);
 }

 /*
--
2.52.0

though I'll probably end up splitting this into two separate patches
when submitting. I don't think the wake_up_all(&ring->stop_waitq);
call is needed in the preemptive checking, as the async teardown work
will already take care of that.

Thanks,
Joanne

>  error:
>
>
>
> Thanks,
> Bernd
>

