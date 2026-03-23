Return-Path: <stable+bounces-228542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLolAnVQwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:38:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 967502F4EA1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDE2B311C8C1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AEC1FFC48;
	Mon, 23 Mar 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z/yROvu2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F9222590;
	Mon, 23 Mar 2026 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275406; cv=none; b=ZuQLFqRhTvnCabpL+p5uLVmp91GSQxZI+zg5/kj0fmZ+wsXSUXpq8xfxf3b25WdekReqFTwtsuXtPPH1hKConF5FllSVXg6OiLdcpOHwdCQHL8FX8vAblmceB/zj2NV4ugQmupdlRMYcWC6JWTFduHgsMPeIFNBbRWm2HW7bASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275406; c=relaxed/simple;
	bh=bWpnDb0QFH68yutdGitYm/hbu0R4t66050tJ8hL+XJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMs98/smMiCVixB8ZvSRnRVVIY5ZBWnCEApmkslIjrgYwU3W7tBA24o9kasjDQXyAGTlqbM9N6M+x6aco9L5/6Z/4JoZuyQm/9/uEUkIVbkffpTtXVlh+QdC91+FwTm2lVNh/8vX8oJc6DYHkAcmyt++o6d5A4hXVccNBub8bpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/yROvu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49695C4CEF7;
	Mon, 23 Mar 2026 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275406;
	bh=bWpnDb0QFH68yutdGitYm/hbu0R4t66050tJ8hL+XJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/yROvu2tbmyyqeDPzO3nEjm2IAosNVQ9vym44dialTk6R7l153GdoGVUIEurW6UG
	 RyJJ9h+OabYBJiKJxqmcmLmagGqjeuC1K+HAMK7muIaYQKtPpH8/GOYZyjVlGF+Jp7
	 NmJqFzi7paMrj+j4HB0pxS/sl1KTMlZjYHUlChVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Seungjin Bae <eeodqql09@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 087/460] usb: gadget: f_mass_storage: Fix potential integer overflow in check_command_size_in_blocks()
Date: Mon, 23 Mar 2026 14:41:23 +0100
Message-ID: <20260323134528.810532383@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228542-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,rowland.harvard.edu,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 967502F4EA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seungjin Bae <eeodqql09@gmail.com>

[ Upstream commit 8479891d1f04a8ce55366fe4ca361ccdb96f02e1 ]

The `check_command_size_in_blocks()` function calculates the data size
in bytes by left shifting `common->data_size_from_cmnd` by the block
size (`common->curlun->blkbits`). However, it does not validate whether
this shift operation will cause an integer overflow.

Initially, the block size is set up in `fsg_lun_open()` , and the
`common->data_size_from_cmnd` is set up in `do_scsi_command()`. During
initialization, there is no integer overflow check for the interaction
between two variables.

So if a malicious USB host sends a SCSI READ or WRITE command
requesting a large amount of data (`common->data_size_from_cmnd`), the
left shift operation can wrap around. This results in a truncated data
size, which can bypass boundary checks and potentially lead to memory
corruption or out-of-bounds accesses.

Fix this by using the check_shl_overflow() macro to safely perform the
shift and catch any overflows.

Fixes: 144974e7f9e3 ("usb: gadget: mass_storage: support multi-luns with different logic block size")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260228104324.1696455-2-eeodqql09@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_mass_storage.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 08e0d1c511e8d..74cb7e57a197c 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -180,6 +180,7 @@
 #include <linux/kthread.h>
 #include <linux/sched/signal.h>
 #include <linux/limits.h>
+#include <linux/overflow.h>
 #include <linux/pagemap.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
@@ -1853,8 +1854,15 @@ static int check_command_size_in_blocks(struct fsg_common *common,
 		int cmnd_size, enum data_direction data_dir,
 		unsigned int mask, int needs_medium, const char *name)
 {
-	if (common->curlun)
-		common->data_size_from_cmnd <<= common->curlun->blkbits;
+	if (common->curlun) {
+		if (check_shl_overflow(common->data_size_from_cmnd,
+				       common->curlun->blkbits,
+				       &common->data_size_from_cmnd)) {
+			common->phase_error = 1;
+			return -EINVAL;
+		}
+	}
+
 	return check_command(common, cmnd_size, data_dir,
 			mask, needs_medium, name);
 }
-- 
2.51.0




