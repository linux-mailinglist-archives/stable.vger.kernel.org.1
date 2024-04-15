Return-Path: <stable+bounces-39497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC078A51DB
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DD1284CC9
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D89757FB;
	Mon, 15 Apr 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvkwA1bE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328F73500
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188299; cv=none; b=PpKmEvwpjkxQKnX+Ac7v9lufLXbv1kGtFNwyGg91hQQALrn1i/xqvzsspVXpJT371G/UR7bq6Sg4npgd1MRFDDyIyV2JOLgL2W1Ktf+SbimbG6OtzJ8I/IP3Gt/xEC0xwZ7s0IsCz9CNNvnOngBg8do6AD+XHWglaWaV2Rj/U+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188299; c=relaxed/simple;
	bh=lvCjzgnykqyNnw5Vrwmo08lX30HbVWMQg86MwppAylM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSGT09lovDQyqMnjxzTHsx/h8PorDYCWAIvDKk/paBljKrsoTNtayoTMGlpmIf9HYP9ePH2RfHynnctNo97tdimvkSG3sNk49N3UnYVUCq5ENK/VZ0r28RN4jHuKbG9xNQk0ruTEpPi6cGyO6AyZaqdNgla+TU75n+kB0qfkdSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvkwA1bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA3C113CC;
	Mon, 15 Apr 2024 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188299;
	bh=lvCjzgnykqyNnw5Vrwmo08lX30HbVWMQg86MwppAylM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvkwA1bE2x3jDXNNfuCGOPl1XXKgZjFhv6cJH8W3E7tVXbCbjKi3OZubmi9p3JECP
	 wfzEWQmTrerZN5uaXNmVypXHHhyrDoqU0HBK4BwApcDtRKFkvyX70EJn51hsMUCafv
	 dRPzByQW0/OaTYPnEyx96F949lJ024eL20D1b48HXiOKSN/daNrgXFx0pgZH9LfKPB
	 +2o3FLYJJb4BlpYFwgDwxUlZLAuQrP3UF723Rh3NoO8kTJB2aDP348v4aepH3/FCo/
	 N4/U/VuHVPvzR+tZCOQZAi0N2rnm+EWmvyiuIZYd2I/uWn5J2FXp8GwjUebv2u/bLy
	 pUjGAkHM+z7Jg==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Stable <stable@vger.kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 007/190] IMA: allow/fix UML builds
Date: Mon, 15 Apr 2024 06:48:57 -0400
Message-ID: <20240415105208.3137874-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 644f17412f5acf01a19af9d04a921937a2bc86c6 ]

UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
NO_IOMEM).

Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):

ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
ld: security/integrity/ima/ima_init.o: in function `ima_init':
ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'

Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
is set, regardless of the UML Kconfig setting.
This updates TCG_TPM from =m to =y and fixes the linker errors.

Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
Cc: Stable <stable@vger.kernel.org> # v5.14+
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 6a8f67714c831..a8bf67557eb54 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,7 +8,7 @@ config IMA
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
-- 
2.43.0


