Return-Path: <stable+bounces-233669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EMNNmgj1WnK1AcAu9opvQ
	(envelope-from <stable+bounces-233669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:31:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0773B1120
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A5B30315D5
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CE83BE150;
	Tue,  7 Apr 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gsQ2/TuL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031829ACD1
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575816; cv=none; b=NmfPlPBr4Kt1/yWXOaIFlMesKIFiUUBmVaSYiv2Cu5TnR8MGO6UHL7D68ePjSSOwgydWhZxpAQ2mRw6kcFXi7D///iwBYUBGXRy84qQ8E9yyVsdKhSBPchfDGhYzrlFfaEwwyfnrZGzfYppn5OZiNK4CzcdbjrK85JwXScyTZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575816; c=relaxed/simple;
	bh=ubygyrw1nx4/iObnlumu/XCMCs+8VE7UoVkw2Lw2R3A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oQqgODw1aaEFvOur3nNmOkMmTrkFFM11UbWzm7FcNPBycGw3TMeHssAHpn3WA06m3kIx7Ib8h5FyJdGkgG3gAesZQB0e4gMj4SHU1MKlW7RLsetTIOBoHWRGJQqaAwyzTEvVF+Ycp6ZtUfY91ffp/PoBqX5OZIQhtkDxpPUBQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gsQ2/TuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA83DC2BC9E;
	Tue,  7 Apr 2026 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775575814;
	bh=ubygyrw1nx4/iObnlumu/XCMCs+8VE7UoVkw2Lw2R3A=;
	h=Subject:To:Cc:From:Date:From;
	b=gsQ2/TuLSxAv8YWSpkfeh6uMFrR+IY3YgdpQ9l61rig7eATEDAXGSZjk5XUHSXycU
	 PEM4LLzoBqfqS9v7yYTnwQWrwQrWlU7CILiixuFSF7LFjDgXlHbKONH8T+gQKc04+d
	 n3dZbZnn6c67ZMlebyEtLLYo6TB+vEFh+EBx+OhU=
Subject: FAILED: patch "[PATCH] usb: cdns3: gadget: fix state inconsistency on gadget init" failed to apply to 5.10-stable tree
To: yongchao.wu@autochips.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:30:11 +0200
Message-ID: <2026040711-pond-storage-68f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233669-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,linuxfoundation.org:email,msgid.link:url,autochips.com:email]
X-Rspamd-Queue-Id: 3F0773B1120
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c32f8748d70c8fc77676ad92ed76cede17bf2c48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040711-pond-storage-68f8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c32f8748d70c8fc77676ad92ed76cede17bf2c48 Mon Sep 17 00:00:00 2001
From: Yongchao Wu <yongchao.wu@autochips.com>
Date: Wed, 1 Apr 2026 08:10:00 +0800
Subject: [PATCH] usb: cdns3: gadget: fix state inconsistency on gadget init
 failure

When cdns3_gadget_start() fails, the DRD hardware is left in gadget mode
while software state remains INACTIVE, creating hardware/software state
inconsistency.

When switching to host mode via sysfs:
  echo host > /sys/class/usb_role/13180000.usb-role-switch/role

The role state is not set to CDNS_ROLE_STATE_ACTIVE due to the error,
so cdns_role_stop() skips cleanup because state is still INACTIVE.
This violates the DRD controller design specification (Figure22),
which requires returning to idle state before switching roles.

This leads to a synchronous external abort in xhci_gen_setup() when
setting up the host controller:

[  516.440698] configfs-gadget 13180000.usb: failed to start g1: -19
[  516.442035] cdns-usb3 13180000.usb: Failed to add gadget
[  516.443278] cdns-usb3 13180000.usb: set role 2 has failed
...
[ 1301.375722] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[ 1301.377716] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
[ 1301.382485] pc : xhci_gen_setup+0xa4/0x408
[ 1301.393391] backtrace:
    ...
    xhci_gen_setup+0xa4/0x408    <-- CRASH
    xhci_plat_setup+0x44/0x58
    usb_add_hcd+0x284/0x678
    ...
    cdns_role_set+0x9c/0xbc        <-- Role switch

Fix by calling cdns_drd_gadget_off() in the error path to properly
clean up the DRD gadget state.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Yongchao Wu <yongchao.wu@autochips.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260401001000.5761-1-yongchao.wu@autochips.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 96d2a4c38b3f..8382231af357 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3431,6 +3431,7 @@ static int __cdns3_gadget_init(struct cdns *cdns)
 	ret = cdns3_gadget_start(cdns);
 	if (ret) {
 		pm_runtime_put_sync(cdns->dev);
+		cdns_drd_gadget_off(cdns);
 		return ret;
 	}
 


