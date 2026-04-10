Return-Path: <stable+bounces-235648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHBeEvsu2Wl+nAgAu9opvQ
	(envelope-from <stable+bounces-235648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:10:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A71CF3DAE6D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 403283006174
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CF63E2741;
	Fri, 10 Apr 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfplRdNw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5563DFC77
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840991; cv=pass; b=C/kgvv3a8MXQblXogi/BNE7zD4Dzh7CRMi66T8PANPZwzCW112RJEaJHD+paw1MjJEk1XmXT4aVjXSexOlqSrX7fB9Kzvzl6ymanAC2rLnePk7aQggf9h1v9LOYXcGbSqrpbVqlm4pont2k9dQKAuG1X5Of5/0ZLC7YY8nitLiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840991; c=relaxed/simple;
	bh=AdRLWuRnA9WFkshkxgv4Av+3azQPL66RiuSI1tP85uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjsIOQGHwliJs6ztKtYelG82bQs6K30cAMxWsWyyuU68KFInACnpsSCqMOX8t5Z2coJnvzX7Of322cqF+ljQsnfWDpu6WknckODunaBpXhPaXL6b+JEK2zc2HTi3yp2GSoDvs0i0QT7PB/2U2+xi/blJibrDqJuLS2Yf6Fhqd1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfplRdNw; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfd832155so1476422f8f.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 10:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775840989; cv=none;
        d=google.com; s=arc-20240605;
        b=fJdaiBJxCoiBJKB6O5/KXEyAoNUlMdq+G2ER3VRHbn6e+rulEtN7AYtElNX1RHry9X
         6XBwfyuA4tpP0cGwsTJRqOJMUY9swzbje6FdTgj0Kf+NHPQJaxmBwoIihbDo0mJhaFKq
         lIVNXG1lx5AeRcD/UkWzhNOwFBum+NsGqjzWU97pgBJS3It0GomPrKAFCrjjjGXb2UPb
         KZylE28LSaipMa4dh8PY2kyToahmhj+UOWucCa/5hjYOc1urDF/OtHbTd2dCnY3IxgHC
         qTzL6DuToXj6q4LuD8rMtB8/ma/dzOftovdD9YcDnqjtPOm6rkHtUeq8jPjpdfpFZrCB
         bA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdRLWuRnA9WFkshkxgv4Av+3azQPL66RiuSI1tP85uw=;
        fh=7hiZSCwoZyaOUYS8VK5gCG7hrrxoWW2nUz6wtZ1T8O0=;
        b=FqX8QH7Ml0j9FzyaCyr1tBo1fZiSAxuDNSCbMrb6JQa2gB+YBQM6iZpEv4Hr0dMtNz
         hKNt3GMKJ2n1477XmGKLDTTezF9sJyHkBWb9QliZ+bk40CYmHpEapRZyxJxcVFL+zijB
         pOb4ydLcUSX2vWYYiHasuEMCOJqXV+SrV0SWkj7HrIHdDV3k5RI+7M+cfRbSh+yX/jJh
         he+Uiy5CQfux4AEPT3b9pvSEdjwocWIJmxNsicBdVXl6laDvl91S8IGXFvDy6i2I32rJ
         ziSDupZvUFgrgHNQOaThsYP6ioiOjGrY2Z87Q1dUeL5GbqKYLC7/54H6hbQPcPLYzg0Z
         DQNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775840989; x=1776445789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdRLWuRnA9WFkshkxgv4Av+3azQPL66RiuSI1tP85uw=;
        b=rfplRdNwLmtq1485FcQYnG9yYcA4JqOjnRrd0GTnhOcjOWDMzTWZxHMu1UhSZvmJYE
         JKDJyeEtpkXeKIBSKBuOKchW5Ecwo+7TfwDN/ZJDBFK9PCbRuBXB2R9WnFVWwHfBIr6l
         U5eCWH3VErvykzhIYEn7jOaQDuvFUGQWrMTku6tpX7IMQ7nelXnrhZecJ4ybKbbwQa2S
         0Rpb7rTrSFYHk+EuHHbeb+gWp9a49TNq7+3oaZayWBcK7vxKo91a9k45udlvTCtrQlsr
         CRGmzh7YITLIHqGuNT1z+R884JxNWTgyNen4HuES1hU5EWI7JGDxPyugarqSWXbxSgx6
         ZxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840989; x=1776445789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdRLWuRnA9WFkshkxgv4Av+3azQPL66RiuSI1tP85uw=;
        b=E5M9e+x1MHUzSifd2Tgqx90QGg4t5GS1IfCyCjBoGY/KGwm/yldB8wsvk0+D7tKifp
         b5iUd81oNykTmabPpA5zarGG3SJQvp/LX/n7Kr1x9oN8sc59+Fiq6PH3D+BWlvl/SndU
         qC92SbLEEcjJVLcwgvkImvnNzFckc9RuzvuzDy7ZIDb7AOChuqMFbK5mV/UySHyRpRHe
         SRNfkrPtb+Fj1ww0+4qje2U/6qnYiqdm5iUmqY4nW+QTYBlVesYY7eXC4iSPa3d0oaOn
         ba8HN/3pOxYwV6NAS3EAYQoagvMXm6PVQbU4SUkQ+Mr0L7nc7L8aaYYGJjPGvlgZ1h7F
         MdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXrgJ7HDWv+Qe/jMJ36JKO+YM4wPWZR7zHI7/eQ6R/uBxOuDre6a3+U3K/yCmtsp2Za5mS3fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hknNe8eKRjaFpNta3qHoHWfoLT3Ragy0jXfJK8jlDJRb6Ja5
	FtGiPPCWKPLMDK/aKCyGdIo5BCRL0SGnaE1akdfcCwEkSD+IazBQktkbbU9Y3TtvtYqhqR6v4vk
	fKN8pxRgOgzqZgvVy02VfWzy1YNHxuww=
X-Gm-Gg: AeBDietYnHM8MRPv4z5NBoxoZIfbE36oD+0kz9Rbze2UJwhM110dlTdTtKW4C9/AUX2
	Jm3HbNNcOIWxtHCwqKOMGiyqAuSGRX7LlISXySgWUQRswE2JAw/PorlcWVPeeugl/oouIunHOzB
	xIlKYQvJ9DVvEDsq0pd0RG0cmuZJmJ0Yr1J0iPPnwVlQsWWvpH6XdEqI2igVRxoVHWSNWYkwUOK
	sPJtHH3yQo7BlFlKbfVJjRaH0SOCQjRs64634bqfDSS8/XdzRUjm0fmXvqxvWPLo3Nc1l4ciuN0
	R0dKiA==
X-Received: by 2002:a5d:64e6:0:b0:43d:c75:9479 with SMTP id
 ffacd0b85a97d-43d642b6965mr6229236f8f.31.1775840988642; Fri, 10 Apr 2026
 10:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora>
In-Reply-To: <adiiTGjP1tqZfIrI@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 10:09:36 -0700
X-Gm-Features: AQROBzCpZMIPHwwS4vGwVuACseQ5RHtCi6FxKCwQuR_ShPf8SxJSWHzXmO8Ytvg
Message-ID: <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
Subject: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
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
	TAGGED_FROM(0.00)[bounces-235648-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:email,birthelmer.de:email]
X-Rspamd-Queue-Id: A71CF3DAE6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 12:21=E2=80=AFAM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> > On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbernd.co=
m> wrote:
> > >
> > >
> > >
> > > On 10/21/25 23:33, Bernd Schubert wrote:
> > > > Do not merge yet, the current series has not been tested yet.
> > >
> > > I'm glad that that I was hesitating to apply it, the DDN branch had i=
t
> > > for ages and this patch actually introduced a possible fc->num_waitin=
g
> > > issue, because fc->uring->queue_refs might go down to 0 though
> > > fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> > > flush the queues without another addition.
> > >
> >
> > Hi Bernd and Jian,
> >
> > For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> > from fuse_uring_cancel" email was never delivered to my inbox, so I am
> > just going to write my reply to that patch here instead, hope that's
> > ok.
> >
> > Just to summarize, the race is that during unmount, fuse_abort() ->
> > fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
> > fuse_uring_entry_teardown() gets run but there may still be sqes that
> > are being registered, which results in new ents that are created (and
> > leaked) after the teardown logic has finished and the queues are
> > stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
> > never gets scheduled because at the time of teardown, queue->refs is 0
> > as those sqes have not fully created the ents and grabbed refs yet.
> > fuse_uring_destruct() runs during unmount, but this doesn't clean up
> > the created ents because those registered ents got put on the
> > ent_in_userspace list which fuse_uring_destruct() doesn't go through
> > to free, resulting in those ents being leaked.
> >
> > The root cause of the race is that ents are being registered even when
> > the queue is already stopped/dead. I think if we at registration time
> > check the queue state before calling fuse_uring_prepare_cancel(), we
> > eliminate the race altogether. If we see that the abort path has
> > already triggered (eg queue->stopped =3D=3D true), we manually free the
> > ent and return an error instead of adding it to a list, eg
>
> In my case (Bernd mentioned that I was investigating a hang during umount=
)
> there were a lot of requests created during teardown, so what happened
> was very similar, but for exact the opposite reason.
> In fuse_uring_abort() queue_refs was already 0 due to an optimization
> where the ring teardown ran before fuse_abort_conn().

Hi Horst,

Just to clarify, is this with running locally patched changes on your
ddn kernel? In the upstream code I'm seeing that teardown is only
called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
-> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
it's possible for teardown to run before fuse_abort_conn(). Is there
something I'm missing?

> Thus the queue->stopped was never set.
>
> How do we make sure that fuse_uring_teardown_entries() has not been
> called by fuse_uring_async_stop_queues()?

If i'm understanding your question correctly, your question is what
ensures the teardown logic in fuse_uring_async_stop_queues() hasn't
already executed by the time we drop the queue lock after checking if
the queue has been stopped? In fuse_uring_async_stop_queues(), the
async teardown work gets continuously rescheduled so long as
queue_refs > 0. The ent holds a reference on the queue, so when the
queue lock is dropped that async teardown work will be continuously
running until it cleans up that (and any other) ents.

>
> Maybe I'm missing something?
>
> My fix was to remove the check for queue_refs > 0 in fuse_uring_abort()
> and make sure that even if the teardown was complete nothing bad happens
> in fuse_uring_abort_end_requests() and fuse_uring_stop_queues().

I'll look more at this path today.

Thanks,
Joanne
>
> Thanks,
> Horst
>

