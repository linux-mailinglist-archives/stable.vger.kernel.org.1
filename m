Return-Path: <stable+bounces-27342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA687863E
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 18:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E564BB212A2
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D694DA1A;
	Mon, 11 Mar 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJnXGeuX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F634AEFA
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177795; cv=none; b=HsptzpQl9WmQaL7Okwcf+BJW2Kxe5Gev/V03v/VJC+VKi1nBOBkk0xY64yFKf+HRDdUmQ4YUzM9pLvzjXf0r0z4hwqjMjbrXynXJpnRVtEJLw8pBiRBIXlSrR06jMPx45Yq/RACFQdmVgb4ej4CN4ion4XRd86oyM/1ACuMOWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177795; c=relaxed/simple;
	bh=oKUsJDC4xXjk3cXvZ0UkhE+m5A6JJ3EOsCl7WrkesAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OrlKQqrv20/8bYNHNw2R63hQXM75LrGs0z3ZsBV+XpajTR7NSboVcxLMH0B/KSx9DoqTHTpGqKdxWKFVJ4RWTrSsPZbaTa45VLTz0wPHFM0E6PPkfOMiR5cp3QvWngxIEpjzBeXVf1bfl6Z60cBIpPVTai2LXQQsJ4F3MHZifB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJnXGeuX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a01d0a862so45829187b3.0
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710177792; x=1710782592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eEFSDQP8nEwgMk7vCT7vaN5aD9pBnwi9LafjzuTKO94=;
        b=VJnXGeuXXmWKS0uRl6BNBeMoQhcNH/BnuKEhE1cT1f27uNBl6tD2HVSgFnQqPFvomY
         nZAYqloYaLJn5ezj6znJfy+mpOfQFBmdRPcsovnyWXEUg+QO3eFx2bD8s2sDbGEyAoUa
         ub2Pq+3qZEadLIT+5hAxqK6kzlBTvA2m/T0Ep39pwjdy5ytwwRb/9gwmGcRnz4dSnJb1
         HRWeHmvtuIPEHTvsICPXMcILjnqIkbgd3kx7ZKM+7EFHX7KT8FMAElnArQ3cZ8uUNbH7
         FTdB9M47DMO7ujY1Guuk2r3ErJ9y2jr7C5iFMumX/GqPGIVg71rJ7D3wlZwJf1608AlK
         Gghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710177792; x=1710782592;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEFSDQP8nEwgMk7vCT7vaN5aD9pBnwi9LafjzuTKO94=;
        b=NH/aTw1nk1BJA+2AAFXi7QT5TNZD4KFxw0z1nTLR/VrXXJEcCECumnuHs7dD6KHllG
         D92Cps3l9n9Wl3PFaYD5cS1ey31JE0WcWCaXNFR8lI+o5KYI+3vwgXziMr+DpjwV9uhy
         tjOgN+kayjLrVteRjbSd7l7+vmhxZDAgBBso/xOHbvTxBsJPsL5Ixfe4SBIkSg/1YUmD
         0s5VV0E8V+qicFI8c9ncuzs+knTOZSkDzLFlXz1STFAJez8uO7ujKZ3Wrko6b4Jh4N6a
         xMZH133SqnGFOj8VUH6Ano7mP8GWUQ706Pr/1qJp+ro+ncgTx+OPYETo9i9rhC+RKiZC
         Iczw==
X-Forwarded-Encrypted: i=1; AJvYcCWLJ/uJkYxh+LgxNgwU2AY8dEu/tyuurhKRD6tVNCLYEc85VVVYOybEi0Ezg2brim0wzh74LZlNN3nXSohVDW+0k0L6OkGM
X-Gm-Message-State: AOJu0YyvZkQH+N3gpdFh4oi1aDrZexnRfJUt0y9pDKJl0Bvyx56jKjGn
	AZR7r0PfWmVJpBroJQXZnQGukPyp/0Wmefd+ySHZr963hiUmmpTOOcojMrrILab/rNN9JKxdS3r
	2WqOZrg==
X-Google-Smtp-Source: AGHT+IEOmE8gBkWsQ+VxVdk/lX9Bz/bX02Oz9mDyF9yTgj6j/8N1NeP6m21R1WLnEHPrOKjNcIihOqVPnS0z
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:f39:e78f:4944:b22])
 (user=kyletso job=sendgmr) by 2002:a25:c4c4:0:b0:dcc:6bf0:2eb6 with SMTP id
 u187-20020a25c4c4000000b00dcc6bf02eb6mr387095ybf.6.1710177792170; Mon, 11 Mar
 2024 10:23:12 -0700 (PDT)
Date: Tue, 12 Mar 2024 01:23:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311172306.3911309-1-kyletso@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Update PD of Type-C port upon pd_set
From: Kyle Tso <kyletso@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Kyle Tso <kyletso@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The PD of Type-C port needs to be updated in pd_set. Unlink the Type-C
port device to the old PD before linking it to a new one.

Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3d505614bff1..896f594b9328 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6907,7 +6907,9 @@ static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
 
 	port->port_source_caps = data->source_cap;
 	port->port_sink_caps = data->sink_cap;
+	typec_port_set_usb_power_delivery(p, NULL);
 	port->selected_pd = pd;
+	typec_port_set_usb_power_delivery(p, port->selected_pd);
 unlock:
 	mutex_unlock(&port->lock);
 	return ret;
-- 
2.44.0.278.ge034bb2e1d-goog


