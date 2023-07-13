Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6C1752639
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjGMPJi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjGMPJh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 11:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC82735
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUgYgb2kelZk4GMT/95PCqHyBSGLmhKOYdEGCv/xiFc=;
        b=R1cBWyrH+EZYgcD7jJwHoX0ryf/81zkeXRl9Fat3z2MLkvNWAFurI5gJapnk5oKQ/o/mrF
        flgVKyEkU0A5eylF9kLG0rW4QZbM7Co8bT597Jm1IScUfYSA+dL2JNLtUQl/3EY++qMoKy
        yUJ9LHkDtz4WuEnIMVUNvYU98i4uarY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-gAc7G-dRNDOOR5-FmDOshg-1; Thu, 13 Jul 2023 11:08:37 -0400
X-MC-Unique: gAc7G-dRNDOOR5-FmDOshg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-576d63dfc1dso6738307b3.3
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 08:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260917; x=1691852917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUgYgb2kelZk4GMT/95PCqHyBSGLmhKOYdEGCv/xiFc=;
        b=Q1xbscEJOLX6xp566pP21rJwSTTpORltjwt3S0NWQyIYYjGyMSqoURNijZPJ2ZnJUz
         yK5j67je1LuSlne7+AWS9TFXLR3ncK9HEkfiEgqlOZrWKFY6ypnhs/hwV53/d/qmwwmm
         ouuenhJWnq7T7o2Q7RxM+VlfErzRdstRh5iM5KN8AGdXxKXqbB0/I2lb9OiGVTSbqpwR
         IlILFV6c6blEuq7Z6cXIc8dMH8+KHXrau3xDoY2tVGX3qU60rA32ox9Y3yIgkN35ikW2
         Xw82YTAgEgkyrJf9KcH5ofxOIGBkWQP5+pBQMh2q6CYAAvfVcKLK0QiYzKkm6zGpqdt2
         tZTw==
X-Gm-Message-State: ABy/qLYT/HA3EtH1hkN8zpatGnYzC5t+iyxvVLizvXYuG9KKAlZ041C0
        0741zJMcpyd1c4dEBU8NGGDWqt1a75uZohirzk5gBlQySSw4GAbDQVDy4HxUfNLEDqcIE7Q+IBA
        MpDIe3yqdYd6mjrfbMwkge6oV8uM7xFogo6VFN4vT
X-Received: by 2002:a0d:cc0d:0:b0:57a:871e:f625 with SMTP id o13-20020a0dcc0d000000b0057a871ef625mr1654527ywd.52.1689260917018;
        Thu, 13 Jul 2023 08:08:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGa8K3WaWqcPe8Ly0B6ohpLfdodb/c6erPOkdw7bYaYKSEpdRc5ofooc51mKzjcw9bVDlvx/r1I3iURGwngHyQ=
X-Received: by 2002:a0d:cc0d:0:b0:57a:871e:f625 with SMTP id
 o13-20020a0dcc0d000000b0057a871ef625mr1654512ywd.52.1689260916780; Thu, 13
 Jul 2023 08:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230713144029.3342637-1-aahringo@redhat.com> <2023071318-traffic-impeding-dc64@gregkh>
 <CAK-6q+j+vQL7nPnr==ZzgWfVoV9idX6k2OT0R_1DJ_qJo4J6mw@mail.gmail.com>
In-Reply-To: <CAK-6q+j+vQL7nPnr==ZzgWfVoV9idX6k2OT0R_1DJ_qJo4J6mw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 13 Jul 2023 11:08:25 -0400
Message-ID: <CAK-6q+g1mpJBjYTN7+BH-XnrkjWzNTAFf8ydydjRQO5+aRVSag@mail.gmail.com>
Subject: Re: [PATCH v6.5-rc1 1/2] fs: dlm: introduce DLM_PLOCK_FL_NO_REPLY flag
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org, agruenba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Thu, Jul 13, 2023 at 10:57=E2=80=AFAM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> Hi,
>
> On Thu, Jul 13, 2023 at 10:49=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> >
> > On Thu, Jul 13, 2023 at 10:40:28AM -0400, Alexander Aring wrote:
> > > This patch introduces a new flag DLM_PLOCK_FL_NO_REPLY in case an dlm
> > > plock operation should not send a reply back. Currently this is kind =
of
> > > being handled in DLM_PLOCK_FL_CLOSE, but DLM_PLOCK_FL_CLOSE has more
> > > meanings that it will remove all waiters for a specific nodeid/owner
> > > values in by doing a unlock operation. In case of an error in dlm use=
r
> > > space software e.g. dlm_controld we get an reply with an error back.
> > > This cannot be matched because there is no op to match in recv_list. =
We
> > > filter now on DLM_PLOCK_FL_NO_REPLY in case we had an error back as
> > > reply. In newer dlm_controld version it will never send a result back
> > > when DLM_PLOCK_FL_NO_REPLY is set. This filter is a workaround to han=
dle
> > > older dlm_controld versions.
> > >
> > > Fixes: 901025d2f319 ("dlm: make plock operation killable")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> >
> > Why is adding a new uapi a stable patch?
> >
>
> because the user space is just to copy the flags back to the kernel. I
> thought it would work. :)
>

* Speaking of dlm_controld here, we don't know any other
implementation which uses this UAPI. If there is another user space
application using it and does a different behaviour then this issue is
unfixable, as we don't know what behaviour we get there.

- Alex

