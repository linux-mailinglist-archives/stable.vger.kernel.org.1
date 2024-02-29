Return-Path: <stable+bounces-25700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6386D7C1
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 00:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEF01F240A3
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCE3FBA6;
	Thu, 29 Feb 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UstDicte"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8136D52F
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249267; cv=none; b=FdQBt/EVS9mEQeXRuD8lLQqyAtMXrE8AWdF4qdVaM8zQlN1NZc8IweoXXlMwrpsA3HzQRg8c7sWGCaZpDJ2GBSvwUhRcvwCWw6aadG4wnXqXKKvQWFPIgjgV+wz/qzgihTmyKB2YIB4GhyWPM9tot6DP7qNJ6hayojlUGFi88XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249267; c=relaxed/simple;
	bh=7tJEoT7UeieYnDrUIelxhTjT/DTW8yYe3f7+9yRHQ0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QUevpSSES5f6ws0t39b5uTRJcQNe8EDCtwCy8o0zwKkI9yKNhCUGk0lnaYdVswcU/a1wD4P4c0O3uuyRISKUk42n4tvDor32bu9sQQGhdbtWuuJ92GruV+mDVXkhvZfSpZwDOnQAEt9yx/rMINILvL8xjaMTopb+PcWdmeEtIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UstDicte; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6093f75fc81so26916497b3.1
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 15:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709249265; x=1709854065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3VOyu5h5VNnqIC5C1wAkPY2R8kjBMsntg/JOJOAxJU=;
        b=UstDicteCTjBperi9tOyIrGuhf+jdUGHooZE4z8lG7gi+AlyqryVfmf/V1PebCg/pT
         LjKSmniNwekt0cPh4XfoLR4peuAF3eMClSGY2kWZdZeDnphUzDdHcHvgNMKunrbzzpCb
         evt7rwZonGmFw+vYINQMPLB4ahdxKEO9iA8NePH574wkJa6bJRlr9hV58ZqfZXOWA0bw
         yvuETpmvJ6gH3X2FOD3ga/pq4mub+thLMLt0H7pXX6OXGfao6ipOEVIfmZUV8hJMPyf7
         12DcPyuTSarVJJlEBY3CQw/sSjMLKmBtK0Lt8DaZwcvpMd3F1xPQ7xjASyuqbOjeHjUb
         OJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249265; x=1709854065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3VOyu5h5VNnqIC5C1wAkPY2R8kjBMsntg/JOJOAxJU=;
        b=tuSjYWFqrc1uRyNkiIqZuiFcsI6OCkyPnNoAzQPi5FZNBRzoC4L0iO93jOUVVv0iVO
         TF6AQyeTqD4lElKt9WJDnJweYgoGQ8uCzLInEwwiRE0twhriNedbo5TOZj0buOwEOskv
         xqiJoqZ5H98mD1FpSHsk+93ZxBGx5MCIInNJ4g17RX5FCcQRr2SyEdZh9NWaL1vTRZMq
         8wG4yWTFNCJdKKh7UAtzfk5onhpo9C7NXhUfq7eYouSxNUWj6mmyxPzrLqJ+WvQpdstX
         Gb4U2JMD50y52kuMPB90b2/yK5gLUm26xXJ2WE8QIgQdiCQQ6CaApmKF4b6bXvHNLWY8
         FZWw==
X-Forwarded-Encrypted: i=1; AJvYcCVXUJPb/F0XPHF1UZXzcgvVQeFiljqPJ5yiuvK4QLw9W/5alLJviaIwhhxwRMyBb3i+L89VsL+PuuxSzGb1o7IHAnTda+jJ
X-Gm-Message-State: AOJu0YyZxrmit6kDvjbBN2oh/r2j1gXR9KpTT75EBRpPx++zGK+/RfY9
	Oxlnphi2KoEjBx+AR5TmjAVyBCVwUOI7kbLDhHeDONo0H5q5lAekUrLxWHFrZokW0LAlM07uX02
	rkA==
X-Google-Smtp-Source: AGHT+IHvyejkGgypClXhg50bB1VZvyXaC2u7Vf4QdGi/7EhCSBdXhsaVPLCfGNLPt1UrGRRNNIIWY0xW7aI=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:b15:b0:608:e4fc:aada with SMTP id
 cj21-20020a05690c0b1500b00608e4fcaadamr124ywb.8.1709249265253; Thu, 29 Feb
 2024 15:27:45 -0800 (PST)
Date: Thu, 29 Feb 2024 23:26:22 +0000
In-Reply-To: <20240229232625.3944115-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229232625.3944115-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229232625.3944115-2-jthies@google.com>
Subject: [PATCH v3 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
plug type and updating the modal support macro for consistent naming.

Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
Cc: stable@vger.kernel.org
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in v3:
- Fixed CC stable.

Changes in v2:
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

 drivers/usb/typec/ucsi/ucsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 7e35ffbe0a6f2..469a2baf472e4 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -259,12 +259,12 @@ struct ucsi_cable_property {
 #define UCSI_CABLE_PROP_FLAG_VBUS_IN_CABLE	BIT(0)
 #define UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE	BIT(1)
 #define UCSI_CABLE_PROP_FLAG_DIRECTIONALITY	BIT(2)
-#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	((_f_) & GENMASK(3, 0))
+#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	(((_f_) & GENMASK(4, 3)) >> 3)
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_A	0
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_B	1
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
 #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
-#define UCSI_CABLE_PROP_MODE_SUPPORT		BIT(5)
+#define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
 	u8 latency;
 } __packed;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


