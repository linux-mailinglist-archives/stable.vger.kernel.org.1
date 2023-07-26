Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA3A763D05
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGZQ4F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGZQ4E (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 12:56:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95BF2122
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 09:56:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso71469895e9.0
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690390561; x=1690995361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvAjR0RXHM04KUJ6xxCJ44wdutKfbrznolrywQynBpo=;
        b=gPwP9cYRLI0/1gC41/q0Jr1CR+IIW/JfihuYlKTz6f1PIWZsBE4GWpAfaLaFhEyytR
         CYpCDGHk9Ii3BArGl1u6QVhv99WT29cLgu4WFyRo00fiyjblJ2o8ZmEZw+fEZFXAX2qH
         YNxbvjaDKjv2Nr6vLfYvMMFHWM1ajt7DKwKgY8OkzErEGYQGvKbUaQ/1ghfx0ImKEt42
         mhBQcoVIx8y6MWA1uKvlnJzHMr1CItEY6WyuyjvcZlEpu2mePaEy+iKsPcpYWx8IkHg0
         ae+ZdG4YbafgUyI3eUWg1N7kBW+JsIaCSsmHxglrEpjhQw10RPTfFREtqMaySoEc437B
         8EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690390561; x=1690995361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvAjR0RXHM04KUJ6xxCJ44wdutKfbrznolrywQynBpo=;
        b=iIF44k6MOw7ym8flhMoPcXlwd8SmVMHOBcSpUxNdTkLtOalmMzpKl4G8VcJ8q4ug3s
         IcGUB8n2ElrppqUeU87btGFfXw5HGwubhOCxHw3oef/1EZ/V4EvOrxPyrfYSmKOnzsXe
         ux3ZfwJifLYclLH/J/lKmimjZQAn1Mw5+bN/LGrXTFieFg5KeLArJsvkOCZvKNjO6L8T
         XRuBWMKH7MScmBJhQoC7JQN2gpLz5cqXSALsHjmxMnFYUPZN16H3Y5UdrYY6FETPWhaT
         4g5n4rxc9ZS84HcwqAHhQIDg/YcCVF8pXsAvLq1z1ZKoQzAXlZCxFeunDhF+sn9VPxzb
         DKnw==
X-Gm-Message-State: ABy/qLajd1Lk7o8yrfW85Xk1sDNfXlIZrtlISgCWMBcD856hc/Dji1Cg
        r4ceZTM5IICfmrhM74uM7Si52eBbV+hamwd73XsQRw==
X-Google-Smtp-Source: APBJJlFZaWVgnC5lijJh7fd8a8IJb7AppjBkSzd3XWZpfjlQoT2ThDwfuz0ZndSG10EC2aQOL/dPxg==
X-Received: by 2002:a7b:cb85:0:b0:3fb:a100:2581 with SMTP id m5-20020a7bcb85000000b003fba1002581mr1972489wmi.14.1690390561164;
        Wed, 26 Jul 2023 09:56:01 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id v4-20020adff684000000b0031431fb40fasm20339564wrp.89.2023.07.26.09.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:56:00 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.10.y] selftests: mptcp: depend on SYN_COOKIES
Date:   Wed, 26 Jul 2023 18:55:47 +0200
Message-Id: <20230726165547.1843478-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023072148-curry-reboot-ef1c@gregkh>
References: <2023072148-curry-reboot-ef1c@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=2V6BadWEVF2toXt/TZLyy8JYT+hyGsJg+tcwRdua7i4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkwVATFMr+9A3nqTxhAuKGCWRGG0ZnyIEQjiCvN
 Ao3n4/D6d+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMFQEwAKCRD2t4JPQmmg
 c1hsD/94P9qqvMpmGPeiqNVlr17wEufbCbmnR4TeyI+oH9A5ov+f9jhVA92IRu/tM+3wqfHPJi7
 qOXk2w/dvOkpimz0hXTIQb+k3IsdllPwlMxP7Uilayq3C1oP2sVqvmbrSwaQ97ZthAWrLv70+r2
 IaWE9/ey+KXKn3uvOwk8eqY6hzpr7556QyTWk5TqMs9nziWXVGuVHxyooBKrKIhZyBzNdgqq16Q
 n6oSQN4ceXA6PINVbtBSoLmbsNwe4Qbz7aPJfjkh90WCFXUs3N8iJaU+hJE87j7H8VyOkzDJ3yK
 KameI0FWPnquFhw89e20+sLOP6HAuURDfJuVKab1V2rZ0raZNeKPCZwiQsULQgiODUk2Sz95EIv
 m0Dk0MNOaJHw+v600dF2m+/+1ev1NhSYkKbYD7e2Hdzp+L3xxJpyvmkfB2d0eqGTRPsCyGuGVsB
 u7QBzrTpTP7iOd9jXZhqm7HDCLkDZSKWel1MbrmlmfmZ/+jHvBG6yD4ytVhdwZprX91iXkOOhV5
 3eKBiGTGlFEp0Wc9xiNsxIS1N+/Iup+SLYVKH+9mKHZosHP5B5Awh2DnPYG3s4lynNE4bJ5BKD0
 ErTddcGkuqK2BmZ+AHViYdAR17YTHXpLDlP7IQ2msa92SwNil+pwEvp0Zhu5oPYGfmLATgQj1z2 7+zq4u/Ah7lb70Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 6c8880fcaa5c45355179b759c1d11737775e31fc upstream.

MPTCP selftests are using TCP SYN Cookies for quite a while now, since
v5.9.

Some CIs don't have this config option enabled and this is causing
issues in the tests:

  # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     (duration   167ms) sysctl: cannot stat /proc/sys/net/ipv4/tcp_syncookies: No such file or directory
  # [ OK ]./mptcp_connect.sh: line 554: [: -eq: unary operator expected

There is no impact in the results but the test is not doing what it is
supposed to do.

Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Backport notes:
  - We don't have kconfig that have been added later, that's normal.
  - Only added the new kconfig dep then.
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 1a4c11a444d9..8867c40258b5 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -6,3 +6,4 @@ CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_VETH=y
 CONFIG_NET_SCH_NETEM=m
+CONFIG_SYN_COOKIES=y
-- 
2.40.1

