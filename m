Return-Path: <stable+bounces-71196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D938196123B
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180CE1C2399E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E70D1CDFD6;
	Tue, 27 Aug 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UthOpZfw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1C1C57AB;
	Tue, 27 Aug 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772416; cv=none; b=RB53LvJk+/z7ccj8KZkqDebVWjCGLLr5m5imVplAmJiL5qd5dICZTX5F2b68HKkcthg9d5LLsL2c0LdhjE3l5G6G2EOWwkmlxV0+nf+davm+4J44iRTT5/yhy19RWz1o2qNx8m/enx+92KnV6qtXP/z9IIvX70ISe2aLIXT4eNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772416; c=relaxed/simple;
	bh=cosvwLeXRaR1SO+kQm9fp+JQLg0D8EGrgBbH0xXzezE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlWVbKpaSWkOo6Nud0yEJV6GzAxdnW2mrhNbQ+42T+x/fzSOGURQiXBaAMW9v09uTsEWT6y/m/NEvP4RcF+0lV/xiUubd3yjgPEdAP+c/cS++RA639oPEEQ/bYaumFkztXDdHIZxB707CrsQi9r277ZNa3m0Y+YZ7Ax8lDIg9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UthOpZfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2C6C4DE14;
	Tue, 27 Aug 2024 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772415;
	bh=cosvwLeXRaR1SO+kQm9fp+JQLg0D8EGrgBbH0xXzezE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UthOpZfwIGBnC5EJseB0IlZDc5Z5xr2Ly1NReTX7Of+P3xGBSfNUqmae7kiLDloHc
	 AqnH+Sm1qtlB9i+E2z33NAnq3LgaoubU2MDruLYJmazyWXa02frn9Y7dUODV2/P6gQ
	 ptonPn9gNNUPAj+rN61wMC+skO7kCU0/1qzVwr1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 201/321] usb: dwc3: core: Skip setting event buffers for host only controllers
Date: Tue, 27 Aug 2024 16:38:29 +0200
Message-ID: <20240827143845.885014122@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krishna Kurapati <quic_kriskura@quicinc.com>

[ Upstream commit 89d7f962994604a3e3d480832788d06179abefc5 ]

On some SoC's like SA8295P where the tertiary controller is host-only
capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
Trying to access them leads to a crash.

For DRD/Peripheral supported controllers, event buffer setup is done
again in gadget_pullup. Skip setup or cleanup of event buffers if
controller is host-only capable.

Suggested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240420044901.884098-4-quic_kriskura@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 94bc7786a3c4e..4964fa7419efa 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -506,6 +506,13 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
 static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 {
 	struct dwc3_event_buffer *evt;
+	unsigned int hw_mode;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		dwc->ev_buf = NULL;
+		return 0;
+	}
 
 	evt = dwc3_alloc_one_event_buffer(dwc, length);
 	if (IS_ERR(evt)) {
@@ -527,6 +534,9 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
+	if (!dwc->ev_buf)
+		return 0;
+
 	evt = dwc->ev_buf;
 	evt->lpos = 0;
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
@@ -544,6 +554,9 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
+	if (!dwc->ev_buf)
+		return;
+
 	evt = dwc->ev_buf;
 
 	evt->lpos = 0;
-- 
2.43.0




