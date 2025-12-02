Return-Path: <stable+bounces-198119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B489C9C721
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 18:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3F584E3F57
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC12C21E6;
	Tue,  2 Dec 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+o2EcXq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A862C21C9
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697501; cv=none; b=sqnCGqf0wu0dSfm5N8lEtSh5re1F5dwub9iTFCUHi/KUHRNr9slWXahNMjZKgVZtNweZunWLfiiRs0HKJ5Z9ft0IftWZziOeSfA63THpoYau8HybGmz8H9444Ks1C15YhNl2spNrkAyXjThFcAd2HDqtF+aeOHIbG6zTs9UVwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697501; c=relaxed/simple;
	bh=VkOP/tUp4yO3N4pXVBifGGjKIp+XwURhcSqAw+kdIJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKRBlRzOiyvZE7nBpe5MucikCMAici2XK7/IAIU2N6twK7YDqfiIv/ab17nXJZ8b0z/SsW9jXGA+06WLc3TeLzcAXtxTNfvkTcbsLcMArzFY4BtAEmibXD4SZfYuJWSegM23AdSWYBOavN9og+G8zhtBiqnuIe/XjjMJkDHA5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+o2EcXq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-343d73d08faso57003a91.0
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 09:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764697499; x=1765302299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ED9tSGVJh0x09FYQjOL2o8g73Yk/StYFmkwh8LhI7Qs=;
        b=R+o2EcXqhE4Ie+g2FL9FFdtDTjogVNSADZuV/dQWUd4sTlMdxQEbuamuUGng0KHT6R
         x+QXj6hF27UKO0yLI+yJFgZ7LSAPgYlJNHf8tFT5yPKWXxK1maBpxwNLVjLh7MamPepO
         2ihNVnUOG9nMt5cliw1PE5iEdL9SQZA+2Dny6Am3n/V6fn9RN4J0Hhp9Vo/2Dhnwyrwq
         Rfl/8AEw3xC5dVQGSfUX12Nlvn1ygUVfXwxQJPfalXwm98eW/mNwvHcHbYOYl4EteBCM
         tNV5fRmy1DsAx2KUHl4qRsg8h8B1jJU0lnq49rJDBkLBgBpynxqsdqtIck0kU2ShzgX1
         aaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697499; x=1765302299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED9tSGVJh0x09FYQjOL2o8g73Yk/StYFmkwh8LhI7Qs=;
        b=X/VP+AE0SUiucVfnb3vBkO43GDH5OIUcdVGNusenmrMZB4MJwFycKzmkRvC7Fm3mNm
         niP2zjVIxa5krxHJaWY7J16HRfHoDkW4YRgDEtyZkMhUP3eFF6xtW2du9yM1DDw+e3r6
         A/iQCN3MbSnjPSq5EX9fRfkp095C5LDl5V/x6HrntQw8pB33tu2UuJce6wVvAyOGLujP
         Q9o3YRIaSjyid8t0ESHAnRERgegA2/Nrl0h5vzFm9ecPcDtc/WpAJ3pIxdleBrOEqm0f
         HSUJkcy0CKGLkov0K7a0enZKmfotlO0M8fH+s2TEm0YZi1J+YX/7mNk3fWu/fdkGqH/H
         bn6A==
X-Forwarded-Encrypted: i=1; AJvYcCXDsnexE7XCj8yPJtMY+xV8LjVdIsZkT9GhN5lf5E3/M98Pk2VvHcr43iweK/oAkFEUxVtCYCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0YR5Uiy1Sc96PHtUpwzseDrKQ5lY0YFW2mLzMS5OsDRbV3y0b
	/aSVIvGgxBPnrj5SHbWGdvtOm1CO4b2n26X0IA3Nfql0r18AJ6AQKXGv
X-Gm-Gg: ASbGncvHzkWiiqAORf27q+3VMV63s2pV2nnjbLtPATZDbv0d00yI7qKdX1M1OT3V5CM
	oK9u0mzx1Qdgpx5BzVzftldo9L2acDwC5nXjoAU4LC61Vb8q2paqlv7YfYz+LDruOaOQR3vZ7Cu
	/V2FldfuuFGYlAzM8O1WCk7n5/uQf8MNNVrW6SbP3ISwn6WgRVhzJSi4kOe80mLb0Iv+vNm4+Ft
	uzCs4yiVm6nkeGeJLMjnCkdlz6RNJuKO8EAgqTlBJZoLZCYRwnT9ijF6YUaiP9/O6iJCUvI/WX4
	Ms6/pKtk+t0sAZzbupdXkW63JRx8ZERJGvFHuD1P0tY2NlkbQ7xqk48fpWP5QL5WjdxnhEt4cSY
	v8D0kfNAJGaJt4thpqJgFiIkFWI0EYU2ADA/5CzOH2noppWt9XLAQYRKQgAzoQ17aox8CmnIJa1
	VSPaRwzSsJ6zugmx6kJvGsKz/IEyvmYRoAlQcF6/HbJyULR1hFr6RXSoM28c4CCjVMTmznvZlUx
	Q0ha+sqHWrBsEPO3pjhlcTvEZPohJLThab/H/B4xvSlPVS/OQVVy/ANNBn5
X-Google-Smtp-Source: AGHT+IEJA6ge4wFCANfbRxKoKiXJwQLoc+/E8FFao7Y7q4CuOUiy2Rbn+7WQlpnH2DFciZOyBF+QWg==
X-Received: by 2002:a17:90b:4b8f:b0:343:6a63:85d5 with SMTP id 98e67ed59e1d1-34907fa9e16mr3588267a91.16.1764697498834;
        Tue, 02 Dec 2025 09:44:58 -0800 (PST)
Received: from 2045D.localdomain (191.sub-75-229-198.myvzw.com. [75.229.198.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-349106cf36dsm56865a91.10.2025.12.02.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:44:58 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: ioana.ciornei@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: fix use-after-free in driver_override_show()
Date: Wed,  3 Dec 2025 01:44:38 +0800
Message-ID: <20251202174438.12658-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver_override_show() function reads the driver_override string
without holding the device_lock. However, driver_override_store() uses
driver_set_override(), which modifies and frees the string while holding
the device_lock.

This can result in a concurrent use-after-free if the string is freed
by the store function while being read by the show function.

Fix this by holding the device_lock around the read operation.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
I verified this with a stress test that continuously writes/reads the
attribute. It triggered KASAN and leaked bytes like a0 f4 81 9f a3 ff ff
(likely kernel pointers). Since driver_override is world-readable (0644),
this allows unprivileged users to leak kernel pointers and bypass KASLR.
Similar races were fixed in other buses (e.g., commits 9561475db680 and
91d44c1afc61). Currently, 9 of 11 buses handle this correctly; this patch
fixes one of the remaining two.
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 25845c04e562..a97baf2cbcdd 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -202,8 +202,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.43.0


