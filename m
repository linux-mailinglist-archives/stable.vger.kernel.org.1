Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C415F7A3F50
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 03:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjIRBvj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 21:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbjIRBvc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 21:51:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873391
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 18:51:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40473f1fe9fso39778235e9.2
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 18:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695001886; x=1695606686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdhYeWFUupd8CumwOXd56eCg8LNwmhFEfrbDHqjtz+U=;
        b=ZMj51TEesxZx6W2gPBGkGGVhXt2FNtlP17m8awlr55Q6oPZHO9aQucVg4vmFN3Cnkr
         uvrwn8lyOXeFJGAiBOKgfrM7Tz6xSzIZqLcaE25+Z5VC2MQ64IkC6S8vcxzCPciqHsXg
         sVDU4svWZ911DsSAXJhISwWUjmQrzBZ7FKf2/VMrLtNmFP3bncMeXJx3yfq2vwcXmRO+
         bgyiibMAS2E7ShyTk2dpAkciEB0BpO5sMA+FmZoCaBOQGyzhQ+FcGNeYRpyIjC7mjlkZ
         eYt/7jT0g/hSPvd7mpIM85fr5HxDGhr5X1K+SWKjLJirNs4HNVBaurnmbcExMnPbyzvk
         01MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695001886; x=1695606686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdhYeWFUupd8CumwOXd56eCg8LNwmhFEfrbDHqjtz+U=;
        b=bQCrY6bLF3DgoczLfMBrqKFox+DaQlqeYl+SZaa2dM8zOC3FyNGNzWuOrhct+lE4nl
         gjr8na3JzMcBAkYuqRqvx3JfTWzWHuAIMMji9+g5pIw4kvqJOTnvAuvDLTx+yftlqWRO
         c1qQ83EBpVdK2KVGKU65gnftyD3kiyBfnX9RJS2wtqsiZYZJAigzoSfo8Aqbz8MfikrW
         MJ+gYyyxo6qvLYbHbmcPhhaEKMkfUIfnMSdVBkvW6na8naHR+RjQRBI20Ebj6ePlBKOg
         KP0ALyb0Nhj2RBt4sQn3mXf+3ajWXNOkgF7oEpFZ8D0FfZNNiSYERaeRucxvwFi8iwwB
         sbVQ==
X-Gm-Message-State: AOJu0YwM5ykoHSzy++gQ5Gp/zA3BcVeKSqI8BiVKm2hik8y9uMHA1BOb
        wKOnoO2Yhgczmd61Fbgp2jJ+BYJkuGDuWjSvpwU=
X-Google-Smtp-Source: AGHT+IFsN4CSXAya55dgE/LFOVwBdT2N/njIrBCW1aKeXbivsdFRaHER1bQCTOosW08QEABG5AAoe7g6AVganKqPiuo=
X-Received: by 2002:adf:ef8a:0:b0:317:5f13:5c2f with SMTP id
 d10-20020adfef8a000000b003175f135c2fmr8236049wro.0.1695001885774; Sun, 17 Sep
 2023 18:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191101.035638219@linuxfoundation.org> <20230917191109.075455780@linuxfoundation.org>
 <276965bc5bb339bc02bbd653072ceb50a7103400.camel@gmail.com>
In-Reply-To: <276965bc5bb339bc02bbd653072ceb50a7103400.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 17 Sep 2023 18:51:14 -0700
Message-ID: <CAADnVQ+OwQzzGC7tP_qbLYi=k6T4dPKrod57iXt2-_JFCdqF4g@mail.gmail.com>
Subject: Re: [PATCH 5.10 294/406] bpf: Fix issue in verifying allow_ptr_leaks
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>, patches@lists.linux.dev,
        Yonghong Song <yonghong.song@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, gerhorst@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 17, 2023 at 1:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sun, 2023-09-17 at 21:12 +0200, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me =
know.
>
> I believe Luis Gerhorst posted an objection to this patch for 6.1 in [1],
> for reasons described in [2]. The objection is relevant for 5.10 as well
> (does not depend on kernel version, actually).

Yes. Let's delay the backport of this patch until that thread is resolved.

> [1] https://lore.kernel.org/all/2023091653-peso-sprint-889d@gregkh/
> [2] https://lore.kernel.org/bpf/20230913122827.91591-1-gerhorst@amazon.de=
/
