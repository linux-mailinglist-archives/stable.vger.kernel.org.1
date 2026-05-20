Return-Path: <stable+bounces-250037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIlMOG3rDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:12:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FF59310F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EE33317FD9C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B735D3A6B6D;
	Wed, 20 May 2026 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUy28tIA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBDC3A4526;
	Wed, 20 May 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294378; cv=none; b=SCfQ5kowx+dViTUod9MGBi8hXJYedWy7n9b+AVMwMpGATTudzc/YAAWWh5rExiTK9jmti/t3ZTTiam5DOAPW0yOpypD1rzQajCythVE/wJWEeR1D0o2Uh7wbvt+78J85FeOpOskjh/7LX8JODCHnBm013GvSAZpqKhKVdM399qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294378; c=relaxed/simple;
	bh=P8Y1cj9wpgDItTSGXBhupMml7pJsZziLkL++kwUkB80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRCtrj8nse42QphKcxFAjEaPRnmWkK1VnQYGADjRXAvmNC5uW7LCL46Tz/QXc0R1HZp0NsLvUIXjkAdN7fkpY8dgUMORhifd8dOEulGspc5DsfS8se3pkB6MByCYgHq9QBc99JBB9Wn+Stfl3boOf5tWWxPP1BOgmqV8QBymQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUy28tIA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005DB1F000E9;
	Wed, 20 May 2026 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294376;
	bh=lXDoxyiSJbSPJ3E+qH+DUJ7Wkxo+I+jPeH9zl/QNG3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CUy28tIA8Xvd5nhaTuiWxbuhCWOCISMf9bF+i+IzOTXqzlkRZvN/OaVwsHRZm+nt9
	 uMOUa/4p7XvkXyo/cC1Ekl8UO0JXXKPqjL+OPb2eB7V49p2x3TDcAn8obMMPgBuK/2
	 6iLBi2zSYWyStpgRiNe9o/GiftbiQkarM7nnlm1s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com,
	Yuto Ohnuki <ytohnuki@amazon.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0017/1146] blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
Date: Wed, 20 May 2026 18:04:27 +0200
Message-ID: <20260520162148.778731279@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-250037-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,71fcf20f7c1e5043d78c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: E92FF59310F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuto Ohnuki <ytohnuki@amazon.com>

[ Upstream commit e9b004ff83067cdf96774b45aea4b239ace99a2f ]

wbt_init_enable_default() uses WARN_ON_ONCE to check for failures from
wbt_alloc() and wbt_init(). However, both are expected failure paths:

- wbt_alloc() can return NULL under memory pressure (-ENOMEM)
- wbt_init() can fail with -EBUSY if wbt is already registered

syzbot triggers this by injecting memory allocation failures during MTD
partition creation via ioctl(BLKPG), causing a spurious warning.

wbt_init_enable_default() is a best-effort initialization called from
blk_register_queue() with a void return type. Failure simply means the
disk operates without writeback throttling, which is harmless.

Replace WARN_ON_ONCE with plain if-checks, consistent with how
wbt_set_lat() in the same file already handles these failures. Add a
pr_warn() for the wbt_init() failure to retain diagnostic information
without triggering a full stack trace.

Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
Fixes: 41afaeeda509 ("blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter")
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Reviewed-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Link: https://patch.msgid.link/20260316070358.65225-2-ytohnuki@amazon.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-wbt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 33006edfccd44..dcc2438ca16dc 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -782,10 +782,11 @@ void wbt_init_enable_default(struct gendisk *disk)
 		return;
 
 	rwb = wbt_alloc();
-	if (WARN_ON_ONCE(!rwb))
+	if (!rwb)
 		return;
 
-	if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
+	if (wbt_init(disk, rwb)) {
+		pr_warn("%s: failed to enable wbt\n", disk->disk_name);
 		wbt_free(rwb);
 		return;
 	}
-- 
2.53.0




