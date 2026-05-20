Return-Path: <stable+bounces-251395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDCeCe76DWrO5AUAu9opvQ
	(envelope-from <stable+bounces-251395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DED0595C21
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A793333F6F45
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3539A33BBAF;
	Wed, 20 May 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FTabJGis"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AF3D6673;
	Wed, 20 May 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297869; cv=none; b=LUX0b/Pq+Qrr6450htiMt9FEMKdXahfRRg2VZKYJK9tiWLESCOQqp11G/ZWtgeIkzBGEMzWH/GeSmoIGkJYW62xGaxYUef0j2XiUtmXMKqQI8AutFkn/dzmH8IHQedqVAZK/DXKWlwNWcuidbP7HjAnIPxTi+1H32s7o0y9ULvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297869; c=relaxed/simple;
	bh=DWDZRs8fRANK5hRm/NwThHAt3WTM73QKcGRdNSKkNtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bxq7F0aw5qcFK3FrcjP7c3ejEQzBIUTEw8I17Qf0aFCXtbsC52pSVWl4dGreSn1ik/+KibxhvxEPQjGDaVo60mOqSTf8LcyEm0NbPH0KYc7/+MGwFjX+fhA7fyHoVR06CZLku7pLXgRhzojvgXAGy2pLra+jrVmUFq++tTB06sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FTabJGis; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7DA1F000E9;
	Wed, 20 May 2026 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297867;
	bh=Cvwp3Xn3z5fDb1ToB01EfM1P6hBnTy65ZPCO8FGsXXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FTabJGispXr/H5NAGaOntytuqaQgZRHRhRHWDnFlI01j7vN1MYu55klA6lqdLZino
	 b2QRyMTcbrHQQGafWoCd+b/AV+/wh3OW9YNbqw8NHMHwEE4DqoRXYzQh12izGJoopS
	 Ml051w7tkws6pBBn89pXdOdPEUhy3QVz294czdoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 194/957] ASoC: SDCA: Update counting of SU/GE DAPM routes
Date: Wed, 20 May 2026 18:11:17 +0200
Message-ID: <20260520162138.757824525@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251395-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cirrus.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 7DED0595C21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 1fb720d33eecdb9a90ee340b3000ba378d49f5ca ]

Device Layer Selector Unit's are controlled by a Group Entity control
rather than by the host directly. For the purposes of the ASoC class
driver the number of input routes to the SU is controlled by the number
of options within the Group Entity Selected Mode Control. ie. One valid
DAPM route for each valid route defined in the Group Entity.

Currently the code assumes that a Device Layer SU will have a number of
routes equal to the number of potential sources for the SU. ie. it
counts the routes using the SU, but then creates the routes using the
GE. However, this isn't actually true, it is perfectly allowed for the
GE to only define options for some of the potential sources of the SU.o
In such a case the number of routes return will not match those created,
leading to either an overflow of the routes array or undefined routes to
be past to the ASoC core, both of which generally lead to the sound card
failing to probe.

Update the handling for the counting of routes to count the connected
routes on the GE itself and then ignore the source routes on the SU.
This makes it match the logic generating the routes and ensuring that
both remain in sync.

Fixes: 2c8b3a8e6aa8 ("ASoC: SDCA: Create DAPM widgets and routes from DisCo")
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260225140118.402695-3-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdca/sdca_asoc.c | 41 +++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sdca/sdca_asoc.c b/sound/soc/sdca/sdca_asoc.c
index 197a592ec2f16..523ea9a2c5f42 100644
--- a/sound/soc/sdca/sdca_asoc.c
+++ b/sound/soc/sdca/sdca_asoc.c
@@ -51,6 +51,25 @@ static bool readonly_control(struct sdca_control *control)
 	return control->has_fixed || control->mode == SDCA_ACCESS_MODE_RO;
 }
 
+static int ge_count_routes(struct sdca_entity *entity)
+{
+	int count = 0;
+	int i, j;
+
+	for (i = 0; i < entity->ge.num_modes; i++) {
+		struct sdca_ge_mode *mode = &entity->ge.modes[i];
+
+		for (j = 0; j < mode->num_controls; j++) {
+			struct sdca_ge_control *affected = &mode->controls[j];
+
+			if (affected->sel != SDCA_CTL_SU_SELECTOR || affected->val)
+				count++;
+		}
+	}
+
+	return count;
+}
+
 /**
  * sdca_asoc_count_component - count the various component parts
  * @dev: Pointer to the device against which allocations will be done.
@@ -74,6 +93,7 @@ int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *fun
 			      int *num_widgets, int *num_routes, int *num_controls,
 			      int *num_dais)
 {
+	struct sdca_control *control;
 	int i, j;
 
 	*num_widgets = function->num_entities - 1;
@@ -83,6 +103,7 @@ int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *fun
 
 	for (i = 0; i < function->num_entities - 1; i++) {
 		struct sdca_entity *entity = &function->entities[i];
+		bool skip_primary_routes = false;
 
 		/* Add supply/DAI widget connections */
 		switch (entity->type) {
@@ -96,6 +117,17 @@ int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *fun
 		case SDCA_ENTITY_TYPE_PDE:
 			*num_routes += entity->pde.num_managed;
 			break;
+		case SDCA_ENTITY_TYPE_GE:
+			*num_routes += ge_count_routes(entity);
+			skip_primary_routes = true;
+			break;
+		case SDCA_ENTITY_TYPE_SU:
+			control = sdca_selector_find_control(dev, entity, SDCA_CTL_SU_SELECTOR);
+			if (!control)
+				return -EINVAL;
+
+			skip_primary_routes = (control->layers == SDCA_ACCESS_LAYER_DEVICE);
+			break;
 		default:
 			break;
 		}
@@ -104,7 +136,8 @@ int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *fun
 			(*num_routes)++;
 
 		/* Add primary entity connections from DisCo */
-		*num_routes += entity->num_sources;
+		if (!skip_primary_routes)
+			*num_routes += entity->num_sources;
 
 		for (j = 0; j < entity->num_controls; j++) {
 			if (exported_control(entity, &entity->controls[j]))
@@ -451,7 +484,6 @@ static int entity_parse_su_device(struct device *dev,
 				  struct snd_soc_dapm_route **route)
 {
 	struct sdca_control_range *range;
-	int num_routes = 0;
 	int i, j;
 
 	if (!entity->group) {
@@ -487,11 +519,6 @@ static int entity_parse_su_device(struct device *dev,
 				return -EINVAL;
 			}
 
-			if (++num_routes > entity->num_sources) {
-				dev_err(dev, "%s: too many input routes\n", entity->label);
-				return -EINVAL;
-			}
-
 			term = sdca_range_search(range, SDCA_SELECTED_MODE_INDEX,
 						 mode->val, SDCA_SELECTED_MODE_TERM_TYPE);
 			if (!term) {
-- 
2.53.0




