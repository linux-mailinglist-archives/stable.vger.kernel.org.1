Return-Path: <stable+bounces-248704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFFNIFFTB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:09:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00097554868
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F41310C81A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FB64D2EF6;
	Fri, 15 May 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1aTdip8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877743F8716;
	Fri, 15 May 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862414; cv=none; b=XdGFFO/Z8ReKg+FdDDN+wTxO17pvWoutIQmeaOAk8iyTjahLcdrk5GPUIZ4f2lTb/3HoeBr7XNN3dSLPi6GFZK6VWPq+rF8SGkB5SNLETOUSv4f8SDvhDEXtKtZ0YRMkBkTMZsqEH5VZWOQjYKZbpoi+sOzO19vbDMpsAOYZb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862414; c=relaxed/simple;
	bh=3KMG9AA8rD3Bj28EJ4edBTuJpHw8f+W5yonWiZ69+wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqqmM3tBNq4j71uQdj+Yy5LYYvNQlXMcs2HE3Si2/8fioDgLTGrcHMJB/19qijInSbaJxYSRF0QsVK/Z4LvHvMli4CD+nMrFRCUjRnonGcM9UFo5sVaJsO09zy49CfHJXtnwwd6z9YIQK1uyeNd72lIzedMYlsqcfjk/OruAp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1aTdip8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BCAC2BCB0;
	Fri, 15 May 2026 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862414;
	bh=3KMG9AA8rD3Bj28EJ4edBTuJpHw8f+W5yonWiZ69+wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1aTdip8kD2jl5mCZnXDGIJmvemSoAPstFoRKiTL8esfqG1fdMzIycpNWUoi/949BA
	 UuvubCfYLKisuEB2W2w+qGDPUAq53nZRhufmd7h3vOTt184IER1csrsNwkO4dfaY4+
	 ySOEhonsB264XAYMn8tDTq2qJ7SbhzRUEJgm4eQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Tarang Raval <tarang.raval@siliconsignals.io>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 7.0 038/201] media: i2c: ov5647: Fix runtime PM refcount leak in s_ctrl
Date: Fri, 15 May 2026 17:47:36 +0200
Message-ID: <20260515154659.359942890@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 00097554868
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248704-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ideasonboard.com:email,intel.com:email,siliconsignals.io:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaolei Wang <xiaolei.wang@windriver.com>

commit f11ae9c04f8368a3b5a0280ef595198dace1c983 upstream.

Three control cases (AUTOGAIN, EXPOSURE_AUTO, ANALOGUE_GAIN) directly
return without calling pm_runtime_put(), causing runtime PM reference
count leaks.

Change these cases from 'return' to 'ret = ... break' pattern to ensure
pm_runtime_put() is always called before function exit.

Fixes: 4f66f36388d5 ("media: i2c: ov5647: Convert to CCI register access helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Tarang Raval <tarang.raval@siliconsignals.io>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov5647.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 6a46ef7233ac..db9bd2892140 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -967,21 +967,21 @@ static int ov5647_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_AUTOGAIN:
 		/* Non-zero turns on AGC by clearing bit 1.*/
-		return cci_update_bits(sensor->regmap, OV5647_REG_AEC_AGC, BIT(1),
-				       ctrl->val ? 0 : BIT(1), NULL);
+		ret = cci_update_bits(sensor->regmap, OV5647_REG_AEC_AGC, BIT(1),
+				      ctrl->val ? 0 : BIT(1), NULL);
 		break;
 	case V4L2_CID_EXPOSURE_AUTO:
 		/*
 		 * Everything except V4L2_EXPOSURE_MANUAL turns on AEC by
 		 * clearing bit 0.
 		 */
-		return cci_update_bits(sensor->regmap, OV5647_REG_AEC_AGC, BIT(0),
-				       ctrl->val == V4L2_EXPOSURE_MANUAL ? BIT(0) : 0, NULL);
+		ret = cci_update_bits(sensor->regmap, OV5647_REG_AEC_AGC, BIT(0),
+				      ctrl->val == V4L2_EXPOSURE_MANUAL ? BIT(0) : 0, NULL);
 		break;
 	case V4L2_CID_ANALOGUE_GAIN:
 		/* 10 bits of gain, 2 in the high register. */
-		return cci_write(sensor->regmap, OV5647_REG_GAIN,
-				 ctrl->val & 0x3ff, NULL);
+		ret = cci_write(sensor->regmap, OV5647_REG_GAIN,
+				ctrl->val & 0x3ff, NULL);
 		break;
 	case V4L2_CID_EXPOSURE:
 		/*
-- 
2.54.0




