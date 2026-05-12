Return-Path: <stable+bounces-245836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFNbDttPA2pQ4QEAu9opvQ
	(envelope-from <stable+bounces-245836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:05:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D59F524548
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E71C63027C56
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E73BED43;
	Tue, 12 May 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewspg6dd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194853C8C5A
	for <stable@vger.kernel.org>; Tue, 12 May 2026 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601940; cv=none; b=ax22MqhKpIWyOKkJI2PHz/ktAhhgqKbkM40ZrajCYWVnnB/EHof/hTmBMoawncMacdth/+ZkPtVWUho9P/6O+1a9iXCelnzBUC+Ud+4d3gxAJ3w4KMaGOgHZLvqlVHPqAhDukwcjdR9/FkfqNV+GsIY14ZoxU/pkzcEe5mx2gKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601940; c=relaxed/simple;
	bh=oFLU835hnkQ0S4QHH8e6Y68/BW2CchKOk0YRBCmJeaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiFZ5mjNGzWr1WVtjbfc7uUvMBfyU137SeLP5ERpK2DvKzKkmlsV2gC97oaCaQ1eLFOOngDyJQI7au4EL14AX6w9aGmG0OoHNGyU60T1Fo7MAs1jHoQDmVz1BRB5NdSn1tTQ2scKSrkfVz91A6+1+lINtSIZ9VoWuJy3ILSutcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewspg6dd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51306c9f2e1so56991171cf.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778601937; x=1779206737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJVGtLX4Hm7QXav4cdi4atZzWJUm1596Y32TKWTpJs0=;
        b=Ewspg6ddG2mSZ878szVA3HbFaz6E0iH10Ob322vOq5fYfbHk+iC7zEwxS3JTL0nQoV
         IoxBo6W4LL0Jw5p6hMB+o+TNYGs6BlZpsNwG7MKWSEJWUXw8YIwQ38cNyQKFoo2AHcYy
         bD9XL6JRUK4+Dk0z8ef1rg2LKboV7LcLHFrKgee5da6oSy3mQBmE6PjCoCd1jbcQhdVt
         5R1eEEmVANEXJHfqZlvSD6Oh1loyNhwgWf12kP3mZKyKbFOXHGzzTgsflrbJAqa/XLHp
         20RO3qKe3NnXJaMb6xlbyh3LjggVyaUHLCOe73nz8gi8IIjXEtp11OrGDE6UNh6ZcoIW
         DprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601937; x=1779206737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJVGtLX4Hm7QXav4cdi4atZzWJUm1596Y32TKWTpJs0=;
        b=rHOUiyyAC99m0DI29R7KWeFOm2mxkNBmhLAcV6lxs6TUiFS5DKB4xKnxPwtiAc+o/s
         n/xKAxDqN51avV0njXfceMOjJYuh42BzphYDZUpcdtWzKT7aOkopEZa1E7Jmmz8xW/Cw
         VmC9aezL72xj4WM97avIRop2nmjABsvQD5124B7BLun2h04a6bYTShWMfmpYQMt8RySa
         vm7KlVd8X/NNeAG4PE0M3HQBupREgm0AyfQ3WJYqfc4aMtoLElGPD5FvrNGPRuqlz78k
         AL3GES/pawnOo4l4VJ/eB2t1KeD+ojwx5yZ+1d/X9PgJqosdChbGI1iB3dVPO+7MkyvK
         Nr1w==
X-Forwarded-Encrypted: i=1; AFNElJ9VUXrVRVc4lp4a1qTKdOToEi4HnRlDT/PG4EbPGnNjlb7dPG3pWm78SXBUEt9ot5hflD8uN50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDf/8v03c3OJHzOdNQOn8On1TzU/0sNlnkXd8xDJo9qEXDXmV
	UWy0YYdjV7MQ3HDK8++dus6J341jQ1q8zflpOrsyJvUiubXacYxkVzXt
X-Gm-Gg: Acq92OHlfBBR8C7fGSfXwwEpqKamdjHYIceu1GTvA5dyp7hhtwAtL85b4vnl3nHiow3
	iLLpTL0mHwwUN3TFZ/15cxnhas0Vrz8Ntd97BuPHkEN5XxLumPxZjDhw/r6inuv0S5oHGyyX4LS
	sOginql30aFHUFMg6cDBkESzIKSy59OpS/j2/1irlTPf0SCsAuIKQjnRHuKik+aHqF7kkQP4Joi
	x06EoD+otMqhSAZDZxXOrZh8n8Tiorm4Vk4gizletvVRND/CiThaFiuetLliPDYit5kMD+EHnNl
	WzYSg38rSnQalnIraVhDuyACI15NoQ5IRHD8zJZJ8KOEukF4DTCCgzsBYiP0i0KMUhY37amwDjR
	WZF0I7SQiQCoyf01g/wWwMQJRSR3t3Fa4hBZwwo93PDuWDbDJaK4BlqfW79A4T/0lriGa9c+NoE
	iX/NtyJhxN2MJH9YxXf3wkprqz4x7fN6Nnl3upthBPGXASBHzFKEMSwGIV4083O6/YKChfE3bHL
	MNHN6flCnKA2/A=
X-Received: by 2002:a05:622a:4d86:b0:50f:ba44:ce5f with SMTP id d75a77b69052e-514a0a69e31mr210098491cf.22.1778601936659;
        Tue, 12 May 2026 09:05:36 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148fa78723sm118135811cf.3.2026.05.12.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:05:36 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: gadget: composite: fix integer underflow in WebUSB GET_URL handling
Date: Tue, 12 May 2026 16:05:30 +0000
Message-ID: <20260512160530.352318-1-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051227-concerned-geiger-b8a6@gregkh>
References: <2026051227-concerned-geiger-b8a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D59F524548
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245836-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mendozayt13@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The WebUSB GET_URL handler in composite_setup() narrows
landing_page_length to fit the host-supplied wLength using

	landing_page_length = w_length
		- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;

If wLength is smaller than WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH the
unsigned subtraction wraps, and the subsequent

	memcpy(url_descriptor->URL,
	       cdev->landing_page + landing_page_offset,
	       landing_page_length - landing_page_offset);

ends up copying close to UINT_MAX bytes from cdev->landing_page into
cdev->req->buf.  KASAN reports a slab-out-of-bounds in composite_setup
on the kmalloc-2k gadget_info allocation, and FORTIFY_SOURCE traps the
memcpy as a 4294967293-byte field-spanning write into
url_descriptor->URL (size 252).

A USB host can reach this from a single SETUP packet against any
gadget that has webusb/use=1 and a landingPage configured.

Handle the small-wLength case before the math: when the host requested
fewer bytes than the URL descriptor header, only the header is
meaningful and no URL bytes need to be copied.  Setting
landing_page_length to landing_page_offset makes the existing memcpy a
no-op and leaves the descriptor returned to the host unchanged for all
larger wLength values.

Fixes: 93c473948c58 ("usb: gadget: add WebUSB landing page support")
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
---

Changes in v3:
- Add missing version-change notes below the --- separator.

Changes in v2:
- Drop the self Reported-by tag.
- Add Fixes tag.
- Cc stable.

 drivers/usb/gadget/composite.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index a902184bd..dc3664374 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2172,7 +2172,10 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				sizeof(url_descriptor->URL)
 				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset);
 
-			if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
+			if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH)
+				landing_page_length = landing_page_offset;
+			else if (w_length <
+				 WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
 				landing_page_length = w_length
 				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
 
-- 
2.53.0


