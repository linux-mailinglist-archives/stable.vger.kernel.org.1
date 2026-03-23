Return-Path: <stable+bounces-229492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIrjCX5lwWkzSwQAu9opvQ
	(envelope-from <stable+bounces-229492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:08:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D32F79A2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC4030ED454
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CF23BED69;
	Mon, 23 Mar 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dhmg8H7y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C903BA220;
	Mon, 23 Mar 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279407; cv=none; b=mEnlUSsKHcV0ZZXQNY7wRL5NjFZ9WPcQBxCnq7a3lYS4DXlcuvTHB/EgZwxr4o9vT5mo+K40QkQYu3w+CKxYqdmqVRSmyVAM/FYGCyFJt1/x5jmPJiERDdzYD785Ls+ymGlwjpWYw4nsr+6UII1agOIMbDC1V+aGhTBKFJ7N96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279407; c=relaxed/simple;
	bh=2jV94pvHXSOuYCuL0dG1jhNApS3Izqa6yDKjYZUKFtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fk+/0VF2qv7Y4pRLWmZuTuLtC5qBuPaEupdkAj2K9csG1lRifP7lMBNhJfHvTVtWCJqxRHpl3kEoyYbRCcIPpEEMja6RpXBd7mYAmdtwH5uYF9I/Ny6EQUEVLCV1fMs5bkugxLjMzzPjbKp270FmCgUjDNCYRnvnhU9XLUWXrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dhmg8H7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795CEC4CEF7;
	Mon, 23 Mar 2026 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279406;
	bh=2jV94pvHXSOuYCuL0dG1jhNApS3Izqa6yDKjYZUKFtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhmg8H7yBG6d9F7kL8dX4fxy/+3Q4I3aGyuYxglQSS+gXPSF/sSVfxN+GA7zxMZGh
	 7Qhn8YPgYRlk35nQIh72DYbmEsboKSgO7/ULBWCdGw4Vb61DkDmdnLcHYlumx7waaI
	 8OeYJcor0AzMXSvFbPtKQMwjxbHqz8BgFTONhOH8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>,
	Johan Hovold <johan@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 559/567] i2c: cp2615: fix serial string NULL-deref at probe
Date: Mon, 23 Mar 2026 14:47:59 +0100
Message-ID: <20260323134547.864243347@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229492-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,bme.hu:email]
X-Rspamd-Queue-Id: A91D32F79A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-cp2615.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -298,6 +298,9 @@ cp2615_i2c_probe(struct usb_interface *u
 	if (!adap)
 		return -ENOMEM;
 
+	if (!usbdev->serial)
+		return -EINVAL;
+
 	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = &usbif->dev;



