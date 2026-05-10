Return-Path: <stable+bounces-245070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN3CBl3rAGrbOQEAu9opvQ
	(envelope-from <stable+bounces-245070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:32:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF13F5063D9
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C91301497B
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D1334C1F;
	Sun, 10 May 2026 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+HSqjha"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67348282F3F
	for <stable@vger.kernel.org>; Sun, 10 May 2026 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778445135; cv=none; b=Wta3NXgHtzKT//erQniZbXzgVcw2qVvgGZybRUSVKNUgZO7QLlrwwTvdoVWwOVDuQrhmBND7f2fNX2zEONuCmT3i/L/YAYMSrsvbsTHlFlxkFhexO/czUlc/Ak21DKwcORO4naDWRVUZVzfR0JSdlBar7QVBFm2xvf/II/1eHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778445135; c=relaxed/simple;
	bh=p7VqSN2UpsNMNe8MEGLukrdN+9KxN+Fp71w4tceNRFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h3Y28NJdgPHPq+haZu4fbm7+40epSWVjFUU7snnS0FcS+s5KbFUve6NezXniKTBtrFw1G2yVl6hmoTsNpq08JBCvzMZi9txlwYMPzRro33EHza/XqpWlhJRrzOjmLcaxelTiSwZb7cccWIVlxHZGTaecl+2ft5X+KBVd7G1z3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+HSqjha; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b45dff1eebso36229716d6.2
        for <stable@vger.kernel.org>; Sun, 10 May 2026 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778445132; x=1779049932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GH0BIPUR5p8mIEZWyU6SEUzThcS+ZdasVBlkjfRz1DA=;
        b=q+HSqjhabRI88lWxRTy/z9TL4aQSGtvs8jVOsjJCIw8oAWuvES6J+sNbfSszTtD9zH
         sJGisgNbbh/9inZPFrMLhOFJuuobgRQXim1eXfM/vfNrR7RE0qAiSRDAAqhyE1c8KhTm
         uHwJnl5UKA9KFYd1N/1c4++VPOSaY/hx0ydIAtYrJaWQ8SNreYPTV+LVK+jBE90/mgud
         nLpJTHvYNyxKdRdtO34r7kR+Ih/ROOd3b+WrafSOSu+r/DZE+ltW1KCcPdzJW9ZyjYhn
         pWdjGetm+wuR8Xl7qZZ/MDdWXKjt6Q9h+WS7yA7H7bvggmvfUxa7DADuhSe8MuY3KHzW
         UoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778445132; x=1779049932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH0BIPUR5p8mIEZWyU6SEUzThcS+ZdasVBlkjfRz1DA=;
        b=leaOSYrWutNpG5ljkHrOT29L45HUmnvTWC9YdT0UG7OqkWQ0xzFTCvWkQWAxbHPxCz
         ZaiKcQ0VGnZDztPaH59MKQ0K0aX8qVXUh1ZnHew8ROBRpg9BcwZvbXzqyumkx5dIUNcu
         Z2xKQyusTmLL6b7N1iQJPJJ/K2gxmMFxXzow49rM+m0bQ6R6IYogCEPMPoCNjbCr2Iyz
         7a/XbAJXPD2p5PQggeZOBRnhTsgFvTQ4XOsYaViLwylUjL1ATLWTju/b0Dg5ZyvwYRu7
         Qj/trx2jUchEsCHaEGxrPbgK5GItHojvXDL3TVjRIQ0KJP9yWc57rq8NL3r1NTuKDQB5
         JS1w==
X-Gm-Message-State: AOJu0Yyn6NViNuROdctyd7G+UYrunoJJGVauOOv4euoB9aWbbJT+Vlto
	ZiuS/5OLJ0qP3taldcGVgM4dl21p4Io9ol3B4S/DN0Ld0IcfbNHPqUW3
X-Gm-Gg: Acq92OEoUX+jSE1XVL4O9VXJZnYqH6a2GEXgLd9fElKbJlkzqCJuEyHe1vlGYCitJjB
	wdKGnOAoVnxoCXGZzuSf8c/w/SWbkVsr1/kcmnRDlind9GCNVBaBi+nFzn7nDQTT/C54Ie9i+dZ
	GOdXdUlfbtQj+5ujIjLPMRlZWlmQSwX1sENH5LGBOob06YreUjA3OkXDrBvHbM7B6IzkkZCGaPZ
	mJZmwc9NwFfjurkJXdFmwKASwE/ZeK9dk7iJPqAEoLhZJ5JSqcsNcqqwN61ggKnw1LgSRMXHaTz
	qOP6WdM0Zb5ahpUR5Z6Bc8ighwV5BCTKXWg2txfPouCnTJmjVrhKunUhlYv4/stn1KSIiJ0StQX
	2I4tZnHx1GVymFdsMNrPSyyhoA51CWrhk2ItRTcx29TUSD/GJb0qCIB+tj/2oxxYZEfnZDijVi7
	jw7AzUWq8fTwv7v+ltYUVnol16X8B8e6r3DLK7NFkBcmHVBpgQI1p5MmZOpA5F3HihzpEIs5PiN
	q4PJSSpEktKm4ztvfQB1u+GHv3tpAz+yc2CCB0=
X-Received: by 2002:a05:6214:3111:b0:8ac:ab13:8f15 with SMTP id 6a1803df08f44-8bc41cc2ea6mr361413956d6.7.1778445132299;
        Sun, 10 May 2026 13:32:12 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3addb3aasm76968056d6.10.2026.05.10.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 13:32:10 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	lyude@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers
Date: Sun, 10 May 2026 20:31:28 +0000
Message-Id: <20260510203128.2884846-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF13F5063D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245070-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Three sideband reply parsers read 16-bit fields as:

  val = (raw->msg[idx] << 8) | (raw->msg[idx+1]);

and check bounds only after the fact. When idx == raw->curlen,
raw->msg[idx+1] reads one byte past the received message data into
the following struct fields (curchunk_len, curchunk_idx, curlen).

Affected functions:
 - drm_dp_sideband_parse_enum_path_resources_ack()
   full_payload_bw_number and avail_payload_bw_number fields
 - drm_dp_sideband_parse_allocate_payload_ack()
   allocated_pbn field
 - drm_dp_sideband_parse_query_payload_ack()
   allocated_pbn field

Fix by using a single combined check (idx + 2 > curlen) before each
2-byte read. Since the check is strictly tighter than idx > curlen,
no separate step is needed.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
Changes in v2:
- Drop separate idx > curlen check immediately before idx + 2 > curlen;
  the combined check strictly subsumes it (Lyude Paul)

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 9416a48804c8..6e7896193772 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -925,16 +925,13 @@ static bool drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
 	repmsg->u.path_resources.port_number = (raw->msg[idx] >> 4) & 0xf;
 	repmsg->u.path_resources.fec_capable = raw->msg[idx] & 0x1;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.full_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
 	idx += 2;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.avail_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("enum resource parse length fail %d %d\n", idx, raw->curlen);
@@ -952,12 +949,9 @@ static bool drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
 		goto fail_len;
 	repmsg->u.allocate_payload.vcpi = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.allocate_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n", idx, raw->curlen);
@@ -971,12 +965,9 @@ static bool drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
 
 	repmsg->u.query_payload.port_number = (raw->msg[idx] >> 4) & 0xf;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.query_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("query payload parse length fail %d %d\n", idx, raw->curlen);
-- 
2.34.1


