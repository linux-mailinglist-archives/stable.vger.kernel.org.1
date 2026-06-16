Return-Path: <stable+bounces-265883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DZwwEuORMWrymwUAu9opvQ
	(envelope-from <stable+bounces-265883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:11:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E1B693E0B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=x2BWLYgt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265883-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265883-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED476307BFFB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126423D75CE;
	Tue, 16 Jun 2026 18:11:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313F3D091A;
	Tue, 16 Jun 2026 18:11:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633504; cv=none; b=IjB9ycNxhYg2b1MZrJyOezsjkuC+kVUX18+goNszyMxn1HoXFev6FhGaN1/WNTpaDOS7nGiOMray2aSBVi2CpgQpMgQucsAID+PRcJZswFSrZu7fTB394bqM7Tang6z05ijyQ5ZWaCyqhQ825fMWQNqCXYyjNJJvTctwoEInF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633504; c=relaxed/simple;
	bh=MS6Q+LDE4biz2J4CnsU2174gY5nMGRwUKPqczEWgqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5t0Jt6VzqSkwLsd5Ea5ZfXpIHbZYhallQyyMzlM9jD99sNjxeSWfKZCyus7z108DCAUSBjRyutFVJxOKiO3bUG4M/IE6xRkgYEHTPs3KAX0VSuZY0VMrp8IDVIUs0DWSbvwXEHl2QjevCMSiz6o9jtRWaSvSL7kHqODeDBoP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2BWLYgt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD07B1F000E9;
	Tue, 16 Jun 2026 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633503;
	bh=dvIePy7Y01XzeYIYw4EYYM4ScCaL5lWjMUGMQmI/46U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x2BWLYgt9jYIQ6gYAeuZ9jr35FX4b6pEuqDMFOmFN+2Xz3Ts9vMAe8e45JbF+b0//
	 c8xyCIt5+y4RZaCyZ+/ZtaqM+Yjg/SazL5OHrxKU11Ot6a9Cjzmlmsfwe1MUzXyqYv
	 3sINOqx9rny+rX2vbOgMrBHQKIzjPLQsuTSsOO+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.15 058/411] usb: typec: altmodes/displayport: validate count before reading Status Update VDO
Date: Tue, 16 Jun 2026 20:24:56 +0530
Message-ID: <20260616145103.363250903@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265883-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:heikki.krogerus@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1E1B693E0B

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 8a18f896e667df491331371b55d4ad644dc51d60 upstream.

A broken/malicious device can send the incorrect count for a status
update VDO, which will cause the kernel to read uninitialized stack data
and send it off elsewhere.

Fix this up by correctly verifying the count for the update object.

Assisted-by: gkh_clanker_t1000
Cc: stable <stable@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/2026051350-reacquire-sculpture-4244@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/altmodes/displayport.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -286,6 +286,8 @@ static int dp_altmode_vdm(struct typec_a
 			dp->data.conf = 0;
 			break;
 		case DP_CMD_STATUS_UPDATE:
+			if (count < 2)
+				break;
 			dp->data.status = *vdo;
 			ret = dp_altmode_status_update(dp);
 			break;



