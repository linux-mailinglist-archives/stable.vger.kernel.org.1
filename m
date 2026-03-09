Return-Path: <stable+bounces-223541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MQUKf2ermm2GwIAu9opvQ
	(envelope-from <stable+bounces-223541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:20:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BB7236F04
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E94830185DA
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2F437BE95;
	Mon,  9 Mar 2026 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="niOiUs4o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048381732
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051643; cv=none; b=AECU8vIET/++Nnf4Exi5Qb9OKc6JLzZyWjJj1GaRLbEvDXf9dG/klEvaxpPVFpOlAwRsvjRUgYTz13NowfsoQRapUJzhFxx6TLPytDHwfoPJe1XPiSvgyZ/ZO3y4V6qxu3dDt2YuOVcD/ReRevKUfDuq31+15evI4xM/5oItu3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051643; c=relaxed/simple;
	bh=Cc6jD8CxShdI89KM5MflUU7xv4qbHOdRVqEOCLlfuls=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UXFYWhrowa7EWq2goJ6kGv6YkMFD43X43XQQdgaNK62LDrvPP+jvQItircOiDjptpeQmy098zMuU/2e5ye8XNVsW6s9iFxX8kHOsUKMUh6KOIfXXn2SjfoBuMLKpVH5cyAr0s3OerFyHqqWVouaLl7UQQC9J1WIpfTorjwwVUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=niOiUs4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB85C4CEF7;
	Mon,  9 Mar 2026 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051642;
	bh=Cc6jD8CxShdI89KM5MflUU7xv4qbHOdRVqEOCLlfuls=;
	h=Subject:To:Cc:From:Date:From;
	b=niOiUs4oxENgmtudf6ouzjKBlgXbJNRYmvmZ+6lP+t6T2V/UaoWkYzudE1IG95Yo6
	 9tulMOefM9+3srMicJL++zr14C7pomfiolnLDb5wFQsImyYojLgeJbh3TY0nvdDTxE
	 pfd0Bwov1x3sJRpHSDXAOQsnLiBklbSjvNs9Qt9U=
Subject: FAILED: patch "[PATCH] Bluetooth: Fix CIS host feature condition" failed to apply to 6.18-stable tree
To: mariusz.skamra@codecoup.pl,luiz.von.dentz@intel.com,pmenzel@molgen.mpg.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:20:32 +0100
Message-ID: <2026030932-henchman-travesty-7e47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08BB7236F04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223541-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.206];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,codecoup.pl:email,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7cff9a40c6b0f72ccefdaf0ffe03cfac30348f51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030932-henchman-travesty-7e47@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7cff9a40c6b0f72ccefdaf0ffe03cfac30348f51 Mon Sep 17 00:00:00 2001
From: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Date: Thu, 12 Feb 2026 14:46:46 +0100
Subject: [PATCH] Bluetooth: Fix CIS host feature condition

This fixes the condition for sending the LE Set Host Feature command.
The command is sent to indicate host support for Connected Isochronous
Streams in this case. It has been observed that the system could not
initialize BIS-only capable controllers because the controllers do not
support the command.

As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
supported if CIS Central or CIS Peripheral is supported; otherwise,
the command is optional.

Fixes: 709788b154ca ("Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings")
Cc: stable@vger.kernel.org
Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f04a90bce4a9..0b0dc0965f5a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4592,7 +4592,7 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 {
 	int err;
 
-	if (iso_capable(hdev)) {
+	if (cis_capable(hdev)) {
 		/* Connected Isochronous Channels (Host Support) */
 		err = hci_le_set_host_feature_sync(hdev, 32,
 						   (iso_enabled(hdev) ? 0x01 :


