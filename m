Return-Path: <stable+bounces-211451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GniJDGddGkO8AAAu9opvQ
	(envelope-from <stable+bounces-211451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:21:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA487D3A2
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E00E30117A6
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170128853A;
	Sat, 24 Jan 2026 10:21:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE012620DE;
	Sat, 24 Jan 2026 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769250094; cv=none; b=sEbjPEMqzZaomHSGbqu7rDy1hped/yBC4sUqNfGnOKRwAi8nMA0jsHHnV/P/ZGAo/TxlKoQgOlwB7lSKne2J/jcJrnjgtJx2FAtokG+rM7OrBpCGVxFHYXEtGpadYLjn2FgIqvQoxPvromGBr5E1emdkxbkG/rUYFaSRUL9nGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769250094; c=relaxed/simple;
	bh=hKzjDxwmygk4rO4sd9PlZ1bEfj0X2QNvP0hDGmKV9dY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZw3+dRrAcZm4JvtP/pFFjz0ko4QeaALStox7CdJTlYBgykFhaIkVpVB6XRvvendqhZRFa2fqF1qHbzmrxvGGuIXzoW0GxxQH4pey5R7suhQV6oUaemUD3+x8tuec9HkKrbPpHS9qV7WNsSwSiIJ2mfyrnPw3WhwYNZXfwXvPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowAAXpgkHnXRpsX9PBg--.7586S2;
	Sat, 24 Jan 2026 18:20:57 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: ioana.ciornei@nxp.com,
	stuart.yoder@freescale.com,
	agraf@suse.de,
	German.Rivera@freescale.com,
	gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>,
	Christophe Leroy <chleroy@kernel.org>
Subject: [PATCH v3] bus: fsl-mc: fix an error handling in fsl_mc_device_add()
Date: Sat, 24 Jan 2026 18:20:54 +0800
Message-Id: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXpgkHnXRpsX9PBg--.7586S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1ftF1xtryxZry8Ww4kJFb_yoW8XF1rpF
	1xWa4kAryUtr1UCw4kZFWxua45Ka92y3yF9ry0yw1fu3W5XF1Fq340g34FgFWDZr9Yka1Y
	vFnFyr1UXF1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAcRE2l0JoO7QAAAsK
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-211451-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihaoxiang@isrc.iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isrc.iscas.ac.cn:mid,linaro.org:email,nfschina.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EA487D3A2
X-Rspamd-Action: no action

In fsl_mc_device_add(), device_initialize() is called first.
put_device() should be called to drop the reference if error
occurs. And other resources would be released via put_device
-> fsl_mc_device_release. So remove redundant kfree() in
error handling path.

Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/b767348e-d89c-416e-acea-1ebbff3bea20@stanley.mountain/
Signed-off-by: Su Hui <suhui@nfschina.com>
Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
Changes in v2:
- fix a patch error. Thanks, Christophe.
- add specific changelog. Thanks, Dan.
Changes in v3:
- Also call put_device() in other error paths. Thanks, Ioana.
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 25845c04e562..6d132144ce25 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,11 +905,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	return 0;
 
 error_cleanup_dev:
-	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	put_device(&mc_dev->dev);
 
 	return error;
 }
-- 
2.25.1


