Return-Path: <stable+bounces-61510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF95493C4B4
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72182B250A7
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF219D896;
	Thu, 25 Jul 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PEN+oPza"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1419D892;
	Thu, 25 Jul 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918546; cv=none; b=qYNsrIbQGql0wjaDow2Rag9/EIA8CzOVZI43s8Vt2erB1raz1J+sV7LZO04g1VyLp5OwwOF96tl2nEyX09F9r0nsnJQ70dKqxfHNaUeNEvLXBJvX+Nui9iJFEMRt7G6nrlBoxNBoRLAGYdKQ7B8zA14utbJGctuhH9XICaRGIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918546; c=relaxed/simple;
	bh=fJF/QONNE0LOjzIJblJUrQcCQkdS0y8+XpnNFZTae5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKAydU9CUTxyVs/DOLz1/NxBtFNKGter0Ca7hEy+GkfDBVTddifblMicVb/04GDxjXqkSYRokw9UKA4fGJirUOLfepjrISuQOyNk5vikZ1Pvn83mLgPkJyZXtWHl9fFAKJt08Esf77X0hciE7kjekx2xbDrAWuO8GFZ9zXaWssQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PEN+oPza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE1EC116B1;
	Thu, 25 Jul 2024 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918546;
	bh=fJF/QONNE0LOjzIJblJUrQcCQkdS0y8+XpnNFZTae5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEN+oPzaS00M7AeqHP2HdrMTz8gVfFnz8XiD5FrVMLt7/3DPiOXlCJwDbfnZmpr9k
	 qC4EarD7bGvBrLzITEfozR1ar9WzkgwvehuHYDt1oFn5oxdAjblsKYB+rB9eBgYf9s
	 EFjZjbyKIfK7JHftlfbOjslhIhE7dd1E+qB3+7dc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 10/43] kconfig: gconf: give a proper initial state to the Save button
Date: Thu, 25 Jul 2024 16:36:33 +0200
Message-ID: <20240725142730.863640337@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142730.471190017@linuxfoundation.org>
References: <20240725142730.471190017@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index e36b342f1065b..9b10f1248da11 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -1483,7 +1483,6 @@ int main(int ac, char *av[])
 
 	conf_parse(name);
 	fixup_rootmenu(&rootmenu);
-	conf_read(NULL);
 
 	/* Load the interface and connect signals */
 	init_main_window(glade_file);
@@ -1491,6 +1490,8 @@ int main(int ac, char *av[])
 	init_left_tree();
 	init_right_tree();
 
+	conf_read(NULL);
+
 	switch (view_mode) {
 	case SINGLE_VIEW:
 		display_tree_part();
-- 
2.43.0




