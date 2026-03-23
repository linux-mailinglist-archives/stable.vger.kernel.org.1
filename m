Return-Path: <stable+bounces-229779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N57JcVuwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:48:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B8B2F8D31
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 728A130B0A3F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A053038B7C4;
	Mon, 23 Mar 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/d+6gNL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4B3B388C;
	Mon, 23 Mar 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282842; cv=none; b=OMbCb7qFMY3KvYdlpEnlm8fzFsZ0QP0m3uuSOV5pamK7dfQIgnCtVgWC+ESBa+MPhIZ8G+Dql9y+1OU34lBt1FTdJCvAwwT1TrIN4R8fDQlUO4ZV/+kpXHVeGPD1bDCxZnnuP/aI+Hg01Mqsa3oyoFyzab1PVWOiX6dUK9irEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282842; c=relaxed/simple;
	bh=ragAFEnDl7G/FX6nRDDEAdOq3ssgAbiCkhL9orLWq+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ74k7y7QYe/I0hlG6C3io1dxuLT4HDwVElV85/UacA6eOxbjBnokigVksVfOV5EatOqYMWPzEnT2aDnPVvC2XrVemL2lvd1AWRNmq4s3u/OrlD4X4Ik/GHRU7Pfz8QuZsgE2ahjy0eWDKX4uHA6boRFa41/qemKjfTqnYo8+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/d+6gNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C2FC4CEF7;
	Mon, 23 Mar 2026 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282842;
	bh=ragAFEnDl7G/FX6nRDDEAdOq3ssgAbiCkhL9orLWq+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/d+6gNLT/fHSkYPVBum4kqou209A4Q4kIpfXIJKLz80s7CZml1e39iOH2sa1yEqf
	 kXUo4yv7vtuCkIgVZ1uBe/rVY6QpHEPMykghVA7lJN9rJFKVCjHx0Frf1ylIjHf8Az
	 vbwIEebNvbjmvfj6xRUjiolMPdliu5Bij5YZBjX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 306/481] drm/amdgpu/mmhub3.0.2: add bounds checking for cid
Date: Mon, 23 Mar 2026 14:44:48 +0100
Message-ID: <20260323134532.566843197@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229779-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 70B8B2F8D31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit e5e6d67b1ce9764e67aef2d0eef9911af53ad99a upstream.

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1441f52c7f6ae6553664aa9e3e4562f6fc2fe8ea)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -108,7 +108,8 @@ mmhub_v3_0_2_print_l2_protection_fault_s
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 
-	mmhub_cid = mmhub_client_ids_v3_0_2[cid][rw];
+	mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_0_2) ?
+		mmhub_client_ids_v3_0_2[cid][rw] : NULL;
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",



