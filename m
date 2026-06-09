Return-Path: <stable+bounces-262199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W7MeDXDDJ2r+1gIAu9opvQ
	(envelope-from <stable+bounces-262199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 09:40:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E92A65D503
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 09:40:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262199-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262199-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A566E30323B0
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165383DDDB9;
	Tue,  9 Jun 2026 07:40:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A13C769E;
	Tue,  9 Jun 2026 07:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990826; cv=none; b=iubF6MEFfZjToAXml1Ck7xH6FU4eKDGvhk9xMwGpveXwvtMyvREfWFCuXzBleWSHza+7v/v8HjP96KdiaV+PU2kJS6PyARFI5pzwAj9vajKVi9BcS9XMTk9X6iWGiyl4+gJzKragGxPBRhj/sRtxtps43diw6y5q4n1hSIcum1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990826; c=relaxed/simple;
	bh=wLJGk3bCO/WNdnkcwu1xkiHmrhwjxM4NAwi6zjwPgQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhCw4v5W/GX+E+6AlhMQ6gvxZnMJEjP2FIdC/yokVhiKEOpcMu2UG+tUpTrBsS3fa6SvgAMqLuZtMh+ezdM3KSiN0CXPKtrdILQ2ESVGe6hsrupJTxBVO7HxiBsKRPqSy5tzY3X6wzIbcXFfrN22iT2Quhk638hdKTyjrzfjWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHkcRZwydqsYDNEg--.13811S2;
	Tue, 09 Jun 2026 15:40:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: olteanv@gmail.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: sja1105: fix refcount leak in sja1105_setup_tc_taprio()
Date: Tue,  9 Jun 2026 07:40:02 +0000
Message-Id: <20260609074002.204113-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHkcRZwydqsYDNEg--.13811S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4DtrW8uw48WrW5Gw1UAwb_yoW8Aw48pF
	47WrWfAF4fJry3Xw4DZw45uFyYqa97Ary5Krs7Ga4Fvw10yw45Jr4jy34j934jqw4DAayY
	krW0yFy3ua4DAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU7ku4UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwNA2onpjNyLQAAsC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262199-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E92A65D503

In sja1105_setup_tc_taprio(), taprio_offload_get() acquires a
reference on the new offload and stores it in
tas_data->offload[port]. If sja1105_init_scheduling() or
sja1105_static_config_reload() later fails, the function returns
without releasing the reference via taprio_offload_free(). The
stored pointer is thus leaked, as the driver will not clean it up
unless a subsequent TAPRIO_CMD_DESTROY is received, which may
never happen.

Fix the leak by calling taprio_offload_free() and resetting
tas_data->offload[port] to NULL on both error paths.

Cc: stable@vger.kernel.org
Fixes: 317ab5b86c8e ("net: dsa: sja1105: Configure the Time-Aware Scheduler via tc-taprio offload")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/dsa/sja1105/sja1105_tas.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_tas.c b/drivers/net/dsa/sja1105/sja1105_tas.c
index e47967b12d5d..96cb5aa04910 100644
--- a/drivers/net/dsa/sja1105/sja1105_tas.c
+++ b/drivers/net/dsa/sja1105/sja1105_tas.c
@@ -575,10 +575,18 @@ int sja1105_setup_tc_taprio(struct dsa_switch *ds, int port,
 	tas_data->offload[port] = taprio_offload_get(admin);
 
 	rc = sja1105_init_scheduling(priv);
-	if (rc < 0)
+	if (rc < 0) {
+		taprio_offload_free(tas_data->offload[port]);
+		tas_data->offload[port] = NULL;
 		return rc;
+	}
 
-	return sja1105_static_config_reload(priv, SJA1105_SCHEDULING);
+	rc = sja1105_static_config_reload(priv, SJA1105_SCHEDULING);
+	if (rc < 0) {
+		taprio_offload_free(tas_data->offload[port]);
+		tas_data->offload[port] = NULL;
+	}
+	return rc;
 }
 
 static int sja1105_tas_check_running(struct sja1105_private *priv)
-- 
2.34.1


