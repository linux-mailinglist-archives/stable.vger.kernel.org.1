Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05DF72C05B
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjFLKv7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjFLKvh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11B19039
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66CDC623EE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5039FC433D2;
        Mon, 12 Jun 2023 10:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566160;
        bh=eciLBRU5NBmlrnVccYFmJdD3KpdOhdOVw8GQ4LBDrsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eB7o0axYF2SILU+c69v6iar2+40/gdNy60YN2b1sShVh7lfSWwvjJ3gURV3YhGeFZ
         atTqbhk/vWxbm0GxgCuXnv+H9HCqMUthe1EFRRbq3v5pmrGjOKCL1dwaF7yEDemcMp
         MQ8BxRknCnFgYPFNX6nk4jAxmErBD2mzE2c2paqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 18/91] net/ipv6: fix bool/int mismatch for skip_notify_on_dev_down
Date:   Mon, 12 Jun 2023 12:26:07 +0200
Message-ID: <20230612101702.851518398@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit edf2e1d2019b2730d6076dbe4c040d37d7c10bbe ]

skip_notify_on_dev_down ctl table expects this field
to be an int (4 bytes), not a bool (1 byte).

Because proc_dou8vec_minmax() was added in 5.13,
this patch converts skip_notify_on_dev_down to an int.

Following patch then converts the field to u8 and use proc_dou8vec_minmax().

Fixes: 7c6bb7d2faaf ("net/ipv6: Add knob to skip DELROUTE message on device down")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netns/ipv6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index ff82983b7ab41..181b44f6fb686 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -53,7 +53,7 @@ struct netns_sysctl_ipv6 {
 	int seg6_flowlabel;
 	u32 ioam6_id;
 	u64 ioam6_id_wide;
-	bool skip_notify_on_dev_down;
+	int skip_notify_on_dev_down;
 	u8 fib_notify_on_flag_change;
 };
 
-- 
2.39.2



