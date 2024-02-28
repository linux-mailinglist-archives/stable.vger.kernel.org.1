Return-Path: <stable+bounces-25434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA586B7B0
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB52892DB
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03A171EBD;
	Wed, 28 Feb 2024 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4fFdpTz0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B079B7A
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146285; cv=none; b=BTsyR0A6UdmHNLq0nWJKSTB0v9hv/Xx9c25DmAyo+wCbIh3z3Dh8RT1n5ULCAMcYYgQB/aOATxOzt2TMy0aMnPk2cFk94z9Uf7hLf3pnQZTnmKl+zqRrSJ/CLBdUYudCtsgto7MVQ/XMoHKcz8vB0wK3sMMDHZyiHdcxGlKSTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146285; c=relaxed/simple;
	bh=74xrWMGlTWlkqjlt9MN9TpLqx1sShodBXiCj0AvmP38=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ru6KobZgsKke9Ol4u8f6QZptVcFPfj7i7iRh5QSeAxWkHsKzKoAAMvibybi6d2bgDsKh5Y29tGRUaxsY/E9OJKwGksEaWY8cgFziE6QKy+vPMKALTNlSaarFtRB/IvVwVQxGU5/+U8V5YtyfMqozVvYnDeLgstIMB6mUFpcAvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4fFdpTz0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b2682870so222988276.0
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709146283; x=1709751083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q995VDUT1rCWamECeHTo++lWCTqa/WTcSCUgzRaXW40=;
        b=4fFdpTz0jZsGXDB2XeKVNB4Ld/y696qu1FM6CnC3OQ36xJJRIixw1uif0KTXX+OfTZ
         DaZbU/7uNpbZxwqNv2PV+Q1C03VJZElU+uRntihu+kkOiQiiVqCR0udTr7/o4ZiX8j67
         CYkBaaL66K819azaiLcSwr8v6PvnCp44ku8Cs2yNLThzs1vvTofW+VqmTe0zf688KzZd
         qa27wLQMKHzpehYRxiiWfSE26Yf/Wj6loVzfamU+smLq4rSpV5VdwOOGEvB7iX2HTEyB
         UEwzswJuJBEQ8FbnlgH5lQ3QHXmVxOqb8wD72A3KSgWQL6105s4Gc+MVUICOuYzisJAf
         NZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146283; x=1709751083;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q995VDUT1rCWamECeHTo++lWCTqa/WTcSCUgzRaXW40=;
        b=W2KUexnrMEz46rLeiQpMVBkLo3AklP418AUGsQZTVumYUSqQMIVgBPLXj6S61rf3nt
         XywV+vh65us9PL16gD8OVS6D36GmnGZ2n679mH46PtDhAIpgtqy9N6+sP8bMTAJgaM4Q
         XkUpcYk+kgpWKtBnBDdY99oJulw+ahSI6yO8bMHfLNceQS1wAk2LOSvWzlucGrNmDGCZ
         9np/8arkS+NhPS28EudG8YjgYz0opunUc3fThStWD3DbE0glry9yQ/baDubPXPPp0cZw
         IkU24MeSaTeSTwNPZWyljTRiTkeodKQyWJCSFKhhzT2U0tTuw5z+TFGEbVG/VxY1v6sZ
         SlNA==
X-Forwarded-Encrypted: i=1; AJvYcCVTIxi+vr4CLfOZXrxGAx5AtEIoRxnL3A0o1f2oXT2S3tELLc84ZlpzQ+WvA43UjpUaao/CN+8klWHXSchXqoe56uCYJUaY
X-Gm-Message-State: AOJu0YztWk//XvpDYkbpwGBAu8AyyQ2YMY8afm487diinXocmgFlnsfO
	bjplnXwUoqHo2419Lmvg05b3PSze8FI8aROrPodLBfDlmjUND5/YkZwZeZ9gqvxFd9GW34xZdpf
	XwAeg14aKmQ+8o/bl5uYH/XcUBvydbw==
X-Google-Smtp-Source: AGHT+IGnnmWYe3kzdu/ZFn7IzaatprsDRrYZpULNetR7ouB2Ba0CntgRLWuFHTTETzBJffD/BE1RNdgRwXmu5DK9wX8U
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:6902:1885:b0:dc6:fec4:1c26 with
 SMTP id cj5-20020a056902188500b00dc6fec41c26mr8000ybb.1.1709146283403; Wed,
 28 Feb 2024 10:51:23 -0800 (PST)
Date: Thu, 29 Feb 2024 00:21:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228185116.1269-1-vamshigajjela@google.com>
Subject: [PATCH] spmi: hisi-spmi-controller: Do not override device identifier
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

'nr' member of struct spmi_controller, which serves as an identifier
for the controller/bus. This value is a dynamic ID assigned in
spmi_controller_alloc, and overriding it from the driver results in an
ida_free error "ida_free called for id=xx which is not allocated".

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driver")
Cc: stable@vger.kernel.org
---
 drivers/spmi/hisi-spmi-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 674a350cc676..fa068b34b040 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -300,7 +300,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spmi_controller->lock);
 
-	ctrl->nr = spmi_controller->channel;
 	ctrl->dev.parent = pdev->dev.parent;
 	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


