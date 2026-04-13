Return-Path: <stable+bounces-236984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL9NJK8i3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-236984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1A3F0C4C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9088E31B52E9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2982230EF80;
	Mon, 13 Apr 2026 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ami/oDgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD4311C2D;
	Mon, 13 Apr 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098293; cv=none; b=sMBPvRR0UVybAx8UzNoMHFNFMvC5TkrAEgoxKTSIQn6BTSy6LOrnS28FBVRLBc+1jzuZ1pR/R+cysN+r+TizlsMw4g5Osh1lI959w8xc6hIMw4v1aOOepAVs6fDBRyW1nRmveLWiNvM0oRFcMsZ7OgG2OZ1dYagtwOSIcMKVvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098293; c=relaxed/simple;
	bh=xOjJIs7L1ItAK0LzeUZUcND3QSHWFCyQtuDfXSiJkUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ9W8aDHurjsGmpwF7GVA2UasXorra4ApZs30lO+bTBpmY2tl1sAYSqWcuAFTHT74QiuF9RM+yKj0iZWhel2txg8hNoJADReM8BVNHYF1dulsf5glDBNk621BJmJ6XEabb9zSpgAAB19IuXc8E/E4dz/auDdsDekLuCcjLjU+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ami/oDgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7901DC2BCAF;
	Mon, 13 Apr 2026 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098292;
	bh=xOjJIs7L1ItAK0LzeUZUcND3QSHWFCyQtuDfXSiJkUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ami/oDgEgWwEWd3zZkjkfUYW8sbest3mvCBvNamaidSN8y2kEOA/M9tEZueC77CWF
	 d9HeTadyZdxRzI4XqjBq9cn1hPWVuVmrXPo30ZFWplZ5FLmK/w2GdGqXIEBgcymGFQ
	 2BgApwU47Y5mfQXyZmNWmZQ0qwR74Tey1b+akReM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.15 467/570] usb: ulpi: fix double free in ulpi_register_interface() error path
Date: Mon, 13 Apr 2026 17:59:58 +0200
Message-ID: <20260413155847.959819022@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236984-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,linux.intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: DED1A3F0C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangshuo Li <lgs201920130244@gmail.com>

commit 01af542392b5d41fd659d487015a71f627accce3 upstream.

When device_register() fails, ulpi_register() calls put_device() on
ulpi->dev.

The device release callback ulpi_dev_release() drops the OF node
reference and frees ulpi, but the current error path in
ulpi_register_interface() then calls kfree(ulpi) again, causing a
double free.

Let put_device() handle the cleanup through ulpi_dev_release() and
avoid freeing ulpi again in ulpi_register_interface().

Fixes: 289fcff4bcdb1 ("usb: add bus type for USB ULPI")
Cc: stable <stable@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260401025142.1398996-1-lgs201920130244@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/common/ulpi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -286,10 +286,9 @@ struct ulpi *ulpi_register_interface(str
 	ulpi->ops = ops;
 
 	ret = ulpi_register(dev, ulpi);
-	if (ret) {
-		kfree(ulpi);
+	if (ret)
 		return ERR_PTR(ret);
-	}
+
 
 	return ulpi;
 }



