Return-Path: <stable+bounces-234912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNwMOKSo1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:12:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439BD3C28F9
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B7AA3117AD5
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6E33D8918;
	Wed,  8 Apr 2026 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uKzte96o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2343624B2;
	Wed,  8 Apr 2026 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674084; cv=none; b=ImtkXEobCn1ugacf4OpNVkLHNapq8Zx1DdHWtAqmRkJd9lJiaJ2ulvIH4c07F+KS4D53C17Kw7OkamP1LYe5rtQF1G/DRE+EgZ+6iJICyC3SffxEDCOuiNwPmpbWs3xOpBK2pjmZtv2ayTZGa3jqfTUiMbrQr+z3B5gUq2xxvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674084; c=relaxed/simple;
	bh=M2Onc25iO+4/rV73H0QVcGdmvUkcDFF2oTyS+4cbAzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRsq1jpcxjbBCb2/BijDNS5ZDHxwiCaStAMZ1CMsjGnpveyPC6atSc8PoQg8nh2htva0ws+aAaQ+V2NYxHtsOVvIlSAoXIBF8DsAQ+DVNjmt995uux8W2BFp1Mb97MjsL7kG1D+AZAgXCX4NuCs54KvQkJN0Cs3ioL84lOQsCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uKzte96o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226E2C19425;
	Wed,  8 Apr 2026 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674084;
	bh=M2Onc25iO+4/rV73H0QVcGdmvUkcDFF2oTyS+4cbAzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKzte96ow+lhiL5DCItIIK3vrjFoOFFPlV+G8scBzltUmqxU21Z0Oalo/eVboM7D4
	 hT1e7AlluKcz6RfnsxAIgMi/mjlqLC3zPSRSmhZVMRLIpXL1orE4rlIzRNSuV/mEZI
	 1A6MgoNa/ggJBI0A1iyniAl7ymOOdZR7GKEyU3/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Val Packett <val@packett.cool>,
	stable <stable@kernel.org>,
	Kuen-Han Tsai <khtsai@google.com>
Subject: [PATCH 6.12 202/242] usb: gadget: u_ether: Fix NULL pointer deref in eth_get_drvinfo
Date: Wed,  8 Apr 2026 20:04:02 +0200
Message-ID: <20260408175934.641809909@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234912-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,packett.cool:email]
X-Rspamd-Queue-Id: 439BD3C28F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuen-Han Tsai <khtsai@google.com>

commit e002e92e88e12457373ed096b18716d97e7bbb20 upstream.

Commit ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with
device_move") reparents the gadget device to /sys/devices/virtual during
unbind, clearing the gadget pointer. If the userspace tool queries on
the surviving interface during this detached window, this leads to a
NULL pointer dereference.

Unable to handle kernel NULL pointer dereference
Call trace:
 eth_get_drvinfo+0x50/0x90
 ethtool_get_drvinfo+0x5c/0x1f0
 __dev_ethtool+0xaec/0x1fe0
 dev_ethtool+0x134/0x2e0
 dev_ioctl+0x338/0x560

Add a NULL check for dev->gadget in eth_get_drvinfo(). When detached,
skip copying the fw_version and bus_info strings, which is natively
handled by ethtool_get_drvinfo for empty strings.

Suggested-by: Val Packett <val@packett.cool>
Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/linux-usb/10890524-cf83-4a71-b879-93e2b2cc1fcc@packett.cool/
Fixes: ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with device_move")
Cc: stable <stable@kernel.org>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260316-eth-null-deref-v1-1-07005f33be85@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_ether.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -112,8 +112,10 @@ static void eth_get_drvinfo(struct net_d
 
 	strscpy(p->driver, "g_ether", sizeof(p->driver));
 	strscpy(p->version, UETH__VERSION, sizeof(p->version));
-	strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
-	strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
+	if (dev->gadget) {
+		strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
+		strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
+	}
 }
 
 /* REVISIT can also support:



