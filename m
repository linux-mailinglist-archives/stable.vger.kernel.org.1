Return-Path: <stable+bounces-236283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KETHElAX3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A059B3EE959
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AFD530AF000
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624C82877E5;
	Mon, 13 Apr 2026 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07SxybLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25542283FEF;
	Mon, 13 Apr 2026 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096514; cv=none; b=NezzPx42WgJCryKb2LIH3iIKKUdtSQaEgqmwwzAqELZjSKfTFrRTj+n21IUCCtEGn2GJDGfU+NUbpK6RbLA21yT8yG/eZ/Vkx63N/ROOvqpMY2LNuge9kv3O+ctTqJqMRFF7k/DH242/xIg2IBn+UBRhqwDxEy/R293l7qRd2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096514; c=relaxed/simple;
	bh=5DP4SCV8POB8lQnsyKpZ6CP/nb6gEVAQggftfi8sFS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A656EmJ1Uny/3XUB2UbFAIaCM99DP28WipidUsnbh0jPczUOjpocQqKJPsdPdSSYtKpy3jgTpw+5yBK/s+PMPEu92iTZ/dSnC+K+oU8+Hw4xwpRvKhkm+cAAgXnXpk337fGlCETR303hWz++pbVmtAzkcUFj42K7XH9kcCxii7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=07SxybLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7FAC2BCAF;
	Mon, 13 Apr 2026 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096513;
	bh=5DP4SCV8POB8lQnsyKpZ6CP/nb6gEVAQggftfi8sFS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=07SxybLp3/wOFvSBO/UmGHTsDfDecff5v412WBaS56+y3WDjqqwtZ2UTrjx4zu306
	 hfvw+oEG2X4iGjZK3hH37H2RaKZLxLpQM0YDtgnONRUvK0M3ARm9bIZRqUBfZI4Z4B
	 ybMb7491owCBZHvKId76utfM5VUPDpDf8jJJpBGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	stable@kernel.org
Subject: [PATCH 6.18 39/83] EDAC/mc: Fix error path ordering in edac_mc_alloc()
Date: Mon, 13 Apr 2026 18:00:07 +0200
Message-ID: <20260413155732.475013028@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236283-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,alien8.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A059B3EE959
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

commit 51520e03e70d6c73e33ee7cbe0319767d05764fe upstream.

When the mci->pvt_info allocation in edac_mc_alloc() fails, the error path
will call put_device() which will end up calling the device's release
function.

However, the init ordering is wrong such that device_initialize() happens
*after* the failed allocation and thus the device itself and the release
function pointer are not initialized yet when they're called:

  MCE: In-kernel MCE decoding enabled.
  ------------[ cut here ]------------
  kobject: '(null)': is not initialized, yet kobject_put() is being called.
  WARNING: lib/kobject.c:734 at kobject_put, CPU#22: systemd-udevd
  CPU: 22 UID: 0 PID: 538 Comm: systemd-udevd Not tainted 7.0.0-rc1+ #2 PREEMPT(full)
  RIP: 0010:kobject_put
  Call Trace:
   <TASK>
   edac_mc_alloc+0xbe/0xe0 [edac_core]
   amd64_edac_init+0x7a4/0xff0 [amd64_edac]
   ? __pfx_amd64_edac_init+0x10/0x10 [amd64_edac]
   do_one_initcall
   ...

Reorder the calling sequence so that the device is initialized and thus the
release function pointer is properly set before it can be used.

This was found by Claude while reviewing another EDAC patch.

Fixes: 0bbb265f7089 ("EDAC/mc: Get rid of silly one-shot struct allocation in edac_mc_alloc()")
Reported-by: Claude Code:claude-opus-4.5
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20260331121623.4871-1-bp@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/edac_mc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -370,13 +370,13 @@ struct mem_ctl_info *edac_mc_alloc(unsig
 	if (!mci->layers)
 		goto error;
 
+	mci->dev.release = mci_release;
+	device_initialize(&mci->dev);
+
 	mci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
 	if (!mci->pvt_info)
 		goto error;
 
-	mci->dev.release = mci_release;
-	device_initialize(&mci->dev);
-
 	/* setup index and various internal pointers */
 	mci->mc_idx = mc_num;
 	mci->tot_dimms = tot_dimms;



