Return-Path: <stable+bounces-177836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F19AB45D14
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB25BA41C70
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28231D730;
	Fri,  5 Sep 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BThGmdHG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AF31D72F
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087573; cv=none; b=mjY+8H8wBhRtK4igFmrthmnVH/CKhnbbuGmjH/8YVkTZIvE16BBbdD0r3GTdejBkZTO1BNP+PvLiQssuJtUGqntW4UhyHLMN1dNBcHiSF5w8N3GFdiVGF64BCAmxPbm3vUojWcum87/uJERsMXarhXsiTVKqbTneBjpWy+ES4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087573; c=relaxed/simple;
	bh=5zfXehV04vK8S3lIZxd+9kL1ZT+R4mmosbbnmr8qhbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rgo0Uc+wdjDSEvQxXP2gZuae1yZpRUFf3E9a3kIc1LajuJOq8VvSzWyutz3HCjzfmZd3DfbtcyHqmzcVcBqoWUmZDvkEf7UoiUylYpKCQBbmgla8RShDjg0n50iu3VuRMN31j9UuXG6CecmJQug+9KvWgPm3htRwsFKLvGi9Hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BThGmdHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D663EC4CEF1;
	Fri,  5 Sep 2025 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757087572;
	bh=5zfXehV04vK8S3lIZxd+9kL1ZT+R4mmosbbnmr8qhbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BThGmdHGBiO+gxvBemfQsDyL3+2bI5FAWI3t7DVAk3o8kRcXHibSnhQJ8BL/NeMl5
	 525MDujXJPDaW+QAe2YH0HPpWYPwFSCZ4TorGA/VyewU20yCYEmljM4wc+6B10x6Sa
	 6iEz6s5GzwBFqlSuoxPt4aXNGm6nthn0JuLVmpYc/oRekQ8SjHAf2q0gjKl5MndN5h
	 7HlQNdPHffiXmt38Jqmjhymoe4LR9DfawxMcug30LWkAB4uCwSij/KJ5URJ9Zin8To
	 iHR5Z9nVXW9Du/pRt9p+ZshUum5Zareqq7C3AMTBLZczhjPl2134mxLPcQdPvraGR5
	 qkrGNt9uOHnYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] randstruct: gcc-plugin: Remove bogus void member
Date: Fri,  5 Sep 2025 11:52:48 -0400
Message-ID: <20250905155250.1730294-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025060527-upwind-coveting-bcba@gregkh>
References: <2025060527-upwind-coveting-bcba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit e136a4062174a9a8d1c1447ca040ea81accfa6a8 ]

When building the randomized replacement tree of struct members, the
randstruct GCC plugin would insert, as the first member, a 0-sized void
member. This appears as though it was done to catch non-designated
("unnamed") static initializers, which wouldn't be stable since they
depend on the original struct layout order.

This was accomplished by having the side-effect of the "void member"
tripping an assert in GCC internals (count_type_elements) if the member
list ever needed to be counted (e.g. for figuring out the order of members
during a non-designated initialization), which would catch impossible type
(void) in the struct:

security/landlock/fs.c: In function ‘hook_file_ioctl_common’:
security/landlock/fs.c:1745:61: internal compiler error: in count_type_elements, at expr.cc:7075
 1745 |                         .u.op = &(struct lsm_ioctlop_audit) {
      |                                                             ^

static HOST_WIDE_INT
count_type_elements (const_tree type, bool for_ctor_p)
{
  switch (TREE_CODE (type))
...
    case VOID_TYPE:
    default:
      gcc_unreachable ();
    }
}

However this is a redundant safety measure since randstruct uses the
__designated_initializer attribute both internally and within the
__randomized_layout attribute macro so that this would be enforced
by the compiler directly even when randstruct was not enabled (via
-Wdesignated-init).

A recent change in Landlock ended up tripping the same member counting
routine when using a full-struct copy initializer as part of an anonymous
initializer. This, however, is a false positive as the initializer is
copying between identical structs (and hence identical layouts). The
"path" member is "struct path", a randomized struct, and is being copied
to from another "struct path", the "f_path" member:

        landlock_log_denial(landlock_cred(file->f_cred), &(struct landlock_request) {
                .type = LANDLOCK_REQUEST_FS_ACCESS,
                .audit = {
                        .type = LSM_AUDIT_DATA_IOCTL_OP,
                        .u.op = &(struct lsm_ioctlop_audit) {
                                .path = file->f_path,
                                .cmd = cmd,
                        },
                },
	...

As can be seen with the coming randstruct KUnit test, there appears to
be no behavioral problems with this kind of initialization when the void
member is removed from the randstruct GCC plugin, so remove it.

Reported-by: "Dr. David Alan Gilbert" <linux@treblig.org>
Closes: https://lore.kernel.org/lkml/Z_PRaKx7q70MKgCA@gallifrey/
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/lkml/20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org/
Reported-by: WangYuli <wangyuli@uniontech.com>
Closes: https://lore.kernel.org/lkml/337D5D4887277B27+3c677db3-a8b9-47f0-93a4-7809355f1381@uniontech.com/
Fixes: 313dd1b62921 ("gcc-plugins: Add the randstruct plugin")
Signed-off-by: Kees Cook <kees@kernel.org>
Stable-dep-of: f39f18f3c353 ("randstruct: gcc-plugin: Fix attribute addition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 60e9359a71a50..a8595df5fb6e8 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -377,29 +377,13 @@ static int relayout_struct(tree type)
 
 	shuffle(type, (tree *)newtree, shuffle_length);
 
-	/*
-	 * set up a bogus anonymous struct field designed to error out on unnamed struct initializers
-	 * as gcc provides no other way to detect such code
-	 */
-	list = make_node(FIELD_DECL);
-	TREE_CHAIN(list) = newtree[0];
-	TREE_TYPE(list) = void_type_node;
-	DECL_SIZE(list) = bitsize_zero_node;
-	DECL_NONADDRESSABLE_P(list) = 1;
-	DECL_FIELD_BIT_OFFSET(list) = bitsize_zero_node;
-	DECL_SIZE_UNIT(list) = size_zero_node;
-	DECL_FIELD_OFFSET(list) = size_zero_node;
-	DECL_CONTEXT(list) = type;
-	// to satisfy the constify plugin
-	TREE_READONLY(list) = 1;
-
 	for (i = 0; i < num_fields - 1; i++)
 		TREE_CHAIN(newtree[i]) = newtree[i+1];
 	TREE_CHAIN(newtree[num_fields - 1]) = NULL_TREE;
 
 	main_variant = TYPE_MAIN_VARIANT(type);
 	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant)) {
-		TYPE_FIELDS(variant) = list;
+		TYPE_FIELDS(variant) = newtree[0];
 		TYPE_ATTRIBUTES(variant) = copy_list(TYPE_ATTRIBUTES(variant));
 		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("randomize_performed"), NULL_TREE, TYPE_ATTRIBUTES(variant));
 		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("designated_init"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-- 
2.50.1


