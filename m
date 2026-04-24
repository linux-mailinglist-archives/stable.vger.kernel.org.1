Return-Path: <stable+bounces-241020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGmYDCaz62kJQgAAu9opvQ
	(envelope-from <stable+bounces-241020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:15:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DF462513
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 677AF3027B45
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C13EDAC5;
	Fri, 24 Apr 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xLYyjlrh"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster2-host7-snip4-1.eps.apple.com [57.103.74.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EF3ED5D5
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054415; cv=none; b=Gwnsba5ssZ89zi4/8Hl7se9PUzQ0r+pFFGaeoHhFZKPMOUAS7FMttWCFryhDiCTAaNgyUNIzVCOtL2oxO970zyRHz+8GOe7DSOvot+rNyfnSEuXV+mGveuv46lNC+HwiEh5lbuYccPKqhj1r3cpOUqRU1x3nGQf7Bel9bXW0T9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054415; c=relaxed/simple;
	bh=+CHD0fEoJWn3fFn/KfO4j90yc+63AD9FgEVrAD2TZQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V58g6W9MjepeCgy9ABxgDZTkrKwmU/tcoH+b2/WaIk/iVS4Vj5a1FePFDK0NR+xd4KG3PBxGRh7YFXnGtrINtRClG/Kpy/xDGKJD2IoLo/9mbj9bzCL/3a2Lot03E1SgvjDWCBdtQaKt5DN5ghzWgor6mL8Wex6Sq9QwstsFoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xLYyjlrh; arc=none smtp.client-ip=57.103.74.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id 5B5B11800411;
	Fri, 24 Apr 2026 18:13:32 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQNFF0sCTVIPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTVEPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTUUID0EJWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEEVABWB5WXloXXk1aAlZNBUoDXwFbBkINSQtcBFsFXgpAAl0AWQVdC1VAA1gcRRxYE1YtXgheH0wcHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777054413; x=1779646413; bh=ARcHAicRpRjLP0pYofw0nIp4STtCphXvqS3aZMSFMgA=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=xLYyjlrhJ46VRkYAoQPbYprSe/mzNgMxvs9BG88JKBH+dgyVSviskSQRtsEPrpmdoomnhYz24YWI3qdlNRl5hZH7WOy5r8/9aLQschQ6gZ0Ioye+y5Hu+aUNB8fQshbgksx3zBP4qqVf24y6C9Gj4C4OOAT1SEonIVnsLsJRWOAwThUJw350gfo+pmcGbIZxyy9mLY6xmkIhJhMXj9Tcn6btDknnkkHFC5XdJHizlQJ9cunuobc/+HdH4KD+rAPaq5ZPW5jinaSg7fYrOd5Za22NEkphWQi9iMfSRumgGZ0CqSyfMG9E+kw9neUJkH0E3OhQVN0yI8SVOxbdusbQmA==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id DE1391800434;
	Fri, 24 Apr 2026 18:13:29 +0000 (UTC)
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
Subject: [PATCH net v4 4/5] nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
Date: Fri, 24 Apr 2026 20:13:06 +0200
Message-ID: <20260424181307.3810727-2-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424181307.3810727-1-snowwlake@icloud.com>
References: <20260424180151.3808557-1-snowwlake@icloud.com>
 <20260424181307.3810727-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: x5fOlyDxLj6XfiVsW-OnqNNHywzSXXBR
X-Proofpoint-GUID: x5fOlyDxLj6XfiVsW-OnqNNHywzSXXBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3NyBTYWx0ZWRfX0V6UfoUExX34
 +c62nF7ifP9UhBTz48ekeRNBq2VXdxfDxOAc8cv6SFd+0ZAsTHOsUHoMiBJwUKcAm7mXdQxAXZH
 QAvQHC49R3K0NWNuXUCubPipc6w4KW05oLRbqL1qpPfAm2H6OhmIxS+fVNSJS80yF97QcTbj+8o
 8NYeB/RimWg+s8FyDfXkocHgIrZUbyzu2rNmX+O91qc/McrjwLt4LTESy2rGKZawUkL1HNrkuq7
 ds3Rx1FIlUebFdtgP0WhKpKafswFbOZfRj29AQtXBEL+lXlaMFFgMzbS8yilFcO/qYd918CFdDO
 01hMOKVI2VrKBJ37D9rS4iEQh5wY026uuyT4nZ+A+6jgzszMTNpgxF62Dj6y2Q=
X-Authority-Info-Out: v=2.4 cv=BZXVE7t2 c=1 sm=1 tr=0 ts=69ebb2cc
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=DIMQZ1PCNJLnr07J7f4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Rspamd-Queue-Id: BF3DF462513
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.63 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[icloud.com:+];
	TAGGED_FROM(0.00)[bounces-241020-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com]

nfc_llcp_recv_dm() reads skb->data[2] (the DM reason byte) without
first verifying that skb->len is at least LLCP_HEADER_SIZE + 1.  A DM
PDU carrying only the 2-byte LLCP header from a rogue peer therefore
triggers a 1-byte OOB read.

Add the minimum-length guard at function entry, matching the pattern
used by nfc_llcp_recv_snl() and nfc_llcp_recv_agf().

Fixes: 5c0560b7a5c6 ("NFC: Handle LLCP Disconnected Mode frames")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/llcp_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 3284be517204..ca0abfd329e5 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1239,6 +1239,11 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	struct sock *sk;
 	u8 dsap, ssap, reason;
 
+	if (skb->len < LLCP_HEADER_SIZE + 1) {
+		pr_err("Malformed DM PDU\n");
+		return;
+	}
+
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
 	reason = skb->data[2];
-- 
2.51.0


