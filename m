Return-Path: <stable+bounces-223223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHU0CnWeqWnGAwEAu9opvQ
	(envelope-from <stable+bounces-223223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:17:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA321450F
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AA183004F32
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210153BED5A;
	Thu,  5 Mar 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C56pSXDi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810B3BED36;
	Thu,  5 Mar 2026 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723587; cv=none; b=Ck8yWZC2hoM8x29Wsr2+hanjjahZehMwGjMJd3h6p4RstTBrMa924bi/ezQRHbStzYw1K9HUAbo796UKcKQ1HBXzT6w8TIR8GklL2oojotVesGVtDuUgEqgTIx3yLlBdt+A33wZ3Xg4eH5zKZcI77nPhS1Hs19Z+utsg5eydUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723587; c=relaxed/simple;
	bh=GmIDgFVHe8JF0vl+VygOfi4IcAnTQNNndatSOdAQlsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq3ZAw+XQ7aqL9PcHG65S0i4+CAynJk21ajPRhhRllJ1EDy+RIeqJ/Ao2mx10kJNJedOqMSgTC9Yod0d3cTKsGc/LX3ZKUl9K8E5U1t9X1bVuYP5cq+7oWD9hzBp0G7GJPsjvBOfMevlcB9GW7W8SZn3QcLZMmJY2gQZqZrulSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C56pSXDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB77AC2BC87;
	Thu,  5 Mar 2026 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772723586;
	bh=GmIDgFVHe8JF0vl+VygOfi4IcAnTQNNndatSOdAQlsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C56pSXDiI2dDFUpAc5rFH5LhBs1WAG/8+acb4iKiUcxeijSLTthciL2lYHfFmbRmV
	 WE5brQGmcG6igvZGw9u/DwqnQMqURlnb3CemS6C3e11rRTeRhvFFAn5yvrG/+mn+mP
	 rADmAo8MSHAyfgoSdXPhhvuafe3w6tp1BWfMix24AkoNU52gUTud2fApRyMQwX87Je
	 uUoObexM5z+eTNgOLCW9seDykatdRT9GNdeGYFOFrcpAFuopmh15DPevpKpPXaHkzy
	 e85O075M38lXvE+pT6iK47iUxvR8TSya1AboSJnGEQ4BCvL76o7KSoiHMo5HzRaJq+
	 6kXTOQMzx4ElQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 6.1.166
Date: Thu,  5 Mar 2026 10:13:03 -0500
Message-ID: <20260305151303.676629-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305151303.676629-1-sashal@kernel.org>
References: <20260305151303.676629-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3CA321450F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223223-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index ab1cb6f2e6ee2..5c06e9d3dfd37 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 165
+SUBLEVEL = 166
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 38f48875df91a..18a034613d94d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -377,15 +377,9 @@ int __init ima_free_kexec_buffer(void)
 
 int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
-	int ret;
-
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
-	ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
-	if (ret)
-		return ret;
-
 	*addr = __va(ima_kexec_buffer_phys);
 	*size = ima_kexec_buffer_size;
 

