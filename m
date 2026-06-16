Return-Path: <stable+bounces-266290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +hO8OvCaMWosoAUAu9opvQ
	(envelope-from <stable+bounces-266290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:50:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B30F69481C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=P1cvAcUC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266290-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266290-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA033222828
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F94657C2;
	Tue, 16 Jun 2026 18:47:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD43CFF55;
	Tue, 16 Jun 2026 18:47:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635648; cv=none; b=jomMBt92h3uHHt3ARFO3IfkLMyKlU2Esj/MflBqNxyn7Ov7ME6GRTJBwzuQdAV1T3mpkalAUQkO9b3eIT+5mbB7tGLkafPj9mMSrW0W2RiTOW/sB2DJLNHERlM/b97rMozO5bFlf+SviMrM/9dSSr3ZkrGtmlijA75s6beVG1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635648; c=relaxed/simple;
	bh=TckqbwD62SPi1x4igDw3SlLE0LoKWaLbno8QKjwHDf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4uZ+wBnenH8yWAM0TlW4XieTu3pX9R+WP0/YPz1jyRIguTjWtU5EKk/erX0zZvaXOxheaLftptLfeHbtorwD7MaFdR1Bo/oAvNDHju4sS4GxwfQ0DwHr87bhkARAPMAK6nRx2F34L1T693xbGP9E69l8vIb59+QwH7sDmbEb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P1cvAcUC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3F41F000E9;
	Tue, 16 Jun 2026 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635647;
	bh=Ph4DAFS9ziPIEkChjfGtrghH75nSMy4BlMg4ytuW5OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P1cvAcUCPyMw/87RnvmkxvkkUcVqSO1jkEptbOAj8FAvxiGQRUYu3eMQljnn13Daz
	 +M2u6Ys4xeVJh4zX9s5KvE9XEe7Zcjd5B1CTUDyKbZaoFNq9lwKuf+LDLIKqe2NgkA
	 8X0L2yj4jon/k7Dpbj6u9w+EwL2NpE2toHRKvSMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ben Hutchings <benh@debian.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5.10 055/342] parport: Fix race between port and client registration
Date: Tue, 16 Jun 2026 20:25:51 +0530
Message-ID: <20260616145050.821643731@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266290-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B30F69481C

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -223,10 +223,14 @@ static void get_lowlevel_driver(void)
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
 
@@ -553,6 +557,7 @@ void parport_announce_port(struct parpor
 		if (slave)
 			attach_driver_chain(slave);
 	}
+	set_bit(PARPORT_ANNOUNCED, &port->devflags);
 	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(parport_announce_port);
@@ -582,6 +587,8 @@ void parport_remove_port(struct parport
 
 	mutex_lock(&registration_lock);
 
+	clear_bit(PARPORT_ANNOUNCED, &port->devflags);
+
 	/* Spread the word. */
 	detach_driver_chain(port);
 
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -245,6 +245,7 @@ struct parport {
 
 	unsigned long devflags;
 #define PARPORT_DEVPROC_REGISTERED	0
+#define PARPORT_ANNOUNCED		1
 	struct pardevice *proc_device;	/* Currently register proc device */
 
 	struct list_head full_list;



