Return-Path: <stable+bounces-240759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJTVN+py62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:40:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AECD45F619
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B987F3047513
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8753563D4;
	Fri, 24 Apr 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFWi0HZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28123645D;
	Fri, 24 Apr 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037767; cv=none; b=pFjAnBxPIJe6g0/6MRrv4k8cDyjCrzvOA6XXNHk9K26zjKoWKooljOQVpo4eug4c4dprXNHnb1KBRkxmzKGHQn4Pn4aviKOSeRZ1kntunQO2HsDAxd/WfhmS38S6h4J8XJbdknCKaSFnJt2hh9MQfqh5+SGpLH3KRv5kA4hNXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037767; c=relaxed/simple;
	bh=2dO/ZOQ1ga4Bvg0ue3oFZCGl5UAz0jchc24ZP2XkD+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXGoj1d8bWqC7oy8wo9jCS383LkztW/PVzqxT1nKbybAHgyZMnDDPdQ4lj9vMYlLF4PCAQB4dllQwh9/2jaNHv7/zJh6JqfSVswKno1MitMf8LT3549aJ0hW2ri0FnrV5MdPlH+C1Em7EzjCq3E4VrqOdhp3DnJF53B0JN6rVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFWi0HZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D747DC19425;
	Fri, 24 Apr 2026 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037767;
	bh=2dO/ZOQ1ga4Bvg0ue3oFZCGl5UAz0jchc24ZP2XkD+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFWi0HZ6ZMy98D229AsUNVVWPUCCYx+Y+HWePxJ+1EoLmd1a7f2m6fTX3Ndhinqih
	 UEJdNXObIMHml/ZrpnvTczmt8QV6soC1a0mFR4LP66X95yc5q+k3yqu7T9Ae5lknXa
	 Q48zUM85dnJYQ2/9QkUcQU9agAGWSMWVZADkPttU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com,
	Daniel Pouzzner <douzzer@mega.nu>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 062/166] crypto: algif_aead - Fix minimum RX size check for decryption
Date: Fri, 24 Apr 2026 15:29:36 +0200
Message-ID: <20260424132545.699696552@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2AECD45F619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-240759-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,aa11561819dc42ebbc7c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,mega.nu:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 3d14bd48e3a77091cbce637a12c2ae31b4a1687c ]

The check for the minimum receive buffer size did not take the
tag size into account during decryption.  Fix this by adding the
required extra length.

Reported-by: syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com
Reported-by: Daniel Pouzzner <douzzer@mega.nu>
Fixes: d887c52d6ae4 ("crypto: algif_aead - overhaul memory management")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algif_aead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 7d58cbbce4af2..481e66f8708bb 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -170,7 +170,7 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (usedpages < outlen) {
 		size_t less = outlen - usedpages;
 
-		if (used < less) {
+		if (used < less + (ctx->enc ? 0 : as)) {
 			err = -EINVAL;
 			goto free;
 		}
-- 
2.53.0




