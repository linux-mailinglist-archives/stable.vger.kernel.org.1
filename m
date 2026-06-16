Return-Path: <stable+bounces-264959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UDftHmyAMWoolAUAu9opvQ
	(envelope-from <stable+bounces-264959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:57:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CE96929C5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:57:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ENoNsr4G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264959-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264959-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 335B2303B6E1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E6521C16A;
	Tue, 16 Jun 2026 16:53:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137633A9EB;
	Tue, 16 Jun 2026 16:53:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628790; cv=none; b=cPCOt1On4QLwHjmldK82GHQyxSz09wt7NYIJYX5launpXR5FLgAgp17/pd0BHYmRnIY6HCUUsjvmIhsmuNjYpSxxV4virjci5OsFLLCbAPLEHnDgxEc19nlwhDzdxG/FQULFpsxAPeMCd6R7KtMmvtKm6r00auPMTQ/c/Xtft7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628790; c=relaxed/simple;
	bh=r5Qs0ml6ihJjFaXeRs8/vLI4oNZ7r89dR58DyBvnnUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sosUF28NML+kyEukwvFnZSjeVIJLzh/7gHiOOn8MZ5bcfuhEYJ2ZkyZZQMVjZpPP5OiI+BW6AgI36gxMNjSeMwCNN4pRDRqt0+2iGT5foSVLnLx1likg9NI4d1Avj29in1oFYiBfmOS1EEiRS81K/pgQqrxuT+yTLJFJHfgzvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ENoNsr4G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2EB1F000E9;
	Tue, 16 Jun 2026 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628789;
	bh=fL4D729GY17gTs5kKow+m6tl9Eszjwd84qAIusulwwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ENoNsr4GcIYM/b9d6BbPRDfm39i0J3cfNwRlzN06Sy4gv2azjRe55pvuPdfvee3Pk
	 yp4UfOnaGhBE0cGKhtpj2xtuH2tnQ8e7EjVStLdTDTRmKEiria+Heh2cnZwdnNYrZg
	 Ye2AQnPmAwfuFKUgpA5FIApE9nSThC3HMMtdNgVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.6 163/452] USB: serial: mxuport: fix memory corruption with small endpoint
Date: Tue, 16 Jun 2026 20:26:30 +0530
Message-ID: <20260616145126.362470494@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264959-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrew@lunn.ch,m:johan@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,lunn.ch:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12CE96929C5

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4085f0dbb1ce2251c9a5938d693de6593f0ab2bd upstream.

Make sure that the bulk-out endpoint max packet size is at least eight
bytes to avoid user-controlled slab corruption should a malicious device
report a smaller size.

Fixes: ee467a1f2066 ("USB: serial: add Moxa UPORT 12XX/14XX/16XX driver")
Cc: stable@vger.kernel.org	# 3.14
Cc: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/mxuport.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -962,6 +962,14 @@ static int mxuport_calc_num_ports(struct
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(epds->bulk_out) < 16);
 
+	/*
+	 * The bulk-out buffers must be large enough for the four-byte header
+	 * (and following data), but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	if (usb_endpoint_maxp(epds->bulk_out[0]) < 8)
+		return -EINVAL;
+
 	for (i = 1; i < num_ports; ++i)
 		epds->bulk_out[i] = epds->bulk_out[0];
 



