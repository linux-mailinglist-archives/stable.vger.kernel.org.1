Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBCB74C27E
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGILVM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGILVM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8E013D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DA9D60B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FC7C433C7;
        Sun,  9 Jul 2023 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901669;
        bh=aodLKqIfeAy7x8lErqPn0TghLwhLAwlY0omqe3ICSsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXwTHJ/fFWbnN59X1l5EOwkj+Kv1buV7tRsWAoojooI5+JCT/FnU5EZbn9kXWKkYH
         4yMpLYvO+j+L9W/2cay/aLZtWX1cFVbNNL39nCFjziPFE2S5j+HBRJ/us3No1nE7Wb
         H14VfXN9pRDTMVHJl+KkgnsDpZ7BwgpyMKBjnupA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Tariq Toukan <tariqt@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 103/431] samples/bpf: xdp1 and xdp2 reduce XDPBUFSIZE to 60
Date:   Sun,  9 Jul 2023 13:10:51 +0200
Message-ID: <20230709111453.572624716@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 60548b825b082cedf89b275c21c28b1e1d030e50 ]

Default samples/pktgen scripts send 60 byte packets as hardware adds
4-bytes FCS checksum, which fulfils minimum Ethernet 64 bytes frame
size.

XDP layer will not necessary have access to the 4-bytes FCS checksum.

This leads to bpf_xdp_load_bytes() failing as it tries to copy 64-bytes
from an XDP packet that only have 60-bytes available.

Fixes: 772251742262 ("samples/bpf: fixup some tools to be able to support xdp multibuffer")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/bpf/168545704139.2996228.2516528552939485216.stgit@firesoul
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/xdp1_kern.c | 2 +-
 samples/bpf/xdp2_kern.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/xdp1_kern.c b/samples/bpf/xdp1_kern.c
index 0a5c704badd00..d91f27cbcfa99 100644
--- a/samples/bpf/xdp1_kern.c
+++ b/samples/bpf/xdp1_kern.c
@@ -39,7 +39,7 @@ static int parse_ipv6(void *data, u64 nh_off, void *data_end)
 	return ip6h->nexthdr;
 }
 
-#define XDPBUFSIZE	64
+#define XDPBUFSIZE	60
 SEC("xdp.frags")
 int xdp_prog1(struct xdp_md *ctx)
 {
diff --git a/samples/bpf/xdp2_kern.c b/samples/bpf/xdp2_kern.c
index 67804ecf7ce37..8bca674451ed1 100644
--- a/samples/bpf/xdp2_kern.c
+++ b/samples/bpf/xdp2_kern.c
@@ -55,7 +55,7 @@ static int parse_ipv6(void *data, u64 nh_off, void *data_end)
 	return ip6h->nexthdr;
 }
 
-#define XDPBUFSIZE	64
+#define XDPBUFSIZE	60
 SEC("xdp.frags")
 int xdp_prog1(struct xdp_md *ctx)
 {
-- 
2.39.2



