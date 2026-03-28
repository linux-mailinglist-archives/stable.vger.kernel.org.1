Return-Path: <stable+bounces-230762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fCuaDFxYx2kjVwUAu9opvQ
	(envelope-from <stable+bounces-230762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 05:26:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D834D434
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 05:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F24E304B8C7
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 04:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A83385A7;
	Sat, 28 Mar 2026 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2PzSyEiB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C433557B;
	Sat, 28 Mar 2026 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774671922; cv=none; b=ILTkhubK8FizFx4neoA1qWKcKGPhJJiTCxKus5ZmhUEC/dUD/GYXqvnHc+YvK49xiwY2sVJdK8wg2W8OvEnbPQkbZfrtEK6oLdQuIKb+7oKETM5pWtT1Fa02IQ1h8aA+3cPNUwTo9A4JdKq6mpmSWccIyK5VJ+gtscDrN8HZMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774671922; c=relaxed/simple;
	bh=8FPl9/q8zv53IgGIRA/JD2ZGMSCaF1t5e0LsHHVCG+c=;
	h=Date:To:From:Subject:Message-Id; b=Xc2YZI2NPGAmn6RVqMM+tUu3tSh/7oAyNOLk6JKH3yxi8Gj93XVGSXAMU0S9a19p20r1XBzNDdCHroEWUPuE7hrPLEYnusFg2e5HYO3tUDUxIvIqSWRhLS/97oqCERdKhFTYu5KM+FffBtTmd7vO9VeG2fqU4jpNZMTsIxQxacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2PzSyEiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CC7C4CEF7;
	Sat, 28 Mar 2026 04:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774671922;
	bh=8FPl9/q8zv53IgGIRA/JD2ZGMSCaF1t5e0LsHHVCG+c=;
	h=Date:To:From:Subject:From;
	b=2PzSyEiBrHW6uyPHzlr11BODdwHLb+5fsxgrF1n29trCf/KeQxaGwRcG5xuGgmCZ0
	 5/twDkpLUp1SUgXJZT0mDq6NhH5bVv5fOhug8FK2gnbiSbekir2sEOA6fUpPnGLwvn
	 Vbw5Oe9oA1rg0DywrILUSnxFAWXYb3zocK9YdcIM=
Date: Fri, 27 Mar 2026 21:25:21 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,kbingham@kernel.org,johannes.berg@intel.com,jan.kiszka@siemens.com,iii@linux.ibm.com,benjamin.berg@intel.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] scripts-gdb-symbols-handle-module-path-parameters.patch removed from -mm tree
Message-Id: <20260328042522.02CC7C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-230762-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,intel.com:email,linux-foundation.org:dkim,linux-foundation.org:email]
X-Rspamd-Queue-Id: 7D5D834D434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: scripts/gdb/symbols: handle module path parameters
has been removed from the -mm tree.  Its filename was
     scripts-gdb-symbols-handle-module-path-parameters.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Benjamin Berg <benjamin.berg@intel.com>
Subject: scripts/gdb/symbols: handle module path parameters
Date: Wed, 4 Mar 2026 12:06:43 +0100

commit 581ee79a2547 ("scripts/gdb/symbols: make BPF debug info available
to GDB") added support to make BPF debug information available to GDB. 
However, the argument handling loop was slightly broken, causing it to
fail if further modules were passed.  Fix it to append these passed
modules to the instance variable after expansion.

Link: https://lkml.kernel.org/r/20260304110642.2020614-2-benjamin@sipsolutions.net
Fixes: 581ee79a2547 ("scripts/gdb/symbols: make BPF debug info available to GDB")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/gdb/linux/symbols.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/gdb/linux/symbols.py~scripts-gdb-symbols-handle-module-path-parameters
+++ a/scripts/gdb/linux/symbols.py
@@ -298,7 +298,7 @@ are loaded as well."""
             if p == "-bpf":
                 monitor_bpf = True
             else:
-                p.append(os.path.abspath(os.path.expanduser(p)))
+                self.module_paths.append(os.path.abspath(os.path.expanduser(p)))
         self.module_paths.append(os.getcwd())
 
         if self.breakpoint is not None:
_

Patches currently in -mm which might be from benjamin.berg@intel.com are



