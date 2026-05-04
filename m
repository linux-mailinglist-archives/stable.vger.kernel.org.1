Return-Path: <stable+bounces-243631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BCCM3au+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:34:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B04BFB68
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BBA307452F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B73DE450;
	Mon,  4 May 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUtLdrOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2229E116;
	Mon,  4 May 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904380; cv=none; b=YZHi1Q+bHNj5roa/H1S/tW/jouesUqbVN6kDgSUMT8rK/59L8PoGTT5RA+UXl2GO9UmYIe05Qa/pLEV2QvCF3ebCXlvXhd04sW48GJB3cIN8AWiGc+geZbpO2+EwQ/z7inPzPToohElq4E/JnBqZFD7MyoKwOfi6H++zu8z2zkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904380; c=relaxed/simple;
	bh=sOg49B/qV3F7338ltwLt/DhEwlJ5r2TYbQtkP34wJT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFSgaqNDWPzvqf6aRlz3lwHQiWbjG8yyYpbQEG4kyD+Jaf35RykWC/mWlyp3zC2iZxZiUYgKYz1qbBimNKFPtARhouCcRSV1UuAocxjl7L6lFs5TsJLZjm+C/zI2bbf/X+RKwRdVVswfYG3YQQ41YKo9IUG+4rhxwGlZ7D0F814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUtLdrOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AF3C2BCF4;
	Mon,  4 May 2026 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904380;
	bh=sOg49B/qV3F7338ltwLt/DhEwlJ5r2TYbQtkP34wJT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUtLdrOyeE89QaXsqqi2Ano+H/SwXXhelZrCm0Bf64UsB4927Fw7B/0YxPdARuWPV
	 AHx8Inqgu9lvU1UsBVCQBAlrl4w1HJL/9UDIq2NIe/YYHbBWmPrkJten/i3pvQIySW
	 B0OsiFfUboh64KEDWRbaLWbIvieAKCOm6pTWtS4w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.12 017/215] drm/nouveau: fix nvkm_device leak on aperture removal failure
Date: Mon,  4 May 2026 15:50:36 +0200
Message-ID: <20260504135130.804017685@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6C9B04BFB68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243631-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

commit 6597ff1d8de3f583be169587efeafd8af134e138 upstream.

When aperture_remove_conflicting_pci_devices() fails during probe, the
error path returns directly without unwinding the nvkm_device that was
just allocated by nvkm_device_pci_new(). This leaks both the device
wrapper and the pci_enable_device() reference taken inside it.

Jump to the existing fail_nvkm label so nvkm_device_del() runs and
balances both. The leak was introduced when the intermediate
nvkm_device_del() between detection and aperture removal was dropped
in favor of creating the pci device once.

Fixes: c0bfe34330b5 ("drm/nouveau: create pci device once")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260411062938.22925-1-devnexen@gmail.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -853,7 +853,7 @@ static int nouveau_drm_probe(struct pci_
 	/* Remove conflicting drivers (vesafb, efifb etc). */
 	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &driver_pci);
 	if (ret)
-		return ret;
+		goto fail_nvkm;
 
 	pci_set_master(pdev);
 



