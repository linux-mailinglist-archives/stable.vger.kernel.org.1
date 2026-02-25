Return-Path: <stable+bounces-218734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIJ1ErFYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA11907BD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB1931E6CA5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930C26AA91;
	Wed, 25 Feb 2026 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zqiG5Hdr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A624A05D;
	Wed, 25 Feb 2026 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983600; cv=none; b=rK5Chmm0m8synTcxfTwst5tiyZC8DxtGFm2MGN+1BAUrza9QxnY36vilDwh6ls49GWblIdOF4l7CeLj+THGvujj4EFLBuJrJpEy5To7gWdh844VpFRlV71U/5+hLd6SjOgCzxLEbMsmotuUctvAu/zvAcSsV9DRzPbD0bML+Z7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983600; c=relaxed/simple;
	bh=cukUdeWj7spsZzvm0zqTmtBSdWb3yGPtcfP75pXwtck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY2eDN+QBMraOXsDiZhuVfz4T3KUsn2MpGJm6HoGGIe8qAJA8yqz3Vh9X9ChjENHPlj0OQ67Kn27sFMUi0o9zdehr23sK8izDKhO9Fy3PJIXsVw+iV4Av1BvxpAXezB2nniDTE6EJPh2xZn8Aq5ZbSojUzg9arq3bdehP3Xb51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zqiG5Hdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86DBC19424;
	Wed, 25 Feb 2026 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983600;
	bh=cukUdeWj7spsZzvm0zqTmtBSdWb3yGPtcfP75pXwtck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zqiG5HdrjCmaxnCN6QLR7MthX63KLsLXKI+z/ccKi5zW4SD9Id5aNUzPCYhgvEcqW
	 TIACvXEpqDYnFzCIjdAcGO3NeZTGBkWlJtK3TUEcuMYFnG3mqByQk6UIaldoSI3l7H
	 3ynuI3PZzlxuzLmXAGduoAH7uprRPACQFMyQQfiw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 672/781] net: do not delay zero-copy skbs in skb_attempt_defer_free()
Date: Tue, 24 Feb 2026 17:23:01 -0800
Message-ID: <20260225012416.265803735@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218734-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: A9DA11907BD
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0943404b1f3b178e1e54386dadcbf4f2729c7762 ]

After the blamed commit, TCP tx zero copy notifications could be
arbitrarily delayed and cause regressions in applications waiting
for them.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260216193653.627617-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 61746c2b95f63..fa6209f45de9c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7231,10 +7231,15 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 {
 	struct skb_defer_node *sdn;
 	unsigned long defer_count;
-	int cpu = skb->alloc_cpu;
 	unsigned int defer_max;
 	bool kick;
+	int cpu;
 
+	/* zero copy notifications should not be delayed. */
+	if (skb_zcopy(skb))
+		goto nodefer;
+
+	cpu = skb->alloc_cpu;
 	if (cpu == raw_smp_processor_id() ||
 	    WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
 	    !cpu_online(cpu)) {
-- 
2.51.0




