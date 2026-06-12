Return-Path: <stable+bounces-262844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4GRlNcxyK2o29wMAu9opvQ
	(envelope-from <stable+bounces-262844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:45:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24061676511
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:45:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262844-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262844-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC02A31C938D
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 02:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919261F0E29;
	Fri, 12 Jun 2026 02:45:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC535972;
	Fri, 12 Jun 2026 02:45:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232326; cv=none; b=gF5ReJ/DHhArwdGiaQkLUp3eoCAUvE6U+WdiuN0BjVrgvs/5PLQp6lZ2RJpOZwbl0ZG8fYhuyGKcSVwadWFQUe+D+YFm0f1IH3y4ouAosmCSC4kmPo2OFRxQfkLzO1nGY65mQZSBdpNoSS8soUkIk7sOFX2mED5qsX1zmjpJj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232326; c=relaxed/simple;
	bh=YtVHqaIjihVlzfbzLmg4BLmzMxDZCN5PxHf4mBFjueA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rul3L0mK37DsVFGnPloGjpgxO9omXYw/vHUVFbew4B57D2aocKjGAEgEiO3zaCFsjxVJJe/HJw4b/XRERNTFCJVLyMcaM2WS9iLoSLHn186dOJYErPQP8mUM6bx6xPNkUc6h9jl7LNSzNbva6VNytE+hUcTHzssPDuCVm+4Twn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowACnTda9citqFlxcAQ--.335S2;
	Fri, 12 Jun 2026 10:45:18 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: vulab@iscas.ac.cn,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: control: fix refcount leak in ctl_elem_read_user()
Date: Fri, 12 Jun 2026 10:45:16 +0800
Message-ID: <20260612024516.18523-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnTda9citqFlxcAQ--.335S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyUtrW5KFWxJw4rWw48WFg_yoWkZFc_G3
	yfWa18uFW5CrZFy3ZFyrs3JFWSyrW7Cr18K348tFW5JFy5ta9rXw47Zry7Cr9rZrW0gr17
	Cr9IyF4jvFWIqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMqcU
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwQA2orL1C-EQAAsI
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
	TAGGED_FROM(0.00)[bounces-262844-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:perex@perex.cz,m:tiwai@suse.com,m:vulab@iscas.ac.cn,m:kees@kernel.org,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24061676511

The error path when snd_power_ref_and_wait() returns an error does
not drop the reference acquired by that function.  Since
snd_power_ref_and_wait() always takes a reference even on failure
(e.g., returning -ENODEV when the card is shutting down), the caller
must release it to avoid a refcount leak.

Add the missing snd_power_unref(card) call before returning the error.

Cc: stable@vger.kernel.org
Fixes: a1066453b5e4 ("ALSA: control: Fix power_ref lock order for compat code, too")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/core/control_compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index af0bb694b463..d53d0182fd42 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -307,8 +307,10 @@ static int ctl_elem_read_user(struct snd_card *card,
 	int err;
 
 	err = snd_power_ref_and_wait(card);
-	if (err < 0)
+	if (err < 0) {
+		snd_power_unref(card);
 		return err;
+	}
 	err = __ctl_elem_read_user(card, userdata, valuep);
 	snd_power_unref(card);
 	return err;
-- 
2.50.1 (Apple Git-155)


