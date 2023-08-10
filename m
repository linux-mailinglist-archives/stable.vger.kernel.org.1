Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16737779D2
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjHJNqL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 09:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjHJNqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 09:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62A211D
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691675127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KxTwz+6ZcTxt+XhK9N8w80lzlwZQUtkNe31IWFhwktk=;
        b=BQ5l3WsL9Qs7Y++SZZjTDHhCGjAXO9TozYo+SRbaZZfVbZgnrTQvDPqCQslB2ekEYy9ktF
        ifhrkAnni7U4bmjyfuYmEvRDvdZFObuVNIxw1hnixBy8Fg0Sp0FdUjBWrlf5DDRxL4YdSu
        7nioq5r2OVQqSEaMrG+rUph6eN9nRQA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-HWGmbCuHPHS_tWWISEYnhA-1; Thu, 10 Aug 2023 09:45:26 -0400
X-MC-Unique: HWGmbCuHPHS_tWWISEYnhA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3175b757bbfso580650f8f.2
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 06:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691675124; x=1692279924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxTwz+6ZcTxt+XhK9N8w80lzlwZQUtkNe31IWFhwktk=;
        b=fgeJ32zBwz8CVCXZZJSiy4WwTNFqgk4lYtyXtvXmqhKi/fH4qpAKrD8yRAOy1uoJcV
         6Fl7LGvfrcRkZHwcZ5V8KHANWCRa22azIVxWjrQVSdMLCUBo5i0fYKFCMKu288e4hSZh
         ZVPA0gsfUzLV/Nufd5JpWaUN75Ia2foSUXwkPGr50PyK0uPSGripUbcyG+cwCjpmDcIk
         uP0PTxKdcu6G025E+MYeb710J9CJP4ba90kjRmGH9WcrwXisjhINl7SoifYsVO14RrhB
         452wzuBvB9lvuqnoGTcMNoIWKS+KNvAELXDra1WxLMwg2lD8MhgW9RY6p1DB/sr7c3zs
         ZnnQ==
X-Gm-Message-State: AOJu0YzJUHJnl/ARYqka2bcUGlagaS/SVID3cdfSS/w+js/F6OcPIdKK
        aWcxp2j+GRuU9ZtlZ1dO1quA2qld0cKCknEPxdIK6r7BBcetUlMx3LJpuS7Ff4IV6UBxmh4I4cq
        t1gQdKSXzAPyXiNjyhoA0OyYPB+n965hKT6lfg+V00RfHbi6Feywtv4TB1RnYtRCo3QdDVp8Og4
        2s
X-Received: by 2002:a5d:624b:0:b0:318:15ba:4a0e with SMTP id m11-20020a5d624b000000b0031815ba4a0emr1312123wrv.48.1691675124597;
        Thu, 10 Aug 2023 06:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Zn2b8BAmbPe8AE2jrOq0epA2OD/jO9zEh2VJEAmRyK5ZF2QLW4RCXPla9/brDi+ICqX9+Q==
X-Received: by 2002:a5d:624b:0:b0:318:15ba:4a0e with SMTP id m11-20020a5d624b000000b0031815ba4a0emr1312110wrv.48.1691675124205;
        Thu, 10 Aug 2023 06:45:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d6283000000b00317643a93f4sm2214686wru.96.2023.08.10.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:45:23 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests/rseq: Fix build with undefined __weak
Date:   Thu, 10 Aug 2023 15:45:22 +0200
Message-ID: <20230810134522.980226-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ upstream commit d5ad9aae13dcced333c1a7816ff0a4fbbb052466 ]

Commit 3bcbc20942db ("selftests/rseq: Play nice with binaries statically
linked against glibc 2.35+") which is now in Linus' tree introduced uses
of __weak but did nothing to ensure that a definition is provided for it
resulting in build failures for the rseq tests:

rseq.c:41:1: error: unknown type name '__weak'
__weak ptrdiff_t __rseq_offset;
^
rseq.c:41:17: error: expected ';' after top level declarator
__weak ptrdiff_t __rseq_offset;
                ^
                ;
rseq.c:42:1: error: unknown type name '__weak'
__weak unsigned int __rseq_size;
^
rseq.c:43:1: error: unknown type name '__weak'
__weak unsigned int __rseq_flags;

Fix this by using the definition from tools/include compiler.h.

Fixes: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")
Signed-off-by: Mark Brown <broonie@kernel.org>
Message-Id: <20230804-kselftest-rseq-build-v1-1-015830b66aa9@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/rseq/Makefile | 4 +++-
 tools/testing/selftests/rseq/rseq.c   | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index b357ba24af06..7a957c7d459a 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -4,8 +4,10 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS += -no-integrated-as
 endif
 
+top_srcdir = ../../../..
+
 CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
-	  $(CLANG_FLAGS)
+	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
 LDLIBS += -lpthread -ldl
 
 # Own dependencies because we only want to build against 1st prerequisite, but
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index a723da253244..96e812bdf8a4 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -31,6 +31,8 @@
 #include <sys/auxv.h>
 #include <linux/auxvec.h>
 
+#include <linux/compiler.h>
+
 #include "../kselftest.h"
 #include "rseq.h"
 
-- 
2.41.0

