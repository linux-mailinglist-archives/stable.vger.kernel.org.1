Return-Path: <stable+bounces-241381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMS/J4SS72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:44:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8EA476A06
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C71D9305FC2A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370334D384;
	Mon, 27 Apr 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTvWmqxm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A107083C
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307917; cv=none; b=f+TzwlSlnGruIw6C8/7tDGxY7qVULbckfP2BsuywDekZVfeF0FaKipIIgPESRrKA8j71133y4JEYfkCzKwwyAeAqLadk34E6Ni0TfL+goiG4CNynUB7Co5y57pTPYK5whfZhmsklBl0sZxKnZZ49JezJ9LNIfjjs8XWlIIWZMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307917; c=relaxed/simple;
	bh=CxPF4o5aluk1fliCqiWGcbncBxsIBbik1ellBafnLgA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E1IU0OGwzXCBYB3wqN1Jj7C6MxKpkz+Y1d3iLiCQUXil47P3rFau4+ZY8ylnntN6MebBvIAfiNsNhDE3Rn6RR2y5rpVuVLHJxTeAMKaIysyy/szWXvnFI5X6mb+m2aRYsXm1FHw45QGzjR1fXB8f+Y38HpLeRWC0qk3ps3bDcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTvWmqxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C78C19425;
	Mon, 27 Apr 2026 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777307917;
	bh=CxPF4o5aluk1fliCqiWGcbncBxsIBbik1ellBafnLgA=;
	h=Subject:To:Cc:From:Date:From;
	b=JTvWmqxmRYLhLTr29ZNqllmcvRztjc2sp4rMYjWoR5kFTuajRPKdCVUwntNYKsItA
	 Mv5xmrUObZ5Vw7Bn7qIQ0ANxRNnD49nqgZ+/N8vYZ3Qn5FSYg0HUhby9BdRoV6/CsC
	 UjdNPtjU5KBdRAdSbJmJW7sP5LrhiUr4lP+epD+0=
Subject: FAILED: patch "[PATCH] mei: me: add nova lake point H DID" failed to apply to 7.0-stable tree
To: alexander.usyskin@intel.com,gregkh@linuxfoundation.org,stable@kernel.org,tomasw@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:38:01 -0600
Message-ID: <2026042701-alumni-disfigure-b344@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B8EA476A06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241381-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,linuxfoundation.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email]


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x a5a1804332afc7035d5c5b880548262e81d796bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042701-alumni-disfigure-b344@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5a1804332afc7035d5c5b880548262e81d796bc Mon Sep 17 00:00:00 2001
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Sun, 5 Apr 2026 17:17:58 +0300
Subject: [PATCH] mei: me: add nova lake point H DID

Add Nova Lake H device id.

Cc: stable <stable@kernel.org>
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Link: https://patch.msgid.link/20260405141758.1634556-1-alexander.usyskin@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 9b1675f98404..f145e8e36cb3 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -123,6 +123,7 @@
 #define PCI_DEVICE_ID_INTEL_MEI_WCL_P      0x4D70  /* Wildcat Lake P */
 
 #define PCI_DEVICE_ID_INTEL_MEI_NVL_S      0x6E68  /* Nova Lake Point S */
+#define PCI_DEVICE_ID_INTEL_MEI_NVL_H      0xD370  /* Nova Lake Point H */
 
 #define PCI_DEVICE_ID_INTEL_MEI_CRI        0x6766  /* Crescent Island */
 
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 8d16bfa6027c..9efeafa8f1ca 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -131,6 +131,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, MEI_WCL_P, MEI_ME_PCH15_CFG)},
 
 	{PCI_DEVICE_DATA(INTEL, MEI_NVL_S, MEI_ME_PCH15_CFG)},
+	{PCI_DEVICE_DATA(INTEL, MEI_NVL_H, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
 	{0, }


