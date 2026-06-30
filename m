Return-Path: <stable+bounces-269845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OHy0Ma4IQ2pFNgoAu9opvQ
	(envelope-from <stable+bounces-269845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 02:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 425BF6DF528
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 02:07:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=StLhMONR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269845-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269845-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EDB7302E7C3
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 00:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A4528F5;
	Tue, 30 Jun 2026 00:07:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607E288AD;
	Tue, 30 Jun 2026 00:07:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778028; cv=none; b=t6Tg+Cu8Xeh8+1jQ9nTYKFhZNDJ8Hawg7/ScDzYeFAg3PLlQ9kaavq5zqRw3+Hwby2uGw0onq6kAvxIhf6qYoWFcqgzu3fl6zUVNqt0RdspU+ISiPOCYQovSYetp9D4qQhuqqHKrtqQbEYRtu2NrpX8SdgQJVKJ03NA0MCyu2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778028; c=relaxed/simple;
	bh=48oVKqp++UwmWwYbOQj+zEgCOQDZdYF1TON13bpfwL4=;
	h=Date:To:From:Subject:Message-Id; b=qSZ599SjqXdtsbiyM/2cW/p4beL7ZFbjUuM6TqqNORAoQ7FH0ACCe/p5R8rGxzKTWU+TnXU4QAvmUPUZOG07d1cRxMAA1xpbYWN0INBR4nnSAdc/gM0B2S6akHKZrG3O9ZbtfWDtxsp5PlxwycuxUmB34n2MlP5O0UjQ3Nyl5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=StLhMONR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088041F000E9;
	Tue, 30 Jun 2026 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782778027;
	bh=ypL546/XRnjqYdyZKSkW5L04xouqnRJrLMHPXAQ1Nfw=;
	h=Date:To:From:Subject;
	b=StLhMONREzRcNqTWCCQBU1fb7SGoaXxbUguI1FG3CIMCnpNZIm+dl0usNUw4SB1F+
	 3yxSa4CsorbFAnsJA1e7mg6CD4OYmUPAu4vKrWQdr2PeZjycYGY98E0uQDz+1DaxM7
	 6wn/wL0DvpVbB8jCeUr7rUd8d1yjBM65m/JekOjY=
Date: Mon, 29 Jun 2026 17:07:06 -0700
To: mm-commits@vger.kernel.org,zenghui.yu@linux.dev,stable@vger.kernel.org,leon@kernel.org,jgg@ziepe.ca,balbirs@nvidia.com,apopple@nvidia.com,skinsburskii@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + lib-test_hmm-use-device-devt-for-coherent-device-range-selection.patch added to mm-hotfixes-unstable branch
Message-Id: <20260630000707.088041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269845-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:zenghui.yu@linux.dev,m:stable@vger.kernel.org,m:leon@kernel.org,m:jgg@ziepe.ca,m:balbirs@nvidia.com,m:apopple@nvidia.com,m:skinsburskii@gmail.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.dev,kernel.org,ziepe.ca,nvidia.com,gmail.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,nvidia.com:email,linux.dev:email,ziepe.ca:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 425BF6DF528


The patch titled
     Subject: lib: test_hmm: use device devt for coherent device range selection
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     lib-test_hmm-use-device-devt-for-coherent-device-range-selection.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/lib-test_hmm-use-device-devt-for-coherent-device-range-selection.patch

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
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Subject: lib: test_hmm: use device devt for coherent device range selection
Date: Mon, 29 Jun 2026 16:30:14 -0700

Commit af69016dab96 ("lib: test_hmm: implement a device release method")
moved the initial dmirror_allocate_chunk() call before cdev_device_add(). 
That means the struct cdev has not been added yet, so cdev_add() has not
initialized mdevice->cdevice.dev.

The coherent-device range selection uses the device minor to choose
between spm_addr_dev0 and spm_addr_dev1.  Reading
MINOR(mdevice->cdevice.dev) before cdev_add() therefore always sees an
uninitialized dev_t.  As a result, both coherent devices select the same
physical range, and adding the second device fails due to the overlapping
dev_pagemap range.

Use mdevice->device.devt instead.  It is initialized in
dmirror_device_init() before dmirror_allocate_chunk() is called and is the
same dev_t later passed to cdev_device_add().

Link: https://lore.kernel.org/178277581197.172200.16265155329935822153.stgit@skinsburskii
Fixes: af69016dab96 ("lib: test_hmm: implement a device release method")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/test_hmm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test_hmm.c~lib-test_hmm-use-device-devt-for-coherent-device-range-selection
+++ a/lib/test_hmm.c
@@ -581,7 +581,7 @@ static int dmirror_allocate_chunk(struct
 		devmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
 		break;
 	case HMM_DMIRROR_MEMORY_DEVICE_COHERENT:
-		devmem->pagemap.range.start = (MINOR(mdevice->cdevice.dev) - 2) ?
+		devmem->pagemap.range.start = (MINOR(mdevice->device.devt) - 2) ?
 							spm_addr_dev0 :
 							spm_addr_dev1;
 		devmem->pagemap.range.end = devmem->pagemap.range.start +
_

Patches currently in -mm which might be from skinsburskii@gmail.com are

lib-test_hmm-use-device-devt-for-coherent-device-range-selection.patch


