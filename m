Return-Path: <stable+bounces-226600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fBYGDauOuWnQKQIAu9opvQ
	(envelope-from <stable+bounces-226600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB0C2AF888
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B5CB3113687
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3A3F54DC;
	Tue, 17 Mar 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UKxTINbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD32F60A7;
	Tue, 17 Mar 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767415; cv=none; b=to2xkri936M6ZDVCSFA6UOKYGPPyb8KTzQYpxyl8qmvFLU8neQQ4hcZlDoNpt+/qQbubqWU3X/gM6uOtXfoNr7nt+I/XyWBM+GGhD4vq0tmyQg01YUaXFWNDVrQY8CBq+KQHeCLscfqHT1gnIoTU7htpncmnY94KyAkf1mILbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767415; c=relaxed/simple;
	bh=G1UfVPWgJXlPN5dPkhybqm6AmbcehoNGzc+CqljBvU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3NxtOTSSMmuZn5KPQ4TikM+Q1VZWIEkeHFgI8SJcV83MUwxD+FWVtCQl4XLNg7VwgYlR6ifp52FOaQM1UUrnPt3WtKKTaR61J2BLRmBfdlz15OwiHlUa1frE5Ze9bwJg811ZT5n6qLMCq4xdAcL1UFktT0gqJoMZl9Gu1m+kJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UKxTINbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBB0C4CEF7;
	Tue, 17 Mar 2026 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767415;
	bh=G1UfVPWgJXlPN5dPkhybqm6AmbcehoNGzc+CqljBvU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKxTINbpNBH2+57J/TJZSqXJQELVXDuS7NX2J6VenEdAQ4sR8/gD5fmtP1b1dyird
	 cu6f2Kyv3ac9FGe2se1FMEm6FlvWLWhzNE8FnuhHD0QIUpO/hFfh8Dzj7ojcMWuyWT
	 eBKOrybPnQhLrFBx2g9jtv8tuSRsCOMXQEKHRcRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Oros <poros@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 082/333] iavf: fix PTP use-after-free during reset
Date: Tue, 17 Mar 2026 17:31:51 +0100
Message-ID: <20260317163002.417674704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226600-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mpg.de:email]
X-Rspamd-Queue-Id: 5BB0C2AF888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Oros <poros@redhat.com>

[ Upstream commit efc54fb13d79117a825fef17364315a58682c7ec ]

Commit 7c01dbfc8a1c5f ("iavf: periodically cache PHC time") introduced a
worker to cache PHC time, but failed to stop it during reset or disable.

This creates a race condition where `iavf_reset_task()` or
`iavf_disable_vf()` free adapter resources (AQ) while the worker is still
running. If the worker triggers `iavf_queue_ptp_cmd()` during teardown, it
accesses freed memory/locks, leading to a crash.

Fix this by calling `iavf_ptp_release()` before tearing down the adapter.
This ensures `ptp_clock_unregister()` synchronously cancels the worker and
cleans up the chardev before the backing resources are destroyed.

Fixes: 7c01dbfc8a1c5f ("iavf: periodically cache PHC time")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 53a0366fbf998..3625c70bc3292 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3040,6 +3040,8 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 
 	adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 
+	iavf_ptp_release(adapter);
+
 	/* We don't use netif_running() because it may be true prior to
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
@@ -3215,6 +3217,8 @@ static void iavf_reset_task(struct work_struct *work)
 	iavf_change_state(adapter, __IAVF_RESETTING);
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
 
+	iavf_ptp_release(adapter);
+
 	/* free the Tx/Rx rings and descriptors, might be better to just
 	 * re-use them sometime in the future
 	 */
-- 
2.51.0




