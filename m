Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC07A23BA
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjIOQme (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjIOQmc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 12:42:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265EF199
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 09:42:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81503de9c9so2784507276.3
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694796145; x=1695400945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5w8nYSzkVPx0Y4u1Ts0WLw0xCMJcfflotrabEjHQ33Q=;
        b=ApwWh6n0wxiKSuI9gEA0fx0wrklh1S2ew7sCqhPf6FbE9afejpIXqjisiF7zu5r11D
         ZUAykGC9rMwJ8Y8fr+ylxXv+PG8lgScEAIWNXH3TKVhNOk4EUUFUg39RSMJnJV2o7iyg
         H4LD3sIKrnOkeSHF6O2A4BVz6APzAxC/tCx1Ub20h2Emh2fxRd8nddncuf5O7zydF2+6
         6eQiGLWqAfizCCpCzSUjqhWPmhjOhoOeZutKRwpgSEpa+TlQrZCXC/W+bgji+SfjYeys
         sBiTbfBntmTxUGLD3iigbvmEJV7Vt2wxwmP4ksJQP7yHOCLVpa0/nY8c+B8Ipst1WgfH
         bgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796145; x=1695400945;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5w8nYSzkVPx0Y4u1Ts0WLw0xCMJcfflotrabEjHQ33Q=;
        b=DYcPVtvKAeGkt64VVGrWlNYHxJwTMX6kdqmc51yf+GBOpjIV6UvTjeZWOHR04fxzM5
         3e/YnuzEyW3GuVReCA0yVY5Kg0Wosmk6xfDk3Sfnb+xejJfWRcW/vNRhZEdZr31f2mWp
         dQPYXZF+L0kmfN/2wdTeKHnqgpMMEeILrZxv1HDWR7eSomqdy7UxcrqyFuwW1lqGC4RC
         9YOwCFn5f15Sgh7ZLJy2IS56NIEN7iKcmjVD/yXP9u12oM6PGLw/ouKkiZbO6S8oJxUT
         1K5gp8AbXhfCkcJ2+o1bp0v0MdJotZqp3evbClDrC+HDmR2O38j+MhvRpEQgCAKYkJWC
         1MXg==
X-Gm-Message-State: AOJu0Yx0fmm2gDTW9CU74xixO8V/b2QC8i/SQqpii+57njkID6OkUGvO
        uJnKsyy5DBfNJRU75Q04WxofoJSvTXmAJ8nKFic=
X-Google-Smtp-Source: AGHT+IGST3z+4KkcZ6kz4kNyjk4QqtRxcLbAmEGaWSms7bQf894dFDpTB9oaFPiSxyc4T6mpJxzaP3F9DPY4Ro3m/Hs=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:22ea:f17b:9811:4611])
 (user=ndesaulniers job=sendgmr) by 2002:a25:fc01:0:b0:d10:5b67:843c with SMTP
 id v1-20020a25fc01000000b00d105b67843cmr50528ybd.4.1694796145127; Fri, 15 Sep
 2023 09:42:25 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:42:20 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGuJBGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI2MDS0NT3aSCtPjk/JwcsEpdYzMLC8tEY0vDFBMTJaCegqLUtMwKsHnRsbW 1AKn00e1fAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694796143; l=1838;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=xGla73CQna/Fo/W2LSdP2nzHHuTYVpRoroUyiOyj28c=; b=PXHwW1V09cFms7V2IdxFS5Lhjdgg3ChUMjyCNuo5CFmdvRYm+zJ/C9YtGZKTavJ+GvRYufx1c
 3hWeTQ77CCGBtgQPO5uvlTnSX1I/sGSpJSC8fEX0g1G09/3VdFv6clr
X-Mailer: b4 0.12.3
Message-ID: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
Subject: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, stable@vger.kernel.org,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Marcus and Satya reported an issue where BTF_ID macro generates same
symbol in separate objects and that breaks final vmlinux link.

  ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
  '__BTF_ID__struct__cgroup__624' is already defined

This can be triggered under specific configs when __COUNTER__ happens to
be the same for the same symbol in two different translation units,
which is already quite unlikely to happen.

Add __LINE__ number suffix to make BTF_ID symbol more unique, which is
not a complete fix, but it would help for now and meanwhile we can work
on better solution as suggested by Andrii.

Cc: stable@vger.kernel.org
Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 71e54b1e3796..30e920b96a18 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(prefix, __COUNTER__ __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing

---
base-commit: 9fdfb15a3dbf818e06be514f4abbfc071004cbe7
change-id: 20230915-bpf_collision-36889a391d44

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

