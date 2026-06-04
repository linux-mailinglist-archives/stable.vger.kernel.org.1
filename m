Return-Path: <stable+bounces-260573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5OuHIgnXIWrhPQEAu9opvQ
	(envelope-from <stable+bounces-260573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 21:50:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9ED643055
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 21:50:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GRjt6TZh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260573-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260573-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC39300D306
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27893C2769;
	Thu,  4 Jun 2026 19:45:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF53C2BAC
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:45:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602306; cv=none; b=mqhsfjNM+4tZEzqepCnAeq1lmsxmGMQ46P+kk3O8AR69hYOxh6TF0JCuLVjzh49ZNmBJhXp+w3FOs3Lv1SkaQ+YSiXGsmAmCuY5W2b8t0MTh+f9fCJppTb0CfOuiylA9h8IUPLQkTGaRoSPRn6C4JQS0o8aKlI2EiLRR7qDgDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602306; c=relaxed/simple;
	bh=/gmoLLMAo/GzhQ22tgCWXKjw1JudXuylbXpEcniuoVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntvElQBQjMuTceUnFDB0De770H50tkzEh05twExEv4WVCD0U1PZnKESBeFXKY148GKbnWVkTqDufOYzRXf/Zbit3Uvln86D0KnkefVLOSikEYWRrsRGxEHMZojnTyfcOZb5LPY3f9aKyGS1A7tkpB7gbzTjAe9qdtkYKRqqgGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRjt6TZh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A9A1F00893;
	Thu,  4 Jun 2026 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602305;
	bh=DCIOFqRh7492p3bRzXXUy3Lb6TkWbrG93PEciHUCx0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRjt6TZhl66lJUgu6SkdUUgv7p+YgcYFEmOUBoPLqwH5wYRNs39Ildu9lTrfI2B7+
	 Y49BZdEqnyY9sxAODo0DTdZgJQqdfFt98aJAiFP5B8fUjTNP0M5OsF1Zi5ncRMJJHY
	 98/Wl2fZSlfzNcIzoIx2iXk4lpbtQLrrwrkliF+bEV6A5m/u6imI3XvT0FTW/jSIvn
	 7h0J1koMjPM6faPux8zNHVpvu2W8YQV+hOIm5MKWiENJShFuCDcNy80cgjH1J7atHH
	 +dORQfDk/tUSl5kv8lJXkgx2cc0Q1/zaARKply0AjLv1esWzmpRYtnLaMhbVvAY8qY
	 UqNqectXOO9ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongchao Wu <yongchao.wu@autochips.com>,
	stable <stable@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: cdns3: gadget: fix request skipping after clearing halt
Date: Thu,  4 Jun 2026 15:45:00 -0400
Message-ID: <20260604194501.920866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060411-untoasted-urologist-7591@gregkh>
References: <2026060411-untoasted-urologist-7591@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260573-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:yongchao.wu@autochips.com,m:stable@kernel.org,m:peter.chen@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA9ED643055

From: Yongchao Wu <yongchao.wu@autochips.com>

[ Upstream commit c8778ff817a7047d6848fefba99dcb27b1bf01fe ]

According to the cdns3 datasheet, the EPRST (Endpoint Reset) command
causes the DMA engine to reposition its internal pointer to the next
Transfer Descriptor (TD) if it was already processing one.

This issue is consistently observed during the ADB identification
process on macOS hosts, where the host issues a Clear_Halt. Although
commit 4bf2dd65135a ("usb: cdns3: gadget: toggle cycle bit before reset
endpoint") attempted to avoid DMA advance by toggling the cycle bit,
trace logs show that on certain hosts like macOS, the DMA pointer
(EP_TRADDR) still shifts after EPRST:

  cdns3_ctrl_req: Clear Endpoint Feature(Halt ep1out)
  cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04030  <-- Should be f9c04000
  cdns3_gadget_giveback: ep1out: req: ... length: 16384/16384

As shown above, the DMA pointer jumped to the next TD, causing
the controller to skip the initial TRBs of the request. This leads to
data misalignment and ADB protocol hangs on macOS.

Fix this by manually restoring the EP_TRADDR register to the starting
physical address of the current request after the EPRST operation is
complete.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Cc: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Yongchao Wu <yongchao.wu@autochips.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260513160012.2547894-1-yongchao.wu@autochips.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/gadget.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 45b5a909e19017..61388e2089f5f7 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2798,9 +2798,19 @@ int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
 	priv_ep->flags &= ~(EP_STALLED | EP_STALL_PENDING);
 
 	if (request) {
-		if (trb)
+		if (trb) {
 			*trb = trb_tmp;
 
+			/*
+			 * Per datasheet, EPRST causes DMA to reposition to the next TD.
+			 * Manually reset EP_TRADDR to the current TRB to prevent
+			 * the hardware from skipping the interrupted request.
+			 */
+			writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma +
+						priv_req->start_trb * TRB_SIZE),
+						&priv_dev->regs->ep_traddr);
+		}
+
 		cdns3_rearm_transfer(priv_ep, 1);
 	}
 
-- 
2.53.0


