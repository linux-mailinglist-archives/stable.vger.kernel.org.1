Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B368771DF0
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjHGKZk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 06:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjHGKZj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 06:25:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEED10F6
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 03:25:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f254c41aso52073327b3.1
        for <stable@vger.kernel.org>; Mon, 07 Aug 2023 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691403937; x=1692008737;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2aUKpQwJlHBI/B+2GbtIOlPh3mE3Zvb3L0td+ezE/jI=;
        b=7E/NkiULl2M9cdqts9VO0MSxJxbVHEHGurbi0jgvhMeGimmxGgM31Trmm7/Ctyw2qz
         zE7g+nTkHNHTadi35xGUawIfJe5q2mopjl4cxWLWPCOqxr8SgKgMlKYHeFJqM58YNMJn
         /DNi8RC8XznZbAWw2kJuXdC6dd4fn7Tsrq4psW9I9HNFAeY7QASLb/CaN6/UDGVkcH2t
         TqoK5mVQibv7JOkUDYavFugC4pkQhh4Jp40dxkdr7n4nr9l/liqs4jnj0JQMZm881nTj
         ZqANgzgd6sgCQSMpCIWrGzLemywGYMeMPo7/voT306ax/7c0npWW6njPmoj8RYZ4cjRe
         rYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691403937; x=1692008737;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aUKpQwJlHBI/B+2GbtIOlPh3mE3Zvb3L0td+ezE/jI=;
        b=ESsxrmF1sMpJ4UI45F5TZ8vxByx2tim87mMHaPOghEn37BvU4kxX9gFXeLphP4nck5
         yHqmkYTDlBvtrxZaHVHyZXpkW92CZr7psLj0UN3rjCLx3mpnhuvJI9DExThM61Z7i3hE
         31uE5UBW5HsVXh/E2NKNfllIh9di17g5mUJqZz5sY8bww2D5ZYTeT5b0czf2bar7mmPh
         eptGjkcK6OWtmbI7nAbPNWVIkNXMVBQ/Zulu1LXfo1Iwai3o2wDJYcLqfyKlStw/d8NZ
         lScDzgya7i7ogs8sK8jdcJ4SwfL9oNZLkKDoWGpa/B3FivZzv0ZGkBpDKdgQZLBtm8jt
         tO6A==
X-Gm-Message-State: AOJu0YwI3Atmre5oBeqfwZTXWHTOxyAjvNT9swXcV3LBQY1BYpY7Aruq
        pv02al9vp/LqTW524+BujqI4/Xh7
X-Google-Smtp-Source: AGHT+IGGLdFXemELYIzvqJ5Mv44a7zYa4WvyXVxK9VeqHYvA+/dL0sWoulXMRVWNeb8CH4lDtKL9kmlJ
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:a6d2:3629:c0bf:7b42])
 (user=maze job=sendgmr) by 2002:a81:af20:0:b0:583:529d:1b9d with SMTP id
 n32-20020a81af20000000b00583529d1b9dmr61419ywh.5.1691403937532; Mon, 07 Aug
 2023 03:25:37 -0700 (PDT)
Date:   Mon,  7 Aug 2023 03:25:32 -0700
Message-Id: <20230807102533.1147559-1-maze@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH net] ipv6: adjust ndisc_is_useropt() to also return true for PIO
From:   "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To:     "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc:     Linux Network Development Mailing List <netdev@vger.kernel.org>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Jen Linkova <furry@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "=?UTF-8?q?YOSHIFUJI=20Hideaki=20/=20=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?=" 
        <yoshfuji@linux-ipv6.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The upcoming (and nearly finalized):
  https://datatracker.ietf.org/doc/draft-collink-6man-pio-pflag/
will update the IPv6 RA to include a new flag in the PIO field,
which will serve as a hint to perform DHCPv6-PD.

As we don't want DHCPv6 related logic inside the kernel, this piece of
information needs to be exposed to userspace.  The simplest option is to
simply expose the entire PIO through the already existing mechanism.

Even without this new flag, the already existing PIO R (router address)
flag (from RFC6275) cannot AFAICT be handled entirely in kernel,
and provides useful information that should be exposed to userspace
(the router's global address, for use by Mobile IPv6).

Also cc'ing stable@ for inclusion in LTS, as while technically this is
not quite a bugfix, and instead more of a feature, it is absolutely
trivial and the alternative is manually cherrypicking into all Android
Common Kernel trees - and I know Greg will ask for it to be sent in via
LTS instead...

Cc: Jen Linkova <furry@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E <yoshfuji@linu=
x-ipv6.org>
Cc: stable@vger.kernel.org
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/ipv6/ndisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 18634ebd20a4..a42be96ae209 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -197,7 +197,8 @@ static struct nd_opt_hdr *ndisc_next_option(struct nd_o=
pt_hdr *cur,
 static inline int ndisc_is_useropt(const struct net_device *dev,
 				   struct nd_opt_hdr *opt)
 {
-	return opt->nd_opt_type =3D=3D ND_OPT_RDNSS ||
+	return opt->nd_opt_type =3D=3D ND_OPT_PREFIX_INFO ||
+		opt->nd_opt_type =3D=3D ND_OPT_RDNSS ||
 		opt->nd_opt_type =3D=3D ND_OPT_DNSSL ||
 		opt->nd_opt_type =3D=3D ND_OPT_CAPTIVE_PORTAL ||
 		opt->nd_opt_type =3D=3D ND_OPT_PREF64 ||
--=20
2.41.0.640.ga95def55d0-goog

