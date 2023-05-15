Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96C770399A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbjEORoJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbjEORnr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD4315524
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F402D62E55
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9201C433EF;
        Mon, 15 May 2023 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172485;
        bh=hFs6H8U4vhH6vm2ONxBuoxMhFHoJU80DZCVmCwifdOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jIGJwMMBkaIX+U03gV6Y1EIjilVvoRmGo5JtSm/+S5OxJEeUwRWr/5lNyF3awTdU
         OYKqVe0XBvf9to+oGw0AQgIsDJk+Pts7SXnFH3TjZ0geYKrtOyhSViPpO7QARgH68W
         vXSDgMRCtM1o+ckm6BiQG4z2UR3/bToWdvwsc50w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 161/381] bpftool: Fix bug for long instructions in program CFG dumps
Date:   Mon, 15 May 2023 18:26:52 +0200
Message-Id: <20230515161744.080986921@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Quentin Monnet <quentin@isovalent.com>

[ Upstream commit 67cf52cdb6c8fa6365d29106555dacf95c9fd374 ]

When dumping the control flow graphs for programs using the 16-byte long
load instruction, we need to skip the second part of this instruction
when looking for the next instruction to process. Otherwise, we end up
printing "BUG_ld_00" from the kernel disassembler in the CFG.

Fixes: efcef17a6d65 ("tools: bpftool: generate .dot graph from CFG information")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Link: https://lore.kernel.org/r/20230405132120.59886-3-quentin@isovalent.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/xlated_dumper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 8608cd68cdd07..13d614b16f6c2 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -363,8 +363,15 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 	struct bpf_insn *insn_start = buf_start;
 	struct bpf_insn *insn_end = buf_end;
 	struct bpf_insn *cur = insn_start;
+	bool double_insn = false;
 
 	for (; cur <= insn_end; cur++) {
+		if (double_insn) {
+			double_insn = false;
+			continue;
+		}
+		double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);
+
 		printf("% 4d: ", (int)(cur - insn_start + start_idx));
 		print_bpf_insn(&cbs, cur, true);
 		if (cur != insn_end)
-- 
2.39.2



