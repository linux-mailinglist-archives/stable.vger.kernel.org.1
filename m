Return-Path: <stable+bounces-220676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAkbJqFSo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:40:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB221C87B8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAAD33316A5F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766BE3F5A70;
	Sat, 28 Feb 2026 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVSblbch"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612F3F5A60;
	Sat, 28 Feb 2026 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300558; cv=none; b=u6TO8/iXQieOH6U2ykU9eT/4/zOILOdMItsvFZhi0sT/XHaNGvpyReG6xKDmuOMcEevtk0wdtCvDZbfQoY5AZ263w15btjlIf33KXaCTD/X3Fy3ck6jLlnilSfj7OvtA7nbvCpxEVBKV0lKjHrTzNXjACc0Ol8Hfp3QodLPgtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300558; c=relaxed/simple;
	bh=c3A55tmRUKNtJtG/xnSgd+ZJdr/KmsWNCeJ7nVrLmXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4VdygKSFukydq0dyq8cgKrKZAHm+Q7FF6Fr/z8VhvshX1C7UlKOxPK8NMRivgKrD4k6xjJIaDaWnI3J571jbqsM+HZeoO/+IWu1GqXbJlDke0idQ5bXYBG7VM8uhu39laF6TbLYa0gIuFy4nkNLX8qs3kD21acz5HFpFzsEVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVSblbch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8CDC19425;
	Sat, 28 Feb 2026 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300558;
	bh=c3A55tmRUKNtJtG/xnSgd+ZJdr/KmsWNCeJ7nVrLmXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVSblbchXC2wUkVNn5CXPAxmHwfJb3gYFdTVHviFxG2G5o3LMOdiHOGHOkKA6u1dc
	 FmEL/CVjGvp9OEprLHI6BMoK1Ogq8OKfdfi/5i3U51RiOI8RswXaM+4ew8f4JIXywc
	 lTc6+OQ8ef1O1wgc0jifyRFyHXkmOyT2ggDEFHcR5lESrsZGkTYBU9E3MNVQY2zulz
	 D3a7pgwRVwgN9DdckXS3eobfkgWmY7qKLQeInZ53Rsd63Gi03eQWfj4EFUT5sHwcAJ
	 vkR7Xm0/nkctUFTpn7M/ze6BV77aA79XreB1z374gnfuXZDsDwHeHu3FGuTwrkUcii
	 P2AEnM4cI+v6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bingbu Cao <bingbu.cao@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 597/844] media: staging/ipu7: Fix the loop bound in l2 table alloc
Date: Sat, 28 Feb 2026 12:28:30 -0500
Message-ID: <20260228173244.1509663-598-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220676-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCB221C87B8
X-Rspamd-Action: no action

From: Bingbu Cao <bingbu.cao@intel.com>

[ Upstream commit 98cc19a353abc8b48b7d58fd7a455e09e7c3aba3 ]

This patch fixes the incorrect loop bound in alloc_l2_pt(). When
initializing L2 page table entries, the loop was incorrectly using
ISP_L1PT_PTES instead of ISP_L2PT_PTES though the ISP_L1PT_PTES is
equal to ISP_L2PT_PTES.

Fixes: 71d81c25683a ("media: staging/ipu7: add IPU7 DMA APIs and MMU mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/ipu7/ipu7-mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu7/ipu7-mmu.c b/drivers/staging/media/ipu7/ipu7-mmu.c
index ded1986eb8ba3..ea35cce4830ad 100644
--- a/drivers/staging/media/ipu7/ipu7-mmu.c
+++ b/drivers/staging/media/ipu7/ipu7-mmu.c
@@ -231,7 +231,7 @@ static u32 *alloc_l2_pt(struct ipu7_mmu_info *mmu_info)
 
 	dev_dbg(mmu_info->dev, "alloc_l2: get_zeroed_page() = %p\n", pt);
 
-	for (i = 0; i < ISP_L1PT_PTES; i++)
+	for (i = 0; i < ISP_L2PT_PTES; i++)
 		pt[i] = mmu_info->dummy_page_pteval;
 
 	return pt;
-- 
2.51.0


