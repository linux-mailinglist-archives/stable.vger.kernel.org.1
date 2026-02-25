Return-Path: <stable+bounces-218883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG7uBUVWnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:54:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67980190222
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2E432C8875
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30B291C10;
	Wed, 25 Feb 2026 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jo+SrJXN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D728D8DF;
	Wed, 25 Feb 2026 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983770; cv=none; b=DTNrBNB/yTmrqWJaLDWAZMF0APVR3Jf0sjaC7JiDdOVbgxBaYQmc7fye5ZDzKp8CrEv8gLk2FOo/PrRfpmhL76NuuyPOW/S6DjGxgvzLAa5QggN3nz1Oj2aWTeqDWBfRRuPvKLmD+L+UwfLabeeHk2qOi3qxAHFtTTmO7nLVEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983770; c=relaxed/simple;
	bh=hQZybT4PwKtWeHTZ53jjF6ZoqC9NS3IXde3Ih/5rucs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSI2t7tva3V6U97cQpUt8l92ks9qCgWBr6w8MIQ8GZ/fz4nV7xZ8GJvv2bDBlbscl3qvWVp7iK4WXhyBVg0GxYf3N5u6LCGpTVigbmnzkeOnKKhyzhiIYkRtUwvgolsao3Ba5umheIyHBPufg5whupJnNqLdIQDT+BGpNdmz/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jo+SrJXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84732C116D0;
	Wed, 25 Feb 2026 01:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983770;
	bh=hQZybT4PwKtWeHTZ53jjF6ZoqC9NS3IXde3Ih/5rucs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jo+SrJXNgXbKG9KU3gc+mg8ZBJlXkS+J9bU7A3g4GGCvXYSt1p1X+viGK6YgX1e0s
	 8m/LGur5D8atfxlQVdZ8g5M/YTZQJ7Go3EQj2+LLuFKJDNA4iZZ1OugfJFvMIKceCw
	 6VadZYCz+ygMCqmk+T0Y9YnsMbIGMVaYrhUvEDDw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salah Triki <salah.triki@gmail.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 061/641] s390/cio: Fix device lifecycle handling in css_alloc_subchannel()
Date: Tue, 24 Feb 2026 17:16:27 -0800
Message-ID: <20260225012350.529694407@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218883-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.ibm.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 67980190222
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Salah Triki <salah.triki@gmail.com>

[ Upstream commit f65c75b0b9b5a390bc3beadcde0a6fbc3ad118f7 ]

`css_alloc_subchannel()` calls `device_initialize()` before setting up
the DMA masks. If `dma_set_coherent_mask()` or `dma_set_mask()` fails,
the error path frees the subchannel structure directly, bypassing
the device model reference counting.

Once `device_initialize()` has been called, the embedded struct device
must be released via `put_device()`, allowing the release callback to
free the container structure.

Fix the error path by dropping the initial device reference with
`put_device()` instead of calling `kfree()` directly.

This ensures correct device lifetime handling and avoids potential
use-after-free or double-free issues.

Fixes: e5dcf0025d7af ("s390/css: move subchannel lock allocation")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/css.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index be78a57f9bfde..8a70596a55447 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -236,7 +236,7 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
 	return sch;
 
 err:
-	kfree(sch);
+	put_device(&sch->dev);
 	return ERR_PTR(ret);
 }
 
-- 
2.51.0




