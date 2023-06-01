Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F38719DD1
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjFAN0q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjFAN0i (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B018F
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62AA7644AD
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F14BC433EF;
        Thu,  1 Jun 2023 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625972;
        bh=DHbeZIlCJD/8jt1CjNFc6VqW0nOJJ4BR9ZXicu9RwkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpQjnqVAoOMX786E1yeDt6otAGPz6NcJe1yad3Yom0bIPLKpTU4VvPGHm5tsJHtJt
         6xnU/Dcf9Mlx8wH+n3WfGwY6Y2/of3KSyK7+cJAUAZkf/XDbwNRlCSjVE3Ho0gi9O0
         K7gtMfpqoVhhFF3HFY7hza//NbNfsyMqE1Mj0iso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 09/45] bpf: netdev: init the offload table earlier
Date:   Thu,  1 Jun 2023 14:21:05 +0100
Message-Id: <20230601131939.130808037@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit e1505c1cc8d527fcc5bcaf9c1ad82eed817e3e10 ]

Some netdevices may get unregistered before late_initcall(),
we have to move the hashtable init earlier.

Fixes: f1fc43d03946 ("bpf: Move offload initialization into late_initcall")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217399
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/r/20230505215836.491485-1-kuba@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0c85e06f7ea7f..ee146430d9984 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -853,4 +853,4 @@ static int __init bpf_offload_init(void)
 	return rhashtable_init(&offdevs, &offdevs_params);
 }
 
-late_initcall(bpf_offload_init);
+core_initcall(bpf_offload_init);
-- 
2.39.2



