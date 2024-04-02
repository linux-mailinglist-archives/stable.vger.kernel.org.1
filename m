Return-Path: <stable+bounces-35586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30228950D2
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED481C23250
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A6B604B3;
	Tue,  2 Apr 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkXnnbGA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6F5FDD3
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055012; cv=none; b=aTuQKqEMi0nciW1qce6L3Uv70Z5TMCcJ0BYULHx/dqCz4XE9rRssO6RT8bOqWOZrItwroe9+Jgsjlblbq56EYeyJ2Wf8aW4+2h26lq1TMjcRE1EGSh0gItEJndq6ENQrqZZilWNbxkQLjbBeHJqyJoNZxwuPezDcJtr07VGDQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055012; c=relaxed/simple;
	bh=6lBfGpyYrM7UmFRJx/uEzPLjeYuHkK68XVP6SOldfac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGQtYjxmPPcldhKkzB7h+SRi5GcBE9U6H16PZbVStr42bTHT3Wr32k8KGsjbbMcYyQlpdIwTbMqkFVBcA6OXASaNEAHG55QWzzJiNZFC1XIPdHFfiW1IKM/bfdqns9jzWynvnkUB0ZI8bnsjEIME0jEHEzx951yNTaaBqu2mqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkXnnbGA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712055010; x=1743591010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6lBfGpyYrM7UmFRJx/uEzPLjeYuHkK68XVP6SOldfac=;
  b=lkXnnbGAM+cS82cEK8hhwFZpgdTnak88Z2OYdPRCI5iDhwArY3ldxlnC
   wNqdB06hoLvHSSCobz/jGumuKICYAgFE6bWfizCa+S7ZGKlIvCyYC+j6f
   jJvPKwoxhx3D3x5xHw9zZ7AAm1t24dEqsmmDTvbchfDkPDTlLGDUS6xWj
   0yBR84xOG5uwHnuQaAnLuaO36vsNS54Je7rHL6/vc5uvd4WdGHxEj0Uew
   7vMpd9jLjOO2PUpKHDZjFKaT+b/2OYZIXyHl8zpYhEqJY7+kPhWVL8v42
   Q7ZkTHmcjMx9zXWoqf2kkb+UOeYTkN/OMnygMkTX6GCCNZdyldYzEBwak
   g==;
X-CSE-ConnectionGUID: DNSmHGekT+mtq5ZMkHSIiA==
X-CSE-MsgGUID: 12JV/fEPQSySPT+Nmbbmxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17944417"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17944417"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18002502"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:09 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	"Wachowski, Karol" <karol.wachowski@intel.com>,
	stable@vger.kernel.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 3/8] accel/ivpu: Fix PCI D0 state entry in resume
Date: Tue,  2 Apr 2024 12:49:24 +0200
Message-ID: <20240402104929.941186-4-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Wachowski, Karol" <karol.wachowski@intel.com>

In case of failed power up we end up left in PCI D3hot
state making it impossible to access NPU registers on retry.
Enter D0 state on retry before proceeding with power up sequence.

Fixes: 28083ff18d3f ("accel/ivpu: Fix DevTLB errors on suspend/resume and recovery")
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 9cbd7af6576b..325b82f8d971 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -71,10 +71,10 @@ static int ivpu_resume(struct ivpu_device *vdev)
 {
 	int ret;
 
-	pci_set_power_state(to_pci_dev(vdev->drm.dev), PCI_D0);
+retry:
 	pci_restore_state(to_pci_dev(vdev->drm.dev));
+	pci_set_power_state(to_pci_dev(vdev->drm.dev), PCI_D0);
 
-retry:
 	ret = ivpu_hw_power_up(vdev);
 	if (ret) {
 		ivpu_err(vdev, "Failed to power up HW: %d\n", ret);
-- 
2.43.2


