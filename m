Return-Path: <stable+bounces-245827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMB8HXhKA2pq3AEAu9opvQ
	(envelope-from <stable+bounces-245827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:42:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9013523E2D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 211163012C8F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C93C3797;
	Tue, 12 May 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRXrUCuL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66103C2BAC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600315; cv=none; b=aUZ8oPEZEWhtrmDX/HdHcT/IhhpHbJRfS07MuWLLjWtReJ5SD0rUBiy9pyGcA3yB5Jvd0x9kDcM5UTDKvkurozS67asue3AwwkkVfw6pk3WYkQ7la1QaSgIXl8efhBme21jFmYVz17s7x6OJhCDw4ZobPvzfEHF+Y0MpmPtocNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600315; c=relaxed/simple;
	bh=h9bsPBYcOXqMfv+VjbAyojonmmoubV1MX83pq2oMIGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5F+rqgD9XFN85sOD0vVlB5TNO2KAw0na1QcYPAziB3X9ddS5Stj+dj08kVQ7egL75j9E65JydCPTSxEn/LJh2PL2KBHQjzwHCdCucfs+jDwTnD6kUMeHItJD+EIYsiZDiYNPHAcqan24ED5+pF5dMMT7jyX4tdEjsLSoOZrZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRXrUCuL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f0579401c4so682942885a.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778600313; x=1779205113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT0wrWmrJN0SJeayxN4+PzyvP8WgeUPSpw6VtORWwAU=;
        b=TRXrUCuL5qt+imjfrwEC7P9hkuSMXXElskCeFBD0WarzIy6Vi34JxGtvlKazRupPOe
         2rrDg6Ov6u4irjIApiKdWC5MZH5bszFgFiI82hOvQtdoSZr1lYwy+zxfpT06G8M7DI4Y
         UwkebQZAjrLLgHQcmCI58m3ZPoNt6M3CqRVzsNOWtnKUtUCZXUmMrX0saw0Losw19LlJ
         xoAxDo/io9VbmTSQr8SrAN2TINoMMqiJDrW+yeS1OmZ1LwPiLoQLcgjLnKHwCP0189lI
         fd2Uf+xRHFtq5RQL/XO3le6dIfwni9IpDUFg7e2AGqdLpxnLBdUYX1QBtkc4BzqfnBna
         pQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600313; x=1779205113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZT0wrWmrJN0SJeayxN4+PzyvP8WgeUPSpw6VtORWwAU=;
        b=bFWKz6MBJXRH/omVQW8zziO0BjfkfPP8PSnK9TCUuhtr5kC1q/dGTp17cciF/akS5i
         hlpuVUoxDjAccrOYuxt0nqPZ9KHmNS4jSYCIvt5ZKHIY42gUV/rozfYATbKUWj1tPNBU
         sGRxjBwNDmhopF09LpuOtelIzwMvgf1tM0fxpwXIKL9olNpxwcac3qOhtl9dfW563X6y
         nxbsQ2Ar6NZRXDffN7M2Hjt0TXxiNKX2b780PYgr3yMkNEMcPoqKbgKr8hYJGY+jvYyJ
         SvTR5TYCOXb034DMPfV9GurcaMz/MedQxj5oRs7+LjTMOcwvdSjftDThdUy5EjSCggNG
         lQNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MEA91tQn0y/o4Meo/pUaW7//mt8KAzKS59zcYb1hFNpYcPFDbpP0r+BjfZxCIDhKAan84MvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKxRb+Dl84K8xXbykM0hPv0m7lc2mDLRx2ZWXNsIxdE/OeHdo
	liibAH8pPbyIj7yQN4BS+SIxk7gBKE+v1FJkUkyfp/kyeD6YY4zznFjl
X-Gm-Gg: Acq92OGY87pK/k0kZUNPAiZagjE+/+fvlljBTUfQMfWqaNjPd66dUfTxk/b8ZF186TI
	Pv7wEyNEHKvTjQi5PxGTHEZTA7ix0YjmvkzMGdhaX/TASG2lpqZvvVJSM05dBm2aCPw08AmR4ow
	9SakYHNYy/uWrvWsaQuO04c+WFPlsvZLy/wMZoiLSas+L/ytv+zpbKk4yH12/P2eXqpAZpxzWjU
	YtYGv1nRzSs73Rx6+4vNEPEfuqruql01V7FoaeJQA2yu+hbcGPe+VAq2IQQSY2RKZfrVMMRnK/+
	6x3LyxH0OvF/pKXrvh3mJnmB2PdDpHeHWpzNUrtyXVjhi7bcZ4jy1OB2jmUgTyzUmUUkbfvJGxq
	t562sJOlC+36az6cSFle8PWieopa3PURribExVOv7BD03BYZqxnvrmgCZOTXBdKyqbb7r+9vtwn
	D/Z6xaHD8qEj5bnPV1deAUnjH1DXnxsFSa3PMYw07VAesySJ87dTm7a6zAN+oIaAbzLj7y7lwyZ
	Bod2io1ftamO+k=
X-Received: by 2002:a05:620a:372a:b0:8f4:e8ce:8f4 with SMTP id af79cd13be357-90cfd34179emr518940485a.47.1778600312657;
        Tue, 12 May 2026 08:38:32 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b966f5f1sm1412826585a.8.2026.05.12.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:38:32 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: composite: fix integer underflow in WebUSB GET_URL handling
Date: Tue, 12 May 2026 15:38:25 +0000
Message-ID: <20260512153825.327038-1-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051237-delicacy-gallon-268c@gregkh>
References: <2026051237-delicacy-gallon-268c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9013523E2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245827-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mendozayt13@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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


