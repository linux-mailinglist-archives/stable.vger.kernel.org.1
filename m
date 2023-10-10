Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4A7BFE29
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjJJNnH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjJJNmj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 09:42:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA391A3
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 06:40:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4054f790190so55340495e9.2
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696945220; x=1697550020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSJbo3Jf5hZpxJ7r2XgwmKjkjebO2fblXtzOAiGrInA=;
        b=iZh3AvIGSbDwbXp38wzB/V6sASv0N/XTljd59oC+yvfVTMWXnVZt6ysXMfNyNzmHLs
         xVgKgii08b/WofflwYfKDHwm0wkeKKIvUa112yuM+BCu3xiVYV44hfCZpLqbgS1FkCS2
         uO732V7kdcyiYsp7HGq89+sxX/CTQMEzCtidpRA7gH5wZiyIVfQMdqM+VhyKFWG+63BX
         W+5NgJHXRlvgFEkXuxDu9y1WCy5sDqabtEURjkN+7k/POMWecHcHROOT9GDTvoS24y0y
         BTKXnA2a6mljju0cxmOuK/h8Xroq7lt4J4yKi1YJd67hBp59UFi1YyP3zwpqsWjn0YCr
         tWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945220; x=1697550020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSJbo3Jf5hZpxJ7r2XgwmKjkjebO2fblXtzOAiGrInA=;
        b=mJAFmr6oLjMIvijnBVhX+3QjCqdAiIK1oZ6RiTQJtGndRrqxktLAOTYVaY/I+vaGOA
         4ATRohd0XjlvZSLuPTtSLS0ikyrQHZZfJ2Yyvs47Pay/ZkZx5raQ1ZWurNhsDHAtaU0v
         V92/TW7LpCZIBz/IVCOmy/UChaXeWWZF+Arb6/APY5F9eQlxSxSlTtzouBpsdoo+rNyk
         rKhkol6bluxcQq6j3uCxdZuMZctogx0uPYryen2rdLsrrQw7AJL/YQ1Ov01xeZ9qCCKP
         ixbnb50lAPCVS4v3wdPW5LMVUDUnvnPGjJmf9Q5eZkVTc5waLybQrxolq5eBztIKBGai
         UCfQ==
X-Gm-Message-State: AOJu0YzNLjz4BVS+Al2uuqdcSLgDASokvqCLjCx+5zyqEuxYkFX6RbxV
        MlaJtNDxmsr9MgtF71XcF8UPEUHVGTBbwMfZWtw=
X-Google-Smtp-Source: AGHT+IGi5n6OERa2jdoJ3ZdK+ZIz/qqkok2mJgSmiCxtpGoqBx+LuSJ952TEZsfla+16VVx7oqEvj+cGQuTqd1ynqVM=
X-Received: by 2002:a05:600c:1c10:b0:407:5adc:4497 with SMTP id
 j16-20020a05600c1c1000b004075adc4497mr711914wms.9.1696945220216; Tue, 10 Oct
 2023 06:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de>
In-Reply-To: <20231010074634.GA6514@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Tue, 10 Oct 2023 19:09:54 +0530
Message-ID: <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 1:16=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, Oct 06, 2023 at 07:17:06PM +0530, Kanchan Joshi wrote:
> > Same issue is possible for extended-lba case also. When user specifies =
a
> > short unaligned buffer, the kernel makes a copy and uses that for DMA.
>
> I fail to understand the extent LBA case, and also from looking at the
> code mixing it up with validation of the metadata_len seems very
> confusion.  Can you try to clearly explain it and maybe split it into a
> separate patch?

The case is for the single interleaved buffer with both data and
metadata. When the driver sends this buffer to blk_rq_map_user_iov(),
it may make a copy of it.
This kernel buffer will be used for DMA rather than user buffer. If
the user-buffer is short, the kernel buffer is also short.

Does this explanation help?
I can move the part to a separate patch.

> > Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru o=
n char-device")
>
> Is this really io_uring specific?  I think we also had the same issue
> before and this should go back to adding metadata support to the
> general passthrough ioctl?

Yes, not io_uring specific.
Just that I was not sure on (i) whether to go back that far in
history, and (ii) what patch to tag.

> > +static inline bool nvme_nlb_in_cdw12(u8 opcode)
> > +{
> > +     switch (opcode) {
> > +     case nvme_cmd_read:
> > +     case nvme_cmd_write:
> > +     case nvme_cmd_compare:
> > +     case nvme_cmd_zone_append:
> > +             return true;
> > +     }
> > +     return false;
> > +}
>
> Nitpick: I find it nicer to read to have a switch that catches
> everything with a default statement instead of falling out of it
> for checks like this.  It's not making any different in practice
> but just reads a little nicer.

Sure, I can change it.

> > +     /* Exclude commands that do not have nlb in cdw12 */
> > +     if (!nvme_nlb_in_cdw12(c->common.opcode))
> > +             return true;
>
> So we can still get exactly the same corruption for all commands that
> are not known?  That's not a very safe way to deal with the issue..

Given the way things are in NVMe, I do not find a better way.
Maybe another day for commands that do (or can do) things very
differently for nlb and PI representation.

> > +     control =3D upper_16_bits(le32_to_cpu(c->common.cdw12));
> > +     /* Exclude when meta transfer from/to host is not done */
> > +     if (control & NVME_RW_PRINFO_PRACT && ns->ms =3D=3D ns->pi_size)
> > +             return true;
> > +
> > +     nlb =3D lower_16_bits(le32_to_cpu(c->common.cdw12));
>
> I'd use the rw field of the union and the typed control and length
> fields to clean this up a bit.
>
> >       if (bdev && meta_buffer && meta_len) {
> > +             if (!nvme_validate_passthru_meta(ns, nvme_req(req)->cmd,
> > +                                     meta_len, bufflen)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out_unmap;
> > +             }
> > +
> >               meta =3D nvme_add_user_metadata(req, meta_buffer, meta_le=
n,
>
> I'd move the check into nvme_add_user_metadata to keep it out of the
> hot path.
>
> FYI: here is what I'd do for the external metadata only case:

Since you have improvised comments too, I may just use this for the
next iteration.
