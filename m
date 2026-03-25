Return-Path: <stable+bounces-230328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HteN1ndw2kgugQAu9opvQ
	(envelope-from <stable+bounces-230328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:04:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2132568E
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50FBE3363E7F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63C13DBD73;
	Wed, 25 Mar 2026 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZgdxCoaA"
X-Original-To: stable@vger.kernel.org
Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B53DA7E4
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440698; cv=none; b=l1Sl0nidpUeXszXboMs8lF++fTBPOd07Q52zuFNnoRSVy3evG5wwfUfejzaGYJMFOK6zayQihmih4NbbjzM4XpIalvsiy9atK/ECKZN18CrT1FVwMmoni0qd1ThwHgX9KgRzvBl0lTIfIAy+vKMBewwM7GHBMv9x0YdwWp6ELTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440698; c=relaxed/simple;
	bh=YAUtJDw2f3K/ebctitXa9tJPCYVwC+kEThdG8vlj+yw=;
	h=From:Date:Message-Id:Mime-Version:To:Subject:Content-Type:Cc; b=u6OZz5x+60FkOPgwuzI50Ibld3iuDMWLKod7yuLsclISiOuY5Siqcguuu4Ruh64FCVMbdj7qkVCdhFhoMjU4rKPw7ThVwhXvtcHjcM/dXV46CH1vmSgUfPXxIb3P1uSS3VvYtXDwtTY3pZvyG+Iwt5WFsRuJ/YGmfnjs73h5ihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZgdxCoaA; arc=none smtp.client-ip=209.127.231.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1774440685; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=7gvAcvhp23Tp997YHFDCTzlIp6jmCAkjpZ+WoXr7cCM=;
 b=ZgdxCoaAnsIUVN/p44EDxIRkHUPLJ/n9e6YmiZCL9YaJ1wFN+3gX+22f1+m8QCvi7SizMi
 VFFkSbtw51NcqpiT8uWsHpyJ8SIPa0dgOtofoURVP/HgcF6TvaPZsv036J38NG+ShaVjN2
 xnVDz7CGYoyCNIycKxW3y6hkJTZxDD1Ro4F1r7TXv4PoLo58jMO3h/w2OWe7FOAnW2QT6b
 8oeQ72yZOIDxffqc36ZAO3ay8vZxFZFr18HqH34fMthFuQ76VOZPZsHSNMmgApJMZDck4r
 dtVxtjlPumbGtwbM9Lqw+ppLahyN2+MBA59XH5yl4uZOZGAuj4Rqf4kKWR4Rcw==
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Wed, 25 Mar 2026 20:11:09 +0800
Message-Id: <20260325121109.89705-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+269c3d0eb+bbc1c0+vger.kernel.org+qirui.001@bytedance.com>
To: <minyard@acm.org>
Subject: [PATCH] ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp
Content-Type: text/plain; charset=UTF-8
Cc: <linux-kernel@vger.kernel.org>, 
	<openipmi-developer@lists.sourceforge.net>, 
	"Rui Qi" <qirui.001@bytedance.com>, <stable@vger.kernel.org>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.52.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230328-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qirui.001@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:dkim,bytedance.com:email,bytedance.com:mid]
X-Rspamd-Queue-Id: 1FA2132568E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a bug where rcu_read_unlock() was used instead of srcu_read_unlock()
in handle_read_event_rsp() when ipmi_alloc_recv_msg() fails.

This mismatch can lead to SRCU read-side critical section imbalance.

Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
Cc: stable@vger.kernel.org # 6.12

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 71c6ec8a87927..d2bbf8ffd9d76 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4388,7 +4388,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 
 		recv_msg = ipmi_alloc_recv_msg(user);
 		if (IS_ERR(recv_msg)) {
-			rcu_read_unlock();
+			srcu_read_unlock(&intf->users_srcu, index);
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
 				list_del(&recv_msg->link);
-- 
2.20.1

