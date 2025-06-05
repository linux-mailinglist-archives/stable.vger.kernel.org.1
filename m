Return-Path: <stable+bounces-151503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C8ACEC3A
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 10:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14C51898C6D
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CB520F08C;
	Thu,  5 Jun 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EYseanAe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92120E007
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113020; cv=none; b=BuLjIlDAVkBkz7lI3ikuS4vkUDa85rgju7+x8jlWUxroxY6gEFgRWxET1b4Klx2MklxNg4EECO+FWDbNYa+bxCKrwu2mTUaKy5p7OxUUqd9zXkQ2gDDQNlvMfgGDY2e05PEoWcuKdTccYGjeJG9DOdj9376+2+y2/MusXvpBq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113020; c=relaxed/simple;
	bh=2RQxWuBdjyL9USTmMv5uU7D3LQPb6uOXmgdUS4Hv9II=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UBVO4TudSQUzuHx0MoUbX3a8vhlunG6Dr1phn+3TsZz9vJ7gQOyrgO9EszpnWZSgnJl0N5th400+OiT4tCP9XS0nwiNQxCyjJLxuD9a6lLFb+wuhjbEHZENp82ZYm9WTmcd8QxyNy7919rN6kadHKs5LvsPSjhH9jFaXhR7YycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EYseanAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A31EC4CEE7;
	Thu,  5 Jun 2025 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749113020;
	bh=2RQxWuBdjyL9USTmMv5uU7D3LQPb6uOXmgdUS4Hv9II=;
	h=Subject:To:Cc:From:Date:From;
	b=EYseanAelcaGHgSCLW9+5mNTSAhywv/jv2vtq0JtkFD7gKudGl02ffgc71DhB6eUk
	 /cvHy6FXVTawJEzxqmAYH6d4v9AVfg+2uVdOPFdmrl0XipvQ8brD8NuWaWTC9qgE5A
	 znY+WaGcOg/FiRr6cnyanXsXUQDJ1SdK//pZzlJI=
Subject: FAILED: patch "[PATCH] randstruct: gcc-plugin: Fix attribute addition" failed to apply to 5.15-stable tree
To: kees@kernel.org,ingo@hannover.ccc.de,thiago.bauermann@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 05 Jun 2025 10:43:27 +0200
Message-ID: <2025060527-upwind-coveting-bcba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f39f18f3c3531aa802b58a20d39d96e82eb96c14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060527-upwind-coveting-bcba@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f39f18f3c3531aa802b58a20d39d96e82eb96c14 Mon Sep 17 00:00:00 2001
From: Kees Cook <kees@kernel.org>
Date: Fri, 30 May 2025 15:18:28 -0700
Subject: [PATCH] randstruct: gcc-plugin: Fix attribute addition

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

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 3222c1070444..ef12c8f929ed 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -123,6 +123,38 @@ static inline tree build_const_char_string(int len, const char *str)
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
index 971a1908a8cc..ff65a4f87f24 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -73,6 +73,9 @@ static tree handle_randomize_layout_attr(tree *node, tree name, tree args, int f
 
 	if (TYPE_P(*node)) {
 		type = *node;
+	} else if (TREE_CODE(*node) == FIELD_DECL) {
+		*no_add_attrs = false;
+		return NULL_TREE;
 	} else {
 		gcc_assert(TREE_CODE(*node) == TYPE_DECL);
 		type = TREE_TYPE(*node);
@@ -348,15 +351,14 @@ static int relayout_struct(tree type)
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
@@ -424,10 +426,8 @@ static void randomize_type(tree type)
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


