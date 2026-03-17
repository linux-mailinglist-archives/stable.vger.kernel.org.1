Return-Path: <stable+bounces-226810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLVIIJOVuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:55:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D52B05AA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51087339D005
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD07280A21;
	Tue, 17 Mar 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QYlG8z3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256E31E841;
	Tue, 17 Mar 2026 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768284; cv=none; b=Za+UcZfn64oM24nij/G2lfJVqeoKQkkZarjXm4RPxjOfs3ItmZQfg757oe6fHIHrXKJ3fVbC7vNn7jgie/WyCXvu8NO+UdvgEWwg4fZ6Dka2O1UFwBdbaj65CDiQ4LhoL4dLMplr/q8ZaLCaqehyQXWC75kQDohdpJ+ZDL5lfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768284; c=relaxed/simple;
	bh=zreThYR8sa6sophSv2uuD4IT9Wu29+IXS2blv1ET2bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzF9wXDz9pTkhdCpYJQwIWPKYlllKdbOEdLOK6NJg4PQNXEEvq+Ne37SUYUH+k2Nyk1MGOUURuXUGnEdxRiZZMaW6hlZLNm1QyDeMTal0LEXOOJ7L+uyz76cNgJkMZAhBn2exEWDNd2UpfnPhuUcerZ4NNWiIeOjQkX3QurvduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QYlG8z3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB02C4CEF7;
	Tue, 17 Mar 2026 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768283;
	bh=zreThYR8sa6sophSv2uuD4IT9Wu29+IXS2blv1ET2bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYlG8z3WIx7Z/gcKO5PIeN/ef93HtshqGKICFpbDrHQWKDH9QQ5DiiI+o6iysDvtq
	 6BogjN51wPXSjmlL3YA3IhBUs1a30oFlpq+ptxLg/7FCjR2gUw92YBqKRjQPZdPqZg
	 cImZZbzVU9/hyX33tRzt+heu1pZYlCL0NPQmZ87o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Eduard Shishkin <edward6@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 274/333] s390/dasd: Copy detected format information to secondary device
Date: Tue, 17 Mar 2026 17:35:03 +0100
Message-ID: <20260317163009.557740177@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226810-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,kernel.dk:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D36D52B05AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.ibm.com>

commit 4c527c7e030672efd788d0806d7a68972a7ba3c1 upstream.

During online processing for a DASD device an IO operation is started to
determine the format of the device. CDL format contains specifically
sized blocks at the beginning of the disk.

For a PPRC secondary device no real IO operation is possible therefore
this IO request can not be started and this step is skipped for online
processing of secondary devices. This is generally fine since the
secondary is a copy of the primary device.

In case of an additional partition detection that is run after a swap
operation the format information is needed to properly drive partition
detection IO.

Currently the information is not passed leading to IO errors during
partition detection and a wrongly detected partition table which in turn
might lead to data corruption on the disk with the wrong partition table.

Fix by passing the format information from primary to secondary device.

Fixes: 413862caad6f ("s390/dasd: add copy pair swap capability")
Cc: stable@vger.kernel.org #6.1
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Acked-by: Eduard Shishkin <edward6@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://patch.msgid.link/20260310142330.4080106-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_eckd.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6146,6 +6146,7 @@ static void copy_pair_set_active(struct
 static int dasd_eckd_copy_pair_swap(struct dasd_device *device, char *prim_busid,
 				    char *sec_busid)
 {
+	struct dasd_eckd_private *prim_priv, *sec_priv;
 	struct dasd_device *primary, *secondary;
 	struct dasd_copy_relation *copy;
 	struct dasd_block *block;
@@ -6166,6 +6167,9 @@ static int dasd_eckd_copy_pair_swap(stru
 	if (!secondary)
 		return DASD_COPYPAIRSWAP_SECONDARY;
 
+	prim_priv = primary->private;
+	sec_priv = secondary->private;
+
 	/*
 	 * usually the device should be quiesced for swap
 	 * for paranoia stop device and requeue requests again
@@ -6198,6 +6202,13 @@ static int dasd_eckd_copy_pair_swap(stru
 		dasd_device_remove_stop_bits(primary, DASD_STOPPED_QUIESCE);
 	}
 
+	/*
+	 * The secondary device never got through format detection, but since it
+	 * is a copy of the primary device, the format is exactly the same;
+	 * therefore, the detected layout can simply be copied.
+	 */
+	sec_priv->uses_cdl = prim_priv->uses_cdl;
+
 	/* re-enable device */
 	dasd_device_remove_stop_bits(primary, DASD_STOPPED_PPRC);
 	dasd_device_remove_stop_bits(secondary, DASD_STOPPED_PPRC);



