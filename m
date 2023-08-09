Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4F7759A2
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjHILCN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjHILCM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F51FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 055B663118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CE2C433C8;
        Wed,  9 Aug 2023 11:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578930;
        bh=MkjWwhlPWgLrOJ4MNuKArkGuM9h79tqyoDFgMaMk4h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKi+uphSfLI2+Xf8InhjZ5Mzy4eLuVDwrDhyJgwbum7OeUXo/z12I+erKpNimF64j
         o12FW53dKrroxyIdujwsy4MLCcaA0PAfUOeDvkYzEd0bNbDACR47gm5Dr5tMxdh6qh
         xuvD487u0Ale4SywdHvnCLRhBe3R4nk4TXoMCDHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Ahmed S. Darwish" <darwi@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4.14 006/204] scripts/tags.sh: Resolve gtags empty index generation
Date:   Wed,  9 Aug 2023 12:39:04 +0200
Message-ID: <20230809103642.773270455@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

commit e1b37563caffc410bb4b55f153ccb14dede66815 upstream.

gtags considers any file outside of its current working directory
"outside the source tree" and refuses to index it. For O= kernel builds,
or when "make" is invoked from a directory other then the kernel source
tree, gtags ignores the entire kernel source and generates an empty
index.

Force-set gtags current working directory to the kernel source tree.

Due to commit 9da0763bdd82 ("kbuild: Use relative path when building in
a subdir of the source tree"), if the kernel build is done in a
sub-directory of the kernel source tree, the kernel Makefile will set
the kernel's $srctree to ".." for shorter compile-time and run-time
warnings. Consequently, the list of files to be indexed will be in the
"../*" form, rendering all such paths invalid once gtags switches to the
kernel source tree as its current working directory.

If gtags indexing is requested and the build directory is not the kernel
source tree, index all files in absolute-path form.

Note, indexing in absolute-path form will not affect the generated
index, as paths in gtags indices are always relative to the gtags "root
directory" anyway (as evidenced by "gtags --dump").

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/tags.sh |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -37,6 +37,13 @@ find_all_archs()
 	done
 }
 
+# gtags(1) refuses to index any file outside of its current working dir.
+# If gtags indexing is requested and the build output directory is not
+# the kernel source tree, index all files in absolute-path form.
+if [[ "$1" == "gtags" && -n "${tree}" ]]; then
+	tree=$(realpath "$tree")/
+fi
+
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
 	ALLSOURCE_ARCHS=${SRCARCH}
@@ -145,7 +152,7 @@ docscope()
 
 dogtags()
 {
-	all_target_sources | gtags -i -f -
+	all_target_sources | gtags -i -C "${tree:-.}" -f - "$PWD"
 }
 
 # Basic regular expressions with an optional /kind-spec/ for ctags and


