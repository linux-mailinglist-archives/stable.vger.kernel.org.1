Return-Path: <stable+bounces-187531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6567BEACA7
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B70D94565F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852DE2F12BB;
	Fri, 17 Oct 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FdpuJ/w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2E330B2E;
	Fri, 17 Oct 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716339; cv=none; b=qmKpH/ixK/4vzP5C45qj+KoxgnfaDEvfr5FQMZJtDNBCNcYCe3pMKqdXaaCQ+WVwWuM/fMPQ1ZWd7JRj7O2Y9QZWqrUMAcvbAbwbLMw4+1fqM94Z3lIbtx41nPiGOvxJ01KwWFLxCmLzwWC0c8FzBggaANSZuXcoV1mP+yJDonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716339; c=relaxed/simple;
	bh=grzkNWZGpk04kzbbQg50j02d7QMyU1ZGUZQENbB6qs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8wWJgryFyTA4Zoxg6SB1jqwvzB6MSO4RR45O5ZeaMj6TQ7W+OAP/kzQwyVUABbvTceP8mlt2cD1YWd7lgOgeP7Q5hAlJ+JfVKoOK46Fk7yD2qXxMqq8oWjYKckVDRlxZDCPtZF/yV9qXNW95lzlEg1FJYPlT/evF/cJbUnIRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FdpuJ/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1773C4CEE7;
	Fri, 17 Oct 2025 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716339;
	bh=grzkNWZGpk04kzbbQg50j02d7QMyU1ZGUZQENbB6qs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0FdpuJ/waObzLRmy06BZcXx+SRiCKlQb0p1M3b88JepwSytNJoDGZoFAqx+ERrnXI
	 eL5PwK0FMQ1esBqsn1JlFTtb0eQsciw7+zEtQOzBGaj1Qjdjk3D1WvmoXtJEuQpqtz
	 /rNMQaU0VTlTYjBhOuYS+AWqSGt6LDUSgJj+/DJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 157/276] drm/amd/display: Add missing DCE6 SCL_HORZ_FILTER_INIT* SRIs
Date: Fri, 17 Oct 2025 16:54:10 +0200
Message-ID: <20251017145148.207987959@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit d60f9c45d1bff7e20ecd57492ef7a5e33c94a37c ]

Without these, it's impossible to program these registers.

Fixes: 102b2f587ac8 ("drm/amd/display: dce_transform: DCE6 Scaling Horizontal Filter Init (v2)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index cbce194ec7b82..ff746fba850bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -155,6 +155,8 @@
 	SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), \
 	SRI(VIEWPORT_START, SCL, id), \
 	SRI(VIEWPORT_SIZE, SCL, id), \
+	SRI(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL, id), \
+	SRI(SCL_HORZ_FILTER_INIT_CHROMA, SCL, id), \
 	SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL, id), \
 	SRI(SCL_VERT_FILTER_SCALE_RATIO, SCL, id), \
 	SRI(SCL_VERT_FILTER_INIT, SCL, id), \
-- 
2.51.0




