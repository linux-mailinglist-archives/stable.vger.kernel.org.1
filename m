Return-Path: <stable+bounces-212970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DAuG4ebfmnGbQIAu9opvQ
	(envelope-from <stable+bounces-212970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 01:17:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFFDC478A
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 01:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6756303714D
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 00:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0007518E02A;
	Sun,  1 Feb 2026 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jKjVjSeZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F43EBF1D;
	Sun,  1 Feb 2026 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769905018; cv=none; b=uQCu2htLCU45pai5St3KWJbDnR005jCEmbpzMiWp4dxXGnDCMH+gNuDGJYExnIDZ4tnSZq/U6w3v5nV6vx8dnoqMtRNaobLbGyG6kLRnRXa8QCxRiOED0hEmb9Jr1Vqbk9yNGff2EBdHbe5pZ0bY3a35NxeCwA8m9Wwiaguo3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769905018; c=relaxed/simple;
	bh=6RctTLQPf4+7ZsKzFgIFE++ROKMSz2MHCHxRh3Q0AGU=;
	h=Date:To:From:Subject:Message-Id; b=cfrtFDL3fec283xKmZz43p9IfYG/1RGPJMdVH96iSCLQ84CGEz6MR5IlrhFTVzDOdwRLVqRL/2bl7gDeV4+eB9Hs90pYwymDVIo3XZFnsII8Mgide1HqpV6/1xxhUl1u324YCtJ2kEAzeWFYFiLYXVW6DC6eoNr4d5WzSl7mwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jKjVjSeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AC3C4CEF1;
	Sun,  1 Feb 2026 00:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769905018;
	bh=6RctTLQPf4+7ZsKzFgIFE++ROKMSz2MHCHxRh3Q0AGU=;
	h=Date:To:From:Subject:From;
	b=jKjVjSeZQfFKUGRzuC5MinfU6k5+sbEhaNKXl03W4MRaOitN+1eVZyGlvk0fqq1CP
	 9gcQXGcF7Sw6LpIYwTV+K6Tk/0e3UxyrfTcxobbam5d39Wbptd7BsPiqTV7fam2akq
	 mrslyi+V5BRgkqV/f5TbU2ptA49mw9bD/exMZcWo=
Date: Sat, 31 Jan 2026 16:16:58 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,mporter@kernel.crashing.org,alex.bou9@gmail.com,akpm@linux-foundation.org,lihaoxiang@isrc.iscas.ac.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] rapidio-replace-rio_free_net-with-kfree-in-rio_scan_alloc_net-v2.patch removed from -mm tree
Message-Id: <20260201001658.86AC3C4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212970-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.crashing.org,gmail.com,linux-foundation.org,isrc.iscas.ac.cn];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,linux-foundation.org:email,linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: BBFFDC478A
X-Rspamd-Action: no action


The quilt patch titled
     Subject: rapidio: replace rio_free_net() with kfree() in rio_scan_alloc_net()
has been removed from the -mm tree.  Its filename was
     rapidio-replace-rio_free_net-with-kfree-in-rio_scan_alloc_net-v2.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: rapidio: replace rio_free_net() with kfree() in rio_scan_alloc_net()
Date: Wed, 21 Jan 2026 09:35:08 +0800

When idtab allocation fails, net is not registered with rio_add_net() yet,
so kfree(net) is sufficient to release the memory.  Set mport->net to NULL
to avoid dangling pointer.

Link: https://lkml.kernel.org/r/20260121013508.195836-1-lihaoxiang@isrc.iscas.ac.cn
Fixes: e6b585ca6e81 ("rapidio: move net allocation into core code")
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/rapidio/rio-scan.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/rapidio/rio-scan.c~rapidio-replace-rio_free_net-with-kfree-in-rio_scan_alloc_net-v2
+++ a/drivers/rapidio/rio-scan.c
@@ -854,7 +854,8 @@ static struct rio_net *rio_scan_alloc_ne
 
 		if (idtab == NULL) {
 			pr_err("RIO: failed to allocate destID table\n");
-			rio_free_net(net);
+			kfree(net);
+			mport->net = NULL;
 			net = NULL;
 		} else {
 			net->enum_data = idtab;
_

Patches currently in -mm which might be from lihaoxiang@isrc.iscas.ac.cn are



