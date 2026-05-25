Return-Path: <stable+bounces-254092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBZdC2XuE2qHHgcAu9opvQ
	(envelope-from <stable+bounces-254092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:38:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9040B5C693E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEE1C3037695
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC838E126;
	Mon, 25 May 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bLzA+2px"
X-Original-To: stable@vger.kernel.org
Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBD3A7F41
	for <stable@vger.kernel.org>; Mon, 25 May 2026 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690781; cv=none; b=S3b82XehFz5Qkz//v0CuoCVgHakBvOeQv+QTagLgGTYwwJZk023OB5JqzS0ipI2YXQoWxZXCzXZIu84QK7+62X8k138ZAj1GsZMR468vrVtuHTljXI5R6rLP05lN1DYMGEzz+cOZy8HaQpGCNzprAoLy0qbQEMtDc9BEo65Yeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690781; c=relaxed/simple;
	bh=PT/6j//cUYRye2KeDUxQ/fGyunYOhu9WR8MQyypHQ5U=;
	h=Content-Type:Cc:From:Mime-Version:To:Subject:Date:Message-Id; b=kTr9FdsCLtFC/OD5RK8WlIPYh618DsOF4N+78yINgMdcrXBJB0BSSWf3pKDCEzh9o/hwYy/Z1ERr2awWTnNPm12qILMYcfpslUw593LTvVcymSwVIrimNYrJzq1htFXEeJ0Y9RfEY6IqEESrdJdHumrWFl8LRi+XFiHCB0wDlXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bLzA+2px; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779690769; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=07bFtTnXwilNmnh/+5dheCThlPykU801eesxhhjJU/E=;
 b=bLzA+2pxZDL84O9JAYnS0CuQkGqmhUu+9Yj+GKeZHnbZBg4+avzqv9GZ9QSxQbllzX5Te4
 0e53LIfJOrDruxTuagexfxVRRejl17FLnoAFLhRqcMvq7VzEw+axa0D2X4Q6aU9v0yCSrH
 QQgZ1syYYdeP9xGXc+cbqPTPNeXQjG9eF3iaYGWFotO8O0IM+lk+Gi5zUBJkvoh4KcqoUQ
 2oIygkc97Ruiuh/r1LujNSbsJH4wtOQ2xwLZ1Q42kpw7t4Ua+k/sF1qjpf4wkr7qXLbe03
 CDPWqs2eNdumpUCcAt+mcJNK9xVw/awuSQMY9h2k2SaJs7WIPJA77f2A1ru70A==
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <openipmi-developer@lists.sourceforge.net>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Corey Minyard" <minyard@acm.org>
Subject: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+26a13ed0f+840f9e+vger.kernel.org+qirui.001@bytedance.com>
Date: Mon, 25 May 2026 14:32:35 +0800
Message-Id: <20260525063235.990101-1-qirui.001@bytedance.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qirui.001@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:email,bytedance.com:mid,bytedance.com:dkim]
X-Rspamd-Queue-Id: 9040B5C693E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rui Qi" <qirui.001@bytedance.com>

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
---
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
--
2.20.1

