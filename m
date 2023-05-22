Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDAF70C61C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjEVTPM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjEVTPE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:15:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB1910D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF02062742
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B53C433D2;
        Mon, 22 May 2023 19:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782899;
        bh=gWcA2/j5JZGlFbqhbj+OujreXgVjsxiQubZ1yW1+vQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JC6FNc9Yw1mkvyGxOWEP5gBBs9Ww7qu8H+HcCivYUJxtlqhc+e3lUhuuxUMtDbc3j
         7cWNlgaebMapDi1r0TNBGVFSSGJNoTlHNxZqBvijBWWz/Qaza+tY1LYAmnGLF6KI0z
         w/lCuHSOXsSP5EFg6sU76MoevPuHgnWPnPsGyNc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Zeng <zenghao@kylinos.cn>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/203] samples/bpf: Fix fout leak in hbms run_bpf_prog
Date:   Mon, 22 May 2023 20:08:10 +0100
Message-Id: <20230522190356.818952959@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Hao Zeng <zenghao@kylinos.cn>

[ Upstream commit 23acb14af1914010dd0aae1bbb7fab28bf518b8e ]

Fix fout being fopen'ed but then not subsequently fclose'd. In the affected
branch, fout is otherwise going out of scope.

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230411084349.1999628-1-zenghao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/hbm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index b0c18efe7928e..a271099603feb 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -308,6 +308,7 @@ static int run_bpf_prog(char *prog, int cg_id)
 		fout = fopen(fname, "w");
 		fprintf(fout, "id:%d\n", cg_id);
 		fprintf(fout, "ERROR: Could not lookup queue_stats\n");
+		fclose(fout);
 	} else if (stats_flag && qstats.lastPacketTime >
 		   qstats.firstPacketTime) {
 		long long delta_us = (qstats.lastPacketTime -
-- 
2.39.2



