Return-Path: <stable+bounces-102445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E089EF33D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D461654C3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25870226532;
	Thu, 12 Dec 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qIqeDrCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CEC205501;
	Thu, 12 Dec 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021252; cv=none; b=GjmimgoyeC3sQN1XCOU9Hit8XuuoIwhdcCSNYpFL8t0LoXP3FhaqlOVJmcUIQmfItL6ldd7EREeDOFn0tbxZpfF94gKUtNnoBqoBRYxGggvxL/5DjAVTRCQOOhQ7SBAQBGOD3bUdFBQgtisPxnkTOg8B22jbDzecMpEnmAkEwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021252; c=relaxed/simple;
	bh=KcXG/Lrl9v7ZdYUBK09t/F3WyNfi1saexAAQ1OSbcHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwDpDHN06ewgCAXnuSGgypT1wflRWRvEj/V5W1tmTRXWvYks/pLEkixhDjqawpUeKAmhB1+8wh650Rz4SsmqHSIjmEQ8KIsrEjeSaJe36ffa/YnAeOjLKQT8m+qDsRhP8Fxf2xsqbg7Lhvj0Y9hqa6pa/Z4hXDyra3R3niiBuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qIqeDrCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE3DC4CED0;
	Thu, 12 Dec 2024 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021252;
	bh=KcXG/Lrl9v7ZdYUBK09t/F3WyNfi1saexAAQ1OSbcHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIqeDrCh4Yaz3cTSc2AP4Tr/OXK28uZil+5iS7iV+h7uWl9iFj4dLF5IGNKtcvLpB
	 gn+L+qXDAL5QfaOcHLkiVtW9K7s9ilbVxEKoVudW4kYL+jurUK6QaN74E2l/kVRk43
	 Vd7jFfnMILdwHP1HP/t5STrmwtgGsXPTUTejClHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prike Liang <Prike.Liang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 680/772] drm/amdgpu: Dereference the ATCS ACPI buffer
Date: Thu, 12 Dec 2024 16:00:25 +0100
Message-ID: <20241212144418.017172614@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 32e7ee293ff476c67b51be006e986021967bc525 ]

Need to dereference the atcs acpi buffer after
the method is executed, otherwise it will result in
a memory leak.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7ad7ebaaa93cd..5fa7f6d8aa309 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -758,6 +758,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 		return -EIO;
 	}
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.43.0




