Return-Path: <stable+bounces-218851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMzRDCRXnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:57:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DEF190496
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1FF4309C207
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C0271456;
	Wed, 25 Feb 2026 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KS4lA+8A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DE280CE5;
	Wed, 25 Feb 2026 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983735; cv=none; b=f2kWzyXFD7V63Iklkb2tH36hd/C6ewUCoUjL59Dba+iQCd2MD41WBqWtolWKXOtNre/yLI+7CtP9KetDJ2iXcbrZnQ2kIwchyKiE/yAUvNd+gD53Suu+tx5Fb++KDwyDpckUON9055XG1OhC809L1+QQ6mbfCPKmT7OHC+7uwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983735; c=relaxed/simple;
	bh=o14d0mNoLyfdtPY4Bc62M+pIcL9ykKgJbk0V4tda2Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1PBh+Ha13mOacvGS54pUhQhs6feWDQaYMpa5X59SopyM7oaRkop7aXPxnzvMgF+/N1iKGkfgKpJ1i5XfhMqy7wiJQRjhW5N3qAR8vCqmNsDcjN9hOHIA0kzNo7ANghPUSJJZIOkH1yFRuAhgopNe8atvWKJIr7QqL2BIi/nzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KS4lA+8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F35C19424;
	Wed, 25 Feb 2026 01:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983735;
	bh=o14d0mNoLyfdtPY4Bc62M+pIcL9ykKgJbk0V4tda2Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KS4lA+8AYpL7BWnUtTob0bzMaJ4VVsldYPqDrj8YqBl4FKIJoJCBRlEZwVdXDtzv/
	 st7HogMr19k17dsWsvxcGZQjmMLqIXK1GWqmBdioC95kwP7kaePWuRAwbP+wXJ8tRj
	 1u+W5aWUJk1QI4JapXy977qdaajdR760LymWxvNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 003/641] auxdisplay: arm-charlcd: fix release_mem_region() size
Date: Tue, 24 Feb 2026 17:15:29 -0800
Message-ID: <20260225012349.014959845@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218851-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux-m68k.org,linux.intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 84DEF190496
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit b5c23a4d291d2ac1dfdd574a68a3a68c8da3069e ]

It seems like, after the request_mem_region(), the corresponding
release_mem_region() must take the same size. This was done
in (now removed due to previous refactoring) charlcd_remove()
but not in the error path in charlcd_probe().

Fixes: ce8962455e90 ("ARM: 6214/2: driver for the character LCD found in ARM refdesigns")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/auxdisplay/arm-charlcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
index a7eae99a48f77..4e22882f57c9c 100644
--- a/drivers/auxdisplay/arm-charlcd.c
+++ b/drivers/auxdisplay/arm-charlcd.c
@@ -323,7 +323,7 @@ static int __init charlcd_probe(struct platform_device *pdev)
 out_no_irq:
 	iounmap(lcd->virtbase);
 out_no_memregion:
-	release_mem_region(lcd->phybase, SZ_4K);
+	release_mem_region(lcd->phybase, lcd->physize);
 out_no_resource:
 	kfree(lcd);
 	return ret;
-- 
2.51.0




