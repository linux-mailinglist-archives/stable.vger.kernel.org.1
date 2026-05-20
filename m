Return-Path: <stable+bounces-253018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A4QGtkADmp+5QUAu9opvQ
	(envelope-from <stable+bounces-253018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:43:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC459716D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8C883079664
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70623371CEA;
	Wed, 20 May 2026 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q/sJ+V87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B2272E56;
	Wed, 20 May 2026 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302189; cv=none; b=CMwpQkMD7oB80w2onuusRQmSgpNLnnzHbvKutTc0g3WF5pmOs360dixr+cg2rwGSk+H5Y0IjfyrnOpWrfbJFAH4pr7gm0XcCjT2Z1PUGYYcT/Mg9ialhIZvlZKE1kPfq0jt8GhVMysjfkNQnj1v5vHXaUaFQxXEZAReNCp/2NH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302189; c=relaxed/simple;
	bh=Czxj7D9PHXzaoVE5f4ysm4HfKyu3jDET7V0ThXaqQ+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA8HBDv4+XfQelnz/G9U2of7Q4JSNEJxt6erOHhJ731ekSoHBwVRZS69BYp8nSJDZppsK+5lps2Iw3te+5p9BymzR6aNSWXqbpr+LJMkMYTqzZAH1qNI+C1jkUroYGcxcl5mYyi9hOGjE48UxCLeDCjAVdsktsVSnUI/aNcztEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q/sJ+V87; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9922F1F000E9;
	Wed, 20 May 2026 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302188;
	bh=1nOSvPqrgi/wiHnD5m1hGlfMkGaRNwp1DeyEEpkMFhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/sJ+V87RXWbTbD1PUQOqHIFJtf1MKG6Rcr9ER/o2wmR4+HC+SIXY78lSgbwtGHqd
	 1PJbAujZQffoNoBEPzyodkSlLkbeDmpaH10wLJ4UysLtML8yBp1GX8adoMdffhevuq
	 OE44+X+agHos4c6OEwnMXO/b85ysznec0IaPBAw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 120/508] drm/panel: simple: Correct G190EAN01 prepare timing
Date: Wed, 20 May 2026 18:19:03 +0200
Message-ID: <20260520162101.229627915@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253018-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 36AC459716D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit f1080f82570b797598c1ba7e9c800ae9e94aafc6 ]

The prepare timing specified by the G190EAN01 datasheet should be
between 30 and 50 ms. Considering it might take some time for the
LVDS encoder to enable the signal, we should only wait the min.
required time in the panel driver and not the max. allowed time.

Fixes: 2f7b832fc992 ("drm/panel: simple: Add support for AUO G190EAN01 panel")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260217142528.68613-1-ian.ray@gehealthcare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8a94eee57d943..7620ac20393b7 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1157,7 +1157,7 @@ static const struct panel_desc auo_g190ean01 = {
 		.height = 301,
 	},
 	.delay = {
-		.prepare = 50,
+		.prepare = 30,
 		.enable = 200,
 		.disable = 110,
 		.unprepare = 1000,
-- 
2.53.0




