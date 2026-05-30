Return-Path: <stable+bounces-258969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLBZISMvG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-258969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:40:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A2D6123A0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9265130B4541
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBDA3546F6;
	Sat, 30 May 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqK5tlg2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C0313E34;
	Sat, 30 May 2026 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166153; cv=none; b=F7ckifVw9nyMr+ESHEbRHAb/4kWk0zAQ54Nn/X4k+mgNSDJ4NyHRQC8vbGkRg2f0C4h3uYSrGTv9gFmlZIgNgX6FviE0II0+kCd8DYyGUjDrZGTRv+a7xXWJBA9Bt1VJU5nYa+Fcc3F+6F1iCuLKFsar5JnAHLS/cD1H8qEQkQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166153; c=relaxed/simple;
	bh=sYi4NuOAcoYFjveaJigebvXCYPB8cscBZGuFe/aw3HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uek8DvdqMI1DevlTcYJZoKAkm6C5TWesOGyzTQc8FEl/+0cikP3Vpvbe8T1rgUWhqOtOlr9/Pkw/04wFqTUnsd5VzZk63j7PS8IrdH0SmH5UZsUzCVKFBOKrCEFn3p3hfNGwiAYWXdkJ8Ev5cwHk/JyR2ntH7gkr2VvsAAxM0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jqK5tlg2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596931F00898;
	Sat, 30 May 2026 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166152;
	bh=1qDWmpPsaz19p3zwmL9dexeKFXaQxZ8WVjq/cqvKIps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqK5tlg2X44/EaoJ4x8aJtliecFMC8bB8M/3L8wrhdR6ubjXICKu+0C0hwuw7VkN5
	 X5+qrgvd+F8QqdfwLZkZhO6kx7G0SspFO6eXmyHfjqjZx77l25ZjZSRh4E8Yp2/8PU
	 GKjuO/OjH5MO56bpr1m1RWSHEhslonvd0YvEZxcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Coly Li <colyli@fnnas.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 290/589] bcache: fix uninitialized closure object
Date: Sat, 30 May 2026 18:02:51 +0200
Message-ID: <20260530160232.562896516@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258969-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[easystack.cn:email,kernel.dk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fnnas.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 02A2D6123A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mingzhe Zou <mingzhe.zou@easystack.cn>

commit 20a8e451ec1c7e99060b1bbaaad03ce88c39ddb8 upstream.

In the previous patch ("bcache: fix cached_dev.sb_bio use-after-free and
crash"), we adopted a simple modification suggestion from AI to fix the
use-after-free.

But in actual testing, we found an extreme case where the device is
stopped before calling bch_write_bdev_super().

At this point, struct closure sb_write has not been initialized yet.
For this patch, we ensure that sb_bio has been completed via
sb_write_mutex.

Signed-off-by: Mingzhe Zou <mingzhe.zou@easystack.cn>
Signed-off-by: Coly Li <colyli@fnnas.com>
Link: https://patch.msgid.link/20260403042135.2221247-1-colyli@fnnas.com
Fixes: fec114a98b87 ("bcache: fix cached_dev.sb_bio use-after-free and crash")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/super.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1401,7 +1401,8 @@ static void cached_dev_free(struct closu
 	 * The sb_bio is embedded in struct cached_dev, so we must
 	 * ensure no I/O is in progress.
 	 */
-	closure_sync(&dc->sb_write);
+	down(&dc->sb_write_mutex);
+	up(&dc->sb_write_mutex);
 
 	if (dc->sb_disk)
 		put_page(virt_to_page(dc->sb_disk));



