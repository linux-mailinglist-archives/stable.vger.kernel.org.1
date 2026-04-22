Return-Path: <stable+bounces-240357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJt/OLLy6GkdRwIAu9opvQ
	(envelope-from <stable+bounces-240357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:09:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49734448437
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8711307ECB0
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85C37FF69;
	Wed, 22 Apr 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2GBCcGM"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FD37DEA5
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873912; cv=none; b=KDay0eEJp1koC/Du9YYviyhzgAsJUWv3fR995/3rpprIC0fssya5AKGu4ZQHUDg/l9Xxpzk0U2uphKWcs5OuVOneXoQ9iFHEWQa40iYN60V1UzdLwKWpUfjPwDTOT0v2WwaQGQwUI2tXQfZXTqWTJ/wqdcFC9Ac7iIbGX+SA+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873912; c=relaxed/simple;
	bh=VZEs0jCnFC8H/qkvnT27RK2A5MyzuOg0UJ8UJ0X/Bvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSRMuO7ccR4M5q27ANnV/DSEE0JfMbLTOWAzW4rhrhflaWcRre1YZ2qA3syubbil/WyOh3jcKyN0b+f5jaaRfHWXFIzuH6YyvGfa1q0z+H7K7v4iPiQt5O2xa1ZfHG4XTZeeSeeEd3fRah99bDiFsSFQ9fdrCdy+K/QtZ+1JVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2GBCcGM; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d891442388so8646788eec.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873909; x=1777478709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j25ZLlpELNU+5nioGRIXycqczMeWBKR/3eVX7cdAHw=;
        b=e2GBCcGMHG0QpPUpxaApWMuLj6PXzU2Wr+zxcpsv5Tux9S8rX5y1bZ96/W/DdWuW/2
         t/wpLWZ/zdDBeft8QopKsqxISrZr5VQfy5n0k18dTxQHBLH4ZrBSIGJIwWm7PMgcRaUz
         +ekMujxNpYQKUqYMC+WSh7V9jBvTumc32I1vGHuez79FuPToRabuVOG4TW7WXn7p6A7t
         OPC9IIjTq+3AkUtz+S4/TS151Ia3goSbUBH50xT0vZRJWoSGzmoo29wILktPcm679Dcu
         8IIV5lm5ARgbk4KJgpf3RpMG7fBxU5MA42L/U/8djFh3zNM+FelOynpxoPaEQrXGc9pn
         hYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873909; x=1777478709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8j25ZLlpELNU+5nioGRIXycqczMeWBKR/3eVX7cdAHw=;
        b=ovwONYk0EzIhxzk2AFSAmkMsalZ725SiAlsMHxAFkco/bE0khiG+WOdGq4V/dEiypr
         H4zu+2eFTt4qlFQqEJEXrpWKmSjFhChwGvRzEUxOrmBzHGBqBCGzbVI/GrtsXY5NiBY0
         OQg1Y0ysx+mLr1IQiG8nCTkSyflPWj8kbV+74EPIh+SIfeVokawO/iRlxualW8idSpyO
         /iRJrj+tB23NNnx+urZe6Afwi20VEJOY3axgZxdSiGnmJqjEeC5TQv8MD+iTT13wHU8N
         AwV8xQlpjbWoVzuvH6WW16hUh+VuwtvgDE7w1uBBDedUE8Bb+msTBiHV6njZePPsISQO
         2FFA==
X-Forwarded-Encrypted: i=1; AFNElJ8jyUhDW9zatK+OGBzBoNqICHSmQLXx7NB1LXadNv/vawNBgxj88NnjXAkaE1DAH16sw8Yn9dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJUk/bjJ5pwAAi6oFhiIwCjPXIL0tqiP6pgVC7Vrr3/9buceGA
	o8rNg8/zKGlEUtlkf+peeOXHH3LYk7X4SJfsVmj39LvIHLAgvWdeY/Hs
X-Gm-Gg: AeBDies9C7L3VrqLLyGVR+vfvXOmoTaDZfal2V2U1wbV+3XEXsi58KmsgSBQ9iYiM9e
	8eJzXzBG4YnEbIVPXETOXpO9OYRIaZFLN9Y8cxAg/qj42yAD7Pd28OiEIIKhEwC0tQahKsL61RE
	7adturZY2iXwFfW+PqMzLVpa2O43jV8iIu5g9Min2BnAXamjAB0aZQBYUYz/jtptfduwG33icKI
	6AR4WxC4Gpr+/+Dt1d7vhMBc1kfiS+LS5f0ik+TM7dGynEYX3MAphVr0YnWP2OutVITcKAXRCil
	UhhmVAvMMYQ/OzrI9shT68z5AEhqi/E8aHHp7+MhZQ81/rmhxETfe7F1F+D2bV9wFoPXVUq09j3
	83hRAVxymM4u/nFSUVYapjeGcJ1McRroGtkEYcXfrFfQzKsRnmksUvG1vFA1E1MmcWpEEDZ19IY
	lDJElab9R1gqeoN/cSu+PBA2bjxkr+thmHRdiqC6Tc6apTqJMkZUHs6raYYH0qrKb8dat6yM0Cs
	wP8dg0fB6j/F6HF8X5zrS8JiPotjxQ=
X-Received: by 2002:a05:7300:d516:b0:2db:2089:460f with SMTP id 5a478bee46e88-2e478c1ee94mr12945274eec.19.1776873909017;
        Wed, 22 Apr 2026 09:05:09 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:08 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/6] net/ncsi: validate GMCMA address counts against the payload
Date: Wed, 22 Apr 2026 12:03:39 -0400
Message-ID: <20260422160342.1975093-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240357-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49734448437
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Get MC MAC Address responses carry a flexible array of provisioned
addresses, but the handler currently trusts address_count without first
checking that the advertised payload actually contains that many MAC
entries.

Validate the fixed GMCMA fields plus checksum, then make sure the
address_count fits in the remaining payload before the handler walks
the address array.

Fixes: b8291cf3d118 ("net/ncsi: Add NC-SI 1.2 Get MC MAC Address command")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 47ddf2bbb13b..cbddb2012f90 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -40,6 +40,14 @@ static bool ncsi_filter_is_enabled(unsigned long enable, unsigned int index,
 	return index < nbits && (enable & BIT(index));
 }
 
+static unsigned int ncsi_rsp_payload(struct sk_buff *skb)
+{
+	struct ncsi_rsp_pkt_hdr *h;
+
+	h = (struct ncsi_rsp_pkt_hdr *)skb_network_header(skb);
+	return ntohs(h->common.length);
+}
+
 static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 				 unsigned short payload)
 {
@@ -1127,9 +1135,21 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 	struct sockaddr_storage *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_gmcma_pkt *rsp;
+	unsigned int addr_bytes;
+	unsigned int payload;
 	int i;
 
 	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
+	payload = ncsi_rsp_payload(nr->rsp);
+	if (payload < sizeof(rsp->address_count) + sizeof(rsp->reserved) +
+		      sizeof(__be32))
+		return -EINVAL;
+
+	addr_bytes = payload - sizeof(rsp->address_count) -
+		     sizeof(rsp->reserved) - sizeof(__be32);
+	if (rsp->address_count > addr_bytes / ETH_ALEN)
+		return -EINVAL;
+
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
-- 
2.53.0


