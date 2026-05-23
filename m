Return-Path: <stable+bounces-253888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NB8Kkg2EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E75BD355
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56AE7302BE1E
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE602DC79F;
	Sat, 23 May 2026 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1OVd+/i"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBA32860B
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512803; cv=none; b=QSJ/PRlyl0pYM2PgHJfk9mWVqyY0doEQlHf7cXhMZsaZ/nlWf1XblGaqj5vr27DrIsc9A85oBmeXXlPuVaT9+ny871eJyv8i4FCujnW3NUVZI8vS4zfSI5nUTcQdhfRTT3JpSdxNseiG3kDGPVfMHo0qXOejrz6wtyE3D6GxZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512803; c=relaxed/simple;
	bh=khrnOXSh64A8oBJ2XH2OmpvJLC2kKn0IivBd7kZb3z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZfPpUfgjy+lIUUADwDxAYu8xQLs9Z+K4ZcrBVMRdxh6Cpt2V/jNDYKIu1BO0JcQqkQEYAgoUMMnC4Ce2ci+wVd6vtJn0Vy40VZg5+h/rqe3uIiBm1iaR3d38YxmsqaINOF178qZunG5SyEpMYk4dJwniCu9x/e4vm9c/xpP47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1OVd+/i; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f68f3b075fso2129950eec.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512801; x=1780117601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktEAdZm8Qq2zkDwBfCfBkczTqnA0709P/kUhmmDv8dA=;
        b=C1OVd+/i4AGkdvJKWuimx+2U8Tw+TgiY0pm85U5Y/KiCq1tMYTUKQHIcfb/gjWscL9
         XdYba0o0sq/438RWVjmHTMEaO9F+KmM0yVSUniYxF6YzOf7r7X1H5TRQZdzq7ezhZkPY
         lJRz3hoQktYdfhgBoxuwFDjSQgBpjjpGlpAJxHvyK3Huq6w1w8cd2NQm0SIJovDaTkw2
         IJ6+9z7X/t9aVVuvbsnnWsQ2cmXrmdefFQqC+5p4AHFHEoGnsG4G5jbYs3nlQ742Xv97
         wMA6yMW7yTYDHTCKgitXqSB/vdbQDTXw1NrLqgPvHR3Qk3KrQkNUk0T6CaIsmpxoEz6T
         TfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512801; x=1780117601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktEAdZm8Qq2zkDwBfCfBkczTqnA0709P/kUhmmDv8dA=;
        b=HJWvgjRWtsd69gIK85bqsXyMUxHzyMW74XcGadSVBGvVo6aRk6klRCpFaEVI4ev5Y6
         V2OETxyJzVpx0UsN8S9vc/JLzuG0uxZ5pzjUBT7x1LYuhMmxtbDKb5cNtcjxYU02+S7D
         mx0UpvJW5325TS5cvxMu7CKw2O2xCtt6XG3rE70YkDNyUpPsr3CxRPzehvuOaKCaWbVx
         sjMOPN2b0WCk34+NWopWv9T8X/R/FHZqgJ5cPic1YRn8eWJrKO/jX+IAwUjHU0Q+Molq
         jqCwIsMyQe0SIAwb1/aDajhXvf/04g3sD8V3lswwBZM7yAWT7cpuqfbOZjI/YIeK1ujN
         32ag==
X-Forwarded-Encrypted: i=1; AFNElJ8+EDm6xX29iepu/jpZ8kS+Whwy0RA+CRl9g/vD64MKYCCcODyQvuxZVW/7c0hIubxQsIFzZAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoe5wa2+DoLDQR2j25j/+IO+d7m1a1cc2I7XW8fJAl0wmDGsrF
	t7NKpH0RJt3GbS15ktga+z6G/7A6dhchI4dEPKkxaK6ZeKoZcP0AU1wY
X-Gm-Gg: Acq92OHf6XuUW3zo+OcVsD2s08AGtOHBFkQv8Wn7rBOQUXynM7xBZW8mkLSrvqp5dU3
	uAqt0uYDwD8/h+OSjO+RVjnOBHA+Uzrv5eJgw/JglET8lOBvQ+3yzvCosa6zt9c/DlpXMBiKI27
	OpFux5MCq4rt2cwUWqnYjVhCIWXe1n9gU+guXIWa7sSaN7h2VEyJ983y/D0eWvMB0aGIYyM3Z7F
	PiR1apdrpQ+9wDhoU/kJ9n+ioZeEFjvdDrNj9J+RYd4MP1tBJygiG424yhaOVNB8wgks8voYoQW
	vzBfjGiYPqdipzooo54CcPpBBJhWFyh6w87T52+aMzL7WeD/nO2Qx0r5SuSimTgqCrfOOGr1E8J
	NFa1B45KpKHGU5C+mjlW/GnOqJAuXae+m6SDmJ/cPotGA4za6xF8lGBBZNOOVYDtUeWMM2U2CKS
	grxKcX5J/vgiI8kdd79WR3TYZDa9MjusOsDsB0PoJq/JNfKxdv6D1TeJXC4DVi8ttcQhkzUNA/N
	WGVbuxvU4AQ+fCXAcCJWlagxNnf/QBeB5g=
X-Received: by 2002:a05:7300:bd03:b0:304:188d:d0b0 with SMTP id 5a478bee46e88-30449141795mr3396835eec.20.1779512800552;
        Fri, 22 May 2026 22:06:40 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:38 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 02/11] Input: ims-pcu - fix use-after-free and double-free in disconnect
Date: Fri, 22 May 2026 22:06:20 -0700
Message-ID: <20260523050634.501509-2-dmitry.torokhov@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253888-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F7E75BD355
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ims_pcu_disconnect() only intended to perform cleanup when the primary
(control) interface is unbound. However, it currently relies on the
interface class to distinguish between control and data interfaces.
A malicious device could present a data interface with the same class
as the control interface, leading to premature cleanup and potential
use-after-free or double-free.

Switch to verifying that the interface being disconnected is indeed
the control interface.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 57d917387544..d0934d577b5e 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -2071,7 +2071,6 @@ static int ims_pcu_probe(struct usb_interface *intf,
 static void ims_pcu_disconnect(struct usb_interface *intf)
 {
 	struct ims_pcu *pcu = usb_get_intfdata(intf);
-	struct usb_host_interface *alt = intf->cur_altsetting;
 
 	usb_set_intfdata(intf, NULL);
 
@@ -2079,7 +2078,7 @@ static void ims_pcu_disconnect(struct usb_interface *intf)
 	 * See if we are dealing with control or data interface. The cleanup
 	 * happens when we unbind primary (control) interface.
 	 */
-	if (alt->desc.bInterfaceClass != USB_CLASS_COMM)
+	if (intf != pcu->ctrl_intf)
 		return;
 
 	ims_pcu_stop_io(pcu);
-- 
2.54.0.746.g67dd491aae-goog


