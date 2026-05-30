Return-Path: <stable+bounces-258248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF7nE0wlG2pm/ggAu9opvQ
	(envelope-from <stable+bounces-258248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:58:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3EE610BC3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C540E30237FC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C0342CA7;
	Sat, 30 May 2026 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JUWGLf9v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8F237713;
	Sat, 30 May 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163712; cv=none; b=b30eAFtJrjV3Zp7THwMWUktJ8nIG5gpL4ici280Npm14jnuyuGZll4o97099M9YlNo5Sq4mupzwBUVdJbtrSCtYt4yOkYDv+n0jOA+dgjLeVZzjisInpjmo6krCj07h+rsmxWLBIT17/hMG+4O7/8DXoJPOfBQI806e6qtFvvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163712; c=relaxed/simple;
	bh=Anr946FTDbxz2wNi8j1464YamnOMUM+4rjGu4Z07Wyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3LDh456jglkBy3reJvrITjMlMO7KXhyhfUGfP1mlxP4UBCQoQfZUPMZUjEMG04CitLW7wK29ojYtL3IGN84odjHcPoGyXLqMkkyvLdfMaVMWOQJGzKoHEoKSOxEyxSnjfaXiqTjkdH2siM3SE4NKjj8uSkkkrkckNmGOnzDBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JUWGLf9v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6121F00893;
	Sat, 30 May 2026 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163711;
	bh=HHei9Zbft0pTYotTxoRO9HuJI6zSKbwUmRNMolg0R3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JUWGLf9v5pALvggxBkIuLD2ajAFxq+7x9S5lFHUPazNWaQTghZx3d22z7kGG/7oV9
	 0cQGN2L7exj/FdZpc3AlS79rFN51tGqpik/socT8c8UOQ6hCs4iowScQvqoMFWhTRh
	 OMMNOxeAq01uDQ7sRnuEuG9Fg3WaVuIfbZcTkc1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH 5.15 340/776] PCI/AER: Stop ruling out unbound devices as error source
Date: Sat, 30 May 2026 18:00:54 +0200
Message-ID: <20260530160249.361499762@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258248-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,wunner.de:email]
X-Rspamd-Queue-Id: CF3EE610BC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 1ab4a3c805084d752ec571efc78272295a9f2f74 upstream.

When searching for the error source, the AER driver rules out devices whose
enable_cnt is zero.  This was introduced in 2009 by commit 28eb27cf0839
("PCI AER: support invalid error source IDs") without providing a
rationale.

Drivers typically call pci_enable_device() on probe, hence the enable_cnt
check essentially filters out unbound devices.  At the time of the commit,
drivers had to opt in to AER by calling pci_enable_pcie_error_reporting()
and so any AER-enabled device could be assumed to be bound to a driver.
The check thus made sense because it allowed skipping config space accesses
to devices which were known not to be the error source.

But since 2022, AER is universally enabled on all devices when they are
enumerated, cf. commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
AER is native").

Errors may very well be reported by unbound devices, e.g. due to link
instability.  By ruling them out as error source, errors reported by them
are neither logged nor cleared.  When they do get bound and another error
occurs, the earlier error is reported together with the new error, which
may confuse users.  Stop doing so.

Fixes: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
Cc: stable@vger.kernel.org # v6.0+
Link: https://patch.msgid.link/734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pcie/aer.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -852,8 +852,6 @@ static bool is_error_source(struct pci_d
 	 *      3) There are multiple errors and prior ID comparing fails;
 	 * We check AER status registers to find possible reporter.
 	 */
-	if (atomic_read(&dev->enable_cnt) == 0)
-		return false;
 
 	/* Check if AER is enabled */
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);



