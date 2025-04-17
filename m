Return-Path: <stable+bounces-133285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14952A92520
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084097B0D2B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CBB26156B;
	Thu, 17 Apr 2025 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OJdeSuHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E792256C92;
	Thu, 17 Apr 2025 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912620; cv=none; b=tf4tAtbVcO3F+1vs2YvxwNMvWpWYPY90sDWQHV8k1D2IKVSZjvyB7wfwRMcz31ENyzVnKp3PSWVtEoIORi5FBvHmAq7Snio/Qc+a29JITXxaJC+ydgSUxb+P69btaiS1VzYSH2Hwu4+WzKGQIZQrHfNmMx16WkEAJtQq468mu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912620; c=relaxed/simple;
	bh=ce2FKUjfjZehm6FouN9nZwe7y1wyqsloRsLQz04VueM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaFM+3pe6lFPSuyx0znQfx/AY/WfWDJOfflxU2iWu07vmL3BfdZy1De2dqS/E3dBIk5bbPTlFev6Jo8tD+OkmfhdQA/w0VJph4StX7iJlNKsM+zJTVnr+JHygZkZ7FkcknjCfHZ5/x0GA5BejJjt9PFIHMfuOBmd79o7blpYoYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OJdeSuHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6183FC4CEE4;
	Thu, 17 Apr 2025 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912620;
	bh=ce2FKUjfjZehm6FouN9nZwe7y1wyqsloRsLQz04VueM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJdeSuHjFpeN2r1Vab7w9ev62i0UBxBEUAh8ZG0JErr+6WvvWdmcCBR8w5v7d9O32
	 Ec3LTeyNczV6k/fhGfMD1Kg4FHojq7G3s/DJTDWt4WzErigP0vvnS0v5oCkGGHzVsD
	 u56Wk5DD9Kh1LVFkYvnYJ7P3LN6H3WoCMSbS2F9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 041/449] net: ppp: Add bound checking for skb data on ppp_sync_txmung
Date: Thu, 17 Apr 2025 19:45:29 +0200
Message-ID: <20250417175119.643611005@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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
index 644e99fc3623f..9c4932198931f 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -506,6 +506,11 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
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




