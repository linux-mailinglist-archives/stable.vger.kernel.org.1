Return-Path: <stable+bounces-25456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF886BE8F
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 02:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518211F22BD9
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4602634545;
	Thu, 29 Feb 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3Odmy4w"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB736B00
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171563; cv=none; b=vGqe4IEdrOsPKQ3H1QKqpS019MzV83sFTaW/q3BrRydLswp/3AbNDr3uHJjEpLG+bGOIgTLIeXSgsIEvlUjeraUBHtzGlb+L3IA7vysRPCVVVwSJq4ZEisSg+Hn1fBht0B2wIwDHBUzo4O4rrXgpMrHLtjsRaSPeIonEkXUUMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171563; c=relaxed/simple;
	bh=7tJEoT7UeieYnDrUIelxhTjT/DTW8yYe3f7+9yRHQ0g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rYrJZz3cbjTJxnOKPzxS9QVTDY44BQVU6pbahcE4SoFVCu2ELPxEwdgzol8Bu7MhbL9W1RPGK2FtmJBce3L5pTsRpqpUil2hKvBfOHrJ8jC3/Dc4JOugfRuVGflO0xpFeCSR9ZQyVB0iN/mapaKmT5XBV2BKouuUh6ZQv4DeFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3Odmy4w; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so814460276.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 17:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709171560; x=1709776360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E3VOyu5h5VNnqIC5C1wAkPY2R8kjBMsntg/JOJOAxJU=;
        b=r3Odmy4w9nUoBFuT8uHtW8oR/jEYDSJB3qjSnrlPntvaLFhLvkowp9zdVwSSniuExn
         i40Udw7lMUFLwMpqpFaXHT5n8EV77mXhFu4L1PbqFTVII7E1FA2BS52lc/9jmVD7l9TS
         ss7wlGWGzqhucQOnIjvJkvvI5eWYw7NqARi1ZKP+JCJ2k/pqBUj31CtLCwaF0Bo6Y+gJ
         a80aOSCAdTqZFQBWknxpE3wG4WIKgHugdfOrfNFbVUQk6wiX6sbxKBGaE0JuCgM4H7ou
         NBnentahKIQHoirFBJcRIIAFLwGPYpq/c4Prue4jfuT0u6WDeU8HJw5nuyQCF81qmEC9
         yEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171560; x=1709776360;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3VOyu5h5VNnqIC5C1wAkPY2R8kjBMsntg/JOJOAxJU=;
        b=Wnaw5m4NizfoLcUEZcBA74E/dZ5hLJbtkIa+9PqjC7XJHc/qRCytCmQ6rjGBJftEW/
         dL6TqgtP0p7kY3Mv5oXRhtdRmXi6dIM5gYKOMtKRq8k5hLO1t/9GmOjCjdfetmihSx/8
         eMHooSV17Dnlfp5wU1Pdiv4SSOBUP8HQVjvvwQefe+/FpvCoMB8mfqVZm8xNFkah0+Co
         ReK1Vl+AfFYRW/Rl/D46QKlGevUIHyD6FB3ikq/YEM6MaCm+6jSY5r10H8WZdvIP+qth
         qN2uZ0icJJh2YaUtJOvfQvaPsz5DCnmBuKqpLp9XRgSSSzBDOxB8vNa9XhF4jYpO9gC9
         OBZw==
X-Forwarded-Encrypted: i=1; AJvYcCWygo+E/bRbIMIraSWFGbqgrsIWYdEcjxd3FM15XOEm6aC2N/NoEkP96ix+ce9DLCd8hRFOc7o8t+aAaFdOgX3ULpBtzFP4
X-Gm-Message-State: AOJu0YwzklI5RiexLrgxa1ULB3e55dx2BpF7c3CvuCgrkRlHjsCRB/tb
	uqrg83NeO/lZBSHfmx/H6lfroCRgMqrXQefaUjiG9ssOr2j7wGwH3LQJbpcDNzARo6GHIQ5q4Z6
	INQ==
X-Google-Smtp-Source: AGHT+IEEVeZo1PJjoBdtLbZi7QC6z28ER8EtOUgYeV01NYjBTS89wq1lQoJnDGaUjcpDYkcPSDEvQYEBbm4=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a25:dc0c:0:b0:dcd:25be:aefb with SMTP id
 y12-20020a25dc0c000000b00dcd25beaefbmr233082ybe.13.1709171560541; Wed, 28 Feb
 2024 17:52:40 -0800 (PST)
Date: Thu, 29 Feb 2024 01:52:21 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229015221.3668955-1-jthies@google.com>
Subject: [PATCH v3 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
plug type and updating the modal support macro for consistent naming.

Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
Cc: stable@vger.kernel.org
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in v3:
- Fixed CC stable.

Changes in v2:
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

 drivers/usb/typec/ucsi/ucsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 7e35ffbe0a6f2..469a2baf472e4 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -259,12 +259,12 @@ struct ucsi_cable_property {
 #define UCSI_CABLE_PROP_FLAG_VBUS_IN_CABLE	BIT(0)
 #define UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE	BIT(1)
 #define UCSI_CABLE_PROP_FLAG_DIRECTIONALITY	BIT(2)
-#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	((_f_) & GENMASK(3, 0))
+#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	(((_f_) & GENMASK(4, 3)) >> 3)
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_A	0
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_B	1
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
 #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
-#define UCSI_CABLE_PROP_MODE_SUPPORT		BIT(5)
+#define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
 	u8 latency;
 } __packed;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


