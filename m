Return-Path: <stable+bounces-261891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GZ1ZLMFVJWqZHAIAu9opvQ
	(envelope-from <stable+bounces-261891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:28:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDCB650724
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:28:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=pgDWmYD2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261891-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261891-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A567301CF82
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47C33A1A54;
	Sun,  7 Jun 2026 11:24:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56B1A682F;
	Sun,  7 Jun 2026 11:24:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780831488; cv=none; b=e6b2iWbqsZ3xTllcOd537MQGSet+S79/QyNf+7xX4QCm3/sXJtA1CvYjr2ThyJ1fQsfvR248hEjyQvTbV3vjFcuwElvCtB9Q848Z+bV77paeI/cNICn0gfi2DjieI68tB3i4pRjz+GOHoHZcz257v3ZKZaWt4GFDaRzwhCr730s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780831488; c=relaxed/simple;
	bh=+nmq43sNgGmd2vNw2NvmZs8Ush/0vhGvg1Eifh/Tp54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPzV2YAZEOt09eG25B0YbEtJRyXTUF8anF7ht7XIyZdegaOBtDuTk5kRTj+t+biK+Djsc24hgp2kqTPtHcy1QQd79ilzMY8MduZeKMkRc25V/zZZEMAB0AMUFaQFo/XuE2CpaRkwTgmxgvWe/HNNXKa3xvTUYya7mmViXjxsY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=pgDWmYD2; arc=none smtp.client-ip=207.46.229.174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=DARBR
	pjjX9MOXcdBF/nIEpLCCYsDkglVoq0NbmWOMXk=; b=pgDWmYD2uZ4UZHpdeIyK9
	Mej0vW0tj7aFEzMHm3cOLXDLktNQ3h6JlVNS+XtWD7nnCZYOpRXRNKwdYLt18QNp
	oxiXCj/+RTK1Pugiz7TP8i+EPqKwKjmHtCSQKOGAj1cEr+xCokya1YZ3RE6zkkuZ
	eDFctaTPR0zKe3q0HUx+AM=
Received: from localhost.localdomain (unknown [101.5.11.216])
	by web2 (Coremail) with SMTP id yQQGZQDHn5fmVCVqOR0YAg--.32045S2;
	Sun, 07 Jun 2026 19:24:22 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH net] fddi: validate skb length before parsing headers
Date: Sun,  7 Jun 2026 19:24:04 +0800
Message-ID: <20260607112408.92988-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQDHn5fmVCVqOR0YAg--.32045S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4rWr4DtFW7Cr17Jr4xWFg_yoW8KFyrpF
	ZrGrs0yrZrKrsxArn2ya10vrW5tr4vkaySgrW8KFyYvFn8W3WYyw48KF42gr1kZF48KFy7
	AFWDXr98uwn8trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0Jj4NtsUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgAJAWojJY4SbQACsV
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261891-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhaoyz24@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:zhaoyz24@mails.tsinghua.edu.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:from_mime,mails.tsinghua.edu.cn:dkim,tsinghua.edu.cn:email,seu.edu.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BDCB650724

fddi_type_trans() reads FDDI header fields from skb->data without first
checking that the received frame is long enough for those fields.

The destination address spans offsets 1-6 and the LLC dsap field is at
offset 13.  For SNAP frames, fddi->hdr.llc_snap.ethertype is at offsets
19-20.  A truncated 15-byte frame with dsap != 0xe0 therefore enters the
SNAP branch and reads the ethertype past the end of the frame.

KASAN reports this when such a frame is processed through a dummy FDDI
netdev that calls the real fddi_type_trans() on an exact kmalloc() copy
of the frame:

  BUG: KASAN: slab-out-of-bounds in fddi_type_trans+0x385/0x3a0
  Read of size 2 at addr ffff888009c6fe33
  The buggy address is located 4 bytes to the right of
  allocated 15-byte region [ffff888009c6fe20, ffff888009c6fe2f)

Reject short frames before reading the fields: require the minimum 802.2
header length before accessing dsap or daddr, and require the full SNAP
header length before reading the SNAP ethertype.  Returning protocol 0
causes the malformed packet to be ignored by protocol handlers.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/802/fddi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/802/fddi.c b/net/802/fddi.c
index 888379ae35ec..e26f4549e904 100644
--- a/net/802/fddi.c
+++ b/net/802/fddi.c
@@ -103,6 +103,9 @@ __be16 fddi_type_trans(struct sk_buff *skb, struct net_device *dev)
 	skb->dev = dev;
 	skb_reset_mac_header(skb);	/* point to frame control (FC) */
 
+	if (skb->len < FDDI_K_8022_HLEN)
+		return htons(0);
+
 	if(fddi->hdr.llc_8022_1.dsap==0xe0)
 	{
 		skb_pull(skb, FDDI_K_8022_HLEN-3);
@@ -110,6 +113,8 @@ __be16 fddi_type_trans(struct sk_buff *skb, struct net_device *dev)
 	}
 	else
 	{
+		if (skb->len < FDDI_K_SNAP_HLEN)
+			return htons(0);
 		skb_pull(skb, FDDI_K_SNAP_HLEN);		/* adjust for 21 byte header */
 		type=fddi->hdr.llc_snap.ethertype;
 	}

-- 
2.43.0


