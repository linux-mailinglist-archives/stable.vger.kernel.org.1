Return-Path: <stable+bounces-211668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDhJOpWod2nrjwEAu9opvQ
	(envelope-from <stable+bounces-211668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:47:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDE48BA2D
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250673015485
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA6A2E8B8F;
	Mon, 26 Jan 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XohR/+Mx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D8238C0D
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449617; cv=none; b=GjOo8IUivJTFfyAaezp5jNJxSSdZvRQha6fioTFp07KYPyAfNwve9HGE3wnM2xiTTqbDvPWlzWxMZQtNDZwF5Ms24Imi14q9K6gwO4bvSsL94Fm9p9j5Wcn43npQIJ1kfa9vCr+D67jN4uKg+kaKnC/IeP7LV8TTP3Mj9BAhrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449617; c=relaxed/simple;
	bh=eVxyZVpphCu5K31kZj5MJ7SVfdg/Plr6Bf+KCRfAzj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1IDeluNz/eHpecuOeMwT2rMDEePgUUPX8HSS4v78akkrfZbBrbVUoxx8RmsH0sPfvfltCSBdMGZyYYBnvIPCagNCoiITqf6zrMfTk/L9Mur5N9R+x423xUr4LXOPB8cLv8I2AtKMe4zTxcIHA6t3qd6kXc/NQRw5kK1fawhwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XohR/+Mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5E7C116C6;
	Mon, 26 Jan 2026 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769449617;
	bh=eVxyZVpphCu5K31kZj5MJ7SVfdg/Plr6Bf+KCRfAzj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XohR/+MxmNeIFH0MXjevv3kNY1GHTvWzJciFb5eBGx5ZC1CgbeiGfqIYGzpFHe1Ba
	 GuAbuKqjFz2hD87jDlp1iZpbwASy6uHzwB8l9Lp9Lpc55HZsNTuLqhg5M7VJBMkJsL
	 CwTUoTgjfsvf/HFnuqDWbjbQvd2Xduif/BYWH6lueTvA7YjVdN5NY6OtjI8G7zAUGs
	 Tesw6bsMjceOKPP6Nxwvsj9czjZo4kvuupKjxYkX7YX+N4j1HOoCYR6C8eAwYicd09
	 1tbt7/kirqI6ITyz5De4JW0RQF9L+coyfvu2uj0rS0xJkL7azlqoBK2FaEsBaxoKNG
	 SAEJf8n1jPYLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Juergen Gross <jgross@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()
Date: Mon, 26 Jan 2026 12:46:54 -0500
Message-ID: <20260126174654.3437191-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012626-aghast-repeated-f60b@gregkh>
References: <2026012626-aghast-repeated-f60b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211668-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,suse.com:email,iitm.ac.in:email]
X-Rspamd-Queue-Id: 2CDE48BA2D
X-Rspamd-Action: no action

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

[ Upstream commit 901a5f309daba412e2a30364d7ec1492fa11c32c ]

Memory allocated for struct vscsiblk_info in scsiback_probe() is not
freed in scsiback_remove() leading to potential memory leaks on remove,
as well as in the scsiback_probe() error paths. Fix that by freeing it
in scsiback_remove().

Cc: stable@vger.kernel.org
Fixes: d9d660f6e562 ("xen-scsiback: Add Xen PV SCSI backend driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://patch.msgid.link/20251223063012.119035-1-nihaal@cse.iitm.ac.in
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ adapted void scsiback_remove() to int return type with return 0 statement ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xen-scsiback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 9cd4fe8ce6803..fd0ce2f6bbe47 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1202,6 +1202,7 @@ static int scsiback_remove(struct xenbus_device *dev)
 	gnttab_page_cache_shrink(&info->free_pages, 0);
 
 	dev_set_drvdata(&dev->dev, NULL);
+	kfree(info);
 
 	return 0;
 }
-- 
2.51.0


