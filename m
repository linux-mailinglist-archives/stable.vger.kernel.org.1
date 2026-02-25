Return-Path: <stable+bounces-219270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFX/C9qenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF3192D9F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 265483066BC6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167F2D1F44;
	Wed, 25 Feb 2026 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="auf+Xbuc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1A2C17A0;
	Wed, 25 Feb 2026 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002605; cv=none; b=juCKuX+LHb0f80QmDJK4pQYcPLjMWh6yqp/pSc0bp+yzfGC+bdK0YvENMPcGp7dSR7dGk9ghmbcuEDvTOIZwSZU1JZasAO5RPrmJqpWfbbpkvy5zNT2PeG8NpLFOC4kxeq0Wvl9IMbnnjEdRggRI+ICLlEVTMnGZcn9VaMG0P0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002605; c=relaxed/simple;
	bh=q7N1poig2Cw11JCWko/avDeGBRYzYdmElb7F8WQvU4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXUxkSzs9LPL2KOu6ohLSW6Hh2dY6Vtf6ex6/iGMLtn/zRtmzzi96PIZ1xm3sZ4hEOVXdtyFOH8eJ4DqjHh3d+qejFxLgLJdsZrBfgSBhMxNbDi9LEodsVpayTldM1AUyeaI0kfXDYaF2sfJj32cKP28SPTkRpx2jJWQcyEXhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=auf+Xbuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E78C116D0;
	Wed, 25 Feb 2026 06:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002605;
	bh=q7N1poig2Cw11JCWko/avDeGBRYzYdmElb7F8WQvU4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auf+Xbucv52jhsnMsTz9BedpUh3LEYP5Kk7/65j0zqXEI8ihy1ZPuSncHVStUWXJx
	 4HsBE5LGW4UraB2dERa0NFdHGwivTkh4lCwmyk51BMBp23ebA4xfsCBQ1sDx0bz0JR
	 8uAC6K/OVlIGig2vFFXrzrgPnJycKIUNxBrpzMd8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Matt Ranostay <matt@ranostay.sg>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 355/641] power: supply: bq27xxx: fix wrong errno when bus ops are unsupported
Date: Tue, 24 Feb 2026 17:21:21 -0800
Message-ID: <20260225012357.236617310@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-219270-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79CF3192D9F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 688364a11647dc09ba1e4429313e0008066ec790 ]

bq27xxx_write(), bq27xxx_read_block(), and bq27xxx_write_block()
return -EPERM when the bus callback pointer is NULL. A NULL callback
indicates the operation is not supported by the bus/driver,
not that permission is denied.

Return -EOPNOTSUPP instead of -EPERM when di->bus.write/
read_bulk/write_bulk is NULL.

Fixes: 14073f6614f6 ("power: supply: bq27xxx: Add bulk transfer bus methods")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Reviewed-by: Matt Ranostay <matt@ranostay.sg>
Link: https://patch.msgid.link/20251204083436.1367-1-vulab@iscas.ac.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 19445e39651c7..45f0e39b8c2dd 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1172,7 +1172,7 @@ static inline int bq27xxx_write(struct bq27xxx_device_info *di, int reg_index,
 		return -EINVAL;
 
 	if (!di->bus.write)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	ret = di->bus.write(di, di->regs[reg_index], value, single);
 	if (ret < 0)
@@ -1191,7 +1191,7 @@ static inline int bq27xxx_read_block(struct bq27xxx_device_info *di, int reg_ind
 		return -EINVAL;
 
 	if (!di->bus.read_bulk)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	ret = di->bus.read_bulk(di, di->regs[reg_index], data, len);
 	if (ret < 0)
@@ -1210,7 +1210,7 @@ static inline int bq27xxx_write_block(struct bq27xxx_device_info *di, int reg_in
 		return -EINVAL;
 
 	if (!di->bus.write_bulk)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	ret = di->bus.write_bulk(di, di->regs[reg_index], data, len);
 	if (ret < 0)
-- 
2.51.0




