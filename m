Return-Path: <stable+bounces-177837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9641B45D0C
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CFA18853D0
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082331D739;
	Fri,  5 Sep 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dokwhclD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34331D738
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087573; cv=none; b=WmP+uJ1FcobY6m9Y/wHgDYCyHdo0dFAp2K+4EV11DgQ93LMTxNj9dgrJYLL5V4jdZqMK7mQIEgKxiqtOUbZhiTc4YvJy4z4l4eXPhfVYafvy2twrgpJmdlDw7dwPtTUMrTwdm78vH3K1VRKFO2V22sHQDUf167mYWqaQiDR4mW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087573; c=relaxed/simple;
	bh=kbO1OPt6+l2qd93lrhpI9tx+txK3c/KXJMvnPLPBztI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTYQwC8q85UmXoBgMyKF76o5d/n/u2zZ2g1Ml1gHsXKbsWCnekcmrOMQ0qgklOvHhwa5dCgYk1apPaG88u7wy4dpaZY576hxqbiyyX2qOWB59H8BjgbRGba/eifxPVH9me8WHv6EXoErflkZDyxjOZ6ldHB/81MPwmVs8pg/xdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dokwhclD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF90C4CEF9;
	Fri,  5 Sep 2025 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757087573;
	bh=kbO1OPt6+l2qd93lrhpI9tx+txK3c/KXJMvnPLPBztI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dokwhclD9pP2BEiGX+FFavh9L9g7vJpXEwJ0lsXSGwGQBEN1qCTbbgzaNsP9GyxCm
	 pLNeYCwLNze2rkI1kNVemOnk2+kxwobX0EOzXQi3NEoAyNpZzNrH4L/LJ6sYSIVisq
	 5/0/n5R5oXUB+yNSBpPrRARmGhAneSDD5IU7+j/FvR0wO9buUh/2bz60hU9o5NmJm0
	 zE2EpQlco/Kv+q9YwAqoY80trpwApyILiRf0Igh0jz1QfN8LY9U7Gyd4vIO6zvgKYV
	 fp49LV2VmwjGXo6mQxYyY76Qp6BgKmAZIZ+zrHNlcnnHG37F8FkQHIiOrZogUcVELo
	 kIFmkLBj2dSJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ingo Saitz <ingo@hannover.ccc.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] randstruct: gcc-plugin: Fix attribute addition
Date: Fri,  5 Sep 2025 11:52:49 -0400
Message-ID: <20250905155250.1730294-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905155250.1730294-1-sashal@kernel.org>
References: <2025060527-upwind-coveting-bcba@gregkh>
 <20250905155250.1730294-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit f39f18f3c3531aa802b58a20d39d96e82eb96c14 ]

Based on changes in the 2021 public version of the randstruct
out-of-tree GCC plugin[1], more carefully update the attributes on
resulting decls, to avoid tripping checks in GCC 15's
comptypes_check_enum_int() when it has been configured with
"--enable-checking=misc":

arch/arm64/kernel/kexec_image.c:132:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1519
  132 | const struct kexec_file_ops kexec_image_ops = {
      |              ^~~~~~~~~~~~~~
 internal_error(char const*, ...), at gcc/gcc/diagnostic-global-context.cc:517
 fancy_abort(char const*, int, char const*), at gcc/gcc/diagnostic.cc:1803
 comptypes_check_enum_int(tree_node*, tree_node*, bool*), at gcc/gcc/c/c-typeck.cc:1519
 ...

Link: https://archive.org/download/grsecurity/grsecurity-3.1-5.10.41-202105280954.patch.gz [1]
Reported-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Closes: https://github.com/KSPP/linux/issues/367
Closes: https://lore.kernel.org/lkml/20250530000646.104457-1-thiago.bauermann@linaro.org/
Reported-by: Ingo Saitz <ingo@hannover.ccc.de>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1104745
Fixes: 313dd1b62921 ("gcc-plugins: Add the randstruct plugin")
Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Link: https://lore.kernel.org/r/20250530221824.work.623-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gcc-plugins/gcc-common.h              | 32 +++++++++++++++++++
 scripts/gcc-plugins/randomize_layout_plugin.c | 22 ++++++-------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index cba1440993450..8658e9d220b69 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -137,6 +137,38 @@ static inline tree build_const_char_string(int len, const char *str)
 	return cstr;
 }
 
+static inline void __add_type_attr(tree type, const char *attr, tree args)
+{
+	tree oldattr;
+
+	if (type == NULL_TREE)
+		return;
+	oldattr = lookup_attribute(attr, TYPE_ATTRIBUTES(type));
+	if (oldattr != NULL_TREE) {
+		gcc_assert(TREE_VALUE(oldattr) == args || TREE_VALUE(TREE_VALUE(oldattr)) == TREE_VALUE(args));
+		return;
+	}
+
+	TYPE_ATTRIBUTES(type) = copy_list(TYPE_ATTRIBUTES(type));
+	TYPE_ATTRIBUTES(type) = tree_cons(get_identifier(attr), args, TYPE_ATTRIBUTES(type));
+}
+
+static inline void add_type_attr(tree type, const char *attr, tree args)
+{
+	tree main_variant = TYPE_MAIN_VARIANT(type);
+
+	__add_type_attr(TYPE_CANONICAL(type), attr, args);
+	__add_type_attr(TYPE_CANONICAL(main_variant), attr, args);
+	__add_type_attr(main_variant, attr, args);
+
+	for (type = TYPE_NEXT_VARIANT(main_variant); type; type = TYPE_NEXT_VARIANT(type)) {
+		if (!lookup_attribute(attr, TYPE_ATTRIBUTES(type)))
+			TYPE_ATTRIBUTES(type) = TYPE_ATTRIBUTES(main_variant);
+
+		__add_type_attr(TYPE_CANONICAL(type), attr, args);
+	}
+}
+
 #define PASS_INFO(NAME, REF, ID, POS)		\
 struct register_pass_info NAME##_pass_info = {	\
 	.pass = make_##NAME##_pass(),		\
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index a8595df5fb6e8..24155ce812664 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -95,6 +95,9 @@ static tree handle_randomize_layout_attr(tree *node, tree name, tree args, int f
 
 	if (TYPE_P(*node)) {
 		type = *node;
+	} else if (TREE_CODE(*node) == FIELD_DECL) {
+		*no_add_attrs = false;
+		return NULL_TREE;
 	} else {
 		gcc_assert(TREE_CODE(*node) == TYPE_DECL);
 		type = TREE_TYPE(*node);
@@ -381,15 +384,14 @@ static int relayout_struct(tree type)
 		TREE_CHAIN(newtree[i]) = newtree[i+1];
 	TREE_CHAIN(newtree[num_fields - 1]) = NULL_TREE;
 
+	add_type_attr(type, "randomize_performed", NULL_TREE);
+	add_type_attr(type, "designated_init", NULL_TREE);
+	if (has_flexarray)
+		add_type_attr(type, "has_flexarray", NULL_TREE);
+
 	main_variant = TYPE_MAIN_VARIANT(type);
-	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant)) {
+	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant))
 		TYPE_FIELDS(variant) = newtree[0];
-		TYPE_ATTRIBUTES(variant) = copy_list(TYPE_ATTRIBUTES(variant));
-		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("randomize_performed"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("designated_init"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-		if (has_flexarray)
-			TYPE_ATTRIBUTES(type) = tree_cons(get_identifier("has_flexarray"), NULL_TREE, TYPE_ATTRIBUTES(type));
-	}
 
 	/*
 	 * force a re-layout of the main variant
@@ -457,10 +459,8 @@ static void randomize_type(tree type)
 	if (lookup_attribute("randomize_layout", TYPE_ATTRIBUTES(TYPE_MAIN_VARIANT(type))) || is_pure_ops_struct(type))
 		relayout_struct(type);
 
-	for (variant = TYPE_MAIN_VARIANT(type); variant; variant = TYPE_NEXT_VARIANT(variant)) {
-		TYPE_ATTRIBUTES(type) = copy_list(TYPE_ATTRIBUTES(type));
-		TYPE_ATTRIBUTES(type) = tree_cons(get_identifier("randomize_considered"), NULL_TREE, TYPE_ATTRIBUTES(type));
-	}
+	add_type_attr(type, "randomize_considered", NULL_TREE);
+
 #ifdef __DEBUG_PLUGIN
 	fprintf(stderr, "Marking randomize_considered on struct %s\n", ORIG_TYPE_NAME(type));
 #ifdef __DEBUG_VERBOSE
-- 
2.50.1


