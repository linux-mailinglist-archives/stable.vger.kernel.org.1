Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10246F145A
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 11:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345433AbjD1JoL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 05:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjD1JoK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 05:44:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86AF448C
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 02:44:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso6088994f8f.2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682675047; x=1685267047;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bX5O5UVvhTV+NkgImY0lR+4vbyOqcNBXY53k7mqT+/w=;
        b=pVn3jvXNN9WeJkUaKY9hgbV25v+taqKpkinatoDUAgKm+wukxMujCfBYozQVjChMu0
         70ia+0Fb1kNVuQqpv+DO6TphETGiqTD1tWVmDOLFeuIyj819zIqIywMFQQEkiXx1l6/t
         v2AfyiDbgYSZxwR3/6LHjOU43pVMkhwxJzK964cFLqJg+W6LrYTWMSfDgvGBm8rCM7Tk
         TNLMP3MSm+k6YZQIXBbGCN+mKmcFpYSXYd6B1J2RbMevU6UUNXtcqFPal53Igcp1TQV/
         EK+LQre+ebxUtw4IAsPF6kZSo9YwJw+24c7G8V4zCijCHWjh3X1hug2sYFKSSuVa+6vL
         1pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682675047; x=1685267047;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX5O5UVvhTV+NkgImY0lR+4vbyOqcNBXY53k7mqT+/w=;
        b=bjSUd3YNxj71BBWh6e2liSxsNjuXJehAMNuGnxE6EOEm52ti/KoLui17x5fVS/F7Lo
         tMraC4P78jHVo6epDFBrPA68CBpefm+Hhl8lRkA0RoZbR8cQOcxPNlcsOubj5ZcWGqt4
         DZHYdrbpt5mL2uLO91mLwB1tToC58ewc/oK2HPPbno0vHvKgNotgPG71b6MSWp8RV+d2
         djKN8LzM+bWP1wUtc4cNR68AEmgpygU2XCaINxBbsfMLYGYsAuiW7r5N8u30Ri2aTtSP
         AOTk3Nv5uaekJh6QqI7nUVs+OW9ucxpvxYWJeDVbwiCowGRV8f9CFBpKeR9QeiXedZPt
         Uq0w==
X-Gm-Message-State: AC+VfDw6TP1k59p5fXc2rjSobAXTr/YQVbUkSWLFAcvHxOo+JwySPJ2Q
        ddCnxrI5WizeO0TDeNlWt+9YSUzfL9EDT7TxVZCUwAXV
X-Google-Smtp-Source: ACHHUZ5UuJcy6ChE17z2A//jT2ubqD/5R+/Ow5R3u89zfSIAMODBTt5R37lKINU6lqwVySTGcquVgQ==
X-Received: by 2002:adf:e908:0:b0:300:6473:e339 with SMTP id f8-20020adfe908000000b003006473e339mr3570603wrm.6.1682675047250;
        Fri, 28 Apr 2023 02:44:07 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p13-20020a7bcc8d000000b003ee63fe5203sm23817081wma.36.2023.04.28.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 02:44:06 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 28 Apr 2023 11:43:46 +0200
Subject: [PATCH 5.15] selftests: mptcp: join: fix "invalid address,
 ADD_ADDR timeout"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22@tessares.net>
X-B4-Tracking: v=1; b=H4sIAFGVS2QC/z2OwQqDMBBEf0X23JWYKpX+SvGwMdu6oDFstFjEf
 2/soTAwzAw8ZofEKpzgXuyg/JYkc8ihuhTQDxRejOJzBmvs1dS2xTWmRZkmTAu5kfE/THHpI5L
 3Wep1jpM4dObWkqlrmx0y01FidEqhH07qKGHdsCmrpvycc1R+yva784Czhu44vgoT/mykAAAA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Mat Martineau <martineau@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org,
        mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=vHdKDPc+cwdQr6+1isQPwxOD8LjtsFVj28v1KGjAb48=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkS5Vm27MFh1GGlNngiErdb2tpZCAaLQdKu/SNV
 FRE5cyNzT2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZEuVZgAKCRD2t4JPQmmg
 c5BMEACGe5huR3/83bhZH9rMLl2NPQ5DhjMKusknl3t6Kcgvv3av6xXsLGirNPUTwhwvEV8NtT6
 LMcENTm64HzKJHajd8mHuh9S/B/fKVqB7UMXYwQWI3XpHvgQrJoyhbfhI4mUUqCdAQZ1rragDR+
 vT1uu1uOs687jHcAjYmbNuEoDgdOpFu0RgldiKV3WJp3hvhLOkZn00WgrDb+YNSqFe9PcDNEmrX
 3sGubamJA9mIVGMRi1ixa2hPSoifUg5Nx7Wx8ClchgL4bqBMe5jnEWPVYemGfZXP25hAWePQvro
 PC+DIDe3BkLSyuSu0M6hPJaS4nptlqksOQMwPZhO+oM8XgOR47ba2zT19y/Pc0v+yCqSM65fFVF
 7BNC3rwmvSOYmE0pqSj4TEE65wX5nSsxaJTLF5ulqVkUxMIHZncWMVyW6qme3qRylPplXJ38ETB
 USa7iYLB++fbXjQv/xA7YusTZtrrtGp3rX3q9uqtZz1FtHvbMXjom/m6gzZ74CeQCHj/cwwJiww
 HDCbvRdtH7bBr1OWt8i26oBmpEFx7/D0iyk4H5H3sPqytDlnsq2SRFeKl/dvif+0FKYPcCbcLhy
 MUUsHZ13lM75u5J/Go12wfXo149+sOFS1oKFnwIi38Xg6fCUzN0vYci3GE/tiS2kgf0tTjtds95
 mXIJx64qtbwiEIg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The "Fixes" commit mentioned below adds new MIBs counters to track some
particular cases that have been fixed by its parent commit 150d1e06c4f1
("mptcp: fix race in incoming ADD_ADDR option processing").

Unfortunately, one of the new MIB counter (AddAddrDrop) shares the same
prefix as an older one (AddAddr). This breaks one selftest because it
was doing a grep on "AddAddr" and it now gets 2 counters instead of 1.

This issue has been fixed upstream in a commit that was part of the same
set but not backported to v5.15, see commit 6ef84b1517e0 ("selftests:
mptcp: more robust signal race test"). It has not been backported
because it was fixing multiple things, some where for >v5.15.

This patch then simply extracts the only bit needed for v5.15. Now the
test passes when validating the last stable v5.15 kernel.

Fixes: f25ae162f4b3 ("mptcp: add mibs counter for ignored incoming options")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Hi Greg, Sasha,
Here is a fix just for v5.15, where f73c11946345 ("mptcp: add mibs
counter for ignored incoming options") has been backported but not
6ef84b1517e0 ("selftests: mptcp: more robust signal race test").
Thanks!
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3be615ab1588..96a090e7f47e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -732,7 +732,7 @@ chk_add_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"

---
base-commit: f48aeeaaa64c628519273f6007a745cf55b68d95
change-id: 20230428-upstream-stable-20230428-mptcp-addaddrdropmib-b078a0442078

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

