Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A472BCF6
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 11:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjFLJqx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjFLJqU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 05:46:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019E69EF9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 02:33:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so6128886a12.3
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562364; x=1689154364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxptPHq1O+ZJRSAEfyKsgsV23hTKa6VIIx3zc9GnV3c=;
        b=hCmcyVytK82HpzCwE/oay+5j6YXulQ5qeBz2qIxRxPCSNBmrxyI/KkUXPV9/C73H2G
         217lTHoZxqJw+nNxRymHSgB3rfxbUk5vmxf8Z6Xf4tZoiLr7e0gJJnwVOe13n7aHl49t
         L1gSSmsYSV7Ujk0CnZhQJtNJdjSppqi23dSUsGMRbxyWNbtWLEgj6Cn3xP03BVl6M1MA
         6eYF6i2fdMInmlARzm5ZYXdkR1d8RvWgp1zFGxNLxYPTAn3e4FmonBJVXT+FV2chBQo+
         cCSgKa0xJe9Dlny+9g3dQsNblopH7UNjPxYqri8TO8G8JEsynvtl7BmSxH8o72Ci0ddY
         AacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562364; x=1689154364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxptPHq1O+ZJRSAEfyKsgsV23hTKa6VIIx3zc9GnV3c=;
        b=jba/hLyrjUO+qEG/SFGGzVR04MXIDgCp1n2KX2OhiWmC1fgd7da0GcRScAMpse4QSO
         l/mqcs0X/K7f0uw0iclL7AQOxfEfTsRVcqUuhJAl+mNMS9KX2qTjIhnIIfDWmIY0h1iR
         7CfNH8rdcrU6ZauXSv9KgrxfrmtCLRu71VgRAmbjpXnbMK82U3yWtn+hJe0c07nxoI91
         NYHaQLds+kD+hGAIviYYUfTP6GJfq3EGZcT7MOJAZ2DzO2A/QgeffEk6kbOQ3f6FnOBg
         NbaSxjH6P/7E47o1rmCmA4CgGq6exRbuDXJb6lvfawrZFG2ry2gGLh4CE+5TKWSM4DM7
         r3bQ==
X-Gm-Message-State: AC+VfDzj0JR/K14T8yv3paOoYLV2040zlNjGmquGNGnlGuhrg8FyULuu
        6K5heHNvvrccPM2zUmHnn2+HluBkmFFkjKuJ0Io=
X-Google-Smtp-Source: ACHHUZ6/FojaJyTEQm9O6Zs6A+IrBkSNajZV0GiHGHRLLIRkYPyz3EOWYKvPK5Eom/xvmuTzP7o8shkmEtop/ADMS2A=
X-Received: by 2002:a17:907:1c97:b0:973:ff4d:d01e with SMTP id
 nb23-20020a1709071c9700b00973ff4dd01emr9772718ejc.31.1686562364436; Mon, 12
 Jun 2023 02:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230611184127.29830-1-idryomov@gmail.com> <2023061228-dab-doorbell-c1ed@gregkh>
In-Reply-To: <2023061228-dab-doorbell-c1ed@gregkh>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 12 Jun 2023 11:32:32 +0200
Message-ID: <CAOi1vP9chuevEnh4j0KTPMJ6VUKSM78TsFL8CQndz40uRXPb-g@mail.gmail.com>
Subject: Re: [PATCH for 5.4] rbd: get snapshot context after exclusive lock is
 ensured to be held
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 12, 2023 at 11:25=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sun, Jun 11, 2023 at 08:41:27PM +0200, Ilya Dryomov wrote:
> > Move capturing the snapshot context into the image request state
> > machine, after exclusive lock is ensured to be held for the duration of
> > dealing with the image request.  This is needed to ensure correctness
> > of fast-diff states (OBJECT_EXISTS vs OBJECT_EXISTS_CLEAN) and object
> > deltas computed based off of them.  Otherwise the object map that is
> > forked for the snapshot isn't guaranteed to accurately reflect the
> > contents of the snapshot when the snapshot is taken under I/O.  This
> > breaks differential backup and snapshot-based mirroring use cases with
> > fast-diff enabled: since some object deltas may be incomplete, the
> > destination image may get corrupted.
> >
> > Cc: stable@vger.kernel.org
> > Link: https://tracker.ceph.com/issues/61472
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> > [idryomov@gmail.com: backport to 5.4: no rbd_img_capture_header(),
> >  img_request not embedded in blk-mq pdu]
> > ---
> >  drivers/block/rbd.c | 41 ++++++++++++++++++++++++-----------------
> >  1 file changed, 24 insertions(+), 17 deletions(-)
>
> What is the commit id in Linus's tree of this change?

Hi Greg,

It's 870611e4877eff1e8413c3fb92a585e45d5291f6.

Thanks,

                Ilya
