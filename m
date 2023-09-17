Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DE17A3BAA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbjIQUUu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbjIQUUS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:20:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F54B101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:20:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42694C433C8;
        Sun, 17 Sep 2023 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982012;
        bh=qB7FoAl3l9KHydFEdcIsnrJnR2num6sW/mBcErSs0kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOZ4ggObBca09qvaq39hh22D/khAV+anTgwWIhg6POZ/UFGQeqYjv4Gi+aZoyAhHu
         e5EhtAR6r/StXkedcpd7cr7h0fTqJ6sgW9pJZ9WuMIbPpsPgf/G4uwrGFN8sXO9m3s
         S5kU6iiUETflPFpOSoVAkfVFGv1iY+LLFNm4q3N4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Budimir Markovic <markovicbudimir@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 121/511] net/sched: sch_hfsc: Ensure inner classes have fsc curve
Date:   Sun, 17 Sep 2023 21:09:08 +0200
Message-ID: <20230917191116.794539255@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Budimir Markovic <markovicbudimir@gmail.com>

[ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]

HFSC assumes that inner classes have an fsc curve, but it is currently
possible for classes without an fsc curve to become parents. This leads
to bugs including a use-after-free.

Don't allow non-root classes without HFSC_FSC to become parents.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_hfsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index c802a027b4f31..01126e285f94e 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1012,6 +1012,10 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
+		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
+		return -EINVAL;
+	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
-- 
2.40.1



