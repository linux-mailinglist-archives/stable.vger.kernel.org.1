Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE7B7C809F
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJMIsn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 04:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJMIsm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 04:48:42 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0DEB7
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 01:48:40 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7a7e9357eso22405357b3.0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186920; x=1697791720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsV6T9VsLLy2LxDe9+BKDcZ/cAWQqS9gO3NGL22SRNg=;
        b=yrvXwWvRXLZZaIwpwDlFOB3vN2u8Al6KCOzlsryl+mBbXvvr9T+Ny3KQv2WUVui3df
         ePLrrxXGkZiARdM7/cAfdecyPbQFeFSWt3+BAMsS6hIdbLm7bVnLRfiMQTYllRU5g5e9
         TetkJyF89v2KwBimYcZOnMvm5iiU4nvK8X+ZTumT9rEJ1FL2lOfSE1g1ldd54xgoiaxq
         cLj2N654VC/f1e94VXb8JaDW76hs8H1Fm9sF6SjjjTxMgXusPLAP5C7FxVs7xpC4soUO
         qQ4lTS/lY4XshiKvDfxho30xwYYixgv6WhbEgbkjLDsBEQ/lyfQqYni1ZQb7cPM06gmA
         HH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186920; x=1697791720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsV6T9VsLLy2LxDe9+BKDcZ/cAWQqS9gO3NGL22SRNg=;
        b=oc770kE3uqLjcMfOMN9mXhhWSfQbt+rTHgOcFmOWf2iSIDWL4JXHrz5+1Up2bHaY2w
         o1Xzg5fzN6rNWb5V02oEyoLnADfEPTMu43v5zcC3dz2qZLHIiF5VCz/3hOEP59wfp1fH
         swou9/dSGHi2p1dZPoAYLieMsbt6rtK2m6a5IqgxKxOvng1OcFu6qfWMbdHlJkgmz/lJ
         diLJ4gdsDbVwY23ZbaXbm7G7+1QaNLa35QofYXJ7fZBykA/bDFP6ziJWaBUdQdbTPpgA
         T4t23NEiyz1U3l0GAicHvYCXrus10CkNNouY71280r63lEudIO+0Zs98w+x/FZpvQuyr
         RqYw==
X-Gm-Message-State: AOJu0Yx1CXzeqx2/WejWVEZ8vyWNwuMd1Gzr+Xm4qW9rl2C8reXGCMwH
        RUMWvlcwNc2mKEYGPM3EePh/Iio7Urr5F1I0Of4=
X-Google-Smtp-Source: AGHT+IHd4IPsGpH/FrRZ3mxTpnlfstHsQZ2So8luMKNtrkRy6qveX6G4SwPxatusW2RLjfDR3COPKg==
X-Received: by 2002:a25:8702:0:b0:d9b:1483:3de5 with SMTP id a2-20020a258702000000b00d9b14833de5mr849223ybl.3.1697186919931;
        Fri, 13 Oct 2023 01:48:39 -0700 (PDT)
Received: from sumit-X1.. ([223.178.213.105])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b00692b0d413c8sm13122908pfc.197.2023.10.13.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:48:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jarkko@kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.15.y] KEYS: trusted: Remove redundant static calls usage
Date:   Fri, 13 Oct 2023 14:18:25 +0530
Message-Id: <20231013084825.564638-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023101258-map-demanding-68a7@gregkh>
References: <2023101258-map-demanding-68a7@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ Upstream commit 01bbafc63b65689cb179ca537971286bc27f3b74 ]

Static calls invocations aren't well supported from module __init and
__exit functions. Especially the static call from cleanup_trusted() led
to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.

However, the usage of static call invocations for trusted_key_init()
and trusted_key_exit() don't add any value from either a performance or
security perspective. Hence switch to use indirect function calls instead.

Note here that although it will fix the current crash report, ultimately
the static call infrastructure should be fixed to either support its
future usage from module __init and __exit functions or not.

Reported-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t
Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[SG: backport for v5.15 stable]
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 security/keys/trusted-keys/trusted_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 9b9d3ef79cbe..08da794536fa 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -35,13 +35,12 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #endif
 };
 
-DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
 DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
 DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
 			*trusted_key_sources[0].ops->unseal);
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
 			*trusted_key_sources[0].ops->get_random);
-DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+static void (*trusted_key_exit)(void);
 static unsigned char migratable;
 
 enum {
@@ -322,19 +321,16 @@ static int __init init_trusted(void)
 			    strlen(trusted_key_sources[i].name)))
 			continue;
 
-		static_call_update(trusted_key_init,
-				   trusted_key_sources[i].ops->init);
 		static_call_update(trusted_key_seal,
 				   trusted_key_sources[i].ops->seal);
 		static_call_update(trusted_key_unseal,
 				   trusted_key_sources[i].ops->unseal);
 		static_call_update(trusted_key_get_random,
 				   trusted_key_sources[i].ops->get_random);
-		static_call_update(trusted_key_exit,
-				   trusted_key_sources[i].ops->exit);
+		trusted_key_exit = trusted_key_sources[i].ops->exit;
 		migratable = trusted_key_sources[i].ops->migratable;
 
-		ret = static_call(trusted_key_init)();
+		ret = trusted_key_sources[i].ops->init();
 		if (!ret)
 			break;
 	}
@@ -351,7 +347,8 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call_cond(trusted_key_exit)();
+	if (trusted_key_exit)
+		(*trusted_key_exit)();
 }
 
 late_initcall(init_trusted);
-- 
2.34.1

