Return-Path: <stable+bounces-211642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG6MNqiNd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:52:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34D8A54B
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D15A13013D40
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB6340A47;
	Mon, 26 Jan 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beL5rRrI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF433E35D
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442682; cv=none; b=FMYi3Nge3iE2oJ7lNQCttZUxpakFeJWQWmESl2JN/pl+ytiLN8t30bV6hz/4uNmEW0I7Lw/lZgz6hkgDYYI1F71tghwt0s593T3Ul/R3fCVZiHYYG/uwyC6RisGYxiV+QszLPkkfDoN0uQQizIN9rs0PxVvKAXsWiKnzkLocc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442682; c=relaxed/simple;
	bh=xeFdJ9LLOxMmy0KLBODKsm1h98uHx3SHMFPm5lt2giw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIz6a6sAVHsI3nPd4JGSoy5hDLnHtgixrZc1NVKYZL2OEmiflCT6foDfVMzZQJn9dNIi3sFs+TYNCqS9kkx1vvNDX2gXVBraGSmauk1N9YoHMqWI2kcRRA1qshslnPRluwzuVe8ON1sDYRF3WHsRdVbtKdzGP6MFLqfzAvu8t1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beL5rRrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9671C16AAE;
	Mon, 26 Jan 2026 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442682;
	bh=xeFdJ9LLOxMmy0KLBODKsm1h98uHx3SHMFPm5lt2giw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beL5rRrISqvdqSOlIXgjQjvBe9gkNacbmjFR4xAtgZ9jjgM9/6EF7WusUEsDlJX5B
	 k2zUFo8kssaFiNbWURFfQwot/uXQWmWJK9TcvkbFTojWt9dVz1ADtbFhI+JD+l3VuU
	 aHrOpNWZoAVrCDpoeqA6dH8ok4Sw4RvD9+jEkPx6pVr1PysHdff6Rs2eYnYUl4gcU4
	 uayMf6YOWIy+NTulUn/D771Ra2OJJfCbiBCokIZfvVYq7OhwCAOxmKrGU/2XByGEiu
	 NzmnRUPF+TS2NP3n3EJxh9DC3ml0xMqqHBbVm0GSxzBP7ocTwLau3SCSLMp4rMKrlh
	 jg+JQ8nD8C9+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Juergen Gross <jgross@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()
Date: Mon, 26 Jan 2026 10:51:19 -0500
Message-ID: <20260126155119.3323199-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126155119.3323199-1-sashal@kernel.org>
References: <2026012625-perky-unquote-b3a5@gregkh>
 <20260126155119.3323199-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211642-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,suse.com:email]
X-Rspamd-Queue-Id: 7A34D8A54B
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xen-scsiback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 954188b0b858a..dcc9d15504df0 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1261,6 +1261,7 @@ static void scsiback_remove(struct xenbus_device *dev)
 	gnttab_page_cache_shrink(&info->free_pages, 0);
 
 	dev_set_drvdata(&dev->dev, NULL);
+	kfree(info);
 }
 
 static int scsiback_probe(struct xenbus_device *dev,
-- 
2.51.0


