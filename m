Return-Path: <stable+bounces-254592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM/oByT6FmqKzwcAu9opvQ
	(envelope-from <stable+bounces-254592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:05:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741885E58D3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E65CE3036635
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1135D413D96;
	Wed, 27 May 2026 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRbl+Os/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA333DC4CB
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890277; cv=none; b=alnDbxIxpYblqxK6sKXt1z5kXGzS7YagsJdQNaok4HJXFxOz/vMPHexk9fM1LCfhEmbs/QV6CfedhaF7D086rWnwEnmOpopC+TNfnGV7TaKdIvPE1ECCCrhVGp6jkX+Guu8HBChJ0EjL64ppqvN2y4Jbmrerq13xzaxRQcN++SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890277; c=relaxed/simple;
	bh=eZu08mVs02TntUL7GMXdknTj6wwcyvaBBkvZpAxupeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgInCsaHhoMd0AFrBGIcxFQrgW+B2xyIEs2Jq+QZkApmztF3B3BoJWTLuZ85qISWtwaa4tXgZrt2JdacjG1z6fWOyKnvPosAupo15gh7FDAHrTTCzmVZdgWIrUbfyKKu6p++LTx4C/n+lJjLRX63vyxObsheKLOp9vFVJPnzgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRbl+Os/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so7487385f8f.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890273; x=1780495073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylxspOikl//hUYOHTbCgkMeRhn08cWcQtF58xpwNlyg=;
        b=kRbl+Os/RBeRxw8GuAPgMwvooTT2cYkvimcE2CiNAhVYRID4+FsN/KmJ/n0BPPyYZG
         7mFp3XSaQkjZL2kW9zzRIunJPgPIbeoKUyUKrq98QbgjAuux4AF1aEuSRLA9zbH/VZNc
         e53CpKo6CicERJpmoF9vojJCZBabseM3uaL7ZbpSnbn/R4vnXjrs/wHDpCq1SdtH7VaL
         /xjps3af4vjbFagMPDdVf8RUj6wsg5ug8l1D0qrXAXarP/93tgybnN7Q9IPOlxNdvRAl
         DZg4KdVTPCi31K5FVOswFa6y3mNPp5S5t9XuH2p2AdmlaOV3GArh0y3M2S+ur2YLHl4/
         yErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890273; x=1780495073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylxspOikl//hUYOHTbCgkMeRhn08cWcQtF58xpwNlyg=;
        b=AE4dSYhTonLh4dA5lwv4l/0+TbzMoVUf2od104LRm89JVaoNRW2pmL9coex4ssZ+5I
         QS7+4BbkM6rlz52mQH1nO0dEASYnSqzIrZBtufq80tR1HPQVyEIVW9tvO0Kjdw+3l7KQ
         yYwlWjVABi1WoY84FUURfkhcrg9dwAQBM6lhD4qa++vDVF8w/kj5+xHcxNLKyEevsAwS
         M/ndXbcMOqstCDsVAjr6VpoOSKn7aLVq8t9BCoq86qHVeEKhGCN269IfW4sbe4S7ap1D
         1E1BVE5qdXHHxhF9Z/c6WtPqAIbtEe1sUJXL7hbJ/6TBEo3RBXGsATu4yXSp0OZ9/M27
         Zc0g==
X-Forwarded-Encrypted: i=1; AFNElJ9a6JU11J+YCst3OIrB4EINR8QuxQoCZ87YGyNKBpOF1n2hgpmCaSuPS6fR1P+wXUZkBPZR4bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYTBbSx2j7ypsRjaWWQM7pX0MA+0muRl5l+RvYshU0UokroIk
	fIQiELcgqonxQErymCqCNLl6LvatdA9xKUh1wg+n9utg/NpsX700hRM=
X-Gm-Gg: Acq92OFULSESyvxrczP76KkLKQoRKMXWJRw0a/l1uu/T9XvAWENG7xkDkiZOB3uDTnW
	T8sM80TjRzh0JltflYrobQ/4JEDUBspPr4NtDgz59+Q24afTFpM5NdKomhjt6V2fgvXAFqB3D8u
	9ZhAjmfj03pRHaO/zpJNaExQOXq3DA3YggZVR53y99vZdAE4G+EYDXC21tPyS9zDjwbHC+Eh66F
	G+/b6NzBLRgwFMyrPFaPRkEqVVZ9PNt6xRusDFGexyPfp2PrXj32UmpJxu64+j7slkmwTUJxPYd
	+d+gy+iztVmany9WebwvNXmCHlcGYPI1RszQZjPbYvhBLgMspf5EuGito4HvwVXQOHailkEuAdH
	pABV4qacNDpCcQ3z6ccCOPrArgYWONpiD8nLV8D2kzKislJWCmxPT/9uTTZj4htMDJGnppEa5XE
	YRg3Y=
X-Received: by 2002:a05:6000:144c:b0:43d:77e1:6a69 with SMTP id ffacd0b85a97d-45eb38c2026mr39606398f8f.38.1779890272700;
        Wed, 27 May 2026 06:57:52 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c2323sm6388642f8f.34.2026.05.27.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:57:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] netfilter: nft_tunnel: fix use-after-free on object destroy
Date: Wed, 27 May 2026 13:57:50 +0000
Message-ID: <20260527135751.1031891-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254592-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 741885E58D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

nft_tunnel_obj_destroy() calls metadata_dst_free() which directly
kfree()s the metadata_dst, ignoring the dst_entry refcount. Packets
that took a reference via dst_hold() in nft_tunnel_obj_eval() and
are still queued (e.g. in a netem qdisc) are left with a dangling
pointer. When these packets are eventually dequeued, dst_release()
operates on freed memory.

Replace metadata_dst_free() with dst_release() so the metadata_dst
is freed only after all references are dropped. The dst subsystem
already handles metadata_dst cleanup in dst_destroy() when
DST_METADATA is set.

Fixes: af308b94a2a4 ("netfilter: nf_tables: add tunnel support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/nft_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 0b987bc2132ae..68f7cfbbee063 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -676,7 +676,7 @@ static void nft_tunnel_obj_destroy(const struct nft_ctx *ctx,
 {
 	struct nft_tunnel_obj *priv = nft_obj_data(obj);
 
-	metadata_dst_free(priv->md);
+	dst_release(&priv->md->dst);
 }
 
 static struct nft_object_type nft_tunnel_obj_type;
-- 
2.47.3


