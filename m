Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114D87DD535
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376474AbjJaRsU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376466AbjJaRsT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F8412D
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DD6C433C8;
        Tue, 31 Oct 2023 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774486;
        bh=AJbpoAc2YK3B73Qouj4sgpdZLjYAwEXhyytqXrHpGEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JywdezjSYfWwJmCpcORRs3eEIjh9LFsW8EODmz5Wx4KT7lmixb0h4wk05B7wVtuge
         kG+m/xGldEP4NC4ltgg0vlXXhzn2qJSnmNlMTqbbZObC+R82Hyx2cH3cJKsCnJ9mNY
         c7ZnTYSO63x0/VHHJYs+Q67tUj0lahu+ZGsH14qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Yikebaer Aizezi <yikebaer61@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 028/112] mm/mempolicy: fix set_mempolicy_home_node() previous VMA pointer
Date:   Tue, 31 Oct 2023 18:00:29 +0100
Message-ID: <20231031165902.206790686@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam R. Howlett <Liam.Howlett@oracle.com>

commit 51f625377561e5b167da2db5aafb7ee268f691c5 upstream.

The two users of mbind_range() are expecting that mbind_range() will
update the pointer to the previous VMA, or return an error.  However,
set_mempolicy_home_node() does not call mbind_range() if there is no VMA
policy.  The fix is to update the pointer to the previous VMA prior to
continuing iterating the VMAs when there is no policy.

Users may experience a WARN_ON() during VMA policy updates when updating
a range of VMAs on the home node.

Link: https://lkml.kernel.org/r/20230928172432.2246534-1-Liam.Howlett@oracle.com
Link: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
Fixes: f4e9e0e69468 ("mm/mempolicy: fix use-after-free of VMA iterator")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
Closes: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mempolicy.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1543,8 +1543,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node,
 		 * the home node for vmas we already updated before.
 		 */
 		old = vma_policy(vma);
-		if (!old)
+		if (!old) {
+			prev = vma;
 			continue;
+		}
 		if (old->mode != MPOL_BIND && old->mode != MPOL_PREFERRED_MANY) {
 			err = -EOPNOTSUPP;
 			break;


