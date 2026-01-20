Return-Path: <stable+bounces-210452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78AD3C271
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734C85E0162
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A043B95F2;
	Tue, 20 Jan 2026 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM6kXlGN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F53B95FE
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896463; cv=none; b=cCXiA13ZUJR/+TfEIKTuBtuhAJ6ZJj+otMTkY4YoQcNCA7T4lAV7pH7F6aMy0aCjasdg2y6pbS7ClkWQBuBIxhFa2alOqD4cfS0ia0NgvWrWKqk7KX9n9PPXWwE0GDXztB/SrkTQ5uB3zUQklJrP1jPzunL0bMshQf+It6P1N6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896463; c=relaxed/simple;
	bh=8cXCHWqSFqAhb/0yrvwMCQYeAmlW3lL6PDpwp+nTw6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5ClcEnjH7ekxPfFv4ZWwF33H/ZTwYBEhoxmCIPRpHIPu3EjVGwn+FucAC6kI4oLhd9KiNJI/CIwmestX7rDvd0bbCPCyXxXlSpwqo+0CcwblcN0BaTcWo61FcZkEXQdzPTArZ2A94zpkG+A5mPX0/x7HKTBsdKUv5eh0qZQc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM6kXlGN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0bae9aca3so34083695ad.3
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 00:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768896461; x=1769501261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Syo4ZZwZwDuvqR8s7EAD3Gw1DEsI3pVtXVpUzZjtTyk=;
        b=QM6kXlGNHluP18bDdUqkPr6aIDZEMXEPsLo7AHiBVPYJtXwmoAQb25suvpxtNBUeJ0
         iwMo6g0UIHqpo/ax/YF/xeXqUh8eQWTOAopuCXCIagmapi3i0oYNVdcTsXUYAHjlhfOw
         rTwVNoVrgGJI9IaW0IQwXuwzQyCAV7VXSl/1o9riXmpch0rSnMQIoMM+LDJW20nTfLg5
         L2JMGD9lQNZaUQt3Y2RJ7STtbew6LOtf2IntTa4FmZx2CG/FcJOWFE8g4JldsuC44f7O
         Z1ZVU+J7DH3oZALfybJmJsLTqEviVOk2PHhKdzxUhiVweL9UT+iLwvU7z5+J/98NMAAZ
         mJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768896461; x=1769501261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Syo4ZZwZwDuvqR8s7EAD3Gw1DEsI3pVtXVpUzZjtTyk=;
        b=QzAlv7wgjzm8VrDEI6wKXKF/aBjjTESJ4X5rvj8fDJiK8Jpw0eZCiIyVi+jXWnjHAX
         JTqYnX4nyF0zE0ppiumX2M9GLOBPr/tUkOMsmRIi7rE3DUc+bSRPy3iaWtCcheL8gArb
         z9/9q5ueWA3y6HdcxrhoZ7i9N+npcOa3p7UQZ9ixKtEJwLFeQSKcumckp23B5zqKIJzL
         Mwg61aEHbSNiXUCekbSyfTL5Wut/Rn3XzHuvAVAVzDtXJRZpqmY0xIndjRYYWirb6yLG
         tVwRYu2DYbcFB2G/vkmI6nBQAHacqlEIAZECxXKjEt1QVaP8hL3J/8qzVuOvKwTxxOuY
         mQPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJMrWRt4O+nTuf2vXF0vEDKGnxKdWBtHjHWfo2h36sTBvSXDUXX6lN7gqakAYKYeNOFJ0N3v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBERF0DLpUyik9AXiciWTy4mzkFyKnG/FfgZ9dDaDurRneJoUx
	DwsEJfNnAClt6ogb4trpQo5kQpU0jAyocO9dwEuGR4GIDLmXJaLZnwOQ
X-Gm-Gg: AZuq6aL8IJt3L0RSRmhTETfD+9oURNBPyvvcJSw46nNdzt0bTBg67ey9cUfhkwyATzf
	w4K3VpCCMBN+DAUwFiOFKZ4oZyYKNQ2kl1304pYxqBGNTqGdmuZvjucdh+Wfxs/W58fzbHm54a/
	cG+uxb9qQ3aH8kDxKvxbUCpxbQEdnDJTodwIg9KVC++UOt+zVRftsLlTzDCgGjtCylUAF9klOkk
	BfqAEQjyO/gkY1FtAXpRoz3IM76BFHH8MghdOoDXiGjXq4i1xEAaTm6bG+e6JPfG38YfW7/yaxO
	wqj6Ws/ABU6o1bcp7GD4gOB4toAe/ovWNQauiF5rPL5Nyums6f9Ss6kOGNe2149m2OV5QWzj8tx
	4KSiPICOxoqwVzoX/e9k5SbzGanD6v991jWMR4GX2Eo+DYp4d1cWdE2pvkpXOnUw9zC5r9bYVzQ
	CbaTtTZveVdJoJQXqOc7r9yv3kiTX5lRESzpDu+AIyG0eTzJQt9zAGV9ndVPTepHiwaen5X9x+3
	hNK+9M+RyUUQ7GHKHDN4+8KXOEDTSY3Wj2sKMWpJriGOg==
X-Received: by 2002:a17:902:f544:b0:2a0:ba6d:d0ff with SMTP id d9443c01a7336-2a717533f7fmr123178715ad.16.1768896460959;
        Tue, 20 Jan 2026 00:07:40 -0800 (PST)
Received: from 8d75dc141a66.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193decfcsm115731655ad.60.2026.01.20.00.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:07:40 -0800 (PST)
From: Wei Li <unsw.weili@gmail.com>
To: tony@atomide.com,
	haojian.zhuang@linaro.org,
	linusw@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Li <unsw.weili@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: single: fix refcount leak in pcs_add_gpio_func()
Date: Tue, 20 Jan 2026 08:07:35 +0000
Message-Id: <20260120080735.548853-1-unsw.weili@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_parse_phandle_with_args() returns a device_node pointer with refcount
incremented in gpiospec.np. The loop iterates through all phandles but
never releases the reference, causing a refcount leak on each iteration.

Add of_node_put() calls to release the reference after extracting the
needed arguments and on the error path when devm_kzalloc() fails.

This bug was detected by our static analysis tool and verified by my
code review.

Fixes: a1a277eb76b3 ("pinctrl: single: create new gpio function range")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Li <unsw.weili@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 998f23d6c3179..d85e6c1f63218 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1359,6 +1359,7 @@ static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
 		}
 		range = devm_kzalloc(pcs->dev, sizeof(*range), GFP_KERNEL);
 		if (!range) {
+			of_node_put(gpiospec.np);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1368,6 +1369,7 @@ static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
 		mutex_lock(&pcs->mutex);
 		list_add_tail(&range->node, &pcs->gpiofuncs);
 		mutex_unlock(&pcs->mutex);
+		of_node_put(gpiospec.np);
 	}
 	return ret;
 }
-- 
2.34.1


