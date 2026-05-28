Return-Path: <stable+bounces-254716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HSNHoLWF2rASggAu9opvQ
	(envelope-from <stable+bounces-254716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:45:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFEF5ECFED
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2B3631346E7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 05:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45731E850;
	Thu, 28 May 2026 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Jsc6McTB"
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFB830B51D;
	Thu, 28 May 2026 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946786; cv=none; b=ZJRRwGBIn29W3qXxd/m9hcJ9LVK2ygADglkqaP+O6lZSfWIeJt+8xTne5c5wBhSoX7ZdIm0TF6OPYFfCbOJxpFR5RZoMWvqMvaOYYH6dmvakSquaEerWIkEC07YWfZ7P/PiUP4sSbVpS9c8stEI36vo96LVmUSCF/jGqOX722bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946786; c=relaxed/simple;
	bh=7B9rAloplA1r0RcsAVNw91QYS8XurF/90pYnFiAZW68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cmGD5z02ZwTznzhq9+pT/FlnfEuELTeoksNpnCn4jp99/8w1dw2sHXJDPrxs66hR1NZK94L4iEMu44WNWVSk4MSNYgTcLbF6BE3kvk0EfIAZexEJ38t4uKpsaTazg+w27dv1CTtO7R8zK+xs16WjqC5VTG7RCRhMNExrI6e4r2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Jsc6McTB; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=t9xPm
	cjXLaN1tlmUCZXzsomKbqKsGYPnhhUGNiUjI60=; b=Jsc6McTBAMSFbr21qEvhV
	X0xou8zwKbWrU9pChKGtjgKt+x7trzLSIeT8cczQjIYTofHsV7pZ7QmU1VMlYSod
	UiK4cAK+laVYx+iJxvq4FUek5RCloUaEYAGckaXkqJHV9u9wa25nIFs8528u1kay
	g7fb14BwigwXi6RF4QJSQc=
Received: from localhost.localdomain (unknown [59.66.142.89])
	by web3 (Coremail) with SMTP id ygQGZQCn8o8L1RdqWOP0AQ--.36784S2;
	Thu, 28 May 2026 13:39:24 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: v9fs@lists.linux.dev
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH] 9p: avoid putting oldfid in p9_client_walk() error path
Date: Thu, 28 May 2026 13:39:16 +0800
Message-ID: <20260528053918.53550-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCn8o8L1RdqWOP0AQ--.36784S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry8KFy8Kw1xGr4xuw4rKrg_yoW8ArWfpF
	W7CFsxKF95Zry2yan7Ka4xXryrGrZ5CFyrKrWjyw42v3Z8JF1ktF4kK34fur9IkwnrKFWU
	tFWDKFWj9F1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjV1v3UUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQMBAWoXbq7SMwAAse
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,kernel.org,ionkov.net,codewreck.org,crudebyte.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254716-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tsinghua.edu.cn:email]
X-Rspamd-Queue-Id: CCFEF5ECFED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When p9_client_walk() is called with clone set to false, fid aliases
oldfid. If the walk subsequently fails after the request has been sent,
the error path jumps to clunk_fid, which currently calls p9_fid_put(fid)
unconditionally.

This drops a reference to oldfid even though ownership of oldfid remains
with the caller. If this is the last reference, oldfid can be clunked and
destroyed while the caller still expects it to be valid. A later use or
put of oldfid can then trigger a use-after-free or refcount underflow.

Fix this by only putting fid in the clunk_fid error path when it does not
alias oldfid, matching the existing guard in the error path below.

This can be triggered when a multi-component walk is split into multiple
p9_client_walk() calls and a later non-cloning walk fails. A reproducer
and refcount warning logs are available on request.

Fixes: b48dbb998d70 ("9p fid refcount: add p9_fid_get/put wrappers")
Cc: stable@vger.kernel.org
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM 5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/9p/client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index f0dcf25..4b942d0 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1092,7 +1092,8 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
 
 clunk_fid:
 	kfree(wqids);
-	p9_fid_put(fid);
+	if (fid != oldfid)
+		p9_fid_put(fid);
 	fid = NULL;
 
 error:
-- 
2.43.0


