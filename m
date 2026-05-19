Return-Path: <stable+bounces-249434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME7eJaC7C2q3LgUAu9opvQ
	(envelope-from <stable+bounces-249434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:23:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B70576058
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5BEC301B330
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FBB257855;
	Tue, 19 May 2026 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjiWy7Gt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1122E6CCD
	for <stable@vger.kernel.org>; Tue, 19 May 2026 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153789; cv=none; b=n07SDKa3dmvqKPr8bIjXLwtamUf/JStpAYaw1tKMdcghkGh5AKnbtmwX+P28k9g2WMCFHSr16tZAI/9UPJ/iwiJTrgfdv+/Y4g79unJuMnfZFo4avAvfUWGVUfFm9Mi/1lEsouDC6tPeOfHDNzg932aEg4A6tznBs1BNl0KVtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153789; c=relaxed/simple;
	bh=VeXWv1s7VjIj16f62IeF3AHt/aQZkX3KYCOUQT1VU0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkGG9TRlPYGXkE4G5pKbOU0fEyHv6WZShq/IURsSWBlo7i/k3zmY0SSZuWXWPyQjx6CAEo8tJObfVoskMdiVpuSteSi+DeoinbU/9jFMwOJwi0ISJh9hjnptytdG+UR5h5T77MQSIIySmo/RdHiji6hA9L6ToPW/NPUxXdVPEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjiWy7Gt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d102471a4so23361735e9.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153783; x=1779758583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsZN4KBbcJX1FoY6/tUwgCFPOKTIi4RrtSn6JymXQo4=;
        b=DjiWy7Gt2o13EAY6WreAHqQWHjsPARbZ3CbVns8iFOnfswX4upOkm0Vj1eqVk0TJom
         VzBsOUAcToXs2dIekG088Cc94uQ4DkiBAZwlVSDVfVdJmmpbqHAP9/evg995SToNLvOP
         7ZzePy7P5OJBn0GnaTip+Uf6FSPt5ihuJtrfoEIBJxz6AboQH/we9q5hGirTeCAgGsOn
         Rj5P4OVcGbZ6ed+J8Q2+gs5qmDySAiNjJo8c7XOsSuiepUSwlWXttf8Zb9Z/JfCsSj8S
         7HH7VxFjm9A3VV9XxIH+dDfYCKp2eLB8vptaQVtAxG4OqGaUNdkoZ9CfpmKvh/xHM6cM
         r7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153783; x=1779758583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsZN4KBbcJX1FoY6/tUwgCFPOKTIi4RrtSn6JymXQo4=;
        b=cGkgkQs7sRzrJqG8aRBuDBH/l/oCTbdKvvF7HttPka+9th5iSsWeeMUrFhGX1LqjQL
         dyf7gaSauDhhCHCoOncC7ShHpIKAxwmh/WJhIRgg0zs1xAvZJQdOlFLZszcjY8jbdbf6
         GZdYjs0PS0saBAqLfaDPYMjjNt9rdWjO0QK94FI3xBFjrjH40PjpnxFRJ/AX578xANvA
         SpGmK2rMUSNdxwYC9XGqf1pr2fMqWn8wlsQLhMHJk3/lnebaxKOlwf01GywtQSDVvgum
         /JhavuBI1m9ZF2QBa8SUIN1zTVR21hyCIv2bN6U1kkMdhdgJKC0F5bpQVxAcfhET44zV
         Dc8g==
X-Forwarded-Encrypted: i=1; AFNElJ9IOTjbdx0BEP+9zL9xvb9wddcuDEJeJ1TDRSgNAYmPlGoQLqO+HGtEpgXNcOlFV/wV8ls2rnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5nU5CNWZ454AwyE80bB8lJhATgB7rO3F9oGCC2TqJWlKoF0U
	vI3I9KueO/1fiFP5f31nuDstHqoJUivvLSPgp01gCuO5ldoWCwEXAsDL
X-Gm-Gg: Acq92OEKzvsJz2mKHmDSHN4pyF9FW6Y8ZNhV3W/fDFZhA7RBZxuMXvQjtdrN9aIvlXj
	33tZ6sfVhHoUuYYnpC8DNPCvY0iQbtwmNegcjoFqkaPbYzMRpLQ1/Nyl6To68s9mFUw5Gj9G+2S
	Axmjp7IwtEISmMMUr703pKe9RBqDgzZqtt9po0WHMhugjMHLic4mAuRt9uxTiE7AGJY0Za33vf4
	cWcAO3lQA1+9oybEeLWxzXSqPN2abo/ADs0AwO3fduFAZOdX+JG3opIwnOVeml0r+BgV27xg88R
	bRHbTlZhvyN2weWp7axNScEiMCag7pC70nVZORHtL5Z+DxeQY3O1D14LRnyfhLfuVgvCnpAGimJ
	4ITiJwNylH+Rda/D6I8Dx/5LsBo2pDg4AXS3jQWZm+/g9gNi11L4ArkfgbPTfw9wH3O58zgCWdQ
	HRTWOLEtyAntl0ynpGF9bHI9bEjHWxxxGhAdnn/wclghJhtHaweCDneSe6s0t3oEJvzr8Zo9xfd
	021lT+tYx+h
X-Received: by 2002:a05:600d:10:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-48fe60d7882mr221269375e9.13.1779153782352;
        Mon, 18 May 2026 18:23:02 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm44255416f8f.10.2026.05.18.18.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:23:02 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	david+nfc@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net 1/2] nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers
Date: Mon, 18 May 2026 21:19:36 -0400
Message-ID: <20260519011937.12903-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519011937.12903-1-meatuni001@gmail.com>
References: <20260519011937.12903-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,ixit.cz,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249434-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,nfc];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B1B70576058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() contain
three related bugs in their TLV parsing loops:

1. 'offset' is declared u8 but tlv_array_len is u16. When TLV data
   advances offset past 255 it silently wraps to zero, causing
   infinite loops or double-processing of buffer data.

2. Before reading tlv[0] (type) and tlv[1] (length) there is no
   check that offset+2 <= tlv_array_len. A truncated TLV causes
   an OOB read of one byte past the buffer end.

3. After reading the length field, the value bytes are accessed
   without checking offset+2+length <= tlv_array_len. A crafted
   length=0xFF on a short buffer causes up to 255 bytes of OOB
   read past the buffer end.

Both functions are reachable without authentication via
nfc_llcp_set_remote_gb() which feeds remote LLCP general bytes
directly into nfc_llcp_parse_gb_tlv() with no additional
validation.

Fix all three issues by widening offset from u8 to u16 and adding
bounds checks for both the TLV header and value field before each
access.

Fixes: 3df40eb3a2ea ("nfc: constify several pointers to u8, char and sk_buff")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/llcp_commands.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26fac..9162f8161 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -201,9 +202,20 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len) {
+			pr_err("Truncated TLV header at offset %u\n", offset);
+			return -EINVAL;
+		}
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len) {
+			pr_err("TLV length %u overflows buffer at offset %u\n",
+			       length, offset);
+			return -EINVAL;
+		}
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -243,7 +255,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +264,20 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len) {
+			pr_err("Truncated TLV header at offset %u\n", offset);
+			return -EINVAL;
+		}
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len) {
+			pr_err("TLV length %u overflows buffer at offset %u\n",
+			       length, offset);
+			return -EINVAL;
+		}
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
-- 
2.54.0


