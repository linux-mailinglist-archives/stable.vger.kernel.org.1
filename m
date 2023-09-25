Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DC67AE093
	for <lists+stable@lfdr.de>; Mon, 25 Sep 2023 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjIYVLQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 25 Sep 2023 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYVLP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 25 Sep 2023 17:11:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5910F
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 14:11:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d868842eda1so6638273276.0
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695676268; x=1696281068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imybKAc0k7RBPxQB8Jc+VByaxS4+Mxxvrxvdg6Xv+7o=;
        b=4PMC6o5xGzc3dNQXMXuSQBn0yNw7VA0VgV5sHzgTwqe8uzdwy6Hd4OzSyJE6dG7k8Z
         rKN+r/N/boPyPVvyctHSktVUNZshh+pnJ0fesg14Po+/DChp+vRyyXjIW0bzsaIwpCNN
         tUvBP/wNRaEoTqe79vpiEXvVPrK/TOFefy6C3J6Elt84dYoGt9GKdLYh4BrP/O5VBS2W
         26Q3aGoe9hYPQ8ycQRyKCEDwjqhqNB4S0Sa/Yfk1BZU+EXzH/UWsuqlGlwv+0YwUiS0H
         DxsSX0PpFm9Pc+d8QjDpnqdAt/N5L9weu4tWwjdo78hEzvEHusM+23bA+OY8V3vWu6rF
         kH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695676268; x=1696281068;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=imybKAc0k7RBPxQB8Jc+VByaxS4+Mxxvrxvdg6Xv+7o=;
        b=vfBbngg8li6T5YjXrQiUrEJ/OUTtOSmZ60XLw0ARgevAltkufcH/1qpg7iEqdqetXk
         j3k4ilix3/qKWJZxTKTmsMY+FbcaxTS9bRT4brxjpxWZ4c+8B2T7AvzJwwIM/kaz1lkZ
         BrcLUL2qXkBvqGwU8x2hkN/Jd7Umvuww/HTUesi8QdOkBTcXNgkhvKg0DmIRyvQAK+em
         3QKw5glYMZkrNJDm00/kK6KcA+eUxkqvCF4L05VT1F2TA6lHjhTCWxUTJ5WYuaTDEwS0
         n96BAa0YZELQDMWmrCTe4RAr+VKJDaG2x+sIf79CBkgX9xSGVO6AggjYVYBC9pSXE+0b
         FNhA==
X-Gm-Message-State: AOJu0YwjsJln44WWQB8IdMLUmskmgcfDGlkX2wYgAdN9UjJEIn8Uah3o
        XZL76soL0O8b6isPbDLzEqwg/SUYsV23hRYfW8DwMn8Sv/6SpHkNBHfYTFZccYLNWFAyxPkUThP
        yo1XYA24ajNeRsWtPojWi99MwQ3cXRngZlsRZ/SBGzvk36c10jX657jp9uBA=
X-Google-Smtp-Source: AGHT+IFS+C8q2fL7VFIIaACdT60ZoRt68mrhP2IvzSHNqMR7ibKyeoO6HxJXIAMTZcuon9TLgaun7WveZg==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:146d:2aa0:7ed1:bbb8])
 (user=prohr job=sendgmr) by 2002:a05:6902:161c:b0:d0e:e780:81b3 with SMTP id
 bw28-20020a056902161c00b00d0ee78081b3mr78147ybb.2.1695676267957; Mon, 25 Sep
 2023 14:11:07 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:10:34 -0700
In-Reply-To: <20230925211034.905320-1-prohr@google.com>
Mime-Version: 1.0
References: <20230925211034.905320-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925211034.905320-4-prohr@google.com>
Subject: [PATCH 6.1 3/3] net: release reference to inet6_dev pointer
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
index 53db8daa7385..96f4351b55a6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2734,7 +2734,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
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
2.42.0.515.g380fc7ccd1-goog

