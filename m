Return-Path: <stable+bounces-243464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF8hNzOq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA314BEF0F
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A69C3029838
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78FE3BE630;
	Mon,  4 May 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PAY3WFWY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0DB377575;
	Mon,  4 May 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903951; cv=none; b=J/9fkubZB3CWpcAzv2ZHexm0rMWHSEh22tQZEYCwtO0HdupjNjX3IZLcO08p0d+ABTPPdQRzVHmfRSixGD/JP9KbUFPwERBgGYiTPHaOAMTUoptw65sKOKPdakciswTKqJhc6WwVWcMdi7VI5qWG/tWSdb8v4FOMO+9n8t2qCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903951; c=relaxed/simple;
	bh=XYqT5lOCQBrjnqIJHLqPhhg+fA2MjIAuTP+RttybFug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayGevrd9WDGzW1J/t5WFnFvaVSfK5XJJvzVoqVadiSCoRktw+6UoZG3AqcwQwCkfj8icR5WAZgGUWs8YOX6ViXzpBAaA4fhR2nzDB7aYzRLvmG5BwP+d8f8NbH4GT7DCFRCHXyj2XRmaGA9y5zpJwZd/kSHFCQHE1RTYj7Wanek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PAY3WFWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA87C2BCB8;
	Mon,  4 May 2026 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903951;
	bh=XYqT5lOCQBrjnqIJHLqPhhg+fA2MjIAuTP+RttybFug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAY3WFWYkZGuH+TKKWU8I0mLMl3q7ngcZK0aC5DSXJJhaBYOl53HzFCbHlfOu8Qls
	 fMQ7Xu6e50QdZLg9dmtk2XaHGD42k+nhXln81LEp6ANun7hx6JgM9WRSsFpBcO+O4Q
	 SyqHvP2e6Vp5aCompBuLXuZRdEjlUJUQzKlU/9zY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 093/275] block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()
Date: Mon,  4 May 2026 15:50:33 +0200
Message-ID: <20260504135146.372964884@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7EA314BEF0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243464-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,wdc.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,acm.org:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -801,13 +801,17 @@ static void disk_zone_wplug_schedule_bio
 					      struct blk_zone_wplug *zwplug)
 {
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



