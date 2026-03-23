Return-Path: <stable+bounces-229391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIufBedgwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:48:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A602F6F5B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64ADA3065262
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CF23BF66A;
	Mon, 23 Mar 2026 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/qTpTOV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97292275AF5;
	Mon, 23 Mar 2026 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278967; cv=none; b=DX5x+CTYp/cpZGgK2i5DfC39yfvBourkh46AJ0PfiXORzgXVponEBO6cyn0mDEG9q7NQXFhB0f7qnmM8XRV5x0xLua/QFfjAoMdD1XyRwkq5jiZ0kpRQro0IkI9lV71r5o4tr8h0oyjSV75l/tpwjEYKEwtZPWn3VdddhAf6Gss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278967; c=relaxed/simple;
	bh=/RIkYjeJ2H7HHXR2824IcBGScQxj3k9UrT7z6dsEYu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPSAmhqRIuK3lIqAllPSrH3IQs6B2458ui8v3GhfiVOEDptgQR1LeoStW3vJdXQdEfmvvRsbc6glzjbic4Ps3y6aBNV/MSZtQt3g4PgFYDRvh2t2T+n60vUTSULNI7y6OjePKhtJJaMDBq+f8dQJiHj+Jt2u1xgoANSP9AX5Ngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/qTpTOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC35C2BC9E;
	Mon, 23 Mar 2026 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278967;
	bh=/RIkYjeJ2H7HHXR2824IcBGScQxj3k9UrT7z6dsEYu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/qTpTOVcgs4NB8PvhlbTdQ6RnkaCUEeOLpgpib3PomEcRAmg4N0DRJ47S2nduNDf
	 1KiUew7FjWtQXs189IpCVpzbEnvt/9ImHonpNndY9CLEMycGXV4NJPCsSYTwBvKsak
	 8bMGnLNN+l4Y5SEZyxpv5qiYDpk8glLwEOdmzb0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Jander <david@protonic.nl>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 477/567] spi: fix use-after-free on controller registration failure
Date: Mon, 23 Mar 2026 14:46:37 +0100
Message-ID: <20260323134545.782843827@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229391-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,protonic.nl:email]
X-Rspamd-Queue-Id: 12A602F6F5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 8634e05b08ead636e926022f4a98416e13440df9 upstream.

Make sure to deregister from driver core also in the unlikely event that
per-cpu statistics allocation fails during controller registration to
avoid use-after-free (of driver resources) and unclocked register
accesses.

Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
Cc: stable@vger.kernel.org	# 6.0
Cc: David Jander <david@protonic.nl>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260312151817.32100-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3213,10 +3213,8 @@ int spi_register_controller(struct spi_c
 		dev_info(dev, "controller is unqueued, this is deprecated\n");
 	} else if (ctlr->transfer_one || ctlr->transfer_one_message) {
 		status = spi_controller_initialize_queue(ctlr);
-		if (status) {
-			device_del(&ctlr->dev);
-			goto free_bus_id;
-		}
+		if (status)
+			goto del_ctrl;
 	}
 	/* Add statistics */
 	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(dev);
@@ -3239,6 +3237,8 @@ int spi_register_controller(struct spi_c
 
 destroy_queue:
 	spi_destroy_queue(ctlr);
+del_ctrl:
+	device_del(&ctlr->dev);
 free_bus_id:
 	mutex_lock(&board_lock);
 	idr_remove(&spi_master_idr, ctlr->bus_num);



