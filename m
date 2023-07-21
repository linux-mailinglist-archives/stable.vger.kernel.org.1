Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1152875D34E
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGUTJN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGUTJM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A430E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B79C61D02
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704F4C433C7;
        Fri, 21 Jul 2023 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966549;
        bh=lgTUt7JDiYkVjOzr8diPbzsXbnxvocxGjGGmQyEAwHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0qjOu7Sbb+EUyEtv76l78OOpOlonp3HJAREqzSp7so9Uuj+oq3tbLE00qQce7dwj
         DNnYBx/B/adSBdYCY0Fbv++9vQVEizYbOJ9P3tVL5AKMxSsbLkTGbb3xrcxKqFYrDG
         MuD+cyN4HW5PMlLxNVI3knKIP5f7G8MNko6vh4IM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.15 354/532] integrity: Fix possible multiple allocation in integrity_inode_get()
Date:   Fri, 21 Jul 2023 18:04:18 +0200
Message-ID: <20230721160633.646700412@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

commit 9df6a4870dc371136e90330cfbbc51464ee66993 upstream.

When integrity_inode_get() is querying and inserting the cache, there
is a conditional race in the concurrent environment.

The race condition is the result of not properly implementing
"double-checked locking". In this case, it first checks to see if the
iint cache record exists before taking the lock, but doesn't check
again after taking the integrity_iint_lock.

Fixes: bf2276d10ce5 ("ima: allocating iint improvements")
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: <stable@vger.kernel.org> # v3.10+
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/iint.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -43,12 +43,10 @@ static struct integrity_iint_cache *__in
 		else if (inode > iint->inode)
 			n = n->rb_right;
 		else
-			break;
+			return iint;
 	}
-	if (!n)
-		return NULL;
 
-	return iint;
+	return NULL;
 }
 
 /*
@@ -121,10 +119,15 @@ struct integrity_iint_cache *integrity_i
 		parent = *p;
 		test_iint = rb_entry(parent, struct integrity_iint_cache,
 				     rb_node);
-		if (inode < test_iint->inode)
+		if (inode < test_iint->inode) {
 			p = &(*p)->rb_left;
-		else
+		} else if (inode > test_iint->inode) {
 			p = &(*p)->rb_right;
+		} else {
+			write_unlock(&integrity_iint_lock);
+			kmem_cache_free(iint_cache, iint);
+			return test_iint;
+		}
 	}
 
 	iint->inode = inode;


