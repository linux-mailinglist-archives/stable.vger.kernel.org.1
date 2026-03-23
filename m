Return-Path: <stable+bounces-229407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE07FcJhwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:52:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC562F70B0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCBBB340BC56
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449353BADA2;
	Mon, 23 Mar 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lVzde7TN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B03B389F;
	Mon, 23 Mar 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279150; cv=none; b=LQ8sUkczOUnMYKD7ZJmkGDkzW5uE10ZfGkUfOSf1f+feGCKJfra6Z0uEgUP+IcC9Ps5jJal/fPv3HS6LdfeB8XwbYVEZs86sKPmZ+xelhACqUAJn5ZuXv4BaVR1Az1xjZAa3a6oqkmH3GAUstDhNg7+veQBfqWac7OFPVZLnnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279150; c=relaxed/simple;
	bh=qqL0zhly+FuiyFyEetMioI9dR1bobeIhiDAKXWobwa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8vYgQnGFiVuCqbp5rdc6/nemaMvSezjMKRkm+3dAgj2WEq+wOAElxlbttVgWLwthd6wOO4iiP6olu/vLN99WHn53PhEgPyjXzE1PFU9khktT2QzH402asKhY04e2a141sRHT87V/4CAqExX0C9JHZjVpLvTbdURp/8U0atYi2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lVzde7TN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4768AC4CEF7;
	Mon, 23 Mar 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279149;
	bh=qqL0zhly+FuiyFyEetMioI9dR1bobeIhiDAKXWobwa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVzde7TNihUZml2+0u78ZcnFOYAKQkjET799k3vGd6M822W31gyXawsegR06DBMKZ
	 jeAiiCq0N1zW4tJBOw10tGnNAd7i1YEHQt+ONVfwja7YHcYzj5Q3nZk4kXBpjT7GXI
	 pOuOWDAPm7BoraQoH5ciSZ7sw5abn7esfA0OCnIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 491/567] drm/amdgpu/mmhub3.0.2: add bounds checking for cid
Date: Mon, 23 Mar 2026 14:46:51 +0100
Message-ID: <20260323134546.129616706@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229407-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,amd.com:email]
X-Rspamd-Queue-Id: AAC562F70B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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



