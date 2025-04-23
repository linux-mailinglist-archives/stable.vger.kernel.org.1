Return-Path: <stable+bounces-135374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A16A98DE9
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C244729A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDDE280CCE;
	Wed, 23 Apr 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5YaZ9o+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B83280A20;
	Wed, 23 Apr 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419755; cv=none; b=WpdZuz55jYKzm66WAEQilBRemLvNlx1XoH0VJr2yp7Zdq6EKQpJr1a0D3+GAhWM+gkLdAKefhaX451Y7jM0MJ4gJg8kkx6HAsM295V6Di5eGghJ56dmM9/u2n5kC1iNTMihVSqjs0nwutP8QEoDIUbQixMRxKeUINKdcbuQG8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419755; c=relaxed/simple;
	bh=VQCDqpo1MwV7z2S/chKURXu0lcLrgLgbLNEKjZEXu4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN0orJEaGMte3+xoTvoenPU6h6m1bq5VJyARjz4ht8EUhUAs2+jrA/6L51pESpt6gL0D9gbVlrceiwaRg/aU5AO+DwYW9C/b4LGdKbemCj6MgK12S2O7CdJEnfFW4qzwsKd+OpPPXnKvwhi/tSy3tohy+SQPW4DKkPYJtYBQbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5YaZ9o+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE87C4CEE2;
	Wed, 23 Apr 2025 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419755;
	bh=VQCDqpo1MwV7z2S/chKURXu0lcLrgLgbLNEKjZEXu4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5YaZ9o+8PasUhYQZ9mtELhWbvLNQu+/ECJxDiJUL2ESF/Yrqsqu17+r8346w7Xyj
	 kYszzO+zw2cFM/xBmQiU50zNAfnUMYwmDYO83jAvKU+y1BjDsDYFmulWYW3egenMAq
	 aHR6VZBL/tuaFdKvuYc3fOCsmBRgSN+ZydukmSwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 056/223] tools: ynl-gen: individually free previous values on double set
Date: Wed, 23 Apr 2025 16:42:08 +0200
Message-ID: <20250423142619.409588836@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ce6cb8113c842b94e77364b247c4f85c7b34e0c2 ]

When user calls request_attrA_set() multiple times (for the same
attribute), and attrA is of type which allocates memory -
we try to free the previously associated values. For array
types (including multi-attr) we have only freed the array,
but the array may have contained pointers.

Refactor the code generation for free attr and reuse the generated
lines in setters to flush out the previous state. Since setters
are static inlines in the header we need to add forward declarations
for the free helpers of pure nested structs. Track which types get
used by arrays and include the right forwad declarations.

At least ethtool string set and bit set would not be freed without
this. Tho, admittedly, overriding already set attribute twice is likely
a very very rare thing to do.

Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250414211851.602096-4-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 62 +++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 463f1394ab971..265a0ec0ef811 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -126,9 +126,15 @@ class Type(SpecAttr):
     def free_needs_iter(self):
         return False
 
-    def free(self, ri, var, ref):
+    def _free_lines(self, ri, var, ref):
         if self.is_multi_val() or self.presence_type() == 'len':
-            ri.cw.p(f'free({var}->{ref}{self.c_name});')
+            return [f'free({var}->{ref}{self.c_name});']
+        return []
+
+    def free(self, ri, var, ref):
+        lines = self._free_lines(ri, var, ref)
+        for line in lines:
+            ri.cw.p(line)
 
     def arg_member(self, ri):
         member = self._complex_member_type(ri)
@@ -224,6 +230,10 @@ class Type(SpecAttr):
         var = "req"
         member = f"{var}->{'.'.join(ref)}"
 
+        local_vars = []
+        if self.free_needs_iter():
+            local_vars += ['unsigned int i;']
+
         code = []
         presence = ''
         for i in range(0, len(ref)):
@@ -233,6 +243,10 @@ class Type(SpecAttr):
             if i == len(ref) - 1 and self.presence_type() != 'bit':
                 continue
             code.append(presence + ' = 1;')
+        ref_path = '.'.join(ref[:-1])
+        if ref_path:
+            ref_path += '.'
+        code += self._free_lines(ri, var, ref_path)
         code += self._setter_lines(ri, member, presence)
 
         func_name = f"{op_prefix(ri, direction, deref=deref)}_set_{'_'.join(ref)}"
@@ -240,7 +254,8 @@ class Type(SpecAttr):
         alloc = bool([x for x in code if 'alloc(' in x])
         if free and not alloc:
             func_name = '__' + func_name
-        ri.cw.write_func('static inline void', func_name, body=code,
+        ri.cw.write_func('static inline void', func_name, local_vars=local_vars,
+                         body=code,
                          args=[f'{type_name(ri, direction, deref=deref)} *{var}'] + self.arg_member(ri))
 
 
@@ -443,8 +458,7 @@ class TypeString(Type):
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"free({member});",
-                f"{presence}_len = strlen({self.c_name});",
+        return [f"{presence}_len = strlen({self.c_name});",
                 f"{member} = malloc({presence}_len + 1);",
                 f'memcpy({member}, {self.c_name}, {presence}_len);',
                 f'{member}[{presence}_len] = 0;']
@@ -490,8 +504,7 @@ class TypeBinary(Type):
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"free({member});",
-                f"{presence}_len = len;",
+        return [f"{presence}_len = len;",
                 f"{member} = malloc({presence}_len);",
                 f'memcpy({member}, {self.c_name}, {presence}_len);']
 
@@ -528,12 +541,14 @@ class TypeNest(Type):
     def _complex_member_type(self, ri):
         return self.nested_struct_type
 
-    def free(self, ri, var, ref):
+    def _free_lines(self, ri, var, ref):
+        lines = []
         at = '&'
         if self.is_recursive_for_op(ri):
             at = ''
-            ri.cw.p(f'if ({var}->{ref}{self.c_name})')
-        ri.cw.p(f'{self.nested_render_name}_free({at}{var}->{ref}{self.c_name});')
+            lines += [f'if ({var}->{ref}{self.c_name})']
+        lines += [f'{self.nested_render_name}_free({at}{var}->{ref}{self.c_name});']
+        return lines
 
     def _attr_typol(self):
         return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
@@ -586,15 +601,19 @@ class TypeMultiAttr(Type):
     def free_needs_iter(self):
         return 'type' not in self.attr or self.attr['type'] == 'nest'
 
-    def free(self, ri, var, ref):
+    def _free_lines(self, ri, var, ref):
+        lines = []
         if self.attr['type'] in scalars:
-            ri.cw.p(f"free({var}->{ref}{self.c_name});")
+            lines += [f"free({var}->{ref}{self.c_name});"]
         elif 'type' not in self.attr or self.attr['type'] == 'nest':
-            ri.cw.p(f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)")
-            ri.cw.p(f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name}[i]);')
-            ri.cw.p(f"free({var}->{ref}{self.c_name});")
+            lines += [
+                f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)",
+                f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name}[i]);',
+                f"free({var}->{ref}{self.c_name});",
+            ]
         else:
             raise Exception(f"Free of MultiAttr sub-type {self.attr['type']} not supported yet")
+        return lines
 
     def _attr_policy(self, policy):
         return self.base_type._attr_policy(policy)
@@ -620,8 +639,7 @@ class TypeMultiAttr(Type):
     def _setter_lines(self, ri, member, presence):
         # For multi-attr we have a count, not presence, hack up the presence
         presence = presence[:-(len('_present.') + len(self.c_name))] + "n_" + self.c_name
-        return [f"free({member});",
-                f"{member} = {self.c_name};",
+        return [f"{member} = {self.c_name};",
                 f"{presence} = n_{self.c_name};"]
 
 
@@ -706,6 +724,7 @@ class Struct:
         self.request = False
         self.reply = False
         self.recursive = False
+        self.in_multi_val = False  # used by a MultiAttr or and legacy arrays
 
         self.attr_list = []
         self.attrs = dict()
@@ -1071,6 +1090,10 @@ class Family(SpecFamily):
                     if attr in rs_members['reply']:
                         self.pure_nested_structs[nested].reply = True
 
+                if spec.is_multi_val():
+                    child = self.pure_nested_structs.get(nested)
+                    child.in_multi_val = True
+
         self._sort_pure_types()
 
         # Propagate the request / reply / recursive
@@ -1085,6 +1108,8 @@ class Family(SpecFamily):
                             struct.child_nests.update(child.child_nests)
                         child.request |= struct.request
                         child.reply |= struct.reply
+                        if spec.is_multi_val():
+                            child.in_multi_val = True
                 if attr_set in struct.child_nests:
                     struct.recursive = True
 
@@ -2794,6 +2819,9 @@ def main():
             for attr_set, struct in parsed.pure_nested_structs.items():
                 ri = RenderInfo(cw, parsed, args.mode, "", "", attr_set)
                 print_type_full(ri, struct)
+                if struct.request and struct.in_multi_val:
+                    free_rsp_nested_prototype(ri)
+                    cw.nl()
 
             for op_name, op in parsed.ops.items():
                 cw.p(f"/* ============== {op.enum_name} ============== */")
-- 
2.39.5




