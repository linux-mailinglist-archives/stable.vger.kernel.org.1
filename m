Return-Path: <stable+bounces-238730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ucghCEP05Wl+pgEAu9opvQ
	(envelope-from <stable+bounces-238730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:39:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85302428ECB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 166F9302B516
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E43389119;
	Mon, 20 Apr 2026 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEbM1UgX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5FB3815E1
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677949; cv=none; b=TEEtOYo1Z7bTh4qc6H4Hwo+ZeygpkTjFk0wqloZoaDjPuP1Du1JH1f0+gAlXRJjlgJcw2GB6qJEtcr0EkL6AIO0FrCBivfOSFDHpCc1P/AgreFii9jcC3dElMe/VLWFWcsxcbvYXgYatF0j/Meq8z4BiNick+uXNc1XrXpoNwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677949; c=relaxed/simple;
	bh=aYiHX5rAJalMyGgqasItiAaZl0PwJqW8xhexmlXewP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPLSrWw9AwGX6q0+14jaSM8JPS4hs7VI5qIxcGU4NRIVdVmX/272Jb0ueiAQxR2zEf1RXTROeIa4lJe2r1lv9t//gzAOcuJB2nxxZKlUaytWotQxhSyNMc1Omsx+usLQ+WACbxyt91H3zd77TgM/kM6fqCiRb+RhprYNuvwtcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEbM1UgX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so888982a12.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 02:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776677948; x=1777282748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCVZolkJ/jGGZ3sp1HB4+a9dT+5CyB5mH+bc98lNAj8=;
        b=KEbM1UgXhBnW1CZSaphRRlxJNa5AxuHXrRcR4TfaEHKw3bvKG8jX1q8OB9WRXTQ9Vb
         khHlEI+doLtgKlzkeVR3QDTGyvn8jzZ2LB7rVBOIcQO2gMx7WaAAKnKqG9f/1sFK70fJ
         LXeSMLlPpsDaJJWXdagUbLM8S+7b6ZH95y8R4NcvHbhs7WIVI6eAQSs7pvvl6RtqKHOi
         oDDDS1oW3MAkulQndWn0fNOvq0NIbKLG7vgGlX8/3CEZ3zocY9ZzYTHcdwtpMCGIh+XT
         5hMANqFMu/6ezoPl49ILkFIs39sb1CUThReBbxhWy0VO4SRl/Q4MZVLx+GY+R+oWHvLr
         J4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677948; x=1777282748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCVZolkJ/jGGZ3sp1HB4+a9dT+5CyB5mH+bc98lNAj8=;
        b=UDHdNCTgx6jCWJDq7EYxHcU3q2gZemBpgLm5DFhGd6/kw/WKLkFR2R/YZ5p3gGJix5
         zlOAb+PHdeZ4HBBblVEs6S8HPg0WoygFZyI8AkSBbsK0hfoDjIknhGdiZEA1RIbEBVSL
         nrXsaCpDHKSJDik4hc13JAa8ciT81Wvvc5k1VlkOQ1A/pcA/zVCHRmVLZ+qZhYoO39Su
         nyO1PK4uN74XI4Lo9JYRO84H8oSeL0ltU6ChmHHXUv35HHMwiJssJnaRihQ6BM/qx5MY
         hmZedXsCm936Eo+4HZotfNbYBABw7nRlzm/8YFfWs/TUQUuypHlawduhwSGOhHPgHvvB
         zOUA==
X-Gm-Message-State: AOJu0Yzs6C+NzGqClQBihBtfeLBdUMOC/o2u1slrCkmKJBqHYySmN7/Q
	TWL5ktDOrGXV5cGS/ksI09K+weBzsP7C9joqnG4JJNQ+iZ//F/kr0KpP
X-Gm-Gg: AeBDieteon5yV+AyGd6fdRCej45pqf/axem/qHr8GmWU5vKfQ2m2Ru+5MtkhnxS2HmH
	GfYplezDWkTmGhnIyJUBK+jC+CIi2YK2iowz7DiGm5b/ZCAZpUCz7ACVTHuN6EdAcORzwsVVvbe
	LB9Vjce77mPMxEqX+ASMdo6TNZmpQ2SEU90knZaFzkc5dAZoMm5leaUotf9pa29SN4FQk8Yi9gL
	ZW3H6vg51MYwwhZ6k4ypkfPHAfKC5Hs2KCH1H7JqQbB5sP7/TR8LktM78C9icXNfiRBOSviuM2s
	6U8PMZxEI8Z+NX0z6iZJkXMqFL2zz76KK2te3nPcLBtNwA0RYJeAKXgz20toldzKMDHG8vqwb6Y
	PguPcDO9nZ9mUUQfT7632TCLAas/O5KiiRQ0aYbpUVVAU/cF9VhhERJ0dEjmgh4Unp9DPVN0gxX
	X3/NeBXzRwBTMWPBSSDt/pT99R4lCy6Soh
X-Received: by 2002:a05:6a00:340e:b0:82a:fc5:fb81 with SMTP id d2e1a72fcca58-82f8c7d109emr13729867b3a.5.1776677947512;
        Mon, 20 Apr 2026 02:39:07 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:2038:6723:d0d:eba3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb33fcsm9681407b3a.33.2026.04.20.02.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:39:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries/papr-hvpipe: fix NULL dereference in handle creation
Date: Mon, 20 Apr 2026 17:38:56 +0800
Message-ID: <20260420093856.123681-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238730-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85302428ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

papr_hvpipe_dev_create_handle() transfers ownership of src_info with
retain_and_null_ptr(src_info) after anon_inode_getfile() succeeds.
However, retain_and_null_ptr() clears src_info immediately, and the
function then still dereferences src_info in the subsequent list_add().

Store the transferred pointer in a separate variable and use that for
the list insertion.

Manually identified during code review.

Fixes: 6d3789d347a7af5c4b0b2da3af47b8d9da607ab2 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..497eb967611b 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -480,6 +480,7 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
 	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	struct hvpipe_source_info *owned_src_info;
 
 	spin_lock(&hvpipe_src_list_lock);
 	/*
@@ -509,7 +510,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	if (fdf.err)
 		return fdf.err;
 
-	retain_and_null_ptr(src_info);
+	owned_src_info = retain_and_null_ptr(src_info);
 	spin_lock(&hvpipe_src_list_lock);
 	/*
 	 * If two processes are executing ioctl() for the same
@@ -520,7 +521,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		spin_unlock(&hvpipe_src_list_lock);
 		return -EALREADY;
 	}
-	list_add(&src_info->list, &hvpipe_src_list);
+	list_add(&owned_src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
 	return fd_publish(fdf);
 }
-- 
2.43.0


