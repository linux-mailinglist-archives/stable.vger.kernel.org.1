Return-Path: <stable+bounces-223504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CvhL0B0rmmlEgIAu9opvQ
	(envelope-from <stable+bounces-223504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 08:18:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23818234B78
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 08:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D9CB303C024
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DA25B1CB;
	Mon,  9 Mar 2026 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="UYO6gip2"
X-Original-To: stable@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84195364926
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773040656; cv=none; b=rkGL8sZdY0f6Gx8Xee4JHdDQqcmhrDu4rYxW05zo/hXOpprHG0RoQUkzmd+hZGUSQ3nH4Ipe0B1puP69jBVgS7GNSL1H/JBxOwdEQuYKUtqxlfdin+HgZubpRO8Jvb9NB+cTr9c8MDDelwL4rI823xyppV+XjpIY4NW53zwsdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773040656; c=relaxed/simple;
	bh=ErTJ9oJiQ41nXTWpalPuN4tgtAIAEsdBqpRRR75CHEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQj6WVQ2On6SxD93WjRjnkgZoPAJ8G4JMPQeDg5GjEuqZ0l8AoBBWW3to5tw4RD68QXMiQicZEgq9WIYxuRPJtJFWflRFlRueYIrF9x80T/268phkKV8C2ePjKEIYOwsVE2nhVLxkrYQIQDKmpKHikWiwuR/6F1sqa90XA1QjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=UYO6gip2; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773040653;
	bh=1Dek5A81r6AP/qj4cXStGFtHr0uB+0N7oMFFyoqIedA=;
	h=From:Subject:Date:Message-Id;
	b=UYO6gip2eT7a1JoekDf9xDQmFu7zGj9NzLJ4xMZ7MkKzJYNjKX9GFP0a4tPT5L0Gd
	 EuvbwuoB8Mj1IGnbdOmkwOo4vCTIdsuLrFynk4hUllqQSyUWRwuBVeqfT9SHZINYO7
	 DAeW7EGJdhIrDK7DnmrUj5bbiwAVRAlE0hsavJ6M=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.22) with ESMTP
	id 69AE73FC00003C17; Mon, 9 Mar 2026 15:17:24 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 1843927602396
X-SMAIL-UIID: 64C2F4942B6C4866BC7A9F60DA2FE276-20260309-151724-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1.y] dlm: fix possible lkb_resource null dereference
Date: Mon,  9 Mar 2026 15:17:15 +0800
Message-Id: <20260309071715.2380423-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23818234B78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223504-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,sina.com];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit b98333c67daf887c724cd692e88e2db9418c0861 ]

This patch fixes a possible null pointer dereference when this function is
called from request_lock() as lkb->lkb_resource is not assigned yet,
only after validate_lock_args() by calling attach_lkb(). Another issue
is that a resource name could be a non printable bytearray and we cannot
assume to be ASCII coded.

The log functionality is probably never being hit when DLM is used in
normal way and no debug logging is enabled. The null pointer dereference
can only occur on a new created lkb that does not have the resource
assigned yet, it probably never hits the null pointer dereference but we
should be sure that other changes might not change this behaviour and we
actually can hit the mentioned null pointer dereference.

In this patch we just drop the printout of the resource name, the lkb id
is enough to make a possible connection to a resource name if this
exists.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
[ The context change is due to the commit e1af8728f600
("fs: dlm: move internal flags to atomic ops") in v6.4
which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 fs/dlm/lock.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 0b1bc24536ce..d5aeda3399f9 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2908,16 +2908,14 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	case -EINVAL:
 		/* annoy the user because dlm usage is wrong */
 		WARN_ON(1);
-		log_error(ls, "%s %d %x %x %x %d %d %s", __func__,
+		log_error(ls, "%s %d %x %x %x %d %d", __func__,
 			  rv, lkb->lkb_id, lkb->lkb_flags, args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
+			  lkb->lkb_status, lkb->lkb_wait_type);
 		break;
 	default:
-		log_debug(ls, "%s %d %x %x %x %d %d %s", __func__,
+		log_debug(ls, "%s %d %x %x %x %d %d", __func__,
 			  rv, lkb->lkb_id, lkb->lkb_flags, args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
+			  lkb->lkb_status, lkb->lkb_wait_type);
 		break;
 	}
 
-- 
2.34.1


