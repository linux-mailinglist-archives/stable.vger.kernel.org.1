Return-Path: <stable+bounces-233796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPF4IEv+1Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:05:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE273B7DEF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7397301E6C7
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C24A36C0DC;
	Wed,  8 Apr 2026 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="buofvWxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA992D0C63
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631832; cv=none; b=djochNHEkmlH3Z8Wa+QwSyHCGSFvvGU0DY/aITIUxvJv04lt3NujlB2XmfYrDWN66yiA1BE44xHBsCndvmB8RzjbqlAMXSIGlFWTAz/X5gWeUMAiueTIAb1+WPbMjM+bAegiQSKZ1uaJ1Bo7nhEppd3E2+ae6jCz/r7RZ6X+Uyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631832; c=relaxed/simple;
	bh=gmTwcN+wJ45AimWuAIV1iA4L8vQ6SfbQFyb6TpvUu6g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZK0nYaVM/sU1wilAeuw0lmJ9SAKY6EYTFCm7WE/CqPKoTN2/7al/U3FjkviHh1GU6smxyQkEm0+/CcLZYr+N6bbFndmjxu+8JTrV/XeheDj/qK6wB1zHhkGCsIfWMLPtyBCX8PE4OUXiPCVdzZeNat8gG6azz1cfj3CSTdFnYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=buofvWxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F50C19425;
	Wed,  8 Apr 2026 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775631832;
	bh=gmTwcN+wJ45AimWuAIV1iA4L8vQ6SfbQFyb6TpvUu6g=;
	h=Subject:To:Cc:From:Date:From;
	b=buofvWxU7fg638qsbS5lUa5fKMa/AbeKjdGnuJBErSUnlWIu+LTRjMgSHqsB6gWia
	 djOfVTJvj9sbHTbKsk0yGOjcizF3TM5NOJS7OCS2NWirgvP9UdjbBAQRt6+PZjooRe
	 Ua/Mr+Xrq7i/JyA7iT0VX/m4/E2v0McW+SZ4YiVM=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: validate connector number in" failed to apply to 6.1-stable tree
To: nathan.c.rebello@gmail.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 09:03:41 +0200
Message-ID: <2026040841-elevator-mule-ecae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233796-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,linux.intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,gregkh:email]
X-Rspamd-Queue-Id: CAE273B7DEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d2d8c17ac01a1b1f638ea5d340a884ccc5015186
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040841-elevator-mule-ecae@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2d8c17ac01a1b1f638ea5d340a884ccc5015186 Mon Sep 17 00:00:00 2001
From: Nathan Rebello <nathan.c.rebello@gmail.com>
Date: Fri, 13 Mar 2026 18:24:53 -0400
Subject: [PATCH] usb: typec: ucsi: validate connector number in
 ucsi_notify_common()

The connector number extracted from CCI via UCSI_CCI_CONNECTOR() is a
7-bit field (0-127) that is used to index into the connector array in
ucsi_connector_change(). However, the array is only allocated for the
number of connectors reported by the device (typically 2-4 entries).

A malicious or malfunctioning device could report an out-of-range
connector number in the CCI, causing an out-of-bounds array access in
ucsi_connector_change().

Add a bounds check in ucsi_notify_common(), the central point where CCI
is parsed after arriving from hardware, so that bogus connector numbers
are rejected before they propagate further.

Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable <stable@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
Link: https://patch.msgid.link/20260313222453.123-1-nathan.c.rebello@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index f38a4d7ebc42..8333bdaf5566 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -43,8 +43,13 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 	if (cci & UCSI_CCI_BUSY)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+	if (UCSI_CCI_CONNECTOR(cci)) {
+		if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
+			ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+		else
+			dev_err(ucsi->dev, "bogus connector number in CCI: %lu\n",
+				UCSI_CCI_CONNECTOR(cci));
+	}
 
 	if (cci & UCSI_CCI_ACK_COMPLETE &&
 	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))


