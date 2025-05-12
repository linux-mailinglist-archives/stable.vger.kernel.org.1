Return-Path: <stable+bounces-143258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C887AB3623
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E655D7AA0F3
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4774C1DD0EF;
	Mon, 12 May 2025 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jGp/Q7E5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CaSbZnt4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614531A316E;
	Mon, 12 May 2025 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050330; cv=none; b=AmyGnTk8Rgfcl++9CgEvZsEYvV7x/qfkK4r62mllv4U+jhn8l3JyzT7CYxSEkbHPk7eG+ydpoRUcC8xwqQPgjzsmuUaY6w66Cg3JuG2REDJF1Tk6GpLS2s4rOgeSG+TBVkbtWjos6QvWIkD2PYUPmPEL4WpUQtE4k9fR1XYXAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050330; c=relaxed/simple;
	bh=YWiM6vGisc533idk3Y8w3zdMwTHvy71CxY/g1Qi4rL0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mv5cMMjdoC45PEBkli8AGxIjzsijTWIJvk6hmdCNv7pUIvwKPQRgtyrGlLRHYJKHWFb8CgcKQrgffIEEtxdWmUK7xBb0lBU8VmjaK7HGH+AyYRbwwPmVL7dsiOOD6yaDAOvzUSVg5uogqLVf2SySRXnpCRaJFTp1NjiSm913TBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jGp/Q7E5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CaSbZnt4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 May 2025 11:45:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747050326;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLGjoFWngeYLmQuHMyClgegn0RjYCnIzKALh0Gu0V40=;
	b=jGp/Q7E5qhAGIHxhdoQehddz/msxS830Lc9Ifp9UoCL8WFH3wuvFs4x5if/BBtIXExnIQe
	BCYuOGdzyi+911ICsY0OK8PBa0AzbRCsZvs9s2qWKnabmq4h3mdeuZ+fuKhsyyVECPp8Jx
	iU0wCK3vL3dxMXBwt3JnqZaeoWoDflr6fnT4WPks/3fFRj1/BBII064nAeFWnNvZOzq6UJ
	QqgZaEMkEF6OqVg/gyh0Vi5xybsvQgW6vnn/uuYibbQ/G4ZD3cfKdhZhpW7k+crWwHBx0I
	RUbdhAezCs1l3gK1+nYINHA1m1li6DRebQyGlgUKHlJ7kP8n+/d0QKFH1UiOgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747050326;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLGjoFWngeYLmQuHMyClgegn0RjYCnIzKALh0Gu0V40=;
	b=CaSbZnt4nmOY/Iol5YVXmB+EnhMACgCDAUayLlRrtsoYdIwEi85bkaPXcYRAHD8Ri6SEcJ
	sA66LYWbBllruaCQ==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Update Alexey Makhalov's email address
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Juergen Gross <jgross@suse.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
References: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174705032496.406.14853786060370943087.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     386cd3dcfd63491619b4034b818737fc0219e128
Gitweb:        https://git.kernel.org/tip/386cd3dcfd63491619b4034b818737fc0219e128
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Tue, 18 Mar 2025 00:40:31 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 May 2025 13:41:06 +02:00

MAINTAINERS: Update Alexey Makhalov's email address

Fix a typo in an email address.

Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Reported-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250318004031.2703923-1-alexey.makhalov@broadcom.com
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69511c3..0d3a252 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18373,7 +18373,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -25859,7 +25859,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -25887,7 +25887,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported

