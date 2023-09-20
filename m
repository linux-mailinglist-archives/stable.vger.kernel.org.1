Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369A27A8356
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjITN1a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjITN13 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 09:27:29 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E31E0;
        Wed, 20 Sep 2023 06:27:21 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-656262cd5aeso34303456d6.3;
        Wed, 20 Sep 2023 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695216440; x=1695821240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lJBAHwXz95QANGBLZn265N6QlIJAVj8T25LP6ROrKU=;
        b=UKTLqVBcncDOEBfJGGP8uKLDvgy9H50mL7gM5FfHOG87DEEMuFyCujMnNk2N78cxu1
         BFvHOynSJTvhBSgJA5Zn9o41XGU+R74D6Tb9WeWREj2Ad1W0N5uYnlbY7v/Vgx5Uqd+y
         /3XiJmg3AjwJ+/zvuWHxPy7SqycMAsc30TGOq/QEQdhOqinly3aYPLx5SBgq+gyA60Ju
         /WVVEiYprSvOqD8ojaVp4+i3EgLwHgYQ9Ph5/sljhx1UbVbd+wHy8k0RZGiAkAtbhvLM
         OuS5JyV9l/pRYCRXz9enJJG9oBu+71gh6qZpXgo5WjCzcPsjL3E+wPOlpJXwGCVpEIP7
         OLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216440; x=1695821240;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7lJBAHwXz95QANGBLZn265N6QlIJAVj8T25LP6ROrKU=;
        b=ptquM1AlMMV2NQV617jW0v6R7fNa+aZtsNjhyd5Ro03CEAMaOQBPGpVDNlZpr9Hv8A
         IOr9pf/9wDyaj9AfLwhy5eNZxS8AADvfuBQysebNHGW76yt68meSPs2F9waUcLd30Sp5
         HmZhZQNkIFoH1LOrc1Je/KHXzJakZaRAUkMBwLlr9T0BAjpGDEumFsNCmPEPsHnLm6jV
         757067RPVvzK8Qrta39QWFS3W8uut6BihjT95wNCwwuo6kd5Mse3GkO8Q1RAHc4/22D4
         b09mHTZ9A9GmDvXFxqNrxrEHINem4FP17YVnQ1o0UeCEdrlMDfJV7RSSXx1OInKfdKCq
         TMbg==
X-Gm-Message-State: AOJu0Yzqa/JiFcnG5TcBFnBln2didXJuUBg99Izq5xX58k8gIWApcyvL
        Cj84nXm1CY6ePUVLAMdI7VdwiO6e1U9xhw==
X-Google-Smtp-Source: AGHT+IG5b3th4xNUuvg+sk7Pn9aTH4enYL56voYGp06KsdUbZ1iypoRXYbAp1/62ou/mXzeE41X1ag==
X-Received: by 2002:ad4:4532:0:b0:647:2f8f:8c29 with SMTP id l18-20020ad44532000000b006472f8f8c29mr1983309qvu.48.1695216440547;
        Wed, 20 Sep 2023 06:27:20 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id x18-20020a0cb212000000b0063fbfbde4adsm5257903qvd.129.2023.09.20.06.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:27:19 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:27:19 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Jordan Rife <jrife@google.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc:     dborkman@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        axboe@kernel.dk, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, jgg@ziepe.ca, leon@kernel.org,
        bmt@zurich.ibm.com, ccaulfie@redhat.com, teigland@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        sfrench@samba.org, pc@manguebit.com, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com, ericvh@kernel.org,
        lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com,
        idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
        horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        Jordan Rife <jrife@google.com>, stable@vger.kernel.org
Message-ID: <650af33778093_37ac73294a9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230919175159.144073-1-jrife@google.com>
References: <20230919175159.144073-1-jrife@google.com>
Subject: Re: [PATCH net v4 1/3] net: replace calls to sock->ops->connect()
 with kernel_connect()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Jordan Rife wrote:
> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> ensured that kernel_connect() will not overwrite the address parameter
> in cases where BPF connect hooks perform an address rewrite. This change
> replaces all direct calls to sock->ops->connect() with kernel_connect()
> to make these call safe.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
