Return-Path: <stable+bounces-238630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODYrKkCC5GmPWAEAu9opvQ
	(envelope-from <stable+bounces-238630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 09:20:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C36064234C3
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 09:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BBC0300BC73
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0222B33E379;
	Sun, 19 Apr 2026 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTY2bI2F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98405378D8E
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776583202; cv=none; b=iONxYHBy19A64VhB31ElchDbKw6coCu8+ZKGziCkBV3IR1b1KoamAkYvE4tC8Pde8HW7LQ0Q9ehlok3QOISVdrCpIw73C8zH8ywnvZuWuvoIP26IreSt6HDey07cs7KdBshNQSCvOXKMaZNdMVO40R64lh6AMlvkmJFv5/G5/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776583202; c=relaxed/simple;
	bh=/6WqY7FVaM7RrmmrXcARtBbEz0lWyS0aYGllGtWbYaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGMwxkbjCz8kw6Up4KwDOsM8IIomwL25T0BfDlrdANARhtwVyOlr67qIqm28Cq2Yvhm8xJfwk+Np1XaNriP4Ap5t19pIJBwOKR3HsbSf7Ac6pBACAQzLIV3+23uSxT/0HyjXdQyW63SgvWfBXXMKlI1r9daAC0uQvSvUJsQGUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTY2bI2F; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso1945904a91.3
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776583201; x=1777188001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0uptcA/nPT9b5VoNX/H/wV7A62sl2YDH38WqrqI4Qc=;
        b=fTY2bI2FFSWSQDqw6FI1Yy8SjIZU9qv5aBH4fQjlbDJ0SG5jfPqTFEjBCpQymm+ZK3
         5xMLnzpBTwb0M2Nm7SW75DjTTeFhrIGWapvH/xfqOpYLEsbIyhsb542S3dUcxSfYB4qq
         Px3jE86EoApD3Adt22itKJpD8brVOZ+/U+zLxm1dVUisF/gHQ4m+V30LUMf5WuWECWBm
         KpefGV+NYxeVrdzm4flneab6opnA1kRvQnr/fBA2X82flmTw/ebdYVLed1Y2Fczgsmdk
         pWqX2IQHJ/4NF+30yG6Yc6ZO+qsEPyMKvKtT66exZePtTFsd4cIanF/rNZgDVPOVUCoh
         MWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776583201; x=1777188001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0uptcA/nPT9b5VoNX/H/wV7A62sl2YDH38WqrqI4Qc=;
        b=b8StuJP45eMNijRS9HaKxpWgYFLUk1wWUZTWhONiX0jE36NXV5yGERuAbO11HQxsqN
         PyGye1D43oYLHpQ3W1EvlYcFM5ny7BOlUePpEmzEPdaK21vFSpk4Gvmaca6aRkxKtc70
         AuXaQHN8hQDpCJT4RrRt68q8JDFDJFa4gmMxJgWobGjlBnnCg2lPybVT5JZ2AbckSbhh
         mSnJi29kXwDwDaC/k4X96tBea7aFmfcaMO9pIyb+jV/+DZ11fRJWoWji3d4prh6Y3Fmq
         RVq8oIf/hW3KysCJr4rNLtZeT/M9yXtzR2dkFTPI6mWMqz/ykPoWBntSGgER1KBZ7zqr
         lKvg==
X-Forwarded-Encrypted: i=1; AFNElJ+s+UF9T8YnojS9g0L6cswhcqhY/Swdo87AAMAgmLZuym4t7st+SFKk1cEuNCpcEM0Kiaj5KVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtyo7WjrIvhjVzuYa6tladzRbTWkCnQeOYqoSpVIBY9JkaubX
	65cpSXmAsJPMwzQ3+OrPE+P2Ou4pBD5oWgqHqMrAmik7mRjEmORY+0AH
X-Gm-Gg: AeBDiesY4qlBid91SU3zGaG8GEUFTKQEFcIKlwN5g6Xic3S++x6FfI5rABOD9YTDMBK
	Z9uEJQDesoJ/5+XQdX4yYlFErY7LWbg/GSXc7Q0SJq5VErU1htwnrBmTHk/0ub3y4e6jk11gtee
	xXyUq18rNIn+NJjTMIM1z2JYhATs0dIK+4vsXyLYMPO1Oxc5L8yjni1dTr057LjaDOjZLGH/6/p
	acYTfRRwTXm4TnsPj5tj6B98AsKHR0HiX8Kg6ugO6JN6ovoliQVUNBFJ5ICgGH1xmIAqQQLTT5L
	w6eWhhU/zAlyqkFbH2kWlwBPdKoLqkwlEiXS2stJvHd9IQiXBnTm4eQxRYA61VOex7ndQPKgkwZ
	O5dj7/xKA98fWF1+MNYD+VQxjZ/JT0DCrKMqKmHNV53Oj4YHZi4PfX6HOXG627t2+9o3jlwHRLT
	OkbLb24oYGUwqPSY94plEfY4bW4baJqj8cIr3e
X-Received: by 2002:a17:90b:5185:b0:35f:b7f5:9b3 with SMTP id 98e67ed59e1d1-361403b18c9mr9692965a91.3.1776583200994;
        Sun, 19 Apr 2026 00:20:00 -0700 (PDT)
Received: from gye-SER8.. ([1.243.227.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614198f775sm7730486a91.16.2026.04.19.00.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 00:20:00 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] drm/panfrost: Fix wait_bo ioctl leaking positive return from dma_resv_wait_timeout()
Date: Sun, 19 Apr 2026 16:17:16 +0900
Message-ID: <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776581974.git.gye976@gmail.com>
References: <cover.1776581974.git.gye976@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-238630-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gye976@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C36064234C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
on success, 0 on timeout, and -errno on failure.

panfrost_ioctl_wait_bo() returns this 'long' result from an int-typed
ioctl handler, so positive values reach userspace as bogus errors.
Explicitly set ret to 0 on the success path.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 3d0bdba2a..784e36d72 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -390,6 +390,8 @@ panfrost_ioctl_wait_bo(struct drm_device *dev, void *data,
 				    true, timeout);
 	if (!ret)
 		ret = timeout ? -ETIMEDOUT : -EBUSY;
+	else if (ret > 0)
+		ret = 0;
 
 	drm_gem_object_put(gem_obj);
 
-- 
2.43.0


