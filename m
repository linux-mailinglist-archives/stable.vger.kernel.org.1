Return-Path: <stable+bounces-220371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PS3AcUyo2mV+QQAu9opvQ
	(envelope-from <stable+bounces-220371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7E1C5BD7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10F8531077BF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD8480341;
	Sat, 28 Feb 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sORh0V0r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D555C3A353D;
	Sat, 28 Feb 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300266; cv=none; b=VX5pCGpJANNKTVoRX2Jck6NpQl5Icjv+XuU0okjyQwzDynZNz3T1B09LmXlJYYijfDr672yP3ahzbXUZqyP8Ogk8a/ORZnrMxATdfESwLZHug75H//YMhazYQ//X0eNBab22jRjt6C8srG5KCKAtsKZ/QNjSsvwZnFzYIXtc+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300266; c=relaxed/simple;
	bh=pFE7KMqNgpCOcihLdheVtz6wir2jtJW5f5QbLKUawRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qr/eB5ceiQ3effC7l+9YpZ31ceVls7K1OhhUwIhaO7HomdKKlsZ0igbl6JqZKwtIFspuUZM8xIYljqsfh0rUk0FYWC7QYp/DdRiwbJnDjspOw7EgLuZ/ovD3t8HoEmYfxqGGT7UvMN6C+z84hf3UExp8IHNVxBKwTNMGh/tO68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sORh0V0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BBFC19424;
	Sat, 28 Feb 2026 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300266;
	bh=pFE7KMqNgpCOcihLdheVtz6wir2jtJW5f5QbLKUawRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sORh0V0rclTfo1N39C84nhfl+1o7Hw7maohE7KXDqsjFy0+UQscesJ7ItOqc0EnOS
	 dzcadjpLP/FkjjvbVaxksSJVHvcFRfgbxN54mbB8+w2kDc3Ym4E6NMWnQUNWc7g+w/
	 dflNAK0Mi/6VhN1I3/EccgfazEEbNAq94XefzqUpZ+RlCtBbli7PG7Z+jBwoMmZuw/
	 E0pNGnuBIaDvZxNhhFxxEckBlIr2BVLGqUccTo8HNzNfrsGzNwr+WJw58acKApxsbV
	 SL5BF1d2TKZIuYaQshHKSnofumynd5pna+X5gGFtoSOV+rVfzUvWWMvb9ghEx8Gc4y
	 s2tqkynWq2NpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	sungzii <sungzii@pm.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 292/844] netfilter: xt_tcpmss: check remaining length before reading optlen
Date: Sat, 28 Feb 2026 12:23:25 -0500
Message-ID: <20260228173244.1509663-293-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220371-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pm.me:email]
X-Rspamd-Queue-Id: B9E7E1C5BD7
X-Rspamd-Action: no action

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 735ee8582da3d239eb0c7a53adca61b79fb228b3 ]

Quoting reporter:
  In net/netfilter/xt_tcpmss.c (lines 53-68), the TCP option parser reads
 op[i+1] directly without validating the remaining option length.

  If the last byte of the option field is not EOL/NOP (0/1), the code attempts
  to index op[i+1]. In the case where i + 1 == optlen, this causes an
  out-of-bounds read, accessing memory past the optlen boundary
  (either reading beyond the stack buffer _opt or the
  following payload).

Reported-by: sungzii <sungzii@pm.me>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_tcpmss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_tcpmss.c b/net/netfilter/xt_tcpmss.c
index 37704ab017992..0d32d4841cb32 100644
--- a/net/netfilter/xt_tcpmss.c
+++ b/net/netfilter/xt_tcpmss.c
@@ -61,7 +61,7 @@ tcpmss_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			return (mssval >= info->mss_min &&
 				mssval <= info->mss_max) ^ info->invert;
 		}
-		if (op[i] < 2)
+		if (op[i] < 2 || i == optlen - 1)
 			i++;
 		else
 			i += op[i+1] ? : 1;
-- 
2.51.0


