Return-Path: <stable+bounces-258237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK0bKjElG2pm/ggAu9opvQ
	(envelope-from <stable+bounces-258237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:58:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C6610B6B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE8633016B99
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B8342CA7;
	Sat, 30 May 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z6hCgb6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976E2628D;
	Sat, 30 May 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163676; cv=none; b=tJc1dAuENWt6nSus25QFnUvxE5mM5qcH6QE7gj98eYCTEgkLe+KeGQMZuU01KYYE0JBkQj39SBWL2EG/mJ2nlgTqXNKf1H/ubr8IhK70T8T87UveDVe3ce9/PKBo1l91FjHaV38W3jDh4V5GTjczXMi88Hi2Ff4BOC/75v9p1to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163676; c=relaxed/simple;
	bh=qATxPr7tuiI9/KLjHuWxKmFD9qOPcir++BxCkTopnow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCpUCo/gg6ZUHcBBEizykMTBAZ2Rg0Dwaiaxt92uimtJ3qAayD5r7yobdYgz03o5qrih9K/6wOqkM8T18vhwaiwrI6x+585LWNEFnCXuXZd3oqr3egiTJWwj8sja5GVzuRdc9nPOSZXrDEpvyYWxmBzSj5+dDVIZrDboUi5W9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z6hCgb6i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760151F00893;
	Sat, 30 May 2026 17:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163675;
	bh=Uavf3k8IK/aRwxAyGoMsL/ym1W0iSxBIL57e+UzWrCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=z6hCgb6i4i7I9d4Ic6/2h3Mz/ygH289Y4oEMjNVBlO1srcFpCPsyAJyIwYcu/Nn2U
	 5IZ2/6A2GbdbQtmdu9ODaFz+JC+N2WxIkazC1IYWQCPbuzdDe6I1B/SIDaRXQsv2cL
	 jKE1PNJhmyQIqQ65EHJwpXkKmn8CO8z0Ee7eD398=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.15 299/776] usb: ulpi: fix memory leak on ulpi_register() error paths
Date: Sat, 30 May 2026 18:00:13 +0200
Message-ID: <20260530160248.292298821@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258237-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 520C6610B6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -244,12 +244,15 @@ static int ulpi_register(struct device *
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
 



