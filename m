Return-Path: <stable+bounces-220386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ab2MP40o2kI+gQAu9opvQ
	(envelope-from <stable+bounces-220386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6301C5F44
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9208230D5662
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0112F3A7175;
	Sat, 28 Feb 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQpM+pYV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885C3A716D;
	Sat, 28 Feb 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300279; cv=none; b=eE4EKbwF99M3LtKrWKRXKmv60Nob62hHDCQo4TVV9gdww6ZHyN0EM1PcLSnlpRhkeniIr0wgC+Ws6qLPkL9TJIDk/i8wTCUPRQoszCZepXE5ANHBXXgmd9Sr6qzrounrvcR6oSIk/hEnIIJiP/0UKwIZcN6bHpgyzq3ldNFjS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300279; c=relaxed/simple;
	bh=W2Zu8bffyf0YcmUgY9hYpsOx4Ln8hzrk78JdvpIjSgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz8Km5R5vsIEumaQbndkVy1rq8HaLORVrFx5ZtuYAVOSPjzNPdhV8FJDScknxJEl8BHRsL6x4/6lzY6r4bGYNwF4z1Zqe6Qu1jcqa1RZYTwEA0WNZiqEPXp8vJGCBfwTtL0HsrGYh9YkdfPExV44oeWllhpfL8oXbmOijdAejXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQpM+pYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135A0C116D0;
	Sat, 28 Feb 2026 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300279;
	bh=W2Zu8bffyf0YcmUgY9hYpsOx4Ln8hzrk78JdvpIjSgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQpM+pYVbRT6FqMJpYlfMI3pS626lKYtNmQQW/DikHT+pNZy8NhBin2DznHEyye+p
	 onVUl8YxqLJ/QoilQLFP4WrEARdj+ZDUOMoMRmpB++JjPqFLtIMDytaTXelESg8jwI
	 /MeHzGVPlwcO6xSDjQp+FwTqz6CwivBenA9nsKg1L66OK2rs8a8Wncj+Zue4jDWGKN
	 Nm94qBbWqb9ZDjNx1JA2Thh3V4fJ+9BeLT3nHaXQeQQUMG5ndentQhPBapw0uDADVT
	 R5XYA8NIqMehtqyUA+b7izkJR/DfEK7ISrLPhUVR1+oKbg1diQnvkdXl6xGNR7xyIG
	 +MpG6rYcTjp/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 307/844] gro: change the BUG_ON() in gro_pull_from_frag0()
Date: Sat, 28 Feb 2026 12:23:40 -0500
Message-ID: <20260228173244.1509663-308-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220386-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A6301C5F44
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cbe41362be2c27e0237a94a404ae413cec9c2ad9 ]

Replace the BUG_ON() which never fired with a DEBUG_NET_WARN_ON_ONCE()

$ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
add/remove: 2/2 grow/shrink: 1/1 up/down: 370/-254 (116)
Function                                     old     new   delta
gro_try_pull_from_frag0                        -     196    +196
napi_gro_frags                               771     929    +158
__pfx_gro_try_pull_from_frag0                  -      16     +16
__pfx_gro_pull_from_frag0                     16       -     -16
dev_gro_receive                             1514    1464     -50
gro_pull_from_frag0                          188       -    -188
Total: Before=22565899, After=22566015, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260122045720.1221017-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/gro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 482fa7d7f5981..ef61695fbdbb6 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -417,7 +417,7 @@ static void gro_pull_from_frag0(struct sk_buff *skb, int grow)
 {
 	struct skb_shared_info *pinfo = skb_shinfo(skb);
 
-	BUG_ON(skb->end - skb->tail < grow);
+	DEBUG_NET_WARN_ON_ONCE(skb->end - skb->tail < grow);
 
 	memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
 
-- 
2.51.0


