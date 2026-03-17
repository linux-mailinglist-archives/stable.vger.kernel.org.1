Return-Path: <stable+bounces-226709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBvwOTyNuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:19:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CE12AF542
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DD723015899
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AA2DF132;
	Tue, 17 Mar 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RgQEdKPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD952D73B8;
	Tue, 17 Mar 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767908; cv=none; b=BkUPFoEWUGS52jUB99jn8Yfv0Ae06j36t7AXotgwvTcpKuNlEJWnr/4H0Lk9ccwt71DN5R5HkaZiqyWD9xXT2ejQXUt7cPMQjAKSy58qZT9+S6IzvXpojeamuPaRddZIn1kfJrc9qAUzS2iKDMn0IdUQcbLd3ya+934uaZYtHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767908; c=relaxed/simple;
	bh=TA9EySaRAyvQp9md/CP5oWHmAIkrLJATXTuNzX+53AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=einun07+FYHCyEwSPm3Xph1TXEX61wTd4YBPm7iQ3ishrtJm1R9EDeRQGuEUCljb8b0qukscPyqgxssTWsPuU8FV5BVXmqEWArJMHyku1agUNHzBp6TeGkoGUOJ9wigPZUUSjXUdUxbXJziXIV+HqMKDYjkFF46iqVNxKKmE1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RgQEdKPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C99CC4CEF7;
	Tue, 17 Mar 2026 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767908;
	bh=TA9EySaRAyvQp9md/CP5oWHmAIkrLJATXTuNzX+53AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgQEdKPGqVxCDaNDwO39J0SzWVhgglK2vrB93Ea5qorwaahadjIegR4MVqHI2kFyA
	 +HXq1R7xRGfNxBQF8Jvr/Zu+r+rQj1P1oon6die4/Go78jQKBzmVrQSxS8z/A4nFcs
	 KwegQTbZk8tlsagk4SmGxOLTq7kSsw1nxYpXOASs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.18 187/333] ipmi:si: Dont block module unload if the BMC is messed up
Date: Tue, 17 Mar 2026 17:33:36 +0100
Message-ID: <20260317163006.288845343@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226709-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86CE12AF542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

commit f895e5df80316a308c2f7d64d13a78494630ea05 upstream.

If the BMC is in a bad state, don't bother waiting for queues messages
since there can't be any.  Otherwise the unload is blocked until the
BMC is back in a good state.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Cc: stable@vger.kernel.org # 4.18
Signed-off-by: Corey Minyard <corey@minyard.net>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2227,7 +2227,8 @@ static void wait_msg_processed(struct sm
 	unsigned long jiffies_now;
 	long time_diff;
 
-	while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)) {
+	while (smi_info->si_state != SI_HOSED &&
+		    (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL))) {
 		jiffies_now = jiffies;
 		time_diff = (((long)jiffies_now - (long)smi_info->last_timeout_jiffies)
 		     * SI_USEC_PER_JIFFY);



