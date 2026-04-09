Return-Path: <stable+bounces-235491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL3eMVz312mrVAgAu9opvQ
	(envelope-from <stable+bounces-235491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:00:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4519C3CEEB1
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39E87300E3C5
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2096D2F744F;
	Thu,  9 Apr 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="g0OXLDkP"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (pv-2002g-snip4-2.eps.apple.com [57.103.64.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A04194A6C
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761239; cv=none; b=BtP2ANWwuL1JIWHkgjedzboujQpn+VuGf+rNyDJR0BCalA/ieVY9e8M7a8y/6nJFb0NkAQ0NOR8n+a/xwwAMuBLRlvcDgjQPiWq/gm5r9AT1K0a971CEigIpooHRki6iiPptz9clg+Z4j783TiDLH/TJJUmo4HwE1D4xMx9HFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761239; c=relaxed/simple;
	bh=9j2+CSWGYfEdlRdVt5URx1MysjOO9HtzpJmsPQM0fLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsO0+4FWRVaIkUrVfzDJispzK1y7nzV2ihpYrWpjMegaMKkA3eeN42sz8tNAjP0CHt0RvTQ2SnCJRjFQERZQo1TTbGz8zMbV53AtJnO6sCdCnmgRr4wqxMx7RG9f2XmZBrWQdiICmnp1EuILF8T9sO5dwGU8UQQkV7Zs+xyYeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=g0OXLDkP; arc=none smtp.client-ip=57.103.64.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPS id EC4E81800103;
	Thu, 09 Apr 2026 19:00:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775761238; x=1778353238; bh=Ikg3Nb4XMZrtOpv/HDmjHcsfW6ZiiVa0yKifuLisqBM=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=g0OXLDkPaTYykAvcL7YCaWRA3p73dpMNlZpkw/3Je/3Q1DE6PWreL4wQ0lquZJdf+OvutJv+Z5okM0d5rkWkPnfcdiLdAMRW2FR74ZjmRXEtc9/j2mEV1TfcNk9uOsjmTSoVmSNVBCqLWOEyE8b97QlnDz963seAEaHZnYkNWgpbtYPhn5sC/uzrRNZ46bwNkBqV9jZVNyAqJCeUpENAzDUjMl0sREifhqhsMrGH/rhezPKuLRAlUU00ZB+VA5akx5HWOYsNZP5MZtmUEci0DqTsfcB4P71CoTCCL5oNh9gvu1GbSgO3QSREtAcpERQGzQXThwoaO312uLTW27JVbw==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPSA id 5BA79180094D;
	Thu, 09 Apr 2026 19:00:33 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfc@lists.01.org,
	stable@vger.kernel.org,
	horms@kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <framemain@outlook.com>
Subject: [PATCH net v2 0/3] nfc: fix chained TLV parsing and integer underflow vulnerabilities
Date: Thu,  9 Apr 2026 20:59:55 +0200
Message-ID: <20260409185958.1821242-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260409164129.GO469338@kernel.org>
References: <20260409164129.GO469338@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3NSBTYWx0ZWRfX+PXn2pVmTg5K
 lSP+IUmzxptFLT0omgY7HCNdWAPhYWwnZroKmf1RzUdBRz1ASzLTgUAiBFXh8NuNJxaBmNSoPIY
 cjN417ohQuxLR359YrC+VT98lX1dJKWSXjQjcI7FEz4Sqt1u7eUAhuMHXVyoH0beuuzoNtz9X7z
 92IMDauWVo0SLygrwKaxhzOwB4fq8/8sRHzLWADgVJQPpaCDxdiZ0ThbXZxBKMxKUwM1Ev0TFTw
 EvnAgfJ4Ah+kW353GRKRcsntXtqqGnAQhAy6cpRj9TfY7NYLS0dHB/qdCkRtf+OHQSGOvmBEFuP
 dapSN+41P2vpWDRlIHtS960CtxgF0hBIsp3+QQ7izAFmeaZViPzPXPp1xuiBYg=
X-Authority-Info-Out: v=2.4 cv=CZ8FJbrl c=1 sm=1 tr=0 ts=69d7f755
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=htZpkJVHQczNRnQL7vMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=zesNzv29S0FE4YlguZl3:22
X-Proofpoint-ORIG-GUID: uTnDW9Cg7ssq99_fbMeqEe0uQzGl3hNB
X-Proofpoint-GUID: uTnDW9Cg7ssq99_fbMeqEe0uQzGl3hNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=930 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090175
X-Spamd-Result: default: False [-0.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lists.01.org,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235491-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:mid,outlook.com:email]
X-Rspamd-Queue-Id: 4519C3CEEB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

These three patches fix vulnerabilities in the NFC LLCP and NCI subsystems
that form an exploit chain.  Each bug is independently reachable from an
unauthenticated NFC peer at ~4 cm range; together they create a path from
controlled heap disclosure to heap corruption.

--- Chain summary ---

  [1/3]  nci/ntf.c — nci_store_general_bytes_nfc_dep()
         u8 integer underflow: when the peer's ATR_RES/ATR_REQ length field
         is smaller than NFC_ATR_RES_GT_OFFSET (15) or NFC_ATR_REQ_GT_OFFSET
         (14), the subtraction wraps to a large u8 value.  min_t(__u8, ...)
         clamps to NFC_ATR_RES_GB_MAXSIZE (47), and a 47-byte memcpy reads
         out-of-bounds data into ndev->remote_gb[].  This corrupted buffer
         is subsequently parsed by nfc_llcp_parse_gb_tlv().

  [2/3]  llcp_commands.c — nfc_llcp_parse_gb_tlv() +
                           nfc_llcp_parse_connection_tlv()
         Two bugs in both TLV parsers.  The first, a u8 offset truncation
         causing an infinite loop, was addressed in v1 of this series.
         This version adds the fix identified during review by Simon Horman:
         the `length` byte is read from peer-controlled data with no check
         that the remainder of the array can accommodate `length` more bytes.
         A crafted `length` advances the `tlv` pointer into adjacent kernel
         memory; the next iteration reads tlv[0]/tlv[1] from that location.
         When combined with [1/3], a crafted `length` in the garbage-filled
         remote_gb[] can walk `tlv` past nfc_llcp_local.remote_gb[] and into
         adjacent struct fields, including sdreq_timer.function at ~+176 bytes,
         enabling a kernel pointer disclosure via sock->remote_miu/getsockopt.

  [3/3]  llcp_core.c — nfc_llcp_recv_snl()
         The SNL TLV parsing loop carries the same missing guards as [2/3].
         Additionally: LLCP_TLV_SDREQ accesses tlv[2] and computes
         `service_name_len = length - 1` (u8 underflow to 255 when length==0,
         causing a 255-byte kernel memory scan via strncmp); and
         LLCP_TLV_SDRES accesses tlv[2] and tlv[3] without verifying
         length >= 2.  Unlike the parsers in [2/3], SDREQ/SDRES are processed
         directly without the llcp_tlv_length[] table protection.  A missing
         skb->len guard also allows tlv_len to underflow to ~65534 if
         skb->len < LLCP_HEADER_SIZE.

--- Individual CVSS (AV:A/AC:L/PR:N/UI:N/S:U) ---

  [1/3]  C:H/I:N/A:L  — 6.5
  [2/3]  C:H/I:N/A:L  — 6.5
  [3/3]  C:H/I:N/A:L  — 6.5

--- Chain CVSS ---

  AV:A/AC:H/PR:N/UI:N/S:C/C:H/I:H/A:H — 8.3

  KASLR bypass via [1/3]+[2/3] makes [3/3] reliably exploitable without
  the race-condition timing required against the bugs in isolation.

All patches carry Cc: stable@vger.kernel.org.


Lekë Hapçiu (3):
  nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
  nfc: llcp: add TLV length bounds checks in parse_gb_tlv and
    parse_connection_tlv
  nfc: llcp: fix TLV parsing OOB and length underflow in
    nfc_llcp_recv_snl

 net/nfc/llcp_commands.c | 22 ++++++++++++++++++++++
 net/nfc/llcp_core.c     | 13 +++++++++++++
 net/nfc/nci/ntf.c       | 22 ++++++++++++++--------
 3 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.51.0


