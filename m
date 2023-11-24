Return-Path: <stable+bounces-2057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC077F8297
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863772859C5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AAE364C8;
	Fri, 24 Nov 2023 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HPK9wEn9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2477364A7;
	Fri, 24 Nov 2023 19:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBFFC433C8;
	Fri, 24 Nov 2023 19:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852942;
	bh=RNLR/S/HltFo60Uk8uJ4Cj0PbfPgLv75uga5KXLFhT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPK9wEn9jfJCsuZgaV8vztv6VD95pHbMeQeZvNUz3a9+H3GvSHPeULhhqz4Wnq9iq
	 LgiX4iDQIijC7LLvhRCbbbMEhLi6D27tJNKwWyz2pSMmG+p5eUUak3OBnlg+XCeMzM
	 b+QQXLQ/h6aqc5XHRKu4MjprnoOLtPKP1JWt2nCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10 185/193] drm/amd/pm: Handle non-terminated overdrive commands.
Date: Fri, 24 Nov 2023 17:55:12 +0000
Message-ID: <20231124171954.578938490@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

commit 08e9ebc75b5bcfec9d226f9e16bab2ab7b25a39a upstream.

The incoming strings might not be terminated by a newline
or a 0.

(found while testing a program that just wrote the string
 itself, causing a crash)

Cc: stable@vger.kernel.org
Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs")
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -776,7 +776,7 @@ static ssize_t amdgpu_set_pp_od_clk_volt
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 
-	if (count > 127)
+	if (count > 127 || count == 0)
 		return -EINVAL;
 
 	if (*buf == 's')
@@ -792,7 +792,8 @@ static ssize_t amdgpu_set_pp_od_clk_volt
 	else
 		return -EINVAL;
 
-	memcpy(buf_cpy, buf, count+1);
+	memcpy(buf_cpy, buf, count);
+	buf_cpy[count] = 0;
 
 	tmp_str = buf_cpy;
 
@@ -807,6 +808,9 @@ static ssize_t amdgpu_set_pp_od_clk_volt
 			return -EINVAL;
 		parameter_size++;
 
+		if (!tmp_str)
+			break;
+
 		while (isspace(*tmp_str))
 			tmp_str++;
 	}



