Return-Path: <stable+bounces-211667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGoHLn2nd2lrjwEAu9opvQ
	(envelope-from <stable+bounces-211667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:42:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B98B98E
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14803300698E
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227434D3BB;
	Mon, 26 Jan 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QntdRDk7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649133BBD3
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449334; cv=none; b=KTBeqJWZrLnuosKweYdw7wOLPYN9PFYL7vxXJ7nDOaeRhOq3zcj8QmB2b7Pt1tuPMc6bF3OZ+sJdgwdUgfXfBjpeLvgEu40Xp/0emfgtntC6w/rxHh4rZEW3nohyz8WSTxgnrwziswSHYMfHyfD9vvUc7S833J4JDhc99yQXx2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449334; c=relaxed/simple;
	bh=/6oTyU/FHCHObhp6MXUqc+x1DjEaIFeAjpptJsgYVMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9bTLdgof2h1QX9rCqyKv4ZPvmdhdZ5RCoiYwIp67WwnjthHHUCsl7XC1VrN1xo6LKDrTUsbKiYyxrPEtsddiQi3AJij8KKQVZKFgH2e7wLL5zbD6eB+i6h/LAf0Fjx6uvPHK2lv0+7cmiv5zVvOkc32i4pce0DpCH3ogQvKcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QntdRDk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2AFC2BC86;
	Mon, 26 Jan 2026 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769449334;
	bh=/6oTyU/FHCHObhp6MXUqc+x1DjEaIFeAjpptJsgYVMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QntdRDk7bR8tIBzVUEYRPWbX1O2avBf8DBuchNwkBT8Gb39XmadNCEMPute69oLPN
	 u2ypxew9rRprc3seaiaxvb2V1PK4b1DCbIaWqPhAU6W+y6yPdTTKNWzeAz7e0Y+6Tm
	 hOdnWX1UjrqzzlqVoM2nL9rQF5MHvZbZfQxeLLaGiozngvPmI6AGjVxxpG8mpzrlnA
	 8B5DO94Jm4fyGN8LKRrfwKIqK8BVm3PHCiX1OwsRmgRgP+tmPai9WixPfx7ZTLToYr
	 QinTd7yGEsPiNSQucxmKmUF/UMRyEtwyEtmTzLLI+78mI9ff2CBOVU4/rSzgH0pEPS
	 aUS2OEayFMJNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Juergen Gross <jgross@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()
Date: Mon, 26 Jan 2026 12:42:12 -0500
Message-ID: <20260126174212.3433842-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012626-cognitive-spoiled-5d7d@gregkh>
References: <2026012626-cognitive-spoiled-5d7d@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211667-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,iitm.ac.in:email]
X-Rspamd-Queue-Id: BE7B98B98E
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
index 0c5e565aa8cff..244029f4a96f1 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1197,6 +1197,7 @@ static int scsiback_remove(struct xenbus_device *dev)
 	gnttab_page_cache_shrink(&info->free_pages, 0);
 
 	dev_set_drvdata(&dev->dev, NULL);
+	kfree(info);
 
 	return 0;
 }
-- 
2.51.0


