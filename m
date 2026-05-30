Return-Path: <stable+bounces-258433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKmgLjcpG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2686115A8
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8162314E7EA
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECF43AFCE3;
	Sat, 30 May 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8GudS0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4D341AC7;
	Sat, 30 May 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164334; cv=none; b=CTqRnLOgqrzoYpq5eU7k8wdOdaWEZ5b2CI3x/SX2qKp8srCZuWAcuq1D/e8XQKRqhcu2EvTgKMF/ZNEZVm2k3OWQj/pjrhbSUoZYhllntk4qYU/nFlf+s5+8AZ+JOql7iVMW0ojNhJ/fpZVYuauOYlKKic4fkDmru1joeSYW3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164334; c=relaxed/simple;
	bh=kACNz/s3caXLNysk2L7+KwDWaJ2DEyG8PZkPOgEF/Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxZrmO3iCOWq7R1TQPdxamYsTvyIxLm7ZDIGEHGlBygdqzuMIwWn4XJe+8aK2TqyZZ1FAkL9SxXcttmdA3XNgJlAw27BC4HoJ9rK8qIw8yxWAN0hjwZno/aGnKL3PO3J6SWxo9fmsMB390KcgxfKzdgi/jJ8+NYDmzXR6MNnufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8GudS0A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016C61F00893;
	Sat, 30 May 2026 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164333;
	bh=6zS2+Neu25QLsRM0HvB/mCRqGw15bloaZ0Xc8QfBVF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R8GudS0AAXc0EWI3oOgYUcEbcu0BkEF0FXDzGB05g+yW6/aen/JrOnpX1kxPJCT6I
	 nfzsQw+eYksA2u1YAFQUKTAkiR5RbQNgMCqaOR+THhf/3o1ClDT4UfnKWIluDfNcKd
	 5D1jSVdTEh2dMU/OWWlOMJjP6bJHtnMmKGjWfwCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 522/776] dev_printk: add new dev_err_probe() helpers
Date: Sat, 30 May 2026 18:03:56 +0200
Message-ID: <20260530160253.721143951@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-258433-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,huawei.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,analog.com:email]
X-Rspamd-Queue-Id: 2D2686115A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit dbbe7eaf0e4795bf003ac06872aaf52b6b6b1310 ]

This is similar to dev_err_probe() but for cases where an ERR_PTR() or
ERR_CAST() is to be returned simplifying patterns like:

	dev_err_probe(dev, ret, ...);
	return ERR_PTR(ret)
or
	dev_err_probe(dev, PTR_ERR(ptr), ...);
	return ERR_CAST(ptr)

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240606-dev-add_dev_errp_probe-v3-1-51bb229edd79@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 797cc011ae02 ("backlight: sky81452-backlight: Check return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/dev_printk.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index ae80a303c216b..ca32b5bb28eb5 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -277,4 +277,12 @@ do {									\
 
 __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
+/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
+#define dev_err_ptr_probe(dev, ___err, fmt, ...) \
+	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__))
+
+/* Simple helper for dev_err_probe() when ERR_CAST() is to be returned. */
+#define dev_err_cast_probe(dev, ___err_ptr, fmt, ...) \
+	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt, ##__VA_ARGS__))
+
 #endif /* _DEVICE_PRINTK_H_ */
-- 
2.53.0




