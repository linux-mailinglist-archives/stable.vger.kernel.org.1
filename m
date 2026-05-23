Return-Path: <stable+bounces-253892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CADiKSA2EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:07:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B35BD31F
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49D4B302E7FD
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE6331A4B;
	Sat, 23 May 2026 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xosj1dd4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488932A3E5
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512811; cv=none; b=CtCDWY7GqHpXMpvp6mTQXXy4ZeONkCbu/V2Mp6R6I/CDIpbfHQy+z7Q4iNA10JAiCQBOtbdXbD1zTEmIs8VPR0/Vl1MgBv4VRI7hQkIQaWPv9Blcm9NWY4mLq6RBzyFBYqNSnMtwFog/qUfQXy1OAK+rv0kaPspPYqKDgCbX95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512811; c=relaxed/simple;
	bh=wFfcrC6+quti4awUdpIOtG9tFUevx0TecZKQaKI4tv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM32IRh8uMhYZxI0aivzidkimsFq0yDi/NYJpslKY/3KS0v8GUjoP5X82iqg5Xm29ibesKhulllS9/+ymfkNKrpZcR2nGVx+1nEA9cEwLzPnhs6Rt0AxPWpY7kkA8YdfOTFWk3Ynfo+jm/uQgztAGsN3YzOATeV6FlEv8IVcHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xosj1dd4; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30246cfd41aso1421206eec.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512809; x=1780117609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghXdVwh/ggIDUMJwerhmJOVNlYeh4b/xLTuz0F1xTdk=;
        b=Xosj1dd48ZMdESGKBbjrApr302XvRY/invtdzQYSZ2iJbtySj1iUHSq8EL0Ws+rpxH
         lX/Ax4Iz0TjcM+ou3rs9nbmG6WnapCGvjr+aRZatgdCUxXi8+6ADBO3d+TzZG3EfmRuD
         SL69IDz7MgR2mFInue4sxhGdSKcQlz2zk2UyOGGKUGeim/3rElH7XT3jhEiorwkACo/0
         5mkgsWDKpLhguHzRVExdcxwrEZVzwuMxXYVQHd7Gjt8/niCjwFHzceZ9Bw49T7+kWEPb
         d+ImU9RE/AQbDUh5KtTuRQ7o22gYv9MGtmDxEOLERGMF8FoN46eRTxYI0OloW6sSoh6/
         s/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512809; x=1780117609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ghXdVwh/ggIDUMJwerhmJOVNlYeh4b/xLTuz0F1xTdk=;
        b=MvoJWWlTtJHhv9lG+LwDlJsmqutfh0/zoa4nRlh3g+wCkwVTOR3D5dUA7YCBHSjJMj
         O+IIjypR7GZXczxVnZPLEEOHICd3aREbG8GCc0C2OtAje/LT9O1eJ73zW3il1Aq3t6xm
         ysHfKYiGQKAcJsPZyoe9M2rk82+sFOVgscu9+pM+KKBBI1qtnyOTjnBzyxQ/rFGswwvp
         Dc9md4MBwhUaVRx5w6nYfcPYnPL7yQSIi0IsDK4vWf8iW+NlRypjo8jj75dqTWqZQ/Hl
         ghfP3lDnN1eaAiYRM2TlCzI7jPke1aFooCBIBvVTTSVWBsZwV+1I/YbzYy+a+jdQCLhC
         /78A==
X-Forwarded-Encrypted: i=1; AFNElJ8r5uvU+3/bZTevNulNphejtVfjG79vQw1MpTGuFlxrpRbpu4+V/gaeSZXf5xp14dKp402E2Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhsLxNU6H8H83rRMCf9yM1sLI+YbCYw8P43V7RGTjeCw+xGrR
	SaM0Q3P2luQ2eeWRErB8lkvcchAHEWhM58kMTOy0OuIk2V8TJvhLl3GIFvlN7Q==
X-Gm-Gg: Acq92OF6shZ4hZHITvX12qWrC9r97OE8hFwBznwL+/Q5dq1b9yQkMBxYxXLwsDH5/wS
	jS8EqDhY53F2kY0y9/de+wVPIHkVLAkrbUK2p08qnyp5oPvOspM6Wzpd2zCE5p2IHPj5d2eoH+l
	fHuthufVqxkV1beb2kDXmibqBjsigAX30RPVSdI7AX21ntePRXFT1lArQsSIlzpHmD7Df3uGV1m
	yyrlobgqKGcgmp5f8sZx9J70czw2jg/L8HHyy7yWudXMB7j+Fa8/OYxVSmDHCGh0tFr1effyFtV
	FyWUXj4mXNduNcHoyC1lVkeByHurJBAADwiKjxwNMQ+sl7c6rvIAoezYMid0cgWkQb08oRUXUWw
	WFVIlcA5eWZnLVZrZvA86D0JzyGj/Ym8VHUBFAFNxkVTjtTAkJ/PgWn7nep/vorbxHOyi6l7650
	M8/kLVx/pSCHg4crfKfFnoaPos6VYYmPbTE2UmPhrfltdBeBPTmJJFwTXfl+tGriDwso3nXlDCg
	1r0IoiCCH5iqw==
X-Received: by 2002:a05:7301:9c88:b0:2ed:ff78:2c12 with SMTP id 5a478bee46e88-304491f6bb2mr3781274eec.34.1779512808947;
        Fri, 22 May 2026 22:06:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:47 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 06/11] Input: ims-pcu - validate control endpoint type
Date: Fri, 22 May 2026 22:06:24 -0700
Message-ID: <20260523050634.501509-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253892-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5E3B35BD31F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver currently assumes that the first endpoint of the control
interface is an interrupt IN endpoint without verifying it. A malicious
device could provide a different endpoint type, which would then be
passed to usb_fill_int_urb(), potentially leading to kernel warnings
or undefined behavior.

Verify that the control endpoint is an interrupt IN endpoint.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 7fdff9dd1b5f..0e7a783526e6 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1703,6 +1703,12 @@ static int ims_pcu_parse_cdc_data(struct usb_interface *intf, struct ims_pcu *pc
 		return -ENODEV;
 
 	pcu->ep_ctrl = &alt->endpoint[0].desc;
+	if (!usb_endpoint_is_int_in(pcu->ep_ctrl)) {
+		dev_err(pcu->dev,
+			"Control endpoint is not INTERRUPT IN\n");
+		return -EINVAL;
+	}
+
 	pcu->max_ctrl_size = usb_endpoint_maxp(pcu->ep_ctrl);
 
 	pcu->data_intf = usb_ifnum_to_if(pcu->udev,
-- 
2.54.0.746.g67dd491aae-goog


