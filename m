Return-Path: <stable+bounces-268972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XA1BMZOXPmrEIgkAu9opvQ
	(envelope-from <stable+bounces-268972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:15:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B166CE629
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:15:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268972-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268972-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870DB3011F13
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ED537CD24;
	Fri, 26 Jun 2026 15:11:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865A37B02A;
	Fri, 26 Jun 2026 15:11:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486695; cv=none; b=o2twS0YVgfm5JfnGUQ6Ra+JIk10UbfO4skJ+jBpIHo6dqsgdAM9xbQkkMDcJU3LOZ3KOHwohq9cLasVxvcqC3gDdKIdg86iitwcFPRNHgZN2uBOeJejjvUDg6it5ZQ6LHGcyeOfVbYCTw5A8Dxnpz0hGLtPYT02HLPn5REJLarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486695; c=relaxed/simple;
	bh=AYzFMBFNeQefBFbatCJZ+ndY89ePDFGnI2FN7s7QDKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7z9bRJYGlLAO+Psyz6EHwwmU0utljI8H4wJR/b4NYoXv4+D1Ki2/2b+JTc57N8wssdssukE4bvQDp1+DjKTAm6PtvR48Oq/y9o1L5zCB0DhrWESyNC2Mu79SoUTqTWq5z/SbTl0ptRoTA8JpB3myjprMo+vR2ze/fIiXouUXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAB3Hteelj5qs55rAw--.50734S2;
	Fri, 26 Jun 2026 23:11:27 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: mfd: of_syscon_register: fix reset_control reference leak on success   path
Date: Fri, 26 Jun 2026 23:11:25 +0800
Message-Id: <20260626151125.50780-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3Hteelj5qs55rAw--.50734S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW8Jw47GFW8tryUXrW3trb_yoWDAFX_Wr
	yrXF9xX347GrWUGrW8Xr4fuFZ3CayDuw1xGw1j9FZ3JFy5XF13XrykurWUZ34DXr4xur9a
	k3WDX3yfuwn2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUna9aUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIKA2o+idskQgAAsn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-268972-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B166CE629

of_reset_control_get_optional_exclusive acquires a reset control
  reference. On the success path, the function stores regmap and np but
  does not store or release the reset handle. Only error paths call
  reset_control_put to release it. This leaks the reset control reference
  on the success path.

Store the reset handle in syscon->reset so it can be properly managed.

Cc: stable@vger.kernel.org
Fixes: 7d1e3bd94828 ("mfd: syscon: Allow reset control for syscon devices")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/mfd/syscon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 21a7fcdd2737..28576a3c02fd 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -148,6 +148,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 
 	syscon->regmap = regmap;
 	syscon->np = np;
+	syscon->reset = reset;
 
 	list_add_tail(&syscon->list, &syscon_list);
 
-- 
2.39.5 (Apple Git-154)


