Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECD3703348
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbjEOQfR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbjEOQfR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50287A4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E17E8627F2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68F5C433EF;
        Mon, 15 May 2023 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168515;
        bh=ke6IBrxQa/Z0rVtosGv/WT0YqEmh9i+aENIf2DcZNzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xZEvXXp6hyy3zn4EzfUCJ5KhYozHz3DErKzDixyiz5A3hpcRdj1+NfJjOLKba/aN+
         vRBI3gUiygEzoqNPFeIFVZ1oP1dVab2Vfh/5T0Hm3or/NZDNJkbWLyq4JoGHbsc7N/
         etLlGV6C+hadxj7OEGKaV7zn8KbJRibHgZewzMrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang He <windhl@126.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 057/116] macintosh/windfarm_smu_sat: Add missing of_node_put()
Date:   Mon, 15 May 2023 18:25:54 +0200
Message-Id: <20230515161700.163846425@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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

From: Liang He <windhl@126.com>

[ Upstream commit 631cf002826007ab7415258ee647dcaf8845ad5a ]

We call of_node_get() in wf_sat_probe() after sat is created,
so we need the of_node_put() before *kfree(sat)*.

Fixes: ac171c46667c ("[PATCH] powerpc: Thermal control for dual core G5s")
Signed-off-by: Liang He <windhl@126.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230330033558.2562778-1-windhl@126.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/macintosh/windfarm_smu_sat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index a0f61eb853c55..644e123510c52 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -172,6 +172,7 @@ static void wf_sat_release(struct kref *ref)
 
 	if (sat->nr >= 0)
 		sats[sat->nr] = NULL;
+	of_node_put(sat->node);
 	kfree(sat);
 }
 
-- 
2.39.2



