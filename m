Return-Path: <stable+bounces-211177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG+VMRRCcWn2fgAAu9opvQ
	(envelope-from <stable+bounces-211177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 22:16:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B885DE5D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 22:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3236FAABE50
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F84279E7;
	Wed, 21 Jan 2026 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ABYQmCNh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D30426ECF;
	Wed, 21 Jan 2026 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029926; cv=none; b=U7Aq+HtUI0hbDUGildHyubgbKXYoh1PLrabgsewyLkJ10HIKliBjPj3RtAyrG4Pk8SX0TLN8nthtPWJnIUn0wyog5CoGb2d3rstRyFxt3SHfIx8vKZGgcqKs/Tj1kUDX8FRESsy91JzzUa6eOoTq/9ZLeHcVp4wEEL2mhCAMupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029926; c=relaxed/simple;
	bh=Y16Ogx/r9LI3TBwhLfOnKNtYryedEgiaNOAFMq8SJEo=;
	h=Date:To:From:Subject:Message-Id; b=blQtGLtw+VBh89Fy3WVXn8y9PSCRlGnDvebtYKK1ApPqqUilMSh1eaYLBNBYxYz5JKba2zfkUrbc+DztvnsroRdoresi9XpyGciunc5XqwATF8VgWCIqX8nwcRZwV2VH4xoDim/hvEoSZAWwl4PB4RgzDy9TeQQVi2crnL7RHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ABYQmCNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4536C4CEF1;
	Wed, 21 Jan 2026 21:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769029925;
	bh=Y16Ogx/r9LI3TBwhLfOnKNtYryedEgiaNOAFMq8SJEo=;
	h=Date:To:From:Subject:From;
	b=ABYQmCNhAAmOhgfVyPGVyBmlXP89JRadxmEalge4JRcL5occtYBHL/MsXH3bQ/+7t
	 h3jISOcOUFzTm2wHkmfKSTwb7VSx4PTUzmpf9XvXFpGj3uJd3XZTOmzq0V0570jZ/v
	 noAdo6Yshe7ATWqJSNQAPjU4Xki6SS+CgFt4LFaY=
Date: Wed, 21 Jan 2026 13:12:05 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,mporter@kernel.crashing.org,alex.bou9@gmail.com,akpm@linux-foundation.org,lihaoxiang@isrc.iscas.ac.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + rapidio-replace-rio_free_net-with-kfree-in-rio_scan_alloc_net-v2.patch added to mm-nonmm-unstable branch
Message-Id: <20260121211205.B4536C4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.crashing.org,gmail.com,linux-foundation.org,isrc.iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211177-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,iscas.ac.cn:email,linux-foundation.org:email,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 34B885DE5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: rapidio: replace rio_free_net() with kfree() in rio_scan_alloc_net()
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     rapidio-replace-rio_free_net-with-kfree-in-rio_scan_alloc_net-v2.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/rapidio-replace-rio_free_net-with-kfree-in-rio_scan_alloc_net-v2.patch

This patch will later appear in the mm-nonmm-unstable branch at
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

rapidio-replace-rio_free_net-with-kfree-in-rio_scan_alloc_net-v2.patch


