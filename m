Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B707554D6
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjGPUet (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGPUes (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873BCBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:34:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264C060EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E71C433C8;
        Sun, 16 Jul 2023 20:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539686;
        bh=2vJkdluu4T7Octu3p1FPWdkQ/m7rdK+h2dFwYjeNKgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tL23BeYw/TXXD7xy0FNyrBBAQ5tA+EPbTnPsBeD4ElXXT0n+v/keIQa/SvpTdFjgl
         xoaJwj71xNwDfWYUj8xuJl3mFt7OcEuftBjkQJZTLLlMs5JcHeWQRdPTs/ZPYyBiFM
         z/YtGTxbkj7YXAAXdUnOJFqUHI7/7cBvTkPDtinY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@corigine.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 095/591] selftests/bpf: Fix check_mtu using wrong variable type
Date:   Sun, 16 Jul 2023 21:43:54 +0200
Message-ID: <20230716194926.335716478@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 095641817e1bf6aa2560e025e47575188ee3edaf ]

Dan Carpenter found via Smatch static checker, that unsigned 'mtu_lo' is
never less than zero.

Variable mtu_lo should have been an 'int', because read_mtu_device_lo()
uses minus as error indications.

Fixes: b62eba563229 ("selftests/bpf: Tests using bpf_check_mtu BPF-helper")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/bpf/168605104733.3636467.17945947801753092590.stgit@firesoul
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/check_mtu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
index 12f4395f18b37..a756760a45edb 100644
--- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
+++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
@@ -183,7 +183,7 @@ static void test_check_mtu_tc(__u32 mtu, __u32 ifindex)
 
 void serial_test_check_mtu(void)
 {
-	__u32 mtu_lo;
+	int mtu_lo;
 
 	if (test__start_subtest("bpf_check_mtu XDP-attach"))
 		test_check_mtu_xdp_attach();
-- 
2.39.2



