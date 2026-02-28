Return-Path: <stable+bounces-220458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGKjHgE8o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDFF1C68B1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD2B635D2DDA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1B3BA8F6;
	Sat, 28 Feb 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thwszh8O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA543BA8E4;
	Sat, 28 Feb 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300346; cv=none; b=VEMX19lebWjJ1mIdlRGCadzHQev3F9MpaHR+ttAnxqB87FMzP0uQ3jKafaVB5xjAm79SXci2Qi/eiacegmnIRhvEAO7cD1Hp4qnk1LPGMAWhR84GsIR0Cmfd0desCniZESGFftstnfcJVOIJ13nPkJbqNfZLBK3ZCTHsvGS6wwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300346; c=relaxed/simple;
	bh=wa9SgM5VuYcoV5xYsyuevJVQEAqVrSY4rN/akS6gnJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwGJVZOTB/tjMndxxn+scANEjMAQFT0OX1WFWNCf+nJKxebYeduzD4SKzI3xT0SEsGpZC+9ONsyl/Joc1A4INHxthUu8N+SlsD2jAb5mp1Vsvszo05lXsPg9uIzBrnYn13ctzhx+O3GGzSuBZMOckUoVVpHI37+rR6jSKbz7N3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thwszh8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7267DC116D0;
	Sat, 28 Feb 2026 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300346;
	bh=wa9SgM5VuYcoV5xYsyuevJVQEAqVrSY4rN/akS6gnJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thwszh8Oaw1KEr3wjIhSBTBSqkPJyyQuB48kjqER4ElKamWwLqprYwa8pqKGyvrjo
	 l0sbpoZwHrzf23+lxdVQyOT++JpeAqQXJxNuzNJh5pvX4duUWYRDnNXsWmgtrUbMtk
	 Zn/raLYRr8rpio6P9oKmmegM0q/Q3Y5pKHMDTOo0q0UM8NfYGY1S9u18aPmAUd4kdt
	 ZMgLuLmw+y5fs1+wmudXCJiFEyHBFGslJ9Ss5GDcGeyxlLlW4vZdDY7ESOyy9i2pWA
	 sZ0qAIt2J12M9sxxGMbwD1bprETEz9MvPJLNOWRdLR6shs/gKqynx10L6abp+Nzjud
	 Ql2gf1ljuOrKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tuo Li <islituo@gmail.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 379/844] misc: bcm_vk: Fix possible null-pointer dereferences in bcm_vk_read()
Date: Sat, 28 Feb 2026 12:24:52 -0500
Message-ID: <20260228173244.1509663-380-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220458-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,broadcom.com:email,msgid.link:url]
X-Rspamd-Queue-Id: CCDFF1C68B1
X-Rspamd-Action: no action

From: Tuo Li <islituo@gmail.com>

[ Upstream commit ba75ecb97d3f4e95d59002c13afb6519205be6cb ]

In the function bcm_vk_read(), the pointer entry is checked, indicating
that it can be NULL. If entry is NULL and rc is set to -EMSGSIZE, the
following code may cause null-pointer dereferences:

  struct vk_msg_blk tmp_msg = entry->to_h_msg[0];
  set_msg_id(&tmp_msg, entry->usr_msg_id);
  tmp_msg.size = entry->to_h_blks - 1;

To prevent these possible null-pointer dereferences, copy to_h_msg,
usr_msg_id, and to_h_blks from iter into temporary variables, and return
these temporary variables to the application instead of accessing them
through a potentially NULL entry.

Signed-off-by: Tuo Li <islituo@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Link: https://patch.msgid.link/20251211063637.3987937-1-islituo@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/bcm-vk/bcm_vk_msg.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 1f42d1d5a630a..665a3888708ac 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -1010,6 +1010,9 @@ ssize_t bcm_vk_read(struct file *p_file,
 	struct device *dev = &vk->pdev->dev;
 	struct bcm_vk_msg_chan *chan = &vk->to_h_msg_chan;
 	struct bcm_vk_wkent *entry = NULL, *iter;
+	struct vk_msg_blk tmp_msg;
+	u32 tmp_usr_msg_id;
+	u32 tmp_blks;
 	u32 q_num;
 	u32 rsp_length;
 
@@ -1034,6 +1037,9 @@ ssize_t bcm_vk_read(struct file *p_file,
 					entry = iter;
 				} else {
 					/* buffer not big enough */
+					tmp_msg = iter->to_h_msg[0];
+					tmp_usr_msg_id = iter->usr_msg_id;
+					tmp_blks = iter->to_h_blks;
 					rc = -EMSGSIZE;
 				}
 				goto read_loop_exit;
@@ -1052,14 +1058,12 @@ ssize_t bcm_vk_read(struct file *p_file,
 
 		bcm_vk_free_wkent(dev, entry);
 	} else if (rc == -EMSGSIZE) {
-		struct vk_msg_blk tmp_msg = entry->to_h_msg[0];
-
 		/*
 		 * in this case, return just the first block, so
 		 * that app knows what size it is looking for.
 		 */
-		set_msg_id(&tmp_msg, entry->usr_msg_id);
-		tmp_msg.size = entry->to_h_blks - 1;
+		set_msg_id(&tmp_msg, tmp_usr_msg_id);
+		tmp_msg.size = tmp_blks - 1;
 		if (copy_to_user(buf, &tmp_msg, VK_MSGQ_BLK_SIZE) != 0) {
 			dev_err(dev, "Error return 1st block in -EMSGSIZE\n");
 			rc = -EFAULT;
-- 
2.51.0


