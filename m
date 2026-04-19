Return-Path: <stable+bounces-238629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO+JJjKC5GmPWAEAu9opvQ
	(envelope-from <stable+bounces-238629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 09:20:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D534234BB
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B129C3008093
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F19378830;
	Sun, 19 Apr 2026 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFULbpIq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5C37880B
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776583199; cv=none; b=Rd8NfNCabcKyzC0o7mGQlKe3Nf0zjy9dUC6yYTZEMg4O4CKNAEGuKYMIOGqT56zHeNeTk2Cjail8ObyEK0YFnImR+amBx6bc7AsoUljUzJbIGbyB8e+Y315jDwLFU1DCb4Qv5KfNjh4RhbMAKR/89GAarLxsF/k3hNHgCpeHyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776583199; c=relaxed/simple;
	bh=yHU0KXsOgo76EVncDivnKe0OrmUXaQSwZ7RvlLdufV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6TUBypnnjXeYAwuGpr4mv5w+FwOZzTT++xMwcwsUcGiWdlk5PHyZ8j9kols5eB95gW0DAOvFkTtuVcCR+sDoZPseHcXyfzX0s8khIBs4MichC5Butb0c4V6TPzYU7W4egO/k+ZBGdCU1fr4y7kV1CkaxWrCMhPtc3uSMMTyWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFULbpIq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d965648a2so1766284a91.0
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776583197; x=1777187997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NubENbVnw4RB0klzgk0+GOCS1Cv2Xg/qv0QNTz0zlFs=;
        b=LFULbpIqh6VgtH9OI08shhr6mUud9dndPkuDgAw8a+9SjercwMgS8RnP7QQrCZZfCz
         Qp2txmrFGKOpZUz8/kpA70UDm7oRKV2jJr9DH8aKZYX79ao8eY3qYbuKmUQQ3jZybBri
         F+UbVU7BadqBu6s+CR5t6vKPuigX4I/RWdKJEYbnk/fzw5DDwYDUesThVJWjMBi3VTPx
         Jc2sPGmb4MBWMnJnwshZ9490jkOMpEC491Q/7JzjZZQwJZ6ITMswICGo4/goPq5MrOqP
         xnnB/piMN9kFpMRVz5RTHTz3PmwUTHstalKLRP9l/9Nv6xOmquMo4KZhrXxa0ObxrYsl
         gjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776583197; x=1777187997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NubENbVnw4RB0klzgk0+GOCS1Cv2Xg/qv0QNTz0zlFs=;
        b=PwmdRz2ExGoMu1VO/ki3qJ2krk9qdA1YTUJDXApsXT62d0tP9VZ2iTjmEjI4Uwjanp
         yzpi8KTirkbwhgf7HknWfyDtdPwTv+UBRRsr/7tHXOQqqOBFdXm0T7MKbClmEEoepdw7
         U2tEjd/nWslNy2JRfiVvPIcubRscyIs1fyiSbfySUoVB/cl1WE/NO/e1FHRL1QPvRExN
         y+QMsiIOHwv87Uc6V+M5P9T9GBgKWdWU9j1R79cP2S+g2fL7wE5fa0ppqJOPJFnbqmBy
         JhOP1NR8YHfqSMXpgItkxtb37akb2CUQvn+x6mPlXNQCRPGfALtR+1JfnnK/yTt8smj8
         63Mg==
X-Forwarded-Encrypted: i=1; AFNElJ8DBmlA0OuIWml/rJPR8g0dAVBe5AYxDAHtDf5BKMRh+nxC4kgz+nMVUQrxZyoVrEAyBci9fb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXwUPty9WtDDfyVN7Ju0uemlw5BItyKpKy8nCvi/g4e7aDO/Z
	ho2nskdCPOLJBcctYNvW34m+FxKD+lxvtKDaaJAOobMFxjaZCSJDuIAk
X-Gm-Gg: AeBDieu2VAquf9ZZg+pJcGu4WkVHTHuNmQ0IhHjQvZ7QcCUTTPtC1IGOkTsxa1HwCS3
	0+8p4wKcB8ELP0ZFrgW4dr4ubwoq/JtIIhuyYD/EX5hytnTdlQRNQWY5SgNqCE/XiR7ngohrFL9
	FaObneR1UCqwwONWtnYYZWUSrCEK1MEwB/D6kVDZ/2BKsBvyFYtRK2UKkLbugemVNn2o/M4dhjb
	0vahRzjjJsySBwYImQ8gJG842hYAMqykgcvqMc08H71GDwaB9nEeT/Q+Gpn/XVYp2mrFE1r4ymi
	7bFe156CqVANBeHl8/Pdhlyxvl/V7u/qXB3aoO2dRZkVIZVIMUKFG15fpTmeiBWmVutyPkD7b4+
	TDCiEsdIB3SzSufVMVlgrBRJ7a2mc/Zg73FghCZHVx2SXJNZQ6gF8KUqN9HzDf0RNPfqMAc5WoQ
	hFBKli7Hhg1BXupzUg5cdwLWhHCLiSb27+CUQx
X-Received: by 2002:a17:90b:5288:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-3614048b1aemr11300754a91.21.1776583197605;
        Sun, 19 Apr 2026 00:19:57 -0700 (PDT)
Received: from gye-SER8.. ([1.243.227.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614198f775sm7730486a91.16.2026.04.19.00.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 00:19:57 -0700 (PDT)
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
Subject: [PATCH v1 1/2] accel/rocket: Fix prep_bo ioctl leaking positive return from dma_resv_wait_timeout()
Date: Sun, 19 Apr 2026 16:17:15 +0900
Message-ID: <c0ebf83b345721701b22d8f5bc41c52c0ecf5e16.1776581974.git.gye976@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-238629-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 87D534234BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
on success, 0 on timeout, and -errno on failure.

rocket_ioctl_prep_bo() returns this 'long' result from an int-typed
ioctl handler, so positive values reach userspace as bogus errors.
Explicitly set ret to 0 on the success path.

Fixes: 525ad89dd904 ("accel/rocket: Add IOCTLs for synchronizing memory accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/accel/rocket/rocket_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index b6a385d2e..c80847192 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -145,6 +145,8 @@ int rocket_ioctl_prep_bo(struct drm_device *dev, void *data, struct drm_file *fi
 	ret = dma_resv_wait_timeout(gem_obj->resv, DMA_RESV_USAGE_WRITE, true, timeout);
 	if (!ret)
 		ret = timeout ? -ETIMEDOUT : -EBUSY;
+	else if (ret > 0)
+		ret = 0;
 
 	shmem_obj = &to_rocket_bo(gem_obj)->base;
 
-- 
2.43.0


