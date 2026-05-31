Return-Path: <stable+bounces-259382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJekGVWiHGrhQwkAu9opvQ
	(envelope-from <stable+bounces-259382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 23:04:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 016E2617F30
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 23:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82912302334C
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25C34753F;
	Sun, 31 May 2026 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kqZlsZSu"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29242DCF6C
	for <stable@vger.kernel.org>; Sun, 31 May 2026 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780261426; cv=none; b=LOeNo55TxWU6WWcxPnpCsGq0elQFhUZFAXp2N25LeasKgDRkAIp3jDhfajc4wE07fYpU8TcxoqsfJOeYTYkJ1R9Orv3bLif9P32itJjmNqgp1wCovh88K6tNir6vp1UgVHY3wMSSCVwR6J+CPk1bXXEQYQbkt3Jo9ZEDuI6RaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780261426; c=relaxed/simple;
	bh=Slrh7c/WpgTXIB1M+3Ok+vmHpA0rkcf7FnFXxIdLGL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeNf5Do7tICJAjVyT6qmrYImBlYqzBWF8A/Y5/6Io1uNx9VOqvap1DSHBEwz1ca+PzdgLOblylW2FHlJMlMULdn5oBl7apJwGWX0uFz0/nUMM+8dnoRN3i14IbZyPzUTqBKvjJjaOM4bCW9ettERuAVwJARCIXrolO5KvlpiJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kqZlsZSu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9GXwJ8Qss8MUb/Kr/4sQ3HKMVGmXDM6Ezfo8jhqq4po=; b=kqZlsZSuBZSf8K1aR2qM65/xm2
	yF34GBESOEomcI1QBShkvLGyxsyzYokgSBXI151rBWLSOhVePzlo2tosXIVcu6zynYEh5qsntGcMc
	XyH4qVSNDOhhYXP49DSkqdySAU/vp+tbUVh1sCBHY07HySNtPULU/PWBIcctlehh5A9CLKm53gy76
	Dy5a3ihfnvn0h9LXp6UgLjoteCiUaj8ew6rZu3Y0w45ESmhG1ZmAOSZDS+eEKpVtDSUrQEzjotLIv
	0LNrO68RD9UFDofwJ+ZNDfol10KWNHVBq2iOiLHz2kE5utbm61g8GrC5WgFjPfpCM90AI3fggcHts
	is6cndKQ==;
Received: from [189.7.87.67] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTnJt-00AhRK-F6; Sun, 31 May 2026 23:03:41 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Iago Toral Quiroga <itoral@igalia.com>,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.12.y 2/2] drm/v3d: Release indirect CSD GEM reference on CPU job free
Date: Sun, 31 May 2026 18:02:02 -0300
Message-ID: <20260531210323.1637818-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531210323.1637818-1-mcanal@igalia.com>
References: <20260531210323.1637818-1-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.64 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259382-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.944];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 016E2617F30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3d_get_cpu_indirect_csd_params() takes a reference to the indirect BO via
drm_gem_object_lookup() and stashes it in cpu_job->indirect_csd.indirect,
but nothing on the CPU job teardown path ever drops that reference.

Drop the extra reference in v3d_cpu_job_free(). The NULL check covers ioctl
errors before the lookup ran and CPU job types other than
V3D_CPU_JOB_TYPE_INDIRECT_CSD, which leave the field zero-initialised.

Cc: stable@vger.kernel.org
Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Assisted-by: Claude:claude-opus-4.7
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260515-v3d-cpu-job-leaks-v1-2-7f147cbbf935@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
(cherry picked from commit 6eb6e5acafa46854d4363e6c34981289995f3ace)
---
 drivers/gpu/drm/v3d/v3d_submit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 40c21aaade0d..23472c7af41a 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -130,6 +130,9 @@ v3d_cpu_job_free(struct kref *ref)
 	v3d_performance_query_info_free(&job->performance_query,
 					job->performance_query.count);
 
+	if (job->indirect_csd.indirect)
+		drm_gem_object_put(job->indirect_csd.indirect);
+
 	v3d_job_free(ref);
 }
 
-- 
2.54.0


