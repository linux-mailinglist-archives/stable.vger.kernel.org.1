Return-Path: <stable+bounces-258905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPkcCjktG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-258905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:32:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE0611ED9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59E093002F59
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B32FDC5E;
	Sat, 30 May 2026 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sv8roMP2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809941A8F;
	Sat, 30 May 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165936; cv=none; b=m5KulFZNYAavbO0WRVfUtL3tfXZZCOmv7ORh1bNpwSyQqioqw3dE1GfIOxqn3+RPWeCIpyRgoN0MKePnAnXHzpaD3JTDQOu2yRFg7bffxnRrKZHOJnq1X4f4BzLTWCIrtcX+B24ZQseJAIjXgLTFGGmE4DNOg1M9e8CgLmJ731g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165936; c=relaxed/simple;
	bh=QHEBAbdyTEzsUg3c4Wq58F98mJ1LPpEqtg3lZLNTs/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNPKXe4+yEk8p9sMT9N5/cwuJZTjeQmthPq8C+SfnY5TukQmrYlSDSLn5KRtvxreibJNoqLVBpwhezGcJp2gVQrF6BqO3T2xOkNWQsUcjZiIlyWzTdPJHs5TQW5df816FADwCZKGWer7T/IqQPlqUYwDcoztSblkq9sDRa1bvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sv8roMP2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FB1F00893;
	Sat, 30 May 2026 18:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165935;
	bh=cHnn7vMxizjOwdw9kpbsfQXX1wx76Kc/jSXEtKwJa6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sv8roMP2G2oqwXvxJgp1kikfPnDpKf0oGP4FoqpbgwuVJU0xim5OIWW85UvQHdX/v
	 WPmqdNBB01nKS9RpR/jhKl3bjaqC2MqgRrI36MRJ8ue5G4+ibFk0uXEkpIS9YZI9x3
	 uJRm8c/2cdV+OtwWMkU9IEbXRXfID2pwj1YLzLOE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.10 226/589] usb: ulpi: fix memory leak on ulpi_register() error paths
Date: Sat, 30 May 2026 18:01:47 +0200
Message-ID: <20260530160230.919846467@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258905-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 33DE0611ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit 0b9fcab1b8608d429e5f239afb197de928d4de7d upstream.

Commit 01af542392b5 ("usb: ulpi: fix double free in
ulpi_register_interface() error path") removed kfree(ulpi) from
ulpi_register_interface() to fix a double-free when device_register()
fails.

But when ulpi_of_register() or ulpi_read_id() fail before
device_register() is called, the ulpi allocation is leaked.

Add kfree(ulpi) on both error paths to properly clean up the allocation.

Fixes: 01af542392b5 ("usb: ulpi: fix double free in ulpi_register_interface() error path")
Cc: stable <stable@kernel.org>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260407-ulpi-v1-1-f3fafe53f7b2@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/common/ulpi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -246,12 +246,15 @@ static int ulpi_register(struct device *
 	ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
 
 	ret = ulpi_of_register(ulpi);
-	if (ret)
+	if (ret) {
+		kfree(ulpi);
 		return ret;
+	}
 
 	ret = ulpi_read_id(ulpi);
 	if (ret) {
 		of_node_put(ulpi->dev.of_node);
+		kfree(ulpi);
 		return ret;
 	}
 



