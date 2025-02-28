Return-Path: <stable+bounces-119979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92918A4A624
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 23:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20F1168C66
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 22:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756151D8DFE;
	Fri, 28 Feb 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkT1fiIF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF823F372
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782940; cv=none; b=rTmxNy+mqzaoXZNt9GBz5b0jV4pFpzglAQJfXEKZo0qoGv6Db1rWkgwtWUaVWQ09XHknciBWLPfsJUJEH1ck5+hv0VsTgd+N3YUrsz3xEVOqvRfSP5gu9Iv2vx4+n2Z5g2PhCxpwcGiItUjIrjHy2PcsXiKGfTeVdeL/aI7V/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782940; c=relaxed/simple;
	bh=O9U11jsP1m5FkLfi9oR3wO1iMsSRPM0EOQKLcuZFGxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWd0zgr1lMfvkp1TGBUOKGhLPc2IKapu+OIgEM7gLQjtSwnEoFq3OML+tjDgNvX7SxcF7ZsqIoaIvIso6SsH0SesPjomhiGMxBgGynS8apn1F9w4yrmrrx446zWTRWUkgptBIG7aDjlFHqva0PMF34ftUH+tp+3xLGxqjEX7bn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkT1fiIF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740782936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JU11SJXLG3nR5zxtWokAMxQZEi8b7+ufo1e7gl/dKws=;
	b=SkT1fiIFENxxvTxKvhq73I7It7ngxRPD53yiiAlxqUapuu3ttoHEct5ISrnAjpVqmubfLW
	GbQOdspZzr2arDxAxOc7NNSnkyk2oJObVk57qlvEeExlSFxjpIhcvGMEW85B+DUP/tlPrp
	xQB5GjLVexQeXqf/+Ux/6MSvAqQyHYg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-ue-46qApNs6KnIUvJZTbVw-1; Fri,
 28 Feb 2025 17:48:55 -0500
X-MC-Unique: ue-46qApNs6KnIUvJZTbVw-1
X-Mimecast-MFC-AGG-ID: ue-46qApNs6KnIUvJZTbVw_1740782934
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06D2E1800373;
	Fri, 28 Feb 2025 22:48:54 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EB371800357;
	Fri, 28 Feb 2025 22:48:52 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: stable@vger.kernel.org,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 1/2] dlm: fix error if inactive rsb is not hashed
Date: Fri, 28 Feb 2025 17:48:50 -0500
Message-ID: <20250228224851.1283094-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If an inactive rsb is not hashed anymore and this could occur because we
releases and acquired locks we need to signal the followed code that the
lookup failed. Since the lookup was successful, but it isn't part of the
rsb hash anymore we need to signal it by setting error to -EBADR as
dlm_search_rsb_tree() does it.

Cc: stable@vger.kernel.org
Fixes: 01fdeca1cc2d ("dlm: use rcu to avoid an extra rsb struct lookup")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c8ff88f1cdcf..499fa999ae83 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -784,6 +784,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		}
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -EBADR;
 		goto do_new;
 	}
 
-- 
2.43.0


