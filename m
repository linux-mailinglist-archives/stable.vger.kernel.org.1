Return-Path: <stable+bounces-237983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO4/Jm/P3ml0IgAAu9opvQ
	(envelope-from <stable+bounces-237983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:36:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D43FF0EA
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4961300C0D7
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADF3C4542;
	Tue, 14 Apr 2026 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="04JAb1MR"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster5-host11-snip4-1.eps.apple.com [57.103.72.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07299303CAB
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209771; cv=none; b=aU1lO9yBe/KEjyJkjLTUh/ZH2ItJ2Fa0JxCiBJnEP4aNphxvS3JbtkUgjQnn7wc2NqrNXLuwhhBo854N4drqAeflKx6r8A8GuwGv/GsQ7DJgEFYJWVpkKxn+7XaFeLOFJJW2h8Ps58EiKcyiWFKpcH3yl18duEcxTOyUwOlcC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209771; c=relaxed/simple;
	bh=liaIf8mk3ClIG66+FMlWN5Lj0XtendDylxyecG6Cp8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VWm3+en59splKrPNoVm5l3tadsCGkES90awsTZxfSqwjjKTilLlyAZHNyselYIKGaoPu0T/bc+aPjquIo5s2JLtVKWHCc/nxPk5iuiL3qiQlcK4U2PdSrKPdqJ5uM25Mqzv643PUVjca5QVKVFgfZzdd6ZCNEXzjgrrE1SWLNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=04JAb1MR; arc=none smtp.client-ip=57.103.72.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPS id 105C318000CF;
	Tue, 14 Apr 2026 23:36:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1776209769; x=1778801769; bh=Jrzww6qgwfWE9yECgprU7sFvmUJeciqHUUqb2Ja9g9A=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=04JAb1MRwB0OVJhbjuWH2iLvOG7zksVslGL6Xw2GqiLCrmRNakCPk+RWQ9ZuCgWrytrk0F73Z3R0MuG/Z4zJryjRjbJH3yV9H5LiPQ8WgLYYpRS7IUgR9DYwvdLzv2sp7x2pBVQlbqshnC72YRULdUyv09b3RorhU+IGNSQme3whvkVnZQob6+7iB4fDGaksymcSjvAORXEspVJI+77t7+vK3EZsDVMz8qTWxMZRxylLaKry9BtVjcRFY/h4I3EM54XpDxeENQRoNiBB/2dkp4HMEdWYNLpWfIRz9Mab/KBy32IpsRJkCFdGFlG2yYrZAW6x3bDhUrCAguVJBtzHIA==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPSA id 6670418000FC;
	Tue, 14 Apr 2026 23:36:04 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <framemain@outlook.com>
Subject: [PATCH net v3 0/4] nfc: fix multiple parsing vulnerabilities reachable from RF
Date: Wed, 15 Apr 2026 01:35:29 +0200
Message-ID: <20260414233534.55973-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LiepSwMM88gkrc9LWwHV0LvXA1XzBxPX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIyMSBTYWx0ZWRfXwEfijQVBuvPq
 t+lTccMvJhNxKDZgiIr+44R1TWBPldzPKD3dZivk6KBwwhVToW8rnAfREAP/7hXjazGnJ52APi0
 9e5Qc6gwX769JX57lUJqT3suSiIHETiEonGEub03QDiStbjUShRm4Xof74Wcn19KeW3hX/waOpB
 bgDUt48W2TSBTHrwMqH0LxyHYA//2/rIKvoFb6GxNEhEYdfr1tTvUqc61YykdUCvanb3O5huKUq
 Tj18FDV7+Box96Ki0qrArCHGXYF/TCgyBJoAcp+94AIAnJbbPB89AyrnZYVw7DRpmzOqVqjxbq8
 RDuUeISK/qFZd+jUQNDNoI0Y2QQkLiS9tVyvLIOemlV/NsazqVHv/0ZcTHXdjQ=
X-Authority-Info-Out: v=2.4 cv=L4cQguT8 c=1 sm=1 tr=0 ts=69decf68
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=jKCiv9OuvI1guS1cGhQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LiepSwMM88gkrc9LWwHV0LvXA1XzBxPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604140221
X-Spamd-Result: default: False [-0.54 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237983-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,icloud.com:mid,outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E3D43FF0EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

This series fixes four RF-reachable parsing vulnerabilities in the NFC
stack.  All four are triggerable from an NFC peer within ~4 cm of the
victim, before any pairing or authentication.

Patch 1 fixes a u8 underflow in nci_store_general_bytes_nfc_dep() where
a short ATR_RES/ATR_REQ causes (atr_res_len - NFC_ATR_RES_GT_OFFSET) to
wrap in u8 arithmetic, producing a bogus remote_gb_len that copies up
to 47 bytes beyond the valid activation parameter data.

Patch 2 hardens nfc_llcp_parse_gb_tlv() and
nfc_llcp_parse_connection_tlv().  The loop guard does not prove that
two header bytes can be read, and the peer-controlled `length` field
is used to advance `tlv` without bounds checking.  An 8-bit `offset`
against a 16-bit `tlv_array_len` compounds the issue in
parse_connection_tlv() where the TLV array can exceed 255 bytes.

Patch 3 fixes nfc_llcp_recv_snl().  The SNL handler accesses skb->data
before verifying skb->len, and its inner TLV loop has the same two
weaknesses as patch 2.  SDREQ handling additionally requires
length >= 2 because both tid (tlv[2]) and the start of service_name
(tlv[3]) are read.

Patch 4 fixes nfc_llcp_recv_dm() which reads skb->data[2] (the DM
reason byte) without checking skb->len >= 3.

Changes in v3:
 - Restore the u8 -> u16 `offset` promotion in patch 2.  v2 split this
   into a separate v1 patch and did not re-send it; v3 combines the
   promotion and the bounds checks in a single patch (Paolo Abeni).
 - Return -EINVAL from nci_store_general_bytes_nfc_dep() and propagate
   the error out of nci_rf_intf_activated_ntf_packet() rather than
   silently accepting the malformed packet (Paolo Abeni).
 - Drop the style-only paren removal in patch 1 (Paolo Abeni).
 - Condense commit message in patch 2 (Paolo Abeni).
 - Consolidate the length >= 1 checks before the switch in patch 2,
   keeping length >= 2 only for the llcp_tlv16() accessors (Paolo Abeni).
 - Tighten SDREQ length check from >=1 to >=2 in patch 3; the handler
   reads both tlv[2] and tlv[3] (Sashiko).
 - Add patch 4 for nfc_llcp_recv_dm().
 - Send as a fresh thread rather than In-Reply-To v2 (Paolo Abeni).

Lekë Hapçiu (4):
  nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
  nfc: llcp: fix TLV parsing in parse_gb_tlv and parse_connection_tlv
  nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl
  nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm

 net/nfc/llcp_commands.c | 24 ++++++++++++++++++++++--
 net/nfc/llcp_core.c     | 16 ++++++++++++++++
 net/nfc/nci/ntf.c       | 10 +++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.51.0


