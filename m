Return-Path: <stable+bounces-255007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BN6LGdLGGqjiggAu9opvQ
	(envelope-from <stable+bounces-255007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:04:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138C5F3535
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9010F3144EB3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947AB273D9F;
	Thu, 28 May 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5VoI2MV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A75B276028
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976337; cv=none; b=UJ566R4HIxXm2TCXUyOaWqPYRd76UYkyRjeMSgCpG4ltlYu1QgOxpp7F/ZpTtw7UwzQhLiydPjxmfwQ18BV/pYyiXmDOisTfRTSpNk2x0FYJtERfmu7j2EzAR7PQny0HamxqkgH2JMknS2HZpNU/6370XYA129DeYFt/gDuugpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976337; c=relaxed/simple;
	bh=qqYP8edWzKEDTGhfkHjJSqXkuwBoarMkiutzP6/jLDA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pmO6AfEvp76cF5OeHnLwF4QVeoNFJVWeW/KLgPDtOaLmIdwet4PCdQdtkDdG7MYHxPasxYF71r/SAqOb4smAu3B9dYJzYk0/qu7I1uEEdz7mTA48Bt9YZ5ckdVZfs+gWR+o4SlIiD1TtVnLCq6pXtEjBBB92I/M3afgdkA3Z06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5VoI2MV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67DA1F000E9;
	Thu, 28 May 2026 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779976336;
	bh=LujZGIOKD9woXHz8iNHrcp9wDecq9TY8t881NRjGTDQ=;
	h=Subject:To:Cc:From:Date;
	b=J5VoI2MVMu/xxruhfj/S/ENk0wTjOnkCIG/C3FMFDlZ1vZRJm5CHB39jJwyMo/zAE
	 DYtt1N4XBgdliSQTuKVJt+c2sLO2LhUNamvvIx5/8VYSVn+S9PUnegA9ZGgU88JJpw
	 7Eyr7qgwWtYOuPsLuhX4JuD8HrBtIHnAApnq+Rsw=
Subject: FAILED: patch "[PATCH] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read" failed to apply to 7.0-stable tree
To: abdurrahman@nexthop.ai,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 15:51:22 +0200
Message-ID: <2026052822-saloon-auction-5094@gregkh>
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
	TAGGED_FROM(0.00)[bounces-255007-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,roeck-us.net:email,nexthop.ai:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9138C5F3535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 4e4af55aaca7f6d7673d5f9889ad0529db86a048
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052822-saloon-auction-5094@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e4af55aaca7f6d7673d5f9889ad0529db86a048 Mon Sep 17 00:00:00 2001
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 17:52:32 -0700
Subject: [PATCH] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read
 with pmbus_lock

adm1266_state_read() backs the sequencer_state debugfs entry and
issues an i2c_smbus_read_word_data(client, ADM1266_READ_STATE)
against the device without taking pmbus_lock.  pmbus_core holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked debugfs reader can land between a PAGE
write and the subsequent paged read in another thread.  READ_STATE
itself is not paged, so it cannot corrupt PAGE in flight, but the
same defensive serialisation that applies to the GPIO accessors
applies here: any direct device access from outside pmbus_core
should be ordered with respect to pmbus_core's own.

Take pmbus_lock at the top of adm1266_state_read() via the
scope-based guard().

Fixes: ed1ff457e187 ("hwmon: (pmbus/adm1266) add debugfs for states")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-8-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 5ddca5701032..6f6ad7b20e9a 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -335,6 +335,7 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	guard(pmbus_lock)(client);
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
 	if (ret < 0)
 		return ret;


