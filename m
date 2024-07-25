Return-Path: <stable+bounces-61684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4574393C579
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B181F25D56
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661C19B5B5;
	Thu, 25 Jul 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DsVZwSXS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B28468;
	Thu, 25 Jul 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919109; cv=none; b=INZLwxsB/DWahde1GwJybuvA3ykQBVD6C6M2XGaFQsAwVwegV7+xNUjSnG1NPErcSyNVgzgLIfSwo8OnJ+OCN4eCuiXwFNaQ23lNVEvlSulbJqVPDu/Yw/yN63KiS4VJCtw+5887YROJu1I2+I5WwYhoi+L8hwRygetsSvwc6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919109; c=relaxed/simple;
	bh=a0ZJYzaKjLc/i/mdPBlodsHf/oJWnjR4dyUK1e/rHxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUaylfjmxRO/ZEhSmGQpXYGdcVnUGfTRUB0NSSm859AguImsvtn/Rk6Bm+rnml1cAqTufBR/5+vC/20ajLU1tiCNYzG8lOPqxq//FKOtYwXJbqdDQOXwhDd/SHBQFoGAZu9EB2Z/XFBJc8esLBCxKIBzyY+2M/n8/BT7pcydbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DsVZwSXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133AFC116B1;
	Thu, 25 Jul 2024 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721919109;
	bh=a0ZJYzaKjLc/i/mdPBlodsHf/oJWnjR4dyUK1e/rHxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsVZwSXSbjFcJw7mOajMp4kMrHEacViHLlUcLc0q+pwAkZbuip9XnZzxVUEiVIqf8
	 KBb5KXoZbVE6gt2QDY7PUz6yvoETxpQT4rQTYzGw0IRUBgM5V4wACnXN0b1QYHYOY9
	 DyHQU5pwQUYk/herdLdj33h+RjpXWePtJsa0vgLc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 26/87] kconfig: gconf: give a proper initial state to the Save button
Date: Thu, 25 Jul 2024 16:36:59 +0200
Message-ID: <20240725142739.423074698@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 46edf4372e336ef3a61c3126e49518099d2e2e6d ]

Currently, the initial state of the "Save" button is always active.

If none of the CONFIG options are changed while loading the .config
file, the "Save" button should be greyed out.

This can be fixed by calling conf_read() after widget initialization.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/gconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 17adabfd6e6bf..5d1404178e482 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -1481,7 +1481,6 @@ int main(int ac, char *av[])
 
 	conf_parse(name);
 	fixup_rootmenu(&rootmenu);
-	conf_read(NULL);
 
 	/* Load the interface and connect signals */
 	init_main_window(glade_file);
@@ -1489,6 +1488,8 @@ int main(int ac, char *av[])
 	init_left_tree();
 	init_right_tree();
 
+	conf_read(NULL);
+
 	switch (view_mode) {
 	case SINGLE_VIEW:
 		display_tree_part();
-- 
2.43.0




