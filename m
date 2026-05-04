Return-Path: <stable+bounces-243168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL8YOGCo+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:08:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C74BE996
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 169173034583
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAC53DE423;
	Mon,  4 May 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dtKF8iR8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45B2BFC7B;
	Mon,  4 May 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903190; cv=none; b=BJvlnWchwbbpCWS4lbFyPUZSq/IGOY90wIK9VLk4pjm5dHZuFujNsA6sYuAwsnJ3GSeUi25HGEUc5MTWl2ONjG0NgRfMd6nHKVGWzvdd6ecCxgByYih68RXDxkUBIY4Sy6NEOFk/cDQQCh9G7zTCJohVaR43rUwMx+oIK14n7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903190; c=relaxed/simple;
	bh=DEYFhdebBDkoUeIgGKZ86lfpKMFivP8Q/QmZ5J+RlZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqA4oRjaZaaB1fSFvg712sco9fXEv/0pM9v05L/5eJyiBJhEKB9zHqlCWVPh5SO49Uubq4WxeLQfnQl5IhSGIom0k6tOEaJtm64W1gtqmOJvs4y1c7rNfo+ENTyLAFOkStYwz8uD//F6+uuUkGCqO9yJ7nCgqNpJInEG5Fvkr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dtKF8iR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A3DC2BCB8;
	Mon,  4 May 2026 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903190;
	bh=DEYFhdebBDkoUeIgGKZ86lfpKMFivP8Q/QmZ5J+RlZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtKF8iR8Ywc+nZJiqWTbAWpWYVhIHU57WMAh+DAM+P+LsBJzE11UyxOtNd1eJB5sc
	 M+ifPUWvfsU9yFRFsc2/WpfCVl9HoKnr4S6Y2qjUbC/033t002NdL9zOyzPACftEjg
	 f+v63Mxm5DULwKIT4XNowp6LfyXKVAtuaASHTois=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7.0 106/307] block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()
Date: Mon,  4 May 2026 15:49:51 +0200
Message-ID: <20260504135146.800070270@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 152C74BE996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243168-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 0a8b8af896e0ef83e188e1fe20f98f2bbb1c2459 upstream.

The function disk_zone_wplug_schedule_bio_work() always takes a
reference on the zone write plug of the BIO work being scheduled. This
ensures that the zone write plug cannot be freed while the BIO work is
being scheduled but has not run yet. However, this unconditional
reference taking is fragile since the reference taken is released by the
BIO work blk_zone_wplug_bio_work() function, which implies that there
always must be a 1:1 relation between the work being scheduled and the
work running.

Make sure to drop the reference taken when scheduling the BIO work if
the work is already scheduled, that is, when queue_work() returns false.

Fixes: 9e78c38ab30b ("block: Hold a reference on zone write plugs to schedule submission")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-zoned.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1198,13 +1198,17 @@ static void disk_zone_wplug_schedule_bio
 	lockdep_assert_held(&zwplug->lock);
 
 	/*
-	 * Take a reference on the zone write plug and schedule the submission
-	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
-	 * reference we take here.
+	 * Schedule the submission of the next plugged BIO. Taking a reference
+	 * to the zone write plug is required as the bio_work belongs to the
+	 * plug, and thus we must ensure that the write plug does not go away
+	 * while the work is being scheduled but has not run yet.
+	 * blk_zone_wplug_bio_work() will release the reference we take here,
+	 * and we also drop this reference if the work is already scheduled.
 	 */
 	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
 	refcount_inc(&zwplug->ref);
-	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
+	if (!queue_work(disk->zone_wplugs_wq, &zwplug->bio_work))
+		disk_put_zone_wplug(zwplug);
 }
 
 static inline void disk_zone_wplug_add_bio(struct gendisk *disk,



