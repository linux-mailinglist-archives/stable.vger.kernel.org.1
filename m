Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CED74C3C5
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjGILgH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjGILgG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E7198
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA0960BCC
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D71C433C8;
        Sun,  9 Jul 2023 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902564;
        bh=Aa6ybBovXgwBOTjt/BETc5rGGrLEYkMVeVsuSWTB3ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5zDXwZ0r/tPeknST9f0EfIc2e7stUMvQhwtGYX4DpNaodjgkV9h5RHhs/XZtH7aV
         eS7R4HwKcMyMzzfSmzcx4LCPelt/Qev4WK0dV5vA3ueS/ZqV/Ja0aV42BZVbtPZ7CE
         W6VlW5Psnm6Y0liVqb6feO/Qf6iMxRhkMBLAzX8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Triplett <josh@joshtriplett.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 421/431] kbuild: builddeb: always make modules_install, to install modules.builtin*
Date:   Sun,  9 Jul 2023 13:16:09 +0200
Message-ID: <20230709111501.055755783@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josh Triplett <josh@joshtriplett.org>

[ Upstream commit 4243afdb932677a03770753be8c54b3190a512e8 ]

Even for a non-modular kernel, the kernel builds modules.builtin and
modules.builtin.modinfo, with information about the built-in modules.
Tools such as initramfs-tools need these files to build a working
initramfs on some systems, such as those requiring firmware.

Now that `make modules_install` works even in non-modular kernels and
installs these files, unconditionally invoke it when building a Debian
package.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Stable-dep-of: 1240dabe8d58 ("kbuild: deb-pkg: remove the CONFIG_MODULES check in buildeb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/builddeb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 7b23f52c70c5f..07087ca68fe4b 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -62,8 +62,8 @@ install_linux_image () {
 		${MAKE} -f ${srctree}/Makefile INSTALL_DTBS_PATH="${pdir}/usr/lib/linux-image-${KERNELRELEASE}" dtbs_install
 	fi
 
+	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
 	if is_enabled CONFIG_MODULES; then
-		${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
 		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
 		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
 		if [ "${SRCARCH}" = um ] ; then
-- 
2.39.2



