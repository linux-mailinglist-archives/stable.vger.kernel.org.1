Return-Path: <stable+bounces-176948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B158DB3F91C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713C73B65DD
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1CB270572;
	Tue,  2 Sep 2025 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncnnWQr3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DD328643F;
	Tue,  2 Sep 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802983; cv=none; b=ILy1HrGEkAUL7AbF+T+jPhUrSP9ZqaO3ddLZ4mqo+nV8AITM4bU0kGyTUCmZqDVQ5lQ1hq/E7uH0WuvZADl7eGWZ/0VgnkDMIVAOBe+/QOl7pTExCbQSMp9FmAuIrPIHS1hWi9XRTs4UpWN4niQheetYLRZpGiiiPWk0dY+cmSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802983; c=relaxed/simple;
	bh=nlXhO4HLDYtq0dzpcMaadd/2V2QlZV+6ZhSListbxEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=itVVDKCxYkmg3R+zKQatuRwUAMXyr6TDAJRQQ722xmxxWTqHjcbN0fG9HtGiP4Ii0q/3x1Qh2vwGRZ9+1svC20ecDvTfcsQTOyPLEjeGdhvBmvMvV6espny28FctdCeLxjeZj+VIZLPdOZ92T+LXG+1tfzlmGmGwOsUCSrlXASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncnnWQr3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7725147ec88so764238b3a.0;
        Tue, 02 Sep 2025 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756802982; x=1757407782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtSzSjxUSLTzJ3RLkpuTqXgeBjZqhGvXr+BycVNWlFY=;
        b=ncnnWQr3T2Z3eiAhFV16LJofhjmNXRNX7vRtzgSIqdWApp86b2ZBdB3Mbwe28fyQzg
         FYBj26X1hSwuJaU0/bKyNcULVJWAxHpGvwe+tGaFRjSUl5hNf1sRA9b5PjELcY/yRLqI
         wmR7HvHCd8APTA4chZU1YtxvoOS5pwFMM8fEqG0eAEWgFc/HtEheamtUrInwQmpfTcP5
         8sG3/gAfoIBnQhpGDYXzgfSLeMvqY5x+J9a9W4krxjYkIWXTVUmzZerWPcSThJLwB4B8
         y/YT4ELp1ub+HJ8P5JpFHiWzCfdOOQpcPcRjd+MIcj1AtOyPfSZvC+Jy/enbKWXGFdoW
         j0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802982; x=1757407782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtSzSjxUSLTzJ3RLkpuTqXgeBjZqhGvXr+BycVNWlFY=;
        b=NowbhiOPJyotMKj4QxRa7Qrz0pb41CJ1JBOn7YLwBdvAwU0vvB1+NXntXiX0iU5wPF
         YcD6UoGlCxQRKoHqdU7P7TJOPf3RVjasfi9SLx93gpUlJRT2eDdUl4bQYQy0IvVYVSU6
         58QoCq0x+vZMtEirc8hTkU78wlKqmvWfR3oJsKhN0EnpCu2+bAnmsp4amURZPUmPKi80
         a+UYcWJ7dHsSP+YSFs4YFMjBIQPIWfCUK9Ktlw9PTCsF7dMluJQn1HENOlVSoBKd0gtq
         bfUlQMOUNtzJyO19u3Ts41/Y0Ktty4a/Mts7ouH/oojYEIgSqYixD2k+sA0m26Lgm6Ur
         cC3w==
X-Forwarded-Encrypted: i=1; AJvYcCW6WRPKm5GU1K6xVSF0UfKPEvs7LcWt2AwWG1zVoJexeiCLhdG5ranBU8svT4qE3vPgNoVNEEyb@vger.kernel.org, AJvYcCWuYnv8eaRrVCPts6mkandBIg4wuDStI+AQ49olCiEBAIN+lNBThkhjyIcuFBUmnzLEsPcysa+UBXekWx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7jKaj3IvYeuyY400UczHmb/tIsYXJAgYUfCVmZsENAVREFCq
	Isa2PJzzvdPvkDM7mGWkV1Ipc5i5WMxvuraZLLft2J50w1LnLUEpTTn0
X-Gm-Gg: ASbGnctH8IyDFji1nw/8XRBO4IgbGnYkFY4ra3yQqIYD6CH+6XnNS7a/kBh7Z1lm8wa
	j792u7y/ry5O/lnv+1Bda6/iUlFphl3x2Tg6DF1VGh91pnHhbJTQZpfMjbHLat+YVsVuhatapBw
	g4S2os+JKwmhtkrl0ZB/fILwdJIAJhSveaMgfrpsUV0AmUCp4i5MCPje8zz9aPgbMx4ZxO44iR9
	Q33HWkUaEhyVJneWd+sXiWl2HoKCU3rzAP+oB2twI6+dwYa8qV+GxqIsSUX6aGwALCP0MdZJ2fQ
	+riJKgUMMgOg1KoRol1yeECjCXXrQxyrmqcb2neuEyoQRGRlDQplPYFNlhLhXRMQnu9bqEv/R5E
	pLTccW5/69zh2e0DceXwcGtOaIqm8shRgH6Y+7y6ELExLkgoRROYPqSEopSqyR+BCAjAQdq/XL+
	t+xAqfUoW16NyvM3OUyc4gJ6klDiVaTgwsGNvtt+hL73g6PqksDqFLh3o=
X-Google-Smtp-Source: AGHT+IFv6iNbTI1eMfRNmBO54H3FsHJTU56bZ5wAWi6MhGIGp3k4yhC7/28QJiGhkxbKUSyArjCX0w==
X-Received: by 2002:a05:6a00:85a4:b0:770:580d:87fe with SMTP id d2e1a72fcca58-7723c445dbbmr12026434b3a.7.1756802981484;
        Tue, 02 Sep 2025 01:49:41 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.164])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a2d97acsm12803498b3a.41.2025.09.02.01.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:49:41 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] cdx: Fix device node reference leak in cdx_msi_domain_init
Date: Tue,  2 Sep 2025 16:49:33 +0800
Message-Id: <20250902084933.2418264-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing of_node_put() call to release
the device node reference obtained via of_parse_phandle().

Fixes: 0e439ba38e61 ("cdx: add MSI support for CDX bus")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cdx/cdx_msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 3388a5d1462c..91b95422b263 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -174,6 +174,7 @@ struct irq_domain *cdx_msi_domain_init(struct device *dev)
 	}
 
 	parent = irq_find_matching_fwnode(of_fwnode_handle(parent_node), DOMAIN_BUS_NEXUS);
+	of_node_put(parent_node);
 	if (!parent || !msi_get_domain_info(parent)) {
 		dev_err(dev, "unable to locate ITS domain\n");
 		return NULL;
-- 
2.35.1


