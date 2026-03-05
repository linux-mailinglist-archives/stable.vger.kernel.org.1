Return-Path: <stable+bounces-223219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLEnKOueqWnGAwEAu9opvQ
	(envelope-from <stable+bounces-223219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:19:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5BC2145A9
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3052D30F5245
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3D3BED09;
	Thu,  5 Mar 2026 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1INc2iX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131113BE176;
	Thu,  5 Mar 2026 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723432; cv=none; b=H1WXAder7JzFZwpjaQUWjXjSJdKv+2h+SQMn9dqfMlLLCmYiTYA2ywJxGQ36KGOj6MzlsKtFtXHEtR56hiDja4xbsLgqfzYfrWbRkHkI5h5HMcObER5xcS95l/ztJ8w1dld9Lzidel5xlyLEc065qQKTh7179yqv3TYsPazex3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723432; c=relaxed/simple;
	bh=zOPl5w1pLlNo5D4qHH7xKTMpb3uBMpqlHPONE5HM9yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJcc1BhiC7RgJTLoVDliBU23a+mN0N1YkP8/oE5123/+bqgvCtbJCpkKQ09qs6j/K3igcGz49J1Anpthx9Gy5lEqMGqc6MgxTumsKTWi7AfHxMU4GSS/Vuma75bZKrdASXQE8B0C/e1FOUt0jlk3fYl0HbKMMEhcosR3KxAOw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1INc2iX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27392C2BCB0;
	Thu,  5 Mar 2026 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772723431;
	bh=zOPl5w1pLlNo5D4qHH7xKTMpb3uBMpqlHPONE5HM9yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1INc2iXfRB8QU+g7HhfY+xYdC819+gDbLoYOUiDGc+Lkg3QaSPIleTyI9ZYE98nR
	 Az0bvns+644WM43ouU5PMjOjYAMprmQp6eEq2XxeXGOkQNMn7sL3/+IBJRU2jolqG3
	 6a31QHUBV7mbzTZyMU/gPsqatm9AhZbmI0fQby6SV8GHegwfQDgggTuTdR8qerGC7i
	 n0mNoC7i1TMqLyeiA4Lmdm8f+8EIqRJmihjwqckPRg+ES2LxpJT6hepDcSR1DLuyTW
	 9DH5LUUCob2EtRrd9uG0oMEFP0CkXdDivHSiFakBndDRqWGn74XxN1yEyMhY1kgnbT
	 2WI8TMi4V4JIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 6.12.76
Date: Thu,  5 Mar 2026 10:10:28 -0500
Message-ID: <20260305151028.671440-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305151028.671440-1-sashal@kernel.org>
References: <20260305151028.671440-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B5BC2145A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223219-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 882a4dd080e67..ae059d1885110 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 75
+SUBLEVEL = 76
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 234c4d9e50b8f..f1fea506e20f4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -372,15 +372,9 @@ int __init ima_free_kexec_buffer(void)
 
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
 

