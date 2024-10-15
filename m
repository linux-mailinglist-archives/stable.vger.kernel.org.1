Return-Path: <stable+bounces-86341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7C99ED5C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6AD1F25036
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876AD1B219C;
	Tue, 15 Oct 2024 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FkzXJZI0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481B1B2181;
	Tue, 15 Oct 2024 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998582; cv=none; b=WJFymD+Plgx3td7F8mwGwb8Y+jQUN5ETfrJLub787iIMDcvZUck8HvtCjysgC6wqNI6eGBIKNdC10i3+Mtr2SRQ7tDCYWeAnbKknvYu/ZaoWfzP1mf7/R9TvyrAymmz5O8XxE7JQmYrUbYcNQOke1O/aL6GMtfs0IP8XqTjK7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998582; c=relaxed/simple;
	bh=uwmqVF2ksGzon5E6V5Afa8haKeTGr78YmMylWDLYwRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmBWsiBmqDL/hPZxhvkUvp24YrG8GNX5ktuz1kR/vY1Du/uXjpe5qjvNgUiJaoNXbreUkDDkvSW0TK9qB7ly/cf8FyB/XtwpvXiBnM3xQ1CBAnvoc8WD+2i0VqrW5FV7AFoeJVO9xPfuqvNnqU5kT0+8ZhoBiGA6F3zHhJFVelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FkzXJZI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8469C4CEC6;
	Tue, 15 Oct 2024 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998582;
	bh=uwmqVF2ksGzon5E6V5Afa8haKeTGr78YmMylWDLYwRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkzXJZI0dosMrHd/agXQTNKZAXc1ifi5oSPS9a47OGFwSGXVjmYeZvIWquzJj1WGn
	 g583T7oaNZWI584akLfGpCNYQbUIru0WSFG1DjIA3HiUm/y8drP4NMu5hHsAzm1DwP
	 FX5UxBVR3CXCIXAm4E53MIAEk3oLo9YzpyI7CvTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SurajSonawane2415 <surajsonawane0215@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 5.10 507/518] hid: intel-ish-hid: Fix uninitialized variable rv in ish_fw_xfer_direct_dma
Date: Tue, 15 Oct 2024 14:46:51 +0200
Message-ID: <20241015123936.559303403@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SurajSonawane2415 <surajsonawane0215@gmail.com>

commit d41bff05a61fb539f21e9bf0d39fac77f457434e upstream.

Fix the uninitialized symbol 'rv' in the function ish_fw_xfer_direct_dma
to resolve the following warning from the smatch tool:
drivers/hid/intel-ish-hid/ishtp-fw-loader.c:714 ish_fw_xfer_direct_dma()
error: uninitialized symbol 'rv'.
Initialize 'rv' to 0 to prevent undefined behavior from uninitialized
access.

Cc: stable@vger.kernel.org
Fixes: 91b228107da3 ("HID: intel-ish-hid: ISH firmware loader client driver")
Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
Link: https://patch.msgid.link/20241004075944.44932-1-surajsonawane0215@gmail.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
+++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
@@ -630,7 +630,7 @@ static int ish_fw_xfer_direct_dma(struct
 				  const struct firmware *fw,
 				  const struct shim_fw_info fw_info)
 {
-	int rv;
+	int rv = 0;
 	void *dma_buf;
 	dma_addr_t dma_buf_phy;
 	u32 fragment_offset, fragment_size, payload_max_size;



