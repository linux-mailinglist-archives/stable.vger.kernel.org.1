Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1212677AE3B
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjHMWS1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjHMWSN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 18:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62E2D49
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B4D62784
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E89C433C7;
        Sun, 13 Aug 2023 21:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963076;
        bh=qsC4dIn90MefTn9CUh7R5akvFvTaQKk9ffdyzTgWLa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khJPLwYN1jM6UMAvVHmpzE/ZuH77v4MuW0r6890N4hmOMpMSxPYlzzkYcSVLzp81z
         8/WuXI1hVV90C9SH+seodKk9XCP0zOBTlChEXytBQydoYCs8WYq4hHZkULUsB5lkwR
         kZycxqS06tGalsIYWr9TQ30C3eTaNYpv2bPLyeik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Kuohai <xukuohai@huawei.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 5.15 44/89] bpf, sockmap: Fix map type error in sock_map_del_link
Date:   Sun, 13 Aug 2023 23:19:35 +0200
Message-ID: <20230813211712.114627991@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Xu Kuohai <xukuohai@huawei.com>

commit 7e96ec0e6605b69bb21bbf6c0ff9051e656ec2b1 upstream.

sock_map_del_link() operates on both SOCKMAP and SOCKHASH, although
both types have member named "progs", the offset of "progs" member in
these two types is different, so "progs" should be accessed with the
real map type.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20230804073740.194770-2-xukuohai@huaweicloud.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock_map.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -148,13 +148,13 @@ static void sock_map_del_link(struct soc
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		if (link->link_raw == link_raw) {
 			struct bpf_map *map = link->map;
-			struct bpf_stab *stab = container_of(map, struct bpf_stab,
-							     map);
-			if (psock->saved_data_ready && stab->progs.stream_parser)
+			struct sk_psock_progs *progs = sock_map_progs(map);
+
+			if (psock->saved_data_ready && progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && stab->progs.stream_verdict)
+			if (psock->saved_data_ready && progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && stab->progs.skb_verdict)
+			if (psock->saved_data_ready && progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);


