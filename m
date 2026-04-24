Return-Path: <stable+bounces-241016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KZGJE+w62mRQQAAu9opvQ
	(envelope-from <stable+bounces-241016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:02:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6BD46237D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BB1D300C98B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D621D3E8C62;
	Fri, 24 Apr 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eAVUPugT"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster3-host9-snip4-10.eps.apple.com [57.103.72.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798893E717A
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053733; cv=none; b=sZfvn7yfhcrW5xZ0t0ARq9Milwkw9pPnujJiN2P/VSqTOQ1om/UQC9ggDi/33rHmCHKWgrRQdGF8ArUeMZBW6AgLfB3UY4TUZ8L6vvWrkYIsiqxHRXiT6EfUpGJebcPmpXE0WFd8bH/guYR7486h76WGk5V46egyV8YPZ3EARCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053733; c=relaxed/simple;
	bh=f2wOVFiwASDq9Qjkkn83Qnffy6owmf2HGb1oVRNDljY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXLs1Xhphs+gQOsB8hVGvNbvMppyvD0bL3TwZYhNAyHaZ3cYqkWv8ZekETIT64YcerqV2UlSocFm5tXKwuTLkOGOAUJNQQMuG4dUt8xj4uAsH4i93uPlqC3pnsfhE9OeUO4I5FzaEiImaOIG3emSI5cCnz34kplh5AetbhkpNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eAVUPugT; arc=none smtp.client-ip=57.103.72.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPS id EAF3C18009D4;
	Fri, 24 Apr 2026 18:02:10 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQNFF0sCTVIPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTVEPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTUUID0EJWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEEVABWB5WXloXXk1aAlZNBUoDXwFbBkINSQtdBl4DXgpAA1UCXgVdCFVAA1gcRRxYE1YtXgheH0wcHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777053731; x=1779645731; bh=t4GIyWmTQJ1ec4FYSzAsx4+JeosbEvUchHbVxJOqpnM=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=eAVUPugTUGsSX/+8uCn0DNz4bDSjhPUGvfDy/UjhtweRviP9bJr0AjF4cH+l8ytReDe4akeKuvmURMsNc+/0BCIxFd3kOUGhIaAiUryc5FxU167iBXIq4i66zey3BdJFodzxUk57iCHRkkAAw4X38z5/rhUDULgmo9x3agxF/5yEqIitSpOr7FdFmAokI1uuqpHfNVulNJ5gP4aPjqsh3gAUnvuXrwm39v7e5OzUdwXEWTHiwDcJmWi/T56HKTqngDAl1fxG3q7ze0lioHeD5zNCBKtYC+S+wd7JRjGcJmzKW6cuxf/iR9mrJj+T6Kv3vJ5e0PPWGQWuNEIKT7lZRQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPSA id 7E81318002F3;
	Fri, 24 Apr 2026 18:02:08 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	krzk@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net v4 0/5] nfc: fix multiple OOB reads in NCI and LLCP parsing paths
Date: Fri, 24 Apr 2026 20:01:46 +0200
Message-ID: <20260424180151.3808557-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=GP0F0+NK c=1 sm=1 tr=0 ts=69ebb023
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=65b706y0IOD3bZGX9pQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8U-qltqzgrOVxWXo80Lb3_f0tqExWn2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3NSBTYWx0ZWRfXxVoEXlLq2yha
 JJuOFZX7MB4NZ24gPIhpYeQLMIflvzskrzRkAivVDgQOSLt9dL6XjlaitzdN9qHo+zjz+Tt/Cpv
 pzMuoXg6Ir164wNTbHTUIywG1jY800EO/oPibHmTICZkYb42/JAI3QThzM7Mh+P0IrxTCqoL47b
 xvpxcPjWfe52WhGRNer5AyfLv4o6SFuBUV/BhnPWdWUXMZZpBls+nRu0fedoAEeBl7Gatj4eeN9
 hC/dr+D6zhK9QiwcSeKEjk2Ue7/1pmLb6wfs1RsxTjlGjWN3GqKqdzc11WPSPrejAclV2ue27JH
 7HHgbFlB4y3RLwuXyhGRypAWNlxqv1CM+kL6C+T1zNniwTDs1BffZBPuetWLG0=
X-Proofpoint-ORIG-GUID: 8U-qltqzgrOVxWXo80Lb3_f0tqExWn2r
X-Rspamd-Queue-Id: 0F6BD46237D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.63 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[icloud.com:+];
	TAGGED_FROM(0.00)[bounces-241016-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com]

This series fixes five out-of-bounds / underflow bugs in the kernel NFC
stack.  All are reachable from a remote NFC peer that the local stack
has already associated with; in the LLCP cases the peer only needs to
send a malformed frame.

  1/5  nci: u8 underflow in nci_store_general_bytes_nfc_dep() lets the
       attacker-controlled atr_res_len skip the GT-offset subtraction
       and cause an OOB read/write against general_bytes[].
  2/5  llcp: parse_gb_tlv() / parse_connection_tlv() trust the TLV
       length byte without checking remaining buffer, and the tlv16
       accessors read past the end when length < 2.
  3/5  llcp: nfc_llcp_recv_snl() has the same TLV-length trust bug, and
       its SDRES handler uses an unbounded "%.16s" pr_debug() that
       walks past service_name_len.
  4/5  llcp: nfc_llcp_recv_dm() reads skb->data[3] without checking
       skb->len, giving a 1-byte heap OOB read.
  5/5  llcp: nfc_llcp_connect_sn() walks the TLV array with no length
       validation; a crafted CONNECT frame drops it into OOB reads /
       an unbounded service-name pointer.

The series applies on top of net/main.

Lekë Hapçiu (5):
  nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
  nfc: llcp: fix TLV parsing in parse_gb_tlv and parse_connection_tlv
  nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl
  nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
  nfc: llcp: fix TLV parsing OOB in nfc_llcp_connect_sn

 net/nfc/llcp_commands.c | 24 ++++++++++++++++++++++--
 net/nfc/llcp_core.c     | 35 ++++++++++++++++++++++++++++++++---
 net/nfc/nci/ntf.c       |  6 ++++++
 3 files changed, 60 insertions(+), 5 deletions(-)

-- 
2.51.0


