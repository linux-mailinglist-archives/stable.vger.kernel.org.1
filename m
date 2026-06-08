Return-Path: <stable+bounces-261950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8UWJHN42JmoXTgIAu9opvQ
	(envelope-from <stable+bounces-261950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 05:28:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0616526ED
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 05:28:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=U0hOQ4p7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261950-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261950-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FB0C3001863
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 03:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39131F988;
	Mon,  8 Jun 2026 03:28:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A832EBBA1
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 03:28:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780889302; cv=none; b=Qgdix5suc1c/Z/x6lahsI16IQxtQQk6fjgAkG93fP2QfUrexC74j/0UppphL1n+eqN85CtFBvLRA0Aw3jOwP3Bk+JU6H+ezpohPHnGjBEtyAp4SaoaqTZl4E62D9K+fRENuzZ65SpVofSrBUJLAWAw89ZrymgeP+Z1ubEXSocqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780889302; c=relaxed/simple;
	bh=3p21nhULlOFap4CtEJAN7xI98sP0bCHb96zjeXMO1QA=;
	h=Date:In-Reply-To:From:Message-Id:Mime-Version:Content-Type:Cc:
	 Subject:To:References; b=odJEBSlrPDHXtVdpMBVUmf737HoSKeiRFKWv7l3WunuoSJUDOxs+X0DKAk51ihGQRmOX7dFEAgc7dpRoIhGjOUm7CvZZrGGoQj9i+2jWKVrErS0bce9iQniHgyEkLeeRHeDd2QyV0xIgtDHr/aezK22PUpZ50ePQVXCATIJUstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U0hOQ4p7; arc=none smtp.client-ip=209.127.230.113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780889289; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BnFRpGMvMTrAbPzGLBDo0aZKDmaAWW1kmVRIz1TflEw=;
 b=U0hOQ4p7IR8Xds0jMGNhepJFq5476BiqnlGgQbtDlwybLaJOkApC/Bwzv4m5Cydjn8n8i7
 o9ywhTOnxuaZfz4gj1CPZukcBwsag6FAn+1sy1qg+YbTyx9eerOcpKfT2Rkgr6iBPnQIyx
 YzdQRCyx4dT/kPj0Nsa8TWxCEy1BlVJit7/f3c7tBtIIhJg4KPUQjUYXxFCJ5eQq3cm40V
 /Ei6SgznzSlqI5ytTYQ2eNC6BAtdSgJsRxkepvRCT688IGMqsLtAvJRw2ixCIFRpeI9QOU
 9Ed8dbbWHlJu9EkZQ1omn/5paqT16uMdMJpb80hj6PHu2+JCvRO7WKKHYvcKfA==
Date: Mon,  8 Jun 2026 11:27:54 +0800
X-Original-From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <20260525063235.990101-1-qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260608112000.1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: "Rui Qi" <qirui.001@bytedance.com>, 
	<openipmi-developer@lists.sourceforge.net>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp
X-Lms-Return-Path: <lba+26a2636c7+557759+vger.kernel.org+qirui.001@bytedance.com>
To: "Corey Minyard" <minyard@acm.org>
References: <20260525063235.990101-1-qirui.001@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:qirui.001@bytedance.com,m:openipmi-developer@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:minyard@acm.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[qirui.001@bytedance.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-261950-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qirui.001@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:mid,bytedance.com:dkim,bytedance.com:from_mime,bytedance.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B0616526ED

Hi Corey,

I'm following up on this patch which was originally submitted on
March 25 and resubmitted as v2 on May 25. I haven't received any
feedback so far, so I wanted to bring it back to your attention.

To recap, this is a one-line fix for handle_read_event_rsp() where
rcu_read_unlock() is incorrectly called instead of srcu_read_unlock()
on the error path, leaving the SRCU read-side lock held.

This patch is specifically targeted at stable branches (v6.12 and
earlier) that still carry the original SRCU-based locking. In
mainline, commit 3be997d5a64a ("ipmi:msghandler: Remove srcu from
the ipmi user structure") has already restructured this function to
use a mutex, effectively eliminating the bug. However, that commit
is part of a larger SRCU removal series that is not suitable for
stable backport.

Since the affected code no longer exists in mainline or your
for-next tree, this patch cannot follow the usual path of being
applied there first and then cherry-picked by stable. Could you
please review and provide an Acked-by so the stable team can pick
it up directly?

No changes since v2. The patch is reproduced below for convenience.

From: Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in
 handle_read_event_rsp

Fix a bug where rcu_read_unlock() was used instead of srcu_read_unlock()
in handle_read_event_rsp() when ipmi_alloc_recv_msg() fails.

This mismatch leads to an SRCU read-side critical section imbalance: the
entry uses srcu_read_lock(&intf->users_srcu) but the error path
incorrectly calls rcu_read_unlock(), which is a no-op for SRCU and
leaves the SRCU lock held.

The offending code was restructured in mainline by commit 3be997d5a64a
("ipmi:msghandler: Remove srcu from the ipmi user structure"), which
replaced the SRCU locking with a mutex in this function, effectively
eliminating the mismatch. However, that commit is part of a larger
SRCU removal series that is not suitable for stable backport. This
minimal fix addresses the SRCU imbalance for 6.12 and earlier stable
branches that still carry the original locking scheme.

Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
Cc: stable@vger.kernel.org
Signed-off-by: Rui Qi <qirui.001@bytedance.com>

 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 188722ec0337..41ae4dac4eeb 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4395,7 +4395,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,

 		recv_msg = ipmi_alloc_recv_msg(user);
 		if (IS_ERR(recv_msg)) {
-			rcu_read_unlock();
+			srcu_read_unlock(&intf->users_srcu, index);
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
 				list_del(&recv_msg->link);

