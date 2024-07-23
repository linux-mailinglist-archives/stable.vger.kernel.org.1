Return-Path: <stable+bounces-60970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463A93A63A
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A2628182F
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050D156C6C;
	Tue, 23 Jul 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VcBa/xx5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8942067;
	Tue, 23 Jul 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759590; cv=none; b=IrJ+up8MWwstCrD11znRvp6EDGPKAPPyEcZ8AUzktMBuoMt12eNS/9slCvZMtqrlP115Jt/MyKKyYyrCUErHx4Xjip4ahtqLujwN2soxgDw+E1vAVWZBvO/hY6sc+A9UNE5On9hJFEPyAFFwjWhPcxhylAVpwGX2vtgem5J6tWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759590; c=relaxed/simple;
	bh=/riMaBp1GMzhYjKYy1GKoH7H9eIEdUj5bs5IqitGT28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQAUNCLuidjDUWIl0YooibBCDi3hrCoNFQ7fAVDFtuqA+uHkwtLLg5j3+Uc4aUrRmJttxVnzirzTv78I/cEljRqvYVwSqvhNVwWfXLEGupLllcg/yy9r5Z7GS+KLEvY3NMaEtVjun2h21Vw2835E7LRHRnAbF7yCeh9txNlzTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VcBa/xx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F648C4AF0A;
	Tue, 23 Jul 2024 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759590;
	bh=/riMaBp1GMzhYjKYy1GKoH7H9eIEdUj5bs5IqitGT28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VcBa/xx5zdNOuqMfmQPljN3lkgCe0JhM2Z0S6RfwPZfjbwO9+F3/tk+zZ7DMyMZdZ
	 p2eLks1tmvXpA1CgEgVOlC+7GnfnM6DhoGFQezOwPVJIwxAiPkPa/yR8BY54ceiblg
	 nbF9FZbDQSTH8Pn3yfBONggxOadpxwVjJhjPvVxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/129] kconfig: gconf: give a proper initial state to the Save button
Date: Tue, 23 Jul 2024 20:22:59 +0200
Message-ID: <20240723180405.993508916@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
References: <20240723180404.759900207@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 9709aca3a30fe..9e52c7360e55b 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -1478,7 +1478,6 @@ int main(int ac, char *av[])
 
 	conf_parse(name);
 	fixup_rootmenu(&rootmenu);
-	conf_read(NULL);
 
 	/* Load the interface and connect signals */
 	init_main_window(glade_file);
@@ -1486,6 +1485,8 @@ int main(int ac, char *av[])
 	init_left_tree();
 	init_right_tree();
 
+	conf_read(NULL);
+
 	switch (view_mode) {
 	case SINGLE_VIEW:
 		display_tree_part();
-- 
2.43.0




