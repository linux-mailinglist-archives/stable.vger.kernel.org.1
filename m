Return-Path: <stable+bounces-266203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Da2VFFeZMWp5nwUAu9opvQ
	(envelope-from <stable+bounces-266203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:43:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19AD694623
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:43:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="D/qOgyvI";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266203-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266203-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5412431E313C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5653DF007;
	Tue, 16 Jun 2026 18:39:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFF47A0CD;
	Tue, 16 Jun 2026 18:39:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635194; cv=none; b=AYncebAN+A4/6a+lonAb8YbpWK0XPsUc94ItScnNnHqlMbaLciDJAZSWyFuPtpQXgj0nUPidMX63irOeuYvFKSJoJCzvJ3fbS//jBGUe3HlNcndeuVrKatyztDUawaWWpCCX0iRwq6ZFVPanrf1crcYGNSa7zNIe4D8f8eVHKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635194; c=relaxed/simple;
	bh=vs/3WnXGnLOAlAt8iHu3CigoSdX2N5HINoRk9W0hLok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlPxMykd95PGWLZy7mRfu5ESec60rbOhbUAP9BnClXI29CKPNXykMU8ywVLkdn8Me5/3t1W+aUEICYOmXjSbAYAXSm310ux7yfmnm4h6x5XjQiA+atg59wOIAt2ASBTBug2y7P+1ltunbarlaqk0J/jfuDm6comIFuh48mgfiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D/qOgyvI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7061F000E9;
	Tue, 16 Jun 2026 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635193;
	bh=80662teBGgGrb/ADAN4aBxDjh+xjVoN3e2nW+EOJtXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D/qOgyvIOaNn/yID5ucOHzG9s4+NjKlBQckggYDHzdrR8ItsxgrtkT7iCZnlBSyyN
	 i4ZkD91LkD8m1kiekB2Cm0Ef8zl2wnmakWtbLxqO4BKh6KffoOtH12CsCVemMBH6dq
	 AxJekxCkk8ZTQQIObdWpAu0ck6TeQUrIFX/1E9uM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Hutchings <benh@debian.org>
Subject: [PATCH 5.15 409/411] fbdev: vt8500lcdfb: Fix dma_free_coherent() cpu_addr parameter
Date: Tue, 16 Jun 2026 20:30:47 +0530
Message-ID: <20260616145122.874481937@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266203-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:benh@debian.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E19AD694623

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <benh@debian.org>

Before commit 63a11adaceb8 "fbdev/vt8500lcdfb: Initialize fb_ops with
fbdev macros", the virtual address of the screen buffer was stored in
the fb_info::screen_base field and not fb_info::screen_buffer.  The
backport of commit 88b3b9924337 ("fbdev: vt8500lcdfb: fix missing
dma_free_coherent()") did not take that into account.

Change the cpu_addr parameter to dma_free_coherent() accordingly.

Fixes: 9c3873cccb3f ("fbdev: vt8500lcdfb: fix missing dma_free_coherent()")
Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/vt8500lcdfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -434,7 +434,7 @@ failed_free_palette:
 			  fbi->palette_cpu, fbi->palette_phys);
 failed_free_mem_virt:
 	dma_free_coherent(&pdev->dev, fbi->fb.fix.smem_len,
-			  fbi->fb.screen_buffer, fbi->fb.fix.smem_start);
+			  fbi->fb.screen_base, fbi->fb.fix.smem_start);
 failed_free_io:
 	iounmap(fbi->regbase);
 failed_free_res:



