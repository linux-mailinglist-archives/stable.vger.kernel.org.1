Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC68D77AD57
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHMVt2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjHMVs4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DE19AC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4EC6110F
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546C1C433C7;
        Sun, 13 Aug 2023 21:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962874;
        bh=xXFjVzXeG1U1HBgQhtEyEk4tWd/Tkl557R1e0nq47qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W53slKj8ShKhkFqLmV2n8ldGPgqQnkdN5iCSJ/GIo4noBHvNabm+NhsltP9harxTg
         gsVOwc0U+oPqyRTjWpAcnh2rHU7yzEQDGbHTnwZj8FqVRj6SPG9N68h9PETeXZmGQ4
         ZioZGHgzVqA/Vufbjk0BImYpKgH7od+9Q5bLlxDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 39/68] mISDN: Update parameter type of dsp_cmx_send()
Date:   Sun, 13 Aug 2023 23:19:40 +0200
Message-ID: <20230813211709.347864489@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
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

From: Nathan Chancellor <nathan@kernel.org>

commit 1696ec8654016dad3b1baf6c024303e584400453 upstream.

When booting a kernel with CONFIG_MISDN_DSP=y and CONFIG_CFI_CLANG=y,
there is a failure when dsp_cmx_send() is called indirectly from
call_timer_fn():

  [    0.371412] CFI failure at call_timer_fn+0x2f/0x150 (target: dsp_cmx_send+0x0/0x530; expected type: 0x92ada1e9)

The function pointer prototype that call_timer_fn() expects is

  void (*fn)(struct timer_list *)

whereas dsp_cmx_send() has a parameter type of 'void *', which causes
the control flow integrity checks to fail because the parameter types do
not match.

Change dsp_cmx_send()'s parameter type to be 'struct timer_list' to
match the expected prototype. The argument is unused anyways, so this
has no functional change, aside from avoiding the CFI failure.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308020936.58787e6c-oliver.sang@intel.com
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Fixes: e313ac12eb13 ("mISDN: Convert timers to use timer_setup()")
Link: https://lore.kernel.org/r/20230802-fix-dsp_cmx_send-cfi-failure-v1-1-2f2e79b0178d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/mISDN/dsp.h      |    2 +-
 drivers/isdn/mISDN/dsp_cmx.c  |    2 +-
 drivers/isdn/mISDN/dsp_core.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/isdn/mISDN/dsp.h
+++ b/drivers/isdn/mISDN/dsp.h
@@ -247,7 +247,7 @@ extern void dsp_cmx_hardware(struct dsp_
 extern int dsp_cmx_conf(struct dsp *dsp, u32 conf_id);
 extern void dsp_cmx_receive(struct dsp *dsp, struct sk_buff *skb);
 extern void dsp_cmx_hdlc(struct dsp *dsp, struct sk_buff *skb);
-extern void dsp_cmx_send(void *arg);
+extern void dsp_cmx_send(struct timer_list *arg);
 extern void dsp_cmx_transmit(struct dsp *dsp, struct sk_buff *skb);
 extern int dsp_cmx_del_conf_member(struct dsp *dsp);
 extern int dsp_cmx_del_conf(struct dsp_conf *conf);
--- a/drivers/isdn/mISDN/dsp_cmx.c
+++ b/drivers/isdn/mISDN/dsp_cmx.c
@@ -1625,7 +1625,7 @@ static u16	dsp_count; /* last sample cou
 static int	dsp_count_valid; /* if we have last sample count */
 
 void
-dsp_cmx_send(void *arg)
+dsp_cmx_send(struct timer_list *arg)
 {
 	struct dsp_conf *conf;
 	struct dsp_conf_member *member;
--- a/drivers/isdn/mISDN/dsp_core.c
+++ b/drivers/isdn/mISDN/dsp_core.c
@@ -1200,7 +1200,7 @@ static int __init dsp_init(void)
 	}
 
 	/* set sample timer */
-	timer_setup(&dsp_spl_tl, (void *)dsp_cmx_send, 0);
+	timer_setup(&dsp_spl_tl, dsp_cmx_send, 0);
 	dsp_spl_tl.expires = jiffies + dsp_tics;
 	dsp_spl_jiffies = dsp_spl_tl.expires;
 	add_timer(&dsp_spl_tl);


