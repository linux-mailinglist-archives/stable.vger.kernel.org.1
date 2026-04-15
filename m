Return-Path: <stable+bounces-238033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BlFC3Eb32myOwAAu9opvQ
	(envelope-from <stable+bounces-238033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:00:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A0400497
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60A3C3092666
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF9B2D8DA8;
	Wed, 15 Apr 2026 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkik+nEJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE933985
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229228; cv=none; b=YO5i16NjiMCG0mRqMTW59LxAXM8a5bXbYtn+TN9rgrHXbY4Pz05P3trDBDA9yC4Hyp8v4wyJYUAN7CshUS/ZcQjO0UgnKPg3uaovyX9XYy1w3JFQMBfZpg/91angx9R3aYofyrTkeq/536RPFUgDhN6iR1i1W0ol/KotYwIWJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229228; c=relaxed/simple;
	bh=Fzc9eqvLzNuwDX6zkwsl6r1NdmrlNbLoWZyp60IKOpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEB6HzV4WZSeOQRkgWU2KZkcvsZbYQqexQ2LCcbZjUt7Y5P1c6GP5t05lcp8FmTu4brfiH/m+Kk9h0YNhAYiu0PIbdrESzM1GzGL6h2XzzmWxtz/2dkBAlpbz078UhYaryaGXVuTiUyeN10XSlFW74MgKABmKkRat8E5pJodaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mkik+nEJ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a58057d7baso68365186d6.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 22:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229225; x=1776834025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BD0Jh7NHgh3Rj0E+5aYakpmd9tAV1Auw6G8xYy/O08k=;
        b=Mkik+nEJ2DeXlyEy65i+ZTw64CdwgP2EFUORrwofHzStmuX0wmAHqZ1BIO5NRwLHp0
         +hqUfCunHozkzW8s1wBGo3NAD3JCaH87nIX1zc6F2UD8nrri4YjUkqeHArY4JjjyztMy
         umcs6WK+pNhq0Uo6ezAtJA+H/q5CIWWxUpCy2StsFfOJujJx22vfxUJQjaDLhB8U3+3O
         5hZDDytUK2RAC3Yb/hw3kzrHVKsIz9ZqLSqtvdAjKi7vUth0AQn80dIfZPYD8hBEgfiR
         FCgMv3mOECMchoIUNl8RLADeCgMd7VnP9JF7rdi+rVIUFd4gzrHlpzavWzfKWKC1M9Nr
         pAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229225; x=1776834025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD0Jh7NHgh3Rj0E+5aYakpmd9tAV1Auw6G8xYy/O08k=;
        b=aXG78C8obOAn7NLrwXpyYMYjTvcuaV10Kt59rfW8TEOeYsAPc+1soNN42NnebSGINH
         0njduDpxL/m2jhsKuXo5euEvDQLWxxKIJwh5nsdHMwafqsF+GUvf5rLqOgDs7ZhMHpSn
         ekTSKm6FQDQuqsMH0GuNZb1x5HNKkFocfGcVNgHrfgaMcelYrNCKz+Kba1/urYD0ebvO
         aPIN2q8mhXci2G1+Y8Vjk67O5voePhjz3O1ts5D138+lw57LmAyNCp1Evrdo4qB+pfaw
         lsQfG50ZV+Klk1uXSUhp/4894WqXXLUMBhdoRADvjiXzCwpZRidK6pyCVZapqKmNzJJE
         N5dg==
X-Forwarded-Encrypted: i=1; AFNElJ9Os08mHrQNAmX7BI8cRr1QgpCk7WUeV5UQ0TIxo9afJyYZXlGEAiQl7iKMz/cmyteQQ29cwNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy20hpwBtuQIR8kaxF8yFUi6+hIzmmMO1X8zv6vukfHdbNI0DL
	5FEq2GHXJV7kFekxQ94Embjw/6rbPgPkqFmfWiXzYOkS2mLE/yPbrgSr
X-Gm-Gg: AeBDiesLrXCEch/e9AgPPjpI6a8fxP/YDM3S4J2cFBBycNGLYkrREKxVLwXKkm5K8wr
	hRAYfYFU8V4mjvusuvSQ1qJczM2O44RZpSEj91++GtddaHTWix74+oqTbDpYvF4UyA1tb68768l
	4WSxUqoGsEEqe0wXmqtvjhMKvBj0bifWIaKdhFIOQsHSJoA6cyZMhEZsG8NrSueowSqBWVnui8K
	dd+YPPCkmU1PPzLJtp1FYpCfORH72cwcsphfKiZZzkQ1nI00+bWMcQaAfxnIshB1XoTr9BI9guU
	6cVlu5x9Fi3x8Ry15k8DJ10s02kwxrFgL8c3q9Dc/oQho42Er4CSoWXpEmWpiu55/TelY1uNbnS
	yxcJY7Gphu4mKbtl5JhY+nXNz+kdBAo0ja6Wdik20EwQccmRDL3wSaigjlmuHIlfcO4z70LZG8a
	Ub/qkbm8Nsg5nOvw4zv6i9Xsg3vTCJjAqRojIVTMspEJzfiqmaQ3P46njz57418ifWBUchn7vWh
	4WyJu9W0Kmwlww+P9cOQCRqB54tOfpr9JLWAA+56o9HPWqSNg==
X-Received: by 2002:ad4:5f8e:0:b0:8ae:61bb:95e3 with SMTP id 6a1803df08f44-8ae61bb9793mr70305236d6.36.1776229224733;
        Tue, 14 Apr 2026 22:00:24 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c93b7e2sm3890086d6.8.2026.04.14.22.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:00:24 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: mwen@igalia.com,
	mcanal@igalia.com
Cc: itoral@igalia.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v4] drm/v3d: Reject empty multisync extension to prevent infinite loop
Date: Wed, 15 Apr 2026 05:00:00 +0000
Message-Id: <20260415050000.3816128-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[igalia.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238033-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF8A0400497
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3d_get_extensions() walks a userspace-provided singly-linked list of
ioctl extensions without any bound on the chain length. A local user
can craft a self-referential extension (ext->next == &ext) with zero
in_sync_count and out_sync_count, which bypasses the existing duplicate-
extension guard:

    if (se->in_sync_count || se->out_sync_count)
            return -EINVAL;

The guard never fires because v3d_get_multisync_post_deps() returns
immediately when count is zero, leaving both fields at zero on every
iteration. The result is an infinite loop in kernel context, blocking
the calling thread and pegging a CPU core indefinitely.

Fix this by rejecting a multisync extension where both in_sync_count
and out_sync_count are zero in v3d_get_multisync_submit_deps(). An
empty multisync carries no synchronization information and serves no
useful purpose, so returning -EINVAL for such an extension is the
correct defense against this attack vector.

Fixes: 9032d5f633ed ("drm/v3d: Detach job submissions IOCTLs to a new specific file")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
V3 -> V4: fix indentation
V2 -> V3: drop depth counter; instead reject empty multisync
          (in_sync_count == 0 && out_sync_count == 0) in
          v3d_get_multisync_submit_deps()
V1 -> V2: change cap from 16 to V3D_MAX_EXTENSIONS (7), add #define

v3: https://lore.kernel.org/dri-devel/177614548527.3603641.5360701002746181082@gmail.com/
v2: https://lore.kernel.org/dri-devel/20260413055230.3349114-1-ashutoshdesai993@gmail.com/
v1: https://lore.kernel.org/dri-devel/20260410013907.2404175-1-ashutoshdesai993@gmail.com/

 drivers/gpu/drm/v3d/v3d_submit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 18f2bf1fe89f..fc74351efad5 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -393,6 +393,11 @@ v3d_get_multisync_submit_deps(struct drm_file *file_priv,
 	if (multisync.pad)
 		return -EINVAL;
 
+	if (!multisync.in_sync_count && !multisync.out_sync_count) {
+		drm_dbg(&v3d->drm, "Empty multisync extension\n");
+		return -EINVAL;
+	}
+
 	ret = v3d_get_multisync_post_deps(file_priv, se, multisync.out_sync_count,
 					  multisync.out_syncs);
 	if (ret)
-- 
2.34.1


