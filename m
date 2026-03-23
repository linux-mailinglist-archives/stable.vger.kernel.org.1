Return-Path: <stable+bounces-229516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO5YMnZjwWkCSwQAu9opvQ
	(envelope-from <stable+bounces-229516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:59:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B5C2F73C8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E812B35B3D5D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A820248F6F;
	Mon, 23 Mar 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izpKHURZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30152258CE5;
	Mon, 23 Mar 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279482; cv=none; b=e+tqoJ3neBpaWCumUTSaTjFiIf1eFwSPhSLZUg5TwBJo0lB9uT1+cwsGu/ETPntcLKAVFnASzC55WsJsW+PpmX3LZARXlgpk5nivXLYjuuHOVqARv0B/Seo6lG+erlrLzasQL7Npr2DRcqOMWhOah/5Z+am9+eSeG24NFqRBOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279482; c=relaxed/simple;
	bh=LIoq89Od1GrnFx1TCDO5UK2NYh14FHTFuJK2k942t0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4hHCpRqdsZeL/IjxEzvGSWtPZVimlof9hBkRzixInizq+L4jMeCBb/FVx7pgpNhrlGh8Rg+8byivuSQ/4/wTEGsZp1t1cTGuOOJQQ8V+Eizmn7F1i7bejFhfqw4QV6M4G31HebW6L42Sx/dspRZkw5lgBJkyYZAmNOGw7NnahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izpKHURZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AEFC4CEF7;
	Mon, 23 Mar 2026 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279482;
	bh=LIoq89Od1GrnFx1TCDO5UK2NYh14FHTFuJK2k942t0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izpKHURZaPQKGpEHmkaYifsdIm7Gi6kdxqFWYnbAWr64jfP6zdCNm3bgHrFEwKAhr
	 lVFAa5Zc3sZVZYroh0Tl9mT4z73lvgniXCdUB61yAmd97E4mkiqtOPVxtD/ZpTXnJ7
	 S1l77bbuUjbxhCnPeI9DEnpzMdgrOYjH3OuXt/vY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Milen Mitkov <quic_mmitkov@quicinc.com>,
	Robert Foss <robert.foss@linaro.org>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/481] media: camss: vfe-480: Multiple outputs support for SM8250
Date: Mon, 23 Mar 2026 14:40:14 +0100
Message-ID: <20260323134526.022677573@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,quicinc.com,linaro.org,xs4all.nl,kernel.org];
	TAGGED_FROM(0.00)[bounces-229516-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:email,xs4all.nl:email]
X-Rspamd-Queue-Id: 39B5C2F73C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milen Mitkov <quic_mmitkov@quicinc.com>

[ Upstream commit 1c4abf0246d2ad5fabc830f1d9cc3944d5a4ae95 ]

On SM8250 each VFE supports at least 3 RDI channels, or 4
in case of VFE-Lite, so add appropriate IRQ setup and handling.

Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: d965919af524 ("media: qcom: camss: vfe: Fix out-of-bounds access in vfe_isr_reg_update()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/qcom/camss/camss-vfe-480.c | 57 ++++++++++++-------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index 72f5cfeeb49bf..0063e36a30e05 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -93,6 +93,8 @@ static inline int bus_irq_mask_0_comp_done(struct vfe_device *vfe, int n)
 #define RDI_WM(n)			((IS_LITE ? 0 : 23) + (n))
 #define RDI_COMP_GROUP(n)		((IS_LITE ? 0 : 11) + (n))
 
+#define MAX_VFE_OUTPUT_LINES	4
+
 static u32 vfe_hw_version(struct vfe_device *vfe)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_HW_VERSION);
@@ -170,12 +172,26 @@ static inline void vfe_reg_update_clear(struct vfe_device *vfe,
 
 static void vfe_enable_irq_common(struct vfe_device *vfe)
 {
-	/* enable only the IRQs used: rup and comp_done irqs for RDI0 */
+	/* enable reset ack IRQ and top BUS status IRQ */
 	writel_relaxed(IRQ_MASK_0_RESET_ACK | IRQ_MASK_0_BUS_TOP_IRQ,
 		       vfe->base + VFE_IRQ_MASK(0));
-	writel_relaxed(BUS_IRQ_MASK_0_RDI_RUP(vfe, 0) |
-		       BUS_IRQ_MASK_0_COMP_DONE(vfe, RDI_COMP_GROUP(0)),
-		       vfe->base + VFE_BUS_IRQ_MASK(0));
+}
+
+static void vfe_enable_lines_irq(struct vfe_device *vfe)
+{
+	int i;
+	u32 bus_irq_mask = 0;
+
+	for (i = 0; i < MAX_VFE_OUTPUT_LINES; i++) {
+		/* Enable IRQ for newly added lines, but also keep already running lines's IRQ */
+		if (vfe->line[i].output.state == VFE_OUTPUT_RESERVED ||
+		    vfe->line[i].output.state == VFE_OUTPUT_ON) {
+			bus_irq_mask |= BUS_IRQ_MASK_0_RDI_RUP(vfe, i)
+					| BUS_IRQ_MASK_0_COMP_DONE(vfe, RDI_COMP_GROUP(i));
+			}
+	}
+
+	writel_relaxed(bus_irq_mask, vfe->base + VFE_BUS_IRQ_MASK(0));
 }
 
 static void vfe_isr_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id);
@@ -192,6 +208,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 {
 	struct vfe_device *vfe = dev;
 	u32 status;
+	int i;
 
 	status = readl_relaxed(vfe->base + VFE_IRQ_STATUS(0));
 	writel_relaxed(status, vfe->base + VFE_IRQ_CLEAR(0));
@@ -206,11 +223,14 @@ static irqreturn_t vfe_isr(int irq, void *dev)
 		writel_relaxed(status, vfe->base + VFE_BUS_IRQ_CLEAR(0));
 		writel_relaxed(1, vfe->base + VFE_BUS_IRQ_CLEAR_GLOBAL);
 
-		if (status & BUS_IRQ_MASK_0_RDI_RUP(vfe, 0))
-			vfe_isr_reg_update(vfe, 0);
+		/* Loop through all WMs IRQs */
+		for (i = 0; i < MSM_VFE_IMAGE_MASTERS_NUM; i++) {
+			if (status & BUS_IRQ_MASK_0_RDI_RUP(vfe, i))
+				vfe_isr_reg_update(vfe, i);
 
-		if (status & BUS_IRQ_MASK_0_COMP_DONE(vfe, RDI_COMP_GROUP(0)))
-			vfe_isr_wm_done(vfe, 0);
+			if (status & BUS_IRQ_MASK_0_COMP_DONE(vfe, RDI_COMP_GROUP(i)))
+				vfe_isr_wm_done(vfe, i);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -233,7 +253,6 @@ static int vfe_get_output(struct vfe_line *line)
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output;
 	unsigned long flags;
-	int wm_idx;
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 
@@ -245,12 +264,12 @@ static int vfe_get_output(struct vfe_line *line)
 
 	output->wm_num = 1;
 
-	wm_idx = vfe_reserve_wm(vfe, line->id);
-	if (wm_idx < 0) {
-		dev_err(vfe->camss->dev, "Can not reserve wm\n");
-		goto error_get_wm;
-	}
-	output->wm_idx[0] = wm_idx;
+	/* Correspondence between VFE line number and WM number.
+	 * line 0 -> RDI 0, line 1 -> RDI1, line 2 -> RDI2, line 3 -> PIX/RDI3
+	 * Note this 1:1 mapping will not work for PIX streams.
+	 */
+	output->wm_idx[0] = line->id;
+	vfe->wm_output_map[line->id] = line->id;
 
 	output->drop_update_idx = 0;
 
@@ -258,11 +277,9 @@ static int vfe_get_output(struct vfe_line *line)
 
 	return 0;
 
-error_get_wm:
-	vfe_release_wm(vfe, output->wm_idx[0]);
-	output->state = VFE_OUTPUT_OFF;
 error:
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
+	output->state = VFE_OUTPUT_OFF;
 
 	return -EINVAL;
 }
@@ -344,6 +361,8 @@ static int vfe_enable(struct vfe_line *line)
 
 	vfe->stream_count++;
 
+	vfe_enable_lines_irq(vfe);
+
 	mutex_unlock(&vfe->stream_lock);
 
 	ret = vfe_get_output(line);
@@ -550,7 +569,7 @@ static const struct camss_video_ops vfe_video_ops_480 = {
 static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 {
 	vfe->video_ops = vfe_video_ops_480;
-	vfe->line_num = 1;
+	vfe->line_num = MAX_VFE_OUTPUT_LINES;
 }
 
 const struct vfe_hw_ops vfe_ops_480 = {
-- 
2.51.0




