Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31C878599E
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 15:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjHWNlO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjHWNlO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 09:41:14 -0400
Received: from mail-lf1-x161.google.com (mail-lf1-x161.google.com [IPv6:2a00:1450:4864:20::161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E4184
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 06:41:12 -0700 (PDT)
Received: by mail-lf1-x161.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso8616290e87.1
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1692798070; x=1693402870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2qu37sZVV1qRApBkDfrlWEG8W4ZixQal+A4N9ZAaww=;
        b=OJktVX1N0oNMhQ/ZLzO+4oeImrmWPHTrJe/BZpVQld9t8E27vOW6EOZBgVROhc9KD0
         dFOLnNJ8WEHPGFP0AAlAso0js98m0zlO7TMArTVDdPN02++sgyC2V1DTDJDJsao9VPWO
         ILD6O3S73Xb1UDGtmMQlaqtg1ZAtbQ1XBmRuJLaRckZdR3gjIRiv8Xd88fH5tSiLjEQl
         nIHddnRViPFEyYXeidWtweBwFzBp/BzrtFNXVQTbPc/h06BYdk9MRcYmSX0nRqgPgWYY
         oUgvOQZm7uglcXIQPdaFqftsKO6y3BO9UcNL7AGj71YVTMRpV058VgvLTITt2Pl+xWpz
         3Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798070; x=1693402870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2qu37sZVV1qRApBkDfrlWEG8W4ZixQal+A4N9ZAaww=;
        b=G4QQBD1hR1Lt9Yh6mZycW92XTQstuOj7oRjlaTIJBN5oYl94m41ufMprzhFUMbyU6j
         pDqbl48d1jiuvtJUjWQbP9PMayCv2yh32fht9+6yB/0hpP/0XwGIaJx78I6ntBD6kvgi
         cm3gTt71ZEmAhgfaTlL3QwTjas+Tyo6hW4bj8BaK6GQlD92Bg9RRptJYbFlXbYb8JYoC
         OO3s5M7LKm552wOZWwT6rs41YauOneqSkYUrU4qymznmpE7xuq11uV5SIdGGOHpmgGL2
         CznKU4zTj3jsAt4FJxUQu2S5ZJi0LPcgepYHRG0xmiDhh4aHknF6318+q/tTM2zgHtrf
         vLKg==
X-Gm-Message-State: AOJu0Yyvp6IFLTQ5TY1X3rQG7aPfyhKutcF0RPtaw86G00HF9p0Ao7K9
        bRGelLeD8TX+bX0GqQ5rMEfkBGnk2NRwfoV4KgB+/ELGBASczg==
X-Google-Smtp-Source: AGHT+IHTRzq3nD+UFN66SZKVHA/+L3Kt7Y4TDcJr59sF1OKTOsRZ//DdVeIV/o6gPP9bjinNxq6o2VslC+wK
X-Received: by 2002:a05:6512:3b5:b0:4f8:70b8:12b1 with SMTP id v21-20020a05651203b500b004f870b812b1mr8292633lfp.4.1692798070204;
        Wed, 23 Aug 2023 06:41:10 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id b25-20020ac25e99000000b004fe1d8a43edsm314016lfq.89.2023.08.23.06.41.09;
        Wed, 23 Aug 2023 06:41:10 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
        by smtpservice.6wind.com (Postfix) with ESMTPS id 86CAF60101;
        Wed, 23 Aug 2023 15:41:09 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
        (envelope-from <nicolas.dichtel@6wind.com>)
        id 1qYo6f-007l01-7A; Wed, 23 Aug 2023 15:41:09 +0200
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Guillaume Nault <gnault@redhat.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        stable@vger.kernel.org, Siwar Zitouni <siwar.zitouni@6wind.com>
Subject: [PATCH net v3] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Date:   Wed, 23 Aug 2023 15:41:02 +0200
Message-Id: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The goal is to support a bpf_redirect() from an ethernet device (ingress)
to a ppp device (egress).
The l2 header is added automatically by the ppp driver, thus the ethernet
header should be removed.

CC: stable@vger.kernel.org
Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
---

v2 -> v3:
 - add a comment in the code
 - rework the commit log

v1 -> v2:
 - I forgot the 'Tested-by' tag in the v1 :/

 include/linux/if_arp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index 1ed52441972f..10a1e81434cb 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -53,6 +53,10 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_NONE:
 	case ARPHRD_RAWIP:
 	case ARPHRD_PIMREG:
+	/* PPP adds its l2 header automatically in ppp_start_xmit().
+	 * This makes it look like an l3 device to __bpf_redirect() and tcf_mirred_init().
+	 */
+	case ARPHRD_PPP:
 		return false;
 	default:
 		return true;
-- 
2.39.2

