Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFB7A836B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 15:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjITNas (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjITNar (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 09:30:47 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ABEAD;
        Wed, 20 Sep 2023 06:30:42 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76f18e09716so431515985a.2;
        Wed, 20 Sep 2023 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695216641; x=1695821441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVvtMrQyahCEGoTn1zZw0/f8rWvi3EadqrwsH+LEYoU=;
        b=Qp0v6wVCxLpsVI668waqkz8otA/VNvtbknQNXbr9EZEE858OOKEb4iOtxEw25TVfzQ
         7OJDjO4pzdWfCEmwHYJBv7kMZ3WjAOTKDJap86vpCfozGYyEWz5pjcUDEYgwZpDKpOZi
         QBZVA9sFMou1ZuTqgfyaUQYSVKveztf7AzHsfXLwgB+aacPxzD5cFrvWTXj2YWlpkp9R
         lStCH5HTKBcRL/GMEfUdnvH/kLCx0QAbIvCtzXLPW5UkTKZ4nFOFpV/A7qkpRswbklPG
         15ahxOa/jmCpzN0wB4NDTjsPK8CcZMRJbP+80Acqt3tqyeSi1KJ9Szy75Mg/ycQdlAXo
         O/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216641; x=1695821441;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PVvtMrQyahCEGoTn1zZw0/f8rWvi3EadqrwsH+LEYoU=;
        b=j3rLfCjtmvSsRwQWwqvi/d/ZV/WdZHpnR6cMw/SlAT5Sjb7FdR7yAqvtO46balYSQ7
         dT7zP4AaOGu3yo1oPD/yqiEYOBiBTwqm827P6mpZXyoDo2iCr2X+a62tkMCYw6XGyzZO
         M7ZIdCsBs9czU7LpsrVZgN6vVbIGr7BNoKjLPhIsXSdb3DhavTAXEAUFoeBzPX65LXip
         S4PDgomekoLCPHiXKVfRB+ckiJRuI+d9S8EyBNnRqg0nYgLtKGL/iVINf9a6MJyA0ZBT
         hUkSMhPS3nUhDiDtYZFF/F8EigmkJkHwZLY+3Ik1GXZVA9B5zn1WaHAV8gkpjdIQJFxj
         rysw==
X-Gm-Message-State: AOJu0Yzh9yG+7rVpL9HoxzMFlvSdo92wC2VjDvGEIlRRo3TVSFT9aL++
        n41JdfehQ3NzxshI4/hk2H8=
X-Google-Smtp-Source: AGHT+IH+IiyIV3jecQnzX1d6fu+6EV5NDHV6xVJ8eBfW0mdzNrGT1c2vxkg9J2q2v0YVJ7R6z1wBZQ==
X-Received: by 2002:a05:620a:298a:b0:773:a97f:31a with SMTP id r10-20020a05620a298a00b00773a97f031amr3275726qkp.8.1695216641162;
        Wed, 20 Sep 2023 06:30:41 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a06d000b00770f3e5618esm4804460qky.101.2023.09.20.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:30:40 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:30:40 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Jordan Rife <jrife@google.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc:     dborkman@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        axboe@kernel.dk, airlied@redhat.com, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, jgg@ziepe.ca, leon@kernel.org,
        bmt@zurich.ibm.com, isdn@linux-pingi.de, ccaulfie@redhat.com,
        teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com,
        lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com,
        horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        Jordan Rife <jrife@google.com>, stable@vger.kernel.org
Message-ID: <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230919175323.144902-1-jrife@google.com>
References: <20230919175323.144902-1-jrife@google.com>
Subject: Re: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Jordan Rife wrote:
> Similar to the change in commit 0bdf399342c5("net: Avoid address
> overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
> address passed to kernel_bind(). This change
> 
> 1) Makes a copy of the bind address in kernel_bind() to insulate
>    callers.
> 2) Replaces direct calls to sock->ops->bind() with kernel_bind()
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
