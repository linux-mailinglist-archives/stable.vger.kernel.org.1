Return-Path: <stable+bounces-129016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A061A7FDA4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE92C170B71
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0F9267B93;
	Tue,  8 Apr 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0XCELWOI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E01311AC;
	Tue,  8 Apr 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109891; cv=none; b=My5MnZ846rruCjVWqqBHWlCqaS8vWWHVptMy9ALIJJSZ9bYrelUgxZsh5UDKndEZl4Rp4PJ+j/g5sLtL2jAUqonM+tbLU+kEunzwkOeT486JrtLLZ3brEVKRWkSljVuBCy29StLRLZpkOmQCGBGuYXqop5nwsu30adlPXTBiuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109891; c=relaxed/simple;
	bh=sWFcY/4kwf3LtjiYQXHcNoSckYAYyV7OCs8A1fPjpj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcmwRwj9Pta0SSlRbq7mj7B8M6mCGhrjEqRxYY2dxcfb9iki/ghLUjUOTDFj3Rwt4hiOzuyIC99jFt02Cox2Czp8VAPetk7UpAgt1P1NEBC8Oq+tfz6IaZ5bfTnwem78lHHW6MdwvFzQOJfChD3fua6pZka5paSSyJ6v9v9ssz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0XCELWOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F56AC4CEE7;
	Tue,  8 Apr 2025 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109891;
	bh=sWFcY/4kwf3LtjiYQXHcNoSckYAYyV7OCs8A1fPjpj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0XCELWOIal8erDxcD7SRx6uHXIkeK888ANvKcJnJDrKaAJ0QnGYCyVtpzUAGOoDUo
	 saKtgc9piOWgYT/JdHt1jtG4WPPu81Rf6tF21Un6AvIct0OT31CDdSldZvpAK101M7
	 vSgVgYy7qO1V1s6jGrMeIIsk/qcfwNJ7zKcVgwEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10 092/227] drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()
Date: Tue,  8 Apr 2025 12:47:50 +0200
Message-ID: <20250408104823.131385766@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

commit dd8689b52a24807c2d5ce0a17cb26dc87f75235c upstream.

On the off chance that command stream passed from userspace via
ioctl() call to radeon_vce_cs_parse() is weirdly crafted and
first command to execute is to encode (case 0x03000001), the function
in question will attempt to call radeon_vce_cs_reloc() with size
argument that has not been properly initialized. Specifically, 'size'
will point to 'tmp' variable before the latter had a chance to be
assigned any value.

Play it safe and init 'tmp' with 0, thus ensuring that
radeon_vce_cs_reloc() will catch an early error in cases like these.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 2fc5703abda2 ("drm/radeon: check VCE relocation buffer range v3")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2d52de55f9ee7aaee0e09ac443f77855989c6b68)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_vce.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -558,7 +558,7 @@ int radeon_vce_cs_parse(struct radeon_cs
 {
 	int session_idx = -1;
 	bool destroyed = false, created = false, allocated = false;
-	uint32_t tmp, handle = 0;
+	uint32_t tmp = 0, handle = 0;
 	uint32_t *size = &tmp;
 	int i, r = 0;
 



