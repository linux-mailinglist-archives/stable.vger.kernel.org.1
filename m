Return-Path: <stable+bounces-229279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKJIBC5ewWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:37:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670222F6938
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37894316FFD5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838F3B4E9A;
	Mon, 23 Mar 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i4OEd/Js"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F62773C3;
	Mon, 23 Mar 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278619; cv=none; b=PGIG+J9Iy3oqKGvARcTuKaYwqXMLSVnfFcpQtneJ/omB6qRR+TcYTLfM1r5EekfULBpXk9Owem0TPhPkGL9NB/MDIWRsFs0YdoQJ4UixSv8a2HaK6TLB2dhNW74a7V7uWOxYPKLcAT58c3Bv/IaCQC6MnYQqxw9b02yFRAV98pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278619; c=relaxed/simple;
	bh=yFRsDeE44w5xi+s3sl+7wrpf0JV6QieOJ8tEf1+flwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyu27bqsolzL8wxXic1+2G39s95WuqHSnHxk9y0/aBP/cx7hC+XGesbtcn8TLq+pwC5xorf9XkoDBOb7okKezqIOh8dce98GJIDkeOIfXPbk2ccDokgTEsyukPgUgFHSJuOL7XYoRR8sliHoTx5hoDPKPCi8+HFYij79L2EN1Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i4OEd/Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EACC4CEF7;
	Mon, 23 Mar 2026 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278619;
	bh=yFRsDeE44w5xi+s3sl+7wrpf0JV6QieOJ8tEf1+flwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4OEd/JsLLZKrj+MJygjBs5KLOp9B8PPa0ueXMBHY8KjKGmX3uvCe5q+w1GG6IXqx
	 RtCar4zF8YTx9ct6EF0g7I0HytvDQEQmK02TqSL/8IpHiJm6/QcHzNWW60TDkKuonx
	 pc8lQEaWNGAO5AXCsk8oTh7KY1Y6B3RZ82tJGqfI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.6 363/567] i3c: mipi-i3c-hci: Restart DMA ring correctly after dequeue abort
Date: Mon, 23 Mar 2026 14:44:43 +0100
Message-ID: <20260323134542.805055152@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229279-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 670222F6938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit b6d586431ae20d5157ee468d0ef62ad26798ef13 upstream.

The DMA dequeue path attempts to restart the ring after aborting an
in-flight transfer, but the current sequence is incomplete. The controller
must be brought out of the aborted state and the ring control registers
must be programmed in the correct order: first clearing ABORT, then
re-enabling the ring and asserting RUN_STOP to resume operation.

Add the missing controller resume step and update the ring control writes
so that the ring is restarted using the proper sequence.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-11-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -491,7 +491,9 @@ static bool hci_dma_dequeue_xfer(struct
 	}
 
 	/* restart the ring */
+	mipi_i3c_hci_resume(hci);
 	rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE);
+	rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE | RING_CTRL_RUN_STOP);
 
 	return did_unqueue;
 }



