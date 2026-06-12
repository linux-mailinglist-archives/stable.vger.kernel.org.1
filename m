Return-Path: <stable+bounces-262838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vldOADdtK2p59QMAu9opvQ
	(envelope-from <stable+bounces-262838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:21:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC21676434
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:21:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262838-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262838-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10CDD313D5D8
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC5E371CE3;
	Fri, 12 Jun 2026 02:21:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63314344023;
	Fri, 12 Jun 2026 02:21:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781230895; cv=none; b=mkKY8BdqOps4FQJLnWOnnSwCpGsSlx0I38SBBZa9glYkWmpzmmexKPgtCBR51od3axGeKuZtNxJi48ugmt3BWZ8rEf468Sh+QmPxO0cybRmp2JdfvZO6Rp2knaJjfL5gcKI34DwwhMKLOByb5frIjB7Vj4LUNrSMprsOs2K/TT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781230895; c=relaxed/simple;
	bh=+Q5s18gJwnfOGJ66Y7Dt4zC3P/cVawbQpMH1/w6BemE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTIG57fsRq216bf7OVrFqjLUJftLu5X0pg3b2ZGyg6PBxjDa5ZWnxSvSqidHlsiPZK4DDpnurj7GNr8kmYBugWkE7+RyacHZ6j+aM4j4XOOOfaM7yjFHvvArALaCk3J+gCVZDoq5NP4RmmW2FpdIJeLSblPdxxs7cT8KGqN9cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowAB30NcjbStqHtdbAQ--.10561S2;
	Fri, 12 Jun 2026 10:21:25 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: chenziqing@xiaomi.com,
	vulab@iscas.ac.cn,
	broonie@kernel.org,
	cezary.rojewski@intel.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] sound/core: fix refcount leak in snd_ctl_elem_info_user()
Date: Fri, 12 Jun 2026 10:21:21 +0800
Message-ID: <20260612022121.14329-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB30NcjbStqHtdbAQ--.10561S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1Duw4kWryxGF1kAr13urg_yoW8GrW7pr
	4kGrW2kFs5JF4Fka12qF409F1rur13CF98Aw48Kw1UZw1fWw1vvayvy34FkF4UCFWkG3yj
	qr429a4xAF9xC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbHa0JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkQA2orL1CdzAABsz
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
	TAGGED_FROM(0.00)[bounces-262838-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:perex@perex.cz,m:tiwai@suse.com,m:chenziqing@xiaomi.com,m:vulab@iscas.ac.cn,m:broonie@kernel.org,m:cezary.rojewski@intel.com,m:kees@kernel.org,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FC21676434

snd_ctl_elem_info_user() calls snd_power_ref_and_wait() to obtain
a power reference for the sound card.  If that function returns an
error (e.g. -ENODEV when the card is shutting down), the reference
is still held because snd_power_ref_and_wait() always acquires it
unconditionally.  However, the error path in snd_ctl_elem_info_user()
directly returns the error without releasing the reference, causing
a refcount leak.

Fix it by calling snd_power_unref() before returning the error,
matching the successful path that already does the paired unref.

Cc: stable@vger.kernel.org
Fixes: fcc62b19104a ("ALSA: control: Take power_ref lock primarily")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/core/control.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 5e51857635e6..135a994e2d9e 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1186,8 +1186,10 @@ static int snd_ctl_elem_info_user(struct snd_ctl_file *ctl,
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
 	result = snd_power_ref_and_wait(card);
-	if (result)
+	if (result) {
+		snd_power_unref(card);
 		return result;
+	}
 	result = snd_ctl_elem_info(ctl, &info);
 	snd_power_unref(card);
 	if (result < 0)
-- 
2.50.1 (Apple Git-155)


