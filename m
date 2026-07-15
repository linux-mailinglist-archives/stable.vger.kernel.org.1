Return-Path: <stable+bounces-274735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SerIMDQhV2rAFgEAu9opvQ
	(envelope-from <stable+bounces-274735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 07:57:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A93DB75AC8E
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 07:57:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=nCsoSLEc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274735-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274735-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22520302FEB0
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB64F3B8111;
	Wed, 15 Jul 2026 05:56:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95C3B8105
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 05:56:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095018; cv=none; b=V+xv3G5+cZYWiliRQcfbtPrnu0rVmDUQnjm01LDF463+UqHaPw9T2joyMFM+DqQ+6kjRgDC9Alplw5KGw0Wrav1EGey7ERvEgK4utyq2Ay4CgE89j19q/AMUwvOHlJ164WXdaJNpQMISOznDt0/WmuEKezKTocvWqUn2TPPdqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095018; c=relaxed/simple;
	bh=esL/43unqiNUkBr/Ljva6pP91lPf4vb7RyxAP1zl12c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fx3dXir0aEvA7Sh7/qVdIEnfghh4CCMAhf7hYJC/OCpSqeAsORBpv5zbKKUUhiw1rv2fX1KWfEhceUOPpsm6Tua+U3eP0bM4kO1+YWU+V5EZoXwrzY3QG+NGNTobBLjOzLwaziYByOOH4QLYjVu9n+jCIVzZm6Q7vEIohvbqSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=nCsoSLEc; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1537385f8f.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784095013; x=1784699813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iueURVe0vlYIqUuAsBfvKYIJESyK+6jqiIp58cwZiM8=;
        b=nCsoSLEcjUE3qQ+jpRtBiSHZz+xWcrG9vjTNkYWF1V+0mZyK5KTd4njN7WY7qhetK/
         OLV6TrS5aBpEU7A3jLAubLcnSjYMHarXfQbbisTm2KEqGGAWfCnBmDGEa4/+zKr4ILNz
         oPrCPXvXflKVHA7+LJxKIxO4Wxw4/gpeRdhelvUv61j7S5qgGf31y0f07LaOTg2j9yPR
         SkeWsn18bLqGp/luj9vQw8oV3AWWt9clqvFOGVXZT892pz7yuPMDwF5jezGjLXJiU4Bs
         celWm3mRxtVW7t3XZ6kCAVqh7DFWhV6u4YfvXnLGkzXFGh5KbFl6n1KNbqEGCaynF5Xv
         pePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784095013; x=1784699813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iueURVe0vlYIqUuAsBfvKYIJESyK+6jqiIp58cwZiM8=;
        b=ciwBjE2bmsclJ6WQCtJmfYU8udrJ/11NBDawlWj8CJrHWAa+nNe5hcEkY/Fd8eWtEE
         VBGBcp8Ik+L0PslneJcu2eq91nfriNBxgIWyUma1Tur09oENS+Iprrpytv0viKMqNpi4
         0Nc7F1Z/7V3U29pPHbdrn+Bvs9tDorphHOVIbpalP0dWGs3YcvICWhgN1dEyyXfD1D3F
         3chXS53tdZVfTk2e31pyYltN6ggobVXDodiCFhyA+lBPSRyvEJBkqTbEa70Qlytl/Lcm
         m1XX/wLp2iP4IyBiraSLhfxgrDccB4GzEV7XFEUY7FoUwezgbOK7aj1r7Fpd7ADmrhxs
         3FeA==
X-Forwarded-Encrypted: i=1; AHgh+RqJUodzAsuTOxE2CG2XDGrR+g3zpu2C9H/86IMN0E1pAYXzFA8E+Hfa5f6tVOjiyKA3Nuj1WLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhjNNFq6/LyXaUIZgeBwskfT95+whrGmibEu0zb9XT9FQAt6l
	0tuXPU9k5/uEd4XlDRJRkpQ6OEi7J6fUsa+ojxEw13PB9WugigENJ2FCU1dyXq7AjKgV
X-Gm-Gg: AfdE7cnnlSd8hPdmqaYMDSUPRpmVQU6R/d/wq60b2SU/WvtxLghiX0qwGTL/2tlcJUm
	vXM/3OZvYWeMCBGE4UwebfWbk3eGsTONlXeyxlqtjxN+TMAPJQz1viBfvzLJhJ934buquVT8wo8
	DmsL7gc2EQA9Z1LZG2+UCkWVBJ3xEKZ5zZDo+k7b1azgqVGzz4PkyxOrmDEYnilBhSXi//PNHoK
	d52n0PDnyI4H7RTX64UBVzYSfviZi2k03njBFk6xKKw6KfKLAddPH5dTdWYZCa9jzJXA3lG7L2h
	iqaTiEAzY9PsJbSp7at8Lca9MVsS/cgdqQ8erLfB6ciC/5xnQDeee/NW3IYd248UDC2Vf/8Xpkc
	mjttJBadmc6S8EJ8m1cBi1AWvk9NcgJQrIf1aW35qXywK38iUhDPjmhhAK5tHHWIrJY2QqLeE6v
	nOkaLO6I94H85zHMzOytxEranAN6BOgVWrhD3SIIjRq3z9JrvBSy8vha/tZxD5qp5uVwWbSMKjC
	zXkVbHdEZQy1Ww7IC/9O1c6oNrztugAyrE=
X-Received: by 2002:a5d:59c7:0:b0:461:a16c:a5f4 with SMTP id ffacd0b85a97d-47f2dd1f29emr18774517f8f.33.1784095013281;
        Tue, 14 Jul 2026 22:56:53 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm14220369f8f.7.2026.07.14.22.56.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 22:56:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] geneve: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 15 Jul 2026 07:56:48 +0200
Message-ID: <20260715055648.33060-3-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715055648.33060-1-doruk@0sec.ai>
References: <20260715055648.33060-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:sd@queasysnail.net,m:linville@tuxdriver.com,m:mschiffer@universe-factory.net,m:maoyixie.tju@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[queasysnail.net,tuxdriver.com,universe-factory.net,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274735-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A93DB75AC8E

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the sticky underlay netns geneve->net. They differ once the device is
created in or moved to a netns other than the one the request runs in.
The rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev),
so a caller privileged there but not in geneve->net can rewrite a geneve
device whose underlay lives in geneve->net.

geneve_changelink() applies the new configuration against geneve->net:
geneve_link_config() and the geneve_quiesce()/geneve_unquiesce() pair
reopen the underlay sockets in that netns (geneve_sock_add() uses
geneve->net), so the same reasoning as the tunnel changelink series
applies here.

Gate geneve_changelink() with rtnl_dev_link_net_capable(), at the top of
the op before any attribute is parsed, matching ipgre_changelink() and
the rest of the "require CAP_NET_ADMIN in the device netns for
changelink" series.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 2d07dc79fe04 ("geneve: add initial netdev driver for GENEVE tunnels")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/geneve.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 396e1a113cd4..03c99a016298 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2376,6 +2376,9 @@ static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct geneve_config cfg;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, geneve->net))
+		return -EPERM;
+
 	/* If the geneve device is configured for metadata (or externally
 	 * controlled, for example, OVS), then nothing can be changed.
 	 */
-- 
2.43.0


