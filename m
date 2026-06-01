Return-Path: <stable+bounces-259490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK+eLDVRHWpfYwkAu9opvQ
	(envelope-from <stable+bounces-259490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 11:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 513E461C738
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F38D6300ACAD
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC4390C8B;
	Mon,  1 Jun 2026 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="OUsIBo7I"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604F3438B4;
	Mon,  1 Jun 2026 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306210; cv=none; b=d0gRcCcJ5LEjZzV6mn7c1IlhBVZKbM+1SWZwiZ2/7B2nwQueNQr1j2GCPhtevo5FeELHFlUzA3EW3hfPTgBnD3KdH2/UDXwe4LO/4Fy525XgFCFniwTG7XNfZGH+KEXtderw4OWLJC3tKkmgrt72CpUD0fk9RfeLcky4ko007bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306210; c=relaxed/simple;
	bh=OvHJDxBLer/KMoiG4SEo/qRY7Hjb+dywLz08afdf3rg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qx3i4MsbGjQB/xVPqBtLx8T2ZzPN/oLwxjiJ3Ab2wFCwfQDdCTGz6DgFZbQn4SE2QeKbo1xVVWh7ypAQOoG/DrPRfeldsphHDfgHF59XYB5qzOR1S09pHKLXcPM/4NYTi/jnWjdjvArbLLHYty7D6bADypN/i2Zoj9zS7pU3vHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=OUsIBo7I; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780306208; x=1811842208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M2wQtFcciWsfTba4Bx+EqffPExVMFVr2dQP2DazucmA=;
  b=OUsIBo7I+BQGTBePRI5B/WEiEBb2mS4k7PMq8rA/DWWHU2qKna9ZcR0Q
   bc+f6jhIgVnAOXBr0o9aUXknkBCSPqbrkkiD+S+KknbMSdKFYt1oEjVzC
   DnfqNwfTnFZRdO2waqTMqTi02DmBKugb4LilxDGgq+oBTX9eLRii4SX5f
   XA4Iwzacf/4Q8V8sXfVQ+tiSPDC0FeNOypLFL8hE9eVDDIJXNoAL+ne/I
   0hrolTGXjPO8q/syVeJb3jXDEjHlFwxRehy6BIEF73VMgXMT5Y3X5rPpG
   W7WNlOZszSgCvw3UMO4RAoLf0sXahIP/KZwr02VYvUkEmLblGGIj+XleU
   g==;
X-CSE-ConnectionGUID: c8oJnFHSSCakrxa4T66FgA==
X-CSE-MsgGUID: 7k7goRWHThGFWzn7AQp2cA==
X-IronPort-AV: E=Sophos;i="6.24,181,1774310400"; 
   d="scan'208";a="20629465"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 09:30:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:16543]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.154:2525] with esmtp (Farcaster)
 id 065e6b8e-8300-46c6-a48d-56b8ecabcb0b; Mon, 1 Jun 2026 09:30:08 +0000 (UTC)
X-Farcaster-Flow-ID: 065e6b8e-8300-46c6-a48d-56b8ecabcb0b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 09:30:06 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 09:30:04 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <axboe@kernel.dk>, <dlemoal@kernel.org>,
	<johannes.thumshirn@wdc.com>, <linux-block@vger.kernel.org>, "Shin'ichiro
 Kawasaki" <shinichiro.kawasaki@wdc.com>, Gyokhan Kochmarla
	<gyokhan@amazon.de>
Subject: block: fix handling of dead zone write plugs
Date: Mon, 1 Jun 2026 09:29:58 +0000
Message-ID: <20260601092958.12798-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259490-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,wdc.com:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gyokhan@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 513E461C738
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Damien Le Moal <dlemoal@kernel.org>

commit 836efd35c472d89c838d7b17ef339ddb3286ffc5 upstream.

Shin'ichiro reported hard to reproduce unaligned write errors with zoned
block devices. Under normal operation conditions (e.g. running XFS on an
SMR disk), these errors are nearly impossible to trigger. But using a
"slow" kernel with many debug options enables and some specific use
cases (e.g. fio zbd test case 46), the errors can be reproduced fairly
easily.

The unaligned write errors come from mishandling a valid reference
counting pattern of zone write plugs. Such pattern triggers for instance
if a process A writes a zone (not necessarilly to the full state),
another process B immediately resets the zone and immediately following
the completion of the zone reset, starts issuing writes to the zone.
With such pattern, in some cases, the zone write plugs worker thread of
the device may still be holding a reference to the zone write plug of
the zone taken when process A was writing to the zone. The following
zone reset from process B marks the zone as dead but does not remove the
zone write plug from the device hash table as a reference to the plug
still exist. Once process B starts issuing new writes, the zone write
plug is seen as dead and the writes from process B are immediately
failed, despite this write pattern being perfectly legal.

Fix this by allowing restoring a dead zone write plug to a live state if
a write is issued to the zone when the zone is: marked as dead, empty
and the write sector corresponds to the first sector of the zone (that
is, the write is aligned to the zone write pointer). This is done with
the new helper function disk_check_zone_wplug_dead(), which restores a
dead zone write plug to a live state by clearing the BLK_ZONE_WPLUG_DEAD
flag and restoring the initial reference to the zone write plug taken
when the plug was added to the device hash table.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: b7d4ffb51037 ("block: fix zone write plug removal")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://patch.msgid.link/20260513111129.108809-1-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

[ context conflict due to different line offsets in blk-zoned.c ]
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -505,6 +505,28 @@ static void disk_mark_zone_wplug_dead(struct blk_zone_wplug *zwplug)
 	}
 }
 
+static inline bool disk_check_zone_wplug_dead(struct blk_zone_wplug *zwplug)
+{
+	if (!(zwplug->flags & BLK_ZONE_WPLUG_DEAD))
+		return false;
+
+	/*
+	 * If a new write is received right after a zone reset completes and
+	 * while the disk_zone_wplugs_worker() thread has not yet released the
+	 * reference on the zone write plug after processing the last write to
+	 * the zone, then the new write BIO will see the zone write plug marked
+	 * as dead. This case is however a false positive and a perfectly valid
+	 * pattern. In such case, restore the zone write plug to a live one.
+	 */
+	if (!zwplug->wp_offset && bio_list_empty(&zwplug->bio_list)) {
+		zwplug->flags &= ~BLK_ZONE_WPLUG_DEAD;
+		refcount_inc(&zwplug->ref);
+		return false;
+	}
+
+	return true;
+}
+
 static void blk_zone_wplug_bio_work(struct work_struct *work);
 
 /*
@@ -1027,12 +1049,12 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	}
 
 	/*
-	 * If we got a zone write plug marked as dead, then the user is issuing
-	 * writes to a full zone, or without synchronizing with zone reset or
-	 * zone finish operations. In such case, fail the BIO to signal this
-	 * invalid usage.
+	 * Check if we got a zone write plug marked as dead. If yes, then the
+	 * user is likely issuing writes to a full zone, or without
+	 * synchronizing with zone reset or zone finish operations. In such
+	 * case, fail the BIO to signal this invalid usage.
 	 */
-	if (zwplug->flags & BLK_ZONE_WPLUG_DEAD) {
+	if (disk_check_zone_wplug_dead(zwplug)) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
 		bio_io_error(bio);



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


