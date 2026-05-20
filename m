Return-Path: <stable+bounces-250284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGKWAijlDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:45:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC5592629
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 625DD30CB520
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B23A3E90;
	Wed, 20 May 2026 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzisrtqY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAE34B40F;
	Wed, 20 May 2026 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295010; cv=none; b=ANkMx2p078ucdPCl5lgDwR1pZy0IqIyUzzy87Z5i65ramLwieHbfPnYG3S02PZlZAnqfBocQW1YpuQn/TX91g++bYjniW2rLRb+XxKBnZ32v8hFyMVr9NkfJjGJ2gcD9lLG8K1jbF6Y0yOGuVTFY3ErsBXmMe/N9bdL/lsLfbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295010; c=relaxed/simple;
	bh=kU3Z+Ms0AdoYLVaiksXX0uvAM+Es8fDhjM0ntMgYaLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ki3fVfG0U/+x4D0zsJS2e05m0PCrLyj5pWO5h97YtKQ5bQHatijl1xyOgoIaXe9Vn3F9CLVhy35z+J7mIKSUsAOzKWtTGJDvy7VOky+jMHFMvqZIaqbXXR7u7iWPT0TYmj8z5IV+fbu+uTZajRV/MqHG3meUXzOidjkAVrYbCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uzisrtqY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AA21F00893;
	Wed, 20 May 2026 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295008;
	bh=gAbgbl4C3y//kcYRqyhxCn8H1yjr71nDuSd/voozFkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uzisrtqYSpaxZvL2jI8D2nQG3Qixvjx4t+h6qY5Qa2aIHx31GWagRWJHJIYv7mddQ
	 T74EuNPDzgXl46P4qjXXQh9/V9gzMqXQDcf2tLVSP+75TEkPaCaKmheIfylrF1ddjk
	 F2wI5irlVGwxEFuScoT1y7gYx1K05q2eXpTjwIVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Luczaj <mhal@rbox.co>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Wei <dw@davidwei.uk>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0215/1146] Bluetooth: SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec
Date: Wed, 20 May 2026 18:07:45 +0200
Message-ID: <20260520162153.125623386@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-250284-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,rbox.co,intel.com,gmail.com,holtmann.org,davidwei.uk,vger.kernel.org,samba.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,holtmann.org:email]
X-Rspamd-Queue-Id: 72CC5592629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit 4e10a9ebbf081c16517cdd9366ac618bf38d7d0c ]

copy_struct_from_sockptr() fill 'buffer' in
sco_sock_setsockopt() with zeros, so there's no
real problem.

But it actually looks strange to do this,
without checking all of codecs->codecs[0]
really comes from userspace:

  sco_pi(sk)->codec = codecs->codecs[0];

As only optlen < sizeof(struct bt_codecs) is checked
and codecs->num_codecs is not checked against != 1,
but only <= 1, and the space for the additional struct bt_codec
is not checked.

Note I don't understand bluetooth and I didn't do any runtime
tests with this! I just found it when debugging a problem
in copy_struct_from_sockptr().

I just added this to check the size is as expected:

  BUILD_BUG_ON(struct_size(codecs, codecs, 0) != 1);
  BUILD_BUG_ON(struct_size(codecs, codecs, 1) != 8);

And made sure it still compiles using this:

  make CF=-D__CHECK_ENDIAN__ W=1ce C=1 net/bluetooth/sco.o

Fixes: 3e643e4efa1e ("Bluetooth: Improve setsockopt() handling of malformed user input")
Cc: Michal Luczaj <mhal@rbox.co>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: David Wei <dw@davidwei.uk>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/sco.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b84587811ef4f..18826d4b9c0bf 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1045,7 +1045,8 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		codecs = (void *)buffer;
 
-		if (codecs->num_codecs > 1) {
+		if (codecs->num_codecs != 1 ||
+		    optlen < struct_size(codecs, codecs, codecs->num_codecs)) {
 			hci_dev_put(hdev);
 			err = -EINVAL;
 			break;
-- 
2.53.0




