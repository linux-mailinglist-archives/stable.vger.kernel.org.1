Return-Path: <stable+bounces-244672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIcDEe2F/WmefQAAu9opvQ
	(envelope-from <stable+bounces-244672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:42:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ABE4F294D
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70BB3300868C
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 06:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD237883E;
	Fri,  8 May 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCRLw1IV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0AE2EF652
	for <stable@vger.kernel.org>; Fri,  8 May 2026 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222561; cv=none; b=QlR5kMz694LedBQSrZ1HERwGjZsWQT880Nuxxq0cJ1FbOTLaHlCpY+IrolifjonSy+x85XbnVuNDWacOAgY4zeEa2drxpKiTftqC0/UClZOcb4G4bq+D2tck56bNbGJZnA0/nhqp4VO+Gon0+l15xBf7e7ihS18nkkdUWBlRSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222561; c=relaxed/simple;
	bh=0quxifnJ6eLNYHMyHf/CXF5opgcByfW/LR54z4sJXnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bidrtZFOVRSVOeK5oxEB/hyhNsPyIB63MeLVVLe1siSZcfo+hoDjBTp3sK8zVNIpeAfJuDPqC20YmHRkPiH3qbg4cL7wQwp+V4oW6y/iHki8U5hXgiPHCkB27AmxS5FO5YhVnN0bKH61iUF+NTnBLxmYH5llXAXovNYOFZp7rmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCRLw1IV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bab82d75fdso9388095ad.2
        for <stable@vger.kernel.org>; Thu, 07 May 2026 23:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778222553; x=1778827353; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Wj6RD6FHkHjiXXRtgdNiP7tVxbDGuEYZp49mnK7Ji8=;
        b=TCRLw1IVUs7DHRiFDSP5x8/n4YALVhX9ye73CWRywLCU0aGnG0k/UYc70OYUBlUL85
         JBRY+0wR3MDQs0TIyDj0JY025kF/sulLy//sOZD50mdYuXb4aN6ZdPCyLqzLniV0vqXS
         sdY+VXvusTtkOfmcQKdJiNEq8KvqE0dW+fVd0kxDc5TjQynKCZpQ6raXfMcFeiLicGyM
         6eleTnc5/LC4CKk1ThPWBofoHLBXZsM/spyosUBOYI9Xct1O+bc5LGbcYlX9CGcpL1uz
         TMrqXH81M6gcm/SU+9yb50ytvnowrmGSoR8nHTNFY4/gYBE/K8Vr+J57Ogx3c8Qf0w/a
         ZA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778222553; x=1778827353;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Wj6RD6FHkHjiXXRtgdNiP7tVxbDGuEYZp49mnK7Ji8=;
        b=AcD674rO0tAq8Q9M2P1yy06LHg/adzYjPyHxcrgOJkXq09ZBwEZx/j2TmTDe4RLwHl
         IvsPobUC/LqESHzwNQu2upAPLGHX4iCSBbNFGUvjBeJ9/5Hphmu6VcrSp0uGA/1bTolh
         +ORJHxDqa+41TincWr7Bhow0faz5LTMj/ZEu5V2Ze5JwmT5vQ17jOE4ulrT5vGEQ0FVT
         Y4J/1i6QSO52FCXQ8rcgsNZPmd+2b3QqN4jpYj5CPTBVn6f1+Tgk0YIPO7k55ORyr17h
         YL93QH1iL2Vx5rW1cC5lWUq/EIIgoIpOqKnNfIBpjcsh0bfHCz7AFNbCc1e9g24JMc2d
         rzHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yVT8RFvl/QvJJlixsHhcMOv4WK5hlnjU/L59UM7QnptdMOxLQJC0Xx0/vO6TL3nMdxLxnUzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMycXjImP8VIieiHdrKlsybY1ePyl0p8Lo0d6oBQJ4mkW1kP0O
	CmvyYca2VSZIJZ0hfamyMNjlD/aLrwkjaB77sfiSZtmzAm7ws2wJSLPF
X-Gm-Gg: Acq92OHkoUnmRtI9SDB9XrgB7qp9FnWY0KPkImlxArC7m1A9yWduf31B4auz4Jx3omy
	dvhKOa1ajurpn+YS1nGmKsteuHEMO5PE2l2bGr+l//qLKPX8TStIOoVJzYdqlJDuC7KZa8GgD/e
	BjXr66YPUKSq/mqz+DCiENkdHuDwPrLaVFDCq5MoeAJu6JMSg+RQTjh+9Dda0bL+pi3GPp4+g84
	yGeBzQt18Epcjif5U8ec9loYSzN/iNvTaCBGrhPoREuNbi+whfNcQwTjNrEpOh0+amC2q4aMG66
	6Y/O9Aag31wMBf5cbBDk7AaWZzoR20rX3d8lYfwLEVODJGjmA0fX03zHXNAKboWPUABnwIXXJw7
	OhXsE0OmfVFtRxmGC0axtVWiFZQvFHAQBSlrDgtUvotFAql+W9vfLItdrj7O6+peoLJSeRdVzNl
	1HeI26T/tw2GepfHJk99PvivfU6rUqSux6ZLoa1dEOnfs=
X-Received: by 2002:a17:903:947:b0:2b2:5857:583e with SMTP id d9443c01a7336-2ba798bb607mr112847185ad.31.1778222553061;
        Thu, 07 May 2026 23:42:33 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e36596sm9559765ad.48.2026.05.07.23.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:42:32 -0700 (PDT)
Date: Fri, 8 May 2026 15:42:28 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, qingfang.deng@linux.dev
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] rxrpc: Also unshare DATA/RESPONSE packets when paged
 frags are present
Message-ID: <af2F1FU5d4Q_Gn1W@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 42ABE4F294D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244672-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
handler in rxrpc_verify_response() copy the skb to a linear one before
calling into the security ops only when skb_cloned() is true.  An skb
that is not cloned but still carries paged fragments (skb->data_len != 0)
falls through to the in-place decryption path, which binds the frag
pages directly into the AEAD/skcipher SGL via skb_to_sgvec().

Extend the gate so that any skb with non-linear data is also copied,
ensuring the security handler always operates on a fully linear skb.
The OOM/trace handling already in place is reused.

Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Use skb_is_nonlinear() instead of skb->data_len
- v1: https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/
---
 net/rxrpc/call_event.c | 2 +-
 net/rxrpc/conn_event.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fdd683261226..a6ad5ff6ec5f 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -334,7 +334,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 			    sp->hdr.securityIndex != 0 &&
-			    skb_cloned(skb)) {
+			    (skb_cloned(skb) || skb_is_nonlinear(skb))) {
 				/* Unshare the packet so that it can be
 				 * modified by in-place decryption.
 				 */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index a2130d25aaa9..632cbeff1f5d 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -245,7 +245,7 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
 {
 	int ret;
 
-	if (skb_cloned(skb)) {
+	if (skb_cloned(skb) || skb_is_nonlinear(skb)) {
 		/* Copy the packet if shared so that we can do in-place
 		 * decryption.
 		 */
-- 
2.43.0


