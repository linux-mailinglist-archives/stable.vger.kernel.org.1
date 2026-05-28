Return-Path: <stable+bounces-255181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKgaJfydGGpRlggAu9opvQ
	(envelope-from <stable+bounces-255181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:56:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 454ED5F77C1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AF133015892
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370D338936;
	Thu, 28 May 2026 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CfdZgeGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C393290B0;
	Thu, 28 May 2026 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998192; cv=none; b=UZYKtRPEo/b5xLVSKV+mZPOToyH6jTzcU7es+cPsv9gT1ciktcRzcYut2tM6InU1y0fALqiAwT/5vWM3w7laNlcb2uoheAvp/8W7iR9cSx2ret8DnvU6c40aZt69B+L9R/O/uA6YFgCuuZs0xPH7KKMUlfPuHaaxgmB0jxSfgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998192; c=relaxed/simple;
	bh=vfCFXTZSbWVqBdLQec2Hc8wnr4pBJ5IUyt3DPcbERIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVdH56ySJxOMzkRSq6oYjFf9Rr0qfvRVK9Y1xiIhJ+ymQbe1D/DHqIFPLaJxKZWkK+u0zAz0MbFxBjAFvPZJkHrHakeQBNsy6YDxQT+l4TfH8mStCGuNIimxC8P1OMVPbUFKICqTsbVqtwOOEJbxSwAjgKABMoSr5wx7HBOPm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CfdZgeGN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC2E1F000E9;
	Thu, 28 May 2026 19:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998191;
	bh=ZWkpd/yikDma4ZZ2dwVC9C16Wg4VntVe6ylYA3IILTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfdZgeGNwdCOTqcN+5fGiF0sY2qk1S1uvWpTP1FhKO68PxJtC0/msC8wR7q8z7YL+
	 mUqeYRWC1ClBZkRWOEzLhn7qOW9J9pMwmU11VVcOWn5+X+z7A8aZ8WQdXE5rOOilk7
	 5jGTsmVHEmlVggMXntVgs9a+ZBoHieh6cz+muVuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Geetha sowjanya <gakula@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 087/461] octeontx2-pf: fix double free in rvu_rep_rsrc_init()
Date: Thu, 28 May 2026 21:43:36 +0200
Message-ID: <20260528194649.441485111@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255181-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,marvell.com:email,seu.edu.cn:email]
X-Rspamd-Queue-Id: 454ED5F77C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dawei Feng <dawei.feng@seu.edu.cn>

commit e8fb3de2a8effcaf62bec2c56b93d8bb480371d1 upstream.

rvu_rep_rsrc_init() allocates queue memory before calling
otx2_init_hw_resources(). When hardware resource setup fails,
otx2_init_hw_resources() already unwinds the partially initialized
SQ, CQ, and aura state before returning an error. The representor
error path then calls otx2_free_hw_resources() again and can free
the same resources a second time.

Fix this by splitting the cleanup labels so that a failure from
otx2_init_hw_resources() only releases queue memory. Keep the
otx2_free_hw_resources() call for failures that happen after
hardware resource initialization completed successfully.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime validation was not performed because reproducing this path
requires OcteonTX2 representor hardware.

Fixes: 3937b7308d4f ("octeontx2-pf: Create representor netdev")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Geetha sowjanya <gakula@marvell.com>
Link: https://patch.msgid.link/20260513151320.213260-1-dawei.feng@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -609,7 +609,7 @@ static int rvu_rep_rsrc_init(struct otx2
 
 	err = otx2_init_hw_resources(priv);
 	if (err)
-		goto err_free_rsrc;
+		goto err_free_mem;
 
 	/* Set maximum frame size allowed in HW */
 	err = otx2_hw_set_mtu(priv, priv->hw.max_mtu);
@@ -621,6 +621,7 @@ static int rvu_rep_rsrc_init(struct otx2
 
 err_free_rsrc:
 	otx2_free_hw_resources(priv);
+err_free_mem:
 	otx2_free_queue_mem(qset);
 	return err;
 }



