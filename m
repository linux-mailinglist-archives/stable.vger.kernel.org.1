Return-Path: <stable+bounces-262414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NrRoLT/WKGq7KgMAu9opvQ
	(envelope-from <stable+bounces-262414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 05:13:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7E665923
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 05:13:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=foxmail.com header.s=s201512 header.b=ERRjLjHw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262414-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262414-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=foxmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21FF830A8F30
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6C34216C;
	Wed, 10 Jun 2026 03:11:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727013346B4;
	Wed, 10 Jun 2026 03:11:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061087; cv=none; b=VkKPEyc8yAvtmQCBnwDFfAdOXl1IhcTJ2wKuUqTQZ/s6vot6iY32FB0i0mdEvwfHbtaw2eIc6LSscXVz01VWXQkwBWZb62663U0PUOqsGPn8kEwcJupFWNgjjFVve1deZgqpRapjjFQpJQziCfeB5tRq/reUiK8LKgA65z56X34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061087; c=relaxed/simple;
	bh=RrDj1dVqthvI8cUvj+c8uSlEErP0aGR6vgHkoXDFBDA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kzxL/uxtmOiIwIcKstaTa6dOeK66CLRkcc7PXW7Qdbza4BgrELxNuerjGFZZq8Ga/q4uvMqbWoAcUgGsTfIRKpe8VH4HMLmMvLAfh9NdPGL3QcmBtkl1n+jEYiSHOpac/YLrwrkK1wTpp3oLDcHfG22qMZjUbvivJ3MqzWFCJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ERRjLjHw; arc=none smtp.client-ip=162.62.58.211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1781061073;
	bh=XMINfkWJMUehntgXydtcMCrD39psxFUXu00/+v4bE3U=;
	h=From:To:Cc:Subject:Date;
	b=ERRjLjHwoYNkIUWXukgOxq5fYF9h3xC1BpRv9s+Hsb5lRAjRhTbBmNja5xPNrGplC
	 HiUp1fA6x2ZLlsmOuyUtz5A55LWb7iNn8pkmiNe44tyZr+/wj2Q5+cGzqx3J6axcTe
	 CcKNR7BznlTKfcy52EyhsFC9B6gXb/q7ZhbwkoC0=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 2CAA70E6; Wed, 10 Jun 2026 11:11:10 +0800
X-QQ-mid: xmsmtpt1781061070tncfo02na
Message-ID: <tencent_D87B6446BC0B517BEF9D4731C6CD8B288206@qq.com>
X-QQ-XMAILINFO: N4zS2EeO0VckaIgrGMVHM8hulUcyekeRnnw3GxgGeODx/aGSrURgg4iEbnUgCv
	 vEvlwekc8iKWrDtyE5MbWT6pVcFbuOlc5pgZEOIFoW4ZV1BnL5SZuoeCXSdBHbwSiI3Vcy476RlL
	 xs4JKBxPUVBmPnrLDFKZMdOtcRezqANZIttJZzhRYcdE/VgjPLQe57pU9a441c4Mn5u6Tq9JmFjE
	 hSd/xyljYv4SzO2WuPyZ4Ppy0iTFwHUnqEW7s3c/YK6/L0aDKIrV7bxz7GehUDbGBcRtbxSIQvi+
	 G1oww360v9Efkl4xfqBkVwuYPD3i6+9gX3dhqnajKj3qc9DHsF4qgHBAL4jWvdrLdkCsuwFtee+q
	 b9x/hoajfMOye0oLnUteQXfSzHBVvLHG8y34YCdVnikaPtWLEkZ5RA1ds+POPFNnJNjPlBMHbA/Z
	 RUwDkCL8TFSAsfGZlLSpiTj1pxkfMZFTWV5oHsWHDYa8LmgQ9QEgRGh6vuq4bgCYpVbOrZZoBt/3
	 i1M3H9pzqDaEJ6ZHYMhqv16NMsAtUoZ6Zqw76TOL4LCWIRj2RcLPjcP+ijXXnoTKz4LsUKIMwhiE
	 TK89aap/WEA8aT+iZwAK98i1lw6CzkR1lpzLMsJoxttL6HSSqnYQnaiYf87HHzcTqecL6Ps5Do/q
	 pD2VEpb9ZK7OI6kHm+9iZoBRjrXDCGaCTXu1e4URdG2v/YV+6yW+54qTcrG9AufgWN/M7cSBaT5m
	 bsoar/lXY1ynEy+E/ulnJD/7C4lfcoMbiUtc00uARv3NSPL0VyywpZxASbcfOM/YaI9wKHqJLiSR
	 /T1EcQIr1KAhjMqdY6cU0c8CfCg6DNnNlgpRicP3/tKAhjFjeHFYzOqIkmzQgameJgOQKccsFKNO
	 1xt+b/LOwuhYVXR7Zm5oCBtsRp1RvZwmSa7yKT0xDRwUMzn4mVvVenukmL2cTkYBenUG7z36t1+9
	 3ohzCSMVoLdfE4MNaj6xl9yoUjYwXQTL41fgDnzQ5r6EZ1XGSnIiOfxeS995XOwbfw56T9NhYvuj
	 1/3a+qg+gXT4q6zv88LnkpiTAYHQQ=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Zhao Dongdong <winter91@foxmail.com>
To: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	daniel.baluta@nxp.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: topology: fix memory leak in snd_sof_load_topology
Date: Wed, 10 Jun 2026 11:11:08 +0800
X-OQ-MSGID: <20260610031108.143331-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lgirdwood@gmail.com,m:peter.ujfalusi@linux.intel.com,m:daniel.baluta@nxp.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sound-open-firmware@alsa-project.org,m:zhaodongdong@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262414-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email,foxmail.com:dkim,foxmail.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DB7E665923

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

When the topology filename contains "dummy" and tplg_cnt is 0, the
function returns -EINVAL directly without freeing the tplg_files
allocated by kcalloc() at line 2497. This leaks memory on every
such topology load attempt.

Fix this by setting ret = -EINVAL and jumping to the out: label,
which already handles the kfree(tplg_files) cleanup.

Fixes: 99c159279c6d ("ASoC: SOF: don't check the existence of dummy topology")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 sound/soc/sof/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 63d582c65891..09d6dc01814c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2534,7 +2534,8 @@ int snd_sof_load_topology(struct snd_soc_component *scomp, const char *file)
 		if (strstr(file, "dummy")) {
 			dev_err(scomp->dev,
 				"Function topology is required, please upgrade sof-firmware\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		tplg_files[0] = file;
 		tplg_cnt = 1;
-- 
2.25.1


