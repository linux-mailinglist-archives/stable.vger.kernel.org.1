Return-Path: <stable+bounces-174153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E9B361BB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B1D2A32EF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58A20F079;
	Tue, 26 Aug 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gWxUfz/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AD28FD;
	Tue, 26 Aug 2025 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213633; cv=none; b=JcUG2NJBiDnfGNmO/rNax04UW25z/oOD4e1UTWXOycii2b1ceLnyVKWSbVR3zzp/diI8BOcujOp+4au070Etn2t23uVFjJ71YNdpBrZZM+3QsCBE+sHVg/x175I3MBBFM+uw2tHAP9TXp4nfJQCvXhlyPqWbQ8sThl2cj/g4Hls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213633; c=relaxed/simple;
	bh=5aUsVyMrcRBhTmf1Ywjlwclwr489Hy81aQunPZO+lMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtEWSuJ8oGxzlg+HIIAMWTTZmG2e8dw4/ySvJNS7FiMgnc7vd3DLUmbeUzkAEitnWjqRZaJV1RlnI6zlITnm8+DEsZDGnXXtIuwWJzUc7xwotb+/I+EqwmPz8f3nqwl5QhcMCIilKoBz8lgeD2atZTTr0H5H5NRt2r5eLViboyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gWxUfz/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5093EC4CEF1;
	Tue, 26 Aug 2025 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213633;
	bh=5aUsVyMrcRBhTmf1Ywjlwclwr489Hy81aQunPZO+lMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWxUfz/UXe2n6oqM5uAVap/BiFT9FnmpGAqzEnHB5BFCUUyoqvqziwiDYoOnXC/2q
	 UVJoiSSOQ/GM8ruoLZhDGcAcHol2hX+3fTJRWWm+q+CJAecAGWdBHJ3flAIHVt9xbI
	 eHb4KYoY+GqFo1teVM7yXWwNLhCSrPEq0uKe7DPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6.6 422/587] drm/amd/display: Dont overwrite dce60_clk_mgr
Date: Tue, 26 Aug 2025 13:09:31 +0200
Message-ID: <20250826111003.674674631@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

commit 4db9cd554883e051df1840d4d58d636043101034 upstream.

dc_clk_mgr_create accidentally overwrites the dce60_clk_mgr
with the dce_clk_mgr, causing incorrect behaviour on DCE6.
Fix it by removing the extra dce_clk_mgr_construct.

Fixes: 62eab49faae7 ("drm/amd/display: hide VGH asic specific structs")
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bbddcbe36a686af03e91341b9bbfcca94bd45fb6)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -162,7 +162,6 @@ struct clk_mgr *dc_clk_mgr_create(struct
 			return NULL;
 		}
 		dce60_clk_mgr_construct(ctx, clk_mgr);
-		dce_clk_mgr_construct(ctx, clk_mgr);
 		return &clk_mgr->base;
 	}
 #endif



