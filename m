Return-Path: <stable+bounces-212520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDoOELoyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:00:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17EA4ECB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97AB4305075D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CA3093C3;
	Wed, 28 Jan 2026 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjJwwdnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A862874FE;
	Wed, 28 Jan 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615793; cv=none; b=qP+nK4ub3Nvw1p1HdalEGG037s9u7754NO5z6fbWwHDamypWFwYQZ3H2ty96Ok2R9dQGSVPcR15rjQ4PCoWcqvQivQub/hAl5wrT4eDfF2g89UDBEFEIc6zTUMFxUljBeKpWqA/5S0rKrmm1V8v5XNZ5wC5FzkjiEvCCZiwsGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615793; c=relaxed/simple;
	bh=XB5eoqvX9b0GesXKkIDvUNiiq5sgGs8ABiuFChLcae0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AitYNNDg+CoZxCr0bhbHfnNKWWFl2q5FfyRuAlMXy69kDAIdl95pSRbIKxbiXOUbTEEHJgmhwsd4opL7fQpbgy+j0xhQl3z15XUjMZyo94nRijhJIStxuzytnW7iPNy92cRfQDgVaupgvXgzYWWmx/ARQmZ2udraGIzM1O5I2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjJwwdnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554D5C4CEF1;
	Wed, 28 Jan 2026 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615792;
	bh=XB5eoqvX9b0GesXKkIDvUNiiq5sgGs8ABiuFChLcae0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjJwwdnjp+ZprDRWhPoC9LoVT7M/sdc7tBFTB9QIsbBRCXs5TWE8rKXHIUZdRAr4J
	 L3ShKiAoH/hlutpHI4THkXZ860DQFs1L1NeAT/S+2Uo+Mhpzg53IhX8DGxdX30pozM
	 ILNHBy0g8Zto/NtmC7sGcFUoI32ZN0vd5sbUTuZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 116/227] usbnet: limit max_mtu based on devices hard_mtu
Date: Wed, 28 Jan 2026 16:22:41 +0100
Message-ID: <20260128145348.639674155@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212520-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[passt.top:query timed out,gitlab.com:query timed out];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[lvivier.redhat.com:query timed out,sbrivio.redhat.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1F17EA4ECB
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Vivier <lvivier@redhat.com>

[ Upstream commit c7159e960f1472a5493ac99aff0086ab1d683594 ]

The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before calling
the device's bind() callback. When the bind() callback sets
dev->hard_mtu based the device's actual capability (from CDC Ethernet's
wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
hardware limitation).

This allows userspace (DHCP or IPv6 RA) to configure MTU larger than the
device can handle, leading to silent packet drops when the backend sends
packet exceeding the device's buffer size.

Fix this by limiting net->max_mtu to the device's hard_mtu after the
bind callback returns.

See https://gitlab.com/qemu-project/qemu/-/issues/3268 and
    https://bugs.passt.top/attachment.cgi?bugid=189

Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC drivers")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Link: https://bugs.passt.top/show_bug.cgi?id=189
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Link: https://patch.msgid.link/20260119075518.2774373-1-lvivier@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/usbnet.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 697cd9d866d3d..ab5ded8f38cf8 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1803,9 +1803,12 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
 			net->flags |= IFF_NOARP;
 
-		/* maybe the remote can't receive an Ethernet MTU */
-		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
-			net->mtu = dev->hard_mtu - net->hard_header_len;
+		if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
+			net->max_mtu = dev->hard_mtu - net->hard_header_len;
+
+		if (net->mtu > net->max_mtu)
+			net->mtu = net->max_mtu;
+
 	} else if (!info->in || !info->out)
 		status = usbnet_get_endpoints (dev, udev);
 	else {
-- 
2.51.0




