Return-Path: <stable+bounces-242637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPLRKenE9mnBYQIAu9opvQ
	(envelope-from <stable+bounces-242637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 05:45:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B84B4530
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 05:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C33AB300A3A9
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 03:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5422773E4;
	Sun,  3 May 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri736iXX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84D19AD5C
	for <stable@vger.kernel.org>; Sun,  3 May 2026 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779943; cv=none; b=oN3f47FT64nM0hz6WYju1V1nrHmSPMOX6syyYPBkiwOeu78ZLrkE0DEDz51UoCXtGTL7zCibydPUe5eVGAqoIHIT3S0ajmaIkUip9Ppd2IIAkFxcJ07z7c8CG7iZ9A+4o5OIZwLJGF54ZkR5gWNzHOSG3G5AjB96mwRGLRJQsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779943; c=relaxed/simple;
	bh=aoAj+gQoahG7S0iVGgSJk+XtiNbNUZMUxTlAg3Z79l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XemToGaQS4PRdFLDsYN2sHQ6QPUtyP3LuGvvaIZDTRycC1jgibU7CnD2NlXKxWnoi794og6oh1kp8RwN8GPIvh7MEYaSyPYjyJXGTdtM73wuBcphaLK+FUpjCWO7FarVHH+0tzaCqq2FxPrBwcxkvyWrRWJgrrth98LM6gDSGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri736iXX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-365212191f6so342991a91.3
        for <stable@vger.kernel.org>; Sat, 02 May 2026 20:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777779941; x=1778384741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SI2MBPlJf9O7ukydYqfXIQUzeildkAOurtWd8SQi+24=;
        b=Ri736iXXYT1WketKV3Moi47Ly0on4iCVAw200Da4+RTbTu1QHGHPmCY4te9LBXgSRZ
         7JFkM+7dauEU5KjK0cK7f5LRzFud6QW0aQ17QNd9MnW9wGFZSYLqmSeFFH62EzR8Ix/Y
         mRgSMUEIKGigKQq3/tn3YLqohBtTcIHaO3QcGyAoNiNXIeGPNF6nGce98jDMYMnX+Nji
         32wwU73FmsN01HwXQqSfPoinuRQS+kIW4jp81/JaW5DIGMCn7MpfJrZoae8dxEoSL0vq
         Q7kunI4yefXemS4jhpI9dFq2eyfCBXo0rTHhxEG0BbksjV950h8gkgOT2Ne7C3NBQ+vQ
         ATdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777779941; x=1778384741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI2MBPlJf9O7ukydYqfXIQUzeildkAOurtWd8SQi+24=;
        b=N/IaMzF1r8PvD0VPGO5kbkR2wPayHZ/1hsW8FczpDDfofojTcBSiLoCUpbbzJhmC4b
         OK9b2i4e9nBLuTpQ5NAnUi7RLEd5kdwSPGzW4Kh/5caT0h1cEaEXm+05eiUlWg0PPCZH
         qPiwoVI2Oja8Ik61ELLHxZjuPaoQPEeSvQcGyAolE8Q/sWDKT6hqHOHrUt77rYbA4GMc
         ORN6IzUd+n3paQ/iRWw/6R8805jhzQef9OfHspy4sRnAMIzuiSwDGro5qDQYdh3/yscu
         r7+DUt/JliHIFRQU1j5mWV+28NpTqtJCwaDJpi7aDg6mnbz7HKhMgdrSkev1QgE6g+QY
         KD5w==
X-Forwarded-Encrypted: i=1; AFNElJ9ghzZGm94QTaE0r8S4vBtkB1nYR2clSHyrm2Lx3woxZyxYcldccOkzepOUPOyRhsjHFVJS+rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUnP4JeRMzeVESHCvQX6lTNXdBqdG2H9BVRAiOXrL1emRMgWe
	q+Ctq9Vhd24BkbiFVCL6mqXIebFDFfWg+ltaeP7TmXNgK4tnZ8g9ILB8
X-Gm-Gg: AeBDietyeqk+NQyKr3GluiSEaNFFomeHwmX76wFp+yuei6gkD7sFzRn49sNaS2Rtc2j
	EnmUR7vSKMn1e1emtYJVFLSMiRI0AddZd5nEz+F0ieeMVhoX9oDZ2xt5DjY0APGudi8Ul05qpik
	07LpnJ/wOgg1aw4eoP9Io6h2OUF8w86NeMXXuFOHYYwUwESjnMuWSazMrpAfrnBbxfhHpHJOFWq
	OW1aZVZE2ZeEK/vr4geLYJGTbuBBie08HCibYxqcnif2Tfyv6S4ikmMb+rypYoZYAxUwomGXzLE
	drl9ynfeobLN3eRueHYaLrLYTexStkk4gPMN2mX+fduKU7N+i/L8d//C+NP8yhC148kQGKGrhC0
	yK9vZKqbqUYwAShT6xni5TcG4eK2RjC0m4GTUBLHNqWfGZyYT2/MZ8CLo0ALc74lNpGdIeeaocp
	fe0Ql087Y4dz2+3swwAIorKO7zUXJMGHpTfXvgzEghjfOp5WvUHq3+vdKS40onOQVU
X-Received: by 2002:a17:90b:5887:b0:35e:581c:6bca with SMTP id 98e67ed59e1d1-3650cd25673mr5014165a91.3.1777779941198;
        Sat, 02 May 2026 20:45:41 -0700 (PDT)
Received: from jester ([159.192.33.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf54203sm10082989a91.7.2026.05.02.20.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 20:45:40 -0700 (PDT)
From: Jonas Emilsson <jonas.emilsson@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jonas Emilsson <jonas.emilsson@gmail.com>,
	Imre Deak <imre.deak@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	stable@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH] drm/dp_mst: Handle torn-down topology gracefully in drm_dp_mst_topology_queue_probe()
Date: Sun,  3 May 2026 05:45:33 +0200
Message-ID: <20260503034533.1023686-1-jonas.emilsson@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F2B84B4530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,redhat.com,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242637-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasemilsson@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:email]

A hotplug or link-loss event can tear down the MST topology
(setting mgr->mst_state = false and mgr->mst_primary = NULL) concurrently
with a caller invoking drm_dp_mst_topology_queue_probe(). Since the check
is already performed under mgr->lock, the condition is not a programming
error but a valid race -- the topology was valid when the caller decided
to call this function, but was torn down before the lock was acquired.

Replace the drm_WARN_ON() with a graceful early return. This eliminates
spurious kernel warnings and the resulting compositor crashes observed
when connecting/disconnecting DP MST monitors, while keeping the correct
behavior of doing nothing when MST is not active. A drm_dbg_mst() trace
is added so the skipped probe remains observable under MST debug logging.

The existing WARN_ON(mgr->mst_primary) in drm_dp_mst_topology_mgr_set_mst()
already catches the case where the topology is initialized twice, so no
diagnostic coverage is lost.

Fixes: dbaeef363ea5 ("drm/dp_mst: Add a helper to queue a topology probe")
Cc: Imre Deak <imre.deak@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Jonas Emilsson <jonas.emilsson@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 8757972e8..0cb341ce1 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3738,8 +3738,10 @@ void drm_dp_mst_topology_queue_probe(struct drm_dp_mst_topology_mgr *mgr)
 {
 	mutex_lock(&mgr->lock);

-	if (drm_WARN_ON(mgr->dev, !mgr->mst_state || !mgr->mst_primary))
+	if (!mgr->mst_state || !mgr->mst_primary) {
+		drm_dbg_mst(mgr->dev, "queue_probe skipped: topology torn down\n");
 		goto out_unlock;
+	}

 	drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);
-- 
2.51.2


