Return-Path: <stable+bounces-243047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDmdIXCl+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:56:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBF74BE227
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F69E300C3B8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887403DE42F;
	Mon,  4 May 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0rZ3DMM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D43DE428;
	Mon,  4 May 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902881; cv=none; b=UG05acT0f05M1Azougxv2Q7q57/7rVYRPkh2xpYv3EmeG410mNmJdo1DP+ir7Ia4ZHEtLv2b3XTkyCsiT4fkM/DszMex1xoGroP0574BcxnhhXgMVSVR8ceZLSkyaJADHSeKpOHKsmWEFyIvO5MCwIAi9BCqEG/uRTn62mqfRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902881; c=relaxed/simple;
	bh=3MWiebezA+lAtrE41hLy7KVUrEMaUkF0AADIkQ+LDDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+o3ZOehlZv+aLARRoo7rTEMy5VnUMcpAnKZYBeyqmFKUw8BYXCIxLhW39QKHcTCnZ+4Qm5KjjHm3FSnY94pvej8vya33DkksBn0OYJjxg79MZS3h/9R0vGr0PshuHIqYejHWR2C1/UGnnK54J1V1koZyQDtUkYtOUap2gqw+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k0rZ3DMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94663C2BCB8;
	Mon,  4 May 2026 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902880;
	bh=3MWiebezA+lAtrE41hLy7KVUrEMaUkF0AADIkQ+LDDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0rZ3DMMESh++RCsjiTZxojj6ZtJmftkmZBVDMv1e2vN8yQlz9ZbH1GdkskIQ1eWR
	 oUg2lVOmxGs1lydp/3xqdJ9YaPBjRGP2Yfhdfo5zPPReOeEgivi45M+oCl2if6v4Z1
	 olQQfUGx2yRsouAFLXEsVYJVNb++BqT6aYRlSRb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 7.0 019/307] drm/nouveau: fix nvkm_device leak on aperture removal failure
Date: Mon,  4 May 2026 15:48:24 +0200
Message-ID: <20260504135143.550048523@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5CBF74BE227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243047-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -874,7 +874,7 @@ static int nouveau_drm_probe(struct pci_
 	/* Remove conflicting drivers (vesafb, efifb etc). */
 	ret = aperture_remove_conflicting_pci_devices(pdev, driver_pci.name);
 	if (ret)
-		return ret;
+		goto fail_nvkm;
 
 	pci_set_master(pdev);
 



