Return-Path: <stable+bounces-153343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A3ADD3D7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65FC161EEF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394D2EF2BE;
	Tue, 17 Jun 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uJe1xN8H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D92EF2AC;
	Tue, 17 Jun 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175643; cv=none; b=um8I45z8kNCmFTOHJBLZYCax4zYJuvg+KwVLnAMpv1fbUFRqI/gISb83/PQpp+oFkqIpuVKzD6iqXDivtN+MEg5dfBSg9q78Nkos6oL3/ht2z3pgIo+baKXUc2GBnIRynQxoCXwaUzkPRWftRixSIu+4eycDxYw5ay4bncTtuuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175643; c=relaxed/simple;
	bh=pCLxBwfFsdDLYDtiZ/dA1poSUugIKpVKqABoVjdtaWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUqep4GEy3oGmLMpq5meMPAwlzUpfjyabSh0RCOXtLZxJENHWx+MJ2EBtDfkFs6f6vetKALrjEShZyW7V7vyI4I4wGNX1Fa+2Mw40mQP1TfFE2s2u0QaJVKgWZbzcGzbCpw0jBXsT+8U5sy19zHCdXp/hTLRpaf6c8OEneXPV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uJe1xN8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295B7C4CEE7;
	Tue, 17 Jun 2025 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175642;
	bh=pCLxBwfFsdDLYDtiZ/dA1poSUugIKpVKqABoVjdtaWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJe1xN8HZFvUqBqY4XSQ0dNuhIISkRGZ0DGLxWPU3etQBfkze4E8wRGHQaOqTTzOs
	 d6L01+U/fRfbjSCUaq5sudR4UFtpTKbaEOnJDOyqJDIDFXUg4QP+QK/L8FrzkVA3lW
	 Byig+UvLLzZiy/Vr5Bb+hPUBO3aBTGEOChADKo7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 196/356] randstruct: gcc-plugin: Remove bogus void member
Date: Tue, 17 Jun 2025 17:25:11 +0200
Message-ID: <20250617152346.105748617@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 746ff2d272f25..bb8c6631971db 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -348,29 +348,13 @@ static int relayout_struct(tree type)
 
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
2.39.5




