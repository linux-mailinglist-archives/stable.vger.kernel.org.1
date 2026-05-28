Return-Path: <stable+bounces-255718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDQlDWmnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D01AB5F91D2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D14D31F385B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFF3002A0;
	Thu, 28 May 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSsw0sfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0752D9787;
	Thu, 28 May 2026 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999692; cv=none; b=NZ5WJpBbHKCdgPe+IcDWeAERiYAYuvCnn+QXZk3ui3KbHISKfykqe+aWZIEdNJ4B+dbUKek9FCAWWCG3v83uWmJhf6Q93ywnyzfxN+f7hVoyohmLqY/NnFytVeR12WTuPlTV2GsQnIws9h8xmMZOAo1/Kuelyek3IBfRguZX1bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999692; c=relaxed/simple;
	bh=pkFwuhYbiBh8jel/BissMVn79akhL0O5xqKUmLR+u6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcFHCDTtGJO4KLGkICUOiUZulbIzH7I0UeUK3Xa5Hg4XEVwjHx8YTMTsUH61+t3vC6K9TiZ/lS81hrzJMBzPNB8HhaY6t42iD/JxufCl/CGlpUPqCYlYQuFNzfas3AtoSQ9d7quwCEyRr7kKwBry2ZP6dlphcTQBNCmMqH1ndN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSsw0sfb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392F11F000E9;
	Thu, 28 May 2026 20:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999691;
	bh=oOPbVtMzUEfZ1AsyF+5D7ndNsVlQjMRxnngA8CCCDPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSsw0sfb2Yzy84AXz8k31NeGmIn6dlvGVght8xXjyXh+HI3R30nFvf2IKLOWzu1YJ
	 NUnIZFRRCn67evN7r8aEKSiqwdEm1iqvZmIaV2KVQkLuOdrq+2r9g009N7auaLPK5G
	 Sdlk8hvALmXks0QcmlOQ/A5Oz/4WuLQU0LmEeXsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vignesh R <vigneshr@ti.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 121/377] spi: ti-qspi: fix use-after-free after DMA setup failure
Date: Thu, 28 May 2026 21:45:59 +0200
Message-ID: <20260528194641.844441572@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255718-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D01AB5F91D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit ea6ec3343e05f7937a53eb6d7617b3abdb4abc19 upstream.

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to clear the DMA channel pointer also if buffer allocation
fails to avoid passing a pointer to the released channel to the DMA
engine (or trying to free the channel a second time on late probe errors
or driver unbind).

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: c687c46e9e45 ("spi: spi-ti-qspi: Use bounce buffer if read buffer is not DMA'ble")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=17
Cc: stable@vger.kernel.org	# 4.12
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260512074809.915084-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-ti-qspi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -868,6 +868,7 @@ static int ti_qspi_probe(struct platform
 		dev_err(qspi->dev,
 			"dma_alloc_coherent failed, using PIO mode\n");
 		dma_release_channel(qspi->rx_chan);
+		qspi->rx_chan = NULL;
 		goto no_dma;
 	}
 	host->dma_rx = qspi->rx_chan;



