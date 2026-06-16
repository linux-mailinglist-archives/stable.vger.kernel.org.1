Return-Path: <stable+bounces-265881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b+J5C92RMWrvmwUAu9opvQ
	(envelope-from <stable+bounces-265881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:11:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47239693DFE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:11:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IWi7bsnV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265881-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265881-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E2673001CE6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F13D75CE;
	Tue, 16 Jun 2026 18:11:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E63D5656;
	Tue, 16 Jun 2026 18:11:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633493; cv=none; b=QL8DT3qi1OCLl0qyr5+72RyjyqKSBjSZIbljNHmzChDyOO6CYlqWshi5t8ch7cegyhGpR1wIDBwI5AJxJ4sbsb1ZE4YrDGrrhUa55IzOPZQg6k1CUXSLqqy4U32UQ17ggCJgQQy2Tcp/PhLvOnnFzzLE/TP4KURNcvT8NXKe7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633493; c=relaxed/simple;
	bh=7hOLrNYyrcBsTD069r9JTM+ALgInoBC9X5qqrVQyMAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBiSegbLKNrpCrQs8qExjDAC/3r3amC25ziae8lp7CsIh6JMT5KudC/ZpwbPkvGKSSLA2vT2LwNhue3CBCIP8+QWec2jCu3PX0EDIujszWd8UVOEY1CLyrn5AZxVEevtRdYOdUR/n1oAMC9FX+WTn//h+MaHCK03RpSgC1R80sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWi7bsnV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB191F000E9;
	Tue, 16 Jun 2026 18:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633492;
	bh=NNB44iMdnTIEtYMjqHSngrhU0YWLpx7BP9DSINAbLWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWi7bsnVPv2axWEzOuUeKZMpdGfmW9TKGFzahkyM0LuIfy30+JkJb5G03h7KUaC57
	 jZuOhqQZ7tko01TzssigYfUUAHex3S9ZIQGNy8dL5A8tS/WOrJWD1hFvkIBlc4OjNU
	 27xZUzRVOrzZlh6u/aq5x6+VlFmRsJbZHYG3CRPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.15 056/411] usb: typec: ucsi: ccg: reject firmware images without a : record header
Date: Tue, 16 Jun 2026 20:24:54 +0530
Message-ID: <20260616145103.258469150@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265881-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:heikki.krogerus@linux.intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47239693DFE

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit d7486952bf74e546ee3748fb14b2d07881fa6273 upstream.

do_flash() locates the first .cyacd record with

	p = strnchr(fw->data, fw->size, ':');
	while (p < eof) {
		s = strnchr(p + 1, eof - p - 1, ':');
		...
	}

If the firmware image contains no ':' byte,  strnchr() returns NULL.
NULL compares less than the valid kernel pointer eof, so the loop body
runs and strnchr() is called with p + 1 == (void *)1 and a length of
roughly (unsigned long)eof, causing a wonderful crash.

The not_signed_fw fallthrough earlier in do_flash() and the chip-state
branches in ccg_fw_update_needed() allow an unsigned blob to reach this
loop, so a root user who can place a crafted file under /lib/firmware
and write the do_flash sysfs attribute can trigger the oops.

Bail out with -EINVAL when the initial strnchr() returns NULL.

Assisted-by: gkh_clanker_t1000
Cc: stable <stable@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026051405-posture-shrill-7884@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1156,6 +1156,11 @@ not_signed_fw:
 	 *****************************************************************/
 
 	p = strnchr(fw->data, fw->size, ':');
+	if (!p) {
+		dev_err(dev, "Bad FW format: no ':' record header found\n");
+		err = -EINVAL;
+		goto release_mem;
+	}
 	while (p < eof) {
 		s = strnchr(p + 1, eof - p - 1, ':');
 



