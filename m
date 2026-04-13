Return-Path: <stable+bounces-235910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJWkEueE3GnnSAkAu9opvQ
	(envelope-from <stable+bounces-235910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:53:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E117E3E798F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D6530125F2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD47346FAD;
	Mon, 13 Apr 2026 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK0wsSkZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128F346A14
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059560; cv=none; b=Wc0HptaES/4+M1VdNNi5pcHQTyiqot+Xkyah0Qu25/+28V9v9T7iBG56JkrA1IwTgin6UKMhz1wpo/Jkaqe0KSpg7qpNAID91U0y/rK8hKyag1p23UZJy+OP+A2FbLJX3N56OCRS3qw0/mXJHScMX44FAQpjUqBSiqyl0WLSnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059560; c=relaxed/simple;
	bh=l0Cj8j3Q+NUX4biG01axjMgQqFX3+/yamm6QFzbDQsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDM9QFVIE8uaLwsnUSL6DQ7nwfVLWHm0DhylYOdhyc3ySajs0qOSwK0dl8gi2LfSxKZaKyxLTZjj0shPoBoIe8oYgX8Pgya9YpRqu9HWTEMc0Tspiqk3/3Q3coTCUqASmVQz/FtbgthgwFvSgenvK4w3bs4QaHlgMnMY9ArodlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK0wsSkZ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb38e86cf2so362547685a.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776059558; x=1776664358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSGzBK0vRtSGgnqUijtqcTjFMvAPUSIRJpU4Molx+ao=;
        b=nK0wsSkZW+OAyqnNrkr3JrIKEMjm2uKszDNz4HS/Dt5FaRezSI7FKuLkqsIwdy04q7
         PeZVFdgnkqJKXTwVOERCvjySLKyriFfdSXEoGe2UTpXy1T/Dx6hL2XdGGZSvNoU5ayoD
         IQZq5UNTJT3Sh/sXZFNblE3jX8Bo9b+oSgUaS4hUEHemujq8aLih1HY9cBeVPSotGjsj
         mS0y5Ynbyr5kpD4vReCTTmsr46MmfM9V63lCtPIuueRKiVgmmhugeNw5A8K3LJ2KW3pz
         3YRxYaL6ngjPWJN2YoumudPp4JQJQQxJewc6cP3d2RbxvaRAWaMqX5qYKCWtRMQhVqfu
         A73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776059558; x=1776664358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jSGzBK0vRtSGgnqUijtqcTjFMvAPUSIRJpU4Molx+ao=;
        b=meDk4//4zd1iAO2+z1ImxxnzImTFU/cn0bOsqEkAmWXQhT9EaVcWvhO47z+ZjFY2h8
         gdWujEPoSLcD1jIllzrmPDcP8otX5brL1LZ37PNDdfDnlCobb6qJW+WdFzF/sgdxcN2h
         hOIAih3wybQ0oGWzddPzFKF28MvA/0BmxZbHE79qhiZ6li92VTjSDgp11k/h67IcJeoT
         O3JZz28J7IOtbllvjQA48C1mScgFMSHQdl8KrTTEF3+Gdz4AVoq1/V5QmFYCJ+vB6wbu
         0/fNl9wmI0+U26cu2tnSgON1boRXxlW7joTC7zZs2BVlamKGOw4aU6MK+6DIKsd08j79
         vofA==
X-Forwarded-Encrypted: i=1; AFNElJ8e1V0j6Av2VbejNE9rkB+ttxru2qFSzdnvqE/Hqoka0qLB1G6yffEBI3dvdvtFXJr+C8/SLFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDsTNTc9PszZqFQHUbM8viT5ykpDLQ7zbudkGP7K8babh9gQe4
	Cmh9hpEqnFcFBiBYwtdWeu3kZL9yW0/RiCTL2yUlMMbBGgiBTeI4Ixw3
X-Gm-Gg: AeBDievr+MmD3gBVcOahb9HEe+ZSAPLDBWG33sWDM0QT0eEcJSj1AndjUoGWOhUmWJd
	7pS8SkTs1sJNUO8Za/Z8tFiqH5Kmy+2HAxWNxLlDY24lEFUFhjUKwziwqLFcEv2VkYIQl0rarmA
	hjdSy/3CTMlqiceimW7tpctqIPE/1AiwmLuZzI0adUzeov4zM79c0cjvvS7zEjRk3mkzvIQkf+L
	u0Cq6I9NFIW8pCCgrjvSeDU4zyFVdONtMN4Wdj5Q8HMudtJA0SgaKCZptYUpEv25zp6s3nOfhVe
	5Vy4rbgE1/5kKMeZsZkPFd41MrhhrjPpNV18iKF5rfAPjFNNtpLr0il2We3rJdjt3+zwcdZSxR7
	q7IKXV5SQHPD3elJ9loX30/CpBdJ8zmJbU/3SrqZQm9nxcTNzXIWmnqG7lcMacbPznqaFbJe2/G
	q37BKMiHJ01paLZ1YmkOW8LMq16kG3mBRaSOhM94U0ChHedn3BDAGg2p+SjdLYlAaiPRrzKrg/C
	tNqV7fk7erTPSLlbT9uXhAG4Sv+
X-Received: by 2002:a05:620a:2944:b0:8cf:c56f:cadd with SMTP id af79cd13be357-8ddcd02484bmr1777722085a.13.1776059557751;
        Sun, 12 Apr 2026 22:52:37 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb66587e4sm804111185a.19.2026.04.12.22.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 22:52:37 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: mcanal@igalia.com,
	itoral@igalia.com,
	stable@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] drm/v3d: Limit ioctl extension chain depth to prevent infinite loop
Date: Mon, 13 Apr 2026 05:52:30 +0000
Message-Id: <20260413055230.3349114-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cbcb794f-0d82-40b4-a9a5-6aca99e8c434@igalia.com>
References: <cbcb794f-0d82-40b4-a9a5-6aca99e8c434@igalia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[igalia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E117E3E798F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3d_get_extensions() walks a userspace-provided singly-linked list of
ioctl extensions without any bound on the chain length.  A local user
can craft a self-referential extension (ext->next == &ext) with zero
in_sync_count and out_sync_count, which bypasses the existing duplicate-
extension guard:

    if (se->in_sync_count || se->out_sync_count)
            return -EINVAL;

The guard never fires because v3d_get_multisync_post_deps() returns
immediately when count is zero, leaving both fields at zero on every
iteration. The result is an infinite loop in kernel context, blocking
the calling thread and pegging a CPU core indefinitely.

Both i915 (stackdepth = 512) and xe (MAX_USER_EXTENSIONS = 16) impose
an explicit depth limit on the same pattern.  Apply the same defence to
V3D by introducing V3D_MAX_EXTENSIONS and capping the walk at 7, which
matches the number of currently defined V3D extension types.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 18f2bf1fe89f..8951909198c2 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -11,6 +11,8 @@
 #include "v3d_regs.h"
 #include "v3d_trace.h"
 
+#define V3D_MAX_EXTENSIONS 7
+
 /* Takes the reservation lock on all the BOs being referenced, so that
  * we can attach fences and update the reservations after pushing the job
  * to the queue.
@@ -802,12 +804,18 @@ v3d_get_extensions(struct drm_file *file_priv,
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct drm_v3d_extension __user *user_ext;
+	unsigned int ext_count = 0;
 	int ret;
 
 	user_ext = u64_to_user_ptr(ext_handles);
 	while (user_ext) {
 		struct drm_v3d_extension ext;
 
+		if (ext_count++ >= V3D_MAX_EXTENSIONS) {
+			drm_dbg(&v3d->drm, "Too many V3D ioctl extensions\n");
+			return -E2BIG;
+		}
+
 		if (copy_from_user(&ext, user_ext, sizeof(ext))) {
 			drm_dbg(&v3d->drm, "Failed to copy submit extension\n");
 			return -EFAULT;
-- 
2.34.1


