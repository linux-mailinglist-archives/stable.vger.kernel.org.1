Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F2972620C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjFGOB6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjFGOB5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 10:01:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F561707
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 07:01:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so4476790f8f.1
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686146514; x=1688738514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ztKSsDHg9eNLN9LTe0oc60tN/3daRtMs8PauC+08n8=;
        b=1vvzGKaRgY2W7NkFOjDoEpCNFqo77TDs/Gm9fLg6/iq2tjvP4SfSXhcEssseK99T+z
         CB19VRDF+53j2MoRfvqxFmVfwGmCTV9Mw+oAQuX0PMv83glJxLiW/JwPC155YnpiEQJj
         BqU0cWn9yxauiZNA0vfxZPHgV8BH5u9/8TTdwGIkVqNk/biNiFJERTk5j9HG4vOljpFR
         j3C+l4kxPJMf40AKBjwPbCCy+qPsVEpxHssmBSnaBsQ4kghQ9DSd8Uo9NztLZ8qw69c1
         N7X+k0Kuag1yRtzwRsGxBoVNMGDr1LdR+uVx0lSkfbG7kHUmLE5S9st1wdkCdP6uCfl5
         3rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686146514; x=1688738514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ztKSsDHg9eNLN9LTe0oc60tN/3daRtMs8PauC+08n8=;
        b=PHkpNwHcBsLX+Zz40fhpFfU7vddCLd290GaJRtG6Nj0MQyaXrQdnS+f1IWVJB9WoPh
         CCwB/YuhorsGmlXdixUAaTH3XbQ0pHRHB3ksVKGfyJSalSS2maXWS7DNo0TWTdhP/rIt
         8szxw9Dv96L4OJsCo9c2D1Zxwri1UT21ftmQcZBlrxtQcvQs+QNNXt60MfOlqnOrUWU6
         arRZqRBi+xPQxFm4OAsGSSOY5ALb/fYBTnUG2obLgSrTLEpXOLRCK9wESpz22+rvjhrf
         W0m3QLh69SRLJV25m5MHj3wlDtBK3yk765lQWMfcmscHfKObAyYAA/jLcPTqZYVPNduj
         SVCA==
X-Gm-Message-State: AC+VfDxYTkzjLu2Q8O2K8CIF/I1z6T0CKH3UpTO5QQpltij9MnZ5D4cj
        bl8kQ/USfPonW5YBA69IXvLS5lQ9Flb9MZ8fPtCjqQ==
X-Google-Smtp-Source: ACHHUZ4fjsQ6+iyX2OSraZMVPsc6mDQK9vP4mbNqFXb66cwVNGfp062e+8VHyXEEX95MCRQZECdP/w==
X-Received: by 2002:adf:ea10:0:b0:30e:3ec5:aa62 with SMTP id q16-20020adfea10000000b0030e3ec5aa62mr4724189wrm.8.1686146514658;
        Wed, 07 Jun 2023 07:01:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id h9-20020adfe989000000b00307a86a4bcesm15553848wrm.35.2023.06.07.07.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:01:54 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: simult flows: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 16:01:32 +0200
Message-Id: <20230607140132.2632917-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060730-morally-unsigned-2b7b@gregkh>
References: <2023060730-morally-unsigned-2b7b@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=PI/wIR1TzeY3w6OAGoaggRoGIzG54YUwRtqK29lbDhQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgI28K6QD1pNxw28D1ZLFqFkY4otvZHuDeZrRb
 HXylGgubvyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZICNvAAKCRD2t4JPQmmg
 c0B5EACjWnCFYhyz26biI5YW0IaT4aUhOo5Fuq0SDuxckH6tCd8HIcNFNGzUPzRE6NskR58ZfgF
 WUApHlzks23+S1jSlD6YDnchyvrvo8tFKbtx4Q4sUHdtIPxVc6enSnDC7xKV6dZ/PkipH+Tyn2E
 tfwPaG2OI0gcnpaDz5Yucb18G9iVN6B/CTO/y6GZRkWjbR2TIQyVMMYfvNvDnfz7vJ2gSe72GKt
 NsFXNS1xWGPinTJVvhNc9/GzC4Vt5wvd1LnwALNSY4CAJvxI7Bp2v3Pe4JYOjf524mpXjYg0Zle
 uFMVUWmLhDDQS1U1S2n3O+QDsFtZ4TZXtZz7qxOg28aAMO+yYCOUHsGtdG2sCVB0ftmpz5BZ6iG
 vRED46dinN2Hk8Fc8AJhbZSByWfKEkYgcoiADm35V+T5gsyTD47eYHYgG061+U8Sf8Mso0csNb7
 BsQRWQ2YGkINYEU5dRuwfG+zXEi7E4agkigJBVn/r9QQVXp42DK1eNBUUpEP2f5PpFfboGt7+T+
 w4QtpdD8N8wi0nw0XIaCKnp2IxgVU8rvtG67fs3OfkKb85IdRcnqbF4AgUcj+B5sRRy+3VbwJfk
 ZbaDAmtwAzQVbP72L3e2pkRpAjfL+aeFmjkIC3LC/OagNFlyz+A/r8/s8ZBKRBIdICXSi7J+C3C f+5+MsBY8kkHIIQ==
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

commit 9161f21c74a1a0e7bb39eb84ea0c86b23c92fc87 upstream.

  Backport note: a simple conflict with 787eb1e4df93 ("selftests: mptcp:
  uniform 'rndh' variable") where a new line was added for something
  else in the same context.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 40aeb5a71a2a..4a417f9d51d6 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
@@ -33,6 +35,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-- 
2.39.2

