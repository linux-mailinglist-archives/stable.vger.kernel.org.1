Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC3726B60
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjFGUZM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjFGUY2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B4E26AE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C60C264409
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ECEC433EF;
        Wed,  7 Jun 2023 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169434;
        bh=NzEPcKervLugpEAasHPOHiuyqhyE4vRH/b5OPKuJUkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DST3zy7aWEIU57y9rIMRAI0VHkmyYsKQU9DaeFyptQynL52iCEBH1rrys3xhloTac
         Q6GRl7o61QlphNnCG9S3xRl5vVK6MBoJqu7GiUsQsjtvojocc4yZJSEEetLvwf4AgK
         arDWUJ8MmAHpi559XKpMiGr+xaFMOUcXRtG82osw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 080/286] mptcp: avoid unneeded address copy
Date:   Wed,  7 Jun 2023 22:12:59 +0200
Message-ID: <20230607200925.690150866@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 2bb9a37f0e194ed95c70603b0efc7898a5a0d9b4 ]

In the syn_recv fallback path, the msk is unused. We can skip
setting the socket address.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 7e8b88ec35ee ("mptcp: consolidate passive msk socket initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/subflow.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 281c1cc8dc8dc..8a6bd2782dc97 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -823,8 +823,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (new_msk)
-				mptcp_copy_inaddrs(new_msk, child);
 			mptcp_subflow_drop_ctx(child);
 			goto out;
 		}
-- 
2.39.2



