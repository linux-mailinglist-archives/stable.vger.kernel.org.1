Return-Path: <stable+bounces-224066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MImWHpL+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811B24A735
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FBA93203F03
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0558A381AF8;
	Tue, 10 Mar 2026 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfy2F6TD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE56386C02;
	Tue, 10 Mar 2026 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141200; cv=none; b=kr7ryvrluE1x+ZdtEMgMygfwvFk09LhWmQ8dkL6l9VW3SnySUdJBYLlBJgIUb4uyAoKuX5wqv8/48O5Sw2EbBAtdUiZdqfo7DovX0TeOC+FN8ZY3O6S27dr7tKmatUFyxjmjWBteeZL48MmhohVb9xQX8VVW4NNHY30ilwO4Ug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141200; c=relaxed/simple;
	bh=ZZ/3gYuyMFwSvkFWJTL8qNyg/is8CcZLHXlWeF0H1zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8O2v0mgff1oX2TTRn0G4h3pXY5JXbS66BdOkXsPeNaBQuUQdxcT8NZwortmySq9PxXuCXvKldxykJP0bGhXGln1T+dSacJfGya5dUgeAVXmr1P2nM8BsZoLcPp6ry3ZANkAFHfMrxDDC67qPdU/4TwLJkvQrrST3EXlnxm6oGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfy2F6TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1864C2BC86;
	Tue, 10 Mar 2026 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141200;
	bh=ZZ/3gYuyMFwSvkFWJTL8qNyg/is8CcZLHXlWeF0H1zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gfy2F6TD0Iq0p0tvwFMGKqINi82mRbAAQfZ1glVVg+QDfPeOaJbwgqTBa2YPfoFDY
	 ca/tJoNM3mFHaosZPI/VZSuizpxQORt3JqL1YBLH0Ee+dj6wHU7iLzWvJTaUvRZ2mA
	 DWxJWrl+W/Dp0Cp3t5lqb41Bb31SrxAt91vJxSDVqwKv7PxNFIasiSNZE/zs55OS6Z
	 hlksvUs43k42LsrXB0Yb7FHAGWMhs8HZk0dOX4i0RPDv1KPA26jk6qItz82FSTKs08
	 GXmmbysPLAFgobOfv2u6eEuj48VqfvYLQzpFubtgsvX9TM2bZtiey1RnPjLlw/m/5p
	 GWGZmG83AZLZw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Justin Tee <justintee8345@gmail.com>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Aristeu Rozanski <aris@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 201/311] nvmet-fcloop: Check remoteport port_state before calling done callback
Date: Tue, 10 Mar 2026 07:04:08 -0400
Message-ID: <eddf39bedc21b82867af340902f92bd9db630a35.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0811B24A735
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224066-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

From: Justin Tee <justintee8345@gmail.com>

[ Upstream commit dd677d0598387ea623820ab2bd0e029c377445a3 ]

In nvme_fc_handle_ls_rqst_work, the lsrsp->done callback is only set when
remoteport->port_state is FC_OBJSTATE_ONLINE.  Otherwise, the
nvme_fc_xmt_ls_rsp's LLDD call to lport->ops->xmt_ls_rsp is expected to
fail and the nvme-fc transport layer itself will directly call
nvme_fc_xmt_ls_rsp_free instead of relying on LLDD's done callback to free
the lsrsp resources.

Update the fcloop_t2h_xmt_ls_rsp routine to check remoteport->port_state.
If online, then lsrsp->done callback will free the lsrsp.  Else, return
-ENODEV to signal the nvme-fc transport to handle freeing lsrsp.

Cc: Ewan D. Milne <emilne@redhat.com>
Tested-by: Aristeu Rozanski <aris@redhat.com>
Acked-by: Aristeu Rozanski <aris@redhat.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Closes: https://lore.kernel.org/linux-nvme/21255200-a271-4fa0-b099-97755c8acd4c@work/
Fixes: 10c165af35d2 ("nvmet-fcloop: call done callback even when remote port is gone")
Signed-off-by: Justin Tee <justintee8345@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fcloop.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c30e9a3e014fb..38bd2db3d6bbe 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -491,6 +491,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	struct fcloop_rport *rport = remoteport->private;
 	struct nvmet_fc_target_port *targetport = rport->targetport;
 	struct fcloop_tport *tport;
+	int ret = 0;
 
 	if (!targetport) {
 		/*
@@ -500,12 +501,18 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 		 * We end up here from delete association exchange:
 		 * nvmet_fc_xmt_disconnect_assoc sends an async request.
 		 *
-		 * Return success because this is what LLDDs do; silently
-		 * drop the response.
+		 * Return success when remoteport is still online because this
+		 * is what LLDDs do and silently drop the response.  Otherwise,
+		 * return with error to signal upper layer to perform the lsrsp
+		 * resource cleanup.
 		 */
-		lsrsp->done(lsrsp);
+		if (remoteport->port_state == FC_OBJSTATE_ONLINE)
+			lsrsp->done(lsrsp);
+		else
+			ret = -ENODEV;
+
 		kmem_cache_free(lsreq_cache, tls_req);
-		return 0;
+		return ret;
 	}
 
 	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
-- 
2.51.0


