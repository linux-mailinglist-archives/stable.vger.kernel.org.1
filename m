Return-Path: <stable+bounces-238248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEU6JpNw4GlkgwAAu9opvQ
	(envelope-from <stable+bounces-238248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:16:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2740A489
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BCC430172CE
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9981333EAF3;
	Thu, 16 Apr 2026 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUKPg3s4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511E33EAF9
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316545; cv=none; b=lLVdigwC8mhRBC2rt2cvLxTNC45cwcIFvTI8xumjY1Oatn8WS+aT84bc6vpJO9yoT7xS7hSDGi7nLWBx1lL1GfkzhDAmfEVR/eJR2Gn6g3MRTYWVkg4EFy4wdCxm5vDVzrA7CLBJ7hlNgmUBw4zeydV+KsobdF0fL5XPA2AOXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316545; c=relaxed/simple;
	bh=eLfXVXZgzEWyDhaVKa2jFIH9cYfs2PbpAApwiSrZmhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HObvs7WIfIIocq+TLORKhDOS99hpCoJCUbgJN7kxfBY6letBWmaIeyIyZVKNyS8GlsziRnZb+694Wmjv3GiB7tyxZX9WE3vRZmpxbCxTwiFaaT+Mt6imRd5YrxMP5k3nWk7sckaoCnZKVR4nokOEUHaolygrqCUskNjjEZfvojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUKPg3s4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8e0a768331cso33992985a.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776316543; x=1776921343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+z6WLGdATwt4kYxsahocIe5C/Hu+LLRPnaW7GZKwbKc=;
        b=aUKPg3s4THsVTqzeW9Y7zlvGEH+P8s5f2a/vu6UGV/3MHKwjCLGYTnoB+9eSac7373
         kqJ8NuzuMKGUpFqO1DvqRSS7Dd39Y3rbU3l8se/IYg9HWUvztxRvVv0+iN61VnhqM2Ob
         ZHR/2uv5ymP7RjH0Q8vWqx88he+AzYPyqv/ouYw92t+Gp36rnO+AqimvJtdI7VxuPzkr
         zsAfTPE2FzwMwMJ+J9xPqT/TqeDbbiE/zaN1WUDFxxWdSCGje58cwNZRPXWkbG7VWUjn
         gc9uiT1tgODXpkzMgNVh9lyqSWaFhaZqA/J1gwSuCxKhL5azGcAO87A2qJO/LsZanS8c
         OQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776316543; x=1776921343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+z6WLGdATwt4kYxsahocIe5C/Hu+LLRPnaW7GZKwbKc=;
        b=IpalDhrligwECdUXI3Lrl93GqNM2KrMd/oroN3oii+hccMUQEACWThnAE9Fy9CaxCb
         qw4hCk1MU1ZUbeepm+uiv6r9Cl3uqPj0irvoyCF0oAuxWqK8S1qKxljb7QJyrca7CnnD
         SRba6XLTjj1k8BicpNtdnvW9c+ucAA39bcX+9kmmo2rY49aeUVrnUdAQZ744eWKACvvF
         c3aQQTBxbtggtE0KRYp3HCa3Hhueir/aU5HG8BofdtbXhzgLelyXhrwg9IchxLxTz8fL
         YRoeKJaQ+psOrD3f8W1sgFTyKFsf+CCfECpolA3zd5SYUxUTB7ib3/dkSfHZFILNOGyh
         o8ww==
X-Forwarded-Encrypted: i=1; AFNElJ/yit+9iM7tG/5uUfDwGzRYVVm2zOgq4gqQXz1HcxxhzPP2KHxikAo+vOuiQG42M3pWXPP5H0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YylzVxaLSPuNJEThwOXIG7pP3ObI4sAV3syGf8LIaSZU7TcTlYJ
	BzxiweiLpzQKl0fjRZ46mKkURUo4b6dpO8he7FK63mpD4FMxuIc2+YeP
X-Gm-Gg: AeBDieupvMl4r2HYCg+gkSsXCOhzNYnESanB6fz5JOfMHZOXy6V8gRCqujYa9mOxTtS
	Plr5YpIc1pRRz40tg3tUb8D+eLbfNdClhuWO4G3vpyx/PO4zu1kF3p7AL2XAQBrgVeLVj1YAD+H
	cH/hBVrqrUBNhMHqbmDCBMfuP0k3Akp2YJhvG8FkBGIzBtAnxyG+qVf1xPfOfd4cZNp6vhCo2o1
	J4ncMJBbE7NmEsOaSMgt6r3LkKVIxwP1/3TbaLHHBOYi+PQ5968XLc2oyoYl2qNF1sCE6gjW4Yz
	MfuTD+c8bM3wE1kobSn5cmKg2aYQbmhx7Fj+0v8PwP2uTf96jwTEg3p0lou5X24rzQp4jrgRxIM
	Y5edD9Dk0rW8b3wc1C4cibMM3S+AkOZy3IQfZCuGScyIdt0+jYvY6SJOccHhmxezOVC0C/gAN5g
	KscXwr8c2R1bsk7UPVPeDxMyTc1+7sFLQCIcFR5CVNesFRV1NNlk52gDTVMKtWkMz6Ls3p5QkHT
	15oFWI92gf6f5wMBKujEcg6ZArro+9cuRSEfaN+Ap6Yg67tBQ==
X-Received: by 2002:a05:620a:4690:b0:8cd:aa61:ad8f with SMTP id af79cd13be357-8e689330904mr24288685a.14.1776316543080;
        Wed, 15 Apr 2026 22:15:43 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2926001sm278457985a.34.2026.04.15.22.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:15:42 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v5 net] nfc: hci: fix out-of-bounds read in HCP header parsing
Date: Thu, 16 Apr 2026 05:15:22 +0000
Message-Id: <20260416051522.4154698-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238248-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AC2740A489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_hci_recv_from_llc() and nci_hci_data_received_cb() cast skb->data
to struct hcp_packet and read the message header byte without checking
that enough data is present in the linear sk_buff area. A malicious NFC
peer can send a 1-byte HCP frame that passes through the SHDLC layer
and reaches these functions, causing an out-of-bounds heap read.

Fix this by adding pskb_may_pull() before each cast to ensure the full
2-byte HCP header is pulled into the linear area before it is accessed.

Fixes: 8b8d2e08bf0d ("NFC: HCI support")
Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
V4 -> V5: fix whitespace damage
V3 -> V4: add Fixes tags
V2 -> V3: drop redundant checks from nfc_hci_msg_rx_work/nci_hci_msg_rx_work;
          remove incorrect Suggested-by tag
V1 -> V2: use pskb_may_pull() instead of skb->len check

v4: https://lore.kernel.org/netdev/177614425081.3600288.2536320552978506086@gmail.com/
v3: https://lore.kernel.org/netdev/20260413024329.3293075-1-ashutoshdesai993@gmail.com/
v2: https://lore.kernel.org/netdev/20260409150825.2217133-1-ashutoshdesai993@gmail.com/
v1: https://lore.kernel.org/netdev/20260408223113.2009304-1-ashutoshdesai993@gmail.com/

 net/nfc/hci/core.c | 5 +++++
 net/nfc/nci/hci.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index 0d33c81a15fe..cd9cf6c94a50 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -904,6 +904,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (!pskb_may_pull(hcp_skb, NFC_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)hcp_skb->data;
 	type = HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NFC_HCI_HCP_RESPONSE) {
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 40ae8e5a7ec7..6e633da257d1 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -482,6 +482,11 @@ void nci_hci_data_received_cb(void *context,
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (!pskb_may_pull(hcp_skb, NCI_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)hcp_skb->data;
 	type = NCI_HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NCI_HCI_HCP_RESPONSE) {
-- 
2.34.1


