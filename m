Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523E3787BF7
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 01:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjHXXZa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 19:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbjHXXYu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 19:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC80210C
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692919385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4oo63TkSrkUX+Z3NHo9KF69Jc5ETG4Wg8FbWNIW5HOw=;
        b=DpbC3YI9ERtuNO5V1hVzTW6kdJfQuH8mFmo2uVdRMXx52a7yMYOZOeAfgOl45XhJb/ERDC
        zTGgJt2x9OPMaMVEsXZJWrIFANZnIeew/RFuNNH6N7h80pkwyI95SFOkqXrYC/iFZZMiwq
        +Dembwyf1SxyYN5kJvEA06nIuaxyxFE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-zOVKg1LiNhyWVX456xdRdw-1; Thu, 24 Aug 2023 19:23:02 -0400
X-MC-Unique: zOVKg1LiNhyWVX456xdRdw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-529f8ef2db5so340712a12.0
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 16:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692919381; x=1693524181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oo63TkSrkUX+Z3NHo9KF69Jc5ETG4Wg8FbWNIW5HOw=;
        b=EXgUbksMQKlyg9DfUQFG7mBBDpw+sdDaPJeqWASXL2p3aPnFw4E/fbWX9JZYKqfBRX
         80CVWq0LTKcwaxtbr5g359hBvEkxXkedBwY02PRAD3HQN4Wx57N8Ts4LB1lWbg3ZLqFn
         6a59agN/8ktw9/8irtbkR6eSjOy1ph3QNj2B+2pzba4QRo+w8VuVPgLXY1855cDdBl4d
         5+MTwdaqRO8/R0fNLMfYHvweWo3wqqFwbjTQynq+byajnq2Uz7flJrOahXSvYBkCf4Z1
         dtQ1aDQjGQi4RAtecWwWWS115ztnv2ydOKiRp1jWN+4PeqH/rVm+3QrN2KOUpWYcMc2q
         mRtw==
X-Gm-Message-State: AOJu0Ywvp7uYnjMKvT2BoeNTBueqKWuVybwlFtsUKKP+NKxwbNo3aMEF
        AIUPwlMQeAxl41ZGTr3u4uocUmccmXedX19+/8ztgRV2u7c8Tp2Kkgsq4T+DL33oNHyc4fUNMg8
        rJNZ5oaqQJZnAFkwn8PElVbeCNi65dYRy
X-Received: by 2002:aa7:d058:0:b0:522:1d23:a1f8 with SMTP id n24-20020aa7d058000000b005221d23a1f8mr13107656edo.26.1692919381647;
        Thu, 24 Aug 2023 16:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyonal6KJXOHQzqJw6u6txpCMUSkvPsWd2+q/9hdd4MMAPVBbG6Dzlwj9iMdQ6wjV/yHRkcNpT8c3m1nQB+Vg=
X-Received: by 2002:aa7:d058:0:b0:522:1d23:a1f8 with SMTP id
 n24-20020aa7d058000000b005221d23a1f8mr13107650edo.26.1692919381376; Thu, 24
 Aug 2023 16:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230824205142.2732984-1-aahringo@redhat.com>
In-Reply-To: <20230824205142.2732984-1-aahringo@redhat.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 24 Aug 2023 19:22:49 -0400
Message-ID: <CAK-6q+iUe1=68LFv=BVd4MxVhtPf=jGPRFfXXNopEB2J+gjWqg@mail.gmail.com>
Subject: Re: [PATCH dlm/next] dlm: fix plock lookup when using multiple lockspaces
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, stable@vger.kernel.org,
        bmarson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Thu, Aug 24, 2023 at 4:51=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> This patch fixes an issues when concurrent fcntl() syscalls are
> executing on two different gfs2 filesystems. Each gfs2 filesystem
> creates an DLM lockspace, it seems that VFS only allows fcntl() syscalls
> at one time on a per filesystem basis. However if there are two
> filesystems and we executing fcntl() syscalls our lookup mechanism on the
> global plock op list does not work anymore.
>
> It can be reproduced with two mounted gfs2 filesystems using DLM
> locking. Then call stress-ng --fcntl 32 on each mount point. The kernel
> log will show several:
>
> WARNING: CPU: 4 PID: 943 at fs/dlm/plock.c:574 dev_write+0x15c/0x590
>
> because we have a sanity check if it's was really the meant original
> plock op when dev_write() does a lookup. This patch adds just a
> additional check for fsid to find the right plock op which is an
> indicator that the recv_list should be on a per lockspace basis and not
> globally defined. After this patch the sanity check never warned again
> that the wrong plock op was being looked up.
>
> Cc: stable@vger.kernel.org
> Reported-by: Barry Marson <bmarson@redhat.com>
> Fixes: 57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspa=
ce")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/plock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index 00e1d802a81c..e6b4c1a21446 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -556,7 +556,8 @@ static ssize_t dev_write(struct file *file, const cha=
r __user *u, size_t count,
>                 op =3D plock_lookup_waiter(&info);
>         } else {
>                 list_for_each_entry(iter, &recv_list, list) {
> -                       if (!iter->info.wait) {
> +                       if (!iter->info.wait &&
> +                           iter->info.fsid =3D=3D info.fsid) {
>                                 op =3D iter;
>                                 break;
>                         }
> @@ -568,8 +569,7 @@ static ssize_t dev_write(struct file *file, const cha=
r __user *u, size_t count,
>                 if (info.wait)
>                         WARN_ON(op->info.optype !=3D DLM_PLOCK_OP_LOCK);
>                 else
> -                       WARN_ON(op->info.fsid !=3D info.fsid ||
> -                               op->info.number !=3D info.number ||
> +                       WARN_ON(op->info.number !=3D info.number ||

Please drop this patch as I was curious where the per
lockspace/filesystem locking is for fcntl(). The answer is, it does
not exist... I added here also checks to compare start and end fields.
The lookup does not work, even with this patch applied.  It's because
several fcntl() races to put something into send_list and it gets out
of order and we can't assume that recv_list contains the order of
fcntl() calls. We need to compare all fields to match a correct one
which needs to be granted.

The reason why I probably never saw it is because those fields in my
tests are always the same and we simply don't compare all fields on
the sanity check.

- Alex

