Return-Path: <stable+bounces-200189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD27DCA8F2E
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 19:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 760433018350
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993636477E;
	Fri,  5 Dec 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1OX2jc+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251F362AB7
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960649; cv=none; b=HnGUiMx6blGeh0qCIewHq1dI6wYr2jWJaqwTjvgsBli93mx6FMEV10DFQZq7CgpbcnYWcV/0MyLFHb1TlOWsaGQQFKoW7+DWV0ZwJwu7E07PuU+onN8f8aRo2RT2nqxbShVfpJ7yIMHvkjPhrGNb1a/3vfxLqK49IZ604GjD3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960649; c=relaxed/simple;
	bh=N3KeSn5DhptMETPek/UBNqndVmpY4DeybLgH9xhnZ08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgnXs7AeXD04LC/fb30ljymm33hRAuzAeR1Kp0fZnF5MibEXkBDvN+wpIai73klnzJzROs42vjtj43Gh0kWpvS6xFbgnjQyrPkn2BMdOgZUrZ6tPlD0NymU6YXv++u4/hJ3l/uMYwt6aTly3eDuJDkFj+UspysDpOh+3WXIPRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1OX2jc+; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7866aca9ff4so25128947b3.3
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764960645; x=1765565445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VvqenfVK6YXYxWcW+E1Ogd+5OX6yiW3pCxzW+6ISCU=;
        b=H1OX2jc+Q+LAs9Hl+QTMtCqEq14FEvR0sQbQ0HcdkHbcT/GuxHqQFulNfpDp2cqR0z
         L6UEPv8kl+c/SIxGeJ8o5e0ZBBzvG3aP1XfR0AYdpM+hqhl+3yijjOnT+wBVi9Fiudg+
         g8+QRtIdGEyfTjKHFyTUk1umiRthVtvF4vw/d1F7eFex77GGBf1zt8pk8eFQ+ftWCvhV
         a86jZqCr3O9ASdAg/uphoYCQx3IX5TJeLY47TxzFQTbX4sn/yCll/46DPNmZLmw1S4+J
         0TKfMwXoZ9C0+KaBH0kExG34RzFmgyGRP/3R+8dSf0nRmIY4qFdOHqvCPUPmf2i+dtki
         w86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764960645; x=1765565445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6VvqenfVK6YXYxWcW+E1Ogd+5OX6yiW3pCxzW+6ISCU=;
        b=mSpu4B6IGrZvtjJuGUw0vB6AE7jCvtiq4qXy141g/8+hgLyRMz1M+BcPOYyU2HGtb7
         L8F0pI6c8Dz5gmN+wXQIyJ6UlG12GNQmaU7b/cZLBRdbFwBeCH68mPEH7L3v1edL042B
         wugJ0k7clAoK5n4ySexoZNEuu425kcCfRs2G0fmshkNhPhTKtE6Yf0FBax+tqg1mpwzP
         zFpLOYohL2PsLzHkkX4Z/+q0lEK9lUhXtHxRomf49Q4jJ5TbJH1EaCJUWhd0KIB0pWo5
         Umei+Scx1A1ChMOqX89e9L4AsEUlomkvurh6bDpi6vztB4Q7tNURYXQJbD35TJmNbtZE
         Tzzg==
X-Forwarded-Encrypted: i=1; AJvYcCXpsaNJIx53iPM4W6+seVggZzqMtIChFbvUMtlFooFWHN6+B9ig7te2w3Z9GoIr6uzKSjKmr7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAr6Eaq6HL8cleUmw70WKqEKNXiuBwMhRThswIvQLjy6Oomg9q
	Ld4tp9kudfA24IZVfDtge6ivHdyAOpWaF3pfjmvsVHz9EXseC9919q8b
X-Gm-Gg: ASbGncsrdTAq/vGkrUtLhdgjDOcxCCNp4WWi3CDibAZF+Nv1PFRgDw24/p5zBg1sXvx
	Z3hgy7CfvIPmqVfqIAKOTuCIWIi6BoC6wkGVwyJtg89+j39fD9ZlsZxtdU/l8ii2MBl6Nnwq7d6
	vnK5NBpszkYJz5bQys+c8/4mxGgGgZc6B6LpFfG5MEzN/+AemFAbBvvJC+OvV5CEMpguahY62/X
	T00slIUqNGfAPMzZQ4/9Ij1CzrTY5uO+y0pHD8M9VeOgsYDdJdeoLOw14E/Ln7aFO4t1Yk8Qo6f
	XcqituXiBU0D9VRwT0Lo0itrBV+GJSqKOCSU+Kj9UDWU4rxJZCbufqmJt/rIQDSZy/SGLQvTNjb
	MZlW33hVjvaghM5LQ3Qxhljo5z7est8XaGahMJqDWOfYzR41W6UzH2dt8E5Y2s6xVLggTGbCQYt
	Nd9BUGibW6tlAk
X-Google-Smtp-Source: AGHT+IGB9Encw5yA+TZ8NKnSkIJJq0yuc29F5NYiqKYNeHPI1ZukYjqakGBdOTu6uAuvLh1gmML2qw==
X-Received: by 2002:a05:690c:4a11:b0:787:e3c1:8c with SMTP id 00721157ae682-78c33cb3eb3mr687197b3.64.1764960645500;
        Fri, 05 Dec 2025 10:50:45 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c2f0aaf83sm4586407b3.32.2025.12.05.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:50:45 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 05 Dec 2025 13:50:11 -0500
Subject: [PATCH 2/3] platform/x86: alienware-wmi-wmax: Add AWCC support for
 Alienware x16
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-area-51-v1-2-d2cb13530851@gmail.com>
References: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
In-Reply-To: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=N3KeSn5DhptMETPek/UBNqndVmpY4DeybLgH9xhnZ08=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnGmo01oR1x2VMnzl3ncMHlLscsh9Z/+8pKgx9kPuOSe
 ri5gseyo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACbCJcLI8FX+sfXfJtu1QTGl
 Z/44qbb3VEUn+TyLytav+LJuW3TVU0aG70zZ1xa9YlB4yZ7NkTf3n032oTbxZw9y8+9MUFy8xYm
 bCwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add AWCC support for Alienware x16 laptops.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index b7b684fda22e..baea397e0530 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -177,6 +177,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
+	{
+		.ident = "Alienware x16",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x16"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Alienware x17",
 		.matches = {

-- 
2.52.0


