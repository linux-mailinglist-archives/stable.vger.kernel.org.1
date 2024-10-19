Return-Path: <stable+bounces-86930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0339A50C7
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 22:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494E4B2508E
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6181922DB;
	Sat, 19 Oct 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn7Pi2GT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50391917E7;
	Sat, 19 Oct 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729370428; cv=none; b=SBjzwq4WIouMWvJRgYhh2ZwfwSYp7agoZ+S2cZZUsOYvd68n7Jbfo5szQSAF92FuTKg5bQ9XxoxDWJGgKQhl4m3N1GJ7IChJyHnczbCfYoIKq7jLhyGJkJa/9rF/gwgAcvGN4s7+4e8rTi5hsUEqhsfw4ooyRo7/9zOg4jlRUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729370428; c=relaxed/simple;
	bh=LenEoPlLmA1SoqKTjqXO5FKYciLK+4R5R4u0zaMq9I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kmf4PPK+DtkiDgkE8wFyO/Lqjn4yFcod8c0NeVg42PqvPQQK4u/RLWIbZOC87MhgQaZ+nY5FwKsY5LlIrZX9UAoM4Us0Zc5Tu/vAw6GYPaex4wtemdaMSbPYcU5l0GGMNcemvNB7uZBYdzZrlqWaL/nZBlRMF7xVBjzmlEKb1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn7Pi2GT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so10406985e9.1;
        Sat, 19 Oct 2024 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729370424; x=1729975224; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cfj+nIxSeExUj4i/poC4m4fdJwm4vgFsgv2pVWjR3Vg=;
        b=Dn7Pi2GTE1GFP9gieb0v3XovDv8qp2WgDwowJiGemt6LzBaV5hGq+bVv39ClaMTuUP
         oVN6BEue++69M9HF+LiqP4h4tXauKq2/kjb/i3Rtu5WZluE2xQ7rEoyVcu8aRyxlKK0s
         5tiwQZbfPGBE58WpYZWso1UZSWfF+VXDDGi2XcZ5fvLHGIWflURsVui+O5keczaLUkFJ
         gfXWrhympvZKyu8KgQLQMWwfW8QPE3KiizA7CwL6B2jQ+S9eQpeUqXmBzrJ++2HO5rJz
         mMC69GSi+AdhDb6p8BlHa9QY3AUYXesiiNf7g4K0D2sRHjwsFEbAP9VGh6GlmYCA5K6U
         cVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729370424; x=1729975224;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cfj+nIxSeExUj4i/poC4m4fdJwm4vgFsgv2pVWjR3Vg=;
        b=dje11EIr2LhPuXzfX0/oAR6UXHiUIrbKSGGCSRxbwvDYoNfvcgXfYZ8f5PLpTBu5Ke
         DwxkzImyUF/uIL4rAFAknHwf9Op0B/6t/DDXmkI6s0y1Wi3/YtmJAlPt+Rdyu1xBfyi9
         lzj7/QqbfX7gO2SQrCXCfg6I653j5tUoxQTvW0x/TZ8J1bCLzy4s+NP0Yxba1nGdukP8
         z0asJ3ppbsSg4JljrsZcRQAIqAiwsQV7SEJekkGpTaT7z9AiKdfcbnunr1/a34/G6cI3
         ApXEml8YAniDmJ8OcO0xgQ3j/7zkk46bmpmhBYqYIapchcYAi06dLeRxLsGzlSIUfcBD
         hsew==
X-Forwarded-Encrypted: i=1; AJvYcCV6Vwx4/PKRyaI8GWj65R7YVMPCjmB/JFFhNBjrsSZFdX129YYpOqOIHtz1O8jgvwK2m/efygnEnGTDGYc=@vger.kernel.org, AJvYcCVevSQcm8Sb/nMucT+JaPrbzsLZxFm1OZ9jtTfxA5Kf7IhTqQHa2QiWIQbQeS+dEqrYgz6yBort@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsgBz+gIMr6tDaPA6F5GKI+Ps07rwkSKSFllbC3Jte3q8M1zh
	KhRQdUx4XpMMbZv0kw7MM/e0vqnMO6gGP2Bmbx5GscYwkKnPHIBU+UNFEhF3
X-Google-Smtp-Source: AGHT+IGgu1jSUqYjZKjOYbnXn1nsrIhnYrwxb/3xQlm5EfYze6tjtr3VpH9tLksudem1i/UY2FDKbA==
X-Received: by 2002:a05:600c:1d01:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-4316168ff01mr54511965e9.32.1729370424455;
        Sat, 19 Oct 2024 13:40:24 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f8f1-d6d3-1513-aa34.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f8f1:d6d3:1513:aa34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57124csm3947365e9.8.2024.10.19.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 13:40:23 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 19 Oct 2024 22:40:19 +0200
Subject: [PATCH] usb: typec: fix unreleased fwnode_handle in
 typec_port_register_altmodes()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-typec-class-fwnode_handle_put-v1-1-a3b5a0a02795@gmail.com>
X-B4-Tracking: v=1; b=H4sIADIZFGcC/x3MWwqDMBBA0a3IfDtgfNF2KyJikokdkBgyPlrEv
 Rv8PHC5JwhFJoFPdkKknYUXn6DyDMx39BMh22Qoi7JWhXrj+g9k0MyjCLrDL5aG1NmZhrCtqKu
 2frlGm0ZpSI8QyfHv+Xf9dd2pSwwzbwAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729370422; l=1041;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=LenEoPlLmA1SoqKTjqXO5FKYciLK+4R5R4u0zaMq9I0=;
 b=Q6IrHGjc5yf04kPOWOhyGiHXS5Nl+JAPc+FZ00GrtAaqPHTzB4v0Yt0VlLGp2HHfV5leSOxyr
 hBITbIU+2qMDALA9HgSYiP9VTWZ+QZ5A9jSKuYr2+bbr+hSn2yEWxf1
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'altmodes_node' fwnode_handle is never released after it is no
longer required, which leaks the resource.

Add the required call to fwnode_handle_put() when 'altmodes_node' is no
longer required.

Cc: stable@vger.kernel.org
Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/usb/typec/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index d61b4c74648d..1eb240604cf6 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2341,6 +2341,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 		altmodes[index] = alt;
 		index++;
 	}
+	fwnode_handle_put(altmodes_node);
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 

---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241019-typec-class-fwnode_handle_put-b3648f5bc51b

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


