Return-Path: <stable+bounces-229646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMbJJ6RrwWlMTAQAu9opvQ
	(envelope-from <stable+bounces-229646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:34:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E0C2F8595
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D80232ADDCC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88503BB9EB;
	Mon, 23 Mar 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HNFMYCKs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BB3BA226;
	Mon, 23 Mar 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282485; cv=none; b=eARec88byPeuYSK3ppbXKg7FWzue0ELKI87L1Xe7jb5Bn02wtOsifk2RwdpZ7SAkInMCS1czec/ot1slofyM4kI5ZX60Fqy6jAJxMC5NQC4DvTdyXOfvfT58QS5aH4fEgwfKfZfUvcFCtL8ujB0S3p5otKXoAM+7stxPEVUoPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282485; c=relaxed/simple;
	bh=62SJwA8d/+3FakSgM1SS+sNN11+vC9BpXtx8M1cfH18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR0UmDngqXDULGOoBtHju73g3OHe6HjGYywYfAeaE6WB+cLmBURsqUgJHv1fGLpNtUKTGDaY/PpWGycnh7ltG8Xcm5KQ2W3Bu+caDvsrSos7ZPBpHdKTeZXbH0KghPF+jSslkCRILY7qkr0lromG7x5twtqtUQuAjmPRaWL8Su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HNFMYCKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15801C4CEF7;
	Mon, 23 Mar 2026 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282485;
	bh=62SJwA8d/+3FakSgM1SS+sNN11+vC9BpXtx8M1cfH18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNFMYCKs+/C0pJCFyloQ1ulfY93OChQ1rA+aiF3CFoG8rEdP/15fZ4Z//dmtjEtsY
	 rcFyg++WFi10obA7pcATHa9FVa1vb9d/qm5Fmz3glmIUaSUF6FZbt9K1R4IPWts5BA
	 +BdbaSWBVCRL3umc+TeX7kZRn1dykI2uZZwqTQKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haiyue Wang <haiyuewa@163.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 173/481] mctp: i2c: fix skb memory leak in receive path
Date: Mon, 23 Mar 2026 14:42:35 +0100
Message-ID: <20260323134529.438841840@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229646-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,163.com,redhat.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 27E0C2F8595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyue Wang <haiyuewa@163.com>

[ Upstream commit e3f5e0f22cfc2371e7471c9fd5b4da78f9df7c69 ]

When 'midev->allow_rx' is false, the newly allocated skb isn't consumed
by netif_rx(), it needs to free the skb directly.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Signed-off-by: Haiyue Wang <haiyuewa@163.com>
Link: https://patch.msgid.link/20260305143240.97592-1-haiyuewa@163.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mctp/mctp-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index f77389c7006f8..2eeccc3b70eff 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -344,6 +344,7 @@ static int mctp_i2c_recv(struct mctp_i2c_dev *midev)
 	} else {
 		status = NET_RX_DROP;
 		spin_unlock_irqrestore(&midev->lock, flags);
+		kfree_skb(skb);
 	}
 
 	if (status == NET_RX_SUCCESS) {
-- 
2.51.0




