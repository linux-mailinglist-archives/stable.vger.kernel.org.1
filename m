Return-Path: <stable+bounces-165815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB829B192FC
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B1854E01E5
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE32857EF;
	Sun,  3 Aug 2025 07:23:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAC2853F8;
	Sun,  3 Aug 2025 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205792; cv=none; b=bljIgEUOsOYaMp8pxiyjO26L9FoLZpdiZO8dtXav7y3CXP7/PnKtpwlQh1QSTR1D4t1tvL2AdlzsBbqdXx7aQBthqq+Lj8oHBZmdqiLFZtyCD8WZ/3BAAyvNmFyn3rABz3RdibulbwESWH/K0eFCuGTxPHZuYKI6IeJqbHHFatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205792; c=relaxed/simple;
	bh=VyXyy6e3sil0Ay6ER7lD2FBdbK6i7vMKoMfIwsSxWQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGHLZw8udXYwd3dXw+3kq91zC6euV4suV8TK9P9s5MlSZM+d5MHV3Ca1NGpULLhGvdOqKUFazoOO1snt/+AGCd7RNb3AospmeiCNKFOEKN4UUXuqUSS+ttCOhknTc8pYxUTp3hVCVk3gjpzY8i22sH5SUbUFobnNI+fDHeQxZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31ebeb3882cso371223a91.2;
        Sun, 03 Aug 2025 00:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754205790; x=1754810590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUMEPy3NW+Kvt4pCviV3Y3MANBoYuxv/rAODtFlgguI=;
        b=SPWtd2kjHH0JPL2nWxRagy3mqYLAp/hcLERMgaHwswi/rOf9UdrYPSefo4nfRqnbq6
         fpanDjyPR486GZU3J/s2XaFCF/ZsG/hFwWW73aq7+809+e76F814wVOc7s8SBwOX9ATl
         HHmIr4ftITstZ/79VRrQl6nQkNYDeo2oOGQekNbaQThvI8HQXzmZhwkLIDAPh37BlDF1
         VvGlWWFWiQP0x54W+FyjVuCq2nlkxVQCJyYQKNwPfPTS0CdyTLxOCqIwyl57Jr7v6Ahr
         A+zH/lKuS9GfpsH5DXOtgYlGcUkAgOd+36Lz/KKpdW+oBkfoef0hCh7wcAVtswq9bGbG
         1W0w==
X-Forwarded-Encrypted: i=1; AJvYcCUHlFN3+KoXwaM6fsTm0z2JSKHQZLVL1uNFMMxRXO5uGD16SLQ9m8KfZnOp9obLAr8PVTLjiZh73eQip0M=@vger.kernel.org, AJvYcCVlM+PkPBByMu1HAGdzHiixkeBVSUI4AvK/qpONATolDAqOXX5y2Pf4Y+JbweYL40JBb9eL68IxuwpG@vger.kernel.org, AJvYcCXf+HntSi9NhbX89jGljmzvVNliR0tGGk5/Dzi5xjqyG6LlaC812IXcm0Jgwt22VwSnotA00PLW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3P0joIlBC7pM6zZP6Qz8xtQfYjlwBPhVLqLfRz4pzLm2sCOFB
	bFsQYG83eTaL/ECZQ5/vDkbHjtctWPsxfTTKNycMgGr/JxFAI+REApHG
X-Gm-Gg: ASbGncsgQE1Tw+/Px5x7GNVEY5pjWQU1D1JrVr2MndeqynbfA1CycrbZG/I44464NW3
	iOpuTLy14ojKpYArUq543tzwe77bVaJW7UD+806owOERlvgGI41xNQa/lWYSP2QsysvibIZ7hLa
	tpBfdkfQ8gPvGaE0wdb9jYZbUWECyI6BeZBW02rAybp0re1FjxBVfufZo9PmHR/mhcS/mw17f7+
	1YYnrTX8apGNWhkPbcpw7unqVvh9Jao2RcueRKHLBnfpbnFxBD7uckHN/OnbgeXAzyQei8IN4TR
	Fl1MOpkxuzDzuFmd7YiPBLRHX0QcajdpyfB3ahdvNZEKpJf13ZtG1s6W2ChWeGWab15XhQXIQLK
	kbRMVAciE/MNjpFIOfqWw2fo=
X-Google-Smtp-Source: AGHT+IFkiOF2LoZEGkeJ1ZCKCByYFHWEQyRUIxN6P7aax3IOgp/dFnuuDea+zbR2L5+A+YvGsBXbjw==
X-Received: by 2002:a17:90b:3ec1:b0:31f:16ee:5ddf with SMTP id 98e67ed59e1d1-321162cd950mr3588228a91.5.1754205790066;
        Sun, 03 Aug 2025 00:23:10 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm4517004a12.33.2025.08.03.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 00:23:09 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	ppbuk5246@gmail.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH 3/4] kcov: Separate KCOV_REMOTE_ENABLE ioctl helper function
Date: Sun,  3 Aug 2025 07:20:47 +0000
Message-ID: <20250803072044.572733-8-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250803072044.572733-2-ysk@kzalloc.com>
References: <20250803072044.572733-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcov_ioctl() entry point is updated to dispatch commands to the
appropriate helper function, calling kcov_ioctl_locked_remote_enabled()
for the remote enable case and the now-simplified kcov_ioctl_locked() for
KCOV_ENABLE and KCOV_DISABLE commands.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 kernel/kcov.c | 142 +++++++++++++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 65 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index faad3b288ca7..1e7f08ddf0e8 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -579,15 +579,81 @@ static inline bool kcov_check_handle(u64 handle, bool common_valid,
 	return false;
 }
 
-static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
-			     unsigned long arg)
+static int kcov_ioctl_locked_remote_enabled(struct kcov *kcov,
+			     unsigned int cmd, unsigned long arg)
 {
 	struct task_struct *t;
-	unsigned long flags, unused;
+	unsigned long flags;
 	int mode, i;
 	struct kcov_remote_arg *remote_arg;
 	struct kcov_remote *remote;
 
+	if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
+		return -EINVAL;
+	t = current;
+	if (kcov->t != NULL || t->kcov != NULL)
+		return -EBUSY;
+	remote_arg = (struct kcov_remote_arg *)arg;
+	mode = kcov_get_mode(remote_arg->trace_mode);
+	if (mode < 0)
+		return mode;
+	if ((unsigned long)remote_arg->area_size >
+		LONG_MAX / sizeof(unsigned long))
+		return -EINVAL;
+	kcov->mode = mode;
+	t->kcov = kcov;
+	t->kcov_mode = KCOV_MODE_REMOTE;
+	kcov->t = t;
+	kcov->remote = true;
+	kcov->remote_size = remote_arg->area_size;
+	raw_spin_lock_irqsave(&kcov_remote_lock, flags);
+	for (i = 0; i < remote_arg->num_handles; i++) {
+		if (!kcov_check_handle(remote_arg->handles[i],
+					false, true, false)) {
+			raw_spin_unlock_irqrestore(&kcov_remote_lock,
+						flags);
+			kcov_disable(t, kcov);
+			return -EINVAL;
+		}
+		remote = kcov_remote_add(kcov, remote_arg->handles[i]);
+		if (IS_ERR(remote)) {
+			raw_spin_unlock_irqrestore(&kcov_remote_lock,
+						flags);
+			kcov_disable(t, kcov);
+			return PTR_ERR(remote);
+		}
+	}
+	if (remote_arg->common_handle) {
+		if (!kcov_check_handle(remote_arg->common_handle,
+					true, false, false)) {
+			raw_spin_unlock_irqrestore(&kcov_remote_lock,
+						flags);
+			kcov_disable(t, kcov);
+			return -EINVAL;
+		}
+		remote = kcov_remote_add(kcov,
+				remote_arg->common_handle);
+		if (IS_ERR(remote)) {
+			raw_spin_unlock_irqrestore(&kcov_remote_lock,
+						flags);
+			kcov_disable(t, kcov);
+			return PTR_ERR(remote);
+		}
+		t->kcov_handle = remote_arg->common_handle;
+	}
+	raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
+	/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
+	kcov_get(kcov);
+	return 0;
+}
+
+static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct task_struct *t;
+	unsigned long unused;
+	int mode;
+
 	switch (cmd) {
 	case KCOV_ENABLE:
 		/*
@@ -624,64 +690,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov_disable(t, kcov);
 		kcov_put(kcov);
 		return 0;
-	case KCOV_REMOTE_ENABLE:
-		if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
-			return -EINVAL;
-		t = current;
-		if (kcov->t != NULL || t->kcov != NULL)
-			return -EBUSY;
-		remote_arg = (struct kcov_remote_arg *)arg;
-		mode = kcov_get_mode(remote_arg->trace_mode);
-		if (mode < 0)
-			return mode;
-		if ((unsigned long)remote_arg->area_size >
-		    LONG_MAX / sizeof(unsigned long))
-			return -EINVAL;
-		kcov->mode = mode;
-		t->kcov = kcov;
-	        t->kcov_mode = KCOV_MODE_REMOTE;
-		kcov->t = t;
-		kcov->remote = true;
-		kcov->remote_size = remote_arg->area_size;
-		raw_spin_lock_irqsave(&kcov_remote_lock, flags);
-		for (i = 0; i < remote_arg->num_handles; i++) {
-			if (!kcov_check_handle(remote_arg->handles[i],
-						false, true, false)) {
-				raw_spin_unlock_irqrestore(&kcov_remote_lock,
-							flags);
-				kcov_disable(t, kcov);
-				return -EINVAL;
-			}
-			remote = kcov_remote_add(kcov, remote_arg->handles[i]);
-			if (IS_ERR(remote)) {
-				raw_spin_unlock_irqrestore(&kcov_remote_lock,
-							flags);
-				kcov_disable(t, kcov);
-				return PTR_ERR(remote);
-			}
-		}
-		if (remote_arg->common_handle) {
-			if (!kcov_check_handle(remote_arg->common_handle,
-						true, false, false)) {
-				raw_spin_unlock_irqrestore(&kcov_remote_lock,
-							flags);
-				kcov_disable(t, kcov);
-				return -EINVAL;
-			}
-			remote = kcov_remote_add(kcov,
-					remote_arg->common_handle);
-			if (IS_ERR(remote)) {
-				raw_spin_unlock_irqrestore(&kcov_remote_lock,
-							flags);
-				kcov_disable(t, kcov);
-				return PTR_ERR(remote);
-			}
-			t->kcov_handle = remote_arg->common_handle;
-		}
-		raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
-		/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
-		kcov_get(kcov);
-		return 0;
 	default:
 		return -ENOTTY;
 	}
@@ -740,16 +748,20 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		}
 		arg = (unsigned long)remote_arg;
-		fallthrough;
+		raw_spin_lock_irqsave(&kcov->lock, flags);
+		res = kcov_ioctl_locked_remote_enabled(kcov, cmd, arg);
+		raw_spin_unlock_irqrestore(&kcov->lock, flags);
+		kfree(remote_arg);
+		return res;
 	default:
 		/*
-		 * All other commands can be normally executed under a spin lock, so we
-		 * obtain and release it here in order to simplify kcov_ioctl_locked().
+		 * KCOV_ENABLE and KCOV_DISABLE commands can be normally executed under
+		 * a raw spin lock, so we obtain and release it here in order to
+		 * simplify kcov_ioctl_locked().
 		 */
 		raw_spin_lock_irqsave(&kcov->lock, flags);
 		res = kcov_ioctl_locked(kcov, cmd, arg);
 		raw_spin_unlock_irqrestore(&kcov->lock, flags);
-		kfree(remote_arg);
 		return res;
 	}
 }
-- 
2.50.0


