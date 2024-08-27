Return-Path: <stable+bounces-70860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB501961066
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3980FB25D35
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B51C4EEC;
	Tue, 27 Aug 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C2un1pYs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057C1C5783;
	Tue, 27 Aug 2024 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771302; cv=none; b=ZLiUi/xgBwm8dJq2c7Zaymb4RV7cyVyp3lTobSH5O2BlUhrPCrtTWZ1RynkHo3S+YTpuQt6c6tlCKGwfmJYkGr1Yf2fC3X6l+4ADudpG+yR8rdE7Z1yJbDK96rmPmvPFglFfgCfNVGjgP95HWDD4kdgWQVw8bUKuLJ8ruUlIfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771302; c=relaxed/simple;
	bh=UeMeYboT1q57XjQZ+1216pdqY+1inKqJ0NBLOoF1W6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9U/w+v858DTZ3PL6YoatGr7A6EMDNVAYmrfA8Mx35muTsxfP6EzjyXCcHj0b0okuMu5lXg6Q8f1r0Xbb7LJi66LnFCIu+9D08hI7ZZfD2hJeGVmZhcRyHtp7D3eHXEINPVzt7mw/CYsDnuFO0EKamNk4lbxTjBRO42YLYeRioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C2un1pYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D52AC61074;
	Tue, 27 Aug 2024 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771301;
	bh=UeMeYboT1q57XjQZ+1216pdqY+1inKqJ0NBLOoF1W6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2un1pYsDtyMC9GjA3bMS6C9ga9zYj5lxJhFwX825NmidNk46d7vXY+rdOkYVdBl6
	 54UlkZNHPzPFJVrq1F73Rtbcx18f65KnLcGUtkL+obBH7QlNdZ++JRg2uh5Dbl1nfa
	 eAks+IQf5Px6gH4ehZo5gBRE0r/gk63us6l4M6IM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Courbot <gnurou@gmail.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 148/273] Makefile: add $(srctree) to dependency of compile_commands.json target
Date: Tue, 27 Aug 2024 16:37:52 +0200
Message-ID: <20240827143839.037198211@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Courbot <gnurou@gmail.com>

[ Upstream commit 6fc9aacad49e3fbecd270c266850d50c453d52ef ]

When trying to build compile_commands.json for an external module against
the kernel built in a separate output directory, the following error is
displayed:

  make[1]: *** No rule to make target 'scripts/clang-tools/gen_compile_commands.py',
  needed by 'compile_commands.json'. Stop.

This is because gen_compile_commands.py was previously looked up using a
relative path to $(srctree), but commit b1992c3772e6 ("kbuild: use
$(src) instead of $(srctree)/$(src) for source directory") stopped
defining VPATH for external module builds.

Prefixing gen_compile_commands.py with $(srctree) fixes the problem.

Fixes: b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src) for source directory")
Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 361a70264e1fb..194841a4efde9 100644
--- a/Makefile
+++ b/Makefile
@@ -1986,7 +1986,7 @@ nsdeps: modules
 quiet_cmd_gen_compile_commands = GEN     $@
       cmd_gen_compile_commands = $(PYTHON3) $< -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
 
-$(extmod_prefix)compile_commands.json: scripts/clang-tools/gen_compile_commands.py \
+$(extmod_prefix)compile_commands.json: $(srctree)/scripts/clang-tools/gen_compile_commands.py \
 	$(if $(KBUILD_EXTMOD),, vmlinux.a $(KBUILD_VMLINUX_LIBS)) \
 	$(if $(CONFIG_MODULES), $(MODORDER)) FORCE
 	$(call if_changed,gen_compile_commands)
-- 
2.43.0




