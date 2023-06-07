Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4597B7264FD
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbjFGPrm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbjFGPrl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 11:47:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3F1988
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 08:47:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso47295405e9.2
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686152858; x=1688744858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwSKEmHvu2cGCxHbrpczgIk1oaMKQXbj0geHI9EKj1A=;
        b=pF/2/M8hcYS5AqUxArVh0w981sHa6CX7sYNfOhCoiWGtqffym1A3tvaRZqMy90YL6Y
         mXxDx11NsXo90vZkPXaEmBZaz9wGn+0t2J9DNj2vvcM3TnOkj+WFGghwncfNLlVgdZzj
         SM3c0P/dGryEIO69TmGboGseAgk468Eyfev0XcXZTTPZS/3rHlxhhFssIPrs0ddkPwpR
         slmNnsSTUX7FBoqszEi8tjre83mgyslKFpbuK3l/XnFvmlGxWqxhqxThEiipNoz7fgch
         6mCly2ve7XQcUi588RtsDJ5t6BZjR+ZrMek+kRJK/IczbKWrKDishfpu3+5/RnZJrX3k
         kR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152858; x=1688744858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwSKEmHvu2cGCxHbrpczgIk1oaMKQXbj0geHI9EKj1A=;
        b=FqxgCUx0IMbgHnocWsWzPVeRaBMzR2zAGhB6yvEcLqaw0bGWC456szCzsJmhr80S6e
         fazoli72wLRE/wWD/aegF22QzedFR7n1gu3+iYUOOauwcu77ycH90zdpTn1kqferqRok
         ZzxRmjkjAwxsmorGB0P8gMKthYGy1IYl9/Uax0xYhDVCSbWu6ZWL4RVibKBx5BgL32di
         rkmogYX+vlzMY/CkT/mdssh6bb6cprHNXVrUyxZKsSR7z1aMK47GWPD8fUZxFadoO/88
         ZNlBlyI+nDfEadwMTsl9CM5vSl1dRS/eJelwycDucOlgJz329uZK17gIEhcFEpQtDlPv
         WVUg==
X-Gm-Message-State: AC+VfDxS+qcnOFpoXS6Y5cX74bA048aEjxtRUbX1JeOLK83NhSJxBedl
        Pff18W7RywAsYYZStlGKo/W7wW1OMXBOw5Ww9vfbBg==
X-Google-Smtp-Source: ACHHUZ5Zhp4y8Laj3t0M0bVCjHCwdMH42nKugZz0EdT1ZaF9l56jcL//TdoSV7rB7mn2/aXca+bucg==
X-Received: by 2002:a05:600c:c1:b0:3f7:e8e2:f377 with SMTP id u1-20020a05600c00c100b003f7e8e2f377mr7732881wmm.12.1686152857787;
        Wed, 07 Jun 2023 08:47:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6186000000b002ffbf2213d4sm15802623wru.75.2023.06.07.08.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:47:37 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] selftests: mptcp: simult flows: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 17:47:27 +0200
Message-Id: <20230607154727.2695439-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060731-submitter-gone-32b6@gregkh>
References: <2023060731-submitter-gone-32b6@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=P8KRfgP/VQ2Dq3QoTOPdbUvV+s5wB9v3xW1M4hvK7xQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgKaPx3ypVWMebOJJAsK7TNP2PQVjYNx1SP7Is
 iQasAU6YZ6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZICmjwAKCRD2t4JPQmmg
 c0GnEACWg6gDH9UvgJgmYaUbIlJVthKE7skP4S1Cg06mi49KqgDs+2FHmgM5kG+ybYdyqeCViOG
 rztnNVmiYVsaXY3837HHU2WWja9WA2rwXsmlUuhpJIfV7v+qEX0dFyYubbQfI1TsckZKkKFyhp3
 R0dValrKHfbSD9492LhMDTGFt7qWLKU416io6VDUbTr4pkpmmz3NuD/Ed2pOmzUXOms76MYI7ef
 Eo4wJntweEu6vsLy2oulirL/Zd8JVtgtju8vyvF6FlOB8wM4/V3NyeQtvhkRVR2bgwCra+yAuvs
 3jlBy7hJxZar1ULG68Zu3hd3rZgsUPQIDVd6OvsTzC5ALZTNYClda5akoczQ4F3O6Ixx8pOhEPe
 F+8MTtAnm84RK+aGJbaxkDOmkEdb8NDf7l5sNYyndOMNSuabpNZRNkJ0ooMFXczdiR0C8TGAV6d
 IewT7gcXYcBOnZp5NvCTWmuHrEk8BtWjqx1BrdjNvP8zZt0qU0UCPUP6v0f+bS/LKjQiVGCF0TG
 gnpytwmU0nzB2G701nGpr/G8Pbu24NjzvzBM0W6Ln4qEyNrBjZmdjvYttLQ38FyFY+z5vz6xnft
 OJ/FNqo7Iwwvd3X1EHDDGVBCkeesgiJ/ImbbGsjDFU9cRoje7HROTeCluB4gHp6/OlsjmH9TnPP wa70VOwiauX7Vwg==
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
index 8fcb28927818..b51afba244be 100755
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
@@ -31,6 +33,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-- 
2.39.2

