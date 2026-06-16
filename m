Return-Path: <stable+bounces-263514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b0ZBDn+zMGqoWQUAu9opvQ
	(envelope-from <stable+bounces-263514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 04:22:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E4C68B713
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 04:22:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263514-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263514-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA049301DC15
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532623C09F8;
	Tue, 16 Jun 2026 02:22:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10823EAB2;
	Tue, 16 Jun 2026 02:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576568; cv=none; b=VLIB/OUB7/DOR+BfcHqknKCbLG8Zeaz8/il+pL+ElX32CLmTWu2Jkbnt0lYQHr5/+mdWQTrNeCOTR00rzhvKjkU45Lap0liP0QqxhXPcEs12II3p+EGd4ZKzydNX2x7i+tzpeffa/Y7jwRH7RWtP+vLjL/wii0AA6+ZHrxWGF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576568; c=relaxed/simple;
	bh=S3mz17AhE2+LTLaXrzCJePSSSnwKBwPr5tsB0ra3wVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GfGxoEqmuxfRkFum0xWkzX5lwU7AV41PSvBp4yMjo76+dgsAbVoqpjwBPiJPl4pyUUiMpu05cvJb/cXJ0EGyltFSo6FHGfcLYACen9MlyaUsNYgSl8jm413d7lAkxA7HaWv/gYKgZotKzOcn1Nd88xx4ERaVcn21/7+hziQsDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHJt1xszBqCv7gFA--.37987S2;
	Tue, 16 Jun 2026 10:22:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: brgl@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
Date: Tue, 16 Jun 2026 02:22:26 +0000
Message-Id: <20260616022226.1655762-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHJt1xszBqCv7gFA--.37987S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JryfKFyxKw1kXw1fCry8Xwb_yoW8JrWrp3
	98G3sYyrWUWF47tF45tFW7XFy5Aa17J34fua9ruwnYvw15Xa4jyry5ArW5XryjyFy8ZFy3
	tr1Iga48uryj9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUg4S
	rUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYTA2owFOcJPwADsG
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:brgl@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-263514-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59E4C68B713

pwrseq_debugfs_seq_next() declares the 'next' device pointer with
__free(put_device), which causes put_device() to drop the reference
as soon as the variable goes out of scope. Returning 'next' directly
thus gives the caller a pointer whose reference has already been
decremented, resulting in a use-after-free.

Fix this by returning no_free_ptr(next) so that the automatic
cleanup is suppressed and ownership is properly transferred to
the caller.

Cc: stable@vger.kernel.org
Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/power/sequencing/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 4dff71be11b6..1ec4f393994d 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -1010,7 +1010,7 @@ static void *pwrseq_debugfs_seq_next(struct seq_file *seq, void *data,
 
 	struct device *next __free(put_device) =
 			bus_find_next_device(&pwrseq_bus, curr);
-	return next;
+	return_ptr(next);
 }
 
 static void pwrseq_debugfs_seq_show_target(struct seq_file *seq,
-- 
2.34.1


