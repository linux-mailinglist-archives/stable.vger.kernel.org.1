Return-Path: <stable+bounces-119409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EFAA42CB4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 20:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737EC1896278
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB21FECB5;
	Mon, 24 Feb 2025 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6XYyqfm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7781FDA79
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425146; cv=none; b=Iaw4xmyNEFVRp4iFf/J50/PSWIW9Y7/MBmLelLmRRqN7Hi03yJiEZ8Lgl2ZBUJfvdkP8Igj4m1bGnRNTli6sOY89T5ooIJzty200DadG7QI/sd9EULVwXO6HF+3MO+B7MIQBvII1n9IZXzVoDRpR3pwkxDTdgVlN6zPqqm+1LM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425146; c=relaxed/simple;
	bh=svW1exXQ03oPlgdg3UIMqaCxaaP9KNn31iqC5fizrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DujGU/cKourWeH9fhQqbZirVzS7u651OVUAQhF3cMGwUQzBpX8Dft0vZOauBi76CrMv4BXUqV2UeqH4s4gaHJmJ++E+BZcrzvk5Zf1jctKV3PtN6D+BcO5Uw4HGPVRy+cszhciaiQZgdBciyU7ocUuedGeQGMxXhyw0TC25NzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6XYyqfm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740425142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=raZeTMMykYsj1E6LPySnAyAC4pYT6HdMrvMqEuLWarA=;
	b=C6XYyqfmvzS39fLetpq1YTDiavMeiu2bkX8AdyCiINUBIyhvpMYIHhz2PDkmY1Pu/0EJ2L
	mopYlcLMrvl6MHfyMhVeZnqMHCqGLdPKYhSbjTeLhWGLxj7NcsOROQh16w+ThU8HvFzofl
	D1ea89zLxpPEdDahLWIipr52wLUUGC8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-_a3eYmzEOaGuNnn4O_35hw-1; Mon,
 24 Feb 2025 14:25:38 -0500
X-MC-Unique: _a3eYmzEOaGuNnn4O_35hw-1
X-Mimecast-MFC-AGG-ID: _a3eYmzEOaGuNnn4O_35hw_1740425137
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DD9F18009A5;
	Mon, 24 Feb 2025 19:25:34 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 376891955BD4;
	Mon, 24 Feb 2025 19:25:32 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: stable@vger.kernel.org,
	msmith626@gmail.com,
	jakobkoschel@gmail.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH] dlm: fix lkb timeout scanning lookup
Date: Mon, 24 Feb 2025 14:25:28 -0500
Message-ID: <20250224192528.411319-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If a lkb is timed out when dlm_scan_timeout() kicks in and removes a
timed out lkb from ls->ls_timeout list the next iteration can end in
timeout the same lkb again that shouldn't happen. Since commit dc1acd5c9469
("dlm: replace usage of found with dedicated list iterator variable")
we don't set the lkb variable before the inner lookup loop to NULL. The
outer loop will not stop and checks if there was a successful lookup with
the lkb pointer of the last iteration that wasn't set to NULL. To stop this
behavior we use the old condition "!do_cancel && !do_warn" which signals if
there was a successful lookup and the lkb variable should be set with the
lkb that was looked up to be timed out. If the condition is false there is
no timed out lkb in ls->ls_timeout and the outer loop stops.

Cc: stable@vger.kernel.org
Reported-by: Marc Smith <msmith626@gmail.com>
Fixes: dc1acd5c9469 ("dlm: replace usage of found with dedicated list iterator variable")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 226822f49d30..1ff842be5891 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1919,7 +1919,7 @@ void dlm_scan_timeout(struct dlm_ls *ls)
 		}
 		mutex_unlock(&ls->ls_timeout_mutex);
 
-		if (!lkb)
+		if (!do_cancel && !do_warn)
 			break;
 
 		r = lkb->lkb_resource;
-- 
2.43.0


