Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F4B7C7AA8
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 01:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjJLXzk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 19:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjJLXzj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 19:55:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38E6C9
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 16:55:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3e5f1742so2215525276.0
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 16:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697154936; x=1697759736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRFpSfD3/S1f+51RBc1Q00/a6mrqX0qyLC0gAl0w7Ek=;
        b=vHvxivvysSMXs0PuGpNx5Y32XaiS8gUMZ6sGslnvJpkYgOWNnc2fpTvV0jFeNL6Y1Y
         auoBMD0uLQtA1vfApxsBApO3ZJ5Vii8mBYApULaHIG5LZcoGWgRv7bLnOn4emnGwXfZc
         GhgpTQP+5UowzlJ7d2qrrHTbLlaUxmiznooTfkoL9DxtYdw7y2pLsd7SFgsiA2BXqmVy
         11yY7UB3ycmInpD3VxyfwNKdeoxpr/hpwb8Hte/dpoiMXp3vTm3ESQ16ImEOafFMfR9p
         wwCul0u4JVjjiujtVJAINdx0gjFzf2KKM17GmTHi2Hc41QBCzxjS0Yi66fCRpXZljhPD
         itXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154936; x=1697759736;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRFpSfD3/S1f+51RBc1Q00/a6mrqX0qyLC0gAl0w7Ek=;
        b=dsx3qhKWtF4rSdVH9FNQ31aMSd8gkSlP1v9RAr77SrRMqJA0vvnn6REyZ7V+Gg5zj/
         awgiOJgmYALXOjriwtknR7V2oRFBz9Nf3ot6l6x1CJWLLWOV4vVWi5y+Vrk8sDRV4eXt
         7rv4Q9r0odTwdUbPrLISRpygLC/bQulkRBLUW1Z4BFHvvoYwg+9QLVVrjY25yyER1Ik+
         Bqn9qYB+r3pAKGoo1mmFMiKEL13o6zyEP/MIWWK/8tCbL3/1eDOtFYwrStBrzMGw6HG9
         pYxkcDpDfv8x0pK41btxIiIx2nL1vvuzISArOuRGbi2vuh06AJ6KliQdV8qC0e8lfafE
         lnmg==
X-Gm-Message-State: AOJu0Yw6NBrAOQruouQk9jSN3PJFboAPS7hqXen4BTXIYzb8m4EYf7Mv
        /i0cF1UO4zYSMIQIVupJhzUmrf5hBBErR09vZrktNKwmozAGn7sD9QYHp6Cva7E3hEJymrovomt
        /zRNNqNuTxykBIJqJTwxcs/TTFPnQmrv//L+y7sy3fiL6cpHQ4nqmrjQ5XyM=
X-Google-Smtp-Source: AGHT+IFYoAeYyYWutnORTCIAhN3C8C2d+l5q+z2VDeMrfVWQ95sft0PsLPOZNM4LMBSooslPDszo6fZoaw==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:b3aa:6851:9f24:c50a])
 (user=prohr job=sendgmr) by 2002:a25:b08f:0:b0:d9a:4a62:69e9 with SMTP id
 f15-20020a25b08f000000b00d9a4a6269e9mr203374ybj.13.1697154935837; Thu, 12 Oct
 2023 16:55:35 -0700 (PDT)
Date:   Thu, 12 Oct 2023 16:55:24 -0700
In-Reply-To: <20231012235524.2741092-1-prohr@google.com>
Mime-Version: 1.0
References: <20231012235524.2741092-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231012235524.2741092-4-prohr@google.com>
Subject: [PATCH 3/3] net: release reference to inet6_dev pointer
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Patrick Rohr <prohr@google.com>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 5cb249686e67dbef3ffe53887fa725eefc5a7144 upstream.

addrconf_prefix_rcv returned early without releasing the inet6_dev
pointer when the PIO lifetime is less than accept_ra_min_lft.

Fixes: 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA li=
fetimes")
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Patrick Rohr <prohr@google.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0929439f5ac1..af92575d04e6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2737,7 +2737,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
 	}
=20
 	if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
-		return;
+		goto put;
=20
 	/*
 	 *	Two things going on here:
--=20
2.42.0.655.g421f12c284-goog

