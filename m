Return-Path: <stable+bounces-254133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ke9CNI9FGq6LAcAu9opvQ
	(envelope-from <stable+bounces-254133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:17:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C765CA5C5
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4A7430166F3
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D4837FF64;
	Mon, 25 May 2026 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mp0HBVZj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06F30C60D;
	Mon, 25 May 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711436; cv=none; b=TUVP9ov+cn0rVcqdeu+AG8emXAWhy/VrRPAeKZEeQDoCHuPHx07/4yS+SMZeAiV80B1T9AGrKKNI1qFM43nz7oF5vWQm0ZXhPPlhNovkiKcnayRKZgQVYoxfFHOMtz64m55Xfe2QW2JKldC6kycVf9XRxOUCwyUTkoJJvJ81JfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711436; c=relaxed/simple;
	bh=LRqS8dLqxx3er5S7LA1Vegh2QYBORecCeaLuSPru6OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INKlnICvJDhv9wtuCXwgruA0SPa7qmYM0iOCOeMb/7VveXczoc137epdSWZ8rwcO5Hk5+agWiiwp0KLULx6qjywcW1Qd44J0OJUq/u/8TtlNRZ0KjEx/OHnJjRzvYaKNwfzHf/IbGokPkYfesmw2jDATt48SHJygm8UNAGlxTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mp0HBVZj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJo5e13032008;
	Mon, 25 May 2026 12:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kcbhuYVnIyM0gO1Ey8OTwYSmRoXUoO+BdnB7Gvput
	xg=; b=Mp0HBVZj1/HtF9sBIL6MPfsxSIyjH4SRA7eXNKIJlsdiaBrkwuREZxFFU
	OqZ5OSZryje6H9/mOd2KZKYdrvrOei9rPLxoBgqgKERTdQHbeFXBo33xjDtZgk0l
	cctvz1m0diw1QcK+F9+i75+VjVQZVJ2JNi6GfynoMuedFuIuI6FBjrZv5bEK+wr3
	LVsxRIgyBn46p/X3eIo0+w2Cjt7YgpVzmAt+4PbkSbY0oiW9leDqFWKXpl8lDREr
	mL7uyR3P9PG+BwyD4owiZU4LrMghOPpU/TROP8urvBVJWtwvwLbKH6vQA4bsS29H
	bfLaCiOx2uV5oq4BuMNPgpV8+JH4w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nbxwre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:16:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PC9AIC011263;
	Mon, 25 May 2026 12:16:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjn2x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:16:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64PCGikO42860928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 12:16:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F151C2004B;
	Mon, 25 May 2026 12:16:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2275D20040;
	Mon, 25 May 2026 12:16:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.218.95])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 May 2026 12:16:39 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH] ppc/pnv: Fix null pointer deref in pci hotplug
Date: Mon, 25 May 2026 17:46:28 +0530
Message-ID: <20260525121628.3906457-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a143db1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=lml1KbhEJxe8kdhi6MYA:9
X-Proofpoint-ORIG-GUID: B4AjfRteot1akFQ4FhifVoHIFDoqMvAJ
X-Proofpoint-GUID: j1ytpDlrHCLjuc5MFTTqjFIu-2Pq4kAT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEyNSBTYWx0ZWRfX8DynBRZ5R9JV
 A47tk1xLWQfh15pvCoJ/kWw821rXRAVTVUQkZEHsAYrz2muZdyg2ZKeoYU+AST9sWjxzJTFmb0R
 SXVl67H3QIR9WRRfGZUu6Gts/PdQtzg2qZQx7rIY5UqMr7b2iAd4lv5B29z2d0vPL7rpuWoHYgp
 bwgF7qB9EZMK2xmkCoUnc1pIssEW5G4/Bxs91WvvyyJOkhIgBzrb9B3FtAmpHFoQcsVFq99ITsb
 SlTyohakBR1o63i4e6O0yxfNJ/BtQUbkrzj9c9NN8R8iymLm/kprGIjTQ4nNL3ROHFQj8redOMY
 LLJGn/ElQIHT6xtTgXQv2wtdGakUXmokgvRtLNKLUvi1puWlJB6SfwVQjGRCQ4zEt9tmsYuE8Ys
 kapZad0DEMwU+218zFxJoFTUSlTfIeFgoBSXI4d9vwEggGnhaUGUqoKOGFzuxgehvWVGCG2MlQp
 p98HsvNkCnk55IHZ7vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250125
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254133-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ellerman.id.au,gmail.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[adityag@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: C3C765CA5C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With upstream kernel booted on a PowerNV system with OpenCAPI device,
below crash is observed:

    [    1.568588] PowerPC PowerNV PCI Hotplug Driver version: 0.1
    [    1.569722] BUG: Kernel NULL pointer dereference at 0x00000074
    [    1.569811] Faulting instruction address: 0xc000000000b75fd0
    [    1.569890] Oops: Kernel access of bad area, sig: 11 [#1]
    [    1.569963] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
    [    1.570037] Modules linked in:
    [    1.570099] CPU: 250 UID: 0 PID: 1 Comm: swapper/248 Not tainted 7.1.0-rc4+ #1 PREEMPTLAZY
    [    1.570207] Hardware name: 9105-22A Power11 (raw) 0x820200 opal:v7.1-142-gbbc276524497 PowerNV
    [    1.570325] NIP:  c000000000b75fd0 LR: c000000000b75fbc CTR: 000000003008a65c
    [    1.570411] REGS: c000c0000688f6f0 TRAP: 0380   Not tainted  (7.1.0-rc4+)
    [    1.570494] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28000284  XER: 20040000
    [    1.570636] CFAR: c00000000019f9e8 IRQMASK: 0
    ...
    [    1.571492] NIP [c000000000b75fd0] pnv_php_get_adapter_state+0x60/0x154
    [    1.571604] LR [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154
    [    1.571690] Call Trace:
    [    1.571725] [c000c0000688f990] [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154 (unreliable)
    [    1.571783] [c000c0000688fa20] [c000000000b78bd0] pnv_php_enable+0x94/0x378
    [    1.571951] [c000c0000688fac0] [c000000000b7912c] pnv_php_register_one.isra.0+0x11c/0x1e0
    [    1.572077] [c000c0000688fb00] [c000000002091318] pnv_php_init+0x168/0x1b0
    [    1.572111] [c000c0000688fb80] [c00000000001103c] do_one_initcall+0x5c/0x450
    [    1.572162] [c000c0000688fc70] [c000000002006abc] do_initcalls+0x15c/0x29c
    [    1.572283] [c000c0000688fd30] [c000000002006ec4] kernel_init_freeable+0x224/0x3e0
    [    1.572484] [c000c0000688fde0] [c000000000011578] kernel_init+0x30/0x268
    [    1.572562] [c000c0000688fe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
    [    1.572667] ---- interrupt: 0 at 0x0
    [    1.572720] Code: 38810065 e90d0c78 f9010068 39000000 99210065 e8630020 4b6299c9 60000000 2c030000 418000ac e87f0058 89410065 <a1230074> 55290636 2c090060 41820044

This NULL pointer dereference happens due to the call to
'pci_pcie_type(php_slot->pdev)' without checking if php_slot->pdev is
NULL.

This occurs for hotplug slots on root buses where bus->self == NULL,
such as OpenCAPI PHB direct slots. An added debug print (not part of
this patch) confirmed it was opencapi:

    [    1.617227] pnv_php: slot 'OPENCAPI-0009' has NULL pdev (bus 0009:00, parent=NO (root bus))
    [    1.617308] pnv_php: slot 'OPENCAPI-0009' dn->full_name='pciex@603a000000000', compatible='ibm,power10-pau-opencapi-pciex'

Add a NULL check for this.

Cc: stable@vger.kernel.org
Fixes: 80f9fc236279 ("PCI: pnv_php: Work around switches with broken presence detection")
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index ff92a5c301b8..21ce7ead9e19 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -414,7 +414,8 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
-		if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+		if (php_slot->pdev &&
+			pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
 			presence == OPAL_PCI_SLOT_EMPTY) {
 			/*
 			 * Similar to pciehp_hpc, check whether the Link Active
-- 
2.54.0


