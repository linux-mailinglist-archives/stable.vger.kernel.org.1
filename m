Return-Path: <stable+bounces-240863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DITDWR062kQNAAAu9opvQ
	(envelope-from <stable+bounces-240863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:47:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BEA45F9F6
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA80730B44AB
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE4C3D3D04;
	Fri, 24 Apr 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HzfDl73M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208F3290A5;
	Fri, 24 Apr 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038035; cv=none; b=dvtPq3fKKP1qeVHJa26S0OJsP9S1ed/9CiXtSudAgMBuRpSH0S4gBfTHBhNBfGSUdkwiqofsatcjiO7GGOaoIM0YO1VAaWabeOeC9fj2KTh13rP52WjNkhp3vUMS1crLeEYzSNWpNL4Aqleg17FibS47Yf2KPXk395jXXa/1coQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038035; c=relaxed/simple;
	bh=ndJsUsSwYirsRIkSg6jmyNl+aU4SoSI9NhQzmDo5GnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzuG2QdIUwT/Gt9BcHif5kJdAArBxl3pSYhCdcmRDp7DfD3IyfHR1JkfzIPYK/VB+A2R0KsTzpm3Kr8OaawXyxSXqnZe6th+TuLuNQT+FbnW3AFvgGEcy4M3rODKFTkhp4g1gfZcSo697hz44i2rkcXQtxa+EZWYE6t34+APv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HzfDl73M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1AEC19425;
	Fri, 24 Apr 2026 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038035;
	bh=ndJsUsSwYirsRIkSg6jmyNl+aU4SoSI9NhQzmDo5GnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzfDl73M3PSFf65Qz7efr2ycbDgMNC/cZudjwEpIZ+sX+dsRzrMYdJhZBgtHhIjtb
	 lluJKxu0XOG5fE7XA4JN1921Pc363PrNQ8pHfyzGPFNIrZNdNmDcNVN02VU7UkfRwP
	 oNKluT4+glaAJbVdo5QAn8eENHbggbxQZKyalRdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Li Nan <linan122@huawei.com>,
	Ian Dall <ian@beware.dropbear.id.au>
Subject: [PATCH 6.6 166/166] md/raid1: fix data lost for writemostly rdev
Date: Fri, 24 Apr 2026 15:31:20 +0200
Message-ID: <20260424132607.802962503@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A8BEA45F9F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240863-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,dropbear.id.au:email,huawei.com:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

commit 93dec51e716db88f32d770dc9ab268964fff320b upstream.

If writemostly is enabled, alloc_behind_master_bio() will allocate a new
bio for rdev, with bi_opf set to 0. Later, raid1_write_request() will
clone from this bio, hence bi_opf is still 0 for the cloned bio. Submit
this cloned bio will end up to be read, causing write data lost.

Fix this problem by inheriting bi_opf from original bio for
behind_mast_bio.

Fixes: e879a0d9cb08 ("md/raid1,raid10: don't ignore IO flags")
Reported-and-tested-by: Ian Dall <ian@beware.dropbear.id.au>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220507
Link: https://lore.kernel.org/linux-raid/20250903014140.3690499-1-yukuai1@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Li Nan <linan122@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1119,7 +1119,7 @@ static void alloc_behind_master_bio(stru
 	int i = 0;
 	struct bio *behind_bio = NULL;
 
-	behind_bio = bio_alloc_bioset(NULL, vcnt, 0, GFP_NOIO,
+	behind_bio = bio_alloc_bioset(NULL, vcnt, bio->bi_opf, GFP_NOIO,
 				      &r1_bio->mddev->bio_set);
 	if (!behind_bio)
 		return;



