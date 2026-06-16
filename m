Return-Path: <stable+bounces-266416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s0PwFOCcMWrsoAUAu9opvQ
	(envelope-from <stable+bounces-266416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:58:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A86A6949F7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DkErcDtk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266416-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266416-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E37A300E90E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000247D935;
	Tue, 16 Jun 2026 18:58:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF04472798;
	Tue, 16 Jun 2026 18:58:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636310; cv=none; b=WEWtjVoPPLQ3Y6771fFksLCbIr6IMpTbMptjAFImtInM37vVJprsOpkpuPAeRphuEUiCyFW5i8ixzbJbQe+vVYBZYx0fDJOJPjQnJS9CEo2wRxt5W+jF8daiXYS8wmuop/uPVtc0uHbFEEP5qhrfpAb2hcoKxMmAsNx23Ab34p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636310; c=relaxed/simple;
	bh=pBjUARdXejcwjGQXaRqoE4C8pLzReQsQq/1t/vt32/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbxiGTl2eksIDBYgC/IvEnoqzgJYT8Nv7RAEyI9Zm7xhwcLks+LK6UkBeeVIi46TyieRxO8wYeKoe/jivBN2BS2QVcWJJkI4+SArv0WK04QL9ukom5RBCRJoJ+flA0ZYglmuxnZd7k1vhViYmEAqmRhHUKDB2y2WRx0B/shBfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DkErcDtk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0871F000E9;
	Tue, 16 Jun 2026 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636309;
	bh=ky5mGugtF4lfWe2yLNRLpFteYoPnrYFRMiqodO7RxG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DkErcDtkd6vlFT/iweEvJZ8V0QXSr+xwosTozF0OuhyhPbzdFNVyBeB/b+DjMLJLY
	 BrNMyFXD+yQKHIhsvvzc1sS7VbYCzVOpMPQioDzsDZ+B0hGall2lDnrBAGjGT/aC+s
	 NI0Q2xiA9/vp0g7kzW9uugTuIDYgMXqbnIA1asyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuho Choi <dbgh9129@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.10 189/342] ARM: socfpga: Fix OF node refcount leak in SMP setup
Date: Tue, 16 Jun 2026 20:28:05 +0530
Message-ID: <20260616145056.982016976@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-266416-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dbgh9129@gmail.com,m:dinguyen@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A86A6949F7

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuho Choi <dbgh9129@gmail.com>

commit 63838c323924fe4a78b2323bd45aa1030f72ca60 upstream.

socfpga_smp_prepare_cpus() looks up the Cortex-A9 SCU node with
of_find_compatible_node(), which returns a node reference that must be
released with of_node_put().

The function maps the SCU registers and then returns without dropping
that reference, leaking the node on both the success path and the
of_iomap() failure path.

Drop the reference once the mapping attempt is complete. The returned
MMIO mapping does not depend on keeping the device node reference held.

Fixes: 122694a0c712 ("ARM: socfpga: use of_iomap to map the SCU")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-socfpga/platsmp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -78,6 +78,7 @@ static void __init socfpga_smp_prepare_c
 	}
 
 	socfpga_scu_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 	if (!socfpga_scu_base_addr)
 		return;
 	scu_enable(socfpga_scu_base_addr);



