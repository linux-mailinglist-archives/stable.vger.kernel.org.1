Return-Path: <stable+bounces-200160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE225CA797E
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 13:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ACA631A26D6
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C3329378;
	Fri,  5 Dec 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9peK8Bb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985F330B1C
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938312; cv=none; b=jgQLWRz4qADTb5XsnNgi3FT06s+j/cJRAVqHVa5EQpZd7H5sPFOBn8WycRJR4bKn7ixjuB0mT3fWsMJGD7KMPCfhnz2WkYOnkz1ZK7YOPyVzxQ224TkHFzss5zUp/mGjDyebAzt5+yZZt2RnQpx+tAWdj7mEgDj6td+MYlDHvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938312; c=relaxed/simple;
	bh=q2UnUWAWebxnuNlmemGTqFff20tXaiN4RcdNYvzk4vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcCmL5bUyQej9nMENbTn1yVEmyM6o2vs22h5B3IUd8qCERRy8znIO9E+4UCQaLMcbglSK/20JesH2hKVR0E7p//y736X7qYqHECzLtRozCz0PCgipGCqiPG5Jn0NX/hsuStCykKybcNDBvsaoIM+HjCMXcyNIbhgSZGf9XI/nvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r9peK8Bb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5959da48139so2175734e87.1
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 04:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764938307; x=1765543107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om/cMeG15+uH3BDN4RH9PI4d5N4TSJ2+dVbkHS9xaeo=;
        b=r9peK8BbfusciDKr9oDSGuziQhZbMyj5dLWQ/6xFG6O2/i7DaGpgy8OzfYDK48YFg+
         L6ClmGbbgNgYJPySoTen7UV6os5IOONNGuUKdB27GhB3ogVV9h0tqx63yCT5Oqnaad/j
         1Q+6RDktHnqeS7PTdQtJDuuLEoqJyd+ickabVPIp9vIl6qgf4vmN2WJxeOznVXHClgre
         0fmcyzzumUMlF5iY4LUm83yPh5w2lQO+qhpEHgHfTSxkaCIEQnAfRYbGYTlnQwtprZNf
         Z6jq2Y5veKOr9TW5VF7DZYGypDPxBWMTgsdGyGTnfUbjuwG581AZVrfUMaazxshyt1xe
         3wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938307; x=1765543107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=om/cMeG15+uH3BDN4RH9PI4d5N4TSJ2+dVbkHS9xaeo=;
        b=rXu9Oa/Z0DkmRJNdixH6cWNAgKDo+lJQanOJuMy3rTd1TMfjDOEzH6uhnSFKiVDLjP
         57tVnEBqwlPGidu9Q8IJdCLJ6uqCLyTEapiEyUQqwvRrd80M8ejQxPI2G6Lw++4DnFC7
         A3oD7t45/pyxIYUuFdM1CfjCcKKHVTfeg6sRglH1MUrPRnrEHEtVgWyERFsa0o0jP98I
         HrlbNUDtBnWtJWKKuTnbHNRG3LEtIIQO8MGQyJVpdZL0sVTtg4+XnZck6812qmyJGEf4
         m39Rq3VqqYLKU/PTLYeN+KiFbQRU7rknFrS6ct3b+MVrvi5Vf3lEQCkirOaw0EB/C6SE
         wcSw==
X-Forwarded-Encrypted: i=1; AJvYcCViHWxArGyVd7GpG9kbo9d86i8wFgul/kNc31RmQ/uuncwqsJs8jgzo5In6ItYs6LCUrHDGuRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WePGul16l7qEUrlYH3h6TET9gs7J2AM+c3Q9INTccR8Emtf5
	f3v0XOfrPkKHD/7+7o76rvoXlCEJl6IJKa6qyJ1X51nrFeQTtskhIklgOHBsIBe2/oo=
X-Gm-Gg: ASbGncshY+9M0GSMTq6wXZii3bIzHqc2Yszw9rcQuLTL9PRqIZsI5VdiTqs3s0el2lx
	JMWjRTLCiR+/2ILFEemd7jFWBW2jlAb6kQFRR7ChoiuGAkI8Q0ind5yB9x4Jqq/mEa40lNBeeyJ
	3vvys9XLjITY/hhbWDJKm5rrjJxT4TJ9StdLSrrOY1nSHTY9wOtXOJB4Ruewd/8NKsUiboW6zH2
	2ca+HoUulFEga7N1YOYNPLmqSROy4Q7kbHX7srGijQUhC8IXDLgTx0l6wkLFINuEGYc0gRr2QTQ
	N6a5q7n19HG0/yy+ZnuvVjFC5PqDm1LW8c46WICWB9sPt11liyK/ZC6hOngMTHEu4lGiiFULgQq
	MsGBDTcB+oloZV9FVFeJhlx0iEKGpyrMCdo+nc8xMtIvTZDQIV/ShSvD5GEXfEfiCunDWACiVTn
	4F1mSrj2lmhU3uiSt/R1C/hhKaqTZus+9yQir/pZjpHlGj
X-Google-Smtp-Source: AGHT+IGtYnj9jiu7muloz7dbfG4ZFq4BxsOy0KSiABI/FVyASbXwFy6IXZLRiaF5QzQ0YklTxWXgoA==
X-Received: by 2002:a05:6512:1558:b0:597:ddd8:cce9 with SMTP id 2adb3069b0e04-597ddd8cea8mr420850e87.25.1764938306636;
        Fri, 05 Dec 2025 04:38:26 -0800 (PST)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b1a3d9sm1462351e87.4.2025.12.05.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:38:26 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Bill Mills <bill.mills@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	stable@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH 1/2] drm: xlnx: zynqmp_kms: Init fbdev with 16 bit color
Date: Fri,  5 Dec 2025 14:37:50 +0200
Message-ID: <20251205123751.2257694-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205123751.2257694-1-mikko.rapeli@linaro.org>
References: <20251205123751.2257694-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>

Use RG16 buffer format for fbdev emulation. Fbdev backend is being used
by Mali 400 userspace driver which expects 16 bit RGB pixel color format.
This change should not affect console or other fbdev applications as we
still have plenty of colors left.

Cc: Bill Mills <bill.mills@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index 2bee0a2275ede..ccc35cacd10cb 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -525,7 +525,7 @@ int zynqmp_dpsub_drm_init(struct zynqmp_dpsub *dpsub)
 		goto err_poll_fini;
 
 	/* Initialize fbdev generic emulation. */
-	drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB888);
+	drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB565);
 
 	return 0;
 
-- 
2.34.1


