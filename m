Return-Path: <stable+bounces-245068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIZ+BRfoAGpaOQEAu9opvQ
	(envelope-from <stable+bounces-245068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:18:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676425062D4
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71097300C010
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D82F0C7E;
	Sun, 10 May 2026 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNsOcX9m"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E025A2A4
	for <stable@vger.kernel.org>; Sun, 10 May 2026 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444306; cv=none; b=BXiJBqsnB3FTE8K11iPEKup3bQWJAy9RTn96ghz/rfs59q3/KQL3+CmjHjkSwD5jRp+TQNGIwRhVDr7fAxJjCMF81WyH3WHpWyWy/TAaDahbvfThviMI6vqsT6i9HtPOuRWpz2nBb23epZ3IojlyFjnhmqId4hx3Hdll4I9YfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444306; c=relaxed/simple;
	bh=no/1qeHJkclP/vqyRMHVtp/AFnakt9WfqICbC12BM5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ptV6yRFx7Wtw2m1SL/azJwM9p64TGqFaZQskYgKS983vbF5TzsaxFUb6Sc7FolkhgK9pHE25YvMQTIZZDoUjCHAkwtoQWfqJ8zUPwWuCIiP/1BJ97orsefCHElEikZI47vXDgi20Wz5BRMNIxsq4UYFxZMXjAdS7LMWujixlnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNsOcX9m; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b7105dfb35so37977926d6.3
        for <stable@vger.kernel.org>; Sun, 10 May 2026 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778444304; x=1779049104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K67pIs/nY03A+3XziFzgPYzBlsoSwWL+5glnFKhN0Ic=;
        b=KNsOcX9mOEDPDam2QjjM6c90iLxrqDMQNOgN7akxUD9yRAZh9safcSjsHBnT9ZGJCw
         Q8R9Qz9SYgYXnNJ0/5Ru6t9mJw9Ntw7OQ4BzMrxGqr448iFPZ/nU8RoIxnA/VLshftlW
         wLwxn86VNyXGQt7rKvKNytqRIoCptrjjHFPW4C8gffX5qikodHm0nb3HoPdOOtrzFllz
         R9tzeajnVb/3rZMj4eWL8gPqUhv94vvOLv27VEguO4onR8qwyGesm1oZ49gcZaaNLULN
         nj9VzQYtBiz5vAtlvuaWMd5fIv6Tr0VsxfIHSctWn4BCBA4uORgxSiOtKYsaONuRJr8H
         WfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778444304; x=1779049104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K67pIs/nY03A+3XziFzgPYzBlsoSwWL+5glnFKhN0Ic=;
        b=IXeSdkS+R/aYz7YF/gl58Upd84he0qwfvcPg5FslpwUJF5xMlwuGuOdW3Z8M+vHmp2
         Ycs9KIjfD5Pc+gQ/WXT29UaFWOhbhzJraqhFw+LM/+/OG+qyXkIDq0IEMkUH/0wcMIVy
         dy3lcWJ10DcRN4eDWfMz7iok2MZeFYiLTY1TJkbe400WBJ7PJiVGZgUiADFWhj5rXyKj
         rinMl3jb4zRBi7l6fW2Dk5cQNCmI+6k1b73JoAcA8KNs2bjEfAZTc2k8KKgCn8/5HeeR
         Lh31PgcasDT0iLHkJnwIkKU6w8xZpxXDZweRn573kw1SxE63fgAJ5G+Rem/7hnmTB11d
         JK8Q==
X-Gm-Message-State: AOJu0YwAtm98OYw33cy15NWMon6fBuMyrt+lzcPYBnvuGVgYbPZt86uz
	s4IY6GqJlYDz6OkEUluGNd1TPhMQLXCme9iif5MRFQyJPwOuN+mncaUhIIQZVGaCs5JAEQ==
X-Gm-Gg: Acq92OEfS9Jm775ktMg/Q3RndjPuTyJ72ObTj5sqtqLxYpwaOI1DWmiF01RjHbmdUtt
	A6/cdJLdXWf2VmKNoKj5bG/bypH9Om0DFZ1WcJ8QGPOW7cfl8pjDRtxpGK4feV77H4wHckun9Bk
	qOTuGzhqxMcT/TV6TK/WJQ1/ONZuYu9qfJfumKd8/b+bXzzSCc80jahO01TfTVxXiMwy1Qy7UGH
	u4/WOswySbfPe94GdPAJRzgOhHPbS727eXD/y9Igbz4MHEOpXnq6HMpdF1qcO4czgb3zpdGM2/5
	0Nf2VIufiQcTf4rlPYw9qBymdt01dIItMTOV0mqzbB6KKvNH4HrYd4vfOq6pvmany5lQJDK5mLl
	5RGrZ2IeuLrPKGZO2uDeSpegfegMF0uJdBeriGPoUkiotkcBoqLrOyGqY6Etxi5dUCA1HzwgINU
	6qrC7K7MFHjj2CNXiG0TYkCfiJpBw8s2qkG4/Cl8eW9uUaIkQeXR6OEee1gLxZKHZbiE9ZxGoY7
	BW+S/gis8ByP2Sh/XnLJi1BnkIE
X-Received: by 2002:a05:6214:5e03:b0:8bd:4bc7:e19 with SMTP id 6a1803df08f44-8bd4bc714d5mr285979606d6.47.1778444304161;
        Sun, 10 May 2026 13:18:24 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a43636fsm76040566d6.21.2026.05.10.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 13:18:23 -0700 (PDT)
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
Subject: [PATCH v2] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Sun, 10 May 2026 20:17:33 +0000
Message-Id: <20260510201733.2882224-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 676425062D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de];
	TAGGED_FROM(0.00)[bounces-245068-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
message and then unconditionally does:

  memcpy(bytes, &raw->msg[idx], num_bytes);

without checking that idx + num_bytes <= raw->curlen. raw->msg[] is
256 bytes; if a malicious or misbehaving MST hub sets num_bytes larger
than the remaining payload, the memcpy reads past the received data
into whatever follows in raw->msg[].

drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw (noted
with a /* TODO check */ comment since the code was introduced).

Fix both functions by using a single combined check
(idx + num_bytes > curlen) before each memcpy. Since num_bytes is u8,
it is always >= 0, so this strictly subsumes the simpler idx > curlen
form and no separate step is needed.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
Changes in v2:
- Drop separate idx > curlen check; idx + num_bytes > curlen with u8
  num_bytes (always >= 0) strictly subsumes it (Lyude Paul)

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 170113520a43..9416a48804c8 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -871,7 +871,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -907,7 +907,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
 		goto fail_len;
 	repmsg->u.remote_i2c_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	/* TODO check */
+	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
+
 	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_i2c_read_ack.num_bytes);
 	return true;
 fail_len:
-- 
2.34.1


