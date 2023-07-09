Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198DF74C266
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGILUN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjGILUM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64B5130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B6FE60BCA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E64C433C7;
        Sun,  9 Jul 2023 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901610;
        bh=ra0ecAm9GDyk6lKFoXIankzZKDENIX6CFYXplPwUS7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtzrbfWx/m9y6HiG8amQXih1bybZla2TteVLmRE3/4FcKndQrtw6HuBEHabcqXJg8
         +Ya/YNhO63i682Z5lLxBvEllSlqdBAb/eABEv+zepkXRorjQAFIaie/lxhS33orh03
         lIoPhE7SUjKPQV6k5Dv0qfRwH6EGqDlLNasFm94c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pengcheng Yang <yangpc@wangsu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 081/431] samples/bpf: Fix buffer overflow in tcp_basertt
Date:   Sun,  9 Jul 2023 13:10:29 +0200
Message-ID: <20230709111453.050466473@linuxfoundation.org>
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

From: Pengcheng Yang <yangpc@wangsu.com>

[ Upstream commit f4dea9689c5fea3d07170c2cb0703e216f1a0922 ]

Using sizeof(nv) or strlen(nv)+1 is correct.

Fixes: c890063e4404 ("bpf: sample BPF_SOCKET_OPS_BASE_RTT program")
Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
Link: https://lore.kernel.org/r/1683276658-2860-1-git-send-email-yangpc@wangsu.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/tcp_basertt_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/tcp_basertt_kern.c b/samples/bpf/tcp_basertt_kern.c
index 8dfe09a92feca..822b0742b8154 100644
--- a/samples/bpf/tcp_basertt_kern.c
+++ b/samples/bpf/tcp_basertt_kern.c
@@ -47,7 +47,7 @@ int bpf_basertt(struct bpf_sock_ops *skops)
 		case BPF_SOCK_OPS_BASE_RTT:
 			n = bpf_getsockopt(skops, SOL_TCP, TCP_CONGESTION,
 					   cong, sizeof(cong));
-			if (!n && !__builtin_memcmp(cong, nv, sizeof(nv)+1)) {
+			if (!n && !__builtin_memcmp(cong, nv, sizeof(nv))) {
 				/* Set base_rtt to 80us */
 				rv = 80;
 			} else if (n) {
-- 
2.39.2



