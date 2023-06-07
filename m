Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251B77264F6
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbjFGPp7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjFGPp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 11:45:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950AF173B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 08:45:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30e5b017176so581950f8f.1
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686152755; x=1688744755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZtsba9MbeT+Wmsom1GFSJB6b/eMC+x7tl7EFBruVqI=;
        b=ouOCL3uFW1NSISPFEc3Rft/d/swGkJon2LSr6wwbO929qWcMuYvEn/YFlmeKu3q1/W
         QM6RVOhhdMucaMWvPUY1ocZoZtCdEPcW+NA2inKiXb7gnT0nHmy36u2tuUpBxL5IvNqh
         oh2p1WE6Z1dr252+TH/K+j7toVdG49RZHmwuOem4I+qq313NPI6s+H1dCyG8cOJ2GFPN
         cbRIo4qHlpicW5Oe4eNzi2mhV7Yug31Xx/RpKtgZbusAID1+rVL8odehGxLnkRaj/Wxk
         B0Kxv8XYpCZmGDo124Obx8bKCSqCIl+LDaHOp/726JY/brQXQ2YEbbCXlyjtL9wNx3i8
         7mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152755; x=1688744755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZtsba9MbeT+Wmsom1GFSJB6b/eMC+x7tl7EFBruVqI=;
        b=g+YHPqCruBIDStKYEKnlDsWmsdbTqWDO1UE9ZTqNpNfiqOefrg2WiJLCWO8cVpT19f
         qaK2emHPCxPpTsFeHwIeQzwf+wJV4lKRTOSSJFw8To6uP1bGiGusEU2Cp9OxGOX7t91k
         CnB+oVushKm0tO+RxAcxex/SdUsRztIkX50p4H6/G/Dv8IQMSB95nUTRpp4Y8wffH3dm
         yZvoszFHx6q4Fi6chR4y8ppyp+hpsM2HOM+h6/+nrDl5cd2i3UXtoSjYElBdO6xotZZV
         GC49CXcAoZAWscCY37NcmOVfalzIFAdpf4hQvExvXbQxk+sOkv9XVrQi1HLB0yqv7sIm
         4Dsg==
X-Gm-Message-State: AC+VfDwSvffU12MQcIjDvhmQsxJYWJ+kqVhSVZft2EEUKe5AVKP3HNA7
        RGIxMo8M0MIjQedKguhbGiDoDGN/wHNH145wRkL/sg==
X-Google-Smtp-Source: ACHHUZ4Sw0TlaVuNCcj3YerZMOv6y0CEuuw0gf6vgnR/jV2R0HO5XZn3NZETRAbjeh7/mJLhs6TkyA==
X-Received: by 2002:adf:ec0d:0:b0:30e:5390:ea37 with SMTP id x13-20020adfec0d000000b0030e5390ea37mr3043419wrn.5.1686152755605;
        Wed, 07 Jun 2023 08:45:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d638e000000b0030e5bd253aasm1819857wru.39.2023.06.07.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:45:55 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] selftests: mptcp: join: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 17:45:42 +0200
Message-Id: <20230607154542.2693217-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060735-smelting-gas-07a2@gregkh>
References: <2023060735-smelting-gas-07a2@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=a4k7idpPF9uL0lsUoe872oZ7HpfBPJI8FtDLT//ulW4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgKYm+VLdTFhXXMwnbx1pl1c4H39hNQiAr7UEu
 OL3DifYLKWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZICmJgAKCRD2t4JPQmmg
 c6mpEADYLFFegdygr5PlFhITUZMdyWnLFpbjNyiMtBqmKMyodz51Sw6/9viAFQanbybncMX5wAr
 w0KEbHPiv4PiY4jFUdZIgbO9RZPCwqR9GI1nvST+RE+WXzxeMvdqld1K2gzz2D4woVVtGMXyGTd
 agdbI+TPv8MSMZFHZY073JMyGU2nSo2AvHVaVY8pRsEREmsq202hfWmO8vUeZmXSZrcnh/L6rLc
 W7DZvqibKjUbjldZ042WviWMmfPNv2jOoC3Uk1/ElL4x2Y2GHf0gfCrS3nhOK+KqfkgyYYPiC43
 KfC2CUpVc93ulMMq5nAPVR96xK2xS5yKPTYtSsjQzJ7jdytlhJJTEdcxnqqM0AkAyTaIqhGD5om
 KvCon73zqaArt3Uyo2jE0Z1I5wklhursHzIN7F6kpEg1UEk7VFzscICWxiwDLkFFJFi958V4b0R
 49hzMfxqPf4N0ZWXKfDjsebsPeLsgLp5v0J4wGtDgN0c+X9M2ApuFNLCaMQKQm08RvRmMOhrAWC
 /YRsikZEl+rbhLzhHeEX+t7jXVCQa9TsVE0wdNZou8YZopf+O6wLHM15polGWoBdu30uDzu4ViC
 Wz5wx0XiyN2+78JzRB0k6R0TaT+C+EEsFmRt0TbO2yAk3IQ8Se7Vw9UXP25q6fgtRY0uOJMoB+s R/EQXiNCDizsMwg==
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

commit 715c78a82e00f848f99ef76e6f6b89216ccba268 upstream.

  Backport note: a simple conflict with 87154755d90e ("selftests: mptcp:
  join: check for tools only if needed") where the context attached to
  the new line we want to add has been moved to a dedicated function.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 08f53d86dedc..94b15bb28e11 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sout=""
@@ -88,6 +90,8 @@ for arg in "$@"; do
 	fi
 done
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-- 
2.39.2

