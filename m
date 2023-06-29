Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F10742C20
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF2Sqa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjF2Sq0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169952D62
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37734615E2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487C6C433C0;
        Thu, 29 Jun 2023 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064380;
        bh=Uq2KYAuWAyxUlg7TlPfZj30HrNT6oTM7yl3EGO2qOI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1FVV+GM258JL7LNAir4vBxoXu0Kh2A87TI5gfebXGBngKYR/aKXpshyQXMUYvGnKT
         HkazoiwsKoqEz/qceyvSsejCiJzoaeD2PwOBPkrJ7IzOwR+ugWUxcVxd23Bg8Gfhns
         VVA6pDlCSTDhLnJqW5vAzp/XKsQnGNDEvndkSfPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.3 13/29] mm: make the page fault mmap locking killable
Date:   Thu, 29 Jun 2023 20:43:43 +0200
Message-ID: <20230629184152.268350026@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
References: <20230629184151.705870770@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit eda0047296a16d65a7f2bc60a408f70d178b2014 upstream.

This is done as a separate patch from introducing the new
lock_mm_and_find_vma() helper, because while it's an obvious change,
it's not what x86 used to do in this area.

We already abort the page fault on fatal signals anyway, so why should
we wait for the mmap lock only to then abort later? With the new helper
function that returns without the lock held on failure anyway, this is
particularly easy and straightforward.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5247,8 +5247,7 @@ static inline bool get_mmap_lock_careful
 			return false;
 	}
 
-	mmap_read_lock(mm);
-	return true;
+	return !mmap_read_lock_killable(mm);
 }
 
 static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
@@ -5272,8 +5271,7 @@ static inline bool upgrade_mmap_lock_car
 		if (!search_exception_tables(ip))
 			return false;
 	}
-	mmap_write_lock(mm);
-	return true;
+	return !mmap_write_lock_killable(mm);
 }
 
 /*


