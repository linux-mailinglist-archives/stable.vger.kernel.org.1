Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802937C8F87
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 23:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjJMVon (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 17:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJMVom (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 17:44:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A79BE
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:44:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a39444700so3210170276.0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697233480; x=1697838280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwv7s6NCzxgY4t0Dh27WWBLwd9xc47rIp4itWh3H/Ro=;
        b=J1Twn+ztxyBnN3t3MAc5wj5DGxtE7TpOQy1Pl2cJZhj3ra3f3YH3XtwlOVQF9VwEuF
         5ssbu0GOTRwd2DMLlLSVNu/dgKQluCfa34xpRdTUNRt2v7wKPi34ZT/yrfqx5nHaIMCS
         JBGbbermJsT3WELe1BhOchpQt+CPTLNI1wQFdAz+uL7gFuZsvuiwoSVfJAvn935x6zXg
         YG15rbd1PLDN8DoYOw5cluBe5J2ZdEI89CkWdwi9goRCDAjR13oREgxwZXlZSBCwhaKV
         9xtaiRuYIV3DYPRDMU8V1bul0AvcYG2jDOZrcn3ul7ONsebMQeRtbOjUayN0y1GDiv2G
         aFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233480; x=1697838280;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwv7s6NCzxgY4t0Dh27WWBLwd9xc47rIp4itWh3H/Ro=;
        b=Yp5GZ3nDzEB0uaVOW5Uotb1DQNvXd33h+wca0dlbHBYTrz0j6qgVH2wiZUMR6bI08e
         pMuX6xIoRd/pFL32OJ/WuVYug4M90zhr4V8McudHLhWQisPEyfiSbOhQoPnW6IIYVw/l
         sIXeVjwSsfFD1t33oXSkispEanI4Tz4HbrGXYDf4BWJhFvEfzVfrRfDrxgM7M91S6izG
         zJSPXrBWdzEqbgnRp+01ZZzgqFwiCROBhwMB49HdTAUnjEvanxjMwsm6G8d8rvQcTQrz
         jpK0tejpkzoE1o1RiAODe0oXU8/9+bI+57+FhQrdr7z2CAfiELCXAcP39dEvi1hMDO6c
         BW1A==
X-Gm-Message-State: AOJu0YzHGKqh3kqIBHELKnfrXxT4XN6XlQOMLXV7Afdw5Z6sk27VJGkc
        YiEJ0yjlc104iXyxuzaSzZNkMJyZqQxxreZ9r3eh3D+2ZQVf3JjPYEC9vt72/z4cWg660pHP3xz
        vfb9Xv/PpWjORsfMngLi6drcdttyaR25ZJtfamZbcpFS0JcMlRIsPdSNgWBw=
X-Google-Smtp-Source: AGHT+IFSxsDh8zkfKVwPmauThFglZKVER523IZBN1L6ibIU7UuzUpafPXLhlcydgWqiLCqpVl0k5ve3nDw==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:2cb4:ec7b:cfc0:caf7])
 (user=prohr job=sendgmr) by 2002:a05:6902:1107:b0:d9a:fd4d:d536 with SMTP id
 o7-20020a056902110700b00d9afd4dd536mr57512ybu.3.1697233480600; Fri, 13 Oct
 2023 14:44:40 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:44:14 -0700
In-Reply-To: <20231013214414.3482322-1-prohr@google.com>
Mime-Version: 1.0
References: <20231013214414.3482322-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013214414.3482322-4-prohr@google.com>
Subject: [PATCH 5.10 3/3] net: release reference to inet6_dev pointer
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2a389895d0a2..193e5f275733 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2727,7 +2727,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
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

