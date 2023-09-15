Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852397A24F3
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjIORgl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbjIORg2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 13:36:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08572D79
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 10:34:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b59e1ac70so31984717b3.1
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799275; x=1695404075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8CEOaleRfmVWxu+aHRyiNpWZbJifyuSx+uIjLiDWCm0=;
        b=nPF2LtGZqBGsepshfqQ06vgVug/Orws9Xw6tEl7DC4ka7trRIDOgrtP80M2P6ssxgD
         cg+XvCXwaQuvajAKyA5KowA5EYpK9jBrkjYy0oDmpK8ZRTakZD8eppLDlUQEBHt3fYFh
         msJ9oMEIpNzSc+UIm9gYAn8t5hdKMEfuvav2jMGL5DNVusNJqFwPIyoKaNJ8X258hoBR
         dFLIiTzGbHnLazRiIuG1jOqTHvcba97F8lUdWUAy/+qFsCs1xrI7emYvKclCLhs6cSJL
         wnwz76YKUyVuE6di/tZZ9bhiYFYzLgqd373RCdBPa01rbpxzIeZVGfWOGN1Y5QaDpEAM
         /7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799275; x=1695404075;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CEOaleRfmVWxu+aHRyiNpWZbJifyuSx+uIjLiDWCm0=;
        b=dCs2zLTuULbsBiOq4CUbSY81/gY59nFcDhNMjnk4Gp511UBwxqAir2Xo6sLZCA59LH
         i1UAOV4lzwDCWsaHRdtNmFbERvwfxp+/mFkVlgM8iElFGj1CwDq1HF3Pkb5peHHjyuBb
         siS3enPSfZz7u/HlCLKNu5yYe/g1oVLfqdjuKVdzjYMwMynlb1u6/Rm/HDewoaJD7Umr
         6faQQk9dQtAQVAKgkBQ8kp8wMjJf2WPewrYo0RjoQnLnS9qsd2X4FUhem+Fn0pIjo942
         xIQQoIkeLq3AQHUWXD0jY04yMtTcJxoH3xqXte4s6FvGrHDJuvgCQVhqR0rkt3FIaJoc
         FnBw==
X-Gm-Message-State: AOJu0YwwWbGNTJWNSB3/eGVSv9t/071AxJjgtCv7+JzYmezftWi0URGE
        ZABmhv2lg7R9GnDROGsXKSLVGSoUcHCEMa4QriU=
X-Google-Smtp-Source: AGHT+IFBiU/ZCcBisMOL23Ew9xLGlAsZyNiAQBseIuvEQJu6APv2wfjEyjUavA3eiZwGcb97xAwMjmNNJozwXDw6BJo=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:7f04:6b3:b482:dd2c])
 (user=ndesaulniers job=sendgmr) by 2002:a81:ac5f:0:b0:579:f832:74b with SMTP
 id z31-20020a81ac5f000000b00579f832074bmr64518ywj.10.1694799274896; Fri, 15
 Sep 2023 10:34:34 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:34:26 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKKVBGUC/3WNSwrDIBiEryL/uhajaaJZ9R4llMRXBBuDFmkJ3
 r3ivsuZ+WbmhKSj0wkmdELU2SUX9irYBYHclt1q7FTVQAllRHQ3vB7mKYP3jcRs4FwsTHSq76F
 2jqiN+7S9B6DKIpirvbn0DvHbXjJt4Z/BTHGHCR2HkSjGV2XuNgTr9VWGF8yllB/0GbpwsgAAA A==
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694799273; l=772;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=Su0VeWzLLW5m4JW7phmTjSjouMb7pr+oMSGtFqqroBs=; b=scxlJ85JlEGMgwbKW/xcGhuMTeJcbrDquF6+4ucCQh3voJj9Abvx6TkbueYcg7QcRH/LcaNrJ
 mX0JcNwT9T+AW4+NSmsF0uUr7OgKV5U9TpTdeb9hSdnz5v+sgu6TQxI
X-Mailer: b4 0.12.3
Message-ID: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
Subject: [PATCH bpf v3 0/2] link to v1: https://lore.kernel.org/bpf/20230915103228.1196234-1-jolsa@kernel.org/
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v3:
- combine v1 and v2 into a series; I didn't recognize that this macro
  appeared twice in the kernel sources.
- Use __PASTE twice.
- Link to v2: https://lore.kernel.org/r/20230915-bpf_collision-v2-1-027670d38bdf@google.com

---
Jiri Olsa (1):
      bpf: Fix BTF_ID symbol generation collision

Nick Desaulniers (1):
      bpf: Fix BTF_ID symbol generation collision in tools/

 include/linux/btf_ids.h       | 2 +-
 tools/include/linux/btf_ids.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 9fdfb15a3dbf818e06be514f4abbfc071004cbe7
change-id: 20230915-bpf_collision-36889a391d44

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

