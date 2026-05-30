Return-Path: <stable+bounces-259255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFyUM/kxG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB38612B1F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2315E303AB6F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFA1D63E4;
	Sat, 30 May 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k2hnA+HT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428D238D52;
	Sat, 30 May 2026 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167128; cv=none; b=SKGsx2j2wo5o60il+TNyUgnoDhotBqPQgW3Mnxdw/xESE1sVPyLW9E8tfeuk4aRg57glos5GS9OeiMW5hSOFmhUtUyEBv9X9rACzZrlBgvIaj8P4PSpDrIvVcGKZI2DZeCe7JL+dCNMwfLh/zWVZjcvYzQyHPNQb2uNUldOTjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167128; c=relaxed/simple;
	bh=ZwiXyHMMXayKq7qjQQ738qHKcl9++EacUdK6p9MUGaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0RpeSxcdhowDvrr60wBQKCJi/2gKCra8OxgzERWVzahuWb64i/t57ld93zqFRFjo3SxvSeq2Ty5HRsdx7kW8iH+B9Owktdff7tV27mSgRkkRKiGn70x5DCFA3jI+tADLCcEgsSO2XXmfchkzozw2Z7p119L394wGaYm2NggeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k2hnA+HT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DF01F00893;
	Sat, 30 May 2026 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167127;
	bh=AggY5FCkA+oFkY/w7DUSMvbjiguTOKRxud9qlN8LjVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k2hnA+HT6gSVWSBKefX3nCBnXf+oguPiOdm0IFaBaoqCdlOK1h6Zqjiytn9J0PLKc
	 wKw9ZcIZq2MBqgfuFQ4C05t8sSyGHVxE0tZvsaenU6aMQcucf+bW3BLByTIJ4BzumE
	 yMMKeB4/Jbq347ZmplTLyx1VlPLKOTo7ziEDDAtk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Gow <david@davidgow.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 570/589] kunit: config: KUNIT_DEBUGFS should depend on DEBUG_FS
Date: Sat, 30 May 2026 18:07:31 +0200
Message-ID: <20260530160239.603172659@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259255-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,davidgow.net:email]
X-Rspamd-Queue-Id: BCB38612B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Gow <david@davidgow.net>

[ Upstream commit 8f80b5b227ef9ea422080487715c841856339aed ]

CONFIG_KUNIT_DEBUGFS is totally useless without debugfs, so it should
depend on CONFIG_DEBUG_FS.

Link: https://lore.kernel.org/r/20260425034155.53913-2-david@davidgow.net
Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
Signed-off-by: David Gow <david@davidgow.net>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 9eb78ea5e90fc..48d4a2d95fd80 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -16,6 +16,7 @@ if KUNIT
 
 config KUNIT_DEBUGFS
 	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
+	depends on DEBUG_FS
 	default y
 	help
 	  Enable debugfs representation for kunit.  Currently this consists
-- 
2.53.0




