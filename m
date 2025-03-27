Return-Path: <stable+bounces-126860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD84A7336A
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 14:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186753AF38E
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A0215793;
	Thu, 27 Mar 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gWvhUWAY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC1215F47
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082367; cv=none; b=VIbFggaJldnGt4gH8WJ7qnOaAaWhpwtKKnioAm++jIHLUZdWYqRgADuw4cgguP2jgsX5g8lPCwKBLeA7J8qPvBwJ3ujaCTj5zJpHBGVSo9GLlCryHb3aXDBCdu2XyZO9CtAj2/mdRu5nnEwGpgt1urhaZ/RGeSH/bqnF9Y/ML8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082367; c=relaxed/simple;
	bh=X01JfQ+cKjLUBDIQJcA0FuaIirr7RIaDXRwDLohSwpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqZKRHrhY5vj7aZ91koIbUqHJvOHzSOmR3+A9dOm+/EEUa8VbygDOSzpwB6rmtPV2CXFKPDFlz1OlPTSDn4agCd7tZ7z0an6o//lwVvRCJqHpratr6tYqUSDIjhcv/KeRSnL01/Wi9EKAW2YpZf4RAHRjWhGL7/axQY5Y7Ocw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gWvhUWAY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so1846076a12.2
        for <stable@vger.kernel.org>; Thu, 27 Mar 2025 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743082364; x=1743687164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QWUGehiM8ixd6+3TpttVd0daRztBUJbH4ZU660F4gQ=;
        b=gWvhUWAYMASZ4XSfUiT2UeoJAIdBM6poIF+q6X0K/UWPRuMCRgXO5ReEFnPqQwFqe8
         +Z172VuJodGnrSzEAGq2QTpdf2FqCVijS5taS/GYWTPcnVs/kWIaGV+nH4EIVsHQk72C
         mfs585TIdsUumaqY+ONa/D2G6BOtFmsBbSmeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743082364; x=1743687164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QWUGehiM8ixd6+3TpttVd0daRztBUJbH4ZU660F4gQ=;
        b=j+YGl8JudflzpmtO93+azZZ+4/We07ifA+wkBAi8sFBDomYN83PF1dlRLif+D4KzYP
         ZeDHW1GiTBsmKBbZzTJ09voz74GNmh61EZHZo93/g0n8mqv9535zp5cIrMwWfhJ+y5ES
         7Uk7Ari9G0b9m5Hw2EG9MJqtLXRCe3dVdG5UHGzUcpHNsDwPYgvQfiLheWGOEH00HS84
         VJGpodZaqzUWQmE97j0cdS4X+X+22w27SklTMa7OFPkpjiXZ9FO9sB6DQ2Acs4rPbMWO
         jcrzNQ4cU2lhRV331TXvo2f5hIaAt+6rJS/EgGMhKnJyMHovVjwFH/B6H/VMewqNlVfb
         5GyQ==
X-Gm-Message-State: AOJu0YyvovXJWd8xtnxI77G11/Mghq2g83UFR/fSpEJFJMv9J2W56pOu
	wMaXk2vieQMOhrN0qON+mHUB9u424A1b7wQe1XcKzxFMS5DTanIoZv/oLm0U9MVGBCIqTF7t46g
	=
X-Gm-Gg: ASbGncu5Jw+2kILFfMxkGdkq9szzXjB+cmghWIERUgYjRs7OecnGu28wVJWf9qfbQnC
	1TMCRdECJmhuFchK2KRTdOIyrqJU9ddY8FQbWLH25Mws7ckJwjHk1gv+asL3XSZmEc6Z8goWyuk
	2LU1aCvAR05BibhShtTVOPLgGD9CBDKqsumm9bq+yOwzexBlsNGu0cZKlTyDlNRf+S1Gj9gHfom
	WtrAzaiZmJs8qGnb3PkZsctUYHR6g2BIRgLPyr2TWZrWcj6oOu6KPm3mt4MT07mGL+hnG2T+mGQ
	94N5UsvF5Y5tYcLsX0/eL3TWIe8pLqm1dbllYX+MmjONg/UmhA==
X-Google-Smtp-Source: AGHT+IFxOoddU6O+duzh/a7mwkqVTM3uDrObVfR/g0ozT+qDooAyVeXgjaeHU37wRux8dIhLye3U+A==
X-Received: by 2002:a17:907:1b05:b0:ac3:c4a0:c525 with SMTP id a640c23a62f3a-ac6fb14254cmr400890066b.51.1743082363623;
        Thu, 27 Mar 2025 06:32:43 -0700 (PDT)
Received: from akuchynski17.roam.internal ([2a00:79e0:a:1:bab0:84d6:4f2e:2c2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef93e0casm1218812066b.77.2025.03.27.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:32:43 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: Fix NULL pointer access
Date: Thu, 27 Mar 2025 13:32:28 +0000
Message-ID: <20250327133228.167773-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <2025030920-fancy-such-266d@gregkh>
References: <2025030920-fancy-such-266d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resources should be released only after all threads that utilize them
have been destroyed.
This commit ensures that resources are not released prematurely by waiting
for the associated workqueue to complete before deallocating them.

Cc: stable <stable@kernel.org>
Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250305111739.1489003-2-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit b13abcb7ddd8d38de769486db5bd917537b32ab1)
---
 drivers/usb/typec/ucsi/ucsi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 9c82dc94da81..2adf5fdc0c56 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1313,11 +1313,11 @@ static int ucsi_init(struct ucsi *ucsi)
 
 err_unregister:
 	for (con = connector; con->port; con++) {
+		if (con->wq)
+			destroy_workqueue(con->wq);
 		ucsi_unregister_partner(con);
 		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(con);
-		if (con->wq)
-			destroy_workqueue(con->wq);
 		typec_unregister_port(con->port);
 		con->port = NULL;
 	}
@@ -1479,10 +1479,6 @@ void ucsi_unregister(struct ucsi *ucsi)
 
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		cancel_work_sync(&ucsi->connector[i].work);
-		ucsi_unregister_partner(&ucsi->connector[i]);
-		ucsi_unregister_altmodes(&ucsi->connector[i],
-					 UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(&ucsi->connector[i]);
 
 		if (ucsi->connector[i].wq) {
 			struct ucsi_work *uwork;
@@ -1497,6 +1493,11 @@ void ucsi_unregister(struct ucsi *ucsi)
 			mutex_unlock(&ucsi->connector[i].lock);
 			destroy_workqueue(ucsi->connector[i].wq);
 		}
+
+		ucsi_unregister_partner(&ucsi->connector[i]);
+		ucsi_unregister_altmodes(&ucsi->connector[i],
+					 UCSI_RECIPIENT_CON);
+		ucsi_unregister_port_psy(&ucsi->connector[i]);
 		typec_unregister_port(ucsi->connector[i].port);
 	}
 
-- 
2.49.0.395.g12beb8f557-goog


