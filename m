Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223079B1D4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348871AbjIKVbb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbjIKLrk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 07:47:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961ACDD
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 04:47:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so550216166b.1
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1694432854; x=1695037654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nORgkmTlswFH/bOOQW0kCA21wUjdmOzy57ZSBDKPgQE=;
        b=iUJmY8wxDRZ6g7XugxlK9/ztoduG+8cfUBqPF10R2Z6YBbjP250iJv2t5YjIMRjyI0
         xgv0kizbBPMXLWVAXJo4zWgZ6Wi7Z0n2gLelPtH1h53i9EPGv7IFzqGcIYQsmmg7PeIm
         NyTdRgoIPrTUSj8gjhxJUrMXXCqU3QCIXtdKDDlQChMY7UWRSicz3j5xRL2eYou933QU
         IPH/AE0Mr8ZcHPRJH8Nx+0lDDzKTMGGuDO/NwGbJH17BX/lKrq+e2jXpE0zNAKuNLkxG
         d1IMEUfYdcLBOr6AW/U5HGfOwKN8TulCygBX3HrGLFAr950SnGnymLXXVRUaYNPgbSe6
         WCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432854; x=1695037654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nORgkmTlswFH/bOOQW0kCA21wUjdmOzy57ZSBDKPgQE=;
        b=TgMSweygufirY8pR//8yn6LYA+Y5V7P9AQcpRx7pwo7pZRCF3l8dsqCzBWzPUCV4zm
         StnIsFXMd74RT8I5xyAaIQvkEIYgQcnBkJte2KE2/kdx0VQS0JkNpLxRZwVboZNRBE3F
         mTAx955Y5HV1hQIUnazlCs2pYeUQ8VGKLAKQ/kqfO7jvAPC4wESQ4QxXDaWMH0gy7JVR
         SjFGXodcqjApCVKBJr4iZZWiQ6Kf4orbqgvEnhrRNiRV7by8lDEUX1w0zGtSWBFSBPJD
         mq3rHfOFmfTwDlOchfsxP26f2rNXYAGCYmMvh/E58qmuCKp4zhCgUtiLXHWySTuYZf/1
         jVCg==
X-Gm-Message-State: AOJu0Ywypgyad3goJZwI4+ucdq/xUlRfjVB9Mb1eKVu3T5VjWl/GHJkt
        yxt6JnrflemJBhvDB+5cZXjToFQCMcJlxt0NT7c6pcTa5eV4zHeKBWs+nQ==
X-Google-Smtp-Source: AGHT+IG/s/07CMCVruwG1BzsuEavdwyWtwgJCd8qNOPhhjnO7b/txkvrbxqRINXr/BpoxkgXTMXFzPhr19v4+090CBs=
X-Received: by 2002:a17:906:3081:b0:9a5:d657:47e8 with SMTP id
 1-20020a170906308100b009a5d65747e8mr8587760ejv.52.1694432854278; Mon, 11 Sep
 2023 04:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230908230802.3547297-1-sashal@kernel.org>
In-Reply-To: <20230908230802.3547297-1-sashal@kernel.org>
From:   Lorenz Bauer <lorenz.bauer@isovalent.com>
Date:   Mon, 11 Sep 2023 12:47:23 +0100
Message-ID: <CAN+4W8hFq09k37+GDoOj-R_57CNFABuB6BDV8HgqM_pDMK89fw@mail.gmail.com>
Subject: Re: Patch "net: export inet_lookup_reuseport and inet6_lookup_reuseport"
 has been added to the 5.15-stable tree
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 9, 2023 at 12:08=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     net: export inet_lookup_reuseport and inet6_lookup_reuseport
>
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      net-export-inet_lookup_reuseport-and-inet6_lookup_re.patch
> and it can be found in the queue-5.15 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Sasha,

This commit is part of the following series
https://lore.kernel.org/all/20230720-so-reuseport-v6-0-7021b683cdae@isovale=
nt.com/
As far as I can tell this was pulled in due to the Fixes tag on patch
7. I think that tag was misguided, in that the original code
explicitly rejected SO_REUSEPORT sockets so there isn't a bug to fix
here. The SO_REUSEPORT code is quite fiddly, so I'm uneasy about
backporting the change. Could you drop patches 3-8 from 5.15, 6.1, 6.4
and 6.5 please?

This also means that "net: remove duplicate INDIRECT_CALLABLE_DECLARE
of udp[6]_ehashfn" is not required anymore.

Sorry for the mess,
Lorenz
