Return-Path: <stable+bounces-274363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cUy6GJtRVmpM3QAAu9opvQ
	(envelope-from <stable+bounces-274363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:11:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF475644B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:11:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=wmkF0f5D;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274363-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274363-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64532306197F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2903B47D7;
	Tue, 14 Jul 2026 15:08:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B78478846
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:08:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041708; cv=none; b=uMLcVFD5POptV6PiZka6C9iNFSp2cYhc1t+S0A6o31tUDV7+Eqjzgo7TdU4VjYbe14Va5QCJrkQvtS836izQ4ytWLZ+TRqqjl50AfRPTIgYKvif8oR7aqxehj9GgizDJPSsmF+90grUlyWsSpGma1mt5XBPw+fZ8AHGG5fCa3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041708; c=relaxed/simple;
	bh=HO2eSWdkSOcxh0xpZKMRY/Brla/UzFVT7CAQPMnVJqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmIHIPwj1hIeV+rVjA8NoQFPZuE1LCQwelNwzyPZCquvhtUDlDgtcd0ZvYBp9OkUhbtvfxTsHQ9G5fMnLy2pL+AnGCzRDquTru6Zqbb9zGGJdy9f8tL7nx3t2PapddDUF4Ewd2ZN6awnQIkbM+HdqzylxJwjvlmaeqcTn/syb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wmkF0f5D; arc=none smtp.client-ip=91.218.175.182
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784041703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iwBSSYmCQ/6M6ihxE0JkAS/dkFMi1+DJS55iwfDdquI=;
	b=wmkF0f5DXTXTdxe40U0JvOgsc8vOJaNtnPFPwT0b0XMfZJ+kzylbIr9HXtZ6jPvifdo7IV
	k3EP7HillFPUHw0idMZo/kzXoOCT6UqcX4MKDFJYHXhc9iAhbuGRpAN7bOZH3Zz0ItAbn+
	jxMMmDWZrvxKr6OprtCXwt7G/zInyr8=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: linux-i2c@vger.kernel.org,
	andi.shyti@kernel.org
Cc: kblaiech@nvidia.com,
	asmaa@nvidia.com,
	vadimp@mellanox.com,
	wsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: mlxbf: Fix use-after-free in mlxbf_i2c_init_resource()
Date: Tue, 14 Jul 2026 23:08:08 +0800
Message-ID: <20260714150808.85045-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274363-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-i2c@vger.kernel.org,m:andi.shyti@kernel.org,m:kblaiech@nvidia.com,m:asmaa@nvidia.com,m:vadimp@mellanox.com,m:wsa@kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30FF475644B

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

If devm_platform_get_and_ioremap_resource() returns an error,
mlxbf_i2c_init_resource() frees tmp_res before reading tmp_res->io to
get the error code. This results in a use-after-free.

Save the error code before freeing tmp_res.

Fixes: b5b5b32081cd ("i2c: mlxbf: I2C SMBus driver for Mellanox BlueField SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/i2c/busses/i2c-mlxbf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 6c1cfe9ec8ac..e33512b25353 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -1051,8 +1051,10 @@ static int mlxbf_i2c_init_resource(struct platform_device *pdev,
 
 	tmp_res->io = devm_platform_get_and_ioremap_resource(pdev, type, &tmp_res->params);
 	if (IS_ERR(tmp_res->io)) {
+		int ret = PTR_ERR(tmp_res->io);
+
 		devm_kfree(dev, tmp_res);
-		return PTR_ERR(tmp_res->io);
+		return ret;
 	}
 
 	tmp_res->type = type;
-- 
2.51.0


