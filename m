Return-Path: <stable+bounces-135133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E52A96D75
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1719E1887F57
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA1281357;
	Tue, 22 Apr 2025 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1l69cPy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A9201271;
	Tue, 22 Apr 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329896; cv=none; b=te0RPnzHQlCKzj7A7NEXW2Gae3z5iZWx8ktGZ9iy/4tCvQtHFeiGaxirmVW7/tR9uLZz4v7K0Fz81EKKiFyZOh1/k6SQfRfIxmnbPA7cCT/ykTBz2EOwG2huFYc/6UHxXgPMhp4ZaLsy4GFERV7937cwjsZMAq6LIT12CPPp7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329896; c=relaxed/simple;
	bh=cYb5wzdMYyq1bfZwwXLiss9AOzS6rESwiHVLQkIN9oI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qynSnSgoPixQ2mJ+BiNFUlNF9OGHVxBBqSCjW8/OVtyRDWE8IWBBWGOkf0wPcYPQUs7H0kNzEuJNxXkAwYdpeGH68U1SmjqU390pCsOLS1OrNKcUbRN8oY4w9dDJF/XnOTWZHj/kco3fQFwY6J6EGYj5oUvO2+wN467CtQyvBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1l69cPy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso33689955e9.3;
        Tue, 22 Apr 2025 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745329892; x=1745934692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P20BR2Tv8R58N8rBs8jFttYwmstLArnkKgOXXmUHnkc=;
        b=m1l69cPyFgSOKAe+KpCcXIgv15FUkhv+bPR3ezMkLofIfUv7uqEju7/jjxFcuyxWhI
         e2/D4zbfGIqr1JPa3EArS/aPO/5FUqzcPKM85hEjsO6/DZL7Bu4Owj6hUOFGPQnCBEHV
         3a15+uHkyyTe0TKt7cfCt4f3S0xRemoGY1HChJE8pdxfTeGD5+js6t3XABU9N6u829+8
         qhLxQtrMjzrnZcFKb8tNYI99bb0omyagw4sG53CLPp5f2lKzEVPGVFYKr4oqGiH5eoWg
         iaQO5oBVrftXJH6hozVrRt5WydUYHrOnh2L3R7ZGGULzb3tbeKQ2o3sXfb2qkK7ML65Z
         /0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329892; x=1745934692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P20BR2Tv8R58N8rBs8jFttYwmstLArnkKgOXXmUHnkc=;
        b=F4UlFNbrl7PT6rTIfAfbqoc0eeM3a0CMN8ASZA7Ugil2PtF+ESKU6xLjoVdkuNhmOr
         tLL95yJNJzTntxjYlMNmoqRetB5ZBkzJqeCzZhWkxqtj9UwMnbbj5fdu7tHBx6FAUW7L
         IAPAo9PzII+5M18jfWVJkvt6AHV//rMQHtiNzC0B6Y+ujxhI8WA9lNLyQ4rAWPU0v+S2
         9bZxuv/V7Jcr2antyaVupCQUFejEKhNRp9dEp3U7b5lc67gsHcoXJxIYtfnmi5tJY7Be
         wI94PVDIDj7BaxHFhw1TbzE4WBww3PWCv7StUomaq9huC9Fr47p3S4I341LngVzBpChp
         AMEw==
X-Forwarded-Encrypted: i=1; AJvYcCUyjg4V65y2RvpMTgZAdikn7+vMxDw0ffrqzwzRCR4GxGx3V0HRX/twHMwVINIGYsdBI/stitn1TL9zby8=@vger.kernel.org, AJvYcCWrfwAq8TyqJcnaPTIYYIjj2YLK2wwgyaUKo0xogSPMI+U4lc0UsEY9kiS8COimjIwS7SP8Iqyi@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgTB9q6y/ibyAgsCf7muhBEblyyGNhz4fUwqUXLyBqtOwysFm
	a42VDVvc+F14hUfvFirMt2wSLyiS+ar66/h04hq+i+z3GlLqclli
X-Gm-Gg: ASbGncuPAvI3vW8t+WVg0lJzHSIbaxYvnqSL8GGidKkwgpRIfwle/FVJitRzEoNfM/2
	T72DaWqErI16MhA3VCiTB6bAnG9oeoKh5DHIVtJ9dOi6aNF80AQBBLUqZ4wYHjXXklQP9NkQJqm
	RxTEFmK4ggj5r5KevxVNwZnPI36cb0xwnlNsBSVcXURHa+rW1P3ZOB3D09VoreZqBZtjIJPyWPU
	EVOg3igMHXSJ4fjnkxZ/k3y9UQh+v6IrMV9gtbGKuRDSpU6dah2CuMisSV/2S87T0xeGF01NyHs
	YNM2CxeoUz8H85fZzY09GdOmV5x3TVC/muSOudoe
X-Google-Smtp-Source: AGHT+IGwe8Z3YpFb5/ecMVn8Y3ic1OOVBuQhJmpxrIzlY7N4S3tEv4JjbxY4U6rgwDI2qjlfOun/Tg==
X-Received: by 2002:a05:600c:4f8a:b0:43c:fe15:41d4 with SMTP id 5b1f17b1804b1-4406aba7ebfmr151332235e9.18.1745329892446;
        Tue, 22 Apr 2025 06:51:32 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:b678:ddbe:75a4:837])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9e50sm177577005e9.6.2025.04.22.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:51:32 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	lumag@kernel.org,
	pooja.katiyar@intel.com,
	diogo.ivo@tecnico.ulisboa.pt,
	madhu.m@intel.com,
	saranya.gopal@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: fix Clang -Wsign-conversion warning
Date: Tue, 22 Apr 2025 14:47:17 +0100
Message-Id: <20250422134717.66218-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs.c emits the following warnings when compiling with the -Wsign-conversion flag with clang 15:

drivers/usb/typec/ucsi/debugfs.c:58:27: warning: implicit conversion changes signedness: 'int' to 'u32' (aka 'unsigned int') [-Wsign-conversion]
                ucsi->debugfs->status = ret;
                                      ~ ^~~
drivers/usb/typec/ucsi/debugfs.c:71:25: warning: implicit conversion changes signedness: 'u32' (aka 'unsigned int') to 'int' [-Wsign-conversion]
                return ucsi->debugfs->status;
                ~~~~~~ ~~~~~~~~~~~~~~~^~~~~~
                
During ucsi_cmd() we see:

	if (ret < 0) {
		ucsi->debugfs->status = ret;
		return ret;
	}
	
But "status" is u32 meaning unsigned wrap-around occurs when assigning a value which is < 0 to it, this obscures the real status.

To fix this make the "status" of type int since ret is also of type int.

Fixes: df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 3a2c1762bec1..525d28160413 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -432,7 +432,7 @@ struct ucsi_debugfs_entry {
 		u64 low;
 		u64 high;
 	} response;
-	u32 status;
+	int status;
 	struct dentry *dentry;
 };
 
-- 
2.39.5


