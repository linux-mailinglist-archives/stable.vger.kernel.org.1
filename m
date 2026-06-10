Return-Path: <stable+bounces-262441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZEbQIIIRKWqdPwMAu9opvQ
	(envelope-from <stable+bounces-262441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 09:25:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CA8666A0B
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 09:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=foxmail.com header.s=s201512 header.b=Mn3FTlXu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262441-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262441-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=foxmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC24430E8F32
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF8638E8B1;
	Wed, 10 Jun 2026 07:20:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDC38D406;
	Wed, 10 Jun 2026 07:20:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076059; cv=none; b=jfH+bIpftZDZHRajV50MlIIY9EWTsB0y7WEWYLoZe7nselihIdCUlCFrqde/5rYUro6I7nhqcs6bqC2M3wvQPitELOTLdhFPAojArcJtgGijFMWlSni/Q8YPykMziFlpS3AKI40wxL70nPldJRgkJWXvl1TWLgv99fWNZG1x/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076059; c=relaxed/simple;
	bh=nawfURoVNcY1y+AlEZusxpWV8BH3+chGLBW4FIW3N1Q=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=PzFF3g+ad5zwGEPAd/e27Zzeg/LfwCLD5C1I94L31Osvb8LhGFypbfCud5eHNsZ2fJUqfQfXEA5i933b4zvAQv0Nlbma6ZopzgjTAAoiG/RmxhETlEI3XU/XSHlphX07PW3m4lSNPbAImQUneIMnn3vi7srNRcDMhflmQ/xPZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Mn3FTlXu; arc=none smtp.client-ip=203.205.221.205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1781076048;
	bh=PDzkjA71F3P9PqlsL+WLSt4JFrm5GDZf8QurqsS0AaI=;
	h=From:To:Cc:Subject:Date;
	b=Mn3FTlXu2oWWqQVhdUNfIzSh5PYAOPNAMn8QS4jOKj57kiiVEypkPUuxUURL5BXa1
	 JwGUESMb2p8HXF7YV3IElQVQER4zArKPL1wIeX1mmIl+ZO+hLVwXMs266nWS+fQkaT
	 lNt9lop88dyRJw+Jd28J9Ac1NF+84wCjrnqihPk0=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 52E32E9C; Wed, 10 Jun 2026 15:20:46 +0800
X-QQ-mid: xmsmtpt1781076046tvj5gzq2y
Message-ID: <tencent_3EED6D778DC52C3703A2D1EE8119372E8E08@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJTcpz2bT5k+e18oexLPWuzKNjAUUqbJvfmbv4VfEBsjO5LGrtGy
	 u/66wmQlyBEXQzGXMe7lpPu11x7xC61eaikH9FY4NoTChs1lbWS0ugp1XssIcbhK6EzQpDWu+8pI
	 NrgexXFw972N3Q7jG2mYjrdkYoIQTZDCEURsdwKMWCc70TS9cQeU5cQfNC16BzdRQdhBiuqCUIQR
	 nrQTeK3ZITJJEAv6nZ/nLh8OdOUQ7wZnMdrDFWVbAJmmDCzmNmhMAENPlrHITUlPmZbO9ewpg3f+
	 3WkeRj0dGxZF4KNIx9vZsLgvq9Pw8BgKTvQRZSLcbb5qqNaGByhpa1ZigQ3gv4oZ1m7v8cvPelYk
	 zCClS5PoByEF+HMGuu8GN8UBRIRGmeTFdELZzPg3sbT1qghcrQann8UBnuZ/VIcE3KI/lSnrvlst
	 CnBn9CNQWnUjbmBS6+uAHKN44xri0R/s4FpSlHihJnaSpvqttpqFhEk3qQnjUwXFlJa6cZQZ19VQ
	 Bi0nneiJU8WV92GE8sYWAUPFhqsdqYrpFWWwqHAhxKln7m+aEnDxUTO41MbhAqPRlGcQcYoFniqe
	 b2CeDASVq/u8KQfyu+vPuwII1lD/A5o2yKfmtsmM77QXS+dHMnZvE7yKKBDDFkjg6JBQNcNAQ70V
	 VAPO2dsPR6bMie82ayofATzFB27i5Vk8zjIQ6NQ26x8Sx5W5hmWAK3Q4qtjtkydKPosQPnP7D/Al
	 4mtIE442UL527kyrMiLLHJIPJsHu+DNWpOVBV+ak7ct34OoWNj3qY8JUZA0V6SwcBPKDmYHdgZ+2
	 IlD/St1YfOqshB2K8He/PY/QTXf/qo572JpnUmPUVKiS1uTKt5gTJFWBK2Ip7G2udEJCc2wL/5bd
	 ObOIEhHe3c6KA4ddkC3dWVW4iAOC2lBFuSWCEa2LDShQafqtxBBdtojmg2tVpUoUTq64DGZyHE6U
	 7XUVSB7/1sZqrSzgI0alBMjtDWB5QdtfVZaepXnKqcvjWGL0MiSKf94yRiKbV2gOebCtjbRWOEjC
	 SlzsbpNCupLzpXdRZncYBmWEM8DMO6+r+p1dUTsMuEjPb4i18NktEcsy+XUEOKM6YjVIZR7b6rj5
	 u86wckrdMD5Cgu1jk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Zhao Dongdong <winter91@foxmail.com>
To: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	daniel.baluta@nxp.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: SOF: topology: fix memory leak in snd_sof_load_topology
Date: Wed, 10 Jun 2026 15:20:43 +0800
X-OQ-MSGID: <20260610072043.336869-1-winter91@foxmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lgirdwood@gmail.com,m:peter.ujfalusi@linux.intel.com,m:daniel.baluta@nxp.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhaodongdong@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262441-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email,vger.kernel.org:from_smtp,foxmail.com:dkim,foxmail.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4CA8666A0B

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
v2: add kfree(tplg_files) before the return
v1: https://lore.kernel.org/all/tencent_D87B6446BC0B517BEF9D4731C6CD8B288206@qq.com/
---
 sound/soc/sof/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 63d582c65891..a368e257c459 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2534,6 +2534,8 @@ int snd_sof_load_topology(struct snd_soc_component *scomp, const char *file)
 		if (strstr(file, "dummy")) {
 			dev_err(scomp->dev,
 				"Function topology is required, please upgrade sof-firmware\n");
+
+			kfree(tplg_files);
 			return -EINVAL;
 		}
 		tplg_files[0] = file;
-- 
2.25.1


