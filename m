Return-Path: <stable+bounces-15282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C951E8384A2
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E954299CFF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25234745C9;
	Tue, 23 Jan 2024 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XOK+dhRd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B19745C3;
	Tue, 23 Jan 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975443; cv=none; b=DteM/oESU/1pwGoydkKVTJiOrVQKhuhbzG4JEnYr5esNLkJ73H/MtuLNDwlnwRIwHwk1QJoSqnc4GEBfsKfTaURcwdb320aGkrI1NKDnllLzDSMxYFfZTZpSLQMeyxXVSFNiAH4+gae72FmtCPZDAtcHX+43M5No8MDZb3tAKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975443; c=relaxed/simple;
	bh=K9uX0yC/RewCBZ3DqpJxNRUeH/6s5eF324bjslBdh5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cW1FYBs+eHcO+ubek3cqglzMZy3LMHKWTzQWgsy+mN/pQAz5kwnouLvtRSgBKbqLBe6QVdOHiE2K9i0K1Wf9kExps6SQPZ4l0dB3gAbBwp3cuq1rPwpog6lXU9jT++UmeKokEbPxAkkfaRNQYgkUE2zoAp7qDCnh1/YJ+2jGQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XOK+dhRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C55FC433C7;
	Tue, 23 Jan 2024 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975443;
	bh=K9uX0yC/RewCBZ3DqpJxNRUeH/6s5eF324bjslBdh5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XOK+dhRdzg+QhlFpb0koEVfRP0cK65axxLn3tcmTY+4VBIRsk1+aLb56FR4uCbS7d
	 61Q2hYPcGpelSEsXwjo3r2W8UY6IP+xbcn02W2yG9QLsel+m4DHEd34bv5eqoV8tOc
	 gQKOBTyYyoXGsCM/0JLMX0csjZRnMAVXyD0vxMyY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 400/583] drm/amd: Enable PCIe PME from D3
Date: Mon, 22 Jan 2024 15:57:31 -0800
Message-ID: <20240122235824.224079632@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit bd1f6a31e7762ebc99b97f3eda5e5ea3708fa792 upstream.

When dGPU is put into BOCO it may be in D3cold but still able send
PME on display hotplug event. For this to work it must be enabled
as wake source from D3.

When runpm is enabled use pci_wake_from_d3() to mark wakeup as
enabled by default.

Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2197,6 +2197,8 @@ retry_init:
 
 		pci_wake_from_d3(pdev, TRUE);
 
+		pci_wake_from_d3(pdev, TRUE);
+
 		/*
 		 * For runpm implemented via BACO, PMFW will handle the
 		 * timing for BACO in and out:



