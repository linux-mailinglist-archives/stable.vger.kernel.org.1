Return-Path: <stable+bounces-246351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHHXMhtvA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:19:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A435274A7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DDC53093419
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DFD17557E;
	Tue, 12 May 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EVy1gfGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDAF3EDE41;
	Tue, 12 May 2026 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609002; cv=none; b=A+jcSFqKiQO8fFs9epNgIGWd7pCQNHqqmvz2pBXtFXMxxiOVKMsCCgVN22ejlZajpt+VwtvnnqLgKROduV1dzpeK3uqz+LF0oeMXZr8TT7LMJHLDqcuSJ/5SMk2QdAeHTVPM00B3lszHLkD44Th08xXOt4HtUPPkg+lxKXmv+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609002; c=relaxed/simple;
	bh=LhB1XdgpfGcex9nEFYLOBek0wIMQLrgifJpgSGGxxjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtoEphAGDHFFqk3JFjmubYUl4u4E/Ummslm8VaKAscV2R5Nb9/stM7YKQnLa4TiaXb3nuJ/ALSp4ryJS9ThHG+gvz5+tya3SCm4ntI4V51MEyUGa83iYky0voOic9U/sY0RgelGGAEG03wkPnNO1re6r0MXsOf/V4hLjHxyZyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EVy1gfGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2483EC2BCB0;
	Tue, 12 May 2026 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609002;
	bh=LhB1XdgpfGcex9nEFYLOBek0wIMQLrgifJpgSGGxxjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVy1gfGxCtHRAwWGKNohiMwP54Eknp6ohIYUvRARINF1VudVR6mcvYnQL1yN4QVXQ
	 Y8xyCwAgo4FybmIqUQ0cN9JbbU478VJm13DhvIRr8eHQ/1eL+WzKGFYwEiVFEwk7Sq
	 Yd5DdVf2/1Dby1Q8+A9iS8w438Ytse/Zh6uvYzic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 7.0 007/307] ACPI: scan: Use acpi_dev_put() in object add error paths
Date: Tue, 12 May 2026 19:36:42 +0200
Message-ID: <20260512173940.277082336@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 14A435274A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246351-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,rjwysocki.net];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,rjwysocki.net:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangshuo Li <lgs201920130244@gmail.com>

commit 9c0acc169ac71535477caedea8315f7041c5f07c upstream.

After acpi_init_device_object(), the lifetime of struct acpi_device is
managed by the driver core through reference counting.

Both acpi_add_power_resource() and acpi_add_single_object() call
acpi_init_device_object() and then invoke acpi_device_add(). If that
fails, their error paths call the release callback directly instead of
dropping the device reference through acpi_dev_put().

This bypasses the normal device lifetime rules and frees the object
without releasing the reference acquired by device_initialize(), which
may lead to a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix both error paths by using acpi_dev_put() and let the release
callback handle the final cleanup.

Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
Fixes: 718fb0de8ff88 ("ACPI: fix NULL bug for HID/UID string")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260413135343.2884481-1-lgs201920130244@gmail.com
Signed-off-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/power.c |    2 +-
 drivers/acpi/scan.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -991,7 +991,7 @@ struct acpi_device *acpi_add_power_resou
 	return device;
 
  err:
-	acpi_release_power_resource(&device->dev);
+	acpi_dev_put(device);
 	return NULL;
 }
 
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1900,7 +1900,7 @@ static int acpi_add_single_object(struct
 		result = acpi_device_add(device);
 
 	if (result) {
-		acpi_device_release(&device->dev);
+		acpi_dev_put(device);
 		return result;
 	}
 



