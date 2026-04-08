Return-Path: <stable+bounces-233892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOkGKpZQ1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:56:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E93BC76E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55223302AE07
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7273B8D41;
	Wed,  8 Apr 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud3S6nIC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422942E7F3A
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652829; cv=none; b=DhfAJYnS0XGPSg7mo7QrrakMHIbuccXfYeTsccOvWsAJt4WeY1OcyWo8FLZOnZ9b0kerxoat62SmWWSD3Kb3kJsTpDFVsnNgjtfl8WOkUiC4VjFV+/e5mStkv6P2Vhejxe0KhBHeW3NpS1gW6kY/8fRgyws6WvowvktaSbwflqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652829; c=relaxed/simple;
	bh=i/jWbQdpaZ8b/0gnWJEOyZFwTq28t9QPbasnuRPj8Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCgMKhLm/82qBR9TwCHRhEnircTPt5FhEaJ6hyHBID5GIPbIUOxNrxHG7hk4VZKKNGsrF+g88AY4sx4M26Kb4tGtZs6V87+HpO93+shobzBVi7S2T2UpnCY/kl6b4NR/Pmc6RDznRt6chNlLdG6bNkbVetmz8GUmDPw3P+u1Aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud3S6nIC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82ce49785a0so2616675b3a.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775652828; x=1776257628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIlOs7q64Dx26nQmV8oPXsuS8EwxbCgpyhUA7vQTilE=;
        b=Ud3S6nICIpB9oZMnQW20CzuPQNezltDZ3xtEJ7qeSVK4EinmzuEJTUhHQXkwJM2wFp
         xTNpMTqKURsAvq1Otob59OOG064OlkJjSVvOyo6LJX2eBHdGRQgGCEmWEB8vMum+aMgi
         TQCqmZ+vPOCjfd+kGV/iO6GlTlBDuShWDKdjMNFkyfAi67lAB3n7B4nSgY3JAsAvQjcZ
         kUKuHDGvZnIV5rFaqPjAyzQ/deWNjjQME1+QnmHJHy78nArRzowXu09pRGVFQFo4vVr9
         71BFdetafaDSN3w/sT76DE1cBLiu1Eg2T4QWGPiQrzMPJRVVFryd3IDQtipjc6ZALX7C
         zVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652828; x=1776257628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIlOs7q64Dx26nQmV8oPXsuS8EwxbCgpyhUA7vQTilE=;
        b=EPeJegl7AsAmEk+aJ909q51goF17ZyraX+243LMl2RY8P8Zy+B5zhS3tG5atcd6QR9
         uNSfO1ij95ix2flVPiurfXmj2uYdijsfLKPGWFjPg9ShRYLsAPbVNx00iMK2jBTbrffa
         Ln+fTmltacS5Mh/k/dfwGK1/tnuJcK5u3W7n3nyiIeRN38+WApIpMpzBe5aFjH3NU5J9
         Fpz6WvIyeO4shsb5/30iV6VAC/h4ht3SO0UqQmI5r1Rf9O/RdtqyhtckMbnVMSJmeUfy
         z3cUDo0VvcuLSKuLvM5WslaUUfGipiMQf/y44kpC+dS9rZGy7fOQhJFEB1R3IGKSCnED
         C89w==
X-Forwarded-Encrypted: i=1; AJvYcCVze/LUKDGlrjlSIBQe8+0wLCGo+GPeVz2kTYRV7MIpQCiurIadTzKO3I7j9wWAe6hdNCQ+ce0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BCtHk0rjSgxzguCykIPXOWoaLAzZMJ78UAHb2u+c29+dasOH
	vMM+31Gcf3WWGZUhfF7rF6XqoOUGsVgsr0AlNsfoBzPa0YtLyCv/1h4x
X-Gm-Gg: AeBDietO2RC1WdDXO3x1vSY7ov/F4e6459rFGqdjkAJ88vzlPO3PLyC/DNNLxOwtfoq
	NE8Ro2iHOS9PeJJBxr9Bc30xI2a1+8ZsWDf/vvMxlryD4A8EbYvvPhhjPYmwRkR20+HawMLltYm
	wUSMGfdB89NVHqtvvryqcRS9ZlFVYGh89Pd5jPZ3J4oD9DHE+9i4cYyolkmRXzsxF6PX13n16Bz
	b02GG5n12GyffTFqdqTVLr4FYlVH/ExDm/jkiwJsrydCKH/Nf23Kos4L36EkkU8pt4cQ8Ha8oKF
	mMFQdyZGTmjfFhimlkyZPYaPIetc2sJ7mDQ40zrFKPrCHVYTtOjc+3aUOvQEt3dGgblymHtQT8H
	qh1rhaEAeAWAA+XaTMo9QoriND7Vq7xG8xzr8niEAzwzwKEQ/qsiiX6tpgg/2EJCpnKb0/Ddb4D
	VULLr8Qi0AWPEy8h4Kvg==
X-Received: by 2002:a05:6a00:6ca8:b0:82a:ea3:c16f with SMTP id d2e1a72fcca58-82d0dbe3dabmr20955636b3a.53.1775652827507;
        Wed, 08 Apr 2026 05:53:47 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b21c92sm22331921b3a.11.2026.04.08.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:53:47 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	kees@kernel.org,
	thorsten.blum@linux.dev,
	arnd@arndb.de,
	sjur.brandeland@stericsson.com,
	xiaoguai0992@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
Date: Wed,  8 Apr 2026 12:53:33 +0000
Message-ID: <20260408125333.38489-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-233892-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,davemloft.net,google.com,kernel.org,linux.dev,arndb.de,stericsson.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B1E93BC76E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cfctrl_link_setup() copies the RFM volume name from a received control
packet into linkparam.u.rfm.volume until a '\0' is found. A malformed
packet can omit the terminator and make the copy run past the 20-byte
stack buffer.

Stop copying once the buffer is full and mark the frame as failed by
setting CFCTRL_ERR_BIT so the link setup is rejected.

Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
Cc: stable@vger.kernel.org
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 v5:
 - remove the Reported-by.
 - print a warn message and reject link setup by setting CFCTRL_ERR_BIT.
 - using %zu to adapt the compilation of 32-bit kernel.
 - add rate limit to error message

 net/caif/cfctrl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index c6cc2bfed65d..373ab1dc67a7 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -416,8 +416,16 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
 		cp = (u8 *) linkparam.u.rfm.volume;
 		for (tmp = cfpkt_extr_head_u8(pkt);
 		     cfpkt_more(pkt) && tmp != '\0';
-		     tmp = cfpkt_extr_head_u8(pkt))
+		     tmp = cfpkt_extr_head_u8(pkt)) {
+			if (cp >= (u8 *)linkparam.u.rfm.volume +
+			    sizeof(linkparam.u.rfm.volume) - 1) {
+				pr_warn_ratelimited("Request reject, volume name length exceeds %zu\n",
+						    sizeof(linkparam.u.rfm.volume));
+				cmdrsp |= CFCTRL_ERR_BIT;
+				break;
+			}
 			*cp++ = tmp;
+		}
 		*cp = '\0';
 
 		if (CFCTRL_ERR_BIT & cmdrsp)
-- 
2.50.1


