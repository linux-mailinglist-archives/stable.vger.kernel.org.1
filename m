Return-Path: <stable+bounces-244271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CGJN+hu+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750B4D44AF
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D7923023DA1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1C48C8C1;
	Tue,  5 May 2026 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fVQEbrBl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9B34BA5B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020068; cv=none; b=DrMKBQmSl8CNAEsh3k2mMj2ONdaS0p96hUlkcBDdzWiAyYBa7UsOcojy9EZX2s0qjK/NOI6jr8blyqDTjvfhbCgbmWYYBpVojSAF2f2x29wXCnTdGYaRVxHk8Fl2qSIo707Opfb4bD8oXaetb2SDVAFQPX3MbYXTFrZfYmx2mi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020068; c=relaxed/simple;
	bh=8HXIJkmC+IGBaMLd0ZJQn3nXQI9EHPPxuSknY0+Nm1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDeW2HOIHqHKRp45YxnXTVrTen+MXVnywIyjLGirKL3DaowXXgEx0WVLi71XrfkjmF3Tp+dU5xEi2m0CZu9JsSVG1IaUolQSojKlP/lMFZ3FgEOIfGMed5+7E7f1pVF7NJ9p3htkaRqSK3CbCaz23iTq+hyRY1ZpGqQX7VoTwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fVQEbrBl; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3653cb9c6f8so2597536a91.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020066; x=1778624866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrZNRShoG9NxgTRlEfwE7/QFVxhrzc+ecj5iGQ5Zu5U=;
        b=N2oFiupOKFqGoUiqwLsZVc2uuMqfEKmqXIo8a30EWLYdzhXIsWEztH7g2uDY1RV3tS
         84GQqoY2YHDdgU6X6oqg/DciYDSRN75t4ilpM0KUIMKw/t7U2GASLIG33Ej7wCl0JAig
         Kn15StAhbeouv67mCqoMqgjZ7jMVzpYlqjS1krgmRnGyNPkkODnKNVTxY1v7x9keVNTZ
         yQQov4+t/D+LXEWlxG9eHe8pqoxlqn62z7siaoRgnuE8ZE6/ybfhU/KX9NtG7BNjclcN
         MsAst+nwbF44CMG4q2rPhPDXwAYDBDislGO8M2qTMuzlzWIcTrA2yam14zHil1eI71Ls
         ao3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9oPLz1ESJxaVJ/hNnvI7EKd0j+NlXktcynQsFLtn9H6iNkK6gZCVG8EWumb4CZ8/fkTpbd03w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCav8flFFRTjYhpKny61ia2db183zelO1SC6Gcb1j83tdRn8C
	kJNf+qRpqPGBl/hmoBN4q2k13HOCY6TB1GwuOH7eVlGexJ7emsM3hpLE2HuPA8L5OdWuSscsxs1
	jQurK7shbgjx92EcVFQKa4G3pUGhtuxkcyUXIsB+5EZ9l39Niq+AAvar7mQiOKF7z3YgEThTZBJ
	ozTedpF+zhwEBbuYRgfBm0hBUgDxJ2r2shberdukpdQZlw6A7IzA8O3/HfHbqHkEgtREO38Wye9
	V5BwNtp
X-Gm-Gg: AeBDiev2BykXkstZ0qKjM6DsJcwi34OgzLDyzRBuepJsBzvX+y0Fi5mCn8goc+I4F7M
	nuLWpeqfK6ljURnup4/kzTSiA8JeV9X56YBN0w8ZEpBkJ9o22NfeA+12tuZTzH4F5o8AXi7Gk69
	E6NTvNciFRuCQuILXQPULjQz7dLHa7ft1L6f19j2gMLU0BEh11eu1j/DBGnzTmjnH45iZImTyR1
	UCjZ0ocYzvW0xhTXV979dhTn2fC67fRUlP3snr208Ea7miCz2fZ29GohOScZVt+NNJlcZgYQhT9
	cAdv7U/1fUtGBSai1KGdFB/pIvFG89nVsIFhU+twVCIbvIbrUvdrIij9t99R2CfbAIdoA6JtK5O
	Nz2at2k1MXmqYqd8WnMoF1XEOeYve3mnuXJJPT5y37gcWNPgUs0csOKabhBbCZOTqYvbGqf4cg8
	t48AxMfilx1YdXuzq9DgkMKq6Ox1PLdg79lWmhFjAD8gyoBNL0iPACTueUMQGTRQl7
X-Received: by 2002:a17:90b:580c:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-365ac272cf8mr667305a91.19.1778020066533;
        Tue, 05 May 2026 15:27:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-365b4c746dbsm569a91.8.2026.05.05.15.27.45
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8badccc9194so44860906d6.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020064; x=1778624864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrZNRShoG9NxgTRlEfwE7/QFVxhrzc+ecj5iGQ5Zu5U=;
        b=fVQEbrBlQu2vbIj1XgxmCahlAtfbVjEm8IUN+yGnd1c20sdibvmkXqnWD57N6ois7h
         J7d74G1p071I//toZkQVw1nwipGj15T7NI/LDQ3gsS5DZ1xBZ0gi6gKZRb15sbyjoppu
         H9Cb6wDW3T4fzcj4scgHeQWK3Co+gVrpVKenI=
X-Forwarded-Encrypted: i=1; AFNElJ+BB3Cmsam9mu33yjzyYzC9+PmKybi88gDoGmLsmfA6J0cuCXfaTzReHEov7CiPU6SQPgs3gpY=@vger.kernel.org
X-Received: by 2002:a05:6214:246e:b0:8a6:1216:fb7d with SMTP id 6a1803df08f44-8bc45845af7mr11077746d6.45.1778020064551;
        Tue, 05 May 2026 15:27:44 -0700 (PDT)
X-Received: by 2002:a05:6214:246e:b0:8a6:1216:fb7d with SMTP id 6a1803df08f44-8bc45845af7mr11077346d6.45.1778020064071;
        Tue, 05 May 2026 15:27:44 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:43 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/12] drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size
Date: Tue,  5 May 2026 18:22:22 -0400
Message-ID: <20260505222728.519626-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 5750B4D44AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244271-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Two sites in vmwgfx_resource.c assign boolean literals to
res->guest_memory_size, which is an unsigned long allocation-size
field; the intended target is the adjacent res->guest_memory_dirty
bitfield.  After the assignments the field holds 0 or 1 instead of
the resource's MOB allocation size:

  - vmw_resource_release()       writes 0 (false), and
  - vmw_resource_unbind_list()   writes 1 (true).

Subsequent revalidation paths read guest_memory_size when computing
the dirty page range (vmw_bo_dirty_transfer_to_res()) and the buffer
allocation size (vmw_resource_buf_alloc()), producing zero-length
walks or wrap-around ranges that read or write past the MOB bitmap.
The dirty-tracking intent of the original code (mark the resource as
dirtied since the last sync) is also lost, since guest_memory_dirty
is never updated.

Rename both assignments to guest_memory_dirty.

Fixes: 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 388011696941..e3a187a2c7a1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -136,7 +136,7 @@ static void vmw_resource_release(struct kref *kref)
 			val_buf.num_shared = 0;
 			res->func->unbind(res, false, &val_buf);
 		}
-		res->guest_memory_size = false;
+		res->guest_memory_dirty = false;
 		vmw_resource_mob_detach(res);
 		if (res->dirty)
 			res->func->dirty_free(res);
@@ -773,7 +773,7 @@ void vmw_resource_unbind_list(struct vmw_bo *vbo)
 		if (!WARN_ON_ONCE(!res->func->unbind))
 			(void) res->func->unbind(res, res->res_dirty, &val_buf);
 
-		res->guest_memory_size = true;
+		res->guest_memory_dirty = true;
 		res->res_dirty = false;
 		vmw_resource_mob_detach(res);
 	}
-- 
2.51.0


