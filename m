Return-Path: <stable+bounces-218744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHegCApVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BA118FEB7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5ADD31190F3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C692126B764;
	Wed, 25 Feb 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="poDqyujx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBA248881;
	Wed, 25 Feb 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983611; cv=none; b=Fy/lyxvlx9K6ssfX8Thxxi+g9Kz6SJU4a8mHpOr/yl6CG8cfcOOPAJS+fewI+Z7zjFO44BRcG5X8eYaAHjPytFXrKcXSnWDAH7YRsfOJyxqN6vi2WmSR+zqbDWKWgxMNSh3HM2bV5SfMlYcQMtB3rRZ4LL01rjsyMfIMNTqxwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983611; c=relaxed/simple;
	bh=Rk6/ez/L8oCsU7jYWhJuuXvpcpYf45bFdHqC2IMcEHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFGQHIBpuwmEAoaHibnccBAFKAvtabiZR5Pb4qt1QGnL4/IO4vpTko+82e2wWOenIfFpwwXGdbomJheNRI9pnEiHklj2SZZ6KjJD1ziI+tgbyuZaFmw0LqOGFk8x4tMDJfm9Y1zbjPcggoiLPoiiV961wKqamwCNIVSDt8Mp1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=poDqyujx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45111C19423;
	Wed, 25 Feb 2026 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983611;
	bh=Rk6/ez/L8oCsU7jYWhJuuXvpcpYf45bFdHqC2IMcEHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poDqyujxTtHVR5IJHAc4a7tEy3EqAuRZ6x3uOa0fxFYvO8aIj9cZGzL3XBqBITeZ7
	 fx3TDf7spw35BgqRbdE+sFFF5mZIFvp9hQl4YTs7feTj8vuUpzLX52zA+kvh56ag5n
	 zE9mSogxWJLbL5piuzs6BN/XPv+7jwDKcXhPTpqo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 706/781] drm/amdgpu: Fix memory leak in amdgpu_acpi_enumerate_xcc()
Date: Tue, 24 Feb 2026 17:23:35 -0800
Message-ID: <20260225012417.067197384@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218744-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,seu.edu.cn:email]
X-Rspamd-Queue-Id: 82BA118FEB7
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit c9be63d565789b56ca7b0197e2cb78a3671f95a8 ]

In amdgpu_acpi_enumerate_xcc(), if amdgpu_acpi_dev_init() returns -ENOMEM,
the function returns directly without releasing the allocated xcc_info,
resulting in a memory leak.

Fix this by ensuring that xcc_info is properly freed in the error paths.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d31460a9e9582..7c9d8a6d0bfdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1135,8 +1135,10 @@ static int amdgpu_acpi_enumerate_xcc(void)
 		if (!dev_info)
 			ret = amdgpu_acpi_dev_init(&dev_info, xcc_info, sbdf);
 
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM) {
+			kfree(xcc_info);
 			return ret;
+		}
 
 		if (!dev_info) {
 			kfree(xcc_info);
-- 
2.51.0




