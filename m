Return-Path: <stable+bounces-208358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1849AD1EED6
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 13:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88D46304657D
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71BF399A67;
	Wed, 14 Jan 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OinJku6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196E318EE4;
	Wed, 14 Jan 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768395456; cv=none; b=COq2Mht+LGX0ZKkiAq4/h7GgUVuBzxEwHUTkNKyrGj6pKui5aD1H4oDMsyL2KWPH3QbFs8dZIECzWNPA6sPwrpOOfpytRnnSw7VBsxWg27NnHv6eUBn8YxbfiZf0Mvnm88LLZY8OB6c2qxmaQvL588ciKECBMaGUKW3xBFa/yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768395456; c=relaxed/simple;
	bh=6oCaEi76Hg/UqsSDo++T7ZkfHrGDy79mODSERj/qBrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjguLDlE8Pa2dxvhXqsZy8x5hE4afCJnrAA2Jsix2vGp/kG8TtSO6UyMd4dc1s6WmMm8T86ayrFzEW8wg3PxSWPKbI5d3XPdsLrKqwaIZ/Ri7G0nQiMCRmzjeL8VRMW4oxe/WcEJq77Dj0t0JuRca9iAKrpgEPau7v6ejJHbiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OinJku6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24721C4CEF7;
	Wed, 14 Jan 2026 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768395456;
	bh=6oCaEi76Hg/UqsSDo++T7ZkfHrGDy79mODSERj/qBrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OinJku6YFRMUf76QCUhJTt49Z+G64a376QNu68lUXZdQPpv+kmtuGKkaPs9hAasFu
	 HijO/ffFjC+Q/hjHUnKWL/nTAdMzcSEbP8GJ1AlbygDCFSxaCk4Ph7dYcPaEYw7tDt
	 XSSRESBJ8j3nbjiHs+5/IXJTssqB0MLQRBLIFPi7qTl+qg3aSg7qwml36IS4enW5gZ
	 WhAtjmk1v03Zb7PolEITdyegwa4a4NdoVKsFIvZS7Z3Ue/A48CydClXcP29zSvItj8
	 1sPnioDMH2I8zk63/9U2Z1XChOqE8lS39u+Yh61JUsi0krEjF6s529pI0jaaX/QTpn
	 TWNbPu44iBIEA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vg0RK-00000002ly0-16YQ;
	Wed, 14 Jan 2026 13:57:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/4] scripts/kernel-doc: fix logic to handle unissued warnings
Date: Wed, 14 Jan 2026 13:57:22 +0100
Message-ID: <9a3d93bbde9cd3cf5e4dd20ba4f65ef860af6792.1768395332.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768395332.git.mchehab+huawei@kernel.org>
References: <cover.1768395332.git.mchehab+huawei@kernel.org>
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
 tools/lib/python/kdoc/kdoc_parser.py | 31 ++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index a9a37519145d..4ad7ce0b243e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -448,18 +448,35 @@ class KernelDoc:
 
         self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
 
+    def emit_unused_warnings(self):
+        """
+        When the parser fails to produce a valid entry, it places some
+        warnings under `entry.warnings` that will be discarded when resetting
+        the state.
+
+        Ensure that those warnings are not lost.
+
+        NOTE: Because we are calling `config.warning()` here, those
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
 
@@ -1741,6 +1758,8 @@ class KernelDoc:
                         # Hand this line to the appropriate state handler
                         self.state_actions[self.state](self, ln, line)
 
+            self.emit_unused_warnings()
+
         except OSError:
             self.config.log.error(f"Error: Cannot open file {self.fname}")
 
-- 
2.52.0


