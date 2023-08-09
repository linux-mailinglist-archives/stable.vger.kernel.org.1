Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF397758E9
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjHIK4A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjHIKzs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07322133
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6496B62BD5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764FAC433C8;
        Wed,  9 Aug 2023 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578532;
        bh=ylLkhy6v/PN4pPxa18l4YuTnftIaEcFyuOkG/iL8xTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8Gwd8kWCEKiiOoLX/CBfQ1dKY0koTQs/+TVJByp8xukmZlnz87B/ltEUOA73tonp
         kni3bpp9R58M2gGzHTS7rNVsLuWVFt0cZ4XIIvSxMtywiYI5gTjZvTxKIKUrbTuWkj
         Lf/N/N1iYr8vpVtiq+mV7aCC+NEKmfxPY9mfxu8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 093/127] open: make RESOLVE_CACHED correctly test for O_TMPFILE
Date:   Wed,  9 Aug 2023 12:41:20 +0200
Message-ID: <20230809103639.715540620@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aleksa Sarai <cyphar@cyphar.com>

commit a0fc452a5d7fed986205539259df1d60546f536c upstream.

O_TMPFILE is actually __O_TMPFILE|O_DIRECTORY. This means that the old
fast-path check for RESOLVE_CACHED would reject all users passing
O_DIRECTORY with -EAGAIN, when in fact the intended test was to check
for __O_TMPFILE.

Cc: stable@vger.kernel.org # v5.12+
Fixes: 99668f618062 ("fs: expose LOOKUP_CACHED through openat2() RESOLVE_CACHED")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Message-Id: <20230806-resolve_cached-o_tmpfile-v1-1-7ba16308465e@cyphar.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/open.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/open.c
+++ b/fs/open.c
@@ -1233,7 +1233,7 @@ inline int build_open_flags(const struct
 		lookup_flags |= LOOKUP_IN_ROOT;
 	if (how->resolve & RESOLVE_CACHED) {
 		/* Don't bother even trying for create/truncate/tmpfile open */
-		if (flags & (O_TRUNC | O_CREAT | O_TMPFILE))
+		if (flags & (O_TRUNC | O_CREAT | __O_TMPFILE))
 			return -EAGAIN;
 		lookup_flags |= LOOKUP_CACHED;
 	}


