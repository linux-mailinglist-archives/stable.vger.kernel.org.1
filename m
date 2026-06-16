Return-Path: <stable+bounces-264804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gAgyLyZ+MWoRkwUAu9opvQ
	(envelope-from <stable+bounces-264804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:47:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35704692742
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:47:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lDludqoH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264804-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264804-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EDC630953E5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7646AF3C;
	Tue, 16 Jun 2026 16:39:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E2466B4E;
	Tue, 16 Jun 2026 16:39:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627978; cv=none; b=Yq2aEH+2L17saF+Yc7Q8o05zpOGLOdBLSVgo9eODOyxQ+eFnmMX+35Vtv9kqA7a+FunszPuo5r8ExTpd5LwzUCppuObLwnhbpcFw2RvjaLz8FbHBxUryEB0rvvojzjQxKWi7fp6+3E4L+6XTKL2LJwLvSYOcbpunXFFZGoAu1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627978; c=relaxed/simple;
	bh=I+NqjtHfwrRyXV6GfuAZBW3wAHKavblB+g5S2vr/SSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYSrqDMdS8Kegw8XC6tN7L7jrHHIMosxMb7rfNll8Jp83GS2XboXs14DvAhXW5/zGopr5p93y8AFr5X2tEugMU9jRGteq+TocPXy2zpm+8LBsaI5ANoGuSsGWV+0iNsZ7WLgXnPUvCwaj1bJRYKndxLP+1FyVUgdaxfFmFj48eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lDludqoH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5841F000E9;
	Tue, 16 Jun 2026 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627976;
	bh=kj0N2ZxOgWo/1MfOpSuoMdzltG2Ey+1z/+/2ZfwVub8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lDludqoHvKbPS2fV6JTUY3z/Jfq2aCwmV81PuKMN21xRs4XkjX5Sh5/yPT2DH9IVh
	 ZgrKk0DWw/bt/jNh5DvwWgpt830ljw4sVYofQ5CrWQ+M8u9cpft/JYvcLH+bi+XjT0
	 KXA7aQxtOtxZnHDBqyWS0egHt6a5vag/CUDUsorg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: [PATCH 6.12 250/261] block: fix handling of dead zone write plugs
Date: Tue, 16 Jun 2026 20:31:28 +0530
Message-ID: <20260616145056.663049551@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264804-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:shinichiro.kawasaki@wdc.com,m:dlemoal@kernel.org,m:axboe@kernel.dk,m:gyokhan@amazon.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,wdc.com:email,kernel.dk:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amazon.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35704692742

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-zoned.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -517,6 +517,28 @@ static void disk_mark_zone_wplug_dead(st
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
@@ -1037,12 +1059,12 @@ static bool blk_zone_wplug_handle_write(
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



