Return-Path: <stable+bounces-236497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wxV7KNgc3WlUaAkAu9opvQ
	(envelope-from <stable+bounces-236497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E652C3EF88A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E65F2319DE6D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029743093CF;
	Mon, 13 Apr 2026 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XXMMmIkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95882F8BC3;
	Mon, 13 Apr 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097054; cv=none; b=Sawyx8/d6AY5/x95PMtSh3Y3O1Uan7Gl4Ir5mPSJMHAfhB2+bSs1Bk4QXoqWaOem/Lz2NPCuKKwBToDePo+9IWu8xrowaG4k3WmgYLYlACYlqyIhrzFIk4+OrC2VbxY4Oln/uCN9sx+AVewG2OyL5/Mz+0Ph0hxQ5zeqi3Mq3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097054; c=relaxed/simple;
	bh=U006km7u3X1SLgUdMwrprAhC0JjUeHlsH2kIqzxMf3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHowd+iU60Fme8wUdW2VJQmCvaVeSfuokEFH43sBRqR3oMubJzXsSm+WPxLRoVXWza/UouY1Wpx8YuGUQu2glfBmsWIBBeq9SU/mfqGVUtALEPsm/FAQzTva6I6S7hupAHQ6YlqwWGHG06MeRzemlw0NgKsTvmgfoyFVQMTquEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XXMMmIkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E20C2BCAF;
	Mon, 13 Apr 2026 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097054;
	bh=U006km7u3X1SLgUdMwrprAhC0JjUeHlsH2kIqzxMf3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXMMmIkXuRw193aVscCNrrvfzdU5BAOiuHU7Uj5tclBnBfaSlZJP3K1i0vxOL19hI
	 mUfsXQc5LHmBO9zdWHkE3aNbFE2++7oKg8ZwJLSgCavbz2Sv/lga2goiavnKv7oAit
	 hG1XRhY6iGNelZJlWhrhlw3Tj5Q69zMW1D13TsXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	stable@kernel.org
Subject: [PATCH 6.1 44/55] EDAC/mc: Fix error path ordering in edac_mc_alloc()
Date: Mon, 13 Apr 2026 18:01:18 +0200
Message-ID: <20260413155726.476645559@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236497-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,alien8.de:email]
X-Rspamd-Queue-Id: E652C3EF88A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -369,13 +369,13 @@ struct mem_ctl_info *edac_mc_alloc(unsig
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



