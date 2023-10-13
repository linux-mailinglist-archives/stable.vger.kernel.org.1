Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6B7C8EEE
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 23:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjJMVV1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 17:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjJMVV0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 17:21:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55225C0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:21:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a483bdce7so3543608276.2
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697232083; x=1697836883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Xl4o0sN/giETS+teJsYKeTJ21IhgwBeucUPuguVU+M=;
        b=c4BisnYgpTNg88XA3wCRipWBjB6nVxJJs+Gm6qkwGysppppJP+Ry/1dd4NF+PYvYlK
         zC7uUSITtoH9jdlldnbfMTvm2tr/ehHy5Czx1TkMNz65siw50PsuqvC9kDclCAMymgDv
         dPKpSE+1v127rfvw2KZIhMKPp9kjoTBiXKdmxbYfqKbGXiglwZ0jpF/kBmoROTu7MiLY
         nfbi8et1P6KjyTGuR/odmAp+yUFV1uRb2eQqN0zwZ3t3/I2/at3R4hFN7dUQKeV0JOyh
         fy4yS8ylu1LF5nbcAnEkr8n1cunUnvelRW053xwfEa0nEaAmHiUto6vj6tYLySyBLqbb
         Z4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232083; x=1697836883;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Xl4o0sN/giETS+teJsYKeTJ21IhgwBeucUPuguVU+M=;
        b=tw+vrLyXm5LNYreuLNCjDBd2+1WsVVkLX3en0c0udoOzL8oZtMGbW4iqyWRngCBXSF
         0GTBgnOtw28O59RmBtYWZkJPNxEv0AMLE4t8v7v5+Ny5dfP7WH0VL6ELKi4Ve3B7KITb
         daGu5EVsfZb5scmAlyl19mNzRte+2Gsqnzw/1X+5BCj8rrLk0PcuR8LWacTYD33UPXsL
         NgVsb21hkoc2IJzcZoma70YmasAhMc7hd1sS0g4r9t4IClJR4ns9g2F1N5q5GPAOiRxm
         s9tRv/1OCmC4Zaeh6E/sdrUIceDQiR8II8yRlEZssoLOwiz+wOXhPnMeotdMX1e84FqA
         5XIQ==
X-Gm-Message-State: AOJu0Yzlr3W06oETeAKvJeDVoTMKqoojAwzviXdBPgDC9VIPK+v7G1kM
        3iKfbQZS1B7uLEZrBxVeKodA73RRMNE3RC7UrME40DUtGXRFnQ+1F59HX7Do6GZLI7TfMtDZymS
        EXbK5o+IqoHTQs8YSf8J8fFXDMaKahx34dOrnydaqeJxg1vQGhE4u3v/F+ec=
X-Google-Smtp-Source: AGHT+IFAkUflWE9yW7l8JNRhX8IN7OEyQzfIRKq5nGLcvBTgVKTVya3J1BbAEOV8Btj+HgSH3R8HWpfu8g==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:2cb4:ec7b:cfc0:caf7])
 (user=prohr job=sendgmr) by 2002:a25:9881:0:b0:d9b:341a:ba5d with SMTP id
 l1-20020a259881000000b00d9b341aba5dmr63666ybo.13.1697232083526; Fri, 13 Oct
 2023 14:21:23 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:21:14 -0700
In-Reply-To: <20231013212114.3445624-1-prohr@google.com>
Mime-Version: 1.0
References: <20231013212114.3445624-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013212114.3445624-4-prohr@google.com>
Subject: [PATCH v2 3/3] net: release reference to inet6_dev pointer
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
index b11ada7ccc6e..441f60170c85 100644
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

