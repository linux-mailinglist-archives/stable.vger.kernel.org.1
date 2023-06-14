Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD2713CF5
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjE1TUZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjE1TUY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6EFA0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C15461AAF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D73C433EF;
        Sun, 28 May 2023 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301622;
        bh=tjl8LzNrtm/4sfh9AnTfMX8wqt8DpR/xp+EvfUEif6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/M863AAsCCwbuD1eTefyQ16Q8+THgYyAr2lJEij+ObNSn9aBCPNjbrUjtZc/JSD8
         a8yBsLLL14NCS1/VLMOJNwwOYFBrgBUWRKcgGgeZc1uw4pk0o9pOV85XgIKdsRq5/7
         1uY5yzm8ys0vhoO3BDkMW2h9TfcafOOzXLAJaCLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Block <bblock@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 102/132] s390/qdio: fix do_sqbs() inline assembly constraint
Date:   Sun, 28 May 2023 20:10:41 +0100
Message-Id: <20230528190836.807852719@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 2862a2fdfae875888e3c1c3634e3422e01d98147 ]

Use "a" constraint instead of "d" constraint to pass the state parameter to
the do_sqbs() inline assembly. This prevents that general purpose register
zero is used for the state parameter.

If the compiler would select general purpose register zero this would be
problematic for the used instruction in rsy format: the register used for
the state parameter is a base register. If the base register is general
purpose register zero the contents of the register are unexpectedly ignored
when the instruction is executed.

This only applies to z/VM guests using QIOASSIST with dedicated (pass through)
QDIO-based devices such as FCP [zfcp driver] as well as real OSA or
HiperSockets [qeth driver].

A possible symptom for this case using zfcp is the following repeating kernel
message pattern:

zfcp <devbusid>: A QDIO problem occurred
zfcp <devbusid>: A QDIO problem occurred
zfcp <devbusid>: qdio: ZFCP on SC <sc> using AI:1 QEBSM:1 PRI:1 TDD:1 SIGA: W
zfcp <devbusid>: A QDIO problem occurred
zfcp <devbusid>: A QDIO problem occurred

Each of the qdio problem message can be accompanied by the following entries
for the affected subchannel <sc> in
/sys/kernel/debug/s390dbf/qdio_error/hex_ascii for zfcp or qeth:

<sc> ccq: 69....
<sc> SQBS ERROR.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Cc: Steffen Maier <maier@linux.ibm.com>
Fixes: 8129ee164267 ("[PATCH] s390: qdio V=V pass-through")
Cc: <stable@vger.kernel.org>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/qdio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 289ee9db577a2..f98dc3a8e3c71 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -95,7 +95,7 @@ static inline int do_sqbs(u64 token, unsigned char state, int queue,
 		"	lgr	1,%[token]\n"
 		"	.insn	rsy,0xeb000000008a,%[qs],%[ccq],0(%[state])"
 		: [ccq] "+&d" (_ccq), [qs] "+&d" (_queuestart)
-		: [state] "d" ((unsigned long)state), [token] "d" (token)
+		: [state] "a" ((unsigned long)state), [token] "d" (token)
 		: "memory", "cc", "1");
 	*count = _ccq & 0xff;
 	*start = _queuestart & 0xff;
-- 
2.39.2



