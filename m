Return-Path: <stable+bounces-132372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DDFA875EC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 04:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8771A167CC0
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 02:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311D18C91F;
	Mon, 14 Apr 2025 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdWBeJgk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4674430
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599272; cv=none; b=O5zEArswDsZh806RY0KcIsiN844al2tjn7lTa6d6rxqCkRLXuQDD4uJy917LDW2/MAuapFRTJFGi69tHW82tYovo+QE0ANTPYaQt+sbrOrEzxoVRqA72Jw1P9hiW4CmjvLEu7mUwlnQLLe4OhyPuuzMPoWBu1bWwRC2DnYREDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599272; c=relaxed/simple;
	bh=iUAHst3zI6fEf7PtpM5r+6Q34eoySQdVHpTtIfkQwcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjEp9uLFO+hXszzojYq7kcHR4dIbA1TO0icekQE4tCpbqSXqJFbM1T3rNs3xmEJctZfjxuxZMCsX6sx/u2+FkracJ2LRcEYwFWkjEviUyokuAEZP9+9tCm8PMbBV1bqHT6R1o+RtC9iCabjJyrNBb89LxbgOr4JPeD/thKokWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdWBeJgk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744599270; x=1776135270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iUAHst3zI6fEf7PtpM5r+6Q34eoySQdVHpTtIfkQwcg=;
  b=KdWBeJgk31qhTKKQExgPjRdghujl52wGb7/30rABM+RPEUJ8rGvRhBQu
   Ob/j+xeO0K+cIO26ONVPkTkxO4GBTsbcKj7O2kqJMzpjkt/PaTvxepVey
   784BV01kcuqnxfCIzS27QXao/yx4xcwSoOrZAbAMBjGxHi/kPzKIIUnc5
   zyloYjhMIeFRnSms8xZKluYyuEUZ7kBe/xRPNp41CvOjUHeag6ZdbcpOl
   iEkz0r3rT6Qj83t8FUiv0u4a7pvIPsb4ciW1DRgm9fG0qwhueU59mG0Eh
   +AAz5BAi9bz6jFrB8v1Var7bDXqwkUNVNC2vgT69wfLfSOSEpieFt8lCR
   Q==;
X-CSE-ConnectionGUID: IDfmUPCRSLqBkzMb719QzA==
X-CSE-MsgGUID: pQeNZe6ARt2Dw6t4w034Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46189562"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46189562"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 19:54:29 -0700
X-CSE-ConnectionGUID: 31aSWBO1QjayrxyaezRigQ==
X-CSE-MsgGUID: +Qw0VttASQCth+FLqF5yEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130016209"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 19:54:27 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: suraj.kandpal@intel.com,
	stable@vger.kernel.org,
	ankit.k.nautiyal@intel.com
Subject: [PATCH 0/2] Macro for 3 DSC engines per pipe
Date: Mon, 14 Apr 2025 08:12:54 +0530
Message-ID: <20250414024256.2782702-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3 DSC engines are supported only for BMG to be used in specific cases
where 12 DSC slices might be required.
Add macro for the same and use that while configuring DSC slices.

Ankit Nautiyal (2):
  drm/i915/display: Add macro for checking 3 DSC engines
  drm/i915/dp: Check for HAS_DSC_3ENGINES while configuring DSC slices

 drivers/gpu/drm/i915/display/intel_display_device.h | 1 +
 drivers/gpu/drm/i915/display/intel_dp.c             | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.34.1


