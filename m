Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23D7A80EE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjITMlQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjITMlP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:41:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C7BB6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:41:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED18C433C7;
        Wed, 20 Sep 2023 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213668;
        bh=3JJaI5BaSasstDHa55QqlrTmu3Quew4yNglkA8fMszc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTK3r03db03kNnu8WH8Bb9GtLKeCoPWQPIdNncOr0YhQZKDrMPlJ3CmCJV9F5tvPl
         GUIleKJrQXc3RmOpV6QmH2eLU+kAqwmGQL/3YwAgfzCvv/SwutgY4OCOq9X5DsYP1H
         zF13tbx0tJBajHo4OdetPg2Ug/Et421aPInFU0Fg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark ODonovan <shiftee@posteo.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 321/367] crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()
Date:   Wed, 20 Sep 2023 13:31:38 +0200
Message-ID: <20230920112906.851740658@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit 9e47a758b70167c9301d2b44d2569f86c7796f2d ]

During NVMeTCP Authentication a controller can trigger a kernel
oops by specifying the 8192 bit Diffie Hellman group and passing
a correctly sized, but zeroed Diffie Hellamn value.
mpi_cmp_ui() was detecting this if the second parameter was 0,
but 1 is passed from dh_is_pubkey_valid(). This causes the null
pointer u->d to be dereferenced towards the end of mpi_cmp_ui()

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/mpi/mpi-cmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/mpi/mpi-cmp.c b/lib/mpi/mpi-cmp.c
index d25e9e96c310f..ceaebe181cd70 100644
--- a/lib/mpi/mpi-cmp.c
+++ b/lib/mpi/mpi-cmp.c
@@ -25,8 +25,12 @@ int mpi_cmp_ui(MPI u, unsigned long v)
 	mpi_limb_t limb = v;
 
 	mpi_normalize(u);
-	if (!u->nlimbs && !limb)
-		return 0;
+	if (u->nlimbs == 0) {
+		if (v == 0)
+			return 0;
+		else
+			return -1;
+	}
 	if (u->sign)
 		return -1;
 	if (u->nlimbs > 1)
-- 
2.40.1



