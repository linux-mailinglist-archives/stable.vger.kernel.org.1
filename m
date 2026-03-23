Return-Path: <stable+bounces-229783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBBpHs9qwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-229783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA92F839B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83B9931715B1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCB3BD655;
	Mon, 23 Mar 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+xRAw4L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03593BD240;
	Mon, 23 Mar 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282853; cv=none; b=UZqg9zo0ZT/iz8E1VJaEr6/w1iq8dEbtkKBABZbP6GAXobvcqJmTLpF51k9bCV6oUjzF4mY4JML1q+vnovpxiMJfBCjE+/EjZZmZL1hepf3DknjxOgfndr97EC7Cau8/A7wOiIT5jb/Mig7Nx4JPJPW822WPs3WdmD0kIyCtEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282853; c=relaxed/simple;
	bh=a0WlojgjZjYdwZTEygtY3sOItUkuwFS2osDvmfcX+50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KltudXepKYEmhzyiYITB065eZx1NwPs7I5MZCN+kkNJA6quzfKzV0/ZsWt7lE32SAjsR0RvDpnGvzwevFcgprVIiRWmrqllalRkGGc5tAG7uxU/kl8CucILd4qmeofaEGO2QY3C2mY1wnUcPDqlqjnZC+vXfFJPo/IZLMF3UulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+xRAw4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD47C4CEF7;
	Mon, 23 Mar 2026 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282852;
	bh=a0WlojgjZjYdwZTEygtY3sOItUkuwFS2osDvmfcX+50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+xRAw4Lu755PjWNsdw9CAHB/BpJ9JoQBUh+PK1Nwq8VKup6OUtSZO2xGPweHDAIg
	 SOyGzlMMiUUnFK2doa8EZtnujRv/rvNb8QkOdPdfpF761CYeOBYAPG1+QJblx1bZ6Z
	 o4FGL22f1DNlAoHqq+55TCFDtKyef9xqEreNjkaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 309/481] drm/amdgpu: apply state adjust rules to some additional HAINAN vairants
Date: Mon, 23 Mar 2026 14:44:51 +0100
Message-ID: <20260323134532.637643194@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229783-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 19AA92F839B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 9787f7da186ee8143b7b6d914cfa0b6e7fee2648 upstream.

They need a similar workaround.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0de31d92a173d3d94f28051b0b80a6c98913aed4)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3439,9 +3439,11 @@ static void si_apply_state_adjust_rules(
 	if (adev->asic_type == CHIP_HAINAN) {
 		if ((adev->pdev->revision == 0x81) ||
 		    (adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6660) ||
 		    (adev->pdev->device == 0x6664) ||
 		    (adev->pdev->device == 0x6665) ||
-		    (adev->pdev->device == 0x6667)) {
+		    (adev->pdev->device == 0x6667) ||
+		    (adev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((adev->pdev->revision == 0xC3) ||



