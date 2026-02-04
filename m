Return-Path: <stable+bounces-213674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOVjBnJhg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:10:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E76E80E7
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97E24303C294
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687C41C2E1;
	Wed,  4 Feb 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k/Bu8J6j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E927F749;
	Wed,  4 Feb 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217126; cv=none; b=nSGUZmn+pUud33Iu03BWEBhpm08PKS2OMV6wWlgvH2GOw+BwUgOkthvfpSY+J73Pw/X+m+BCvT0ObMIDeqYCA5FinhevcBa3Hc7bN3bgnrQU25lR1UNn9zCOpkpkCpBdI8NLicUu8+cjf643oBBHMLQYQqDZm5C8CMDyHzvTfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217126; c=relaxed/simple;
	bh=iYUCCtz33bRaof6rqf7WXBgzpldJRsVh1BxlD5ZC60o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k835qHgqehiB8njTlDc3XsEqtJJ8HQGdYMc08eDXKarVUufl+jRuCCXoHvsGoTR2y6TL6rJ+Xzohw/pzMHQj+7W3axZCnQszCDO1rhIgxghYBG7ZhAxnw1A0L521sQSXpQB7L2l2aedGh9f1zY+l/hnoGPmYSNoS+CX8OBkFJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k/Bu8J6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F1EC4CEF7;
	Wed,  4 Feb 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217126;
	bh=iYUCCtz33bRaof6rqf7WXBgzpldJRsVh1BxlD5ZC60o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/Bu8J6jTt0FOJIU9UaUJ6KJnjMPH3q+Q0mZmovGA/wqM311bRN/p4B6PIAiJQf6u
	 RX7Ji9Dh0X7ozoTGPYK0gCZGvSEwGqehCHsG6fRY7KefvXzNYKOTjxx101JgU8qNlt
	 Epv8IguCyh/CSDuDh42ctEbXmZnZhnU0VRbb10kw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 098/206] usbnet: limit max_mtu based on devices hard_mtu
Date: Wed,  4 Feb 2026 15:38:49 +0100
Message-ID: <20260204143901.732738564@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213674-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,passt.top:url,gitlab.com:url]
X-Rspamd-Queue-Id: A1E76E80E7
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index aceec2381e802..c4767a729be10 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1797,9 +1797,12 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
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




