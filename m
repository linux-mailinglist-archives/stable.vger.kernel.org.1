Return-Path: <stable+bounces-178135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40B5B47D64
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39547B0012
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4010E27F754;
	Sun,  7 Sep 2025 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C4B/JNXe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F251CDFAC;
	Sun,  7 Sep 2025 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275877; cv=none; b=NX8Vsv+fuYtVJVv2rdQvy49kEEV4IdzI0abeq4yFLc959WnZME7bFbJPi517sE6kK98Na9TUKWznLrKCrxrJYQzRHCZCIaYIgssFs7zbEFzBVLypRJf7p9wcqjCOpwR+ipN1umvRa9/Lxn731DadLhs01M1YwjcWcrwb4VWjkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275877; c=relaxed/simple;
	bh=TWrgYwLb5cGRN9C3izxWzylDlnVbFy30G4Ri5olK7hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcrCbsVdTSuXHFQ5bQpvrXjYyCUC41xJp2tyeWjfXmCY/EBAPnrynMkfhAUCAqDcmLwmp89BsX/oTVM+JPMFQsycXFKWzkaro7IhdZSF4h8nUVXYlT0oxnbNRbhEFK6ogNo4MAKtVmsVdpYmPmeyrU5ETYB7MajrlLYIs77DD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C4B/JNXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AF5C4CEF0;
	Sun,  7 Sep 2025 20:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757275876;
	bh=TWrgYwLb5cGRN9C3izxWzylDlnVbFy30G4Ri5olK7hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4B/JNXe0nXr0AzrYUP5Q1cBUtlAH6eEOsL30Oo5fFk+8U/gNWNY5hgFJTksdIX01
	 6t5UhASCsFs9+WEG5O5mb2JyGqPmDGA+yHNgTBYc8m2xqcy5zyN2Pi/DYPmPhrYrXl
	 Cqj/jTv9ESvrKP5s+qLzcnQzVAwQqDEKn1Z9+1bo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 37/45] randstruct: gcc-plugin: Remove bogus void member
Date: Sun,  7 Sep 2025 21:58:23 +0200
Message-ID: <20250907195602.071212376@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195600.953058118@linuxfoundation.org>
References: <20250907195600.953058118@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

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



