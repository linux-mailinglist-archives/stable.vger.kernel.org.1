Return-Path: <stable+bounces-235660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKJbLQJW2WlGoggAu9opvQ
	(envelope-from <stable+bounces-235660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 21:56:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE03DC32C
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24E59302CE35
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D8F385510;
	Fri, 10 Apr 2026 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBKCZASJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8523845D4
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850836; cv=pass; b=L6osiKTnN6QrwC7sWDAU/9UsZFC901IbgFjXOYsnhjV909eo6ve7xgwXRGAFfyKNnq9pNecv1EwxCqqhU7wVDdUIR2sb5kaNu0qpM6ZZ2XidbqWyqGCuQQW79lCLZ1uCPPXqE/G5CMNXq38RbEvQs26m/vc7cy5Rm37Gtd6vyf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850836; c=relaxed/simple;
	bh=mlQ5y53KD4rC8h/M06AzwimJVRpmM6xvsUuJP91oxtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AB4gS1ERJFlhh5WCJ220h7wwP4gaHH6ksB1qkAgtTPdSb6w17W/qVEKcPIztmt++h6uNxcn/9NfUOPoPjARIplB5jAOnnzyt6OMZcdFsDXk1kXxNbqefXpLOdBFKkx2Sy5M+tTguWR/SK56FQO2Az1fJNoVYmzbRJS4nuv7CgYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBKCZASJ; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1616779f8f.2
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 12:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775850833; cv=none;
        d=google.com; s=arc-20240605;
        b=BKm9zTH0DgzQ80Lh/7udvW58uDP7F87k2bQBGacpAHaJp/ru8gPOgQnRXmqQ7SKPGM
         12VRQ2CKVhRGIOtZTLsigSNSDnAlx2p1SgOwPAEFfI1rsfMGxd65wWK5uK96xEPSFhfV
         MftfHK4wiqrVEUhkLBY2Lw8D1gqGvwf+rc9sTC1Sq0gHjyDNJjWSDNpGMTxPhQDiFl4v
         aMtWJE4vKRiBNxFZbab+91IPhxQKwgcb+gsUFwpcWHle6QWDp5iewk187Vi3igiozUZQ
         287dQas6P4p5wKdZuFgm+0jb2XarymQpqm8M4lBzlm5Db11YzjamSCHqgHZKXGOqhDwn
         7PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mlQ5y53KD4rC8h/M06AzwimJVRpmM6xvsUuJP91oxtg=;
        fh=2xiLb787DXD4AQTj8NOLQQv2uEAzLOvC/7w40eqADfE=;
        b=Q6jARhrZjD0ZfVSGO7zbJusVPcinchW1q/mOEPMLL+rWAPptU7iEOoQlJipu9MMvlR
         8NwTbAv+iLJ6EkOJn+v/dEEY1wSbLspTXs8ukFak761+Xz5Q2Krjci5sNPCyDYhtXMiE
         ebuPw57WihvcucAOf4wLllGjOoqMMCTC4Vae4lifcCvp2T2XAL4GMTbgf/1Sydzt/8lr
         7PEJnzjMbCK25K9a8JxC2Ib22St0Syf3/G8k7xA3Ow3ZLplzh8mlfvu3NYl+42pjKiHO
         6RAuBdpED4azkil7ax6rg+NuPYuvNaX8xkQ2ev0y+MbqiUYRC07opjDSkRIUUNenIyR1
         4YfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775850833; x=1776455633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlQ5y53KD4rC8h/M06AzwimJVRpmM6xvsUuJP91oxtg=;
        b=RBKCZASJbQbiAxcWLSp7HcN49wb4KpWSStYXOApUi6qJ4n9Au9pbnRd/OZGx52S1mS
         kklPfbW36jpRYR0USOkfThu+rXCCb0NHuJRX+VC+XwxymEabLQI26Ou1dsMU3zyPn5lv
         q8sCBG9WfMT+Fjjj+HDqSP3q5mf5c1rNgbLDgq3Gykz6Idz17NVkh8voN6sqyNJNhcr0
         muoZAmQKp4l6Qx6S4dTkugrr8nagxUOTLVCOHzPVAIOSWLrpGgyKrvMpLxJsRQ2bnzCa
         QC4bIvIpevqimHxaG1nxns3Pqxm1+6rCtNM03NXJRpRyTNB0IlB/omAlpGjQTNBAdsL9
         pUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850833; x=1776455633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mlQ5y53KD4rC8h/M06AzwimJVRpmM6xvsUuJP91oxtg=;
        b=lHhp88pY6AtHAhmk3QprMukAwKLd3HK5AJeqYk2kEDZhko/Advv8jCYs+bXG6nB5mM
         OufajsF/ygp/NtoR1kA5Cfczbpe+nrwqJ8VeD3zYVUEeCC863ZzwL6D/fqVWtq9BN/Jo
         YPtRh5uax/ikJaI8AaF29Vn77QnnzcpeivFUyrgZvpYhfQI+NmAZbncBE95nXWb6XF9Q
         A27D3P/uNzW13yZAgGJ7eXwftLz2WiSYMi40Vii+8bY024WQcwZYOOeMiEb/Ap+8rQ6b
         STu9Ma6zOCwFRRcRoFHk3XOwckRjMmj1dccbjrCAyoCTbaIjTlu+khMbvYiFcSTu9+GL
         LJog==
X-Forwarded-Encrypted: i=1; AJvYcCWQ38TNyzjipK8ZTbaiF5h0aElKzNL4WtqpBEGafZMxp6YR+qwcz0Ri+/Bvonvx/wIwt4MiRqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DBBpiI6sO9WzmSIDeN2244GHEuh++VdKUkQ2cH6vKDR5Hisl
	8j93MwjFh2TLf+BZYiPXH4X8KvgRfSbLZPXFqf/VZsPO8tMKDJM/JJUWxA7LHowJT1UueY5yfmM
	nD5LvNxB5Fa4XOp0k9PJaWISyc0L7yDXGdyoqikw=
X-Gm-Gg: AeBDietd3AvhtUuJN6WsipTMzJRp0w4Dh54WGVPZcFivKTd1Lbx2blQ/BtaFCMKsb+x
	2eRQrfPfQWOQ83uAwfjD6rZgK9JhXd+16JCbM1HOQB/lN52vID8iGLNWctv1lYMZ/VArKrNJifd
	f5fPG+MWQaOwqfl5Tyv3PihR3dUcrvIJf4+kUqHlLveyQgwFJliRII6cx7cSv9drtMmdJurdFxa
	SOYGXXk2i1WYiYfTj+cQAMXu9w5L/wcO5YVzzUqfoTqBsyYOwXuV5nBBbJAKqmV1YgfBnX3SLxd
	NTBkZw==
X-Received: by 2002:a5d:5f86:0:b0:43b:445f:3177 with SMTP id
 ffacd0b85a97d-43d642ba100mr6806377f8f.31.1775850833273; Fri, 10 Apr 2026
 12:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora> <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
 <a9b8887d-f80a-4a0b-a1a5-3dd52dd23497@bsbernd.com> <CAJnrk1aSE3ukj=6aoG-UhsFQN1Eo1_AEZk07X+M_z2GM-dq-AA@mail.gmail.com>
 <b002dbde-cea0-4558-a918-db228ce8b48d@bsbernd.com>
In-Reply-To: <b002dbde-cea0-4558-a918-db228ce8b48d@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 12:53:41 -0700
X-Gm-Features: AQROBzDxP9-80eNSj2SoQ5dSv_Bn_mZ0OHqdTPbG7UFLIbNMGGzdiwcfkv3JkME
Message-ID: <CAJnrk1Y8yV6R6k2+x5zmO8P-KnhW7Rh+qxKbspHHcX1nYn=Bxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate teardown
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235660-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bsbernd.com:email,birthelmer.de:email]
X-Rspamd-Queue-Id: 61BE03DC32C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 10:32=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
>
> On 4/10/26 19:28, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 10:18=E2=80=AFAM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> >>
> >>
> >>
> >> On 4/10/26 19:09, Joanne Koong wrote:
> >>> On Fri, Apr 10, 2026 at 12:21=E2=80=AFAM Horst Birthelmer <horst@birt=
helmer.de> wrote:
> >>>>
> >>>> On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
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
> >>>>
> >>>> In my case (Bernd mentioned that I was investigating a hang during u=
mount)
> >>>> there were a lot of requests created during teardown, so what happen=
ed
> >>>> was very similar, but for exact the opposite reason.
> >>>> In fuse_uring_abort() queue_refs was already 0 due to an optimizatio=
n
> >>>> where the ring teardown ran before fuse_abort_conn().
> >>>
> >>> Hi Horst,
> >>>
> >>> Just to clarify, is this with running locally patched changes on your
> >>> ddn kernel? In the upstream code I'm seeing that teardown is only
> >>> called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
> >>> -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
> >>> it's possible for teardown to run before fuse_abort_conn(). Is there
> >>> something I'm missing?
> >>
> >> See my mail please it explains the history and shows the patch I had
> >> posted to the list and which is not applied yet. The DDN branches have
> >> it applied.
> >
> > Hi Bernd,
> >
> > Can you link to which mail you are referring to? Which patch are you
> > talking about?
>
> The mail I had sent earlier today, a few hours after Horsts. Somehow I
> have the bad feeling that half of my mails are going into a spam folder.
> I hope you get this one.
>
> Here is the link to the message-id
> https://lore.kernel.org/all/3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.=
com/

Thanks for the link! To summarize, what Horst was saying in this
paragraph then is that with this patchset applied, there's that
queue_refs =3D=3D 0 problem (since queue refs is now dropped in the
fuse_uring_cancel() path) where abort then doesn't trigger since abort
checks queue_refs > 0 which is the same as the situation in [1].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/4b5a8040-b62c-4d75-a474-70d0b4759=
461@bsbernd.com/

>
>
> Thanks,
> Bernd

