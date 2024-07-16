Return-Path: <stable+bounces-59531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D95932A94
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 437AFB2331B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32DD1DA4D;
	Tue, 16 Jul 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FmD69b1D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F068D53B;
	Tue, 16 Jul 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144130; cv=none; b=CrEx96pqUhATl9R+fxLaJXI913wTtvsh5QoJ8AgTI3e7CS8rEFRmuB32jwOrnI7UPM6a09ngHFs8pQTRG/F+atDVNRjpZ7Bnim16Kx5O98ZquALWWHb7R5ZHOYqG/IDZY0knE//Twmy4r0xoyIlmzfkCjdEkPoAEoEBQyacCBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144130; c=relaxed/simple;
	bh=b2jT4MQ1kFmcWWXs45/K9d7VqVysgAeyQj1r35kD/wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reDkwg83aXDFKWe3lc8jhskeX/P34Dq4bTf2O6E/Cd+dNvc5NvBUbZEmuKVWEuz79MNKmm1rCI5FO8ZiJxmxZ7Lf7SzJnVgjYR7RaRgCOibO/dfdvEePzHMtsV3tKv68qdjePkGjlxGTQq1MTK/pMddpSLcuvDfOBte0gK42zQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FmD69b1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED48DC4AF0B;
	Tue, 16 Jul 2024 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144130;
	bh=b2jT4MQ1kFmcWWXs45/K9d7VqVysgAeyQj1r35kD/wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmD69b1DwN6sbBTquI7FZvWIX/HMFgWPisuo9p4i+1ObwApysTVmUV3fJaUeuEqEd
	 g7p9HbIRcHwZh4dQCijIo8A3zyIJL8yYdG2l1OIlaof8+AqttavCejzexIT/W7n9KS
	 CSQpXy++28icrGqLKgeWoGp18IZed4FwezQLjLXY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 37/66] drm/amdgpu/atomfirmware: silence UBSAN warning
Date: Tue, 16 Jul 2024 17:31:12 +0200
Message-ID: <20240716152739.583332699@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit d0417264437a8fa05f894cabba5a26715b32d78e upstream.

This is a variable sized array.

Link: https://lists.freedesktop.org/archives/amd-gfx/2024-June/110420.html
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/include/atomfirmware.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -620,7 +620,7 @@ struct atom_gpio_pin_lut_v2_1
 {
   struct  atom_common_table_header  table_header;
   /*the real number of this included in the structure is calcualted by using the (whole structure size - the header size)/size of atom_gpio_pin_lut  */
-  struct  atom_gpio_pin_assignment  gpio_pin[8];
+  struct  atom_gpio_pin_assignment  gpio_pin[];
 };
 
 



