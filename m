Return-Path: <stable+bounces-131958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EAFA826F7
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 16:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D659E1B675F8
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C24326657D;
	Wed,  9 Apr 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c6/2GOgr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45C265CCF
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207363; cv=none; b=dRTHPSJ9MwktLu/r5r/0u37Su/8Rd5xExnEDqYbIzqwfSZoP2RTeW95IpAqVQpku8hfIaVotMpid6Ja3MAveQFziMrKg4JDFrUq18M+Oiw/2VEknS8i+Mw27Xyptx4d1cw0qSDV2R/xdcYuWDmoh7e8ALqFUNB0WzhWT9C+68Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207363; c=relaxed/simple;
	bh=mG96fuhZeMSiI4R/GosBkkESrvmzH8d+f53dlK48H50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh4j3yyLGmec9RfLTriU3J/3J1AHpew/mUlRuQqdRmtSrVFDutjQhhlfTxCW1/y1Z3hcw5Cm/Dc2wP5QY3yb/MIygq7bLEhoQLocy4rVFultwAsFFq2SErkswYFxX/YapwRNT7YoPsE4S+FZpDHDSbXtKuvBlbnZIeQb49nAV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c6/2GOgr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso10517461a12.0
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744207360; x=1744812160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqfKoc5OtBfHsLnQESTgykRUnwgehQk6QiKSOB65pWU=;
        b=c6/2GOgrVvbSHtrK+LOIIbr0+LrQoYbcN751ah95zeEs2SdrJmgGHXWszmRH7Gkc8E
         qzW3EcCRkcAs0Bq2D+QGLK9MIMpqDJPLX079X9EkB8/CIiwJHqaNO2m+usSsi3rGCJkg
         OD6V1PDrycsWyNzHrcBRHV/WFhSxU6A1nYqVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207360; x=1744812160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqfKoc5OtBfHsLnQESTgykRUnwgehQk6QiKSOB65pWU=;
        b=g7SwlaXNFeWJj5rrGKw8YsP6SYZAgeqMFSPL36CM6drTJm7rVbazaPZmnlAHihObkK
         aMCqHXaDI5UdRLSJuV+WUKpETFrExM6g2zabKXNOjVPrCGEgunmWa6AYmQQjucEkeMwF
         NvuFEQuLrOLLd0FV1XmHaqOwUypt8ZE1dZUiCKy/Qi5WPH9nonAv+RfzHHjrDPT63eT/
         xwe/74wQSWgZx6x7+uZkbGTQbD8BBVi9fXHB2l+0S34ZfN0gcgXuHG/W8vJx2KeifJIW
         IBzTeox6u5cu/d9oLBHjQZKD8kSC/fwNI2ngT42piMGxerLlCGYfG75BFWv6My5jXE5w
         E6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeThds/ATdgg5Ec7UEzvjDdvg7a1Q4J6oJClEJXgoK2UFFEWSWkHipCsjGavLMZiVy8DSiqwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhRoFbnsI/WmPKjpAtHv5uubq/gUNR7NrxipNm4g6hBFn9Ye8
	fir0bKCWCkvRZQxtKnBJdSBHdYmI4MI+zoTC4a14Efn5C0TMwW6++Htgzoy5sQ==
X-Gm-Gg: ASbGncufTuvHWtzlYx1Jd47rP7vaev5lVDOrL0o5LueHZ9fjJreueKKW4nOyNzm7feJ
	Zeslpx9Eqk60y+NWPhhksdr4ZxB2pWEBNoT05GBBeCNw3QIjLXt7rQ29QoDfDhB2rc0XgJCRh4o
	voXubS7l3RIfsRSaXnmJh1dG6LIx7QvYjkfb1cqWlfT+fEeQCvcQkiNNI1/JU/2cbbW8kWt+w6A
	oBoThiy9GCBvZmCqIEC26gutyDxdRfiqGXVnaEqNVyY2ZSCIsmmOiebg4nJCrNl+KVFMz851R2M
	YUofNwkc6QADSYd94vA4OV7ZJKK8xUFAdovPUHEYat+JHLNnT/t6GQQOkStJIy9k79YCdCLwuBN
	jCDOEBKm5GnTvRmFvlRa1e2Swlo5RloRNyw==
X-Google-Smtp-Source: AGHT+IEWLkJa6H04bRvIjATOXf67M7GaZevp9XaqI0gC2rlSAY+sEhjXK4b4hzkWvOJzYrzvKZi5EQ==
X-Received: by 2002:a17:907:9714:b0:ac2:84db:5916 with SMTP id a640c23a62f3a-aca9b6acee1mr356442466b.31.1744207358401;
        Wed, 09 Apr 2025 07:02:38 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (185.155.90.34.bc.googleusercontent.com. [34.90.155.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be95d0sm102657966b.55.2025.04.09.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:02:38 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Madhu M <madhu.m@intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: ucsi: displayport: Fix NULL pointer access
Date: Wed,  9 Apr 2025 14:02:21 +0000
Message-ID: <20250409140221.654892-3-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250409140221.654892-1-akuchynski@chromium.org>
References: <20250409140221.654892-1-akuchynski@chromium.org>
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
2.49.0.504.g3bcea36a83-goog


