Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5967E70CA11
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjEVTyg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjEVTyf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C39E95
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10EB262B6B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E44C433EF;
        Mon, 22 May 2023 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785273;
        bh=ZIhOo5a8ii1giV5C9jOVgmOnC11PTazzk8auFES1zyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prHi2oz6VAyBaQhkbXY23s/XkLAKhKiWZEMMjYGcBYMDH3RO8F1jt1UcDXd+Z0D8t
         ieAANJi+RXov9mPDa3FijTbTRUV08oegqirHJqibw3yR50Ev5IOA8w1k5wzl0lu4LM
         W2e4UA+RpXbPeIl5jeFO4+XLwBCYLMCKZSqHFr6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hari Bathini <hbathini@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.3 349/364] powerpc/bpf: populate extable entries only during the last pass
Date:   Mon, 22 May 2023 20:10:54 +0100
Message-Id: <20230522190421.510500235@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Hari Bathini <hbathini@linux.ibm.com>

commit 35a4b8ce4ac00e940b46b1034916ccb22ce9bdef upstream.

Since commit 85e031154c7c ("powerpc/bpf: Perform complete extra passes
to update addresses"), two additional passes are performed to avoid
space and CPU time wastage on powerpc. But these extra passes led to
WARN_ON_ONCE() hits in bpf_add_extable_entry() as extable entries are
populated again, during the extra pass, without resetting the index.
Fix it by resetting entry index before repopulating extable entries,
if and when there is an additional pass.

Fixes: 85e031154c7c ("powerpc/bpf: Perform complete extra passes to update addresses")
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230425065829.18189-1-hbathini@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/net/bpf_jit_comp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -101,6 +101,8 @@ struct bpf_prog *bpf_int_jit_compile(str
 		bpf_hdr = jit_data->header;
 		proglen = jit_data->proglen;
 		extra_pass = true;
+		/* During extra pass, ensure index is reset before repopulating extable entries */
+		cgctx.exentry_idx = 0;
 		goto skip_init_ctx;
 	}
 


