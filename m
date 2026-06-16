Return-Path: <stable+bounces-264912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hm9wKht/MWp3kwUAu9opvQ
	(envelope-from <stable+bounces-264912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:51:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8F69284F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:51:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=V0d7zKri;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264912-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264912-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A084303C52A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB78478E57;
	Tue, 16 Jun 2026 16:49:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2D478E3E;
	Tue, 16 Jun 2026 16:49:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628543; cv=none; b=qi0VX+Oj0IukVhJo7nbXB/VX+dWnYC94dN5fGhNI/pSZ2U6sffMWdOvyWF+MgU2OAXuICbgdlakM/+wCXp82Fwe+5I5ECIfjGGt9edW0YZFaFXIH54VSwLvhBCtSPazgDox/yPy8ZtG7jEszg/yL2RpQFyF1zmOgKyVCdj9P4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628543; c=relaxed/simple;
	bh=bJobjdXOYgO543rrAZ8m47+4HOsYNm+q4GXc0RE48wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZc5Nm30gioh4MslPx1IbjLPdLBaLtcekkVTZI4WLhZHnlMC7GzxXK/JCBEIc1l6cIzFpAIuq0x/56eXkSc4MesTtu+l0PJ52LAZi3Wji9aWmWOirV2bFFd+EbZOnJCiK8MM0secs+sD9jaWb4HSzc/S7XZEuOqiGzuwcMp+Q+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0d7zKri; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693371F000E9;
	Tue, 16 Jun 2026 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628542;
	bh=cEB5tn3aGjTaEqK9qJLdhvGVGJNK5FFLb1a8ro+QzPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V0d7zKri5v3r9QwePH7eIxCk9ZFoQPRQe5pnOeLuEu7jlwf3CKpH9UP9Wy9X+a7Ef
	 Qgxm/f3zU1Za7SusNq4xkWUWwRwvCsyd+0IC785oYoMmpyz3mCPFC+0TcEI+2obvuc
	 TURtrs5h6NcpjkfX1FVGzdItH7cViJgP5iZTNrl4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.6 083/452] usb: typec: ucsi: ccg: reject firmware images without a : record header
Date: Tue, 16 Jun 2026 20:25:10 +0530
Message-ID: <20260616145122.227932026@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264912-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:heikki.krogerus@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53E8F69284F

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1178,6 +1178,11 @@ not_signed_fw:
 	 *****************************************************************/
 
 	p = strnchr(fw->data, fw->size, ':');
+	if (!p) {
+		dev_err(dev, "Bad FW format: no ':' record header found\n");
+		err = -EINVAL;
+		goto release_mem;
+	}
 	while (p < eof) {
 		s = strnchr(p + 1, eof - p - 1, ':');
 



