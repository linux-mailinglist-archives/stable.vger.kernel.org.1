Return-Path: <stable+bounces-218875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDM2DWlZnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:07:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96984190932
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D9A32B2DBB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DCE27E1D7;
	Wed, 25 Feb 2026 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c6Fi+P4d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34C279DB3;
	Wed, 25 Feb 2026 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983762; cv=none; b=EcIuzrdzeX/E0Br7ts3u0MeOftW9IP02gjbCr5cE2Fx9dYJ4xRSzuPx5YJeTVloqQ9s0/XWscbg7uWHhrHlEe71kkTswkwQ0uHCrt6TVH4hhzPEXGAvyp5uSotUlnUoj7ZyvP1Mac5Nj1HHtYxiG6TAK6aLY4kF+DMuPrkHeoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983762; c=relaxed/simple;
	bh=HZezEj2GKrNfhLSr3DxJMh4MPaIRhOUVBnaAKd9N++w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ52G1wwY63ioIM6m3ZUpLh2klMw6LI7wSGZk3KiEiFdgv05RRMk2V31Wx7hPHaoLAH4x8OfUTN/FdvRctMfplIqWDV3X7kHd5gXGkCd7NKULt5me1D4xNKPLK9DKDrQTHo2VVmU1qdZg2v6EHQ/rjOYhRERPCg5IB6XHdliM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6Fi+P4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA8AC116D0;
	Wed, 25 Feb 2026 01:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983762;
	bh=HZezEj2GKrNfhLSr3DxJMh4MPaIRhOUVBnaAKd9N++w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6Fi+P4dQm+jI+akyWziifLSlPyqQJLdn8WdlcuiOjCivPSLfS/iUQJUGTL586jSo
	 jw32Owmg7WbCwx0hsfLUkG09An9zbqBorAsLWl4STiixIdmmvsQ38nLoq09HraTY7E
	 BWoRipkDvhidHMERnlKo+iTQqvxrsaWqsoWMUhJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/641] md/raid1: fix memory leak in raid1_run()
Date: Tue, 24 Feb 2026 17:16:20 -0800
Message-ID: <20260225012350.346799937@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218875-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,seu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,fnnas.com:email]
X-Rspamd-Queue-Id: 96984190932
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 6abc7d5dcf0ee0f85e16e41c87fbd06231f28753 ]

raid1_run() calls setup_conf() which registers a thread via
md_register_thread(). If raid1_set_limits() fails, the previously
registered thread is not unregistered, resulting in a memory leak
of the md_thread structure and the thread resource itself.

Add md_unregister_thread() to the error path to properly cleanup
the thread, which aligns with the error handling logic of other paths
in this function.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Link: https://lore.kernel.org/linux-raid/20260126071533.606263-1-zilin@seu.edu.cn
Fixes: 97894f7d3c29 ("md/raid1: use the atomic queue limit update APIs")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Li Nan <linan122@huawei.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 592a402330047..ce7fd68869566 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3253,6 +3253,7 @@ static int raid1_run(struct mddev *mddev)
 	if (!mddev_is_dm(mddev)) {
 		ret = raid1_set_limits(mddev);
 		if (ret) {
+			md_unregister_thread(mddev, &conf->thread);
 			if (!mddev->private)
 				raid1_free(mddev, conf);
 			return ret;
-- 
2.51.0




