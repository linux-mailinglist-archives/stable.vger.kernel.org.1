Return-Path: <stable+bounces-219314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJQDJ0efnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:05:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C66A7192EE0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2C543179584
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D13081C2;
	Wed, 25 Feb 2026 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sDEpXRvW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE99305E28;
	Wed, 25 Feb 2026 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002634; cv=none; b=IFopE1jlAO9ibPyxR7nYcGRXMvqJNFf6AMZgpCLguKYkRzUjEWnuCLRNeYemDLnniFSG8VABHIHzmhH6sQR94OeYnoDrzFvaZmwe+BZhx3OKyQCVHrE7OwXWXo+DPe4/v+cFgPppzIIxNTVIXhDfWK/NMSrwgzPsRd+SHwVoGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002634; c=relaxed/simple;
	bh=hjlBz/iTZzsnZIaxFNT+Nl1gl2EJ32VXJyEzyDJjFeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXxDr6QDyl2yOUN8mBfNdJAtsFiMTU8FPVPx2h2LhE9TeM8nMkiUoeilZ69NiObUHbLw3283FWDEbMI1kLf0igqB74oFqz+onoiha0veC7mIpYzZaBh5+K66RdpkNRJWQaIYsvxOBXgruMBcXlgeVsdcNytHTQ6I8Z89OkR41Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sDEpXRvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF7AC116D0;
	Wed, 25 Feb 2026 06:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002634;
	bh=hjlBz/iTZzsnZIaxFNT+Nl1gl2EJ32VXJyEzyDJjFeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDEpXRvWcSge5ud1hI/aT3xTLx//FfDiEnthM8WuoB3+CNER/RGrhmef2Hcl5V+cR
	 GahEzJNd1OzuWAsxDsUAYFJl92KydDgoz+IIXq/J0TDgCtyMHaO4OoBpBjPmROFqFE
	 kw7JjWDZaFZYZhvFCtP6P6vHLM9j/SwSW1Lo7hCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 398/641] remoteproc: imx_dsp_rproc: Only reset carveout memory at RPROC_OFFLINE state
Date: Tue, 24 Feb 2026 17:22:04 -0800
Message-ID: <20260225012358.216244080@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-219314-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C66A7192EE0
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit b490ddf27be28e64a39c08ae643d7b22561beaf6 ]

Do not reset memory at suspend and resume stage, because some
memory is used to save the software state for resume, if it is cleared,
the resume operation can fail.

Fixes: c4c432dfb00f ("remoteproc: imx_dsp_rproc: Add support of recovery and coredump process")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Link: https://lore.kernel.org/r/20251218071750.2692132-1-shengjiu.wang@nxp.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/imx_dsp_rproc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 6e78a01755c7b..e61a08df113e4 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -1026,9 +1026,11 @@ static int imx_dsp_rproc_load(struct rproc *rproc, const struct firmware *fw)
 	 * Clear buffers after pm rumtime for internal ocram is not
 	 * accessible if power and clock are not enabled.
 	 */
-	list_for_each_entry(carveout, &rproc->carveouts, node) {
-		if (carveout->va)
-			memset(carveout->va, 0, carveout->len);
+	if (rproc->state == RPROC_OFFLINE) {
+		list_for_each_entry(carveout, &rproc->carveouts, node) {
+			if (carveout->va)
+				memset(carveout->va, 0, carveout->len);
+		}
 	}
 
 	ret = imx_dsp_rproc_elf_load_segments(rproc, fw);
-- 
2.51.0




