Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569D0753C3E
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjGNNzT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjGNNzS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 09:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8AF3599
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689342861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PK6HaFz82C/bdWyaRva/u+XDHKqnF71p3ds0rNqF6w=;
        b=AoE5Mhe553Be/91VfXB/btjr7BSLC5rmDcjFZyA/HPukatOJh2snjeqDreMVEASFXJRL8P
        uVFztbqz0dTwgd3mecr3M7r0xowh/P9LbFMByAAZr4u4AglofzTGcXPVU0wrmn0vVE1NZe
        uhV2AUFo1M3FYo+eT8Iedch5R6LJFZE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-5LdpiV98Md6UsRpKalQD4Q-1; Fri, 14 Jul 2023 09:54:19 -0400
X-MC-Unique: 5LdpiV98Md6UsRpKalQD4Q-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-55c1c7f872bso875726a12.1
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 06:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342858; x=1691934858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PK6HaFz82C/bdWyaRva/u+XDHKqnF71p3ds0rNqF6w=;
        b=lRAMV0aqCHod/55AdiGBEmvI4CYPKnG81W5ueTuA1UVc54QY2l1juIFDWqor1AXcXV
         sSYMbKCglt0X6bp7TJsjfwAmq6x/O6yVpo0YRRxHnhhdX/m+co3/NHamPkd6MwB/joJA
         U7dvMHoZvNEFHqtUAsBAidnBM4husXbl4wImm5/0x4NZ5uVR9mXacKhgeGS9Nu+aqQmj
         sma2Pbw1vr6SXAqH+l4njPSCuxsHFWuur0gDJiAkUtfYdqOH5x4NKM7ovrUTLz1id10q
         k0WeeY14SdEyxJGn8qV2SeO0YE52icWM7A4RfaUniJPY8/2XAsXGKUUaKU8BTPwpUwXK
         6UTw==
X-Gm-Message-State: ABy/qLaSJKz2zkG8iveu3tS4uoMnQKS4IjXi4Yk9wbwIbfsGvQMNYdVF
        fwbTyc9QHaIMVikgMwkJ1U6fP9EW4AtNmR/pT77Dw+p3RZtGntWx7COV4JH8C+u6w631PHjfSbz
        s8eu13lBE11D2ERNnl8U1+Y0Bhb5EJi0H
X-Received: by 2002:a05:6a20:2588:b0:12e:49f3:88d4 with SMTP id k8-20020a056a20258800b0012e49f388d4mr4368006pzd.1.1689342858636;
        Fri, 14 Jul 2023 06:54:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHLQqVnt/mSH9AqHCVbmDj2KJ8TP2QEeDyFhtvzbrRfZYYONJeztval1fWTb8L/71DlqSxGqJw0P7geoPeWBIU=
X-Received: by 2002:a05:6a20:2588:b0:12e:49f3:88d4 with SMTP id
 k8-20020a056a20258800b0012e49f388d4mr4367984pzd.1.1689342858224; Fri, 14 Jul
 2023 06:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230713144029.3342637-1-aahringo@redhat.com>
In-Reply-To: <20230713144029.3342637-1-aahringo@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 14 Jul 2023 15:54:06 +0200
Message-ID: <CAHc6FU542V6T8F8W-npN24zVJih5iRckGHqHLPrVHLhLqWBOgA@mail.gmail.com>
Subject: Re: [PATCH v6.5-rc1 1/2] fs: dlm: introduce DLM_PLOCK_FL_NO_REPLY flag
To:     Alexander Aring <aahringo@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 13, 2023 at 4:40=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
> This patch introduces a new flag DLM_PLOCK_FL_NO_REPLY in case an dlm
> plock operation should not send a reply back. Currently this is kind of
> being handled in DLM_PLOCK_FL_CLOSE, but DLM_PLOCK_FL_CLOSE has more
> meanings that it will remove all waiters for a specific nodeid/owner
> values in by doing a unlock operation. In case of an error in dlm user
> space software e.g. dlm_controld we get an reply with an error back.
> This cannot be matched because there is no op to match in recv_list. We
> filter now on DLM_PLOCK_FL_NO_REPLY in case we had an error back as
> reply. In newer dlm_controld version it will never send a result back
> when DLM_PLOCK_FL_NO_REPLY is set. This filter is a workaround to handle
> older dlm_controld versions.

I don't think this makes sense. If dlm_controld understands a
particular request, it already knows whether or not that request
should receive a reply. On the other hand, if dlm_controld doesn't
understand a particular request, it should communicate that fact back
to the kernel so that the kernel will know. The kernel knows which
kinds of requests should and shouldn't receive replies, so when it is
sent a reply it doesn't expect, it knows that dlm_controld didn't
understand the request and is either outdated or plain broken. The
kernel doesn't need to pipe a flag through dlm_controld for figuring
that out.

Thanks,
Andreas

> Fixes: 901025d2f319 ("dlm: make plock operation killable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/plock.c                 | 23 +++++++++++++++++++----
>  include/uapi/linux/dlm_plock.h |  1 +
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index 70a4752ed913..7fe9f4b922d3 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -96,7 +96,7 @@ static void do_unlock_close(const struct dlm_plock_info=
 *info)
>         op->info.end            =3D OFFSET_MAX;
>         op->info.owner          =3D info->owner;
>
> -       op->info.flags |=3D DLM_PLOCK_FL_CLOSE;
> +       op->info.flags |=3D (DLM_PLOCK_FL_CLOSE | DLM_PLOCK_FL_NO_REPLY);
>         send_op(op);
>  }
>
> @@ -293,7 +293,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 =
number, struct file *file,
>                 op->info.owner  =3D (__u64)(long) fl->fl_owner;
>
>         if (fl->fl_flags & FL_CLOSE) {
> -               op->info.flags |=3D DLM_PLOCK_FL_CLOSE;
> +               op->info.flags |=3D (DLM_PLOCK_FL_CLOSE | DLM_PLOCK_FL_NO=
_REPLY);
>                 send_op(op);
>                 rv =3D 0;
>                 goto out;
> @@ -392,7 +392,7 @@ static ssize_t dev_read(struct file *file, char __use=
r *u, size_t count,
>         spin_lock(&ops_lock);
>         if (!list_empty(&send_list)) {
>                 op =3D list_first_entry(&send_list, struct plock_op, list=
);
> -               if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> +               if (op->info.flags & DLM_PLOCK_FL_NO_REPLY)
>                         list_del(&op->list);
>                 else
>                         list_move_tail(&op->list, &recv_list);
> @@ -407,7 +407,7 @@ static ssize_t dev_read(struct file *file, char __use=
r *u, size_t count,
>            that were generated by the vfs cleaning up for a close
>            (the process did not make an unlock call). */
>
> -       if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> +       if (op->info.flags & DLM_PLOCK_FL_NO_REPLY)
>                 dlm_release_plock_op(op);
>
>         if (copy_to_user(u, &info, sizeof(info)))
> @@ -433,6 +433,21 @@ static ssize_t dev_write(struct file *file, const ch=
ar __user *u, size_t count,
>         if (check_version(&info))
>                 return -EINVAL;
>
> +       /* Some old dlm user space software will send replies back,
> +        * even if DLM_PLOCK_FL_NO_REPLY is set (because the flag is
> +        * new) e.g. if a error occur. We can't match them in recv_list
> +        * because they were never be part of it. We filter it here,
> +        * new dlm user space software will filter it in user space.
> +        *
> +        * In future this handling can be removed.
> +        */
> +       if (info.flags & DLM_PLOCK_FL_NO_REPLY) {
> +               pr_info("Received unexpected reply from op %d, "
> +                       "please update DLM user space software!\n",
> +                       info.optype);
> +               return count;
> +       }
> +
>         /*
>          * The results for waiting ops (SETLKW) can be returned in any
>          * order, so match all fields to find the op.  The results for
> diff --git a/include/uapi/linux/dlm_plock.h b/include/uapi/linux/dlm_ploc=
k.h
> index 63b6c1fd9169..8dfa272c929a 100644
> --- a/include/uapi/linux/dlm_plock.h
> +++ b/include/uapi/linux/dlm_plock.h
> @@ -25,6 +25,7 @@ enum {
>  };
>
>  #define DLM_PLOCK_FL_CLOSE 1
> +#define DLM_PLOCK_FL_NO_REPLY 2
>
>  struct dlm_plock_info {
>         __u32 version[3];
> --
> 2.31.1
>

