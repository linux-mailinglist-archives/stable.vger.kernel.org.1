Return-Path: <stable+bounces-11884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D08316A8
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269661F241F2
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A8E208C9;
	Thu, 18 Jan 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNZc+slF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5D208A6
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573784; cv=none; b=pQJ1wZdWqUB9rJYPnlXw3qWrEq/MGZBlZ+5FJ2IK+HThjyAcCLymOfuVkoO3nm2axqSZzFmdjuJ0gHsiUeXJ8C3q4YVcxUDsP4PG0hsK3R+7pt5LFXKjECl7xSJPRWM6mbfCymH6KJZL4/Gt5mNO56wZf/PqFwAmh6sncp/v2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573784; c=relaxed/simple;
	bh=2x2XY7N9FxXJ/ZPylbPkVSx8Rel+LldA9W5ttsAAvk8=;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=KJxAw+DFOzcySUPQXhAfiY/VRgRX1hDTQASuzSQkrO3uXeAZCFS9TdNu7hIztmyzBz40C2pEiUb6or3nMXmqI96jUS6CkFDX0waQd2kePzRnoHAaN3X4VGdr7B+tHQKzOWv/P/47x0jBlVZOUnfFAbNSgNni15s5AYVpt3UBU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNZc+slF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004E6C433F1;
	Thu, 18 Jan 2024 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705573783;
	bh=2x2XY7N9FxXJ/ZPylbPkVSx8Rel+LldA9W5ttsAAvk8=;
	h=Subject:To:Cc:From:Date:From;
	b=cNZc+slFBPQ6kYfuQBD5XnUh/A561Y7tG2/iokPQ/ZkXmIsnGAD75nc7Bsyvkr2F1
	 UeKn+egDCiqdrf4upG79hcpR4pOTp256tgNcpj5dGe9Dc6AQhi57XpJF7MnezG86bD
	 GXMczUdmY5Msbm/nj2V+bahnJd6b1DC0f+eiRYok=
Subject: FAILED: patch "[PATCH] docs: kernel_feat.py: fix potential command injection" failed to apply to 6.1-stable tree
To: vegard.nossum@oracle.com,corbet@lwn.net,jani.nikula@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 18 Jan 2024 11:29:32 +0100
Message-ID: <2024011832-stadium-anew-7be3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c48a7c44a1d02516309015b6134c9bb982e17008
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024011832-stadium-anew-7be3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c48a7c44a1d0 ("docs: kernel_feat.py: fix potential command injection")
f949cb759051 ("docs/zh_TW: update contents for zh_TW")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")
c9ad95adc096 ("docs: sparse: add sparse.rst to toctree")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c48a7c44a1d02516309015b6134c9bb982e17008 Mon Sep 17 00:00:00 2001
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Jan 2024 18:47:58 +0100
Subject: [PATCH] docs: kernel_feat.py: fix potential command injection

The kernel-feat directive passes its argument straight to the shell.
This is unfortunate and unnecessary.

Let's always use paths relative to $srctree/Documentation/ and use
subprocess.check_call() instead of subprocess.Popen(shell=True).

This also makes the code shorter.

This is analogous to commit 3231dd586277 ("docs: kernel_abi.py: fix
command injection") where we did exactly the same thing for
kernel_abi.py, somehow I completely missed this one.

Link: https://fosstodon.org/@jani/111676532203641247
Reported-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/r/20240110174758.3680506-1-vegard.nossum@oracle.com

diff --git a/Documentation/admin-guide/features.rst b/Documentation/admin-guide/features.rst
index 8c167082a84f..7651eca38227 100644
--- a/Documentation/admin-guide/features.rst
+++ b/Documentation/admin-guide/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features
+.. kernel-feat:: features
diff --git a/Documentation/arch/arc/features.rst b/Documentation/arch/arc/features.rst
index b793583d688a..49ff446ff744 100644
--- a/Documentation/arch/arc/features.rst
+++ b/Documentation/arch/arc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features arc
+.. kernel-feat:: features arc
diff --git a/Documentation/arch/arm/features.rst b/Documentation/arch/arm/features.rst
index 7414ec03dd15..0e76aaf68eca 100644
--- a/Documentation/arch/arm/features.rst
+++ b/Documentation/arch/arm/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features arm
+.. kernel-feat:: features arm
diff --git a/Documentation/arch/arm64/features.rst b/Documentation/arch/arm64/features.rst
index dfa4cb3cd3ef..03321f4309d0 100644
--- a/Documentation/arch/arm64/features.rst
+++ b/Documentation/arch/arm64/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features arm64
+.. kernel-feat:: features arm64
diff --git a/Documentation/arch/loongarch/features.rst b/Documentation/arch/loongarch/features.rst
index ebacade3ea45..009f44c7951f 100644
--- a/Documentation/arch/loongarch/features.rst
+++ b/Documentation/arch/loongarch/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features loongarch
+.. kernel-feat:: features loongarch
diff --git a/Documentation/arch/m68k/features.rst b/Documentation/arch/m68k/features.rst
index 5107a2119472..de7f0ccf7fc8 100644
--- a/Documentation/arch/m68k/features.rst
+++ b/Documentation/arch/m68k/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features m68k
+.. kernel-feat:: features m68k
diff --git a/Documentation/arch/mips/features.rst b/Documentation/arch/mips/features.rst
index 1973d729b29a..6e0ffe3e7354 100644
--- a/Documentation/arch/mips/features.rst
+++ b/Documentation/arch/mips/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features mips
+.. kernel-feat:: features mips
diff --git a/Documentation/arch/nios2/features.rst b/Documentation/arch/nios2/features.rst
index 8449e63f69b2..89913810ccb5 100644
--- a/Documentation/arch/nios2/features.rst
+++ b/Documentation/arch/nios2/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features nios2
+.. kernel-feat:: features nios2
diff --git a/Documentation/arch/openrisc/features.rst b/Documentation/arch/openrisc/features.rst
index 3f7c40d219f2..bae2e25adfd6 100644
--- a/Documentation/arch/openrisc/features.rst
+++ b/Documentation/arch/openrisc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features openrisc
+.. kernel-feat:: features openrisc
diff --git a/Documentation/arch/parisc/features.rst b/Documentation/arch/parisc/features.rst
index 501d7c450037..b3aa4d243b93 100644
--- a/Documentation/arch/parisc/features.rst
+++ b/Documentation/arch/parisc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features parisc
+.. kernel-feat:: features parisc
diff --git a/Documentation/arch/powerpc/features.rst b/Documentation/arch/powerpc/features.rst
index aeae73df86b0..ee4b95e04202 100644
--- a/Documentation/arch/powerpc/features.rst
+++ b/Documentation/arch/powerpc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features powerpc
+.. kernel-feat:: features powerpc
diff --git a/Documentation/arch/riscv/features.rst b/Documentation/arch/riscv/features.rst
index c70ef6ac2368..36e90144adab 100644
--- a/Documentation/arch/riscv/features.rst
+++ b/Documentation/arch/riscv/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features riscv
+.. kernel-feat:: features riscv
diff --git a/Documentation/arch/s390/features.rst b/Documentation/arch/s390/features.rst
index 57c296a9d8f3..2883dc950681 100644
--- a/Documentation/arch/s390/features.rst
+++ b/Documentation/arch/s390/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features s390
+.. kernel-feat:: features s390
diff --git a/Documentation/arch/sh/features.rst b/Documentation/arch/sh/features.rst
index f722af3b6c99..fae48fe81e9b 100644
--- a/Documentation/arch/sh/features.rst
+++ b/Documentation/arch/sh/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features sh
+.. kernel-feat:: features sh
diff --git a/Documentation/arch/sparc/features.rst b/Documentation/arch/sparc/features.rst
index c0c92468b0fe..96835b6d598a 100644
--- a/Documentation/arch/sparc/features.rst
+++ b/Documentation/arch/sparc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features sparc
+.. kernel-feat:: features sparc
diff --git a/Documentation/arch/x86/features.rst b/Documentation/arch/x86/features.rst
index b663f15053ce..a33616346a38 100644
--- a/Documentation/arch/x86/features.rst
+++ b/Documentation/arch/x86/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features x86
+.. kernel-feat:: features x86
diff --git a/Documentation/arch/xtensa/features.rst b/Documentation/arch/xtensa/features.rst
index 6b92c7bfa19d..28dcce1759be 100644
--- a/Documentation/arch/xtensa/features.rst
+++ b/Documentation/arch/xtensa/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features xtensa
+.. kernel-feat:: features xtensa
diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index b5fa2f0542a5..b9df61eb4501 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -37,8 +37,6 @@ import re
 import subprocess
 import sys
 
-from os import path
-
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
@@ -76,33 +74,26 @@ class KernelFeat(Directive):
         self.state.document.settings.env.app.warn(message, prefix="")
 
     def run(self):
-
         doc = self.state.document
         if not doc.settings.file_insertion_enabled:
             raise self.warning("docutils: file insertion disabled")
 
         env = doc.settings.env
-        cwd = path.dirname(doc.current_source)
-        cmd = "get_feat.pl rest --enable-fname --dir "
-        cmd += self.arguments[0]
+
+        srctree = os.path.abspath(os.environ["srctree"])
+
+        args = [
+            os.path.join(srctree, 'scripts/get_feat.pl'),
+            'rest',
+            '--enable-fname',
+            '--dir',
+            os.path.join(srctree, 'Documentation', self.arguments[0]),
+        ]
 
         if len(self.arguments) > 1:
-            cmd += " --arch " + self.arguments[1]
+            args.extend(['--arch', self.arguments[1]])
 
-        srctree = path.abspath(os.environ["srctree"])
-
-        fname = cmd
-
-        # extend PATH with $(srctree)/scripts
-        path_env = os.pathsep.join([
-            srctree + os.sep + "scripts",
-            os.environ["PATH"]
-        ])
-        shell_env = os.environ.copy()
-        shell_env["PATH"]    = path_env
-        shell_env["srctree"] = srctree
-
-        lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
+        lines = subprocess.check_output(args, cwd=os.path.dirname(doc.current_source)).decode('utf-8')
 
         line_regex = re.compile(r"^\.\. FILE (\S+)$")
 
@@ -121,30 +112,6 @@ class KernelFeat(Directive):
         nodeList = self.nestedParse(out_lines, fname)
         return nodeList
 
-    def runCmd(self, cmd, **kwargs):
-        u"""Run command ``cmd`` and return its stdout as unicode."""
-
-        try:
-            proc = subprocess.Popen(
-                cmd
-                , stdout = subprocess.PIPE
-                , stderr = subprocess.PIPE
-                , **kwargs
-            )
-            out, err = proc.communicate()
-
-            out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')
-
-            if proc.returncode != 0:
-                raise self.severe(
-                    u"command '%s' failed with return code %d"
-                    % (cmd, proc.returncode)
-                )
-        except OSError as exc:
-            raise self.severe(u"problems with '%s' directive: %s."
-                              % (self.name, ErrorString(exc)))
-        return out
-
     def nestedParse(self, lines, fname):
         content = ViewList()
         node    = nodes.section()
diff --git a/Documentation/translations/zh_CN/arch/loongarch/features.rst b/Documentation/translations/zh_CN/arch/loongarch/features.rst
index 82bfac180bdc..cec38dda8298 100644
--- a/Documentation/translations/zh_CN/arch/loongarch/features.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/features.rst
@@ -5,4 +5,4 @@
 :Original: Documentation/arch/loongarch/features.rst
 :Translator: Huacai Chen <chenhuacai@loongson.cn>
 
-.. kernel-feat:: $srctree/Documentation/features loongarch
+.. kernel-feat:: features loongarch
diff --git a/Documentation/translations/zh_CN/arch/mips/features.rst b/Documentation/translations/zh_CN/arch/mips/features.rst
index da1b956e4a40..0d6df97db069 100644
--- a/Documentation/translations/zh_CN/arch/mips/features.rst
+++ b/Documentation/translations/zh_CN/arch/mips/features.rst
@@ -10,4 +10,4 @@
 
 .. _cn_features:
 
-.. kernel-feat:: $srctree/Documentation/features mips
+.. kernel-feat:: features mips
diff --git a/Documentation/translations/zh_TW/arch/loongarch/features.rst b/Documentation/translations/zh_TW/arch/loongarch/features.rst
index b64e430f55ae..c2175fd32b54 100644
--- a/Documentation/translations/zh_TW/arch/loongarch/features.rst
+++ b/Documentation/translations/zh_TW/arch/loongarch/features.rst
@@ -5,5 +5,5 @@
 :Original: Documentation/arch/loongarch/features.rst
 :Translator: Huacai Chen <chenhuacai@loongson.cn>
 
-.. kernel-feat:: $srctree/Documentation/features loongarch
+.. kernel-feat:: features loongarch
 
diff --git a/Documentation/translations/zh_TW/arch/mips/features.rst b/Documentation/translations/zh_TW/arch/mips/features.rst
index f69410420035..3d3906c4d08e 100644
--- a/Documentation/translations/zh_TW/arch/mips/features.rst
+++ b/Documentation/translations/zh_TW/arch/mips/features.rst
@@ -10,5 +10,5 @@
 
 .. _tw_features:
 
-.. kernel-feat:: $srctree/Documentation/features mips
+.. kernel-feat:: features mips
 


