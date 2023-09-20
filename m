Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86C7A818A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjITMq0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjITMqZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:46:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF17FCE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309FAC433C8;
        Wed, 20 Sep 2023 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213978;
        bh=e8RhCdZTWtpvxEmMvpkp3bzrYGQdeS15XErtdtxFyUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3d+egxnsPZgEUl8M5QYg8a4pvKGhw7jO4HMbMYqjQ8fUuATc/PA2I/dahiccokiS
         bAnEHA3suznqvA0v0Bu0tt5Luek19dxp+D0N6p+Gz/LvcRDnhx/ikQrCeVwxWi0G+C
         ZUU2N7YlM9ynW0sYCed6UDnwKbYWn+zLPQAGS60U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 068/110] MIPS: Use "grep -E" instead of "egrep"
Date:   Wed, 20 Sep 2023 13:32:06 +0200
Message-ID: <20230920112832.966844403@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit d42f0c6ad502c9f612410e125ebdf290cce8bdc3 ]

The latest version of grep claims the egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the related file to use "grep -E" instead.

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Stable-dep-of: 4fe4a6374c4d ("MIPS: Only fiddle with CHECKFLAGS if `need-compiler'")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Makefile      | 2 +-
 arch/mips/vdso/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 151e98698f763..3830217fab414 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -323,7 +323,7 @@ KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef need-compiler
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
-	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
+	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif
 
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 1b2ea34c3d3bb..ed090ef30757c 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -68,7 +68,7 @@ KCOV_INSTRUMENT := n
 
 # Check that we don't have PIC 'jalr t9' calls left
 quiet_cmd_vdso_mips_check = VDSOCHK $@
-      cmd_vdso_mips_check = if $(OBJDUMP) --disassemble $@ | egrep -h "jalr.*t9" > /dev/null; \
+      cmd_vdso_mips_check = if $(OBJDUMP) --disassemble $@ | grep -E -h "jalr.*t9" > /dev/null; \
 		       then (echo >&2 "$@: PIC 'jalr t9' calls are not supported"; \
 			     rm -f $@; /bin/false); fi
 
-- 
2.40.1



