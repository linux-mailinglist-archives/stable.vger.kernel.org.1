Return-Path: <stable+bounces-96271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF54B9E1926
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C2A161B0A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354F81E1C14;
	Tue,  3 Dec 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OS1xNeSD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555B1E1C07
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221406; cv=none; b=uaa3hzd/umunzbSXwuDHXlJ81cZCFEhoAJ3B4b5qYgxNO+f70sChwpu9CS2ACXO83Xc/29F4ydxtSbCwF5+oefEwF5uK9+s3AKNq6fN29v7015ovc5TmcWXAYgUUFrVtAapf7Zmze3pAaF1y1Lzf9m5bhMfVyrt/NmqpG+AXHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221406; c=relaxed/simple;
	bh=ETw7u1mk0LjlQqPvj8gR4APdnoQAxNUE+W5cxhDMBCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqrUvHZBXLwlA6jdx/lyq7akPN0d/s1Srp5z/V28iT4Fl73kcVFrooxU2lw3iGgk+PEXnYbUi3ccKXfLKnUdCEl97YqqpiY9/5gTCoguAEEHjw8Pwr3WvqlYqjqZS2ZGS4U7rO3r25G3MeUnPbx0mia/JNwnujeZEZMcMPBLE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OS1xNeSD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so6767125a12.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 02:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733221402; x=1733826202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJzpjZ91uuCvgpzILXkD8zrAjfL5m7WyfegMJCZBGNo=;
        b=OS1xNeSDFRucWUPYzNa4KkWLxq2n/G+Te8RHXpU/jaGhzQVVCxUeHIQrif/bUYWx0U
         JMlarphRDAkG0/fQjrqKISCDNhpHnh0zAQE3JNYISpEDJ6Yy0JHLGt4vVIaEbTICHOBi
         +XgFjGiYx+bqe1Z1698fpD39UvnE2FMBGCQsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733221402; x=1733826202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJzpjZ91uuCvgpzILXkD8zrAjfL5m7WyfegMJCZBGNo=;
        b=Htic2aFLTqZLxQmLaosPopyt0FQ9gapdBFx52w0ww7XErXwFqrCZiLHqFznLSnF5KN
         YBJKoIGq3kwPNxKJziKKxyHeieyTKYAuQgeUgk3d6ZdXiywLf7dDRKXb1e0W0LJyGpMj
         wzscvQo4UEzk11WJkalPAOJnsez46thZz0MEUlIOKLhoC9Olf1epf1JWHoFc+cWK9mb2
         59pn4oNwLKaT49uBf3Vla5Sjo2rxXAVcwJHfXdKMYxLUbXRyL9jXue0e4Hs27ZXgbSu8
         ckGq/JX4ETx5iVQn9Ya7LiAcdVthasF4jkTEuLq3ODrB2QCCiB/lXeW8tr1O4YhYdpo5
         ABIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKUHWH/1Vuz8RhPntbujnHi3avwURFnK+Fm1FN7ORY87X/UZkFhinr8OOFDRYvOdOOY0zy8wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMARgEsv3aqs392Xp020mNZp3UJ0Uz3LZFsw8ASnc49gX9K+VH
	VnO4b7dlahqDasehCaRtg48ikt2b0eWOD/1etIdO699JC6QGWN0OpVFcBmJF
X-Gm-Gg: ASbGncuoWk8W5hFh7THxKbytQuOWaFURGyDuPVDNoqPsJBGvTrW7pXVyGXdZBj19sw/
	OV48t9hnv23DlSQ6vmoao/RM7h/BHGMSiIAEI3qMMUVz9d7T6oCYGSqd8wxb4HsjArb5IBiXr/9
	SNEiv6FKDLEOvsQ8kuU3HJfjFx1+VDhAIvSy+J87s9fTzQrFb05sA1ZgC1ExtqKluCbJEeITz7I
	5HwXjqsx/91R7zSJqtmtm4YmfLfeJBiAAbomFGwPvbvM/BDVS4If2uw1YdZm95yxSLBjRLXC4R5
	DtmB0kVNxEn1g8xARnN8c5vrkz5Rs/on7vI=
X-Google-Smtp-Source: AGHT+IFVjs1rNJEw3UFMNZnu1wLLGO1PKNpGomwEtLmWDel9W+iixQKGmicK6vakDP7uGLvRDgW1hw==
X-Received: by 2002:a05:6402:34c5:b0:5d0:bd2a:fc2a with SMTP id 4fb4d7f45d1cf-5d10cb80224mr1426909a12.26.1733221402401;
        Tue, 03 Dec 2024 02:23:22 -0800 (PST)
Received: from ukaszb-ng.c.googlers.com.com (103.45.147.34.bc.googleusercontent.com. [34.147.45.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0f6cf4bbesm1720851a12.43.2024.12.03.02.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:23:21 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: Fix completion notifications
Date: Tue,  3 Dec 2024 10:23:18 +0000
Message-ID: <20241203102318.3386345-1-ukaszb@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

OPM                         PPM                         LPM
 |        1.send cmd         |                           |
 |-------------------------->|                           |
 |                           |--                         |
 |                           |  | 2.set busy bit in CCI  |
 |                           |<-                         |
 |      3.notify the OPM     |                           |
 |<--------------------------|                           |
 |                           | 4.send cmd to be executed |
 |                           |-------------------------->|
 |                           |                           |
 |                           |      5.cmd completed      |
 |                           |<--------------------------|
 |                           |                           |
 |                           |--                         |
 |                           |  | 6.set cmd completed    |
 |                           |<-       bit in CCI        |
 |                           |                           |
 |     7.notify the OPM      |                           |
 |<--------------------------|                           |
 |                           |                           |
 |   8.handle notification   |                           |
 |   from point 3, read CCI  |                           |
 |<--------------------------|                           |
 |                           |                           |

When the PPM receives command from the OPM (p.1) it sets the busy bit
in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
command to be executed by the LPM (p.4). When the PPM receives command
completion from the LPM (p.5) it sets command completion bit in the CCI
(p.6) and sends notification to the OPM (p.7). If command execution by
the LPM is fast enough then when the OPM starts handling the notification
from p.3 in p.8 and reads the CCI value it will see command completion bit
set and will call complete(). Then complete() might be called again when
the OPM handles notification from p.7.

This fix replaces test_bit() with test_and_clear_bit()
in ucsi_notify_common() in order to call complete() only
once per request.

This fix also reinitializes completion variable in
ucsi_sync_control_common() before a command is sent.

Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
Cc: stable@vger.kernel.org
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---

Changes in v2:
- Swapped points 7 and 8 in the commit description
in order to make diagram more clear. 
- Added reinitialization of completion variable
in the ucsi_sync_control_common().
---

 drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index c435c0835744..7a65a7672e18 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
 
 	if (cci & UCSI_CCI_ACK_COMPLETE &&
-	    test_bit(ACK_PENDING, &ucsi->flags))
+	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))
 		complete(&ucsi->complete);
 
 	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(COMMAND_PENDING, &ucsi->flags))
+	    test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
 		complete(&ucsi->complete);
 }
 EXPORT_SYMBOL_GPL(ucsi_notify_common);
@@ -65,6 +65,8 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
 	else
 		set_bit(COMMAND_PENDING, &ucsi->flags);
 
+	reinit_completion(&ucsi->complete);
+
 	ret = ucsi->ops->async_control(ucsi, command);
 	if (ret)
 		goto out_clear_bit;
-- 
2.47.0.338.g60cca15819-goog


