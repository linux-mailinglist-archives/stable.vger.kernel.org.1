Return-Path: <stable+bounces-261333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4bjjGPlHJWq5FwIAu9opvQ
	(envelope-from <stable+bounces-261333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6C64FB1A
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yA3aN373;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261333-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261333-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE5273001FA8
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4F2F8E97;
	Sun,  7 Jun 2026 10:29:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE94071E3;
	Sun,  7 Jun 2026 10:29:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828146; cv=none; b=ur1t/E/KEzsDj1lYLWRl5s4c504PiOzJhkQTocXozddVa9Wt7wCqX3S7Wq8FEF6OGeGDlBPRVDI4kJ6wbrC1OjscapfPH9VnLQsqokGBN/SbsY2t9iAlONwTBJl37dJc9fzMFAUEXxTZ9ECkqZn+6JuLkXS6R07SV24Zly5Ja2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828146; c=relaxed/simple;
	bh=xcbyC+6KJiVLSYJppWGSC3iWsmKwcXVbxg8SrnN9cuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3s5ocvFknbg84AEGyOdgKSSqGx8KUvtFPoDZNtf9AWeHm0T3EpgsbdzmUe3mVBpJ0lPfhgkIlWPmov7nUuFf/g1JEfl5xCzer43CgsZoC2X6WOwYDcdsnwHTYzmDFPwCISUFl/KXOFfxB67j4csKJhEA6xDlbYpXekv7myJeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yA3aN373; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EB21F00893;
	Sun,  7 Jun 2026 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828145;
	bh=198dRpYuht8wxvsL57Fyz2hfBEHlV6bqWd9WNf8rhY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yA3aN373cZcIHD2idlU0XwXV7j/T4AYQyFOKZYMYYOdJZrhHFIUBUiaOFBNdyxPvE
	 5ZsSjgAPaFujvaCVHy2REHu+SoTaydnrta29dyD3js3EfouIMnzsOaCjULKJHsrWzK
	 FArTr/T/QjmqRS+PL1fw9U46TMHfQa99Tnhno3NQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ben Hutchings <benh@debian.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 7.0 155/332] parport: Fix race between port and client registration
Date: Sun,  7 Jun 2026 11:58:44 +0200
Message-ID: <20260607095733.776359604@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261333-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:benh@debian.org,m:sudipm.mukherjee@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,debian.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BB6C64FB1A

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <benh@debian.org>

commit ef15ccbb3e8640a723c42ad90eaf81d66ae02017 upstream.

The parport subsystem registers port devices before they are fully
initialised, resulting in a race condition where client drivers such
as lp can attach to ports that are not completely initialised or even
being torn down.

When the port and client drivers are built as modules and loaded
around the same time during boot, this occasionally results in a
crash.  I was able to make this happen reliably in a VM with a
PC-style parallel port by patching parport_pc to fail probing:

> --- a/drivers/parport/parport_pc.c
> +++ b/drivers/parport/parport_pc.c
> @@ -2069,7 +2069,7 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
>  	if (!p)
>  		goto out3;
>
> -	base_res = request_region(base, 3, p->name);
> +	base_res = NULL;
>  	if (!base_res)
>  		goto out4;
>

and then running:

    while true; do
        modprobe lp & modprobe parport_pc
	wait
	rmmod lp parport_pc
    done

for a few seconds.

In the long term I think port registration should be changed to put
the call to device_add() inside parport_announce_port(), but since the
latter currently cannot fail this will require changing all port
drivers.

For now, add a flag to indicate whether a port has been "announced"
and only try to attach client drivers to ports when the flag is set.

Fixes: 6fa45a226897 ("parport: add device-model to parport subsystem")
Closes: https://bugs.debian.org/1130365
Closes: https://lore.kernel.org/all/6ba903ad-9897-42bb-8c2d-337385cc3746@molgen.mpg.de/
Cc: stable <stable@kernel.org>
Signed-off-by: Ben Hutchings <benh@debian.org>
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Link: https://patch.msgid.link/afo6uBv68GDevbMD@decadent.org.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parport/share.c |   11 +++++++++--
 include/linux/parport.h |    1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -214,10 +214,14 @@ static void get_lowlevel_driver(void)
 static int port_check(struct device *dev, void *dev_drv)
 {
 	struct parport_driver *drv = dev_drv;
+	struct parport *port;
 
 	/* only send ports, do not send other devices connected to bus */
-	if (is_parport(dev))
-		drv->match_port(to_parport_dev(dev));
+	if (is_parport(dev)) {
+		port = to_parport_dev(dev);
+		if (test_bit(PARPORT_ANNOUNCED, &port->devflags))
+			drv->match_port(port);
+	}
 	return 0;
 }
 
@@ -532,6 +536,7 @@ void parport_announce_port(struct parpor
 		if (slave)
 			attach_driver_chain(slave);
 	}
+	set_bit(PARPORT_ANNOUNCED, &port->devflags);
 	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(parport_announce_port);
@@ -561,6 +566,8 @@ void parport_remove_port(struct parport
 
 	mutex_lock(&registration_lock);
 
+	clear_bit(PARPORT_ANNOUNCED, &port->devflags);
+
 	/* Spread the word. */
 	detach_driver_chain(port);
 
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -240,6 +240,7 @@ struct parport {
 
 	unsigned long devflags;
 #define PARPORT_DEVPROC_REGISTERED	0
+#define PARPORT_ANNOUNCED		1
 	struct pardevice *proc_device;	/* Currently register proc device */
 
 	struct list_head full_list;



