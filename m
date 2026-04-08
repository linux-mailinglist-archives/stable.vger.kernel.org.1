Return-Path: <stable+bounces-235231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AKkMB+m1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:01:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699743C231A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD403300A328
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF1331A44;
	Wed,  8 Apr 2026 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0OR2gNz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35E352C3C;
	Wed,  8 Apr 2026 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674908; cv=none; b=kF+KMCF5x2bL1NOGBSp1NWru1ga8SAYFAr/OK5qV2Es6UuRYDXNmorm7P4PPUc9RTWnSSUqr809xCKekGf2qfiF4IN1pbNvGW8csLNXwfSA9YPWOmDkD1Qt+z9gIKLOxX+nBOtiRAkag+/yg/DYCTFaKV0KD6a4o3jj2uNVepSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674908; c=relaxed/simple;
	bh=V5tFeSy0TFLtpt8bTkJ6tNdpMWVqwaD1C/OqguFoPwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjjkD3TvAdWzsoNliHO1GPLXe+Wql5UtEKn6n5We47iiPNdaiyOWnhO1wCYK0PPyAeq7lOYo4W1K3vIKGcnr3VdPeDGZvJAcaiFKIBM03xtaOc+BZHQWuMmU0xHgJRpxx7sJGVPiU4GJEX8D6VMr5I0hCL9HTn7hJv7pa10N4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a0OR2gNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E99C19421;
	Wed,  8 Apr 2026 19:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674907;
	bh=V5tFeSy0TFLtpt8bTkJ6tNdpMWVqwaD1C/OqguFoPwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0OR2gNzV18LE24ci7xRmSnjYLkBFDd2S4eW4JhzHzJNBCV8yQBFxqFl7GWdVHI0c
	 emihGsPgyyuNM95hqBrGF6BCNB8ZXSvF+6M//gGUIBKqUILJkFlS6kygvNq07gzh84
	 2gbE+K1l/11mVVavNWdi5Gjog4i9pkcN3ZMq9fmM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Yongchao Wu <yongchao.wu@autochips.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.19 246/311] usb: cdns3: gadget: fix state inconsistency on gadget init failure
Date: Wed,  8 Apr 2026 20:04:06 +0200
Message-ID: <20260408175948.577705691@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235231-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,autochips.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 699743C231A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongchao Wu <yongchao.wu@autochips.com>

commit c32f8748d70c8fc77676ad92ed76cede17bf2c48 upstream.

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
---
 drivers/usb/cdns3/cdns3-gadget.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3431,6 +3431,7 @@ static int __cdns3_gadget_init(struct cd
 	ret = cdns3_gadget_start(cdns);
 	if (ret) {
 		pm_runtime_put_sync(cdns->dev);
+		cdns_drd_gadget_off(cdns);
 		return ret;
 	}
 



