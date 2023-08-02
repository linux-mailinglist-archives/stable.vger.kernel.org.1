Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0D76CC6E
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 14:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjHBMQu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHBMQt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 08:16:49 -0400
Received: from mail-lf1-x161.google.com (mail-lf1-x161.google.com [IPv6:2a00:1450:4864:20::161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA05139
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 05:16:48 -0700 (PDT)
Received: by mail-lf1-x161.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so3018955e87.3
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1690978606; x=1691583406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vI0xScBewLpP69CRTitC0lTT7+EQ4m3F00K4EPi3Rvc=;
        b=Mbafs0baJURckkIHcwi0pOJ6UDeZzv5ZovlhZi8oTGUC/gXOxjLjfvTKqkXCbyMwZ2
         nyWkDOXap24VDElJYdG7iUDsu5/SOsjsisMDT0uw2jO2uabGEd1E85G2cmEEXTH0mKDG
         vuTSVqVwWTHZx7Z2b33jurtmq+2pFhvrRUkrBmx7pHsFWCCIoRdsrNhA/uSe5VhyoYJ5
         1I8gO8XHCXjtCTegTEc+2IRSleM4wTcs+nYFTXMIzd4Jah3zhK61ruCvm2gWUJPXNQYg
         p32aOmxkC7V1lMgxcbub+WERhjxwBB30A9Rgmn9i60a4ZjC2AXpchC0GKqaxYoumYjRr
         wQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978606; x=1691583406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI0xScBewLpP69CRTitC0lTT7+EQ4m3F00K4EPi3Rvc=;
        b=V4gQc+DEcE1PfrruxIk8G8w9pEVbbcpMGdZFhZirfCzlWPK77OU8+bUHMn3LUdD51w
         OWSGl7HOEC9s24WiF5llX1UveC27swM675QOS0wn3Zq9CywnHYG0xQhhd+v5ZzgucH2M
         +2qqdTlAo8OXVWnNhdE5+LCTefQ3QyF4c9kyXh4AoIk8Iws4kE/dRrf4Ouc1ZML+AltJ
         hnK+cbPlTI4quKU4mygsHtEhXRtkh/Ee/v5mG0l7zspFMljtroYSANEuSCrKmNLw9A5L
         SVmebbjcX1wzUBhCiT5U24FVTIKNMZDyuHqAlMCbSQR4kj43xFhlCkG2TvHW/FdnmhS4
         ffEA==
X-Gm-Message-State: ABy/qLYaN0Ozsap08tvnO+h2WWpfLq/lkXQ2SGT+Fh51PH5yhq7CfJu5
        XwVgyFhCAW81R48DXGSqW+pb1XpynkqbRxs6jhvt/VNKdfjvyQ==
X-Google-Smtp-Source: APBJJlE48gCCETGUTzl7w+GwHpvtWhiyjXW+/IDQTPtJtflWvIY+F//loA9GYiYXlZQ2AkOWG4isovje9bGf
X-Received: by 2002:ac2:58c9:0:b0:4f5:a181:97b8 with SMTP id u9-20020ac258c9000000b004f5a18197b8mr3787757lfo.25.1690978606213;
        Wed, 02 Aug 2023 05:16:46 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a26-20020a17090640da00b00993ad4112f7sm1949585ejk.260.2023.08.02.05.16.46;
        Wed, 02 Aug 2023 05:16:46 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
        by smtpservice.6wind.com (Postfix) with ESMTPS id D8FFE60036;
        Wed,  2 Aug 2023 14:16:45 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
        (envelope-from <nicolas.dichtel@6wind.com>)
        id 1qRAmT-00Cgt0-In; Wed, 02 Aug 2023 14:16:45 +0200
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
        stable@vger.kernel.org
Subject: [PATCH net] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Date:   Wed,  2 Aug 2023 14:16:14 +0200
Message-Id: <20230802121614.3024701-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---
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

