Return-Path: <stable+bounces-210138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF5D38D56
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5576B3008C94
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A33321DB;
	Sat, 17 Jan 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJOONk13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F932FA2A;
	Sat, 17 Jan 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768642172; cv=none; b=tDZmVNXso5PzS/bHHpMml0jcP+kDFoFv9b7KpGGBS+P/jiQTr1ceSNaq6Tpp5iMw8jchweKFuLP38e9ktunILbC3tFKvCcMuqzR6wHQd5gIFM0XF9fu6CgoshAyRXJwCxLX8p08rBfgfxTkgPpK1cNnBjtcFInZ7IbqVlDAv1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768642172; c=relaxed/simple;
	bh=TCIDBeqflVUFZ2smOAiTOF7w3v48ieHVeu+24TcmIW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooSAzu5ZV5zDNqpytaMFIEcnoAx4xjAokrBsNpfMXXOrqjHj5TwqHXNQFZpJykLCFRrPPOdvWKSEY0Y6c517x69F6St1uhYsGGzISFVsV3ih7FAvJ9j/hCZxYYe6ynqVKnn36nOV/Z/KxUEoELeV8zUXsoVY2tM00xjNkYOK2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJOONk13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD53C19421;
	Sat, 17 Jan 2026 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768642172;
	bh=TCIDBeqflVUFZ2smOAiTOF7w3v48ieHVeu+24TcmIW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJOONk13XDg+Vh6MUpiG1UvbgkqgyS6CoxXIA28gsmmRDCPYHkQ4M4zkJLGZMKesg
	 pCeCbVZxeXOiBaofjT0jiRr7rhro8nGVmNRUSpmTVtiAR4bMIfQG7FRKq1wgALFu0Q
	 aidhMvDvT5FgvOA97rzBvkIJ+0JSvGZU7pwFJTDrGIENQopoiB5qjVqZFjZWaWczPR
	 thzXfRk5uXXg7tj89hCYBlvJFz7+4dJ9dlWAPY+oieII1rKxvBHYxzAobwWBquxDLp
	 sTRM1fDbcicTQrxHip7QVN/XhHsBoShNLz6mGNwYkzOv4dGQeZyFDRU7nFhThYA4d6
	 RerYLpykplLqw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vh2cc-00000000fnw-0Hz1;
	Sat, 17 Jan 2026 10:29:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/4] scripts/kernel-doc: fix logic to handle unissued warnings
Date: Sat, 17 Jan 2026 10:29:23 +0100
Message-ID: <2de5f576f4ec010962e34d8cd1868c89cce910e9.1768642102.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768642102.git.mchehab+huawei@kernel.org>
References: <cover.1768642102.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Changeset 469c1c9eb6c9 ("kernel-doc: Issue warnings that were silently discarded")
didn't properly addressed the missing messages behavior, as
it was calling directly python logger low-level function,
instead of using the expected method to emit warnings.

Basically, there are two methods to log messages:

- self.config.log.warning() - This is the raw level to emit a
  warning. It just writes the a message at stderr, via python
  logging, as it is initialized as:

    self.config.log = logging.getLogger("kernel-doc")

- self.config.warning() - This is where we actually consider a
  message as a warning, properly incrementing error count.

Due to that, several parsing error messages are internally considered
as success, causing -Werror to not work on such messages.

While here, ensure that the last ignored entry will also be handled
by adding an extra check at the end of the parse handler.

Fixes: 469c1c9eb6c9 ("kernel-doc: Issue warnings that were silently discarded")
Closes: https://lore.kernel.org/linux-doc/20260112091053.00cee29a@foz.lan/
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 35 ++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index a9a37519145d..c03505889dc2 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -295,7 +295,7 @@ class KernelEntry:
 
     # TODO: rename to emit_message after removal of kernel-doc.pl
     def emit_msg(self, ln, msg, *, warning=True):
-        """Emit a message"""
+        """Emit a message."""
 
         log_msg = f"{self.fname}:{ln} {msg}"
 
@@ -448,18 +448,37 @@ class KernelDoc:
 
         self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
 
+    def emit_unused_warnings(self):
+        """
+        When the parser fails to produce a valid entry, it places some
+        warnings under `entry.warnings` that will be discarded when resetting
+        the state.
+
+        Ensure that those warnings are not lost.
+
+        .. note::
+
+              Because we are calling `config.warning()` here, those
+              warnings are not filtered by the `-W` parameters: they will all
+              be produced even when `-Wreturn`, `-Wshort-desc`, and/or
+              `-Wcontents-before-sections` are used.
+
+              Allowing those warnings to be filtered is complex, because it
+              would require storing them in a buffer and then filtering them
+              during the output step of the code, depending on the
+              selected symbols.
+        """
+        if self.entry and self.entry not in self.entries:
+            for log_msg in self.entry.warnings:
+                self.config.warning(log_msg)
+
     def reset_state(self, ln):
         """
         Ancillary routine to create a new entry. It initializes all
         variables used by the state machine.
         """
 
-        #
-        # Flush the warnings out before we proceed further
-        #
-        if self.entry and self.entry not in self.entries:
-            for log_msg in self.entry.warnings:
-                self.config.log.warning(log_msg)
+        self.emit_unused_warnings()
 
         self.entry = KernelEntry(self.config, self.fname, ln)
 
@@ -1741,6 +1760,8 @@ class KernelDoc:
                         # Hand this line to the appropriate state handler
                         self.state_actions[self.state](self, ln, line)
 
+            self.emit_unused_warnings()
+
         except OSError:
             self.config.log.error(f"Error: Cannot open file {self.fname}")
 
-- 
2.52.0


