Return-Path: <stable+bounces-258476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNVCF9wnG2rM/ggAu9opvQ
	(envelope-from <stable+bounces-258476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:09:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A76686111C6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB7263003813
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC53112C1;
	Sat, 30 May 2026 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZN1Mo3Q7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EE340A6F;
	Sat, 30 May 2026 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164477; cv=none; b=IEBWQHFl3AZFSCrM0Y5Y1PTUWTFfddETwm3Hjat02VXhLP08U030QFdklS97mpu3NFrgwWZq6d1yr8Ca0Q4j+vOO38LKSaHv834JsVQvJJ6GmI0q3UFZqABNOcMQI8F6AWHpWMvfgYzzq93ITcSjNDBn2pTsXK3O98DdGSymNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164477; c=relaxed/simple;
	bh=k8Ce2JzHxTQZ/MC4Ob3bXP5OV/61Wn/Vfs9ip3g21fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJcTfQcCN9PB4pyo999Y9sa3Jc4PbEumrFoXdVe+n8NXnb+HJCjqOlNPOHlKQrNoEAD6naOsuwahYas1B68ETDzM1q0218S5GmkKwDoyF1s9X30dHyU+Fkqvdvus0dXDTV53aCQDKhVm+ZZWF61i93fDeouwNdCI+3WB/NrxsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZN1Mo3Q7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FEE1F00893;
	Sat, 30 May 2026 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164476;
	bh=zQZzK1p8S81CdEU3kVYKfjZiL+3YmxFCkjolzYpkRmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZN1Mo3Q7ILvT8Q3OFR/iYoe58xPbE5+1B2+ANL6EWPc+ZnXY8zlIq1ITr7KLVw10T
	 ON0H+NwAg8WQ2k2RjJPVkvlIeqR7rnVBWwRJwGjXg5VuNhzl3481QWLLPMj3uGK21I
	 RhGJ1Or3wdAo1GQgfZ4nOLzd091VTHYO9od5p+/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Sukholitko <boris.sukholitko@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 567/776] dissector: do not set invalid PPP protocol
Date: Sat, 30 May 2026 18:04:41 +0200
Message-ID: <20260530160254.771576024@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258476-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A76686111C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Sukholitko <boris.sukholitko@broadcom.com>

[ Upstream commit 2e861e5e97175dfa7b7bc055c45acdc06d2301d3 ]

The following flower filter fails to match non-PPP_IP{V6} packets
wrapped in PPP_SES protocol:

tc filter add dev eth0 ingress protocol ppp_ses flower \
        action simple sdata hi64

The reason is that proto local variable is being set even when
FLOW_DISSECT_RET_OUT_BAD status is returned.

The fix is to avoid setting proto variable if the PPP protocol is unknown.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: cc1ff87bce1c ("pppoe: drop PFC frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/flow_dissector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index ba437cfcbe90f..537dbd7fc5438 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1207,9 +1207,8 @@ bool __skb_flow_dissect(const struct net *net,
 			break;
 		}
 
-		proto = hdr->proto;
 		nhoff += PPPOE_SES_HLEN;
-		switch (proto) {
+		switch (hdr->proto) {
 		case htons(PPP_IP):
 			proto = htons(ETH_P_IP);
 			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
-- 
2.53.0




