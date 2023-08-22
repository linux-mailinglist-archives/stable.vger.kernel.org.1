Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D652784B85
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 22:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHVUhW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjHVUhW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 16:37:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC7CEF
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 13:37:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so4370a12.0
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692736639; x=1693341439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=621Dqja2RNYBFFHxmHaf8VVJzOZCsbe/JAuSG72Lm5M=;
        b=Qf4va+JJGu83spSuvNpiszBgy/kH1iwdNNXWCBAZmhHIlX75e2TwfBBue0Qbx54L6o
         juGixw46nbOVFnTinQGxBNf7kqc1pCXq/bCuX3aZ1wUtgQOqMJY74Kd0ZHPenB793h46
         6GGAXUgXnAqEca3toJ/UfpCyqwH65Zcqpj41gYgmD+I33ZJw9gmo602WqDWN1WXuCNuu
         xj+fBTsQeRzlCB/I2e8tFx6H4rig8Uy1foqib4hViYRGmHi1i78DPdNOYY2On+qr3WMB
         MlNhJmg0t5X/zKr2HNFlZbRIipmFxtS2UjmRkiS8lDU93qzZgtuO17oNbc56lwo6SctM
         UCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692736639; x=1693341439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=621Dqja2RNYBFFHxmHaf8VVJzOZCsbe/JAuSG72Lm5M=;
        b=MIU0Rf/85RjmRQODHOEl2Dzo5+Az6dFGKu+PrHCQJd6IWh1ofh3vUY2A6oclK8vGTJ
         9PHXWSUngx4Vx9TGUW2TQigdlRCycU7VNht8V8GxwUTsxrilJ4fAwjGS+w7NBuJFrOvJ
         Z3Ji5pbzxl6fWAJciBfBYXKbqJtCxtON04viL+JxtQ1lkc28dV7MxmGMM2O3Zc2p0RL0
         +BaNoPnFmTGRud0ATjUwHxRPhhn4mOptyyyxlO487dGyjU7iY+RJ7nDiO23dIVM8DaZg
         wMLj3UNs2DgKnzOb6NcdsGqcWf6psFMa4zjPgaMnvyqjreT16zXRWrVr5k7VHAU2u4gj
         FLnw==
X-Gm-Message-State: AOJu0YxG268/e1AFaudTlQLh8pQAdFYa5tsjorQUMfHA6w8VbXMLCBM+
        OPqqBISspPRb0lruKGPoeurdbkMBir27PfXL43NtOg==
X-Google-Smtp-Source: AGHT+IFoCsdtugQC1NgLocnGbVdSHy/DAl3o3XYzBnz31F2BWo2BiRQvWRAUz1StSS4DOMOa924oiZrNR/QOFtwI6dc=
X-Received: by 2002:a50:9fa9:0:b0:525:573c:643b with SMTP id
 c38-20020a509fa9000000b00525573c643bmr154602edf.7.1692736638776; Tue, 22 Aug
 2023 13:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230731165926.1815338-1-rdbabiera@google.com>
 <CALzBnUFH=eQmhdpkt5_czKsZ22=u6yDoZZ0TX4eJkHGbjLANAw@mail.gmail.com> <2023082231-strode-pretty-f5a3@gregkh>
In-Reply-To: <2023082231-strode-pretty-f5a3@gregkh>
From:   RD Babiera <rdbabiera@google.com>
Date:   Tue, 22 Aug 2023 13:37:07 -0700
Message-ID: <CALzBnUHXnRjDMr2BaGp4btY3HZu_j4=VB8S-FUC1jiL_aoHBJQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: set initial svdm version based on pd revision
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        kyletso@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 22, 2023 at 5:38=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> What patch?

My previous email was a reply-to for the email containing the patch, at lea=
st
when I look at the kernel lore it's accounted for with Message-Id
<20230731165926.1815338-1-rdbabiera@google.com>.

> And note, people were on vacation.  If can, to help your patch get to
> the front of the review queue, please review other typec patches on the
> mailing list.

I'll start looking more actively and helping where I can, thanks for the
advice.

---
thanks,
rd
