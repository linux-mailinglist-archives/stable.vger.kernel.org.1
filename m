Return-Path: <stable+bounces-228081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AZTCOZHwWlGSAQAu9opvQ
	(envelope-from <stable+bounces-228081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:02:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F042F3ABF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5752230EA331
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C80366570;
	Mon, 23 Mar 2026 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q4WkVwBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4521D00A;
	Mon, 23 Mar 2026 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274069; cv=none; b=ZuaTRi0HgoONqLxsophyYIbJvcqwYuVerKehPkbWpJqZ927Qyt5zeoXLPCRT5ezT2NinNBqZBdbbBsE7n7kCUTvw73lXh0QUrhMfQ+1s4XiEg3efLwwLyx+O+uO4s9vTWwoMDmxbpZBJCR+ge1qTo0NuOiR27Tx51V3HQWHygHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274069; c=relaxed/simple;
	bh=5KwO3ETGFZOr8BQ+LMPlQFry08CzGa6iMLXGuEWTojY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjI029oniNoZXjWhm19GwurO+7PbnDOVBviCRUejSJ2wRuf4UTV2Pp4kEw7BNg0xjVz2P2z8oPoxNOhuT/GLeSzWCvI99GqXGGAKaQ5FZTM5RWD1sL0KBzxz+g7VaEy3hVNxouJAAtJsO1UDFXxB++Y85X+EHLmbURBmrjSf1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q4WkVwBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045FCC2BCB1;
	Mon, 23 Mar 2026 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274069;
	bh=5KwO3ETGFZOr8BQ+LMPlQFry08CzGa6iMLXGuEWTojY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4WkVwBYxluRUFoVY5EbzJB9GWsvWEHiQv4KizvebZjYFrfXqkThG5uaEYOblS/ou
	 Uwr5MVQWD8NfX9lJ1plXAoa59VxEnTFpZEK4g0mS76rtfCIf/Xb00XVSiCtWg3f496
	 FdqYswpCZKiRA/MpWTNMvfMSs7k2O170QG1fhye8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 099/220] cache: ax45mp: Fix device node reference leak in ax45mp_cache_init()
Date: Mon, 23 Mar 2026 14:44:36 +0100
Message-ID: <20260323134507.728840985@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,microchip.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228081-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[conor.dooley.microchip.com:query timed out];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9F042F3ABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 0528a348b04b327a4611e29589beb4c9ae81304a ]

In ax45mp_cache_init(), of_find_matching_node() returns a device node
with an incremented reference count that must be released with
of_node_put(). The current code fails to call of_node_put() which
causes a reference leak.

Use the __free(device_node) attribute to ensure automatic cleanup when
the variable goes out of scope.

Fixes: d34599bcd2e4 ("cache: Add L2 cache management for Andes AX45MP RISC-V core")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cache/ax45mp_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
index 1d7dd3d2c101c..934c5087ec2bd 100644
--- a/drivers/cache/ax45mp_cache.c
+++ b/drivers/cache/ax45mp_cache.c
@@ -178,11 +178,11 @@ static const struct of_device_id ax45mp_cache_ids[] = {
 
 static int __init ax45mp_cache_init(void)
 {
-	struct device_node *np;
 	struct resource res;
 	int ret;
 
-	np = of_find_matching_node(NULL, ax45mp_cache_ids);
+	struct device_node *np __free(device_node) =
+		of_find_matching_node(NULL, ax45mp_cache_ids);
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-- 
2.51.0




