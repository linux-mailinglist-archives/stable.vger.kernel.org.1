Return-Path: <stable+bounces-273455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +IhDCGcNU2pkWQMAu9opvQ
	(envelope-from <stable+bounces-273455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 05:43:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184D743B60
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 05:43:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=oNA2LhDn;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273455-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273455-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44568302002B
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 03:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79C736AB57;
	Sun, 12 Jul 2026 03:43:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77ED2BD5B9;
	Sun, 12 Jul 2026 03:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783827795; cv=none; b=Cq9//oB5yRJvb6WBQVLDOZBsF5jAcEooGL2A07t/D6Xm+/3J/kX/TEYUBz6dEukhHwDS27QfM3QKEbSHiC4hufi6yGOh0t2nwpze0/4Pg0BeEpGYAbvk1A4D4BUwUkh8GwsNA0jlhrDs7K7Fk1TeGqH0zOh87l51IKGNMG1fB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783827795; c=relaxed/simple;
	bh=ieZGQpzAl7ZkRjjBSOv5eE37RVyMQFxLduBwLkMwokI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XNIiGma5oOdcloKL0yC2ZWw8eb6pEuTb+8lbY2Mc+JA5bUNhgBGad71xMdpRphZi2+hLvvYeVS9q4C5oyB0EgKv9v1fVpAgbs/g87U1uDQxUGLM8prd1UHFODrkddEaK/AYE4A408ikYPv40q3brbKMqxfJkc0PQ//pyOxnaafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oNA2LhDn; arc=none smtp.client-ip=203.205.221.236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783827783; bh=1jt5f7gn0PgrU+QrmBPvl4Z/Eul/vK8t5Mvlq46/TjQ=;
	h=From:To:Cc:Subject:Date;
	b=oNA2LhDncmWM74ZVkBgH87e0oWgv9dURDqnp0J+jXzbM99LvZO5m6F7tFW40qCGyz
	 2c+oFxohCkSskFZXAcXZLBzonFU79Mijtwf8JcNu+mfYeJv0C/xGq99hQ/eFHcruvs
	 pBT/8Hd/og/7RD1emY37T/rGOSC7gElnbp5QL0vM=
Received: from ubuntu.. ([218.196.207.7])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id AC09C290; Sun, 12 Jul 2026 11:43:00 +0800
X-QQ-mid: xmsmtpt1783827780t6v69yj7d
Message-ID: <tencent_542687AA9C474951C4132E84DAED17622105@qq.com>
X-QQ-XMAILINFO: NmhoXJR/eu5x3cfTIJojw6goN4j77+ZTDryok1QZb3HuoFDn/cVP6ZDiQWBCYe
	 IeeNDdIjD6ZnxpQlPIMlZiDhOSj7VZwpHZD1E+QPjiwq/IG9/uY4+JaKGHv+8RHAtJVPAFgOEJ41
	 kKlF8ZSFVuObQ0AdunMVgsI+u/4MknPe3U2k9cO050rXDPV3ehAlnyIFGuVzzymGoaf2SV1U4Ae6
	 4haIUsJk04xLew63/0+YdvFYl8t2wWVLE2P8jKoURWky9CghLDtYJ5aKpmrc3ZQSOvXt1LEIkBMN
	 g1Qk/U/TCYt8B93Wx2BkhZzqALm8cChlsFc3bKP5KpSPwlcm9SeRmADM/aepDKEbnzvbTyZg+XLu
	 dIbkc6F+g713wYIbwfEd1dIH9Uk6oxy5iR9Ku3q2Q/yjhB+2RcmJFN2pmqu7VdaFlGEtw2BbfZ5M
	 J0aK0/xOu9vFUOIM36TLuE6dAIe1y3IiokDe7cXGeCVA3ecRDTtGQvku7VjRVkjI5wvfg4yCaY7V
	 m+NPNELmqjKVk9l8z9e/0okYWqvWm1X9FOwHDKkC4PIzJT14KTGB4rzf1jStsCrhHq8uG8+UrNw6
	 BHkplN/XDBgJQOYOMkyg4EdEJAHBQwGLO7n5EtH8r31rtMJdAldojjaTlYxhbH7aamGmMHLYHA7c
	 grSVr14VJBHe03ijDl2qo40NxC6RTaTYtFgfKLMF9XdkZqVGhvtmJf1rTZPpizkjlzkE+F+vz7q2
	 1+b0B/fAZXR3aby0hdjK2KDDE3FvvlstVy4oig4Ndad3DssaXK9XvwJX8odtlV9w+9TdTR4ofI1Z
	 Pmy7FNloX7kuonqaU7GTUBEfKI+/nOmhb4Oy+dtJh9GLmVXy4ClOCYqzyTkbntg3RCHXVK+55JNU
	 uP/g1kYs6P5wX57dZaWaup3OnAUaTmXJ+BZKZKnu5WThgzQEayOs2drUoyzRjQM+Bc2SIhOekiGL
	 h7MXdoPN/9cvVUWGpLF9XdXwI3s0apN6oceOaop0FXqUUt2wb69ICdyoun1D6fuOkUyvIYkONcQ0
	 O1cRN8BOnqsQ147jz/ogzkqWxIgZEtuwJzppYP3Rl13umGfvk+C/PJNf8wbak=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Guanghui Yang <3497809730@qq.com>
To: linux-xfs@vger.kernel.org
Cc: Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanghui Yang <3497809730@qq.com>
Subject: [PATCH] xfs: propagate errors from xfs_rtginode_load
Date: Sun, 12 Jul 2026 03:42:56 +0000
X-OQ-MSGID: <20260712034256.1700970-1-3497809730@qq.com>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273455-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:djwong@kernel.org,m:hch@lst.de,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:3497809730@qq.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[3497809730@qq.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,vger.kernel.org,qq.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[3497809730@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:from_mime,qq.com:email,qq.com:mid,qq.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9184D743B60

xfs_rtginode_ensure() treats every xfs_rtginode_load() error other than
-ENOENT as success.  This can leave the realtime group inode unset after an
I/O, allocation, or corruption error.  Growfs then continues as though the
inode had been loaded.

Only -ENOENT means that the inode needs to be created.  Return all other
errors to the growfs caller.

Fixes: ae897e0bed0f ("xfs: support creating per-RTG files in growfs")
Cc: stable@vger.kernel.org
Signed-off-by: Guanghui Yang <3497809730@qq.com>
---
 fs/xfs/xfs_rtalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 7a3f97686989..84efe5a8fb11 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -737,7 +737,7 @@ xfs_rtginode_ensure(
 	xfs_trans_cancel(tp);
 
 	if (error != -ENOENT)
-		return 0;
+		return error;
 	return xfs_rtginode_create(rtg, type, true);
 }
 
-- 
2.34.1


