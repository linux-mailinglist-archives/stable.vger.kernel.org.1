Return-Path: <stable+bounces-242460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJQmLcTN9GkAFQIAu9opvQ
	(envelope-from <stable+bounces-242460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 17:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CB4ADD25
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 628BF306D564
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239D3D3CE7;
	Fri,  1 May 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqUOE480"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273C3D7D89
	for <stable@vger.kernel.org>; Fri,  1 May 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650883; cv=none; b=YDnYbLaT6oiYsnMzQEqnHyen7W22XsKGLm6mnUT3k1ZghW+D1PhKYkYOK1Vvy76QEPNMTe7XfY0SU8lljShgPiNcQq9blKZ7Kez/CLa2o7MNsriu7F8Nx5soyDaYVhA/sWGV7IF68Dl+LTXT429o/rU/Fgd6QRh4zeknv9N5Xfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650883; c=relaxed/simple;
	bh=DVGW2UNGOpwz82WdUc3xD2/JoCiLHg4vwAkH/Mxc9c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsjNMPVlNYrWDvNz/oDl3+vqnkhUvSKr+6MWACiz1ejwdwDJldXGHHqt2QXsA+8Ys3UEUEfRpOL9sHBRpHnx6lJgwKvts0Ecc9x4T2H/ad4D4vGp09iJEJnwMEFgCUkdH6ZAuUCyAbZIsmEkTXQVbYfrEEaiWYHwinTuic+3g1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqUOE480; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D87C2BCFA;
	Fri,  1 May 2026 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777650882;
	bh=DVGW2UNGOpwz82WdUc3xD2/JoCiLHg4vwAkH/Mxc9c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqUOE480ymmjsCMl0ozUDQurlAlw7m822vb+FptZbEH+LF6fp8wHi2O+z+aEuQ+w/
	 0c3fes2BLSCwp1SXaV0h1NBhDsWEdY8vo1Nfz4MGL4VNI6uIigFSmz1Osh2VgU44YL
	 IUlBAmtkce43sgjsocwRsCAnpyzpHAneKUS3melXO5BV+yCLStQcQbQGXFUR4oQIX5
	 nqzO6nxbuv65TrE/+NMvrg44jK0hRcx3WXwLIUdIDIlwFap+heFQb1ao0VvlFhNIo5
	 icMl2U405Paacx7L2jWObwFD643Qn39sWk4LwzooS0gC3HSUYcbQaNSc2wKQVUGcxS
	 5iKkSvQTu8rmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/zsmalloc: copy KMSAN metadata in zs_page_migrate()
Date: Fri,  1 May 2026 11:54:40 -0400
Message-ID: <20260501155440.3611449-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050105-tremor-wispy-7169@gregkh>
References: <2026050105-tremor-wispy-7169@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E4CB4ADD25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242460-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 4fb61d95ad21c3b6f1c09f357ff49d70abb0535e ]

zs_page_migrate() uses copy_page() to copy the contents of a zspage page
during migration.  However, copy_page() is not instrumented by KMSAN, so
the shadow and origin metadata of the destination page are not updated.

As a result, subsequent accesses to the migrated page are reported as
use-after-free by KMSAN, despite the data being correctly copied.

Add a kmsan_copy_page_meta() call after copy_page() to propagate the KMSAN
metadata to the new page, matching what copy_highpage() does internally.

Link: https://lkml.kernel.org/r/20260321132912.93434-1-syoshida@redhat.com
Fixes: afb2d666d025 ("zsmalloc: use copy_page for full page copy")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ translated zpdesc_page(newzpdesc/zpdesc) arguments to newpage/page ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e4326af00e5eb..76adbce8d42b9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1808,6 +1808,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	d_addr = kmap_atomic(newpage);
 	copy_page(d_addr, s_addr);
+	kmsan_copy_page_meta(newpage, page);
 	kunmap_atomic(d_addr);
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
-- 
2.53.0


