Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE81A7151CD
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjE2WWD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2WWC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 18:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C9A0
        for <stable@vger.kernel.org>; Mon, 29 May 2023 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685398871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rb9/kQafNSw5KkGFRQissHuGR3PHQTnYmFgaKvIovMw=;
        b=GU3o7gkFO+yCUZmeIjREeUsXi+wF9E8w25QeaL9dk53dJ8zT2qtPuthByArS/+g+ihNxcT
        fU1ZfbQO22iPCuXJnZbUDDBu1O7fqHmbEW3qLw2MZy+Sladqp6v7y8cwUByHiaKaljtLxh
        HUgXVi9uKA5N7b6/ZeiSc3aO85NiFhI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-lbwn7IszNiSd108Qn4PV9Q-1; Mon, 29 May 2023 18:21:10 -0400
X-MC-Unique: lbwn7IszNiSd108Qn4PV9Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-510ec47c66aso2926360a12.0
        for <stable@vger.kernel.org>; Mon, 29 May 2023 15:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685398868; x=1687990868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb9/kQafNSw5KkGFRQissHuGR3PHQTnYmFgaKvIovMw=;
        b=XWBJHRhVebWE+0eFnVyYmbWf50JlOBImzWEe6gdr2Yf+nkhW0xHn0x7gojj1Ne1YtL
         UYY6MVDM1farF86qb8CyJko4XtGwwkIhiFRybLw18fxBbbtZkfjM9hZ1BLk3jBbjKI95
         JxOxagDVTb5WGFX5ZJHZ2KxqEY4Izl5lxnkZdidQ7eQ2MoHSTDeUl6u1vUMw6aAJs4N9
         TiwabyrLer+WFK2MOsysKPYo+LY9g/EzWwNNkj3HRCLzcBrZ1FpG6gJa19LBmoP6a6y6
         hHF2h/q73l4TGaffPLXLvhC8U/2chFWm3sGSmvx7jt0xvd7gh8k8vxuSBCUD1QQCXMGh
         wPsg==
X-Gm-Message-State: AC+VfDyPXYQQY1Yz+FrOmfZs57NNSZZ/+B/Ur3B+Qbtt3jHAJadfkQIn
        J7jxWdpg8O8BkoEr9JV/QPFpEL/Y3yV8hup9eg40GJSEGPLY88Pwgaem6pE+c/OqLL6/+RvCmC3
        uAZFl5dw4Zoq4eL9UZ6LFY8IZskx7BI9WQn167qnP
X-Received: by 2002:aa7:d846:0:b0:50b:d553:3822 with SMTP id f6-20020aa7d846000000b0050bd5533822mr170475eds.7.1685398868623;
        Mon, 29 May 2023 15:21:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6F+8vzrwPvjCHivMbN9Zp/PZqfxoXtGQjfrQ42SbwJjDwcnVogt6/bYIfcNuLtYG5GchK0GvUNhgnBreNsfP8=
X-Received: by 2002:aa7:d846:0:b0:50b:d553:3822 with SMTP id
 f6-20020aa7d846000000b0050bd5533822mr170468eds.7.1685398868396; Mon, 29 May
 2023 15:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160204.1042858-1-aahringo@redhat.com> <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
 <CAK-6q+gvSO-MRMUPrGVzkO+ki48itzTjnaUC6t_4a+jUs2xV7w@mail.gmail.com>
In-Reply-To: <CAK-6q+gvSO-MRMUPrGVzkO+ki48itzTjnaUC6t_4a+jUs2xV7w@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 29 May 2023 18:20:57 -0400
Message-ID: <CAK-6q+hhQM_4aP_FQPZCX9dQQMD550vAXnSBFpExCt6JiqwrOQ@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next] fs: dlm: avoid F_SETLKW plock op lookup collisions
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Mon, May 29, 2023 at 6:18=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Thu, May 25, 2023 at 11:02=E2=80=AFAM Andreas Gruenbacher
> <agruenba@redhat.com> wrote:
> >
> > On Wed, May 24, 2023 at 6:02=E2=80=AFPM Alexander Aring <aahringo@redha=
t.com> wrote:
> > > This patch fixes a possible plock op collisions when using F_SETLKW l=
ock
> > > requests and fsid, number and owner are not enough to identify a resu=
lt
> > > for a pending request. The ltp testcases [0] and [1] are examples whe=
n
> > > this is not enough in case of using classic posix locks with threads =
and
> > > open filedescriptor posix locks.
> > >
> > > The idea to fix the issue here is to place all lock request in order.=
 In
> > > case of non F_SETLKW lock request (indicated if wait is set or not) t=
he
> > > lock requests are ordered inside the recv_list. If a result comes bac=
k
> > > the right plock op can be found by the first plock_op in recv_list wh=
ich
> > > has not info.wait set. This can be done only by non F_SETLKW plock op=
s as
> > > dlm_controld always reads a specific plock op (list_move_tail() from
> > > send_list to recv_mlist) and write the result immediately back.
> > >
> > > This behaviour is for F_SETLKW not possible as multiple waiters can b=
e
> > > get a result back in an random order. To avoid a collisions in cases
> > > like [0] or [1] this patch adds more fields to compare the plock
> > > operations as the lock request is the same. This is also being made i=
n
> > > NFS to find an result for an asynchronous F_SETLKW lock request [2][3=
]. We
> > > still can't find the exact lock request for a specific result if the
> > > lock request is the same, but if this is the case we don't care the
> > > order how the identical lock requests get their result back to grant =
the
> > > lock.
> >
> > When the recv_list contains multiple indistinguishable requests, this
> > can only be because they originated from multiple threads of the same
> > process. In that case, I agree that it doesn't matter which of those
> > requests we "complete" in dev_write() as long as we only complete one
> > request. We do need to compare the additional request fields in
> > dev_write() to find a suitable request, so that makes sense as well.
> > We need to compare all of the fields that identify a request (optype,
> > ex, wait, pid, nodeid, fsid, number, start, end, owner) to find the
> > "right" request (or in case there is more than one identical request,
> > a "suitable" request).
> >
>
> In my "definition" why this works is as you said the "identical
> request". There is a more deeper definition of "when is a request
> identical" and in my opinion it is here as: "A request A is identical
> to request B when they get granted under the same 'time'" which is all
> the fields you mentioned.

s/under/at/

at the same 'time' or under the same conditions...

- Alex

