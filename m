Return-Path: <stable+bounces-228297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAeXCk9LwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:16:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A470C2F4126
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 435BC317F980
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDD93AF67D;
	Mon, 23 Mar 2026 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLVOzNKw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37B3AE1A8;
	Mon, 23 Mar 2026 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274727; cv=none; b=Vm6wTpdGgsv289y2bFAfykZLd9KOTDFWsQLzXooRQcIxhu58MfE4Zxz8knFPMYbjfO6E9oF5Jyciyw3ItcAejTXNN9HtJYOr1SFr9yv5naJZxUIk33VMnGm/WjZr7eT1lQjPeDrwTRU+HbXoSbLWR/tI4t/Ff4V2dU/deOPySSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274727; c=relaxed/simple;
	bh=Y4C4tPZWzq8+CMfOuvnnko7yCM8gGAk8Kyv0Cim0Rg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oC39wwy9vimMo/suTP6AaZQrzRFJrJFfjShtifFvEcvjJuOX4ot4YixuqXaGs9qkdWo2KdK40O0/UqR4d/RRbMM5EVZWDdR6DtJpAdTspsthrr9jh5lR1jMuW091m8UYgoG87YHDbakoSc2yRnZv7C9c6xj8px9bUfJt3ydVemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLVOzNKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE976C4CEF7;
	Mon, 23 Mar 2026 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274727;
	bh=Y4C4tPZWzq8+CMfOuvnnko7yCM8gGAk8Kyv0Cim0Rg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLVOzNKwnZ1Ir0tFCsRzdF2OuOFM0MdaTu9b7TU/6n5W/H7r6tcRmWJ87DJbQRfnv
	 ctMtYsQUNjVIzDydgL+q2J6vSyOtbL6dpBUTo9Ses0tODhtSUJfNVVPEAYwgrPJOaQ
	 +yCRe4ZUPzMPvF3o08KGqs20izUIu4PLIKg5nd1M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 090/212] drm/radeon: apply state adjust rules to some additional HAINAN vairants
Date: Mon, 23 Mar 2026 14:45:11 +0100
Message-ID: <20260323134506.622641343@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228297-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: A470C2F4126
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 86650ee2241ff84207eaa298ab318533f3c21a38 upstream.

They need a similar workaround.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 87327658c848f56eac166cb382b57b83bf06c5ac)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/si_dpm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2915,9 +2915,11 @@ static void si_apply_state_adjust_rules(
 	if (rdev->family == CHIP_HAINAN) {
 		if ((rdev->pdev->revision == 0x81) ||
 		    (rdev->pdev->revision == 0xC3) ||
+		    (rdev->pdev->device == 0x6660) ||
 		    (rdev->pdev->device == 0x6664) ||
 		    (rdev->pdev->device == 0x6665) ||
-		    (rdev->pdev->device == 0x6667)) {
+		    (rdev->pdev->device == 0x6667) ||
+		    (rdev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((rdev->pdev->revision == 0xC3) ||



