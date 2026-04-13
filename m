Return-Path: <stable+bounces-236160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDD0KWES3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:57:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A21573EE3C2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60FD0300B516
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3599D3E0C62;
	Mon, 13 Apr 2026 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/8FYODa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBD33985
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095832; cv=pass; b=hfEmgXFeCTzim8Ve7eI3pHpq8KXcJZANKX5kyXXHm19TrQ0Q2fvxyRHxI3OopfS7wTPW1Vk5zs0d4CJ+2hStyNAISFi5a4vhBz5uQIDuJlDk3wL7vvPrW+Ut0l5Os39WWHN518hKO28O2dnQDHUh25ublbj0uu92nKKNaK0fViM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095832; c=relaxed/simple;
	bh=uCKT3mDcBLIjf8+Wa0Yr7vV5tltP+TxZuHAJOqsVuZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCGQTaiSdFOPcuEqWXWQRSY1PDCDAo+YM/NjPxPW6CoX3GbeHgmWwy7ubdAOnlGewrNVc9vRdJiiAdbTm34QXBnJOcuwmAl1Rld+YAVtbSfEOpUCGbXhR5TdvEqNcrVNZCQ6+dtFdzC3PezeNj+b2otNa5kOG1tvI+uIW+RHpFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/8FYODa; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so64067735e9.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776095828; cv=none;
        d=google.com; s=arc-20240605;
        b=VF8G1KzJRgjlgNqNvdkFBMhGOiV19/MiTb4wEazxiHnENg8KxmUe5GNRP+Ko2GXXFi
         Yv5LX6rYU4xCROePgvmnR7Ak2vtjhw1d8d950UsFF87Q1Boq4fhMyMIOaVYDMNrxlp2x
         hlSCHikQYglaEsWe8xGJbt2Nq6S1YYC2d3yF5lcdhG2UXvKzS/R/+DYNQhONAlTZSFHm
         j3RDb5NqEzlg3IwtqGSvAm44iQAvhkwjImg4xViXfYs3qYrQcsz9xd6vCPyOjgmWpYfy
         DMXhSkeDhIaLS/RcNLftH6Q/WtKrdpy+WsJ+Mu9Nhm4C6OnPHSnXQRUlfHr2pNGIQCls
         uHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lLY/V59tkdL3GjoxouNe5fdjlq2HK/DPMs0km7foI4M=;
        fh=uS+d5HJv9WubL8kLUSMpd9dXfw8PC4TiLOh578JMZB4=;
        b=hyocwFnBDldNqQnHMrU7q7tCZD90E8dJt8n9gV3629QChZUtyvpW/Jzzs6f79smB/+
         3lxOdJYJE7TvYKeIWfNbR+Zembv17uvPnAhB/pPLXypA4JqvsVv422gyyJRfKYYhDXGk
         9TvsDxkkRyzvPMX0Xtp7Yhz2DOYS+8Vz9Kd2AeGcXgHMDbG8lPKDzqSuwQOJWZx/jtxS
         aJpQN0J4adm8EnppYSTzsjvmXuMuQpAS0AWGJucB9jVphLSZQ6SipGxCpQbrzvhkIfGG
         Vjpx/5h488OeXvNebQjX36F+bb2L8ju27OWGkmKxuMw40kfl725ZYeY4p8t7iJnfl5QT
         j6+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776095828; x=1776700628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLY/V59tkdL3GjoxouNe5fdjlq2HK/DPMs0km7foI4M=;
        b=G/8FYODaLngjYClLa2F322p3GjfpG9iRRznYQkZzFWITuCW/d+TcWLsm402CoMCK5+
         Cfg804+v91QcJrh04++5y0aG3YSg1XuVvDPwpiJLSfALFR23PO7KKbX0UuGTHSv8khrB
         f4/rvN9rJcsh2bz2ujHpNGpCoBmUhN946PdVlpegFLhtY2aWGr4WtycDv4MiRxwMpqEu
         yTcjJpJAxU81FJBW2DD6mgj9lFXRT2wLrE5ZQeSyX/DXLgGh5JMJzphqQFxTL9Bm139G
         EG30EjDKBIUHeGEQsqQw/BB+wHcCNgKzroFaBt2apUWFVmHo36UjlOvOJWa7YY3XTP3u
         Hedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095828; x=1776700628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLY/V59tkdL3GjoxouNe5fdjlq2HK/DPMs0km7foI4M=;
        b=BVvu/qh9n9hIN8umw3kM/fqh90KjLZ+8xdD4Gtg5V+qsKkuKIcacV9GPL9O5EEx9l7
         ad1XPWWQhVzt8GGDhcs9qG8DeLjg8zpky1TnWF11VmhxH0TAIWmdBrOzPGNS9sIxBmgU
         xPMV2Mu9QEBhtjgVgWTd6/0vHs+TV0SuREPjIV0n7wVgv+qoC/MG86pq9IjlyI5/+u3z
         WTt3+U9D3QAWp6a4pdIxXcvG8kCvfTrE2iDoYxSLmb+l4S9Mo6Ciwzqx6j3XPGU4KvSN
         bTdj3yfEUosjo2cg9lVpHb9tmVQAZ0cZTua9mRVKqrwwps2bS+lNSdu1je3VcxKK6Jkq
         5YXA==
X-Forwarded-Encrypted: i=1; AFNElJ8pwQnF+d7MIxuaRud2GVyVDiCeKdohNztVRHdU2vPape+rkKDD9LnEUxgNFHRnzKL0+xkxq8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5r/twtfhcPZjf1VQiUBTWcpY4GNCAOdorVgJmYCM+u/pBVcw
	HGePtJ4ENuRQlHO0qF17oBZod3kk7ry49oLD723aAATiZf8KuIr0sG9hS6/NvHeOEQuTF8qcZ4u
	nOJosOdIeGY0jURB+E9k5e3T1xIQUl4E=
X-Gm-Gg: AeBDies1vLtyRq6iNygFkE4GeHTkfOJ2Qa3x1wco6DWcNsMpvhnRdRdefG5ueLVKRRh
	cdL8eRMlZumGu9YuINK+PCfmQqQ78ajaVy+sgXff4Jxf6IAJeOqVVbs9cO/qLYD58N89U47vijO
	7eih2PielYG3VFvcXuFr6nH+C3LZ2/9N9TGe+gX+AMPsSsnqjlFCZSmXHddedqxMs6j9rahXt0l
	D1cQLtvcEX/S+eNoMtW6efqSU9AWawCMvVkI3H243maZ7dKyNMWhec/3BqdXuY5Dpe+yathvjwm
	pfYbSbfj6gi206iA
X-Received: by 2002:a05:600c:820a:b0:488:81b1:ae36 with SMTP id
 5b1f17b1804b1-488d688688fmr191294365e9.23.1776095827255; Mon, 13 Apr 2026
 08:57:07 -0700 (PDT)
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
 <f27651af-e5c0-4c3e-8baa-fa2d7232cb4d@bsbernd.com>
In-Reply-To: <f27651af-e5c0-4c3e-8baa-fa2d7232cb4d@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Apr 2026 08:56:54 -0700
X-Gm-Features: AQROBzCQB5LUKidCfDKTOcAMORMn7yCvE_iIjd42P_3YuhwAl8rp2gTfh_3ajVM
Message-ID: <CAJnrk1YPrPXN74fgesg1dbqJJsmjPOJ_My_mYMUevJfSrmrECg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-236160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,bsbernd.com:email]
X-Rspamd-Queue-Id: A21573EE3C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 12:22=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
>
> On 4/11/26 20:11, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 3:08=E2=80=AFPM Horst Birthelmer <horst@birthel=
mer.de> wrote:
> >>
> >> On Fri, Apr 10, 2026 at 02:24:08PM -0700, Joanne Koong wrote:
> >>> On Fri, Apr 10, 2026 at 4:26=E2=80=AFAM Bernd Schubert <bernd@bsbernd=
.com> wrote:
> >>>>
> >>> Hi Bernd,
> >>>
> >>>> Hi Joanne,
> >>>>
> >>>> On 4/10/26 01:09, Joanne Koong wrote:
> >>>>> On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 10/21/25 23:33, Bernd Schubert wrote:
> >>>>>>> Do not merge yet, the current series has not been tested yet.
> >>>>>>
> >>>>>> I'm glad that that I was hesitating to apply it, the DDN branch ha=
d it
> >>>>>> for ages and this patch actually introduced a possible fc->num_wai=
ting
> >>>>>> issue, because fc->uring->queue_refs might go down to 0 though
> >>>>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop a=
nd
> >>>>>> flush the queues without another addition.
> >>>>>>
> >>>>>
> >>>>> Hi Bernd and Jian,
> >>>>>
> >>>>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> >>>>> from fuse_uring_cancel" email was never delivered to my inbox, so I=
 am
> >>>>> just going to write my reply to that patch here instead, hope that'=
s
> >>>>> ok.
> >>>>>
> >>>>> Just to summarize, the race is that during unmount, fuse_abort() ->
> >>>>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... -=
>
> >>>>> fuse_uring_entry_teardown() gets run but there may still be sqes th=
at
> >>>>> are being registered, which results in new ents that are created (a=
nd
> >>>>> leaked) after the teardown logic has finished and the queues are
> >>>>> stopped/dead. The async teardown work (fuse_uring_async_stop_queues=
())
> >>>>> never gets scheduled because at the time of teardown, queue->refs i=
s 0
> >>>>> as those sqes have not fully created the ents and grabbed refs yet.
> >>>>> fuse_uring_destruct() runs during unmount, but this doesn't clean u=
p
> >>>>> the created ents because those registered ents got put on the
> >>>>> ent_in_userspace list which fuse_uring_destruct() doesn't go throug=
h
> >>>>> to free, resulting in those ents being leaked.
> >>>>>
> >>>>> The root cause of the race is that ents are being registered even w=
hen
> >>>>> the queue is already stopped/dead. I think if we at registration ti=
me
> >>>>> check the queue state before calling fuse_uring_prepare_cancel(), w=
e
> >>>>> eliminate the race altogether. If we see that the abort path has
> >>>>> already triggered (eg queue->stopped =3D=3D true), we manually free=
 the
> >>>>> ent and return an error instead of adding it to a list, eg
> >>>>>
> >>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>>>> index d88a0c05434a..351c19150aae 100644
> >>>>> --- a/fs/fuse/dev_uring.c
> >>>>> +++ b/fs/fuse/dev_uring.c
> >>>>> @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *rin=
g,
> >>>>> int current_qid)
> >>>>>  /*
> >>>>>   * fuse_uring_req_fetch command handling
> >>>>>   */
> >>>>> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> >>>>> +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> >>>>>                                    struct io_uring_cmd *cmd,
> >>>>>                                    unsigned int issue_flags)
> >>>>>  {
> >>>>> @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
> >>>>> fuse_ring_ent *ent,
> >>>>>         struct fuse_conn *fc =3D ring->fc;
> >>>>>         struct fuse_iqueue *fiq =3D &fc->iq;
> >>>>>
> >>>>> +       spin_lock(&queue->lock);
> >>>>> +       /* abort teardown path is running or has run */
> >>>>> +       if (queue->stopped) {
> >>>>> +               spin_unlock(&queue->lock);
> >>>>> +               atomic_dec(&ring->queue_refs);
> >>>>> +               kfree(ent);
> >>>>> +               return -ECONNABORTED;
> >>>>> +       }
> >>>>> +       spin_unlock(&queue->lock);
> >>>>> +
> >>>>>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> >>>>>
> >>>>>         spin_lock(&queue->lock);
> >>>>> @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
> >>>>> fuse_ring_ent *ent,
> >>>>>                         wake_up_all(&fc->blocked_waitq);
> >>>>>                 }
> >>>>>         }
> >>>>> +       return 0;
> >>>>>  }
> >>>>>
> >>>>>  /*
> >>>>> @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_urin=
g_cmd *cmd,
> >>>>>         if (IS_ERR(ent))
> >>>>>                 return PTR_ERR(ent);
> >>>>>
> >>>>> -       fuse_uring_do_register(ent, cmd, issue_flags);
> >>>>> -
> >>>>> -       return 0;
> >>>>> +       return fuse_uring_do_register(ent, cmd, issue_flags);
> >>>>>  }
> >>>>>
> >>>>> There's the scenario where the abort path's "queue->stopped =3D tru=
e"
> >>>>> gets set right between when we drop the queue lock and before we ca=
ll
> >>>>> fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
> >>>>> logic that was called before fuse_uring_do_register() has already
> >>>>> grabbed the ref on ring->queue_refs, which means in the abort path,
> >>>>> the async teardown (fuse_uring_async_stop_queues()) work is guarant=
eed
> >>>>> to run and clean up / free the entry.
> >>>>
> >>>>
> >>>> I don't think your changes are needed, it should be handled by
> >>>> IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where the
> >>>> initial leak was - these commands came after abort and
> >>>> fuse_uring_cancel() in linux upstream then puts the entries onto the
> >>>> &queue->ent_in_userspace list.
> >>>
> >>> I think there are still races if we handle it in fuse_uring_cancel()
> >>> that still leak the ent, eg even with the fuse_uring_abort()
> >>> queue_refs gating taken out in the original (jian's) patch:
> >>> * thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() ->
> >>> kzalloc, sets up the entry but hasn't called
> >>> atomic_inc(&ring->queue_refs) yet
> >>>   concurrently on another thread, thread B: fuse_uring_cancel()
> >>> ->fuse_uring_entry_teardown() ->
> >>> atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs down
> >>> to 0
> >>>   At this instant, queue_Refs =3D=3D 0. fuse_uring_stop_queues() ->
> >>> teardown entries (nothing left) -> checks "if
> >>> atomic_read(&ring->queue_refs) > 0", sees this is false, and skips
> >>> scheduling any async teardown work
> >>>   thread A calls atomic_inc(&ring->queue_refs) for the new ent,
> >>> queue_refs is now 1, the ent is now placed on the ent_avail_queue, bu=
t
> >>> it's never torn down.
> >>>   the ent is leaked and there's also a hang now when we hit
> >>> fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queues()
> >>> where it sleeps and is never woken since it's waiting for queue refs
> >>> to drop to 0
> >>>
> >>> imo, the change proposed in my last message is more robust and handle=
s
> >>> this case since it guarantees the async teardown worker will be
> >>> running (since it does the queue state check after the ent has grabbe=
d
> >>> the queue ref).
> >>
> >> Ok so you rely on the fact that fuse_abort_conn() will call
> >> fuse_uring_abort() and that sets queue->stopped.
> >> This could work, but I would still remove the check for
> >> queue_refs > 0 in fuse_uring_abort(), since it just complicates things
> >> for no real reason.
> >>
> >>>
> >>> btw, there's also another (separate) race, which neither of our
> >>> approaches solve lol. This is the situation where fuse_uring_cancel()
> >>> runs right after we call fuse_uring_prepare_cancel() in
> >>> fuse_uring_do_register() but before we have set the ent state to
> >>> FRRS_AVAILABLE. The ent gets leaked and continues to be used even
> >>> though it's canceled, which may lead to use-after-frees. This probabl=
y
> >>> requires a separate fix, I haven't had time to look much at it yet.
> >>> Maybe Horst or Jian has looked at this?
> >>>
> >> Interesting scenario ... haven't seen that one so far.
> >
> > Looking at the io-uring code for how cancels are handled
> > (io_uring_try_cancel_uring_cmd()), I was wrong in my prevoius message
> > about these two races. io-uring already serializes this for us, the
> > io-uring code unconditionally grabs the uring lock before invoking
> > file->f_op->uring_cmd() in the cancel path, which means there's no
> > interweaving between the fuse registration logic and the cancel logic.
> >
> > But I still think the more robust/resilient fix for the memleak is to
> > do the preemptive checking at registration time. I think this fixes
> > races in the force unmount case between registration and abort that is
> > unresolved with the original patch. With the original patch w/
> > fuse_uring_abort()'s queue_refs check removed, I think we can still
> > hit this:
>
> I need to go through the other messages, but I still do not see any
> registration time leak. At least not with the additional patch we have
> here to tear down entries through IO_URING_F_CANCEL

The issue is the hang, not the leak.

>
>
> Sorry, besides also looking into ublk now (for main work), also in
> progress to fix an issue with reduced queues and also still on the
> libfuse part of sync-init....
>
> >
> > registration vs abort:
> >   - thread a: io_uring_enter -> register sqe ->
> > fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
> > yet
> >   - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
> > fuse_uring_abort() -> fuse_uring_stop_queues() ->
> > fuse_uring_teardown_entries(), skips scheduling async teardown work
> > since queue_refs =3D=3D 0, returns
> >   - thread a: grabs the queue_ref, queue_ref is now 1, rest of
> > fuse_uring_do_register() logic executes, ent is now marked cancelable,
> > ent state is now available, ent is placed on available queue
> >   - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
> > and does a "wait_event(ring->stop_waitq,
> > atomic_read(&ring->queue_refs) =3D=3D 0);" which hangs since the waiter
> > never gets woken
> >
> > whereas if we check preemptively at registration time, we explicjtly
> > free the ent and release the queue_ref. I think the preemptive check
> > needs to check ring->fc->connected though instead of queue->stopped,
> > because there's the race where abort and stop_queues() may have been
> > triggered before the register sqe path does queue creation. I'm hoping
> > there's a better solution than having to grab the fc lock and checking
> > fc->connected though, will try to look more at this next week.
> >
> > I think we can hit this hang on a ring creation vs abort race as well:
> > * thread a: fuse_uring_cmd() gets called, passes fc->aborted check (not=
 set yet)
> > * thread b: abort is called, calls fuse_uring_abort(),
> > fuse_uring_abort() is a no-op since ring =3D=3D NULL right now
> > * thread a: creates ring, creates queue, creates entry
> > - if thread a takes the queue_ref count before the rest of the abort
> > logic, we end up with the same hang as the situation above.
>
> IO-uring sends IO_URING_F_CANCEL for every registred command. We never
> had a leak you describe. Upstream has a leak because it does not free
> 'queue->ent_in_userspace' in fuse_uring_destruct. I'm fine with the
> addition in fuse_uring_cancel() (although the just freeing the entries
> in the list is much simpler and race free).
>
> Please let's not make it anymore complex.

The issue is the hang, not the ent leak. What I'm trying to say is
that the original patch submitted fixes one issue (kfreeing the ents)
but doesn't fix the registration vs abort race, whereas the preemptive
registration check fixes the leaked ents and the race.

With the original patch, the umount thread still gets stuck
permanently in TASK_UNINTERRUPTIBLE during the race. Even if the admin
kills the daemon, the umount thread still holds the mount ref, which
means delayed_release -> fuse_uring_destruct() will never get called
and the entire ring gets leaked. If the original patch adds a
wake_up_all() when queue_refs hits 0 in teardown, then killing the
daemon does resolve it (as it'll wake up the umount thread), but the
force-unmount still blocks in TASK_UNINTERRUPTIBLE state until the
admin kills the server. The preemptive registration check is the more
robust fix imo.

Thanks,
Joanne

>
>
> Thanks,
> Bernd

