Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8575CE19
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGUQSM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGUQRr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:17:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F372D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DF861D29
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B925C433C7;
        Fri, 21 Jul 2023 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956198;
        bh=dyKuhQhlV5d3kAXSRkCM3nRbTQ32/vgTiYLr9H2YHjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kt2wXfjyf1PbjsnRoJ3rEeVFf9CrsPA0DoZvvlyxo0GsZ4K1YOjfG6I8kvDWGFrm4
         OrVdFo+vOJy3vnzEtLBFpEvTr0s5gRgfvD/4VS/kRwYbf7+s0h4P4zxY5heDtpiW4p
         aMgFIfVuM9mJ5I8RsYAqbMS6iegWFdgAR/k4td5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joel Stanley <joel@jms.id.au>,
        Naveen N Rao <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.4 141/292] powerpc: Fail build if using recordmcount with binutils v2.37
Date:   Fri, 21 Jul 2023 18:04:10 +0200
Message-ID: <20230721160534.922058559@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Naveen N Rao <naveen@kernel.org>

commit 25ea739ea1d4d3de41acc4f4eb2d1a97eee0eb75 upstream.

binutils v2.37 drops unused section symbols, which prevents recordmcount
from capturing mcount locations in sections that have no non-weak
symbols. This results in a build failure with a message such as:
	Cannot find symbol for section 12: .text.perf_callchain_kernel.
	kernel/events/callchain.o: failed

The change to binutils was reverted for v2.38, so this behavior is
specific to binutils v2.37:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=c09c8b42021180eee9495bd50d8b35e683d3901b

Objtool is able to cope with such sections, so this issue is specific to
recordmcount.

Fail the build and print a warning if binutils v2.37 is detected and if
we are using recordmcount.

Cc: stable@vger.kernel.org
Suggested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230530061436.56925-1-naveen@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Makefile |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -409,3 +409,11 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
+	@if test "x${CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT}" = "xy" -a \
+		"x${CONFIG_LD_IS_BFD}" = "xy" -a \
+		"${CONFIG_LD_VERSION}" = "23700" ; then \
+		echo -n '*** binutils 2.37 drops unused section symbols, which recordmcount ' ; \
+		echo 'is unable to handle.' ; \
+		echo '*** Please use a different binutils version.' ; \
+		false ; \
+	fi


