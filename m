Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FC713D91
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjE1T04 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjE1T0z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:26:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAD218D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 082D961C55
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252DFC433EF;
        Sun, 28 May 2023 19:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302002;
        bh=dmZBw8R2g7FQarp89y4f2fqt3U9m/gMOnwcFcmlwzaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMMEMU2A9o6QZrIqCua7G5PkyEdkSUyuBgOWw2qbH5L/exutfIqGfPVdJ6pp6lgRJ
         mVTXxyf/+IGFFUIDAa+MqUwR/NAikXkN0zF8RFvyLeeUk48DrKmEVtXtlyXgW03KSZ
         IqBJ76tGLdEg696BnUEhbdU+oF0xqS1gL3Zsg53w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 121/161] s390/qdio: get rid of register asm
Date:   Sun, 28 May 2023 20:10:45 +0100
Message-Id: <20230528190840.875219286@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
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

[ Upstream commit d3e2ff5436d6ee38b572ba5c01dc7994769bec54 ]

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Stable-dep-of: 2862a2fdfae8 ("s390/qdio: fix do_sqbs() inline assembly constraint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/qdio.h      | 25 ++++++++-------
 drivers/s390/cio/qdio_main.c | 62 +++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 3b0a4483a2520..e91d2a589957c 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -88,15 +88,15 @@ enum qdio_irq_states {
 static inline int do_sqbs(u64 token, unsigned char state, int queue,
 			  int *start, int *count)
 {
-	register unsigned long _ccq asm ("0") = *count;
-	register unsigned long _token asm ("1") = token;
 	unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
+	unsigned long _ccq = *count;
 
 	asm volatile(
-		"	.insn	rsy,0xeb000000008A,%1,0,0(%2)"
-		: "+d" (_ccq), "+d" (_queuestart)
-		: "d" ((unsigned long)state), "d" (_token)
-		: "memory", "cc");
+		"	lgr	1,%[token]\n"
+		"	.insn	rsy,0xeb000000008a,%[qs],%[ccq],0(%[state])"
+		: [ccq] "+&d" (_ccq), [qs] "+&d" (_queuestart)
+		: [state] "d" ((unsigned long)state), [token] "d" (token)
+		: "memory", "cc", "1");
 	*count = _ccq & 0xff;
 	*start = _queuestart & 0xff;
 
@@ -106,16 +106,17 @@ static inline int do_sqbs(u64 token, unsigned char state, int queue,
 static inline int do_eqbs(u64 token, unsigned char *state, int queue,
 			  int *start, int *count, int ack)
 {
-	register unsigned long _ccq asm ("0") = *count;
-	register unsigned long _token asm ("1") = token;
 	unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
 	unsigned long _state = (unsigned long)ack << 63;
+	unsigned long _ccq = *count;
 
 	asm volatile(
-		"	.insn	rrf,0xB99c0000,%1,%2,0,0"
-		: "+d" (_ccq), "+d" (_queuestart), "+d" (_state)
-		: "d" (_token)
-		: "memory", "cc");
+		"	lgr	1,%[token]\n"
+		"	.insn	rrf,0xb99c0000,%[qs],%[state],%[ccq],0"
+		: [ccq] "+&d" (_ccq), [qs] "+&d" (_queuestart),
+		  [state] "+&d" (_state)
+		: [token] "d" (token)
+		: "memory", "cc", "1");
 	*count = _ccq & 0xff;
 	*start = _queuestart & 0xff;
 	*state = _state & 0xff;
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 5b63c505a2f7c..620655bcbe80d 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -31,38 +31,41 @@ MODULE_DESCRIPTION("QDIO base support");
 MODULE_LICENSE("GPL");
 
 static inline int do_siga_sync(unsigned long schid,
-			       unsigned int out_mask, unsigned int in_mask,
+			       unsigned long out_mask, unsigned long in_mask,
 			       unsigned int fc)
 {
-	register unsigned long __fc asm ("0") = fc;
-	register unsigned long __schid asm ("1") = schid;
-	register unsigned long out asm ("2") = out_mask;
-	register unsigned long in asm ("3") = in_mask;
 	int cc;
 
 	asm volatile(
+		"	lgr	0,%[fc]\n"
+		"	lgr	1,%[schid]\n"
+		"	lgr	2,%[out]\n"
+		"	lgr	3,%[in]\n"
 		"	siga	0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28\n"
-		: "=d" (cc)
-		: "d" (__fc), "d" (__schid), "d" (out), "d" (in) : "cc");
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=&d" (cc)
+		: [fc] "d" (fc), [schid] "d" (schid),
+		  [out] "d" (out_mask), [in] "d" (in_mask)
+		: "cc", "0", "1", "2", "3");
 	return cc;
 }
 
-static inline int do_siga_input(unsigned long schid, unsigned int mask,
-				unsigned int fc)
+static inline int do_siga_input(unsigned long schid, unsigned long mask,
+				unsigned long fc)
 {
-	register unsigned long __fc asm ("0") = fc;
-	register unsigned long __schid asm ("1") = schid;
-	register unsigned long __mask asm ("2") = mask;
 	int cc;
 
 	asm volatile(
+		"	lgr	0,%[fc]\n"
+		"	lgr	1,%[schid]\n"
+		"	lgr	2,%[mask]\n"
 		"	siga	0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28\n"
-		: "=d" (cc)
-		: "d" (__fc), "d" (__schid), "d" (__mask) : "cc");
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=&d" (cc)
+		: [fc] "d" (fc), [schid] "d" (schid), [mask] "d" (mask)
+		: "cc", "0", "1", "2");
 	return cc;
 }
 
@@ -78,23 +81,24 @@ static inline int do_siga_input(unsigned long schid, unsigned int mask,
  * Note: For IQDC unicast queues only the highest priority queue is processed.
  */
 static inline int do_siga_output(unsigned long schid, unsigned long mask,
-				 unsigned int *bb, unsigned int fc,
+				 unsigned int *bb, unsigned long fc,
 				 unsigned long aob)
 {
-	register unsigned long __fc asm("0") = fc;
-	register unsigned long __schid asm("1") = schid;
-	register unsigned long __mask asm("2") = mask;
-	register unsigned long __aob asm("3") = aob;
 	int cc;
 
 	asm volatile(
+		"	lgr	0,%[fc]\n"
+		"	lgr	1,%[schid]\n"
+		"	lgr	2,%[mask]\n"
+		"	lgr	3,%[aob]\n"
 		"	siga	0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28\n"
-		: "=d" (cc), "+d" (__fc), "+d" (__aob)
-		: "d" (__schid), "d" (__mask)
-		: "cc");
-	*bb = __fc >> 31;
+		"	lgr	%[fc],0\n"
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=&d" (cc), [fc] "+&d" (fc)
+		: [schid] "d" (schid), [mask] "d" (mask), [aob] "d" (aob)
+		: "cc", "0", "1", "2", "3");
+	*bb = fc >> 31;
 	return cc;
 }
 
-- 
2.39.2



