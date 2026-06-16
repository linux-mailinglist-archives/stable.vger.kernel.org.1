Return-Path: <stable+bounces-266341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rZ0AIjmcMWqkoAUAu9opvQ
	(envelope-from <stable+bounces-266341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:55:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A1694951
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:55:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=MXR3rU0o;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266341-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266341-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A41D323AB16
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BA47CC7A;
	Tue, 16 Jun 2026 18:51:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6E34FF79;
	Tue, 16 Jun 2026 18:51:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635914; cv=none; b=Dg7u/H77wVm3Qd7Cs1xmOr8sGOPfv8ExkIKhypTC3TVwMsIVxDqsIKynB/jmfiKGZrKhJIsK5JU3m4XIl13JiIxfZ3IhqYgOQeMU6f7hB86dNN/K5quhXx+GZLmYHJ9qPcwEqYEtUrOf9tzT/okO3qUxyttSwXfjBZMBe/NzKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635914; c=relaxed/simple;
	bh=tsUkCCjXvt1MnLCzN7IFB89dSbfY+TR+h4vwNnJrOqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg9uTcFL2N3qaXk/Eu4ShXqxcCCLfzS/sOT0OAKXCcLcxc1bGBRDmUnwj2NSeody3EyqpgsT8vQxJRFW+hpfQHcoyBDXUef1atovZhi8GeNjCFLzJSvNXH1kK/RwOgp7MLPaXPTSbUeUf+zrC53pkWPOtpl0VnLw84jTN/Ggs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXR3rU0o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C558D1F000E9;
	Tue, 16 Jun 2026 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635913;
	bh=PkkSnaygBLb3MFz1SGYfefhUtKG+15QjmXl7TrGBhA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXR3rU0ov2PstAO4oSChOcSVN1Ef8SufLtaucVMxssn8WcPWApy4JNXhIMbF7b3LZ
	 fZjtjyhcl8O0nTvwcm+2Fe1N4puRJJQvRah1SC/Hv6+8Ik8ho93YScA5lLEds6yMCH
	 VADPWpxmvjAFYLK5PIVBTgLM142BfH9Rn6bX3nTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yicong Hui <yiconghui@gmail.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 140/342] drm/imx: Fix three kernel-doc warnings in dcss-scaler.c
Date: Tue, 16 Jun 2026 20:27:16 +0530
Message-ID: <20260616145054.709777906@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.nxp.com,nxp.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-266341-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yiconghui@gmail.com,m:laurentiu.palcu@oss.nxp.com,m:victor.liu@nxp.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80A1694951

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yicong Hui <yiconghui@gmail.com>

[ Upstream commit ae0383e5a9a4b12d68c76c4769857def4665deff ]

Fix the following W=1 kerneldoc warnings by adding the missing parameter
descriptions for @phase0_identity and @nn_interpolation in
dcss_scaler_filter_design() and @phase0_identity in
dcss_scaler_gaussian_filter()

Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:173 function parameter 'phase0_identity' not described in 'dcss_scaler_gaussian_filter'
Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'phase0_identity' not described in 'dcss_scaler_filter_design'
Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'nn_interpolation' not described in 'dcss_scaler_filter_design'

Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
Signed-off-by: Yicong Hui <yiconghui@gmail.com>
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Link: https://patch.msgid.link/20260406180013.2442096-1-yiconghui@gmail.com
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/dcss/dcss-scaler.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
index cd21905de580ff..d156cc60c3f4aa 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
@@ -164,6 +164,7 @@ static int exp_approx_q(int x)
  * dcss_scaler_gaussian_filter() - Generate gaussian prototype filter.
  * @fc_q: fixed-point cutoff frequency normalized to range [0, 1]
  * @use_5_taps: indicates whether to use 5 taps or 7 taps
+ * @phase0_identity: whether to override phase 0 coefficients with identity filter
  * @coef: output filter coefficients
  */
 static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
@@ -249,7 +250,9 @@ static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
  * @src_length: length of input
  * @dst_length: length of output
  * @use_5_taps: 0 for 7 taps per phase, 1 for 5 taps
+ * @phase0_identity: whether to override phase 0 coefficients with identity filter
  * @coef: output coefficients
+ * @nn_interpolation: whether to use nearest neighbor instead of gaussian filter
  */
 static void dcss_scaler_filter_design(int src_length, int dst_length,
 				      bool use_5_taps, bool phase0_identity,
-- 
2.53.0




