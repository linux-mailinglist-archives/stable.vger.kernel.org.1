Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F053273A1E3
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFVNe4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjFVNew (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:34:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096291997
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:34:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f9bff0a543so19017085e9.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687440888; x=1690032888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7HVOwwbzrMSJr/9NLjXpxvsHHAASF1ri+iLdkAuaIA=;
        b=D2TMUJwfIcP34//9yJeHrq9mP1Aa1QVmRjIPnX6RWxhSpr+NCEfXf7GdUXntXRwCdj
         En1cj0+44zYk8KCUKfIrOunJWe2Ifi2KXG+cBcbL3CQH2pYIoehnEv0Ngq+CUsbmn+9o
         HRNx01mvIg+mZhJ+Ge3yjBd7Zucaztn3T82pm8FDmEbuS0wRlY5frfqhrJ/ns0cQesY5
         Mnm6+h9jbp0+yXiwlhvyNDj5+SnkwbN1A1td+dzrYF9X7kE5/Do1B//VyAoHT65t+ROQ
         HnZF7pqnVOPvW3UKM4mvezNqLA+Gf8ba/MOORgDXktl/frDEqLJcu3pq6bC73v1w41dl
         1GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687440888; x=1690032888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7HVOwwbzrMSJr/9NLjXpxvsHHAASF1ri+iLdkAuaIA=;
        b=Uivx5FMeN/1ityiuTeVYxp8gS9QFQqiVmb5uEEEdji4yK25rMGNfsaxWLvOk9cdihB
         Q9gLkgHd+zEuI2QErd7UfpcklfS2GEOD21WgOnhRaaJg46IU+skyvziL17wgZi1d2HAB
         iKggndKTXxBlhx4CLCiVBX6xd5J3l729ULOrMJGkrXIlir+qGbpMk53flgpY+dHuJBoi
         ulRO9jNHzJggOAG7wc9Z9prn4V0IW2VTgdM6FtjxiDYQj8Wqg2u9Vv/xDUJ08z7GtuyV
         cPh+La5WLh9hZ7l7W9RX1aF4GhMZDzWrT8hFuSG61nyyKvJef1EG82i6py5UzrgHHIcL
         WdnA==
X-Gm-Message-State: AC+VfDzcIFs/xYdZNHbN0ifzN+sfm8P0MSgfPcFvTpe7fjPpX/b9yQwe
        p8kI+GiqEJnEiCoi5OoaaZTaf9znx0naVIzNH+nIYQ==
X-Google-Smtp-Source: ACHHUZ4k90HVFJjDT5F0lbdRy0VpfBRU8ogogveohlirayr+SdHBX6Zma4v3agUYtr4XwtIolHNCqw==
X-Received: by 2002:a05:600c:21c5:b0:3fa:1af8:6ebf with SMTP id x5-20020a05600c21c500b003fa1af86ebfmr1930335wmj.0.1687440888089;
        Thu, 22 Jun 2023 06:34:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b003f60e143d38sm7746997wmj.11.2023.06.22.06.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:34:47 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: join: use 'iptables-legacy' if available
Date:   Thu, 22 Jun 2023 15:34:31 +0200
Message-Id: <20230622133431.3216631-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062203-parched-rippling-0d7c@gregkh>
References: <2023062203-parched-rippling-0d7c@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2550; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=SBwAX9+j7M/k4rGltoMLpdvOPhu4ldYhEK5oyiaJ3+w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklE3nakpeKmRC/y8YSUndTzHxDP6KHvCcJmkKw
 pPS45A+kaqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJRN5wAKCRD2t4JPQmmg
 cxsKEAC3Jl/Sfwv+2kkeNMNRuKNvsTpbMm0tkLm39Uz8lZUokGm5UrcZRbHG1htqDghMbUG7yN4
 KhEWOJvdWvT2gX4Myc8drPRFKCU35jYdo2TBMmmCJKA5pDClh4CyIwrn/U7kZH0IoSvXwC+q95z
 /q7/SNPxw2o2b33peuJeha8Ms/u8R4BtQnbwwE/FZJ8HMwSIsDNxl9vtiQ4jIBz0amcy8SmUqNd
 5YW346LBrdCUGEyZf64QbF2Sm4SpU3tzp6soBG91viyo9LfhRVVLjRDhdkrZtkxp5cFCxj145Tu
 NcUpkgSBO5nA6zluFOnF287aae92Xokby7sNgRRCdX8Vs+AoYZWyQ0WTDpNRFO0t+vR3szezsOL
 cD/+Kro+Jtq9r0nMsGD0PvXGumg+Vj/VGjsiVKgRWhZuk50UjXxxixZ+sykxmPGkg1geEW7MXMg
 mPexN+IHgACmRDG5+Ibw5AA8LrJRV5OzpV/BK9DMBt5onMVrp0iEq7E4MgySycAxLu1GckiyQfd
 6PZntSLokgikJIKh6fihoi8qwsC35L+c8ndRHIP2D7T5rq1Ui7RFflqZL6VdPGcxcii6mbkDpW6
 geS97vi69+CgFUmsf27JJ8g3wJ3EXFgY2TzdwSHhWUfm6Uj55D8TwHYPlTHuvq2uuxKwVWfzqB2 uxTK4PXFp4tINjw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 0c4cd3f86a40028845ad6f8af5b37165666404cd upstream.

IPTables commands using 'iptables-nft' fail on old kernels, at least
5.15 because it doesn't see the default IPTables chains:

  $ iptables -L
  iptables/1.8.2 Failed to initialize nft: Protocol not supported

As a first step before switching to NFTables, we can use iptables-legacy
if available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Applied on top of stable-rc/linux-5.15.y: d2efde0d1c2e ("Linux 5.15.119-rc1").

Conflicting with commits:
 - 87154755d90e ("selftests: mptcp: join: check for tools only if needed")
 - c7d49c033de0 ("selftests: mptcp: join: alt. to exec specific tests")
 - b6e074e171bc ("selftests: mptcp: add infinite map testcase")
 - 3469d72f135a ("selftests: mptcp: join: helper to filter TCP")

The code checking if the "iptables" command is available has been moved,
some modifications in the same context and new code we don't need
because we just want to replace "iptables" by "$iptables".

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7330e32bb9ab..e6391e234e97 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,6 +12,8 @@ cinfail=""
 cinsent=""
 cout=""
 ksft_skip=4
+iptables="iptables"
+ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
@@ -126,9 +128,9 @@ reset_with_add_addr_timeout()
 	local ip="${1:-4}"
 	local tables
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	reset
@@ -171,8 +173,10 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+if iptables-legacy -V &> /dev/null; then
+	iptables="iptables-legacy"
+	ip6tables="ip6tables-legacy"
+elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
 fi
-- 
2.40.1

