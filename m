Return-Path: <stable+bounces-226220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NzfIDOGuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:49:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129882AE7FD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2426731255D8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD653ED5C7;
	Tue, 17 Mar 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MqjF8kTg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC453EC2F7;
	Tue, 17 Mar 2026 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765769; cv=none; b=nHLjPeLsX+Y11IfyEvlRCib9IBkMI0PT0OKhEZ5ed0zfpcNY3rroU90t1Q0MFFFar//JQDeVkc76QBAI+7qBuUdXRXM3uJOuLazhZ50MNjJ+WLt3f/birEPlROJWvUg3rv47nt/4qRN+zof5RlIR+AYvDmjDSeacyP1ZeoJdgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765769; c=relaxed/simple;
	bh=ond3atuvWelPXWx4OpNxbkcW07yHFjVC5ynuOwKfiN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWGlpPxvI5+PI9pF4knTGUTxR/eSX1NBHvravwHpfxEqv9QPqaDnLcOmVZfkfFGt3Xs/eDdAKkFrvtIuF0TITTvtewcaDN6q/gSuR1vZRnykWVg3evcWLk5Z8iZnmlWzO19SSMME7sO2QmM0I+FzMAXYy6HNjUJLSnY1AFZ+ydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MqjF8kTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF7CC4CEF7;
	Tue, 17 Mar 2026 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765768;
	bh=ond3atuvWelPXWx4OpNxbkcW07yHFjVC5ynuOwKfiN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqjF8kTgjAr4MUCyK/cQtI0ywyMu2J0pe+Z3HNEagsi+7I5um7k2LFJPQcFHQ8GMr
	 /9aIwURuJ6KIG9gATH15uuV1XkW8DC3b9Z6VXUCn1aN2yjFjvhDusPLlPVJcXzxlP2
	 35uNi45cGmb4TLidhDgXkDRCxQwWuVPGnd0Z5T+4=
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
Subject: [PATCH 6.19 089/378] iavf: fix PTP use-after-free during reset
Date: Tue, 17 Mar 2026 17:30:46 +0100
Message-ID: <20260317163010.291196848@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-226220-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 129882AE7FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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




