Return-Path: <stable+bounces-137135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E0AA11DA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A67B4213
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4D2472B9;
	Tue, 29 Apr 2025 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0eNKbA/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF1216E30;
	Tue, 29 Apr 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945165; cv=none; b=VwHyY2AUVSsDFnP3cqZYe9UhgtvpKCVcbNn5HFzuFMNhnkFcJ0/c2Z/sXIQFel6wNlkIIjDCNpQycFbl9Jtdt7SlQcOSfb0E+8Jpn7GsI608JuRuzFiEURQN/QRzbiaJ7HoIl5T6ZCvSLPCZ+5H3UXgEu/7ydyU5kR7rtKnWdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945165; c=relaxed/simple;
	bh=NNdtKwxceGzp/5bLg2SpopcxrzJHCGm7lnZCtx0pczE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIy8p1AjAALFX2oK8w6r2nsDGTR49TdOG+owAoHPNmvmcbGzYDv1xqhtF+9qVkaIBr3S3q3v/nXlMr9BDeE8HiwkVpnA0wcmgeyneOv0cicQXyB4AXyJsbWRLRVcgu8mFhsvdzzoQ6us5xt76Hlm4+40ezoy0Rtbr6zJRqrz6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0eNKbA/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A61CC4CEE3;
	Tue, 29 Apr 2025 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945164;
	bh=NNdtKwxceGzp/5bLg2SpopcxrzJHCGm7lnZCtx0pczE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0eNKbA/W11CmDPe7Qq4ufNE03NZUG01+QIUqG8GZLeuPnM5KVIbn08HbPwsB8FnhL
	 uBSyd3aqsWy4F7soiTkYE/VH+3Y6JswilOjp/b/cg+rXSt1a3RLp0Zk0RkhS/MGPUj
	 VsnTBC3TniWEF0bP0MCckA3oosCv4Cuozy1U8vZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 006/179] net: ppp: Add bound checking for skb data on ppp_sync_txmung
Date: Tue, 29 Apr 2025 18:39:07 +0200
Message-ID: <20250429161049.650375963@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaud Lecomte <contact@arnaud-lcm.com>

[ Upstream commit aabc6596ffb377c4c9c8f335124b92ea282c9821 ]

Ensure we have enough data in linear buffer from skb before accessing
initial bytes. This prevents potential out-of-bounds accesses
when processing short packets.

When ppp_sync_txmung receives an incoming package with an empty
payload:
(remote) gef➤  p *(struct pppoe_hdr *) (skb->head + skb->network_header)
$18 = {
	type = 0x1,
	ver = 0x1,
	code = 0x0,
	sid = 0x2,
        length = 0x0,
	tag = 0xffff8880371cdb96
}

from the skb struct (trimmed)
      tail = 0x16,
      end = 0x140,
      head = 0xffff88803346f400 "4",
      data = 0xffff88803346f416 ":\377",
      truesize = 0x380,
      len = 0x0,
      data_len = 0x0,
      mac_len = 0xe,
      hdr_len = 0x0,

it is not safe to access data[2].

Reported-by: syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29fc8991b0ecb186cf40
Tested-by: syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Link: https://patch.msgid.link/20250408-bound-checking-ppp_txmung-v2-1-94bb6e1b92d0@arnaud-lcm.com
[pabeni@redhat.com: fixed subj typo]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_synctty.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 55641e01192dd..9ebd1ac569b90 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -516,6 +516,11 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
 	unsigned char *data;
 	int islcp;
 
+	/* Ensure we can safely access protocol field and LCP code */
+	if (!pskb_may_pull(skb, 3)) {
+		kfree_skb(skb);
+		return NULL;
+	}
 	data  = skb->data;
 	proto = get_unaligned_be16(data);
 
-- 
2.39.5




