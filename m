Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A071645B
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjE3OiS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 10:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjE3OiP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 10:38:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F2B2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 07:38:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6ffc2b314so17025875e9.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685457492; x=1688049492;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAmgzHZ0taY5SPP4pd0mS/kPds5RcHqO8vPNH2ACjiM=;
        b=bJKuox5bonpJzRnpjugtlOsG2jpKt4ahr7g76MTuwCEk77cGlIpvMBnl4o2XbYmS9q
         RUu0AvX2NYG54AgPdXlTbmK+7m334rZlM3z4DYoUYE7igjIdPAfxHOHzqJtKbjs98dT3
         xXJDCP0a+1YNEFCWKnU3y12icOoNBf/SVjvNJHL4o9EM+OL/IjoVSMlxO935QIbcaL/o
         h4kPwoEx+jn9SeMbXhIPXeA7yMet3NoRb8yt3A6KbS+ZD92R7X2uoZJfwdL4F8blNpVc
         WEd825hoUjQ5uXK9as+LlOQdGncLaMmjVDasi78uHZ0hKeO0qhjtnJ9SOiQM23vqEpcA
         W4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457492; x=1688049492;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAmgzHZ0taY5SPP4pd0mS/kPds5RcHqO8vPNH2ACjiM=;
        b=I3mArqeDCwURy++jTNkj/ayBVPc+qcqoFwlvbg43eY6mU80Z6jMRhjYTVJxFsrE+SE
         VTVtGx4nAM9zaWDChuESZqAI5YGLE17ZYrLz5KLj8NkNnMRZ8YCH7QzlvDQsnrr+6Tpr
         uSq2rJfrXcBTZjfEMMLNQ04fESZCshFNmGygnTWTKmA86ReGHeuo9uKyNaJWPjk09jGK
         xRAVFPHIed3OOH5Cp2SWe2FngZpy/K80xOuo0EhKLZvW9xIxqklZaDMuqHYIIjkEIPZB
         mv9frSagT9292dVuN39/osshhapzupDXvVyVHF2Xg1QOAt+tRpLcBsDfc9Ic19QEY8sn
         GsXg==
X-Gm-Message-State: AC+VfDwwHAUA7XjYS/2SWX4a7XKqyOZ8Cm/OppzXpxVFBsXuGwDkxCF9
        X0newqF2m++yFFIgfN+FRzyaTlSuoaELEIo/jxTFwypetP/oQg==
X-Google-Smtp-Source: ACHHUZ53R/pMLv04gr1sGg2cNQNCX9CmnfTpwASfTa7RHqihdHxDTrjIyiodUMmv0zMqAOJl3xwmB/A03TG0i053wWE=
X-Received: by 2002:a5d:4e49:0:b0:309:4ece:a412 with SMTP id
 r9-20020a5d4e49000000b003094ecea412mr7796109wrt.14.1685457491924; Tue, 30 May
 2023 07:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me> <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <20230529113813.GZ45886@black.fi.intel.com> <e37b2f7f-d204-4204-ce72-e108975c2fe0@amd.com>
 <20230530080328.GD45886@black.fi.intel.com>
In-Reply-To: <20230530080328.GD45886@black.fi.intel.com>
From:   beld zhang <beldzhang@gmail.com>
Date:   Tue, 30 May 2023 10:38:01 -0400
Message-ID: <CAG7aomWBf2k6NzJ85Qrz4LN_N=K8O0fbd0p9VSP+jm4FsRaNkg@mail.gmail.com>
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        stable@vger.kernel.org
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

On Tue, May 30, 2023 at 4:03=E2=80=AFAM Mika Westerberg wrote:
>
> On Mon, May 29, 2023 at 11:12:45PM -0500, Mario Limonciello wrote:
>
> Thanks, submitted formal patch now here:
>
> https://lore.kernel.org/linux-usb/20230530075555.35239-1-mika.westerberg@=
linux.intel.com/
>
> beld zhang, can you try it and see if it works on your system? It should
> apply on top of thunderbolt.git/fixes [1]. Thanks!
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git

tested fixes branch, applied patch:
    1) boot with mouse..............: good
    2) remove mouse then put on.....: good
    3) rmmod / modprobe thunderbolt.: good
    4) suspend / resume.............: good
