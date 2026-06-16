Return-Path: <stable+bounces-265164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id doPeK/WEMWr1lQUAu9opvQ
	(envelope-from <stable+bounces-265164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08989692F30
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BeIoXz1L;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265164-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265164-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC2430F7793
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A369449EA8;
	Tue, 16 Jun 2026 17:09:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AC1A6803;
	Tue, 16 Jun 2026 17:09:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629799; cv=none; b=ELYuif7v69N81WUQ12XPN3R1y03njKSd2Gq+hxZN38KXAEY94XWcO9JQbwAIrlO0QeiroBE1IbMfU2KEgL63Qp95GTOEO9OtgIxtjMTmlF4PiQnw3vCTPYnh1p8qWxo1bu0Hc/tUVth0mxyDa8K8ynPTvG6ZjcCKCOqvJwpWn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629799; c=relaxed/simple;
	bh=lfyBDrVCB4sekq2iz044xATwWmU1/JBb2kjqH578MEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=em0S3xZ95wHzn1Ce/S2djGU9+4FPJ1GkhqfnWZ28Wkhq/sjNfNWAgOPyOKn/tGR5WnS++Oe9EFYn+zMazGyOsO6wXeD0dBTZtEZjaXZZJmRZLv3IX72nViWW6aKkdvdh6/d9Z0eGjWuY/7BfoDvUCY4h6bfA1IhXQHqlOUEHYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BeIoXz1L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC721F000E9;
	Tue, 16 Jun 2026 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629797;
	bh=L9LV+TJVu4yiYkipv9+GpQaqf+Upsn6l32176YhYiok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BeIoXz1LAC9HeN4GQkReQSXlJ/S0sbNF/b4EZT5Et+qLocFl8BK4o3Qh3wTznhIH4
	 pXEx/On7he9OYhxYgzmH+IOXuIfuSwVAeRjZVuuXXzlEo2E0LZkrb7wMZ3kM0aTQ+V
	 wJl6tMqpPnbbpw2nJJkBG22ZZ6GnIiPr9EjppIhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	Md Haris Iqbal <haris.iqbal@linux.dev>,
	Moshe Shemesh <moshe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 337/452] net/mlx5: Reorder completion before putting command entry in cmd_work_handler
Date: Tue, 16 Jun 2026 20:29:24 +0530
Message-ID: <20260616145135.029083358@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265164-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kniv@yandex-team.ru,m:haris.iqbal@linux.dev,m:moshe@nvidia.com,m:tariqt@nvidia.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,nvidia.com:email,vger.kernel.org:from_smtp,yandex-team.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08989692F30

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Kuratov <kniv@yandex-team.ru>

commit 02896a7fa4cd3ec61d60ba30136841e4f04bdeac upstream.

Assuming callback != NULL && !page_queue, cmd_work_handler takes
command entry with refcnt == 1 from mlx5_cmd_invoke.
If either semaphore timeout or index allocation error happens,
it does final cmd_ent_put(ent). To avoid access to freed memory,
notify slotted completion before cmd_ent_put.

This is theoretical issue found by Svace static analyser.

Cc: stable@vger.kernel.org
Fixes: 485d65e135712 ("net/mlx5: Add a timeout to acquire the command queue semaphore")
Fixes: 0e2909c6bec90 ("net/mlx5: Fix variable not being completed when function returns")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260526162932.501584-1-kniv@yandex-team.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -989,12 +989,13 @@ static void cmd_work_handler(struct work
 				ent->callback(-EBUSY, ent->context);
 				mlx5_free_cmd_msg(dev, ent->out);
 				free_msg(dev, ent->in);
+				complete(&ent->slotted);
 				cmd_ent_put(ent);
 			} else {
 				ent->ret = -EBUSY;
 				complete(&ent->done);
+				complete(&ent->slotted);
 			}
-			complete(&ent->slotted);
 			return;
 		}
 		alloc_ret = cmd_alloc_index(cmd, ent);
@@ -1004,13 +1005,14 @@ static void cmd_work_handler(struct work
 				ent->callback(-EAGAIN, ent->context);
 				mlx5_free_cmd_msg(dev, ent->out);
 				free_msg(dev, ent->in);
+				complete(&ent->slotted);
 				cmd_ent_put(ent);
 			} else {
 				ent->ret = -EAGAIN;
 				complete(&ent->done);
+				complete(&ent->slotted);
 			}
 			up(&cmd->vars.sem);
-			complete(&ent->slotted);
 			return;
 		}
 	} else {



