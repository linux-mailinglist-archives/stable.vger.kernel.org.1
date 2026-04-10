Return-Path: <stable+bounces-235661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCaQLuZZ2WkuowgAu9opvQ
	(envelope-from <stable+bounces-235661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:13:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC623DC69F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D190230053DD
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31E391E7E;
	Fri, 10 Apr 2026 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEy7znA7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8577438E5E1
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851791; cv=pass; b=Oc9mCLBLYVmpUm0yCNKsdPX/eUtnqe8Ms9d+Ab8Nsc84Vdn2RpEzQa95T2y7AOtQxrHgAE1XLqim9gIqEpgYi3iPL5BpNSiauKFN1Wx4uSnr/i9Nv7QJrI3OVW63fDBo0ge3kLn8O79geEb8jHs9CB+ys3nNVyFwGrZhgtD8XGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851791; c=relaxed/simple;
	bh=ogOCvyyoZ9XSpNfyYtW2p4XJwVTVTXAMukOYXRQXI0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GASct//MpH/pUGR2RruA/+40IBNGIuPsvqaDyH6kWLw4Cj/fM8oxy9vKUoTj86l7NjLdOLXYqVmsiX0/xsWZ5eZ2dt+t+8YG8XQVRMiK+SE1SVstfMyRd/RrtppFlpccI8yVHuH3Sk6IDSNo5TX9tB6a+cAIXNurV26FOytyxWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEy7znA7; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so31198975e9.2
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 13:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775851788; cv=none;
        d=google.com; s=arc-20240605;
        b=P9JeJ8+p5klETBe8eaEhTZ/boeBWLZpBncLe1pmEMgFbQtr7W2/MCBmhRiYh0ypnKE
         JKhKaSpIrZHwcxejxvHnwotOAiCR/ASGow0HFen9imljvDM40qzYLrkjpDXDHaT0/RN/
         BZG6n3NvUTQJ/w5NjlvufEZMcOF+WOXVLOQU0s5SwUbNxKYrwh3DafFv742sGxoectTE
         hu2z57bvVL5tscrUfpzEpgf7/+LlgzcDucf5bpT1vwPMVnbySLEDQJ2NPUL6dUsTwmDX
         oih7OItYwwoioCQiiJWAvXKWK2vqz8/KdemZRrtrt4VixZUKFfG0pICbFTQ3n0t6iXhi
         I0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogOCvyyoZ9XSpNfyYtW2p4XJwVTVTXAMukOYXRQXI0I=;
        fh=+Ct1OV20ZM7k9N/DDz0OGIKNQF4NgH5V/+5IfT/ZmpQ=;
        b=eEy9YohdBjrIKkp6oyjSjzb928GGdDpZJNyceC43omo10tz+YMXWXymdEARJGfeInT
         D3wUUj5MZI8pjMiJQIs1h7bCy82l/aWZY/FGqsjygNgx9uqKGmwf8qupYbN9r9kdUlJx
         v5OF7AfbcullaBkq2YvkrPL3hfJiQcl4qV8aXDN25oMtrsjaJLl4WK2oIZE5gzfHx2HB
         WffTIa66ZP/IlACGCMLuy+MTV0qE+m45mSbNZHA8zcUehUYoADiQOJeHuRBbJpGGLcBd
         Q02IL520g9xsJVfJvcn5oYDgHKI4xF93xCUYsC5q+Ek05hXXxLcJf8psgk4GGvuwdCcV
         xz3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775851788; x=1776456588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogOCvyyoZ9XSpNfyYtW2p4XJwVTVTXAMukOYXRQXI0I=;
        b=QEy7znA7t6BHcgNXG3k87Uyr6WNh0DQE/C39tUBGWmRYuDiMxb/8EXiUrtBp/JHtu+
         welp1szQKxtYNlfdcO1yNRSnnSy7IMZ3Fon2vIonOshQT1sx7BuDbEGyXmFvkLLUgva0
         IMpK1Vb4u3+lRSDw8fFEErWRDC2ltmA/K81jwq20MlLRd1yf9qT/jrzYGzz8cDPaK8ep
         dpxvw0ddf0t68d4sQHQTaT0CBYZXfGhDDwavHWsw5PJ31WdVzA/ApFI4mogEYL/OjPuH
         JuHTbq4HEkzgPm2GMGrpxt0u8+Myg6fjKxqOUaSTykQv6g3HhSLLa1h+Mh7CRhvNnkfs
         2Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775851788; x=1776456588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogOCvyyoZ9XSpNfyYtW2p4XJwVTVTXAMukOYXRQXI0I=;
        b=eJDdfXtYCa1SEjFpW9J+75SjezIQAOiKTVePnjJp0jTFTsDldz6jXMJAObiGcQnQPB
         XZCxVmQoK95IfQ6Ft40EYpa5ofz/xK3WjUm+dRuzVVNlR1THOZX0YMWcouWsQ0Ih5q4L
         3qBTOCrQqOdTRm/6iH7We58lihgYuLDPeii2yER6Dsd7d4SsZsIXBEt1x2AlWW6wgYIb
         YEr6+yQ3RGX++nytenGbPPbyUuTQttMGZe4DZviUIx7z8KJvZ6gifOhpxk3jAvElkR38
         H+Eg5X+NdaqmsBxuczeAtw2yhfVKViYSHWA7DsZVbswZ5jcqzMOQy6zKO8pEu1LxSJvz
         przA==
X-Forwarded-Encrypted: i=1; AJvYcCUUscSY8O1x6xA2Fh62gO6PsQwjtOpccca8jp2Cot2+Pj2qA7H7yDeJdM3SOckSNiG4T9P3JKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyv4P4bgZ5QATCnDu7WvcSYXGy4QeK2X1eDccyj2MgbcGAoqaC
	5kM07Au8PyLn80anMLAIZh/1gcqkCh2tdU/1dpfnhvF+FvOsq51avM0KeVtdlsQG9y/0RHhsNR2
	q6gooruW70NXS4Ys32I9iEIOwGvPjo7s=
X-Gm-Gg: AeBDieta/95vODpp4aLYrPL/1IY/H6CxxRtq9VqQCgxpdB/csBf/D3+Zwbs7bGam85D
	aOWWpmKVdpm+BAvq1f6SzcKYjqmkpeZqpgDiwPZJqziZm9me5c4kVa4GAK6ekBZErLAJxW1Bs91
	Fj44ithwm20IK+yFLBHE21+Yry65Fgatyegx7bwMPXkLlpTmDjTf5yFT1zCmOEPBU0fk3YKk46R
	MshdnrpKM4y/+LQzg9r7O+sIZ71wF4lRw5r0OzFUjBSxG7QmOouqhu5LtVvUwu4umvh4hnK6/Xp
	Te765A==
X-Received: by 2002:a05:6000:4285:b0:43b:f322:34e1 with SMTP id
 ffacd0b85a97d-43d642d9f0bmr6365691f8f.51.1775851787743; Fri, 10 Apr 2026
 13:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora> <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
 <adlE6dSPAlMH-ek-@fedora>
In-Reply-To: <adlE6dSPAlMH-ek-@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 13:09:36 -0700
X-Gm-Features: AQROBzDl5u9RsBQZJwaYp4PaanKuHfyGrgmk6Kp2qbDA6zFCLoRJLrmfHaTlQgY
Message-ID: <CAJnrk1acOQ4vm0bj+uLsx7vRodcwJBbfxjY=mn0BJ_j_eMr11Q@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
 immediate teardown
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235661-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,birthelmer.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:email]
X-Rspamd-Queue-Id: 1AC623DC69F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:55=E2=80=AFAM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Fri, Apr 10, 2026 at 10:09:36AM -0700, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 12:21=E2=80=AFAM Horst Birthelmer <horst@birthe=
lmer.de> wrote:
> > >
> > > On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> > > > On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 10/21/25 23:33, Bernd Schubert wrote:
> > > > > > Do not merge yet, the current series has not been tested yet.
> > > > >
> > > > > I'm glad that that I was hesitating to apply it, the DDN branch h=
ad it
> > > > > for ages and this patch actually introduced a possible fc->num_wa=
iting
> > > > > issue, because fc->uring->queue_refs might go down to 0 though
> > > > > fuse_uring_cancel() and then fuse_uring_abort() would never stop =
and
> > > > > flush the queues without another addition.
> > > > >
> > > >
> > > > Hi Bernd and Jian,
> > > >
> > > > For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> > > > from fuse_uring_cancel" email was never delivered to my inbox, so I=
 am
> > > > just going to write my reply to that patch here instead, hope that'=
s
> > > > ok.
> > > >
> > > > Just to summarize, the race is that during unmount, fuse_abort() ->
> > > > fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... -=
>
> > > > fuse_uring_entry_teardown() gets run but there may still be sqes th=
at
> > > > are being registered, which results in new ents that are created (a=
nd
> > > > leaked) after the teardown logic has finished and the queues are
> > > > stopped/dead. The async teardown work (fuse_uring_async_stop_queues=
())
> > > > never gets scheduled because at the time of teardown, queue->refs i=
s 0
> > > > as those sqes have not fully created the ents and grabbed refs yet.
> > > > fuse_uring_destruct() runs during unmount, but this doesn't clean u=
p
> > > > the created ents because those registered ents got put on the
> > > > ent_in_userspace list which fuse_uring_destruct() doesn't go throug=
h
> > > > to free, resulting in those ents being leaked.
> > > >
> > > > The root cause of the race is that ents are being registered even w=
hen
> > > > the queue is already stopped/dead. I think if we at registration ti=
me
> > > > check the queue state before calling fuse_uring_prepare_cancel(), w=
e
> > > > eliminate the race altogether. If we see that the abort path has
> > > > already triggered (eg queue->stopped =3D=3D true), we manually free=
 the
> > > > ent and return an error instead of adding it to a list, eg
> > >
> > > In my case (Bernd mentioned that I was investigating a hang during um=
ount)
> > > there were a lot of requests created during teardown, so what happene=
d
> > > was very similar, but for exact the opposite reason.
> > > In fuse_uring_abort() queue_refs was already 0 due to an optimization
> > > where the ring teardown ran before fuse_abort_conn().
> >
> > Hi Horst,
> >
> > Just to clarify, is this with running locally patched changes on your
> > ddn kernel? In the upstream code I'm seeing that teardown is only
> > called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
> > -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
> > it's possible for teardown to run before fuse_abort_conn(). Is there
> > something I'm missing?
>
> Yes and no ... ;-)
> The original patch this whole discussion was started by had a call to
> the teardown of the entries and I had that applied.
> But even without that the problem can still occur that queue_refs is 0
> by the time fuse_abort_conn() is called.

Gotcha, thanks for clarifying.

Without the original patch, can queue_refs still be 0 by the time
fuse_abort_conn() is called? The only case where I see that is when
the sqes are in the middle of being registered but haven't grabbed the
queue ref yet, and then the abort logic runs (I am going to write more
about this race in a reply to Bernd's other message in this thread),
but other than that I don't see how without the original patch we run
into this case since teardown -> queue ref decrement only happens in
fuse_uring_stop_list_entries() which only is triggered on the abort
path. Are you talking about a subsequent fuse_abort_conn() call (the
one called from fuse_dev_release())?


Thanks,
Joanne
>
> >
> > > Thus the queue->stopped was never set.
> > >
> > > How do we make sure that fuse_uring_teardown_entries() has not been
> > > called by fuse_uring_async_stop_queues()?
> >
> > If i'm understanding your question correctly, your question is what
> > ensures the teardown logic in fuse_uring_async_stop_queues() hasn't
> > already executed by the time we drop the queue lock after checking if
> > the queue has been stopped? In fuse_uring_async_stop_queues(), the
> > async teardown work gets continuously rescheduled so long as
> > queue_refs > 0. The ent holds a reference on the queue, so when the
> > queue lock is dropped that async teardown work will be continuously
> > running until it cleans up that (and any other) ents.
> >
>
> You understand correctly.
> If the fuse_async_stop_queues() runs there is still a window where
> we have queue_refs =3D=3D 0. If in that window fuse_abort_conn() runs
> we never actually stop the queues and we can accept requests which
> will never be processed.
>
> I have never seen this happen without the patch mentioned above,
> but with that 'optimization' it happens regularly when you are able to
> kill the fuse server and the application using the file system more or
> less at the same time e.g. by an OOM event, when the kernel tries to
> free resources.
>
> To me this looks like nothing will stop this from happening, though,
> but maybe I'm just not familiar enough with the uring code ...
>
> > >
> > > Maybe I'm missing something?
> > >
> > > My fix was to remove the check for queue_refs > 0 in fuse_uring_abort=
()
> > > and make sure that even if the teardown was complete nothing bad happ=
ens
> > > in fuse_uring_abort_end_requests() and fuse_uring_stop_queues().
> >
> > I'll look more at this path today.
> >
> > Thanks,
> > Joanne
>
> Thanks,
> Horst

