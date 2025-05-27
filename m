Return-Path: <stable+bounces-147552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8141AC582D
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E663A3A81
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B9227D786;
	Tue, 27 May 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HgZdXQgU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2942A9B;
	Tue, 27 May 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367694; cv=none; b=jjRJX3IAkqY1wakM8Cd9czAqk9HgUmUfIkjhDRFbrHgvECwCaL/7x3uklBxw6nxA96ZuQYER8XcAlB+wrnbB0DRUX41DfynYLd0NLeBqyKX6K4AM/og/UlDOZ5tkik2jObazQAu8BPrJRPBe+PuFUZeX8Q8XDV7PhvKfj6TcCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367694; c=relaxed/simple;
	bh=bX4twi7QHLBDpihEDWciEMnahoeMGPTf+fqTaXhnS6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJUdHuQMynDyI0W8lx+ydV2uz9w3lF721VgPAt+xipUNs93Ui04gGmT9tHsPRg3zj+P0Z1bTgD6mbFh+jQV7Pzvp4tVDt8b8o+sqMA31lvPPW+mYSe40MtkKxJyCdBEzjHXbtWa0mYXwVdOQQKGcKBw6RCYPCgKpT6SdiFi5akA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HgZdXQgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A4AC4CEE9;
	Tue, 27 May 2025 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367694;
	bh=bX4twi7QHLBDpihEDWciEMnahoeMGPTf+fqTaXhnS6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgZdXQgU9DjkAt7K2n8CIlK6K36UdKwXAD9Mhi7XlD19N9MFGzxZ/OCkzsEODCWim
	 rTy2hlQSO5fyoWF1bY6hhiYtwX2gGPTfwDB3jWMYWNgZMdFM0HDbymQpohUwGhiQoz
	 vYB7k4bSyjAHA6F42cbU/K17XHVkDkIYCK1M4b/Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Imre Deak <imre.deak@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 469/783] drm/xe/display: Remove hpd cancel work sync from runtime pm path
Date: Tue, 27 May 2025 18:24:26 +0200
Message-ID: <20250527162532.232127963@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 1ed591582b7b894d2f7e7ab5cef2e9b0b6fef12b ]

This function will synchronously cancel and wait for many display
work queue items, which might try to take the runtime pm reference
causing a bad deadlock. So, remove it from the runtime_pm suspend patch.

Reported-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250212192447.402715-1-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index b3921dbc52ff6..b735e30953cee 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -346,7 +346,8 @@ static void __xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 
 	xe_display_flush_cleanup_work(xe);
 
-	intel_hpd_cancel_work(xe);
+	if (!runtime)
+		intel_hpd_cancel_work(xe);
 
 	if (!runtime && has_display(xe)) {
 		intel_display_driver_suspend_access(display);
-- 
2.39.5




