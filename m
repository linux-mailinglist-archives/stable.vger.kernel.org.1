Return-Path: <stable+bounces-238624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JwhCmZ15GkXVgEAu9opvQ
	(envelope-from <stable+bounces-238624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 08:25:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 613194233AF
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 08:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DEC9301E5BC
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE17334C17;
	Sun, 19 Apr 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fcZ8pqWR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D816FF37;
	Sun, 19 Apr 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776579928; cv=none; b=o6oon4b0li7hGT8tbHR+/gu1fhkk7LgIyPRIRn4H5d2ZoopBQdxXbT+h7IkOzy3mNk2yPRLQoqeljOJ85Q7MAIu+rFTrVOY38dnAsPy9l8nr1QivzLPxGDs5Pm/e10pR+vkl/bYDwMJojLN5DrYnnOxfGGD6vBCNjDxTNz/7je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776579928; c=relaxed/simple;
	bh=8PXBXalHfEw3gaprMog+x7Lxp8YASdQJ0cFl4ayoOLk=;
	h=Date:To:From:Subject:Message-Id; b=WKkif5r1x5+ylzfjSsI5eq3cGbi0ioUD+KKlDMLg6DzafmBtnuuicMpUs23GPl3pGtlUI5VpPD9Mt5PfZAht0rvJwKIqhssMC0jG1W85MoWIrgVMTtaJh1nTMyzqt2ibRI4FzyGiy9V7KAHsNfk1mtkV3hnlQy+z2bQJ7Gvgql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fcZ8pqWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C69DC2BCAF;
	Sun, 19 Apr 2026 06:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776579928;
	bh=8PXBXalHfEw3gaprMog+x7Lxp8YASdQJ0cFl4ayoOLk=;
	h=Date:To:From:Subject:From;
	b=fcZ8pqWR+hvagEapByusG4wa/8oIghoeDB2IJ81JKslKI0HJCY4TjZymLUuxhERIE
	 soQElxn9Q7p5OCzxvq0T6BtaE9u/NU74Z9H/G2ZXiAO8aEmU/8JstaECy0yUa2dIkZ
	 rdRQrI9BYHoi0cYnpGYn8CRYqSZebItoQCQ/Oxhs=
Date: Sat, 18 Apr 2026 23:25:19 -0700
To: mm-commits@vger.kernel.org,vishal.moola@gmail.com,stable@vger.kernel.org,osalvador@suse.de,david@kernel.org,balbirs@nvidia.com,apopple@nvidia.com,matthew.brost@intel.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-zone_device-do-not-touch-device-folio-after-calling-folio_free.patch removed from -mm tree
Message-Id: <20260419062527.9C69DC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238624-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,suse.de,kernel.org,nvidia.com,intel.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 613194233AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/zone_device: do not touch device folio after calling ->folio_free()
has been removed from the -mm tree.  Its filename was
     mm-zone_device-do-not-touch-device-folio-after-calling-folio_free.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Matthew Brost <matthew.brost@intel.com>
Subject: mm/zone_device: do not touch device folio after calling ->folio_free()
Date: Fri, 10 Apr 2026 16:03:46 -0700

The contents of a device folio can immediately change after calling
->folio_free(), as the folio may be reallocated by a driver with a
different order.  Instead of touching the folio again to extract the
pgmap, use the local stack variable when calling percpu_ref_put_many().

Link: https://lore.kernel.org/20260410230346.4009855-1-matthew.brost@intel.com
Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Vishal Moola <vishal.moola@gmail.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memremap.c~mm-zone_device-do-not-touch-device-folio-after-calling-folio_free
+++ a/mm/memremap.c
@@ -454,7 +454,7 @@ void free_zone_device_folio(struct folio
 		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->folio_free))
 			break;
 		pgmap->ops->folio_free(folio);
-		percpu_ref_put_many(&folio->pgmap->ref, nr);
+		percpu_ref_put_many(&pgmap->ref, nr);
 		break;
 
 	case MEMORY_DEVICE_GENERIC:
_

Patches currently in -mm which might be from matthew.brost@intel.com are



