Return-Path: <stable+bounces-211398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF/NFsSUc2ktxQAAu9opvQ
	(envelope-from <stable+bounces-211398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 16:33:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6577D34
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 16:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 812823057CDB
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7CC278161;
	Fri, 23 Jan 2026 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhtMxpAg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D101288C3F
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182280; cv=none; b=khgZK03+Too+a7HBMMPS6NH10kEGPp2miJ2cTHU4iSCW5aAl/22ZaBpcD5tULYpvMg91b1A/RTo/KJdJXsMQvKrc+5bh+IIg1aYKPeQNq6lhyOHYVMB25U1EjPD1dfmhPIUiYzdDGFbmOs6+yNAKYNNYCfbgND+zpGQ58mB7Jmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182280; c=relaxed/simple;
	bh=w2JiCUhmvRT8ZQZxwuaTFt0UtjH6jhCGJVP322DS2Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoEb3+rq1LBO3k7fqNnsiZlY1v5O7hbkZ4Qy5MEuM+pUGHG9QC2GzqIpbv1Vv/yrO5czUBzsSuyemDFn2YXy8dTdyRxcu1bWYTFtcidrruV4hUDHGLfXcHpAx9hj3LCaRuOVKA7UGf7n5oVbeJRMjc/i/g44OdwxKUrdBF7E7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhtMxpAg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MymNL/nYeDWvomO79oTb7U4puYKN2dbfH+nTeBxlP5Q=;
	b=WhtMxpAgyaqFxbGlabEeWjqd/bIxtsNSKUEKjglqzsCWZ0gIuv15sQdNN17puJMNo6/4j8
	4KfIxWHAqrrfiV2CqoCGlldkw0jLfDRsLEB9BA6ed6Cv1YtWYVaDe3brKpp3WOccTUK2gR
	L7Rso+Kleu4BVXUJH2sJp9um0TG79Tk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-8LOpjD06NHmEqrGi9fP1uA-1; Fri,
 23 Jan 2026 10:31:16 -0500
X-MC-Unique: 8LOpjD06NHmEqrGi9fP1uA-1
X-Mimecast-MFC-AGG-ID: 8LOpjD06NHmEqrGi9fP1uA_1769182275
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 512861955D9F;
	Fri, 23 Jan 2026 15:31:15 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A5C830002D1;
	Fri, 23 Jan 2026 15:31:13 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/13] Revert "gfs2: Fix use of bio_chain"
Date: Fri, 23 Jan 2026 16:30:55 +0100
Message-ID: <20260123153105.797382-6-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211398-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agruenba@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.990];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82A6577D34
X-Rspamd-Action: no action

This reverts commit 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941.

That commit incorrectly assumed that the bio_chain() arguments were
swapped in gfs2.  However, gfs2 intentionally constructs bio chains so
that the first bio's bi_end_io callback is invoked when all bios in the
chain have completed, unlike bio chains where the last bio's callback is
invoked.

Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/lops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 97ebe457c00a..d27a0b1080a9 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -484,7 +484,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(prev, new);
+	bio_chain(new, prev);
 	submit_bio(prev);
 	return new;
 }
-- 
2.52.0


