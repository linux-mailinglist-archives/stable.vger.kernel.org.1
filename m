Return-Path: <stable+bounces-231868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE+gEo0BzGljNQYAu9opvQ
	(envelope-from <stable+bounces-231868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:17:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C334836E675
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD6F31BAC6E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A73FF8AB;
	Tue, 31 Mar 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yLfYqnTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9C426692;
	Tue, 31 Mar 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975275; cv=none; b=lUZ6fWZ7q0q36KilE9yXmeeVtJD2yCH2AtKeGoQyEVBiMZzrXu673WnJjY+3ssUfHAEXYjSuwua51SRLz9E78gOstWVIOZXSRbf4KTdaVz30dTtLSfyVqy+V+ZsoOS9yYK532bmqHSdP3Uxl8+hidbxa89+nbSVQkXbU+pY8RsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975275; c=relaxed/simple;
	bh=tpb3rcmkZQXcjosHZGe5nBYpyiMIQi7NVDGoegxtvoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQaBS45lYzNqQXiDQDjiN6owRtz3a/dDsJzbw2O1cvRymHsmIRnIdTRwm3ZR+TvJBCcmChsuUpb7DB0vWOvrb9YcRMtcAqdTSXKa1QfcZGRcDeVaYaiGABwZD8jP408l4d4RHLmljcqcn4gMU5XV623tR9hDguvMLNj6ESqGHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yLfYqnTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB60C19423;
	Tue, 31 Mar 2026 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975275;
	bh=tpb3rcmkZQXcjosHZGe5nBYpyiMIQi7NVDGoegxtvoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yLfYqnTr12KuXg51P+oxRGnA8jI+JXjE335NC2SfkX/EuCdZ3cCpLuxECxIT0grVg
	 OGUFSC7TxiYaOA85nJG8naKDfjOIan1CRqCy+vTVzV3RMfVs6twaUSiIr6PtNI2sJd
	 MgRhVaJYF2SYvyKFdPU6D9XyCRxABQ23VgcM0ZMw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roshan Kumar <roshaen09@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6.19 230/342] xfrm: iptfs: validate inner IPv4 header length in IPTFS payload
Date: Tue, 31 Mar 2026 18:21:03 +0200
Message-ID: <20260331161807.431811164@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231868-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,secunet.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,secunet.com:email]
X-Rspamd-Queue-Id: C334836E675
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roshan Kumar <roshaen09@gmail.com>

commit 0d10393d5eac33cbd92f7a41fddca12c41d3cb7e upstream.

Add validation of the inner IPv4 packet tot_len and ihl fields parsed
from decrypted IPTFS payloads in __input_process_payload(). A crafted
ESP packet containing an inner IPv4 header with tot_len=0 causes an
infinite loop: iplen=0 leads to capturelen=min(0, remaining)=0, so the
data offset never advances and the while(data < tail) loop never
terminates, spinning forever in softirq context.

Reject inner IPv4 packets where tot_len < ihl*4 or ihl*4 < sizeof(struct
iphdr), which catches both the tot_len=0 case and malformed ihl values.
The normal IP stack performs this validation in ip_rcv_core(), but IPTFS
extracts and processes inner packets before they reach that layer.

Reported-by: Roshan Kumar <roshaen09@gmail.com>
Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_iptfs.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -997,6 +997,11 @@ static bool __input_process_payload(stru
 
 			iplen = be16_to_cpu(iph->tot_len);
 			iphlen = iph->ihl << 2;
+			if (iplen < iphlen || iphlen < sizeof(*iph)) {
+				XFRM_INC_STATS(net,
+					       LINUX_MIB_XFRMINHDRERROR);
+				goto done;
+			}
 			protocol = cpu_to_be16(ETH_P_IP);
 			XFRM_MODE_SKB_CB(skbseq->root_skb)->tos = iph->tos;
 		} else if (iph->version == 0x6) {



