Return-Path: <stable+bounces-203041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054DCCE1CA
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 02:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C31630517D6
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A604227EA8;
	Fri, 19 Dec 2025 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b="l08dQAmd"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2006g-snip4-4.eps.apple.com [57.103.90.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557355477E
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.90.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766106106; cv=none; b=JseeW0DqzZpmgo7P+zIqY0cch4rBMC1tgFOn1PHN0vVDngVBiEQpXSXVgbdr7bMxBejS67U+twHolPKv3PlPOA52bul0nOotEDNJH64Gl4tspLEKrNQI8gMfJ692cZ9JA2vSXySsqkdiCx+2VnLiTFaAFwnPI65wu3/hgkyX0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766106106; c=relaxed/simple;
	bh=AhGbHnP05T541cYr30aKQmlP+d4jAKXFQRViMnW0JO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o52t9MaUiQt813WBR0o8FtDUlAmolGitFmnhkHH/VOxz8KSA4SInGmZEeNZmkTXICdIJjlIdocHq73ueUGxmC96yHfrgxQGmCFnUuVl9v2HaIoVAb2a4qXbylfLRfspdVSzWpZXO38rlTE/vULfB9/cNoBDrJ3SusP96QFakUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space; spf=pass smtp.mailfrom=ariadne.space; dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b=l08dQAmd; arc=none smtp.client-ip=57.103.90.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ariadne.space
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-9 (Postfix) with ESMTPS id 379DA1800976;
	Fri, 19 Dec 2025 01:01:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ariadne.space; s=sig1; bh=k/sGFpxfsXXE4bG/gLuHDwciH+XbI6Fj1Tr7xEr6v5E=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=l08dQAmdWxd78K9aTsjzZqQqJP20hlqWzb9XcSdc7O2beVBuqN5KJLLi68TMY5qS3fivMURmk7JkWRnxMmF4L3YuWUxVC9qvV+/fEn32BrjLmkzqUXSMNRl/vnbFhLl8xGPUvMscAb+1/axGSaDjH75cNi4BYfUPhH7/YYeauqNLp072Wrgt6RTYflDXEATzONN2x4pbf9KLjAU0C3UZelUN19B+1oS9Ijh/+RNVOeSRL9KG4EGn9AQFXdYKrXNTGBes2WRj4MO2FCfyk8ZZiITj/CHDF4nnvlKPho8nAFMcSl/DZ/aZccu5gJcGqcVKMeN7TWZ6LFxa5ukT3Jyr4Q==
mail-alias-created-date: 1688796967087
Received: from phoebe.my.domain (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-9 (Postfix) with ESMTPSA id 581AD1800950;
	Fri, 19 Dec 2025 01:01:36 +0000 (UTC)
From: Ariadne Conill <ariadne@ariadne.space>
To: linux-kernel@vger.kernel.org
Cc: mario.limonciello@amd.com,
	darwi@linutronix.de,
	sandipan.das@amd.com,
	kai.huang@intel.com,
	me@mixaill.net,
	yazen.ghannam@amd.com,
	riel@surriel.com,
	peterz@infradead.org,
	hpa@zytor.com,
	x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	Ariadne Conill <ariadne@ariadne.space>,
	xen-devel@lists.xenproject.org,
	stable@vger.kernel.org
Subject: [PATCH] x86/CPU/AMD: avoid printing reset reasons on Xen domU
Date: Thu, 18 Dec 2025 17:01:31 -0800
Message-ID: <20251219010131.12659-1-ariadne@ariadne.space>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=EvbfbCcA c=1 sm=1 tr=0 ts=6944a3f6 cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=cWRNjhkoAAAA:8 a=VwQbUJbxAAAA:8
 a=64mAIdLp92yHhwu-ie0A:9 a=sVa6W5Aao32NNC1mekxh:22
X-Proofpoint-ORIG-GUID: 1g18WFCENcLrMa1DtA2XBcKaizFIFmka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDAwNSBTYWx0ZWRfX/XpCqHGo7QO8
 XVEEd3U/KM52M38w2R3bbNH4op/A1zG3zWse8yplnN98hfQQ5GScFAaMWZDNnLjSsobxsn9wtMv
 oQD4cfxn1mcvBW42+XnjIq0uudpEieWbdtuH9wxL27zMjW38iPPiqYyOSazNxAL2Tflxazp73XC
 o6ltxRDRu65VSwW8mzkBKilupg+8at7y2zzy/nNK/fGqxggSYEp/UWRvvdWkzOot3zxqLpBOgsg
 MNX1TelkMr9UmLZ3yKxck5uWvPMpZAAcbShqnu1jujqsLH9nn02wKOgehR45nur8sPRegqbAJFv
 0Vjb/iS5jZOhSuLHKjZ
X-Proofpoint-GUID: 1g18WFCENcLrMa1DtA2XBcKaizFIFmka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=873
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1030 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512190005
X-JNJ: AAAAAAABr0Q3G94xuvIY8bsEvQNKzbJxhRRxFTbgzGxeuuI6C4zYTCLLh4fyc9dUpyIayNXyTsbSuWjV2AV54y4wdepy1oZRzxT1yakRmjtaGyrQW2y3wNZQTnMfpq7Ugrm8fiopawQF4k5T+2TL9XAykNLaotdeii7CwWE+aS/fDwEgTr/Vdya1EC76gKNdiQiU2Ikhj4OpKbau8+Wmz9+XrYGvly7BbqWkmc6rWCepubDzm03rOas3Pu8Ua3sqZtFsKeh+/ujqEC41cG3j8JOcyybKSb9pwuEw7q+0Sg4C/DsFUrBQ9vGmPZNeQXK5BxB8a2AUCJULS7XY/cU8qUrlgl1+gWwOBjQPrFjnyW9Delr8Us3j3WK3HyNEZQYXEEOkqzW1Lf1En3sIdS4PmdmfJJS2S7a3IM5z+Pcv6uEm+xTWRKCeXHF3BZ1xGimnSePcGtkbpLJP5RLw5fbOK/wM6T/cSP8d9RYbr50D1XJWoRw9o1rBQg3B12lHUc681qn8HgtRRf0OegUnzTTLD6J3Uk22T9Ek9iqvSBZJzTqG6FtiBZTLO01NTv4Aox6FZCjw84u4HXBBVd8dnjbueW6thg69a5AeocA2wQwl/5VSwx9M4CLpIm3g7tt62oVdJkxVcc6TxOWjgE8rqnJKDPzZ2dP8N2XTE5+WjgtJ3735dNOIm9AHEHuepai7KoKUxpI78edlvtC1Oo+1tY7zcauaPbJ89OHwXDGE/Icm4ZmhNUpHr8sIKO/3MxZD/6VPHqhroh4rd5OivC8uzGsxZCbH06iOmNFiD/FBPFvK6n1oh0Bj0ESDDeTQzvFX0SpT1y3bhx/KSjvEjmEfCVU=

Xen domU cannot access the given MMIO address for security reasons,
resulting in a failed hypercall in ioremap() due to permissions.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
Cc: xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/amd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a6f88ca1a6b4..99308fba4d7d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -29,6 +29,8 @@
 # include <asm/mmconfig.h>
 #endif
 
+#include <xen/xen.h>
+
 #include "cpu.h"
 
 u16 invlpgb_count_max __ro_after_init = 1;
@@ -1333,6 +1335,10 @@ static __init int print_s5_reset_status_mmio(void)
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
 		return 0;
 
+	/* Xen PV domU cannot access hardware directly, so bail for domU case */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV) && !xen_initial_domain())
+		return 0;
+
 	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
 	if (!addr)
 		return 0;
-- 
2.51.0


