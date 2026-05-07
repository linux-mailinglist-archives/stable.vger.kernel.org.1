Return-Path: <stable+bounces-244543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HmpJgRo/GnPPgAAu9opvQ
	(envelope-from <stable+bounces-244543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:23:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 185724E6B68
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E94E3011A71
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A7F2E8B6B;
	Thu,  7 May 2026 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2Nuq4Y4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70A3D34A4
	for <stable@vger.kernel.org>; Thu,  7 May 2026 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149371; cv=none; b=cUlN+cxBNUDqKrhjc8A060R+7WOqZJ3JCpqYH6t4K8GX5OBjYq+0qZ4E5uT3lmxTATEMtVUbUiGbDVLmBnC3a0XcTV6lkT74JbnD78rYMUzBENAayi5j0faVPrk7Nvitr9qo5ikRunaciNjgldhDUpp2Kvrv+cBjtWKNlu4GCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149371; c=relaxed/simple;
	bh=YdL25mPHm7dPRGfD7FLstXb9CfNYIqoZJWUZxW4UKi4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D9dy7xq1vmcXoAmBEvgJHrS7cZ3T5gAVoXBP4yRsnC/gU7JPDt3k2rxiVyuqlyKHStIer+w/IeVoC4PUYNN6heX5BT5UP/QjToumk09GxxI6TPudf0F+vj0oFubsPfjS+ND2BtPU1ap2AzeEgG0jhHfX9PAIT7ycZ05o5c2qvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2Nuq4Y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6974C2BCB2;
	Thu,  7 May 2026 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778149371;
	bh=YdL25mPHm7dPRGfD7FLstXb9CfNYIqoZJWUZxW4UKi4=;
	h=Subject:To:Cc:From:Date:From;
	b=N2Nuq4Y4txu4FB7vZ47J0SDSs1yhCJ2el6pd3enUhddJ0YEkS28eBUtUw1ROvIxgm
	 oNb5yc3pgVpCZ7OO837Sf6P4dhdDFfYFAzoSPWmgNF7Pfv0H5Aov2FndgMijVIh8wR
	 4KhpM30c1YVcqCjKBTJBGhi/l75gm+pDczZQeqE0=
Subject: FAILED: patch "[PATCH] ACPI: scan: Use acpi_dev_put() in object add error paths" failed to apply to 5.10-stable tree
To: lgs201920130244@gmail.com,rjw@rjwysocki.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 07 May 2026 12:22:48 +0200
Message-ID: <2026050748-hypocrite-astonish-bb51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 185724E6B68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244543-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,rjwysocki.net,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,rjwysocki.net:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9c0acc169ac71535477caedea8315f7041c5f07c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050748-hypocrite-astonish-bb51@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c0acc169ac71535477caedea8315f7041c5f07c Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Apr 2026 21:53:43 +0800
Subject: [PATCH] ACPI: scan: Use acpi_dev_put() in object add error paths

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

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 6b1680ec3694..d4131c184be8 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -987,7 +987,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	return device;
 
  err:
-	acpi_release_power_resource(&device->dev);
+	acpi_dev_put(device);
 	return NULL;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e8cdbdb46fdb..530547cda8b2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1900,7 +1900,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 		result = acpi_device_add(device);
 
 	if (result) {
-		acpi_device_release(&device->dev);
+		acpi_dev_put(device);
 		return result;
 	}
 


