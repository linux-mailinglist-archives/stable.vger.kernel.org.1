Return-Path: <stable+bounces-235517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHUJE+I32GlWaAgAu9opvQ
	(envelope-from <stable+bounces-235517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:36:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458AB3D0802
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C565300E688
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 23:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6DC3A2568;
	Thu,  9 Apr 2026 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="phx3ueLA"
X-Original-To: stable@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2006l-snip4-1.eps.apple.com [57.103.85.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2B3A254D
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775777756; cv=none; b=qX9d0hUGLathjk890/RG/Q8ZiJi8cCOXjh64LaErw+FejdBW+Bwkzi5hy22AURHHSYmXWa820/ZMlrlN9capqa0DXcahW25QDX/v9tcn5JPIK2jXQZ75gxIVrT+FJUX+HGVoZEK5njOF57x2k5MApO/cD7Zqsp3YPth7QMYMbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775777756; c=relaxed/simple;
	bh=fIVdjJ4nA/At/OaVpVIeoD2VDE67BNQPUm/z89spOBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZarTXTe+Ck1jGKLpD/Sy/gUr+zi6n+0aq4uE9yV49ICdWObndGPKiazKhhRgYzV4vc0FgYn+UXkg17Q2xg4NNvGBMZYrAZofnifPJE3BgTlm0Pi3xdkXhyTgmrXFfRMyvIG1wNMy99QZHj03nMAVL+fFVf/nPU9e0Kie6khNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=phx3ueLA; arc=none smtp.client-ip=57.103.85.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-5 (Postfix) with ESMTPS id 0AC5618000B9;
	Thu, 09 Apr 2026 23:35:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775777754; x=1778369754; bh=4wbWKJiuGa3lp3h91TcAJgj5nreIv8DzdANlgKm+/+8=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=phx3ueLA22G+coO9rdxEMIYJZKdlrloBAgmdcvkHxWsMmloLip8VlAHcAJg8piM6qnk1ewwLxszAp8Ggk51Etq6gptZ8lz0fGRKVkiWk3s3e2o12OXvt9roiI7lT/wosL/airdfZcLvV0hnBfQh2V19424Oz6rSava8jAe4ZQpAL4EqsdfycH6DmDd3UFzrrSAfEB8n/vBUeXRrBk+dVy3g1TIqaUo7HqcJCVRFaqQJytN3PhJN10VrYdxQWD9zwW4/qsWs3meReIcW5WqnUtifXFTZYrFpK7zPO9KUNEtGdHeZx6f6X0s5xLtY8a1CoaC8prgrEvnGcTTTNlvXzag==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-5 (Postfix) with ESMTPSA id BBEB5180051B;
	Thu, 09 Apr 2026 23:35:49 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-nfc@lists.01.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net 0/3] nfc: llcp: fix OOB reads in TLV parsers and PDU handlers
Date: Fri, 10 Apr 2026 01:35:13 +0200
Message-ID: <20260409233517.1891497-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0Ymg3GRGmhS7R6NWrUsU79xuzFzq56uu
X-Proofpoint-ORIG-GUID: 0Ymg3GRGmhS7R6NWrUsU79xuzFzq56uu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIxOCBTYWx0ZWRfX2WO8TgrYBdaf
 JDL2rqVMw9S7cKCRrFm/7oD30pR8to9wOuZpupNYG6H/JDu4V1SXhC7YJt1muEW0fJFf56u/1eI
 f7T0oKsy1PnjS5Xe7pIKEPK/MEZlM5vPCwfT0KFAY5256FBNyfdN4ii0My8CZJt5tChPU1q8gaG
 O5cXRNDHja7DbO1sVUxT0QaELcoaA8LvAKX4mXm0xsY3jH+q92mzuIDpu6pJBdhIcVRLUhm+aDL
 NAhe44dyVU9eK7Wucfg/HnG1XGAnqMxBMaFRqfgRNRvayH5sUEB+DUSnqy8REs9cjxMYvNa774m
 tkExx9VAwHlaBN/hU866S3Y73+rkCueq5PAt6evF0YWTuAHFw++Jhfizzu/vjI=
X-Authority-Info-Out: v=2.4 cv=WIFyn3sR c=1 sm=1 tr=0 ts=69d837d9
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=zN5dko5L0ofWfovZziwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604090218
X-Spamd-Result: default: False [-0.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.01.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,icloud.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235517-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:mid]
X-Rspamd-Queue-Id: 458AB3D0802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes three out-of-bounds read vulnerabilities in the NFC
LLCP layer, all reachable from RF without prior pairing or session
establishment.

Patch 1 adds missing TLV length bounds checks in nfc_llcp_parse_gb_tlv()
and nfc_llcp_parse_connection_tlv() — a crafted CONNECT or SNL PDU
containing a short TLV value field can read beyond the skb tail.

Patch 2 fixes nfc_llcp_recv_snl(), which accessed TLV fields and
performed arithmetic on an uncapped length byte before any bounds
check, enabling a 1-byte heap OOB read and a u8 wrap-around.

Patch 3 fixes nfc_llcp_recv_dm(), which read the DM reason byte at
skb->data[2] without verifying the frame is at least 3 bytes long.
A 2-byte DM PDU (header only) from a rogue peer triggers a 1-byte
OOB heap read.

All three bugs are independently triggered via RF (AV:A, AC:L, no
authentication required).

Lekë Hapçiu (3):
  nfc: llcp: add TLV length bounds checks in parse_gb_tlv and
    parse_connection_tlv
  nfc: llcp: fix TLV parsing OOB and length underflow in
    nfc_llcp_recv_snl
  nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm()

 net/nfc/llcp_commands.c |  9 ++++++++-
 net/nfc/llcp_core.c     | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

--
2.34.1

