Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E27AE090
	for <lists+stable@lfdr.de>; Mon, 25 Sep 2023 23:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIYVLH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 25 Sep 2023 17:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYVLH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 25 Sep 2023 17:11:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8552109
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 14:11:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8040b2ffso55024997b3.3
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695676260; x=1696281060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qADBOd6pnfpqoTGrbUhtJSkTAAgtram3oj8i2hONjF8=;
        b=e1VXQ1mRjK2bxomKznIaR4jz6nw90SRp2N9h5TOllGLFjf7e7eex07s0mwTu+jEkiW
         s7bQK8QDjkzavimwInVcUZpH/EKxj3akO1cKGlkWmCitqHUQD85xmD/M2TDX3JMkxF/S
         hIDj1vPDIw/IHSBVvjFoRcV1pL9eU9nAZGw0VA38j61HgIPCIB8mBtvIFaSOrF/OrIcB
         ReZdr/38lk/pOF7Y3tKK1k8h/mKtU9N0R06q+vt48jifrfFNT+Jpr2mQH86+7wfdJGWI
         tjET66TjgUgsXSEsHpakEyMS2WyGGDgNi8Dq2JgdOV7DQF9KXgX8hpBslub6eFsKOVqW
         aS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695676260; x=1696281060;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qADBOd6pnfpqoTGrbUhtJSkTAAgtram3oj8i2hONjF8=;
        b=uFn53NXjSzxilDzplBzDxmaVndDfWh1i6Tn+gAI53gSQ03RpVtc4bEmuGOryalJ3rC
         pVzc2dSDZMEA5wLRzepr1KbM0gO4qUDoqR4nFfB1f1h16rcbZvcrZTa06RZ/dhC/jF8H
         mZsajHOn3vYqTpXTehw1LXCCUihdK8FpoUfT02Rm7HFzEtn5G+kir3fgaNfV3Uoz5LEy
         wk3n+XmLEg2GOxVURWOun7331YWlGgzPRSYbyIzQhXpj9rZIJtZCvhZDTU8bqtD7IkFe
         8C8LWjdhdhZLrnuB9bSdbmKQytzoGe1yVnGLAN9/oUPPe90Mlf8VUuI+dtz5pp4S1RzF
         j7qw==
X-Gm-Message-State: AOJu0YzpMI8XZpivfYENmcgDuTBDmnP0czS+DDKCPY6oP/uZEr7xH5yp
        TDXp3ddI1U5aTM907X/kvuAT96UQhllktZtzazQAX9tQJMWlEuQwkdtx5YEHFFgL+5LF2GQnzzw
        /wXhSSqkx+pGKGVnIe0yWCMk/0fkXMbYFGsVVddb3weTMwN8w/WvvlmjNZC4=
X-Google-Smtp-Source: AGHT+IH+XB2pepvwizZKpzjmRhcTFeZj6aFGCsERUEGf5RrpK61ScseYjJ9DJqmSiK3jp8AP2XShEZgXYg==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:146d:2aa0:7ed1:bbb8])
 (user=prohr job=sendgmr) by 2002:a81:760c:0:b0:59e:fb27:2a93 with SMTP id
 r12-20020a81760c000000b0059efb272a93mr88178ywc.2.1695676259924; Mon, 25 Sep
 2023 14:10:59 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:10:31 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925211034.905320-1-prohr@google.com>
Subject: [PATCH 6.1 0/3] net: add sysctl accept_ra_min_lft
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This series adds a new sysctl accept_ra_min_lft which enforces a minimum
lifetime value for individual RA sections; in particular, router
lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
lifetimes are lower than the configured value, the specific RA section
is ignored.

This fixes a potential denial of service attack vector where rogue WiFi
routers (or devices) can send RAs with low lifetimes to actively drain a
mobile device's battery (by preventing sleep).

In addition to this change, Android uses hardware offloads to drop RAs
for a fraction of the minimum of all lifetimes present in the RA (some
networks have very frequent RAs (5s) with high lifetimes (2h)). Despite
this, we have encountered networks that set the router lifetime to 30s
which results in very frequent CPU wakeups. Instead of disabling IPv6
(and dropping IPv6 ethertype in the WiFi firmware) entirely on such
networks, misconfigured routers must be ignored while still processing
RAs from other IPv6 routers on the same network (i.e. to support IoT
applications).

Patches:
- 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
- 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
- 5cb249686e67 ("net: release reference to inet6_dev pointer")

Patrick Rohr (3):
  net: add sysctl accept_ra_min_rtr_lft
  net: change accept_ra_min_rtr_lft to affect all RA lifetimes
  net: release reference to inet6_dev pointer

 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/linux/ipv6.h                   |  1 +
 include/uapi/linux/ipv6.h              |  1 +
 net/ipv6/addrconf.c                    | 13 +++++++++++++
 net/ipv6/ndisc.c                       | 13 +++++++++++--
 5 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

