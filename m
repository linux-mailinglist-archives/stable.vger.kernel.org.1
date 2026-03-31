Return-Path: <stable+bounces-231849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC+rAb37y2mwNAYAu9opvQ
	(envelope-from <stable+bounces-231849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B244936D48D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28A6D30B94B7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1AD426684;
	Tue, 31 Mar 2026 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPFgNdEu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014E425CD9;
	Tue, 31 Mar 2026 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975229; cv=none; b=EDl+0rKmtPOJbApXK+xWA6UTT7TitnLUYGmx7Fz0DlWqxicVXVUoUdEgfuSWDYInXpY63N+tO3igScDf9PPx5cZrw5QYsIb51LmzL2jcagZRuedXx0jiW7BdJJZL3iVoyS3HI/1Fuvh7dmDGj9Q7MkA7y5+vCGg7yEKD/k15JJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975229; c=relaxed/simple;
	bh=7yNGKiq6UrxQfZWXv2OU+0X16FadKQE0zRDIqPUs2k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lL8By35oIOFBfDELIedAIUjRYsYPIJLXz1TbeSkOcdWX+9c4Hm35adNoZOqo1UaKFZ9CQRFyCP3fd+zqP4pXxMJW+JlbmTmmu9gytO9rhIEKG01n6mODj/Fr+PFQags7A11i9hiT53h4uk8ZP4AJmjZ7R0SsngSkd4PMFtMzbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hPFgNdEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8769C19423;
	Tue, 31 Mar 2026 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975229;
	bh=7yNGKiq6UrxQfZWXv2OU+0X16FadKQE0zRDIqPUs2k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPFgNdEuuD7jSJmbdTOoZGmLuV1yOR+DPsWoMRsJO6KujQAuJQuXXGPRB9uoAjYnD
	 sZo4qhhBefl2OsNkF2TMFOuf8yuDlNxZKZkfOZhqukZCYqBOk2KWjwy6hbvcIuBJeF
	 fuQ1nix9CSVxkGtYoyTuirzqAYaNLKsg+Tjn4DZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.19 214/342] can: netlink: can_changelink(): add missing error handling to call can_ctrlmode_changelink()
Date: Tue, 31 Mar 2026 18:20:47 +0200
Message-ID: <20260331161806.853414921@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231849-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: B244936D48D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit cadf6019231b614ebbd9ec2a16e5997ecbd8d016 upstream.

In commit e1a5cd9d6665 ("can: netlink: add can_ctrlmode_changelink()") the
CAN Control Mode (IFLA_CAN_CTRLMODE) handling was factored out into the
can_ctrlmode_changelink() function. But the call to
can_ctrlmode_changelink() is missing the error handling.

Add the missing error handling and propagation to the call
can_ctrlmode_changelink().

Cc: stable@vger.kernel.org
Fixes: e1a5cd9d6665 ("can: netlink: add can_ctrlmode_changelink()")
Link: https://patch.msgid.link/20260310-can_ctrlmode_changelink-add-error-handling-v1-1-0daf63d85922@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/dev/netlink.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -601,7 +601,9 @@ static int can_changelink(struct net_dev
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
-	can_ctrlmode_changelink(dev, data, extack);
+	err = can_ctrlmode_changelink(dev, data, extack);
+	if (err)
+		return err;
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;



