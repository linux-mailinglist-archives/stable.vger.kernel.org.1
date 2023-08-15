Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABEC77C7C4
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 08:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjHOG3J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 02:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjHOG3D (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 02:29:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079D0173C
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 23:29:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so7574427e87.3
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692080940; x=1692685740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ludy8s71/IVequuRzsey/0aGXZOas5qhy1/o2Tc5egU=;
        b=R9HJDB3o2BKpiuDxOVG83IJyv8w8Tp4qjYRcn1F+t0LmvM/uIGFT8rq0O4QwLXu7Qq
         OtcXdsTcaf5r1a5UmoQCj3Pti1Rp/j2Ewr05MClnPRjEo7eJEtyRbQgGU8ARmpELtRHI
         ve8abFSll7ZVVPGNGpkCzXAPV1nJaCmWU0YZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692080940; x=1692685740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ludy8s71/IVequuRzsey/0aGXZOas5qhy1/o2Tc5egU=;
        b=JCjboXeWIaehg+g6PG9exI7r6omKDVy7Nvah1e6yMxlOzBV+aqrqPNVwyP6xf9hTq6
         bQM55zqx3algMEeIpA9DOopF3lu+NDN5bP8va0qvO7u87IWvKYW/xnyJOi+HKchufoJ3
         Gwj7p05ChnLJWzwy+a9+iKJ1+OIC+6vxJCegzTT9ZnOIddfkmHkHYv6VyRQdTeZEqu9v
         iCvbcIJvJ3c+XqSbNEo1xVRIPmn5XW7Shmro7NQMvEDzXDmz/IoMHre886GiWtwMzwbR
         llTaeNflUx62ocQuZmZmafSiIGXpYhxRiOtDlgla32PXdMzNVP11drMeHtwLwTpeGFAb
         Pa0A==
X-Gm-Message-State: AOJu0YwSmYAdJYJTemHdxfQkTThll1qcW0fj/CtUTrr04VLPCpSsX5Df
        lBDmfoaYrIgsUUGzfk2DD3lAwzsr5MYtTSzwdmkpVg==
X-Google-Smtp-Source: AGHT+IG4baKVGgDn3WoawnLHLNLEzp4YlwCBeCoKQsO9EgEe19j4x2LxBnizwWirmAsHG1t+lt2/VA==
X-Received: by 2002:a05:6512:78c:b0:4fe:db6:cb3a with SMTP id x12-20020a056512078c00b004fe0db6cb3amr7336144lfr.22.1692080940262;
        Mon, 14 Aug 2023 23:29:00 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u19-20020ac24c33000000b004fa52552c7csm2291347lfq.151.2023.08.14.23.28.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 23:28:58 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4ff88239785so198585e87.0
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 23:28:58 -0700 (PDT)
X-Received: by 2002:a05:6512:60a:b0:4fe:ae7:d906 with SMTP id
 b10-20020a056512060a00b004fe0ae7d906mr6932731lfe.65.1692080938440; Mon, 14
 Aug 2023 23:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+prNOpqd2Tk1tiBAa9MT6ZPxB5gj9ftxOhaZ-u1WEay9H-oHQ@mail.gmail.com>
 <20230815053132.GB22301@1wt.eu> <CA+prNOrUVWM9-vozUZyW49-m=qFWZR3JAtikZb4T1EimV0ZCDw@mail.gmail.com>
In-Reply-To: <CA+prNOrUVWM9-vozUZyW49-m=qFWZR3JAtikZb4T1EimV0ZCDw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 15 Aug 2023 06:28:41 +0000
X-Gmail-Original-Message-ID: <CAHk-=wgDbr7dw0GP4zEkPu5X2mME3YH9t0+cP8Avs3m0KZxbCQ@mail.gmail.com>
Message-ID: <CAHk-=wgDbr7dw0GP4zEkPu5X2mME3YH9t0+cP8Avs3m0KZxbCQ@mail.gmail.com>
Subject: Re: A small bug in file access control that all have neglected
To:     Xuancong Wang <xuancong84@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>, security@kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 15 Aug 2023 at 06:11, Xuancong Wang <xuancong84@gmail.com> wrote:
>
> Yes, by "full access", I mean `chmod 777`. You can easily reproduce
> this bug on any Linux machine by typing the following commands:

This is how things are supposed to work. The 0777 permissions mean
that you can read, write and execute the file. They do not mean that
you own the file.

As a non-owner, you can set the access and modification times  the
same way you could by just reading and writing to the file. So if you
set mtime, you have to set ctime ("change time") too.

To actually change times arbitrarily and with other patterns, you need
to actually own the file.

             Linus
