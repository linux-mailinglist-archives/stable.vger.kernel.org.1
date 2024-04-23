Return-Path: <stable+bounces-40559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A768ADE8B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 09:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B96281997
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31AA4D58E;
	Tue, 23 Apr 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9hJWNsq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32514481B8
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858517; cv=none; b=Sp7qI5KMOqtaH6m31oNN+jpUQN7lv4d27fk82wnE0eXcX8AAGb7w0LQsl7MnaC9zgvZtusoKs5Ha0EFWW7ykXtZ4wcThqhA7Oa213Cqk35XX4P600M6nMUCVj/nupqfoeQukyhYgaFa/XjKPzoV0EWI2ENDlieAva28ExbS2Ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858517; c=relaxed/simple;
	bh=QWtgV5SwnbigQC5y4kW5dSSkWPJ3LkNWfptdsmZW9DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHw4MwxhTBcz+B9e8Ueet+zcVIYkY+lIwGNzGQZFFE3L62P/LYQOft13qSHtW/ypwnxZN2k5lFLV7dYB9I6CU0jc1v8RWJeLkElUKYZ/HjhKfuAqiq8xpYrV8fG0NWu/wfm3laqe2B2INfxTHN3PeEQnnnRJIuMZoHKp7fbRbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9hJWNsq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713858516; x=1745394516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QWtgV5SwnbigQC5y4kW5dSSkWPJ3LkNWfptdsmZW9DY=;
  b=U9hJWNsqsxKRl7WoqWikujXRGnfSXyZMzPKDcZHVxh8aw7snJGH33ZJf
   XFAilT356v23L7Nq+cV1/knsV5n/sCA3XcmBk7uwTmRkz8Bk/qvSeLnUT
   5j8iqV+pDr6oGjjkJZdpf8y8lJvefn49XOE08sylCXhGF5mq0LfVEFzA+
   vqqr9pzJhiQju8SDT73PkESpuiPfuWGdHEL+MGS74/3w09rJzUNf4AdiS
   k/lkX0ZWq8t3HFCC2KJ2IiCxEC8Iu/ff4PZ7t8DLouOHp2hHmvFv+2s8n
   iU2qh5RWFklDUYNj4zNrzxKtMwOCkN9b8bz08Bj+DDJfj7sAX+CDDO5Ep
   w==;
X-CSE-ConnectionGUID: AxN7g4H2RaGowHv2uF3A2Q==
X-CSE-MsgGUID: zDv4xAjoTWSWaie/evNuUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9967007"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9967007"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 00:48:36 -0700
X-CSE-ConnectionGUID: v2WlsUaiT9WfvKSTUbiFBg==
X-CSE-MsgGUID: 7g4Dwd7dQJm9eGeBfcqVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28955731"
Received: from unknown (HELO mwauld-desk.intel.com) ([10.245.244.139])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 00:48:34 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/xe/vm: prevent UAF in rebind_work_func()
Date: Tue, 23 Apr 2024 08:47:23 +0100
Message-ID: <20240423074721.119633-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423074721.119633-3-matthew.auld@intel.com>
References: <20240423074721.119633-3-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We flush the rebind worker during the vm close phase, however in places
like preempt_fence_work_func() we seem to queue the rebind worker
without first checking if the vm has already been closed.  The concern
here is the vm being closed with the worker flushed, but then being
rearmed later, which looks like potential uaf, since there is no actual
refcounting to track the queued worker. We can't take the vm->lock here
in preempt_rebind_work_func() to first check if the vm is closed since
that will deadlock, so instead flush the worker again when the vm
refcount reaches zero.

v2:
 - Grabbing vm->lock in the preempt worker creates a deadlock, so
   checking the closed state is tricky. Instead flush the worker when
   the refcount reaches zero. It should be impossible to queue the
   preempt worker without already holding vm ref.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1676
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1591
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1304
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1249
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 2ba7c920a8af..71de9848bdc2 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1509,6 +1509,9 @@ static void vm_destroy_work_func(struct work_struct *w)
 	/* xe_vm_close_and_put was not called? */
 	xe_assert(xe, !vm->size);
 
+	if (xe_vm_in_preempt_fence_mode(vm))
+		flush_work(&vm->preempt.rebind_work);
+
 	mutex_destroy(&vm->snap_mutex);
 
 	if (!(vm->flags & XE_VM_FLAG_MIGRATION))
-- 
2.44.0


