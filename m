Return-Path: <stable+bounces-226355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNVqA3yIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:59:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 068732AEC08
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C68430492ED
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC53F65EF;
	Tue, 17 Mar 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLPsmIOl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8513F65EC;
	Tue, 17 Mar 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766338; cv=none; b=lzsNU+T5HJd/YmEhr/CPaz7MJksUdyPkdf9n50uPLtEJCQbZpVPjDZtEof0pUbsG8sRXM8nJzFIPCttcEU2ZvbY8sNVcgsFn0/i5p13oyAQMCHWWkWQzOGx+Ah7AfwSS9cc6zF6dB+XdyW1CiQAysEikdRsVsLA1FEjQ7jnG24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766338; c=relaxed/simple;
	bh=ighv4/k353IEb97lfeZYObamKNQc3S7O0KJUR+sWj7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwB8fh7tySLS5NbqJoJymTwfFUSZyTd/3Vrp7vL2cPHgK2I8XWzHSw5tYn7VV7v5JcSuqSLV/DFPrHCXf0D1fsBez6qfUoYw4yEmXPSn2WmJRx4r7gEFt9crXQwS//EjxOh9/unstm0RuRFCQj1nQIr38Twr9CrfM7m7Axg8fck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLPsmIOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECEAC4CEF7;
	Tue, 17 Mar 2026 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766338;
	bh=ighv4/k353IEb97lfeZYObamKNQc3S7O0KJUR+sWj7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLPsmIOluJAb4W9r3QiONcwFwwEQR+kaPLXrtXhhVP+saVSUlpEbDtu/ZNPDlE94F
	 TBaIOTdomSHHQpLNbEfOq3BIktgRxGqfJwQw2wZydUUBthoj4lfpjPNY2Rq0Tq9CNV
	 N1vZ3Tgla09C/bssEI5pP8mR8Lpt4ZLWmPElyBAE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Igor Raits <igor@gooddata.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.19 222/378] ipmi:si: Use a long timeout when the BMC is misbehaving
Date: Tue, 17 Mar 2026 17:32:59 +0100
Message-ID: <20260317163015.177486242@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226355-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,minyard.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 068732AEC08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

commit c3bb3295637cc9bf514f690941ca9a385bf30113 upstream.

If the driver goes into HOSED state, don't reset the timeout to the
short timeout in the timeout handler.

Reported-by: Igor Raits <igor@gooddata.com>
Closes: https://lore.kernel.org/linux-acpi/CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com/
Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Cc: stable@vger.kernel.org # 4.18
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1113,7 +1113,9 @@ static void smi_timeout(struct timer_lis
 		     * SI_USEC_PER_JIFFY);
 	smi_result = smi_event_handler(smi_info, time_diff);
 
-	if ((smi_info->io.irq) && (!smi_info->interrupt_disabled)) {
+	if (smi_info->si_state == SI_HOSED) {
+		timeout = jiffies + SI_TIMEOUT_HOSED;
+	} else if ((smi_info->io.irq) && (!smi_info->interrupt_disabled)) {
 		/* Running with interrupts, only do long timeouts. */
 		timeout = jiffies + SI_TIMEOUT_JIFFIES;
 		smi_inc_stat(smi_info, long_timeouts);



