Return-Path: <stable+bounces-125753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29C0A6BD3B
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0173188935D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B251D9A5F;
	Fri, 21 Mar 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IbNbmAJ5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883431D63F7
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567917; cv=none; b=npPK+SIGsei6MXGnSJkRCN8xgUJm2UrB/xveIlUPoIjxd7RlrWWTwdpRSNqWSd7F3vQLh63sJfqXzg/naejEw29heKVbxZ081cIlhh1w1sJ8D3mPeNZxzmLz2N61TuyWpp5zTmjuhv3FCLsZQlYO/l3B+vQNcc8xo3sXsVwyihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567917; c=relaxed/simple;
	bh=somCsdwAZwSYpVOFZ7+NaJb7TDarJS/nC+HR7pvWjx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLpU7mRwt2sBHgDoljA7cAyl56WosYpoXoP2FoyjXf3w3pImFg3nOenMk9A6CFwwEqqVLKF+AWBB8l8pyLXyXl6Rt3ajUCgvdDVZNhZs3Crey6XvPZlEayNxofiVQmGxKxZic10PYOfHur0UOnIV74sK54r4B7BwtwpRoEBtkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IbNbmAJ5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac29af3382dso329967266b.2
        for <stable@vger.kernel.org>; Fri, 21 Mar 2025 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742567914; x=1743172714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpYeREYD441841zmxzfOu57tf5+TRBtE3JtUo8WB5k8=;
        b=IbNbmAJ5ndgMTdBDPQ9/jYKcCSeQM3Ag+E8/WYkzwNjF9eIuUp6dWPZaxaTIss7Dry
         HcKqx3rc9bGYXEgt76+9PchNyD/BJV5paYUxDZQsjvGlcUoD6wgy0AXcMr2fNHqAtmZU
         0AajppGLYkfmmIrTttZ6c11pfOIl+YnjDroTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567914; x=1743172714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpYeREYD441841zmxzfOu57tf5+TRBtE3JtUo8WB5k8=;
        b=SPQgAsq9gyY7yL1OGxsYXROvMeNC9mpHiW7xfVo2pm6Jq2D9z4+D26LeyaWjWJzHIs
         sbu+SK2Bw0IBfLQdQ84YdMirbyQHk3Y3fV6AqZXhKNCqKbtgWLBs1WrG3kQI5uoZhtu8
         7fliWwF2A6pYtyhFCpSaUBAJF/IB6PNS7QrBpZTybb+zYMWZnTqQtECpspQ2jlEd+iFY
         W0gGkme5gLiF6fODZlvmZNRBS6s8IiR0gaQX8q22JdQD3AQJNYlyq8Wn/8armdHXXloJ
         8B4ylqG0zOvFPZI4Pwrr2ayZRRuAzx/TrHBrvTec47dvLr/ls8wAE4RQMlu2pqVmln/D
         T4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN6YQ/05megGPEeWXkhc9hU/YYlGnV14b1fLA84D8e9lHxRlw5GWoaHks0YjH1QGKqIyQaKyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9Xe85eWnLYuGcCxonoHdOKKK9lN8x2+VrTfJL9qzuQKK5Ton
	C0kfg6DfLGUoOF2lXUcm/+e9q4EH9s47whNtNmjQnshSbJ48gftOc32ZN//ijA==
X-Gm-Gg: ASbGncshp/buE0KR56Ak0fZgah2GVP2OcLSDf/7gAuB4tiXge0jUVuMZOjIW9V4F9ut
	Qobt1rDZnZnJoo9Cjpa4mSTvYQ8pxZ5xp5sHx+SyzZ0tpB1dxUyR/y1Z1Q6ir9gPe6jEX5VHNS1
	/PTRn+h3nZDPKCc3nU+eEBxMBRHoy3+RRv78tTG3wnKP3Bz3MiY037RnEa+Sy/FOmeapXpzkFYS
	91GQStsnr/cGpYHYLJBLuiAC2zG79Asiet+bUlxnfiSryhER5dh8qIYJ6aTQOLS6fOKfDnuINPb
	tP0y95GC+GOVsqmeAwx9eewQdPbeBZ7lCsbX9pVeKlrMDpoYrq7UbN3liU+1G9jUMH7iusHrL3D
	pdffFTqpRhjvJhptTTPh9SGAo1mUBjEnG33w=
X-Google-Smtp-Source: AGHT+IFx6Z5++sXoujB2L8zFX/kIAOeEopfZFF9EvYWaukAV92ezO0xWR/S1jldFyiEhLEo4ae0bLg==
X-Received: by 2002:a17:907:3fa3:b0:ac3:bf36:80e2 with SMTP id a640c23a62f3a-ac3f211183amr353993066b.20.1742567913806;
        Fri, 21 Mar 2025 07:38:33 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3d43sm165303566b.51.2025.03.21.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:38:33 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: class: Invalidate USB device pointers on partner unregistration
Date: Fri, 21 Mar 2025 14:37:27 +0000
Message-ID: <20250321143728.4092417-3-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250321143728.4092417-1-akuchynski@chromium.org>
References: <20250321143728.4092417-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid using invalid USB device pointers after a Type-C partner
disconnects, this patch clears the pointers upon partner unregistration.
This ensures a clean state for future connections.

Cc: stable@vger.kernel.org
Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C partner")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/class.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index eadb150223f8..3df3e3736916 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1086,10 +1086,14 @@ void typec_unregister_partner(struct typec_partner *partner)
 	port = to_typec_port(partner->dev.parent);
 
 	mutex_lock(&port->partner_link_lock);
-	if (port->usb2_dev)
+	if (port->usb2_dev) {
 		typec_partner_unlink_device(partner, port->usb2_dev);
-	if (port->usb3_dev)
+		port->usb2_dev = NULL;
+	}
+	if (port->usb3_dev) {
 		typec_partner_unlink_device(partner, port->usb3_dev);
+		port->usb3_dev = NULL;
+	}
 
 	device_unregister(&partner->dev);
 	mutex_unlock(&port->partner_link_lock);
-- 
2.49.0.395.g12beb8f557-goog


