Return-Path: <stable+bounces-262467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dPm1CVZAKWodTAMAu9opvQ
	(envelope-from <stable+bounces-262467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 12:45:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BFF668695
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 12:45:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kiJrBUJ0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262467-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262467-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4560C31680BE
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5A2345749;
	Wed, 10 Jun 2026 10:41:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4EF372B5E
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:41:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088061; cv=none; b=QyVfztorWJO05IxCyoHtnzV8WIVWNrC2wKR84EfEDOyDkWVaBR4yGOvQoCnA/OXDv/ZRVDPiUs3NupMubLmsZOTpD+CaZwLsyunaETaZVOq423/mcBdQ2sEv9I5386WQL3xDgDZGSJWZ/tSs8zNr0wrr1olY4znYywx/Pg56g48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088061; c=relaxed/simple;
	bh=OGLH7jXzbsIii2mYqUyRub3wuJrPU46nL/mOrml4hmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDAApJacIfPF7rnc2rzc6IRwqwHFsBJCF+ttB4pWwxeRjQQhuc792PpMIP7W+jj3aXw8A3RN95ULRFr6n4HKjFLewuai35hBftuT7LDa7ceZ2dgvaNeOwbxrv5hUbmsyIAp/iEafgxEx86R7z40e5Ep6bkPpKDS7wAfQB+3FSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiJrBUJ0; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so4587839f8f.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781088058; x=1781692858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jw5k2pr2Uxq2pN8ORiGv1jSaTS+XZ+Vd2/C3ba/TNc=;
        b=kiJrBUJ0TYe6M+d8go/FJoIvTPlsGqlqkTFBBPuGnSYzj0l3n3+wkQihvaFoe4Dbvj
         DZTD+z4jNAQ2S49XqMks9g1gK6czazL+jMJGETSv2B/6iDANCo/rmnOIJqD67BIOqc+y
         H20NERmOb2mIG6xWhQiGxFyM1mg0jxU139bewyGXpoVfEMM7KzGT4+qXU7tzcJ8XfjUy
         sVVcuinyKI8WZJUicZ7NVXKVLd9T9bE/MPWnbmAOkBm04/itjtuGe3tPQ3f4Avc8jQuZ
         9BrUT401SMpTJ92K2VqxdhKhfFfJZU2cCtWg6n62fcXEfrff3X8sFwf5D9ySQwfNigJ3
         4Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088058; x=1781692858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Jw5k2pr2Uxq2pN8ORiGv1jSaTS+XZ+Vd2/C3ba/TNc=;
        b=kNsmrI7dsmokND+4WkQOOU7CWCvYaiofynOgX8Pzfz/bFjw0LfLuAx16Dz3UhQvQsQ
         1hc7GadxBUdcU6jj+rmNCw5h0xU8J7aTKJAu0xsjVrtj3J9cLj+fvsR79GWC8annoown
         0mEDqw6MlArzoIv+6o5s1koDVrOtiTL2vINz//v2tMgdPXJJp0L5sUwAdpfVf7WNjbEh
         jplMl3yGV9QFUonarORQaO30iv/snDuksI0klCRLCy+q6VU9vwS1O7d1tgMF+IlDokHZ
         hsevX5N8CYUTK+AR7iR96nABbQlWnulKvs9/1AG0ab++NWOUjbSi4kBCwM7VDF3ZgWh1
         13oQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pPHHj1k2Rd7R83rgyTj5BntvE1cDYt9inyHvBqyYjfNQi7PhM+4Dirl4iAtRYpMxoDfmY1w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZ2zf9ABSBmyQjID1VHqaT6N5bvR6uaMUfYORTrmQT2H2p2OL
	PzUmwouqkOeSHb/7qzBpvMmF2g3AM1fMIrFPXYd/aQsq8hIFu6WxjYTl
X-Gm-Gg: Acq92OFxgKwbDtb1A9Y48D89ixmX6acyyMx3FMNUMDE1oGs4HkZgYelPFfq51WOJy4A
	bGmI5y6jOVIVn8j1Qcu/436LUiros6grptFop2ejDG0G5hqTaGpebEBW3t+HqGzpmbj5+deYTcQ
	/AiHNyGos9VpUdmahRmEo4381V7zQVj/Xznjdyp1/+Nx1oOIKxpxk8c2hQdWgYPW9G9ZStSx84e
	WEKlIdS3CKzi20POR/hDWYcxihV8A6aHHMMlFy3uG26CAJ8ekAr+UHHYKwSWtPkf91AE6xrRXO8
	x85qPr3KmNw03c9XFgJFw05pPRWIF4bvfqa7MB3s2i8IFCihXxFGqQJew0Rn2a+OqQGRnjJcXqZ
	CAoYPAvpHq90u3fRV9FkdFhbFauGvnag6TVkIZ5DAtwjp3h8dMzaCX3xBeYB62Q96qeT1wnwwtM
	wgaDmQ9cWyzOO60VcF6AgNH81rk/NEMRLMcZFBehOfTycqQAu6l8pVs8oIWci77hXdVvrTXtYs8
	2jEFuujIw==
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-4603062bc2amr39185597f8f.32.1781088058536;
        Wed, 10 Jun 2026 03:40:58 -0700 (PDT)
Received: from manta01.. (host-85-36-215-182.business.telecomitalia.it. [85.36.215.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm75828687f8f.17.2026.06.10.03.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:40:58 -0700 (PDT)
From: Davide Ornaghi <d.ornaghi97@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	coreteam@netfilter.org,
	Davide Ornaghi <d.ornaghi97@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] netfilter: nft_meta_bridge: fix stale stack leak via IIFHWADDR register
Date: Wed, 10 Jun 2026 12:39:13 +0200
Message-Id: <20260610103913.1949008-3-d.ornaghi97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610103913.1949008-1-d.ornaghi97@gmail.com>
References: <20260610103913.1949008-1-d.ornaghi97@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262467-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[netfilter.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:coreteam@netfilter.org,m:d.ornaghi97@gmail.com,m:stable@vger.kernel.org,m:dornaghi97@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dornaghi97@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dornaghi97@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83BFF668695

NFT_META_BRI_IIFHWADDR declares its destination register with
len = ETH_ALEN (6 bytes), which the register-init tracking rounds up to
two 32-bit registers (8 bytes). nft_meta_bridge_get_eval() then does
memcpy(dest, br_dev->dev_addr, ETH_ALEN), writing only 6 bytes and
leaving the upper 2 bytes of the second register as uninitialised
nft_do_chain() stack. A downstream load of that register span leaks
those stale bytes to userspace.

Zero the second register before the memcpy so the full declared span is
written.

Fixes: cbd2257dc96e ("netfilter: nft_meta_bridge: introduce NFT_META_BRI_IIFHWADDR support")
Cc: stable@vger.kernel.org
Signed-off-by: Davide Ornaghi <d.ornaghi97@gmail.com>
---
 net/bridge/netfilter/nft_meta_bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 7763e78abb..219c406802 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -64,6 +64,8 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 		if (!br_dev)
 			goto err;
 
+		/* ETH_ALEN (6) is shorter than the destination register span (8) */
+		dest[1] = 0;
 		memcpy(dest, br_dev->dev_addr, ETH_ALEN);
 		return;
 	default:
-- 
2.34.1


