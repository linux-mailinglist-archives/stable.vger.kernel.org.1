Return-Path: <stable+bounces-223540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEJLFvWermm2GwIAu9opvQ
	(envelope-from <stable+bounces-223540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:20:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA5236EF6
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E848304019D
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429137D13F;
	Mon,  9 Mar 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHsrUDIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887FC81732
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051634; cv=none; b=D+4mz6R01EkulBTka4sF97xBL+88W9ruIPL30WVYuSutf1erfK2ZtsYm+IZ2U82oKOTYFg4qD9q3hClJwd7zxJHYeBcr/a7C1gQsnF3q2VvNcgtnkJFGvrKfunEH2nJMUwQ6B6Nb6kl02QGjuFb5GDP13R/wZsg8SAcnwpNXkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051634; c=relaxed/simple;
	bh=iy0g7xzZJwi0OOsAnaMhUjKPAcfRH4jg6sIcDwNr21Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nm3TBqhCABZCok1sJuHH49o0K9VTL5xL+lZacOjWEXlcfgsUBPcQl7GONn6Pm9YCooJxqE2sN3yeogy+R34VBDAvqcY0OXAIBeB9QsZZJ936067KuZj5UAHpDrkXCZ+w+hCREE5kH5zNZy28WBg2pRZ1JSYvCEfkzK8ELgHJa6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHsrUDIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F72C4CEF7;
	Mon,  9 Mar 2026 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051634;
	bh=iy0g7xzZJwi0OOsAnaMhUjKPAcfRH4jg6sIcDwNr21Y=;
	h=Subject:To:Cc:From:Date:From;
	b=xHsrUDIo6XUzbL1uaP8vzk/2cgRJ+OBuIHvG1GBd3aFdv7DHVgpX97xec6sP6N5hY
	 2/t/BniDlmby69ETF9KicIH9RJm1ZKGvU9SXdIh8sYEhjxneCdNMpn1H7j6klwD6d/
	 lnW3w4QLHjZWgsBEOBvfWZNf+z3khDwcGAJMp7r4=
Subject: FAILED: patch "[PATCH] Bluetooth: Fix CIS host feature condition" failed to apply to 6.19-stable tree
To: mariusz.skamra@codecoup.pl,luiz.von.dentz@intel.com,pmenzel@molgen.mpg.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:20:31 +0100
Message-ID: <2026030931-absinthe-imbecile-9225@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCEA5236EF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223540-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,intel.com:email,codecoup.pl:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 7cff9a40c6b0f72ccefdaf0ffe03cfac30348f51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030931-absinthe-imbecile-9225@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

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


