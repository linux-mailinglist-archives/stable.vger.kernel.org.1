Return-Path: <stable+bounces-136539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABCA9A6B1
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F10116699A
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C918722A7FC;
	Thu, 24 Apr 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fiXBQ5fJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC358228CB5
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484285; cv=none; b=J6DOEFaxziXfFw0DviZ0xAYrP2xMvqoMzp/GaQOzW/stVmv96VYSZjbNfZAg9j34y7/cGKRpWou7wu6u5fKa6MffcM1eWht7THLEM/Ra4gLr/wVrw73HXFfhd8cPZQ6ZWFI1eHZ0SH2zutwW4PQYxfMEEiennZtPoFfzVP26Z+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484285; c=relaxed/simple;
	bh=CGJ4lb9gLXqwy9cpqFnBRdCu4buMezQ/KMwBM556iLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VInRzD03swGJT1UACJiAR2y4N4IQNR3tuEzLE6ncAMqDBDSzwabgDHjrF3N5XZkDO1z7LLs54VYead0zk0Ks8QpDEAmIWUWsiO9AQ3+kND/vgFR6EhzX5GpIi9cUyocyPPPuw5HqtOwZwhqbmTm5JQHWuazI0M5MpyRcSHW2sKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fiXBQ5fJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so137795166b.3
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745484282; x=1746089082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOV7HKDdI7XaLmmxtuottKdbNPwVla7Cb6o0YW5q+p8=;
        b=fiXBQ5fJ+bx+VX92/PpxRjo+Zab2gLaqPm8JQ4YVEb/xCbKX05IMX0UDf/H0VOKpPT
         gGZ52S4WhtDdOzVnLSH/KK7oZnQR2FI0EWG6TACPAWjdIHrwwbv/k3G6zDZfLrAG+QGm
         shqvvoYEouzfZX67zer2Pa9JM26APdgh/eEI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745484282; x=1746089082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOV7HKDdI7XaLmmxtuottKdbNPwVla7Cb6o0YW5q+p8=;
        b=Os75xhS/3Lpr+MUAXxA3K3XTeIvrmIO/p9hfQLm0A5amvTjJskAyLYuiaCGydJzBWP
         mGHJFifOz5K7wt759wfiYRqZ0m36ApAcKKKwYFNIaoE+pFTSrnDrBIuHf2s9MKvAwB6b
         TvDNmu801Yx3LuK9/PTkUYalD1eKF8CBwK74jt0lkGhdbAubLNPhQrZZNP4odhl5Nkt9
         3W/Wp2d2+3+wwjcZ1dDocptKoktbZlhLLkUhHilOSbxwva+SASQN2ZqIV/c07/lhDrmR
         rw+jIB9OjPuAYlw/CwlB8/E2ZPvwpQU2fmPoBJqIskrONPYMdDs2kNj6zanuYBWBYu0K
         PtKw==
X-Forwarded-Encrypted: i=1; AJvYcCW2om6IOx2Po7TB/94geT6v9Dvj0bGA8JXWK9YfJCIgx6OR+8ZCX4x4L5NHl7aFBociGjiwY/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOMhfI4KDKomlOk1HhKJLKPYP+vtRWGoBciIiSP0sgVkLEcL8
	C5MakcFiMJU43gwEX3YDV59y0nl2+UidCGv3Vs1U60Dl9T/4eqAz2FmbP+XxrQ==
X-Gm-Gg: ASbGncvRrpGHH6gkSWGM/nSXkz6KQp5/A4LwDWbePmKEdA95IxF7U1dGa6sphMWx1PE
	2dg9mQILJbtQBioRjpRzEATqu0OiYalJca1Hufx1OQqYigFkcEjd1QIlwZAD2GznQg9Z0frReuH
	kasz/QMZTI8aFiB58Bey/tEvRvpfZS+/kC9tO+e53wIoFLngTylJVneY9L6l7R9YhL5ZjKh1N8O
	u7x9QDW9204L2BYnhJWK3SkIbqcL8RvWtF+WI7RT6cHbsZfG7jqg6W87Z/zyIELH3PIOLOBQGlU
	YJJqgMrhxzZHDzDUcl8weB03kfNExbdJbnS7RSvW2LkIg7jWCqdPMFQXFRdafOwUpFMr25c3B5G
	ppuWxZAYqY2UbSws8YO6ccdlcKZpe9eAFkw==
X-Google-Smtp-Source: AGHT+IGDweb2ftW6YAhGNzGas4oXbYMlgUSzms8AcDFioP7Y4uwQhnokaPl/3DGk+MA365cjpfU/uw==
X-Received: by 2002:a17:906:794e:b0:ace:4fcf:702b with SMTP id a640c23a62f3a-ace5728a3ecmr178033166b.28.1745484281876;
        Thu, 24 Apr 2025 01:44:41 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (100.246.90.34.bc.googleusercontent.com. [34.90.246.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59c5eaf0sm69377466b.181.2025.04.24.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:44:41 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Madhu M <madhu.m@intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] usb: typec: ucsi: displayport: Fix NULL pointer access
Date: Thu, 24 Apr 2025 08:44:29 +0000
Message-ID: <20250424084429.3220757-3-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
In-Reply-To: <20250424084429.3220757-1-akuchynski@chromium.org>
References: <20250424084429.3220757-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch ensures that the UCSI driver waits for all pending tasks in the
ucsi_displayport_work workqueue to finish executing before proceeding with
the partner removal.

Cc: stable@vger.kernel.org
Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/displayport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index acd053d4e38c..8aae80b457d7 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -299,6 +299,8 @@ void ucsi_displayport_remove_partner(struct typec_altmode *alt)
 	if (!dp)
 		return;
 
+	cancel_work_sync(&dp->work);
+
 	dp->data.conf = 0;
 	dp->data.status = 0;
 	dp->initialized = false;
-- 
2.49.0.805.g082f7c87e0-goog


