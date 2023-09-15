Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6E7A24ED
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjIORgJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 13:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjIORfy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 13:35:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999430D6
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 10:34:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bfccec7f3so22216917b3.2
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799278; x=1695404078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJC1MpNA41XSWsvvv83w1mhfvF8TpSh3HYkxNC3IYos=;
        b=jgFa188BP2SILiAWR0B1X6XsgVn7BslM7Us/SDpdwusZSBp4uy5fa4ZWfRopAT4u0s
         SAbSQVVtOHZAdekCInESBcRinfCezDiagRudwdZzr6sfx2YnmOWO780oo5cNQjItwNZu
         vI4Efah3+uA29/9yQAucvuKOYPKkU23xhlAvyFxhb95D5dFCX0T3WgjKkKM1nJPfWPNu
         fhI/ZZiwKXYkgWbsSwJVaqK4dH61qq8WaGms2VBnhb0soPQeGPeS9xh/Kp4NS+S4kkcm
         DaqUJNBLgEFroMV4tPSOPEH/AUKlk+hQS/pkr2armRbxVfkSpASKcedhRvk1q9J+ZwBI
         atXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799278; x=1695404078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJC1MpNA41XSWsvvv83w1mhfvF8TpSh3HYkxNC3IYos=;
        b=SWb3eNXRpUTY7hxH9VDKL44u9VgDaJJrx4Ql+KK4w+4jBa2JnLhQlsP/PiXyIrP4i3
         SoSBHl/kWlucbBP4Ohu4kK1F/laBKJM8F8m1HMfItDaIZ3jaBq764NBRqqdLE0TvXdT1
         lYO7DmGCyaPHLhZAtsos3OvRA2HvcYoBprggR5ytgPq4Tw6SyDeWzyfTGdLifwYaHyPP
         4AGvYSP5op1jHNbzmEczsKE7lYA7G6TLuXkS0mL20hXdfXQPfFPkyvk+uDubigu1nVnU
         /a6MTaR7Y+krGYkH06ZmUS9lud3AaVUhEh5Y/rWAfmZsOy0Fl/S/omFcsDZvA2Cd5BTv
         vJnw==
X-Gm-Message-State: AOJu0YyYg+j5V5bLebSqsxWKwTu13nWKNmd7RMtHD1bBHR3bBE4GdtJ1
        VU1WIiEmCzMd27192wsNRrrbWYt1n/yVz1Cq9Cw=
X-Google-Smtp-Source: AGHT+IE9UAT+K+q9ytinkFyMWYt0GrL3lw/3Oewo8P4+2sZ76QzEaJefM4cOvauekXpyLQEY5rvHcSIjPxsuBoor+qM=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:7f04:6b3:b482:dd2c])
 (user=ndesaulniers job=sendgmr) by 2002:a81:ac05:0:b0:59b:ea2e:23f0 with SMTP
 id k5-20020a81ac05000000b0059bea2e23f0mr60367ywh.2.1694799278777; Fri, 15 Sep
 2023 10:34:38 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:34:28 -0700
In-Reply-To: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
Mime-Version: 1.0
References: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694799273; l=1657;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=kgMWLZDqu9UqeTMmXyEC7cxyK+tytDiO2sXAmlSWnBI=; b=7Fop81vSJL23p4VMu5VzZxe8rIQuLhkNpBVhUlwKmPRY48Ma16klxeWZnl8lr8TXo/sQ0gPcx
 t/omK9dcidKAX6N/6NMBikRu7Gj1erxfAt6dZLA53bmu2mXDriFKJow
X-Mailer: b4 0.12.3
Message-ID: <20230915-bpf_collision-v3-2-263fc519c21f@google.com>
Subject: [PATCH  bpf  v3 2/2] bpf: Fix BTF_ID symbol generation collision in tools/
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 71e54b1e3796..2f882d5cb30f 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing

-- 
2.42.0.459.ge4e396fd5e-goog

