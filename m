Return-Path: <stable+bounces-253517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEDMCr4AD2pfEAYAu9opvQ
	(envelope-from <stable+bounces-253517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:55:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15C5A539A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 265E530BCDB2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4803D8137;
	Thu, 21 May 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6t7CYjH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB623D810C
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367143; cv=pass; b=SaF3LCSyNnLBEHwXjmxZNwvBIc3UdxHNllmBoE4CQuJc5fJSEpYKWVBtyoEL8gFeDO28J+ewaUyKe4rjqZ9S5hfhy4e2Q64jPFVfPodyGT96YAe4R7oIyR30u/ZvWYtKCUxaQsb+54KWL+Qp0c1O5hql6m86k1iL8yDp5h7cevY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367143; c=relaxed/simple;
	bh=RiahDbEJAc+a6SEUc46bDIXeBBSM67xZIAhPJO19bM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIXxeBYjTaJs1QgJ+292nI25g0+swRuN00dZU3Eb0iBdM9EO5mLNqv5n32Uwf4AWZqCrLtZSs/yYGzXY/HE85rRxsR7zvREmGDLAtq00wmfW+wm2mxksd+Ag0aPb6JpInodQQnKqi0x0UABZMw/sbM9Qt78tu7L+eAMrA5GtFNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6t7CYjH; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so2243644a12.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 05:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367140; cv=none;
        d=google.com; s=arc-20240605;
        b=QdDz5CT+7rytsau6L5DVH49WbXVffykKO7QUSGTC0svhEOvCGmFQOemVJgv7RfEuKt
         e8HZHJlp5VPyIV9z55ER88GEwlnlrN2iA9WxfXnWgW63+rS0UhlOn6xR6f9ENjl3WR9u
         3hHgFhJYuzMHB/nXSlzBZswHySqn63wukBao4j8LEqsOod3orQphUx9DoB718FB2NFt2
         n9RSTswz2jctsUCvmF20juMaygv3G9CEiam8YvWR14lf7lutiORRDYarg4vapDGTp17Q
         3eoThoL64OjXqeRJuhBafaTW4+8PGVKzILKcqJjvkobxxoHE4xvtu+RqwVl75P21w4HH
         Q9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dopi5lqgBCxQSuAudmyQPmhNkwArDVQ9G92RMimBsT4=;
        fh=PiZwq+LOb7IxOhagTzzGHpDqLic8VcOt2hTmaHJ0XBo=;
        b=V9x8sjZAH6cRY8J/XD84hlv1AHo/Ewv2XfXbbbtjFSK1tiCYIKi+J76bdqN2WsdmFE
         ASmW2FTUP8HvcQNySTv7k42H4+g4GH0mZnQ0Yx+MAOkj0pGPrenqRtMFx7h6yXaRx1K/
         jG6tf/dHy19OR+F7ZJfJMLyGGQ5uqiecsamB6YVA9A/iIc+aekBotZTQ/SO5JtPY/n9o
         EpAgwcxpwulLAeIhiuV/zgi8SqIpb4j5/neV5MiiWFw+bvmNF3YuhzGJubyoSzIikWHx
         BUbEQQPPVC1dJPU8pc+JOc71xSGqusD/kbAU7al4jwqtxK1/cnXr40RfzzvkUO5FRN7l
         9AUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367140; x=1779971940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dopi5lqgBCxQSuAudmyQPmhNkwArDVQ9G92RMimBsT4=;
        b=G6t7CYjHbyGZ7gGKlWqvPx9K0P/fFJ1Yqfdyz4G0HNiGlffzFndo64mp63NwSqJTBs
         5/EgLXZKHLt5OuPTzoEAPq/uRKMBsnEMzi10+Klv7VPdMV1p8B+iu6Zsi2Kf6LcjXMaO
         8Vn975La2iMumihnbYDIMZMktwezlaw3Wf1lIQHwBGv/KqG6He1OCCqm2DCbL+ggDEih
         U6rU9CJi2kMMRWX2nl4t1kz/1UuKerQ2BbVyvl4HOIoITmEqIPFWA3DO/sdDAefa70+E
         OSg/pK1DEnvCQ0hixSsoZC4H3OwbT+apMMiy70vnUEaHoINx4fHGb+XztwlbqhUmreKG
         dIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367140; x=1779971940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dopi5lqgBCxQSuAudmyQPmhNkwArDVQ9G92RMimBsT4=;
        b=HfWwlfA/1b411DHI4Kwtn49giSpkCuvJ3JQUbth+Uh/gfLwgTBTEfg6W1pEimA3upQ
         gauxq/eP49A1dDZgT2r294ICcS8ShxCWuz/9ugjqs6/hP/isib4OIcMAxf/3yDTIrgXY
         +S/EZBvPCICe4GoJBKVdM/otAUiUkdnjkyGuvyzzIieUWYrOF0YGZsHx2EZSoOx6w1g4
         tFELhmeIRJI1r8pkZfMd1AaKfWFCb+bwQj7v5ncaNxHKXnaiVAQs8eJEJE8g3oQxfOvo
         09RYckptuZ/IjlFdXoB90u+vOpaOB6Nfi0g1SDBj1cf9HAwW0SmJZwL3YKlr/jrAGoER
         FZTA==
X-Forwarded-Encrypted: i=1; AFNElJ+HpHUu3dHBLCMVzEx8MVqN499U9wl83n4zdpj97QiFHhh5TAuSgu8a8ztYLofDv+xIgqAbrgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYMrHhdOs7+e/QmoQGyZMd3Uay+HwoEjB8MBI1xEEZOYwUhDu
	cJhh8PMfNqVIKa8CvgdanyIsvggy1NlN1LDMFvd0X5XZ6DiuiuwF0B3FwLLyix15x4XvutCIGyW
	lCcpcqAW37CBjgQeq4hDVpNvYX+68bm0=
X-Gm-Gg: Acq92OHHgPOzNjOS1+NloDAnp2hwZytbVFz5NIZo8gCmZBQBE+Uj/eTjl3KXf+elJzn
	lZVm5bjXmMwJXD6oAyyTvykACUCyN599FoLVGhDz516pnEQqP1FraIKx4WlMSdkj6dRd4HfeW4I
	pTO0Tfo5Fi+kNt7qSsSoaUErcFCpmO2anefnRYBwix2/SSqETJFARnPDuTIS2ENdFlFMOU6ALde
	okfZxBdEwXOF75O7NDQIjyZg/LfBt5UUFjqtSVvBU7ZdPtA1QnY9ScHBpr6aUItizRgjiIn1bPx
	ELMq3qAJJarNKc26wMhO4NUOOzCUrEtUfPAg2ALZLHusAzkoLw==
X-Received: by 2002:a05:6402:34c4:b0:683:1cc8:84ae with SMTP id
 4fb4d7f45d1cf-688356291damr1244493a12.7.1779367140215; Thu, 21 May 2026
 05:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
 <20250718085948.3xXGcxeQ@linutronix.de> <20260429-november-speisen-3084d769d316@brauner>
 <87340exm2o.fsf@yellow.woof> <xbotidrmois5ygxtqtwqzczkt76wcc7uw5cz5lptda53coaavj@pzvxcpe534cu>
 <87cxzc62yp.fsf@yellow.woof>
In-Reply-To: <87cxzc62yp.fsf@yellow.woof>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 14:38:47 +0200
X-Gm-Features: AVHnY4L3kuzvNft9YsihiRD6AmCZerhnkTxoTD2mo1YBA8rn2fL0bTYmJkGq3-c
Message-ID: <CAGudoHFGHsuGUXmefSrGfOkdcoPJnC5a1qbjc9_G4guC4LvJgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Khazhismel Kumykov <khazhy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253517-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A15C5A539A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 3, 2026 at 3:24=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrote=
:
>
> Mateusz Guzik <mjguzik@gmail.com> writes:
> > Strictly speaking more error prone than the seq approach, but should be
> > faster on weaker-ordered archs thanks to avoided fences.
> >
> > I'm definitely not going to protest the seqc route.
>
> Linus probably wouldn't be thrilled if I break epoll again, so let's
> stay with the simpler seqcount route.
>
> Nam
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index a3090b446af1..22c3f0186476 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -38,6 +38,7 @@
>  #include <linux/compat.h>
>  #include <linux/rculist.h>
>  #include <linux/capability.h>
> +#include <linux/seqlock.h>
>  #include <net/busy_poll.h>
>
>  /*
> @@ -190,6 +191,9 @@ struct eventpoll {
>         /* Lock which protects rdllist and ovflist */
>         spinlock_t lock;
>
> +       /* Protect switching between rdllist and ovflist */
> +       seqcount_spinlock_t seq;
> +
>         /* RB tree root used to store monitored fd structs */
>         struct rb_root_cached rbr;
>
> @@ -382,8 +386,17 @@ static inline struct epitem *ep_item_from_wait(wait_=
queue_entry_t *p)
>   */
>  static inline int ep_events_available(struct eventpoll *ep)
>  {
> -       return !list_empty_careful(&ep->rdllist) ||
> -               READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR;
> +       bool events_available;
> +       unsigned int seq;
> +
> +       do {
> +               seq =3D read_seqcount_begin(&ep->seq);
> +
> +               events_available =3D !list_empty_careful(&ep->rdllist) ||
> +                                  READ_ONCE(ep->ovflist) !=3D EP_UNACTIV=
E_PTR;
> +       } while (read_seqcount_retry(&ep->seq, seq));
> +
> +       return events_available;
>  }
>
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> @@ -735,8 +748,12 @@ static void ep_start_scan(struct eventpoll *ep, stru=
ct list_head *txlist)
>          */
>         lockdep_assert_irqs_enabled();
>         spin_lock_irq(&ep->lock);
> +       write_seqcount_begin(&ep->seq);
> +
>         list_splice_init(&ep->rdllist, txlist);
>         WRITE_ONCE(ep->ovflist, NULL);
> +
> +       write_seqcount_end(&ep->seq);
>         spin_unlock_irq(&ep->lock);
>  }
>
> @@ -768,6 +785,9 @@ static void ep_done_scan(struct eventpoll *ep,
>                         ep_pm_stay_awake(epi);
>                 }
>         }
> +
> +       write_seqcount_begin(&ep->seq);
> +
>         /*
>          * We need to set back ep->ovflist to EP_UNACTIVE_PTR, so that af=
ter
>          * releasing the lock, events will be queued in the normal way in=
side
> @@ -779,6 +799,9 @@ static void ep_done_scan(struct eventpoll *ep,
>          * Quickly re-inject items left on "txlist".
>          */
>         list_splice(txlist, &ep->rdllist);
> +
> +       write_seqcount_end(&ep->seq);
> +
>         __pm_relax(ep->ws);
>
>         if (!list_empty(&ep->rdllist)) {
> @@ -1155,6 +1178,7 @@ static int ep_alloc(struct eventpoll **pep)
>
>         mutex_init(&ep->mtx);
>         spin_lock_init(&ep->lock);
> +       seqcount_spinlock_init(&ep->seq, &ep->lock);
>         init_waitqueue_head(&ep->wq);
>         init_waitqueue_head(&ep->poll_wait);
>         INIT_LIST_HEAD(&ep->rdllist);

Apologies for late reply.

The diff reads ok to me, but I would consider not looping in case of
seq mismatch.

So does it solve the problem?

I think a somewhat of a blocker here would be to bench the thing -- I
would expect some slowdown compared to stock kernel, but should be
still be faster than the previously proposed patch.

