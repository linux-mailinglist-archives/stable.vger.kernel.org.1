Return-Path: <stable+bounces-223625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAmPDsG6rmmxIQIAu9opvQ
	(envelope-from <stable+bounces-223625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:19:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B3238AD5
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B96731A9D1C
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA0376BEC;
	Mon,  9 Mar 2026 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eX/JzwT9"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276093A7F60;
	Mon,  9 Mar 2026 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058337; cv=none; b=h9TBCq0D4TY+ifTnXZ82Z109wzOf6Fw/NOoiCmMMMJ4pD3+ED373PLOTJwG57Fdmx1Ezs7kEwklcRQ7vgpv1v+O/NhNrVpY1wyzNxLWHwqqfC3POjxY55vJ4rYichg37NIchJU6ZWxkSvkDDlm9d/mylRtJYavhLkhwOMBlS7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058337; c=relaxed/simple;
	bh=1AkQY3UjZoTtRHE1imcrpxvIEH6TRQY7DY0WnYSDjv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JpPpEhm+lbfn4myDBRz+XVi6mq8Y882uBWOQNxoDUftJOwqL21WoisZF5YHI2jcRzUk63h0llAx8zXXiVC4bId2s/jOgVswbh78KHWwTyAj7akdKI+ibLGiw5OvUDt5PcCVJdiIPAZ7hVKSvQr8GYRCQ8fsl9H3ukHZ8wWucg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eX/JzwT9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=s94M7DGxzITAy84g2XAueMSi4reqo0hpF/UuKtKwq1w=; b=eX/JzwT9z67PHmcOFYRxcMRFLC
	nDohndzWLquFpLTgVSW5a4Wnw/ju+GcCebMiqec1fVxW3Jr49dxIHyGeLFtMeBsE/eM8dBMspLNt1
	adB+ez4gazxsQIlFkw1BBcRHHOBgyBhNF+6COKjw3XF7ek/9Auil/kYghoBPq7YJMiZ4edDTGCUow
	aFpqO5O0IscvK0l/a15MS2p1kG8Y9ZeYWXzMTICtzT9UtyVgUFEKOxSRtpcVmiCtjoZHRuW1vuZd3
	Z6RQl2GGBRhpk2K1QLCPsQcbh9kdzg31FmvirnZg4SbYcPFL2e/NcF47LSV1QxfolxJbX3CQHSr97
	I3hVJguQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzZT1-002D0O-Sk; Mon, 09 Mar 2026 12:12:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Mar 2026 05:11:34 -0700
Subject: [PATCH stable v6.18 v2] ipmi: Fix use-after-free and list
 corruption on sender error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-ipmi_stable-v2-1-9ed91630be53@debian.org>
X-B4-Tracking: v=1; b=H4sIAPa4rmkC/22NQQ6CMBBFr9LMmpIWQgVW3sMQw8AAYxRIi42G9
 O6GsnX9339vB0eWyUEtdrDk2fEyQy2yREA3tfNIknuoBWQqMypXleT1xXe3tfgkiT1pxKEoi9x
 AImC1NPAn2m5wMsKbVJfQnKt744O67RAe/MRuW+w3xr2Or78dr6WWSKrqKlMac9HXnpDbOV3sC
 E0I4QeU6XxVxwAAAA==
X-Change-ID: 20260309-ipmi_stable-bde1bbf58536
To: stable@kernel.org, Sasha Levin <sashal@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Corey Minyard <corey@minyard.net>, 
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Vlad Poenaru <thevlad@meta.com>, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2834; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCf/XcokkkpR9itGzPknY6ElDr4XJx3/5SjeXj4Rm98=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBprrkXaLG/Z5SwHsovF3D3zFP209m/BnTNQIUJB
 BbiZ5WZKxqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaa65FwAKCRA1o5Of/Hh3
 bXFPD/9Rtxb/GrN5noow262DV05XgWKkhYBljIG8jET1aVtbGpt31l5GW+Sl+ikdOS/q4Px9zof
 WlVTeP7ShP97mENhkT3i2RciUKV/9EAtIi0hCZcUt7bhul5fVjJjKrgqdi2OAxCU1HvBaYcJKAX
 i5IRu4OnASS7zrqeohdjb05L1OJH5bIj0AfipbrDB5v277xNeJK+qHg0H1SLEVu5+/Mkqfb6iN3
 UkdLHTC9n5tJd4TNHSzGQCs4v7J0MAG1nV96PhFUh4qIKAXBXSLD8VSrxZ1xSsFnkae38698PZE
 H4drnyBJSA5NJqu5SWHy8K8blibFjTRa9+Qa8d/SaE246e6+jVo4a+atcuL0NUj7CcCHJvt+U2a
 Q49pCnmneO+BWcrP1OacockYpNgi0ezfFAfq+SuyThBju+aZM4ntpPwwsr9ACmaS7rf/nXZSQgX
 UYlGKYkDCA1OTQClpgeKNeY+VIkBA/njt8UzGnp3GldVmOJs5iGSCJXJbNl5xLJJ4A1SOyQU0Ee
 zObvtFc2XHyZA3Ix+pGjwd1QkCVH1wwBudc+FLHwoThlf4c8z0RuEjPRhXoB6oRhH/FYEg37p4f
 gMabEEqESUUunuQSx2IGbyQjk2zIDGdWgZ9IMl26n6KVJZlH6HtyZpnkIP3U9pHcgWUrdDRR0Fa
 /sfx/E2Lf1CfCvw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: A16B3238AD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223625-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.943];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,minyard.net:email]
X-Rspamd-Action: no action

From: Corey Minyard <corey@minyard.net>

[ Upstream commit 594c11d0e1d445f580898a2b8c850f2e3f099368 ]

The analysis from Breno:

When the SMI sender returns an error, smi_work() delivers an error
response but then jumps back to restart without cleaning up properly:

1. intf->curr_msg is not cleared, so no new message is pulled
2. newmsg still points to the message, causing sender() to be called
   again with the same message
3. If sender() fails again, deliver_err_response() is called with
   the same recv_msg that was already queued for delivery

This causes list_add corruption ("list_add double add") because the
recv_msg is added to the user_msgs list twice. Subsequently, the
corrupted list leads to use-after-free when the memory is freed and
reused, and eventually a NULL pointer dereference when accessing
recv_msg->done.

The buggy sequence:

  sender() fails
    -> deliver_err_response(recv_msg)  // recv_msg queued for delivery
    -> goto restart                    // curr_msg not cleared!
  sender() fails again (same message!)
    -> deliver_err_response(recv_msg)  // tries to queue same recv_msg
    -> LIST CORRUPTION

Fix this by freeing the message and setting it to NULL on a send error.
Also, always free the newmsg on a send error, otherwise it will leak.

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/lkml/20260127-ipmi-v1-0-ba5cc90f516f@debian.org/
Fixes: 9cf93a8fa9513 ("ipmi: Allow an SMI sender to return an error")
Cc: stable@vger.kernel.org # 4.18
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Fix the commit id and add the proper branch (gregkh)
- Link to v1: https://patch.msgid.link/20260309-ipmi_stable-v1-1-be09c9686671@debian.org
---
 drivers/char/ipmi/ipmi_msghandler.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 0a886399f9daf..5ed8e95589fb7 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4848,8 +4848,15 @@ static void smi_work(struct work_struct *t)
 			if (newmsg->recv_msg)
 				deliver_err_response(intf,
 						     newmsg->recv_msg, cc);
-			else
-				ipmi_free_smi_msg(newmsg);
+			if (!run_to_completion)
+				spin_lock_irqsave(&intf->xmit_msgs_lock,
+						  flags);
+			intf->curr_msg = NULL;
+			if (!run_to_completion)
+				spin_unlock_irqrestore(&intf->xmit_msgs_lock,
+						       flags);
+			ipmi_free_smi_msg(newmsg);
+			newmsg = NULL;
 			goto restart;
 		}
 	}

---
base-commit: 6258e292d7463f96d0f06dff2a39093a54c9d16f
change-id: 20260309-ipmi_stable-bde1bbf58536

Best regards,
--  
Breno Leitao <leitao@debian.org>


