Return-Path: <stable+bounces-159757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34917AF7A37
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FCE560835
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119132E7197;
	Thu,  3 Jul 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJEreTEp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EC15442C;
	Thu,  3 Jul 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555244; cv=none; b=pc4U4R7AUc4i0WnKy3kcabYfV/jh+OwHfa/4UAnIwDrqd2u6VO2P1J0I6U91sy9p9ECTkVwzhfGgMTr9+FNuCpdmRQILkj2eGjxkkA6lQxalLNYXRoKy7jGzypb/obrFopTM9CUQCypKn+pNdyN9/T2gLCpnQIaX3MHo95LI9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555244; c=relaxed/simple;
	bh=PB3Tg3zJ7mI4LAPel6VpQ80jZLrExtRIEyeW6Czi3XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q94eiNMPtrecDWkx/SbbLKBIriQUaPJiAJqoOjhWkpoKxhmB+pdZIRmElsTVFUKo9R3xVpluc/s05dACh0H33YZWzNgUF6BEqU/gNwWdHKZbnQabop3hlwI8+u6UvU6zjtvD+cOeLLW+lyDI3Ez1sL0owUGuywdcAibFLGB3qMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TJEreTEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADAAC4CEE3;
	Thu,  3 Jul 2025 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555244;
	bh=PB3Tg3zJ7mI4LAPel6VpQ80jZLrExtRIEyeW6Czi3XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJEreTEpj5FokDiWJ0jZY35Psx2qBbC1W+qsgOdbv6mHke/H4a82O+bHosULrjBUv
	 RcD7L+x5CMjaxEMLUUp2zNTPIk2UQc1mePaAGIrgCgFi5HHC3YFANNrKttXu9Jyr0C
	 9TLvsEWmb9Wsmu1Q2d5lZaFVUDGB515pc4BTqsgs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.15 219/263] drm/amd/display: Add null pointer check for get_first_active_display()
Date: Thu,  3 Jul 2025 16:42:19 +0200
Message-ID: <20250703144013.165073261@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit c3e9826a22027a21d998d3e64882fa377b613006 upstream.

The function mod_hdcp_hdcp1_enable_encryption() calls the function
get_first_active_display(), but does not check its return value.
The return value is a null pointer if the display list is empty.
This will lead to a null pointer dereference in
mod_hdcp_hdcp2_enable_encryption().

Add a null pointer check for get_first_active_display() and return
MOD_HDCP_STATUS_DISPLAY_NOT_FOUND if the function return null.

Fixes: 2deade5ede56 ("drm/amd/display: Remove hdcp display state with mst fix")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # v5.8
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -368,6 +368,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enab
 	struct mod_hdcp_display *display = get_first_active_display(hdcp);
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	mutex_lock(&psp->hdcp_context.mutex);
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));



