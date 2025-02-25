Return-Path: <stable+bounces-119477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4765FA43CE3
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891F8443790
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A62C26A0CD;
	Tue, 25 Feb 2025 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="V5q5A13x"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44C269D15
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481384; cv=none; b=d7ungrISiaci0+GJbebbhE4BjrNL0gSQdkIj3MtO2DhOKl+GsNOZ7Ok1eK89+brmVWUHDV9GBxLzw6UOJVelvd+XK2L5IglcBZid1qOvgka6336FoCp5ERks/WEHA6FH9ub9wJMuFA7HYwRVjbSRk3NxmMsHWWZo55ehRhq8OkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481384; c=relaxed/simple;
	bh=wfAXzIwhpO2+XBWyWSyz/a4LEzq4MtL1mGejXu/tojw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky2gKlwgDXpPOykswuAf3KUgtJ8ztaAZ0WDwgXgUfLsBYaSqoX7n8KN+1cTp+Vjqo1Z/FBHf1xjpCECorOmccbp+ulghTZbX+Gw5Ohu1qXjY0vBWmZKtCSfedRGswBsc2/KN0j4NCnipFjN81Lqrml1jtk6vbTQwy8FNh5JbzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=V5q5A13x; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43994ef3872so33068895e9.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 03:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481380; x=1741086180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLlb4o6UgVUoN8Zxl4PnDYtKUduOmsdnArEn4cXecec=;
        b=V5q5A13xNgzKTlt4BHIoxSOjLYYounscGx5id6qqSqUQlgxsFmtFXtNpsJ2QSrJ/EQ
         GFt76qN6MvI1ses50OL+mkQh8xgTfgQggGSqM/u+pihiH5KbTmjRTyJIulV5GAU8CJZi
         /Aep5x/YFfK6XYaDdjkgaCMzH7tzczt0hxF6eshhAHYdQ+4GHt6faBw2iRLj4fobDCHR
         BzYwfeElhMjhQbPvlgz5hzmd+F31D4CrGYvcK6tHuPet47uFLysahPsNloo6gF6Frg9U
         7HGVWvk9zVmtzgsD0W8JLzKUJe7Rv4vv2x/77fouXJFBxdvsbMemuzS+U/6o0yxFi89Y
         cizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481380; x=1741086180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLlb4o6UgVUoN8Zxl4PnDYtKUduOmsdnArEn4cXecec=;
        b=exUp00Cp3Y88dgUQEryULSs2SKwyHITqXfK7LVTtSxevIOnzEA2Bkaoqncw07G8yOz
         RGKQAYWH4MZedf8s/F/gwkc8eqWdj6xtjj2+dmZtJTL3O5YDPVvgCpWkYMgyQqFcYr2s
         AeXA2RIrb94Lg/davE1O6B9Pseagt5PHMO031e0h+Ow4JUQSIwbxb5YF+nXsmWJjscUq
         Hpe9j3Z33Co57ITmHiflAe0IA7mSPtuwncC1pRt6+bbW2PVQ7ir0i/ogBH5S1u7g8q4m
         1uWxsOGRLuQUpgR7etT3/RFdN4xXQxVY2Jg8s1NtDg7bz9WVkBc0d6JC+kraEL7Za0YG
         ST/A==
X-Forwarded-Encrypted: i=1; AJvYcCXIAOHNujMwSlZiZzB/iSAY6JgoT3HyR6aMs2M50M42SFaT6F5J1OL7KGNLdeFEJQ2c2oYUQEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzEHAqYo73QzZK9KH6RR3dAfJ/Hnwk27VY6JEW8St3zJJpd5V
	R0ZjsKthi7kfHv3fr8eE8WZHUovASkWzuk+HkeRw1iGaaIA/aJ7jKg6D2yr8S18=
X-Gm-Gg: ASbGncve/QBQ2j4SuN1xo3as6KEoecrcQ7DD15mxXMpesZ2SS5PL0EIpO6IutZXnAeq
	u5xdf+5NEPNCrjmfwovkFIIItyPwn0gDx901/ID0kzgAmOttbW5YPY10jNKE3SJ4jfNgQK92El+
	GiVbT1zhX2olLFc7ekUUFNW86TIJPsPIFPPuAAOq9OtcxxCKnX2+M53oTHoUwrXCwj9YD0pX8JI
	BTQIV61dEH61fsMSJHkT1pA0dmEvX0qD4BCQ8cPO2MCqxBQnbJq0M0CG3w0snhsIPi3QkFOLzEx
	ycMCoYIP+lbCqtf4cIQsrKrtcay3vozqTpAgUtErT9HhSsHOCj2bhsA=
X-Google-Smtp-Source: AGHT+IG6x8BDpeuUVBGxx4Hc7o7ngM89f2LcZF9li/1kqsl7Q4UaDPQZkhe1oRcNJoNTO05ND2z6+A==
X-Received: by 2002:a05:600c:154e:b0:439:a01d:379c with SMTP id 5b1f17b1804b1-43ab0f285b9mr25045105e9.4.1740481380640;
        Tue, 25 Feb 2025 03:03:00 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532dccsm21972385e9.7.2025.02.25.03.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:03:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com,
	phil.edworthy@renesas.com,
	balbi@ti.com,
	laurent.pinchart@ideasonboard.com,
	kuninori.morimoto.gx@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] usb: renesas_usbhs: Flush the notify_hotplug_work
Date: Tue, 25 Feb 2025 13:02:48 +0200
Message-ID: <20250225110248.870417-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

When performing continuous unbind/bind operations on the USB drivers
available on the Renesas RZ/G2L SoC, a kernel crash with the message
"Unable to handle kernel NULL pointer dereference at virtual address"
may occur. This issue points to the usbhsc_notify_hotplug() function.

Flush the delayed work to avoid its execution when driver resources are
unavailable.

Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of work_struct")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/usb/renesas_usbhs/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 6c7857b66a21..4b35ef216125 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -781,6 +781,8 @@ static void usbhs_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "usb remove\n");
 
+	flush_delayed_work(&priv->notify_hotplug_work);
+
 	/* power off */
 	if (!usbhs_get_dparam(priv, runtime_pwctrl))
 		usbhsc_power_ctrl(priv, 0);
-- 
2.43.0


