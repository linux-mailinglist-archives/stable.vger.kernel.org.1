Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173B17CE6B0
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjJRSe1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjJRSe0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 14:34:26 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16F7119
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:34:24 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a67f447bf0so17702039f.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki.org; s=google; t=1697654064; x=1698258864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJoYW4hKJUW9mcGOvQ3ugfJthKPcw6V99IOrFYVDWkQ=;
        b=lqf2kHeEZmfN9XtIT+mCix9YncxFIl4n+szeWmNiAE5V1uQSfTlKraMA4LLX9bI0Z3
         rVRdSnLYZB/lka7mJZ4ymBCtdpzN3CwvrcwfMoiEKQRVj4HX0o3ty7ieqhyFfRX7YyEH
         Q1LHK5w+ICvE/KlAejnBMIzmBlWlVr2N7lXVZ3WybCTH/VziT00fwmN4KcQjRa1NoLTv
         4b9kGE02si+mKtNpAraGwy10423DYUl8YHTkGoQuMYhSgcbfxWH+/TtbAh5WLLCwrjhj
         PMRf8bjD06a/Kh8WawXfEPeIzs5pZLm9zQfBQ3WxjM425m0+2VdlqK5A5tEmzoS66OIU
         KcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654064; x=1698258864;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJoYW4hKJUW9mcGOvQ3ugfJthKPcw6V99IOrFYVDWkQ=;
        b=P8A0djxS+VabelNPGGnDmB2FN1NDzFa5kab28TFsP1Xvp++BndJVjxN67Wid/lv82z
         ORzYbr38/HloASVs2FKQZXfcVng/pxGSXNBZDH5bWMQaIWVQHjRZoRhxIBnSv2btUOsl
         5TIQpqHy97XafurCTA7fJhX30OGQnTihjKRERTuVyPUHgmQVNjrgAcgpRwie7XQ/1BIb
         1KiE9zjbj06oFM2tGNnJAgJ+Gp5Qbl6B9vHjCMXdX99XBWK+2X7EL/bfVtPN34o6fEWh
         gFfwuJ6taRf28Fnm3uXZeo+fXM+iuXQmYMApV+EgZOTzIS9dqecRFI6QgMyZ3MB9h7eo
         RcTQ==
X-Gm-Message-State: AOJu0YyuVl5eOXEwnvvXwRxi5DKB0eKpOoMCCAXagIB/7V2/ThtyQ6LZ
        xxBRZ5ZennTwWaKwfW0V7NCKApWNpqf9skLafaIJi1BQl6t7pD/vlsg=
X-Google-Smtp-Source: AGHT+IFQNLRtRcdZaRmbO8RcVjQWB8tXHQQq0ES98+OyNoSBoO0sehgwYycrjtvWxtjGGFg5Yae0Y2Ffj84pLbaZzbM=
X-Received: by 2002:a5d:9d98:0:b0:794:eaef:f43e with SMTP id
 ay24-20020a5d9d98000000b00794eaeff43emr148212iob.1.1697654064247; Wed, 18 Oct
 2023 11:34:24 -0700 (PDT)
MIME-Version: 1.0
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Wed, 18 Oct 2023 13:34:13 -0500
Message-ID: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
Subject: Re: [PATCH] attr: block mode changes of symlinks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> If this holds up without regressions than all LTSes. That's what Amir
> and Leah did for some other work. I can add that to the comment for
> clarity.

Unfortunately, this has not held up in LTSes without causing
regressions, specifically in crun:

Crun issue and patch
 1. https://github.com/containers/crun/issues/1308
 2. https://github.com/containers/crun/pull/1309

Debian bug report
 1. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1053821

I think it should be reverted in LTSes and possibly in upstream.

Yours kindly, Jesse Hathaway

P.S. apologies for not having the correct threading headers. I am not on
the list.
