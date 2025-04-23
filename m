Return-Path: <stable+bounces-136269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B8A99352
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5749257DA
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD728E5EE;
	Wed, 23 Apr 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Smxgc7ES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FA2BCF6B;
	Wed, 23 Apr 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422102; cv=none; b=LnBxfp2T9/4eqtDIg7BwRE764ZNZ8MBPMUCupLC89qrq1OAEOAQv0f7KBc7IAYVZYYLrB1iYz9wvnU1/gtiS2++8XAMAHqOjq7aDSLDw8ieINXa/zJY/cIPx8IL0fIBH+Zw5sjrsmFkABBBhEtdNJAaJFssAMCltuX19Ed2gVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422102; c=relaxed/simple;
	bh=iidWNBcLcJj2uSsQfHn+IrTz1R74qe1QGU7DrRrR5Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muD+G3cfb/ZVBjsJaazbNNJPTGlOK+CJmsDT2do9LfZIVU82nQwq3q4+2LjPlSAI/JSugnmVUsOUw0038oPb/dmlbIVNjWgcOUWuUz0VgO7mOwEELFvJvfkr3WI+MHAu4AxafE897q69WmfLmjCczA3+alV9XGbiVzBzNNrrVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Smxgc7ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE550C4CEE2;
	Wed, 23 Apr 2025 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422102;
	bh=iidWNBcLcJj2uSsQfHn+IrTz1R74qe1QGU7DrRrR5Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Smxgc7ESKnwD5KwURHEPr+P0T6j0H0Momr+Kp5YA+GDBeAD1hIKTs+PQrNIE28NfX
	 2mOcKku71mo5rmKFrX2cubqaNQFJPbgc8EQKIDXyiYB3f03xgOHUNEtop0YOHqMSwn
	 fxcHL1F1CG2A4wS/Q6bfc3gGITMQEaa4cA9ZpBt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 278/393] tools: ynl-gen: store recursive nests by a pointer
Date: Wed, 23 Apr 2025 16:42:54 +0200
Message-ID: <20250423142654.834165662@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 461f25a2e4334767d3e306b08dbda054da1aaa30 ]

To avoid infinite nesting store recursive structs by pointer.
If recursive struct is placed in the op directly - the first
instance can be stored by value. That makes the code much
less of a pain for majority of practical uses.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Link: https://lore.kernel.org/r/20231213231432.2944749-8-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: ce6cb8113c84 ("tools: ynl-gen: individually free previous values on double set")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 502d03b8a758a..9e37d14d76bf9 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -83,6 +83,9 @@ class Type(SpecAttr):
     def is_recursive(self):
         return False
 
+    def is_recursive_for_op(self, ri):
+        return self.is_recursive() and not ri.op
+
     def presence_type(self):
         return 'bit'
 
@@ -123,6 +126,8 @@ class Type(SpecAttr):
         member = self._complex_member_type(ri)
         if member:
             ptr = '*' if self.is_multi_val() else ''
+            if self.is_recursive_for_op(ri):
+                ptr = '*'
             ri.cw.p(f"{member} {ptr}{self.c_name};")
             return
         members = self.arg_member(ri)
@@ -450,7 +455,11 @@ class TypeNest(Type):
         return self.nested_struct_type
 
     def free(self, ri, var, ref):
-        ri.cw.p(f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name});')
+        at = '&'
+        if self.is_recursive_for_op(ri):
+            at = ''
+            ri.cw.p(f'if ({var}->{ref}{self.c_name})')
+        ri.cw.p(f'{self.nested_render_name}_free({at}{var}->{ref}{self.c_name});')
 
     def _attr_typol(self):
         return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
@@ -459,8 +468,9 @@ class TypeNest(Type):
         return 'NLA_POLICY_NESTED(' + self.nested_render_name + '_nl_policy)'
 
     def attr_put(self, ri, var):
+        at = '' if self.is_recursive_for_op(ri) else '&'
         self._attr_put_line(ri, var, f"{self.nested_render_name}_put(nlh, " +
-                            f"{self.enum_name}, &{var}->{self.c_name})")
+                            f"{self.enum_name}, {at}{var}->{self.c_name})")
 
     def _attr_get(self, ri, var):
         get_lines = [f"if ({self.nested_render_name}_parse(&parg, attr))",
@@ -473,6 +483,8 @@ class TypeNest(Type):
         ref = (ref if ref else []) + [self.c_name]
 
         for _, attr in ri.family.pure_nested_structs[self.nested_attrs].member_list():
+            if attr.is_recursive():
+                continue
             attr.setter(ri, self.nested_attrs, direction, deref=deref, ref=ref)
 
 
-- 
2.39.5




