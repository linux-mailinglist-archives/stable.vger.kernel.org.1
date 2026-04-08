Return-Path: <stable+bounces-233750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HFdAHTa1Wlo+gcAu9opvQ
	(envelope-from <stable+bounces-233750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:32:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7033B6D78
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C805E308FFDF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 04:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518B1280325;
	Wed,  8 Apr 2026 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MNqm3bzR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78934D915
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622557; cv=none; b=bhqZrxG3ffSBmQliddDsqYJkESJEANRxRroiE7xJllzl/zJszeWf5XpTJE0ywdQ3gHkEkXpGI1BaghZHjtgkcxAvdTlOELrKv7sgKP/eAZF47qFPD1/5xk5N9CgoN+BfNBTn3LSdrf1KdzUNZkJsPCdC3Tv9UW7B+3bl7aVmuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622557; c=relaxed/simple;
	bh=cIArHoKWW7M2L+bV7yYtINAteT1ZKzhrMcOGmUn6i1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyiGxZ2v60O/UEbLBx0pdY+xmis0q4UlSR4oLtD/T3NrgvPjqomxjJJZx73nRV6j9lgwtGkL+HV+fMT93Wo4vdSh0al8wrg82aztxmz1dQFRF+bMP2Sh1K3Qk081H39cHq1TpJx1YH/5EKh07br9p5rICXKWbL2GZ6lfStpdEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MNqm3bzR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DK1DQ2297920;
	Wed, 8 Apr 2026 04:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vRnjyU
	rhxcfoZPRura3rLTuODCZMqQIqjwvce3mBf9U=; b=MNqm3bzRfWGgi/TLn5da9x
	I7Kb9FLPfZA3THeSVUC7e0Hiyj9m1CMGxNHBe8AwIedFbwukXuYDXQiSrBK7JNyI
	pg1IL5h7Kqx46DrG67QuYbmylWUXJAYDlRZW0ZpjExZQ/PHhAlJFzzPNwNw0+TFQ
	2EfocfCKxcrLBCEt+3+WFnVib5Mgj9ObHohnPfmM9JoiXhLCdvLfQTKi4FLP6O06
	x7HTuJUuGN0HlGjtKswqlTLavXda/VGQK7E3y7PtsZMUkk6UJgUFTT/uN2pdm+Fr
	oPKyp9lP4EiWU8AvGsGdSlpYGU6Wh6+XDnFo08pAiudV4+VI91L6Ba7gwzJkWkxA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwrst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637NwmkW030062;
	Wed, 8 Apr 2026 04:29:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7dysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SvVj29950274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 784132004D;
	Wed,  8 Apr 2026 04:28:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E9720040;
	Wed,  8 Apr 2026 04:28:55 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:55 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: namcao@linutronix.de, mpe@ellerman.id.au, npiggin@gmail.com,
        maz@kernel.org, ritesh.list@gmail.com, gautam@linux.ibm.com,
        stable@vger.kernel.org, Christophe Leroy <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] powerpc/xive: fix kmemleak caused by incorrect chip_data lookup
Date: Wed,  8 Apr 2026 09:58:54 +0530
Message-ID: <177562236416.1381144.5101696715064742344.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311134336.326996-1-nilay@linux.ibm.com>
References: <20260311134336.326996-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5d98e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGwZmBqalxsbcZeRzjQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bBCfRcRgAkZLsukp97XLVoO6Dj3vri2N
X-Proofpoint-GUID: u6olKVah22N5aIGIO2sJnKoVr_01cIOG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX4MMAHTOxPtLo
 1hFpFt/WbSQDOZtB0Lr8avdFT1MBCCm0tkwoN6ix/sl0LC+rh7LIkSbQTLH58NMT8pIRVrzmK4Q
 UCLY7hWWoe4KYxtKXAnmY20aDiWs7QdoT1wcvV7Vr9u0LUad0wO8gqcy81BMaHXBd778kwMMRAF
 agHwV4FcVqjNNFVAV1/WvTbVOaht25ZMVEzStM8Fyr0wbk7jV86bKBZs5q9jmYNohsr7Kq939Hx
 yGLj4K0t6jBCtsXOpKBeTA+n+sJ9KIvXwhsa39NSyvIPe4WTOTxNT0pUB4trh0PYkMw5UOyfDu4
 Xv/mNvn/dHkeH69sRhZGZTGeG95zGynxQ2nk3wDjzRob55gvSkC6sZpALTTIuZmFGW8NrZbWA3O
 xVRLsUj5FnbdyD+Xv3FbXhhxZal7a/Z7ZPFwdmTX6dFvSTDgVQhooPWg+A0LbkZ061LUorqmVQ1
 amvZicI95FE/WYXz6JA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-233750-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maddy@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 6D7033B6D78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 19:13:31 +0530, Nilay Shroff wrote:
> The kmemleak reports the following memory leak:
> 
> Unreferenced object 0xc0000002a7fbc640 (size 64):
>   comm "kworker/8:1", pid 540, jiffies 4294937872
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 09 04 00 04 00 00  ................
>     00 00 a7 81 00 00 0a c0 00 00 08 04 00 04 00 00  ................
>   backtrace (crc 177d48f6):
>     __kmalloc_cache_noprof+0x520/0x730
>     xive_irq_alloc_data.constprop.0+0x40/0xe0
>     xive_irq_domain_alloc+0xd0/0x1b0
>     irq_domain_alloc_irqs_parent+0x44/0x6c
>     pseries_irq_domain_alloc+0x1cc/0x354
>     irq_domain_alloc_irqs_parent+0x44/0x6c
>     msi_domain_alloc+0xb0/0x220
>     irq_domain_alloc_irqs_locked+0x138/0x4d0
>     __irq_domain_alloc_irqs+0x8c/0xfc
>     __msi_domain_alloc_irqs+0x214/0x4d8
>     msi_domain_alloc_irqs_all_locked+0x70/0xf8
>     pci_msi_setup_msi_irqs+0x60/0x78
>     __pci_enable_msix_range+0x54c/0x98c
>     pci_alloc_irq_vectors_affinity+0x16c/0x1d4
>     nvme_pci_enable+0xac/0x9c0 [nvme]
>     nvme_probe+0x340/0x764 [nvme]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/xive: fix kmemleak caused by incorrect chip_data lookup
      https://git.kernel.org/powerpc/c/6771c54728c278bf1e4bfdab4fddbbb186e33498

cheers

