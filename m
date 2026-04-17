Return-Path: <stable+bounces-238444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHwHNSnl4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:45:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A42574181FA
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DC2B300DCF6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E153290A6;
	Fri, 17 Apr 2026 07:45:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE852FF17A;
	Fri, 17 Apr 2026 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411928; cv=none; b=SuouxydhTi3j9W5eawH6/AAINe40wCZ98Bo/LBgxxGtA7kKCmhGeG3/gZKYDpfFzc0CXClZP1aoXV0J5eG+t1CaGCbWmUk7IJr3L7ue/txKzVIbe5qpW0+iUGTC8d4jy6AiQPXqtHv8B1VH/zfVMTbvx3qS8k0aOGcsUf26FSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411928; c=relaxed/simple;
	bh=1gczJKb9r8WxSOAQm1hVYc+mTHiGAJvYEzgcY1SntM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILXKNO9fRy2wKNsGTkAub3DB21sV5OseQkb2pVoZ29hLAWvF9QzQnFsbHkaRkRhOBTGjzeKoPPiONju0m9dIOMykRlmRRdWMkhCy5VwcmC3uQfLfMz89vs0SeSjIjZCnYdPG+s09e6UsE+0gcFAkEgnttPMrMgLTkjoFSbgZ3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowABn9gkD5eFpnx3YDQ--.24269S2;
	Fri, 17 Apr 2026 15:45:07 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/powernv: allocate sensor group names to fit the OF node name
Date: Fri, 17 Apr 2026 15:45:05 +0800
Message-ID: <20260417074505.16178-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn9gkD5eFpnx3YDQ--.24269S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5Ar1rZrW3WF1rWFWfKrg_yoW8CF45pF
	sYkFnI9a18ury8Ja98K34j9a1fKan5AFW2gr1UJ3sayFsxZr9FvF40yF1YyrZrJr4rGw1j
	gF43Xw13CFnxGFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDOz
	3UUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-238444-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org,iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A42574181FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

opal_sensor_groups_init() stores each sensor-group name in a fixed
char[20] field and formats it with "%pOFn" or "%pOFn%d".

The node name comes from firmware and is not bounded to fit in 20 bytes,
so formatting the fully qualified group name can write past the end of
the embedded buffer.

Allocate the group name string to fit the formatted result instead of
storing it in a fixed-size array.

Fixes: bf9571550f52 ("powerpc/powernv: Add support to clear sensor groups data")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/platforms/powernv/opal-sensor-groups.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 87fd6d7769e9..f940c223f1b5 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -23,7 +23,7 @@ struct sg_attr {
 };
 
 static struct sensor_group {
-	char name[20];
+	char *name;
 	struct attribute_group sg;
 	struct sg_attr *sgattrs;
 } *sgs;
@@ -207,9 +207,12 @@ void __init opal_sensor_groups_init(void)
 		}
 
 		if (!of_property_read_u32(node, "ibm,chip-id", &chipid))
-			sprintf(sgs[i].name, "%pOFn%d", node, chipid);
+			sgs[i].name = kasprintf(GFP_KERNEL, "%pOFn%d",
+						node, chipid);
 		else
-			sprintf(sgs[i].name, "%pOFn", node);
+			sgs[i].name = kasprintf(GFP_KERNEL, "%pOFn", node);
+		if (!sgs[i].name)
+			goto out_sgs_sgattrs;
 
 		sgs[i].sg.name = sgs[i].name;
 		if (add_attr_group(ops, len, &sgs[i], sgid)) {
@@ -225,6 +228,7 @@ void __init opal_sensor_groups_init(void)
 
 out_sgs_sgattrs:
 	while (--i >= 0) {
+		kfree(sgs[i].name);
 		kfree(sgs[i].sgattrs);
 		kfree(sgs[i].sg.attrs);
 	}
-- 
2.50.1 (Apple Git-155)


