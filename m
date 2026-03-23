Return-Path: <stable+bounces-227968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D01O2Y4wWm7RQQAu9opvQ
	(envelope-from <stable+bounces-227968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975F2F24A6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 337903069DD1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A343A9D9C;
	Mon, 23 Mar 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/LMUL8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5153A9D8F
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270384; cv=none; b=uF1O3uWvLObexkEWzAl2X47cmDMTB1C6UxIPHB9R779KBrXNwmDyTxDbAFRHY9qTSf7xZI+d0UywQtgM4Uk3FZshv7f1ThMLX9FZxwMNYcitNP3Zfoy+ujkUSXL7SJDpUOyydwircdnDmmoc+xIGpP14sk4aQUOP2CDeSBJ3/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270384; c=relaxed/simple;
	bh=5RFSHrSy0T0N8TKyFd5rGOjqnVR8zENTugr+DmETkVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6JC+/gMsu60JGIW1qJdsYUgHjC6zFrcO9bRCWvNqY5vvzzoyF8bvcxi3vxrodpr28IFKJD4KJYyJDFx6Iuvv8TK0wO6IGHs22AF3K7wE61cD6/GfR0yhnCARiEmuQ/Qb9qntRnF6VbJMKWf+X0nHldcpuh3FfRoxi+Iy8DK97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/LMUL8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9ECC2BC9E;
	Mon, 23 Mar 2026 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270384;
	bh=5RFSHrSy0T0N8TKyFd5rGOjqnVR8zENTugr+DmETkVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/LMUL8Y6boPZQwFZORZWUjaXGO9nW9NRyxhzLPJZ3HcSdQ7ntXgnBkfrEcPCmVdd
	 BMTXa38DzNv//3YjtbqoGLjWhNpTDofwPhWneCZ67TsFzjs+Y5dGZnrnvJKvQcdn3J
	 fERmMrlHd3lJ9Lqz4FlKSYCnm0PHB9fnRmUp4SHb3MOYuo1wq4Lvc1qSAIH+Ybrghz
	 3mw+1ezOtBKgL/PRMAUsQg8z2xNc46uDOMmgGqLaOr1TXB/R8o7m+sT6Yn9+73ypBV
	 Jg8gmHED1CQQDOrFV69wsU8RXw13tM6273uzQgPWNJxAuFJAe64aWVDiJaY2B90g/R
	 px1T+X/q8uLbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] i2c: cp2615: fix serial string NULL-deref at probe
Date: Mon, 23 Mar 2026 08:53:01 -0400
Message-ID: <20260323125301.1649463-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323125301.1649463-1-sashal@kernel.org>
References: <2026032347-celtic-fragility-e746@gregkh>
 <20260323125301.1649463-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227968-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bme.hu:email]
X-Rspamd-Queue-Id: 6975F2F24A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

[ Upstream commit aa79f996eb41e95aed85a1bd7f56bcd6a3842008 ]

The cp2615 driver uses the USB device serial string as the i2c adapter
name but does not make sure that the string exists.

Verify that the device has a serial number before accessing it to avoid
triggering a NULL-pointer dereference (e.g. with malicious devices).

Fixes: 4a7695429ead ("i2c: cp2615: add i2c driver for Silicon Labs' CP2615 Digital Audio Bridge")
Cc: stable@vger.kernel.org	# 5.13
Cc: Bence Csókás <bence98@sch.bme.hu>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Bence Csókás <bence98@sch.bme.hu>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260309075016.25612-1-johan@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cp2615.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 20f8f7c9a8cd4..8e17f32d38c06 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -298,6 +298,9 @@ cp2615_i2c_probe(struct usb_interface *usbif, const struct usb_device_id *id)
 	if (!adap)
 		return -ENOMEM;
 
+	if (!usbdev->serial)
+		return -EINVAL;
+
 	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = &usbif->dev;
-- 
2.51.0


