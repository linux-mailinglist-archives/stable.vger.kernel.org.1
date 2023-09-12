Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFE79B7B6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376888AbjIKW0K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbjIKPFn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:05:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DE3125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:05:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D8AC433C8;
        Mon, 11 Sep 2023 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444738;
        bh=kbMPWfmq8dVOzkYgD2ADoEb32xA47LUj0fLIwnaww4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mm23hr5V0mFXO/BA/QaagoH+1YG9BrZsUqd/jcc5QumAbMwjhxyikav4etbtPPQrZ
         eKNJWOdcVJO5+IMHkUD74jxKmMLCXQTQh0W6P00gIqb06KPupmOqkPy2MeNIsgADo1
         PrkbLNC03GO6QMylfF3wfJ0jZHIoTER29uvhmhRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thorsten Leemhuis <linux@leemhuis.info>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.1 099/600] tools/resolve_btfids: Pass HOSTCFLAGS as EXTRA_CFLAGS to prepare targets
Date:   Mon, 11 Sep 2023 15:42:12 +0200
Message-ID: <20230911134636.525987145@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 2531ba0e4ae67d6d0219400af27805fe52cd28e8 upstream.

Thorsten reported build issue with command line that defined extra
HOSTCFLAGS that were not passed into 'prepare' targets, but were
used to build resolve_btfids objects.

This results in build fail when these objects are linked together:

  /usr/bin/ld: /build.../tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o):
  relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE \
  object; recompile with -fPIE

Fixing this by passing HOSTCFLAGS in EXTRA_CFLAGS as part of
HOST_OVERRIDES variable for prepare targets.

[1] https://lore.kernel.org/bpf/f7922132-6645-6316-5675-0ece4197bfff@leemhuis.info/

Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/bpf/20230209143735.4112845-1-jolsa@kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/bpf/resolve_btfids/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -19,7 +19,7 @@ endif
 
 # Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  CROSS_COMPILE=""
+		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
 HOSTCC  ?= gcc


