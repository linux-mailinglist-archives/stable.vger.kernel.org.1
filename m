Return-Path: <stable+bounces-248495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE5MJs5PB2o9yAIAu9opvQ
	(envelope-from <stable+bounces-248495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:54:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0C554290
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73B7340D5F2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052032609EE;
	Fri, 15 May 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ghuv8uJ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4D3BB11C;
	Fri, 15 May 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861876; cv=none; b=VcM/UgXP6p6mlrPVyGwATVWNPbJLCIxbiDtZIY77NaWgWDX3jI04VlXvGRlazOcshQT/rhuIIW9wZWOTEhezG+JX9AOuSak6qBBFtHV8/MGwaNk9RVodfNDxdmJ9D+KFvtd8wi2lTYwEU7xnVCq9g+QZFP1G4l3YXLQdLbjzgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861876; c=relaxed/simple;
	bh=Erurp/3BVYBuGmU8rHD/2zni2VwLiasmkMHtJnLOKKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB94o8fjhUcYhv819q7FhUa2gWL+WdgsRF3sS64k3hZwkDanT2okpDwbhEDP2JsmRCtlaU2c+HZkeyBjBLYvUsoSnQoTU+8TK/cBZ6FHXLdEkAIo7h6ulnCMtyid8oZuWPsDnEtIh5Dvs/w5qHFTV8TcPKfPtKYV1jTTOaQ51/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ghuv8uJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFE6C2BCB0;
	Fri, 15 May 2026 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861876;
	bh=Erurp/3BVYBuGmU8rHD/2zni2VwLiasmkMHtJnLOKKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghuv8uJ498nozMbzsnx6VMP4g0nbRiEHiwio76crBL3bTUZjbxkUy4+Opu7EuKfnf
	 rt7e6T1hT7iC7VwyoX3dB9qX5+XVQvHfnJkBzySrIvZqZcJ06qwKkPYrwu9BATzfo6
	 nHdzSi5IeAEUi/h2QbTCpAwUmKX2lw4pSs/hBXgo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 6.18 008/188] drm/msm/hdmi: Fix wrong CTRL1 register used in writing info frames
Date: Fri, 15 May 2026 17:47:05 +0200
Message-ID: <20260515154657.490956183@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 17C0C554290
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248495-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,patchwork.freedesktop.org:url]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

commit 8c6c93b7db42d15c6e8c2540a648d32986a04b1a upstream.

Commit 384d2b03d0a1 ("drm/msm/hdmi: make use of the drm_connector_hdmi
framework") changed the unconditional register writes in few places to
updates: read, apply mask, write.  The new code reads
REG_HDMI_INFOFRAME_CTRL1 register, applies fields/mask for
HDMI_INFOFRAME_CTRL0 register and finally writes to
HDMI_INFOFRAME_CTRL0.  This difference between CTRL1 and CTRL0 looks
unintended and may result in wrong data being written to HDMI bridge
registers.

Cc: <stable@vger.kernel.org>
Fixes: 384d2b03d0a1 ("drm/msm/hdmi: make use of the drm_connector_hdmi framework")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/711156/
Link: https://lore.kernel.org/r/20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -80,7 +80,7 @@ static int msm_hdmi_config_avi_infoframe
 	for (i = 0; i < ARRAY_SIZE(buf); i++)
 		hdmi_write(hdmi, REG_HDMI_AVI_INFO(i), buf[i]);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
+	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
 	val |= HDMI_INFOFRAME_CTRL0_AVI_SEND |
 		HDMI_INFOFRAME_CTRL0_AVI_CONT;
 	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL0, val);
@@ -116,7 +116,7 @@ static int msm_hdmi_config_audio_infofra
 		   buffer[9] << 16 |
 		   buffer[10] << 24);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
+	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
 	val |= HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SEND |
 		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_CONT |
 		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SOURCE |



