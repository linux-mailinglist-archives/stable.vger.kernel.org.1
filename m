Return-Path: <stable+bounces-241338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A+HMVh472n9BgEAu9opvQ
	(envelope-from <stable+bounces-241338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:53:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1B474BC8
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C6430D2ED1
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463D93ACA74;
	Mon, 27 Apr 2026 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gauu1jmG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF612238D27;
	Mon, 27 Apr 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301204; cv=none; b=L1ighn9j5xVhmIJ/us3xBCANolDzHTeQ94DzJpS9MFQNXhf5afWKBJg3sb+vH6BBZonR2K8aYQAZFlSl6hU+uh3097JJYE3dzGzNewoYhloKuMsALYPojbFFNw77EqS4JbTqwv0gbs4fCDiDg9Vn1PulpNcYyxU60VHX6Jocu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301204; c=relaxed/simple;
	bh=5yb9c7oq+huuVV5m1Or9yERJzLvSzn4j+2VW6uy4X+o=;
	h=Date:To:From:Subject:Message-Id; b=EocDG7wwmnmTYq3KMXKDh/G/5Yl/oeS76tK4DIGxD14h3MFHa2Y7MasUkV+mXGbii13bU6d0uVtptuZ9DvoT1oaOS5PWshuMF4raXdt5Ovg6OLUCI8/3dj+cwSIEcDU354qEnzozEbiREuruBIrFeVCXj7ocGFZeciyThzcR0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gauu1jmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFE1C19425;
	Mon, 27 Apr 2026 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777301204;
	bh=5yb9c7oq+huuVV5m1Or9yERJzLvSzn4j+2VW6uy4X+o=;
	h=Date:To:From:Subject:From;
	b=gauu1jmGLUlHA7eHv6MaWb8AJwi7RRaTHR1iP6bPJGpAyCJtQB92rHXo4rlQ9uqez
	 dOphY1h6GigRF/lBsXcR9DD3+5d6H93OowvDqvAF/+8aSJnmJPEdgRa7ozI1XzNuwJ
	 3jYZS5RBdJGaZXGCE6naQpWkmKZezDqsUrQ99r3M=
Date: Mon, 27 Apr 2026 07:46:43 -0700
To: mm-commits@vger.kernel.org,vbabka@suse.com,stable@vger.kernel.org,kbingham@kernel.org,jan.kiszka@siemens.com,hsj0512@snu.ac.kr,harry@kernel.org,hao.li@linux.dev,florian.fainelli@broadcom.com,illia@yshyn.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + scripts-gdb-mm-cast-untyped-symbols-in-x86_page_ops.patch added to mm-hotfixes-unstable branch
Message-Id: <20260427144644.4DFE1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BEE1B474BC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-241338-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch titled
     Subject: scripts/gdb: mm: cast untyped symbols in x86_page_ops
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     scripts-gdb-mm-cast-untyped-symbols-in-x86_page_ops.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/scripts-gdb-mm-cast-untyped-symbols-in-x86_page_ops.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Illia Ostapyshyn <illia@yshyn.com>
Subject: scripts/gdb: mm: cast untyped symbols in x86_page_ops
Date: Mon, 27 Apr 2026 16:24:47 +0200

The symbols phys_base, _text, and _end, used in x86_page_ops are either
defined in assembly or implicitly by the linker.  Thus, they lack type
information and cause a conversion error after gdb.parse_and_eval. 
Explicitly cast these expressions to unsigned long.

Link: https://lore.kernel.org/20260427142448.666117-2-illia@yshyn.com
Fixes: 55f8b4518d14 ("scripts/gdb: implement x86_page_ops in mm.py")
Signed-off-by: Illia Ostapyshyn <illia@yshyn.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.com>
Cc: Hao Li <hao.li@linux.dev>
Cc: Harry Yoo <harry@kernel.org>
Cc: Seongjun Hong <hsj0512@snu.ac.kr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/gdb/linux/mm.py |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/scripts/gdb/linux/mm.py~scripts-gdb-mm-cast-untyped-symbols-in-x86_page_ops
+++ a/scripts/gdb/linux/mm.py
@@ -40,11 +40,11 @@ class x86_page_ops():
 
         self.PAGE_OFFSET = int(gdb.parse_and_eval("page_offset_base"))
         self.VMEMMAP_START = int(gdb.parse_and_eval("vmemmap_base"))
-        self.PHYS_BASE = int(gdb.parse_and_eval("phys_base"))
+        self.PHYS_BASE = int(gdb.parse_and_eval("(unsigned long) phys_base"))
         self.START_KERNEL_map = 0xffffffff80000000
 
-        self.KERNEL_START = gdb.parse_and_eval("_text")
-        self.KERNEL_END = gdb.parse_and_eval("_end")
+        self.KERNEL_START = gdb.parse_and_eval("(unsigned long) &_text")
+        self.KERNEL_END = gdb.parse_and_eval("(unsigned long) &_end")
 
         self.VMALLOC_START = int(gdb.parse_and_eval("vmalloc_base"))
         if self.VMALLOC_START == 0xffffc90000000000:
_

Patches currently in -mm which might be from illia@yshyn.com are

scripts-gdb-mm-cast-untyped-symbols-in-x86_page_ops.patch


