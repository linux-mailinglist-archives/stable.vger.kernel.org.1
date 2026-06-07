Return-Path: <stable+bounces-260989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UopZKrtDJWpwFQIAu9opvQ
	(envelope-from <stable+bounces-260989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0590D64F61B
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=w6PuUBiR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260989-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260989-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6BF3040AB1
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388F2E3709;
	Sun,  7 Jun 2026 10:08:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DB1DE8AE;
	Sun,  7 Jun 2026 10:08:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826884; cv=none; b=sWPxX/1uFVqHUEDH47rM6GgU9x99PjNTN0Zi0CYdnlteWQIeBxfv9cLJgkVQuc6lt1rJRlAbIZB/QmguwpeGjwYum2h38rReBypLWsH7mI+IE2c2BqmLNVzKQWNX4vFTuyl8mLctJTrnWbOnRhJss+VP+rG2NTYZHFV8EvBDMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826884; c=relaxed/simple;
	bh=9Xg+C5PWom7MBWGM3oBELFmo0AGF7VfetdzY70iIA2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrgStKoQYFh5hMucUUK5qcYFfTnfisll2TJhSLmYeX67tT9T3nQN54oIxSIbjuYvlQqnNl3YSoU+GmmSUbYTsymjr/e1FcX2rRWLOdVq1k4dBvJg5Q5LqXkzPLAQi3pTTPrzXiGg8P9vwadme/YDETel85hR3ieZVGCnSnqx8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w6PuUBiR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970071F00893;
	Sun,  7 Jun 2026 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826883;
	bh=FrfBfdS0gsqPIj/OR9dj1+j7K+fmqxD2LpS+4ykt+xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w6PuUBiRVlq35o8mKJuiDpA/7t4j+yQX2xSdiV0KVtKcgpCjWCP6VGsE/CPUET8sf
	 UkBIIyKj7Oy7MaFsu/6q4hbebqzjHA6jUheKrZVHgB7RGJFEkUuk/E++qlm738jQon
	 xr4B6sz+NIM83X0tzkfQvc2CzAKlSRjtnxETII00=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Coly Li <colyli@fnnas.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 006/315] bcache: fix uninitialized closure object
Date: Sun,  7 Jun 2026 11:56:33 +0200
Message-ID: <20260607095727.739580908@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260989-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mingzhe.zou@easystack.cn,m:colyli@fnnas.com,m:axboe@kernel.dk,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:from_smtp,fnnas.com:email,easystack.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0590D64F61B

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mingzhe Zou <mingzhe.zou@easystack.cn>

[ Upstream commit 20a8e451ec1c7e99060b1bbaaad03ce88c39ddb8 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2f06945533d673..d4ebd13a59f820 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1378,7 +1378,8 @@ static CLOSURE_CALLBACK(cached_dev_free)
 	 * The sb_bio is embedded in struct cached_dev, so we must
 	 * ensure no I/O is in progress.
 	 */
-	closure_sync(&dc->sb_write);
+	down(&dc->sb_write_mutex);
+	up(&dc->sb_write_mutex);
 
 	if (dc->sb_disk)
 		folio_put(virt_to_folio(dc->sb_disk));
-- 
2.53.0




