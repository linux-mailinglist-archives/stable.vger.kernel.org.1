Return-Path: <stable+bounces-218086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OAtFINQnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54F18EC2A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 454F03057EEE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0A2522A7;
	Wed, 25 Feb 2026 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U57NtN2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BE21D596;
	Wed, 25 Feb 2026 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982860; cv=none; b=ralBOunDRW9pgwdbYTPQUAJPUvMW9C5+jpLsOMdgHW8ZiRR8r5sq0pW4ZkuIbyobLc5hSpnTmBbIx/Ta1iqy9bw3OSyhkYYytAmu6qZFuhHxkJ1rSIB52LgXrIXXxMdepUipaKVkquEenLNx2OiEUtPgu9Y4PB5yMHhyHN4Pdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982860; c=relaxed/simple;
	bh=fEhckbrIp1xiFp7nNdR1TzrCWWep88Lf+1ab/Iu9RII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgVql9YeBzqndMnMmooGcmHvFkjQ04Bz/j2fho2yrBjpZ04dEZCM4SOBQTONTGVAf7MJMSbdb5kjrsK4NTgKNGXk5xZfysTajxfd/CmovJCJ8XAHRv6BmFE3X4oCrftAx1mjkI95baZ1sjyoS/5pdUfAMABphP7n7Nv1zFjZstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U57NtN2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EBAC116D0;
	Wed, 25 Feb 2026 01:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982860;
	bh=fEhckbrIp1xiFp7nNdR1TzrCWWep88Lf+1ab/Iu9RII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U57NtN2WRPjn9/Bo9tx0tnbeuG5xGA5CVpYQw2H1fFwbWDrWw4b+Kt550ZNTPF4e8
	 6U29XYvodTPBCjyYAjSwx0w0hx0rr320bEbkWzDdXBjjlBinfdwTvTWI/G0eKE9ddu
	 UhfpEVmv8XbHfIH68BBPawOIMX/iFLDNNNLVc0Qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 047/781] md/raid10: fix any_working flag handling in raid10_sync_request
Date: Tue, 24 Feb 2026 17:12:36 -0800
Message-ID: <20260225012400.858957687@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218086-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BA54F18EC2A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Nan <linan122@huawei.com>

[ Upstream commit 99582edb3f62e8ee6c34512021368f53f9b091f2 ]

In raid10_sync_request(), 'any_working' indicates if any IO will
be submitted. When there's only one In_sync disk with badblocks,
'any_working' might be set to 1 but no IO is submitted. Fix it by
setting 'any_working' after badblock checks.

Link: https://lore.kernel.org/linux-raid/20260105110300.1442509-11-linan666@huaweicloud.com
Fixes: e875ecea266a ("md/raid10 record bad blocks as needed during recovery.")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 84be4cc7e8739..3a591e60a1449 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3402,7 +3402,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				    !test_bit(In_sync, &rdev->flags))
 					continue;
 				/* This is where we read from */
-				any_working = 1;
 				sector = r10_bio->devs[j].addr;
 
 				if (is_badblock(rdev, sector, max_sync,
@@ -3417,6 +3416,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 						continue;
 					}
 				}
+				any_working = 1;
 				bio = r10_bio->devs[0].bio;
 				bio->bi_next = biolist;
 				biolist = bio;
-- 
2.51.0




