Return-Path: <stable+bounces-28400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC77187F88E
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 08:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85743282DA6
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFB2537E5;
	Tue, 19 Mar 2024 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ninuFKo+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D43BBCA
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834232; cv=none; b=gql01t6l0pc4wYveR2xEAnkkM9KQRqerkyYizZqebtF8e+hdoW3m6ZHtcJWKvJR3ek0daFOvcUpHEcRlWtZ69BF3o5k2gOBmx5Bmqhjg1YSRf+nu/xJUNg7rGMeu4ggUuZn3PBhXwM7t3samhVoOC1oYCfA3wFYQBpNaIlWMc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834232; c=relaxed/simple;
	bh=ApTDmdxNjCY2t5sAyX6qT0+1HzvroOVF89Qtq6GJnvU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fVsHRCHvOSg0fW/dJ0sv3dLtYXmTPCSDADW0VjSUxqabMOqu/Rh5emzhHAqjFGKJvaPVizxbbGG8rDHPaVOXvOGrv6B5eR2iy04V1CthMx9Y7lGf7KCSM/Ho4i+5wFELbf38Uon434bJvJ622q8Qmp4SHXjiupHefRLOt9Smf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ninuFKo+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so9491028276.1
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 00:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710834230; x=1711439030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lyVllugR5IqRbqncN1tVXbwrn/I/Myl7P+DNgUkJQao=;
        b=ninuFKo+GaLFTYzWHlcnCueCOXggw0F+Pc6plm/gYjFvdL+ZWGDQy/TvLD5siDrIa6
         aoi5zTvVvFug7BVAvLgfDb/f9W0nDFblIXS7IfxKam2dJDHTRGiQvVUE6WmhpP+vsQDl
         EUWuj4r7oCTg/7GZYdcJpm+Ggw2F9JHYI3/wilLnj7QsxpFk2TVpIIQyh/YgFHOdav1K
         NGLq0wasWznSAUucOTR087IUZURXgAoA2+ipJXigdKWNzkAFqgAMdn9FABbOruqUFSwI
         Ewyjh+xG3RGs8XXjt6Z/VigYEUnezF1IuW/fgfI4Myx39gSc65pFbGTgmIVRjT8IYyNa
         UgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710834230; x=1711439030;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyVllugR5IqRbqncN1tVXbwrn/I/Myl7P+DNgUkJQao=;
        b=mjRWmXczhPIHgJyNdOeqhLVFhSANvGIcE9eE5mbPolk27ErlIxHuC8Bn2Jzb6NRmL/
         sMAtDfnggHh4/ZDUA2+RODRF87ooTz0zV4jUoWfk4qh77d28DyGhtW2UnKa/59SNXeba
         7Kx7mkY667lDeshDTSzFT4DJGbgeT+coI1sk801Jj6ZGTjIra28GQxhOG0GyipDhUAGp
         Ky6FlQ/jIMnzfEmiUekMvKedY1EK3lsXPC2f5umt0xD7OorssYvq9mFOPjawH4roIeb8
         OuvSKKxch5OXaTkBwrlF0pDnJ04iuwPTlHCuI6sHXDtieLsn0VR7lzIFX0TAnV0El8+X
         pmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSi+Hi2GOnfP0jQVsmeSe4bE1JgASq9ijVpvsvcKmLFng7CPaKBvA42CPPgycy7+0vR9d88hFiQap1HWyN4oSboZ79oiD+
X-Gm-Message-State: AOJu0YzDnEupOIMoh7fM1Pkvswxb9cLc0cb7woxT+6ILK77H3LO/l2On
	uA/96O7WDN6q3BXarLT7m/Rpl6fXgXaAJGatkTVs5so/jY7R1uYc0FkVLwLyOsqSONpEg2ZySGJ
	w5bfHSw==
X-Google-Smtp-Source: AGHT+IECrYSanaCM/eJMHcpwnnLjH7+A/JTbe9uQMg4keXB7FUSMz7wYWYlHT+xWhDeI5pUxpdtJR9xZ93Tq
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:2f6c:fc01:709:12f4])
 (user=kyletso job=sendgmr) by 2002:a05:6902:2084:b0:dc6:e8a7:fdba with SMTP
 id di4-20020a056902208400b00dc6e8a7fdbamr398999ybb.4.1710834230386; Tue, 19
 Mar 2024 00:43:50 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:43:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319074337.3307292-1-kyletso@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Correct the PDO counting in pd_set
From: Kyle Tso <kyletso@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Kyle Tso <kyletso@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The index in the loop has already been added one and is equal to the
number of PDOs to be updated when leaving the loop.

Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3d505614bff1..566dad0cb9d3 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6852,14 +6852,14 @@ static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
 	if (data->sink_desc.pdo[0]) {
 		for (i = 0; i < PDO_MAX_OBJECTS && data->sink_desc.pdo[i]; i++)
 			port->snk_pdo[i] = data->sink_desc.pdo[i];
-		port->nr_snk_pdo = i + 1;
+		port->nr_snk_pdo = i;
 		port->operating_snk_mw = data->operating_snk_mw;
 	}
 
 	if (data->source_desc.pdo[0]) {
 		for (i = 0; i < PDO_MAX_OBJECTS && data->source_desc.pdo[i]; i++)
 			port->snk_pdo[i] = data->source_desc.pdo[i];
-		port->nr_src_pdo = i + 1;
+		port->nr_src_pdo = i;
 	}
 
 	switch (port->state) {
-- 
2.44.0.291.gc1ea87d7ee-goog


