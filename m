Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27695726DDE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjFGUq0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjFGUqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:46:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6C2D46
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E2D6468E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEDEC433D2;
        Wed,  7 Jun 2023 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170750;
        bh=jkrdTQWptxSm6fM4k/sllApfSf+nhlEKzgbTsbIhQaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKkbxvoHzJkqotvFjLXO7/yvFOZW+GXoNN1Z3hGw9SGwwUJngzcti8qR30yjl2QyE
         iRtN312gecJMzSO5x8FtcQazIPIvBDg+gkf3+yoZDOk4Vzy3fDWWHSmHEd3fbbHWIj
         cFDxBF4+hgSzrtiyzfX88pn70aCyZ0tn8RN0qqaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Onkarnath <onkarnath.1@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.1 203/225] powerpc/xmon: Use KSYM_NAME_LEN in array size
Date:   Wed,  7 Jun 2023 22:16:36 +0200
Message-ID: <20230607200921.004491506@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maninder Singh <maninder1.s@samsung.com>

commit 719dfd5925e186e09a2a6f23016936ac436f3d78 upstream.

kallsyms_lookup() which in turn calls kallsyms_lookup_buildid() writes
to index "KSYM_NAME_LEN - 1".

Thus the array passed as namebuf to kallsyms_lookup() should be
KSYM_NAME_LEN in size.

In xmon.c the array was defined to be "128" bytes directly, without
using KSYM_NAME_LEN. Commit b8a94bfb3395 ("kallsyms: increase maximum
kernel symbol length to 512") changed the value to 512, but missed
updating the xmon code.

Fixes: b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")
Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
[mpe: Tweak change log wording and fix commit reference]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230529111337.352990-2-maninder1.s@samsung.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/xmon/xmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -91,7 +91,7 @@ static unsigned long ndump = 64;
 static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
-static char tmpstr[128];
+static char tmpstr[KSYM_NAME_LEN];
 static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];


