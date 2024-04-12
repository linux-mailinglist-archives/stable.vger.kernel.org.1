Return-Path: <stable+bounces-39250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B068A23F8
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 04:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0922BB22E3E
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 02:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492B11CAB;
	Fri, 12 Apr 2024 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dn92FAqg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A54175A7
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890528; cv=none; b=Pgm12mFOtDBrp2UdTcoWsEYcqVeCuvd8MMknjvVsAROaaeXGoqbqUq6BySkP0tMarnq9hf3PiS4tWiWgsZddTAKZ3l8PLXl61eFtbxXB/Qf0agEZRoR2XBjCj69UtuumztuAJRatz+/mw2lOnU/CF9ud61j7Dy3hPdD5qbb/0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890528; c=relaxed/simple;
	bh=sCQTFjD7ep6zZTHtC1JwwNYlsthDnvzHZcj/BvLzHdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myxZNXC+LGdGEFh12Iy7j3jQ12UYDSRJehXmGEi2+ejhGbbTRpYWQtIbHtITV/yKM/jOOQE87eCO3CA1vuKy8lzH8jOeyEXN/St9HbKJLS/w0Ksr5/kgtMDoBIJ8tnPgNYBdIJcCLZlnKcaYLdrF3BUL1zr1109hWlqL7W56wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dn92FAqg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d5751901bso32785685a.1
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 19:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712890525; x=1713495325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUdoEKYMeyvOEbhTlsoajd8PIkMAEd98DVuYNbg+BqU=;
        b=dn92FAqgbLAWBU8eGhbleZiOHx5QYWKzvyd2/87vjyjyrB6Lb+DriXVp4t6EB6sdCq
         Apmb28SPPEkN2Ewpj4LW8HVEL93rKn8F1GCxVCu9TQuuHoQOPFZTkOyfUDU0NPXcITNz
         V9RDLiFbahvH7GBSZNT8VmLshi36CfSdZPI7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712890525; x=1713495325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUdoEKYMeyvOEbhTlsoajd8PIkMAEd98DVuYNbg+BqU=;
        b=ojVLnwsCr4wmEFvak4g6uPyL0C2rbCr5zDFcMZE8bBTnck1I48TDUQ7tqj4I7gWT1n
         oZqdVT8I4i0Esj4ANJOqrv4ZeLtD+aMg+h3yQpW1bBFy/EPmxBWfnAbF9MYfSE70lE/+
         YOeoZWzZQLxtcHQKcwn7cci/vsIXA7bSOUrkwISk+O/zOt4EeAK6cJvmNrLgZPBAuFZM
         n3GioBOC/P2tEX5KWZYu9J0kWZVIfcVjz+bhftM6TquOtyAPXBU03krF3con+y5iRpbc
         /Y0PXPmobOdc09/keV8NPdxHBAwoLQOjXF+tChQBvuB8nqIw8NBXUKQy9npWC/WObBIy
         xWFg==
X-Forwarded-Encrypted: i=1; AJvYcCXvOmWmxyEiEN+01bvJoRiVJo3nO9mZW6Ak8pl4GLqxjjXzPuL5tC438C//1hfGn+lV8dnAeute+sJ2h85+MM2MDvhe9o9k
X-Gm-Message-State: AOJu0YzF3WqCu9angG7aHOXYVohrKZhYYN7h/2G6nNxcK+q3XSa3Sds6
	/UIzEYalGm1KTqp+XADEAcFAOUxg2fAaK0NmOsv48M7qZsHA1k14TL9u2aGWRw==
X-Google-Smtp-Source: AGHT+IH9Fbqg4XgLGfQ1M0xRMJylwntm60TK7ZtOpxY+6GSWQRQ+zfrPyDlAmCL/Tqen+8DJois+bA==
X-Received: by 2002:a05:622a:190f:b0:436:5a0e:cb48 with SMTP id w15-20020a05622a190f00b004365a0ecb48mr1962435qtc.24.1712890525665;
        Thu, 11 Apr 2024 19:55:25 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id t12-20020ac865cc000000b00434ab3072b0sm1682174qto.40.2024.04.11.19.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 19:55:25 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: [PATCH v2 5/5] drm/vmwgfx: Sort primary plane formats by order of preference
Date: Thu, 11 Apr 2024 22:55:11 -0400
Message-Id: <20240412025511.78553-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240412025511.78553-1-zack.rusin@broadcom.com>
References: <20240412025511.78553-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table of primary plane formats wasn't sorted at all, leading to
applications picking our least desirable formats by defaults.

Sort the primary plane formats according to our order of preference.

Nice side-effect of this change is that it makes IGT's kms_atomic
plane-invalid-params pass because the test picks the first format
which for vmwgfx was DRM_FORMAT_XRGB1555 and uses fb's with odd sizes
which make Pixman, which IGT depends on assert due to the fact that our
16bpp formats aren't 32 bit aligned like Pixman requires all formats
to be.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 36cc79bc9077 ("drm/vmwgfx: Add universal plane support")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.12+
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index bf9931e3a728..bf24f2f0dcfc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -233,10 +233,10 @@ struct vmw_framebuffer_bo {
 
 
 static const uint32_t __maybe_unused vmw_primary_plane_formats[] = {
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB1555,
 };
 
 static const uint32_t __maybe_unused vmw_cursor_plane_formats[] = {
-- 
2.40.1


