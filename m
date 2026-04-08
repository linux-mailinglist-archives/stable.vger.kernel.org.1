Return-Path: <stable+bounces-234264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH7JFwyd1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:23:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5993E3C08F0
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83E523046577
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BDE3D47AC;
	Wed,  8 Apr 2026 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X+0RDUti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858A3D4129;
	Wed,  8 Apr 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672408; cv=none; b=cs5hlUWO/mEntyDtkAfgTzMCF6bNS1vQbS+3m3/GyYfMn3dG8/9y7Kxk2vNN7USk0Yx3QEkEASmw0/PZ1kbOwFnUxZ9lz79hTIYh04O/kqoE+i3wVtwM0PKfR/ZseCR4Hqs+mpyRJoV7UptyK99n55qSmkr3YfDdt3G4PGo3UYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672408; c=relaxed/simple;
	bh=MVKRdno0jnY7CzdP+oiCXWw6iCQFOPA6iGB0Sy8Me1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgguqQ3FPusRxbKcySlWCE0XyTlbfHs5LnmHFJc81YkkcnDn0k5d54+lQpmzzuIkolPQxkFeloDue+CG/PdLv2Ud3a/lJt7+DOcWokX4soHYf/QGfmFGcYVmOO1ZdM1gPaHhJzeyfiwBnVwHb5p6gAz0ewoEkdccURSoJY/Lzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X+0RDUti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F598C19421;
	Wed,  8 Apr 2026 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672408;
	bh=MVKRdno0jnY7CzdP+oiCXWw6iCQFOPA6iGB0Sy8Me1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+0RDUtiZxo4qyl+BmVNlthF3OZQzA/HOKgpPzCAMwLrJnl2HutbO59UMjIE4hFzZ
	 +skWcKARUSukNBtOUQESGNseUiFv/4VYJQx/WR01ivI9wHyPeue9SB5R4XH+JI8LTt
	 lvRVJKkCopfH1PpafoY25KFGOorjB9jOi8Geixu0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 309/312] block: Fix the blk_mq_destroy_queue() documentation
Date: Wed,  8 Apr 2026 20:03:46 +0200
Message-ID: <20260408175945.316627921@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234264-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,grimberg.me:email,acm.org:email,nvidia.com:email,lst.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,kernel.dk:email]
X-Rspamd-Queue-Id: 5993E3C08F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit 81ea42b9c3d61ea34d82d900ed93f4b4851f13b0 upstream.

Commit 2b3f056f72e5 moved a blk_put_queue() call from
blk_mq_destroy_queue() into its callers. Reflect this change in the
documentation block above blk_mq_destroy_queue().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>
Fixes: 2b3f056f72e5 ("blk-mq: move the call to blk_put_queue out of blk_mq_destroy_queue")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230130211233.831613-1-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4175,8 +4175,9 @@ EXPORT_SYMBOL(blk_mq_init_queue);
  * blk_mq_destroy_queue - shutdown a request queue
  * @q: request queue to shutdown
  *
- * This shuts down a request queue allocated by blk_mq_init_queue() and drops
- * the initial reference.  All future requests will failed with -ENODEV.
+ * This shuts down a request queue allocated by blk_mq_init_queue(). All future
+ * requests will be failed with -ENODEV. The caller is responsible for dropping
+ * the reference from blk_mq_init_queue() by calling blk_put_queue().
  *
  * Context: can sleep
  */



