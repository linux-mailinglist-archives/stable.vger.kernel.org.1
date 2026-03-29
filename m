Return-Path: <stable+bounces-230896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQ7ItAlyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:14:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DD352217
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3631E301373D
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB94371871;
	Sun, 29 Mar 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDXE65/e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF636F431
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790085; cv=none; b=Bx1X93czncsUb1TuhQnkoGsAghL0VFiWu92gCsXk5HoWQZ3xyrcXJdxJhjT1XU9odtf7MECKudKAXqmp9fD7jW9Xo79LOnET+J62K5ZuCUJetFGtfPp7iTh1c0NWViwXI/hVxImU6wGs8HRhnKPi/zO4c/pq6UXxkk5TeLGJWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790085; c=relaxed/simple;
	bh=u2uoElPnWWT5i3zmX/pdVLmP+OOhekxIvpTJ6QGd2YQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M9Cgm0zSf+QvlSo5ioz4/jpayCM6JxbW/VXqNOG85POCvYllDoXdvrqLBdTNM7uwixnTbDOR/uk+/Z+EELT9V3/R2iju8ZljJxnEm8ZTRTipfyiTvKPaXHaBPJ0DNGUVt2OpQn1oXWPGxSaYoi1kSRvyl02rzwD9bYZwCi7FlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDXE65/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B08BC116C6;
	Sun, 29 Mar 2026 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790084;
	bh=u2uoElPnWWT5i3zmX/pdVLmP+OOhekxIvpTJ6QGd2YQ=;
	h=Subject:To:Cc:From:Date:From;
	b=gDXE65/eHkvvxniLryzgRpzMOluLNn5y9Z3uXEW42J24UyCU41QJy3d+XrVKlR/i1
	 2wRb9XFqQ+t3VhhB7IvFrEWe7BpDNkAm+IbaZm8mmPfYTwT82EviqoJkndPzx3RedL
	 pXL7BWrXRGa9KgAdKn6N3avDJWMkrMbRb09DuEkA=
Subject: FAILED: patch "[PATCH] hwmon: (pmbus/isl68137) Add mutex protection for AVS enable" failed to apply to 5.10-stable tree
To: psanman@juniper.net,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:46:21 +0200
Message-ID: <2026032921-joyride-glider-603d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-230896-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,juniper.net:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EF9DD352217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3075a3951f7708da5a8ab47b0b7d068a32f69e58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032921-joyride-glider-603d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3075a3951f7708da5a8ab47b0b7d068a32f69e58 Mon Sep 17 00:00:00 2001
From: Sanman Pradhan <psanman@juniper.net>
Date: Thu, 19 Mar 2026 17:31:29 +0000
Subject: [PATCH] hwmon: (pmbus/isl68137) Add mutex protection for AVS enable
 sysfs attributes

The custom avs0_enable and avs1_enable sysfs attributes access PMBus
registers through the exported API helpers (pmbus_read_byte_data,
pmbus_read_word_data, pmbus_write_word_data, pmbus_update_byte_data)
without holding the PMBus update_lock mutex. These exported helpers do
not acquire the mutex internally, unlike the core's internal callers
which hold the lock before invoking them.

The store callback is especially vulnerable: it performs a multi-step
read-modify-write sequence (read VOUT_COMMAND, write VOUT_COMMAND, then
update OPERATION) where concurrent access from another thread could
interleave and corrupt the register state.

Add pmbus_lock_interruptible()/pmbus_unlock() around both the show and
store callbacks to serialize PMBus register access with the rest of the
driver.

Fixes: 038a9c3d1e424 ("hwmon: (pmbus/isl68137) Add driver for Intersil ISL68137 PWM Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260319173055.125271-3-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index e7dac26b5be6..3e3a887aad05 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -96,7 +96,15 @@ static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
 					     int page,
 					     char *buf)
 {
-	int val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
+	int val;
+
+	val = pmbus_lock_interruptible(client);
+	if (val)
+		return val;
+
+	val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
+
+	pmbus_unlock(client);
 
 	if (val < 0)
 		return val;
@@ -118,6 +126,10 @@ static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,
 
 	op_val = result ? ISL68137_VOUT_AVS : 0;
 
+	rc = pmbus_lock_interruptible(client);
+	if (rc)
+		return rc;
+
 	/*
 	 * Writes to VOUT setpoint over AVSBus will persist after the VRM is
 	 * switched to PMBus control. Switching back to AVSBus control
@@ -129,17 +141,20 @@ static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,
 		rc = pmbus_read_word_data(client, page, 0xff,
 					  PMBUS_VOUT_COMMAND);
 		if (rc < 0)
-			return rc;
+			goto unlock;
 
 		rc = pmbus_write_word_data(client, page, PMBUS_VOUT_COMMAND,
 					   rc);
 		if (rc < 0)
-			return rc;
+			goto unlock;
 	}
 
 	rc = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
 				    ISL68137_VOUT_AVS, op_val);
 
+unlock:
+	pmbus_unlock(client);
+
 	return (rc < 0) ? rc : count;
 }
 


