Return-Path: <stable+bounces-235519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPl+FQA42GlWaAgAu9opvQ
	(envelope-from <stable+bounces-235519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:36:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F713D0820
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2989301E209
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 23:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA5639A07C;
	Thu,  9 Apr 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="oxyFN1Nt"
X-Original-To: stable@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2006g-snip4-11.eps.apple.com [57.103.85.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B73A3828
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775777763; cv=none; b=mlP7TzPWAt1Eb5gldYKtSBEz+xZMAQp0rm+DLZyfNe0SamrtDwR9CzAdYB/o/CqkiHwmAE28/yAu56zZstKDeZMlMNurtVgl6PaMtfKTRxZ16vftONcjNf2E19U3OZV8JHAQyBo0QdbjfMi/FNaWFUKEsanOdWn16gCqny/ywt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775777763; c=relaxed/simple;
	bh=hSmikPzgL8y6eywb49rtW54PNn5eTrNMeLGjlzHrm14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIVOgzrbaVH/mca2MsV1TfErI8BxdRNCW24zTM2PcABF4pYP2FMO0CgZM2wjd9n0dHG3g3lC0fL25eP2mB+rWC9c4GsojQ7Eoh9ltQ+Cjw+7Bsx/2cWdOagoThAOH6a5sf/cCJ9z4MPx6xkd/xJLIgh07JMNrNWFqEIctK0DRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=oxyFN1Nt; arc=none smtp.client-ip=57.103.85.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-5 (Postfix) with ESMTPS id 2E9F918000AD;
	Thu, 09 Apr 2026 23:35:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775777761; x=1778369761; bh=Pncu1TdC8zg7Z1v2RRAxFIwtm9RhRchhMjsfFUfzjrM=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=oxyFN1NtX0nWAn5BAWDoqF42Qgs/DsiWi5uU/QAD8SIiflXjp1NlGZInQmiQE/ldQX1sG3QZt/PFXAUX4nja77Eo1wuILs/VsWge8YBZ9aZR6etXPFuG/piuffxAFBXdoZgx8jbmx774PAJMbI4lFDx7afrbpTRFOGj/M4ctkF7kdarTFvY7NIGoVfk8k1mk+28I1DBJpdxwInU6tJGcA/O1Ge0qlt5nD5VIBNEQZIHb+Vj34FKYokxpWV0lJTyRRs2KsdeV/r+NdfBaNQeRZSM7wA4pO0lEZ4OiuVXRZn1IGPIH4NgTsh217eI1GZ1AEDfVIgBMH6ls4FI4y/vLgg==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-5 (Postfix) with ESMTPSA id 5DB391800512;
	Thu, 09 Apr 2026 23:35:57 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-nfc@lists.01.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net 3/3] nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm()
Date: Fri, 10 Apr 2026 01:35:16 +0200
Message-ID: <20260409233517.1891497-4-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260409233517.1891497-1-snowwlake@icloud.com>
References: <20260409233517.1891497-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xBBaHV0Zg4ManEfMMMiJ76dkxG8p9box
X-Proofpoint-ORIG-GUID: xBBaHV0Zg4ManEfMMMiJ76dkxG8p9box
X-Authority-Info-Out: v=2.4 cv=L6kQguT8 c=1 sm=1 tr=0 ts=69d837df
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=tGfLsbA8W4C8QkWIwgAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIxOCBTYWx0ZWRfX1zlm8WEsz1si
 5XrM7VKde0HyxNXdlR/n5GjNSeaMipRrd0jFUcNEjy/129uojkn/u4PtjAAgSZ0xpG7q8kbr5O4
 3X3d6Fw/uCBgk0gKAKvjcKld85B1sox061pLWllvESsbgWjUOPV2c8ZZqJAQvjfZueYjE41XOaL
 zi/AajAO+KiDpnswmLr57EyhZ+6zYbrJeEt45PVswI/oQfse9mSu/paasvv24rFFXJsPhg7ZXxs
 u+p47+CNCY3j6ve6F5jXfdkbH2R19X2iNf89CnmbUsQHNK/hLuC3ujxdeE2KU6y91k40pF7IaLT
 SOpkz7+aQmWA23EMthcXwx97nwICi6/83QvuoGHExSkGaCcz0owT5lXWvtCmhI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090218
X-Spamd-Result: default: False [-0.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.01.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,icloud.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235519-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:email,icloud.com:mid]
X-Rspamd-Queue-Id: E8F713D0820
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_llcp_recv_dm() reads skb->data[2] (the DM reason byte) without
verifying that the frame is at least LLCP_HEADER_SIZE + 1 bytes long.
A rogue NFC peer can send a 2-byte DM PDU (header only, no reason
byte), triggering a 1-byte out-of-bounds read of kernel heap memory.
The same missing guard also leaves the nfc_llcp_dsap() and
nfc_llcp_ssap() macro accesses to data[0]/data[1] technically
unprotected against a 0- or 1-byte frame.

Add a single skb->len < LLCP_HEADER_SIZE + 1 check before any field
access, consistent with the guard added to nfc_llcp_recv_snl() by
commit ef8ddc69c ("nfc: llcp: fix bounds check in
nfc_llcp_recv_snl()").

The DM PDU is dispatched unconditionally by nfc_llcp_rx_skb() with no
prior length check, so this path is reachable from RF without any prior
pairing or session establishment.

Fixes: 5c0560b7a5c6 ("NFC: Handle LLCP Disconnected Mode frames")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/llcp_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1247,6 +1247,10 @@
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
 	u8 dsap, ssap, reason;
+	if (skb->len < LLCP_HEADER_SIZE + 1) {
+		pr_err("Malformed DM PDU\n");
+		return;
+	}

 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
--
2.34.1

