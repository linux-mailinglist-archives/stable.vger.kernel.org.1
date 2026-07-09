Return-Path: <stable+bounces-272903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1vpJKXKaT2oukwIAu9opvQ
	(envelope-from <stable+bounces-272903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:56:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814E731457
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:56:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272903-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272903-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93C65301980A
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2820B4252CC;
	Thu,  9 Jul 2026 12:43:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F371BD9C9;
	Thu,  9 Jul 2026 12:42:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600981; cv=none; b=ArnkSHTRE1NE+ZEFuZ0UJug1EQIVJZVo8GW4yk2yvSjUkCijpR4sW2mElHm59bLu9PAp6l/xLsgYxjobEbUf4t/PlIg+/GsauUJgG8sRHQ9s+l888YmZlfPLO9I/C04KAw7zZ2SrmLWwa1/zlO9g4TW2M1KctPe4+w8I98FGR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600981; c=relaxed/simple;
	bh=3FQBNC/pdRcS4V1XzrPnyF7wXWQ06YKt2mDewijeLQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2owGqI6W6t6iVXM8tZqn0BkBL2PkXQF9zp8ynDP8FAyYw1dDsrr5BovL2yHEXivYmGZygm5y6TvX38Dj51BCehA7NHO5AyNMG6jFbYPT1o7Rh3NxLT1vYBvv0+/8y+UzAuXpVkHa32kDIN7SmMu9GP0lH4BeOh/VcSmjU7k5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from DESKTOP-L0HPE2S.localdomain (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABnBc5Jl09qhrZPBQ--.6430S2;
	Thu, 09 Jul 2026 20:42:50 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: alexander.shishkin@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] intel_th: Clear dangling resource pointer in subdevice alloc error path
Date: Thu,  9 Jul 2026 20:42:43 +0800
Message-ID: <20260709124243.8127-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnBc5Jl09qhrZPBQ--.6430S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw18KrW3KF1UArW8WFyfZwb_yoWkWFc_C3
	W5Cw17ZryrGFnIkry7ZF4UZr9YkFW2grZ3ZFsrKr9ay342grn8Wrn7ZryrXr1DW3yq9ryD
	Gws2qr4fWw1rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhSdDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEDA2pPMbT0HQABsO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-272903-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.shishkin@linux.intel.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9814E731457

When device_add() fails, intel_th_subdevice_alloc() jumps to
fail_free_res which kfree()s thdev->resource but leaves the pointer
dangling, then falls through to fail_put_device where put_device()
triggers the .release callback intel_th_device_free() which kfree()s
thdev->resource again, causing a double free.

Set thdev->resource to NULL after kfree() so the subsequent
intel_th_device_free() finds a NULL pointer and skips it.

Cc: stable@vger.kernel.org
Fixes: a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/hwtracing/intel_th/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 3924e63e2eee..3ab1a37b045e 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -696,6 +696,7 @@ intel_th_subdevice_alloc(struct intel_th *th,
 
 fail_free_res:
 	kfree(thdev->resource);
+	thdev->resource = NULL;
 
 fail_put_device:
 	put_device(&thdev->dev);
-- 
2.25.1


