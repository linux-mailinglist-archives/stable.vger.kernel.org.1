Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3161E7D9ACC
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346056AbjJ0OGd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 10:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345943AbjJ0OGb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 10:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA288121
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698415542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmiVVEtRZXlvZiCEBDmIRly02OLScsCRxyCghuB2vJE=;
        b=UiTec4+Qzgo/GcMIVNFVZmHs8xHkiFBSXoWBHjc0uB2CfFiw1ewnLghgvlIkjAiBpG1NZC
        5PPhmRRwr1azjqR5yAmMSMa6tObjh7KpkdY3nx32x2scLkmZOJYcNu7Busg+8EeqMnQA5J
        jzXOAR4+hDcQtdGZ1WuUhB/4SB+f3dI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-oYsDGVExNrKn02ab_0a_8Q-1; Fri, 27 Oct 2023 10:05:39 -0400
X-MC-Unique: oYsDGVExNrKn02ab_0a_8Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2801ff79244so27093a91.2
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 07:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415539; x=1699020339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmiVVEtRZXlvZiCEBDmIRly02OLScsCRxyCghuB2vJE=;
        b=TgfSIy/S/b0HQCawNEQ8DZKqJpJjYQPZyT12p1+17xKROIxcVVNxuQZe4tHWa0kR0C
         XId7WrXSrUZTh55d/eQU+Gf+pEo58TxGxU18hCwK2pKxG2CS7wE4b/gsVS/8WWMwy/f8
         FX5I6Qe85N7MPX1pFQC0TMs0oaHrLt039uCXSndKvr9QAXaUMUZgb7nDBrdNUc/d8+GX
         GqZfRkkydz+XvmU/PWSaSCsz9iUXfIso9oDpp5vQtKYHaHH8kmZKuRNBC3tVpaiKqaX4
         23k6KvvBcBo4wC+jX0KfkzW9IEXTjTFoeLL5byvl8fIW+D8vXzoQ2aJ+0+XyJtfRXV2c
         bnLA==
X-Gm-Message-State: AOJu0YyNx+9M8oPOlO07XYbf5llIg9rtNSrV2a0hde2gtFnxU5v5e9dd
        qOQubGR+8EIBIo5wzM0LX38B+vsk+lfGtBDYPBGFqPQ//NCMWJNojLd+/MH5cGq2j7gXokI0irg
        TG7LcUrh/6ErY6NggoqDkTKeTcRKN+4u+
X-Received: by 2002:a17:90a:4f48:b0:27d:166b:40f6 with SMTP id w8-20020a17090a4f4800b0027d166b40f6mr2532531pjl.41.1698415538763;
        Fri, 27 Oct 2023 07:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz7lrTl+zAdmgTnAvT/azIXBCe0/XGufVtBRSSehgdm4mTofu5iqEwH7u2CGPh9s/wxC1dldLVGTED5Rv21bY=
X-Received: by 2002:a17:90a:4f48:b0:27d:166b:40f6 with SMTP id
 w8-20020a17090a4f4800b0027d166b40f6mr2532514pjl.41.1698415538507; Fri, 27 Oct
 2023 07:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com> <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh> <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh> <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
 <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
 <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com> <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
In-Reply-To: <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 27 Oct 2023 16:05:27 +0200
Message-ID: <CAOssrKeJB7BZ7fA6Uqo6rHohybmgovc6rVwDeHbegvweSyZeeA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 3:39=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> On Fri, 2023-10-27 at 15:24 +0200, Miklos Szeredi wrote:
> > On Fri, Oct 27, 2023 at 3:14=E2=80=AFPM Andr=C3=A9 Draszik
> > <andre.draszik@linaro.org> wrote:
> >
> > > The patch in question has broken all users that use the higher
> > > flags
> > > and that don't use your version of libfuse, not just Android.
> > > You're
> > > filtering them out now when you didn't at the time that those
> > > ('official) high flags were added. There are a couple more high
> > > flags
> > > than just the one that Android added.
> >
> > Okay.  Where are all those users?
>
> That's not the point. The point is the kernel<->user API has rendered
> them too non-working.

It is a very important point.  A theoretical bug isn't a regression.
Nor is a broken test case BTW.

Please read section 'What is a "regression" and what is the "no
regressions rule"?' in
Documentation/admin-guide/reporting-regressions.rst.

 Thanks,
Miklos

