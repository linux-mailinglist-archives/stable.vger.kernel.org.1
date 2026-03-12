Return-Path: <stable+bounces-225006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IWJOQsfs2mSSQAAu9opvQ
	(envelope-from <stable+bounces-225006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:16:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B4278AF6
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00E7C303B16D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97994287268;
	Thu, 12 Mar 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="maU/IEdF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597682737EE;
	Thu, 12 Mar 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346564; cv=none; b=AFQQaYrAvJSNTZ0wyKUt1SsFG8UB3l/e4LwIyrJ5XCMtiQcsSRf/30LeFJyaMgKfGnhJSJrRLrkx5C/Q7sOLXZShczkGhkVSrS4fsyS3A5ELLLCKN+cpmbH5SDcLGcVnO50z3hnb9Wl5Im7BUMFp/kpcCt//fS8VvRBLZ37B0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346564; c=relaxed/simple;
	bh=6tkUG9WDR1M0AvJCUuVMKKfG8ZQgNcrMSId70AOk9lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbTASsefvy8Y6fxzuJBDSeSaIUYobQVWPOsyXZ3U5plkcKrGoLDiv9oDZd1M6FfDotE0Hi/ctIcswmpSej456sbXccunCPh4JN7HiHAZ2vLuqMT+G13pUYu1udpJj3A2zkmBByRWeUhSzOwRyhu1WUdE1E4moxjoduPxWIFXSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=maU/IEdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A86C4CEF7;
	Thu, 12 Mar 2026 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346564;
	bh=6tkUG9WDR1M0AvJCUuVMKKfG8ZQgNcrMSId70AOk9lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maU/IEdFaKkHg44FJ1JLsEBQ1kFT5kpEl8VO3JeUyk0yuphNrEApkA5rgzKtAdOCO
	 j5d/4k+dJcQq3Huz5MCKO7h86U/T7iKmPLN4/VdJusTKPaJK6gXyaOEdPuBgvADiU4
	 C0WGJsnnEJ8OChaFnENZCD+QV8UE41yz4AMIwDDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joonwon Kang <joonwonkang@google.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 072/265] mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()
Date: Thu, 12 Mar 2026 21:07:39 +0100
Message-ID: <20260312201020.816057175@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-225006-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 979B4278AF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joonwon Kang <joonwonkang@google.com>

[ Upstream commit fcd7f96c783626c07ee3ed75fa3739a8a2052310 ]

Although it is guided that `#mbox-cells` must be at least 1, there are
many instances of `#mbox-cells = <0>;` in the device tree. If that is
the case and the corresponding mailbox controller does not provide
`fw_xlate` and of_xlate` function pointers, `fw_mbox_index_xlate()` will
be used by default and out-of-bounds accesses could occur due to lack of
bounds check in that function.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 892aa0a048e0f..b4d52b814055b 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -504,12 +504,10 @@ EXPORT_SYMBOL_GPL(mbox_free_channel);
 static struct mbox_chan *fw_mbox_index_xlate(struct mbox_controller *mbox,
 					     const struct fwnode_reference_args *sp)
 {
-	int ind = sp->args[0];
-
-	if (ind >= mbox->num_chans)
+	if (sp->nargs < 1 || sp->args[0] >= mbox->num_chans)
 		return ERR_PTR(-EINVAL);
 
-	return &mbox->chans[ind];
+	return &mbox->chans[sp->args[0]];
 }
 
 /**
-- 
2.51.0




