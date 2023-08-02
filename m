Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A776CC7E
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjHBMVM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 08:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjHBMVL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 08:21:11 -0400
Received: from mail-ej1-x664.google.com (mail-ej1-x664.google.com [IPv6:2a00:1450:4864:20::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5094626AF
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 05:21:10 -0700 (PDT)
Received: by mail-ej1-x664.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so704726466b.2
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1690978869; x=1691583669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrNzIICG8qTOKNKwTpWMsAjtR+/c8US07CWmXigNAyM=;
        b=fHYXNcVOhdR/7FH6J7G0r2LQcNAp1FVyB9XdgBRE+iEeavQVvMNf4ffpzYPDkORFXi
         IXJC7gn50gp/rymY/8kGGRU1gHLfz5sxdXtkt/RxYlGlqrAYZMWqwE7UpGsLoGAYmtaB
         itSF7NXItQLdSJgqFAjkhS4SrEdzuNrQ660+9eddLza9rCr1RpmFyzmeO2bkro31ckk1
         0of8IyNbY61B8bge1cwM9mLiaedKNp24IBa/Wha5OvcVr8StfH5S0MqDsXdhQxzo00dM
         KWXLIuUi6jbqiGqjX0+E2jjcER/FzhnohaUEfe/4lrxxz/RuUquElWP9rxSH5aTn5Zk4
         iIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978869; x=1691583669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrNzIICG8qTOKNKwTpWMsAjtR+/c8US07CWmXigNAyM=;
        b=IDyDA/ANOnaGGRROJb6Fte/4FeojbyjF3GwMSEr/ScpdELsw9RKin3ef7qixAit6pT
         V1z53Pwlp8gMHzJ1UIvtzOIupAsOjg3vOdjDjRsd/Ikx8QDEsPKJzInM/dnxh0vYEZwN
         ZglXmaDvANSpUGfnoLSFcPd3nF95gu6W0Yio4hrXw4UCo/g8avAsAUaqnII9OYqulsQl
         cFzxD6Ws0jhJiKiXOcYGNKmf+rsIXYNZ0bjOzAFATx/SNopfC8pWG/kzHTNxry+cZrRp
         02x0xSneqyI/+5gauQacl8hoSJ6hy88dO1pdFJdkg5IRQADjcLP49ZZA6A7qOU/bSnNU
         QPXQ==
X-Gm-Message-State: ABy/qLb83GvWpALeqSh/XHYwOfSh0HuRwaSjxYnXGGi/bs3gL1gXgvys
        7712fgeZg5EbRJL2ZtnG6hGaEStlUXLVe346BN/DTE+VxxEZhQ==
X-Google-Smtp-Source: APBJJlGIEIkB2PhuqBTTOaBiGs4N6Ks58Bs+FekI9vndNgxTSInymxMmFj3f8DEQHlL+4uCiZQRTjtAGCM1w
X-Received: by 2002:a17:907:7633:b0:99b:c949:5ef8 with SMTP id jy19-20020a170907763300b0099bc9495ef8mr4869671ejc.54.1690978868758;
        Wed, 02 Aug 2023 05:21:08 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id v17-20020a17090690d100b0099bcaf23d2csm1931414ejw.25.2023.08.02.05.21.08;
        Wed, 02 Aug 2023 05:21:08 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
        by smtpservice.6wind.com (Postfix) with ESMTPS id 6D930602BB;
        Wed,  2 Aug 2023 14:21:08 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
        (envelope-from <nicolas.dichtel@6wind.com>)
        id 1qRAqi-00Ch1d-4i; Wed, 02 Aug 2023 14:21:08 +0200
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        stable@vger.kernel.org, Siwar Zitouni <siwar.zitouni@6wind.com>
Subject: [PATCH net v2] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Date:   Wed,  2 Aug 2023 14:21:06 +0200
Message-Id: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This kind of interface doesn't have a mac header. This patch fixes
bpf_redirect() to a ppp interface.

CC: stable@vger.kernel.org
Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
---

v1 -> v2:
 - I forgot the 'Tested-by' tag in the v1 :/

 include/linux/if_arp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index 1ed52441972f..8efbe29a6f0c 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -53,6 +53,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_NONE:
 	case ARPHRD_RAWIP:
 	case ARPHRD_PIMREG:
+	case ARPHRD_PPP:
 		return false;
 	default:
 		return true;
-- 
2.39.2

