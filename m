Return-Path: <stable+bounces-152586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C964AD7EB7
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 01:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4DF3B4E92
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5EE2367A2;
	Thu, 12 Jun 2025 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4tFtxTh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAC192584
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749769337; cv=none; b=AYqrA56K1p2RR0zsUSiujhMaftodNEhA1q3qVsQgdXmwGaU6QnwAMZclC4cfKDnBXvz56AEp//FqfDvr2X6oXMA0QZPVjHJPiFmgoO6nYboGddsP1q29dmUJKMksmNu/uJbZIWj/B/77EMVp+hlzXP8TPS4jWla5BrkWgY1Nt6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749769337; c=relaxed/simple;
	bh=9bXotoJ7r/nWdmWsog0UFxDsx4Cv1O3I0LO1SAdWcek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAaCeJqUKtTb/pOUJXKT4pNrkCm7QnzILFsfKC5GKkTUvC/01q7nzIqrZ8Ts8u1rt6ghaCkyozVYec0IEi1a0XQ0al/b6sEqKSP4XBXZtLva+I6jYkXvztpNe5f2p2QS6JyN5erzyD2E5wp6yQWPe+oTOOJHrtFj8wCslSkhTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4tFtxTh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749769335; x=1781305335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9bXotoJ7r/nWdmWsog0UFxDsx4Cv1O3I0LO1SAdWcek=;
  b=D4tFtxThfQXqxioGQCki8DfLdcPfaSdZZDD96wLJOK8UB07yyYlEw0SL
   SVDPwFwk0pw/MrJpB3HMltxnXbNGZmJoO3EHo7X45EWO+DneU1a5dBf5h
   eMngHzCkHrBf4D7UTOrm/gq6cQQQU5AMk38uFkQDrllZOPsl9LK5TVfMd
   aRQKSslz468aOXAGxqAE+tUqkXNCWQhLOmA0gDsRiA+rPltUpoJzxocNO
   05EXsLZkErOhURy9+mVlFL3UBOKZioPVq89FPrxlVWfQN/y9cbEwIXXXp
   SPjrtcvNy7sNQGXHtUiPs3PxEyIewnqQH2eQlENKYUtWFlifGgb8lrcb5
   A==;
X-CSE-ConnectionGUID: fw3jUmT+Q/aqsxpsNpuUzw==
X-CSE-MsgGUID: n6AdJ0vFSNWs4zMkctcVjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="77372224"
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="77372224"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 16:02:14 -0700
X-CSE-ConnectionGUID: NUtFzj5gQCioh8rEV1/UHw==
X-CSE-MsgGUID: kGsGBqOYQGGRTb/GiqTK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="147644731"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 16:02:14 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-xe@lists.freedesktop.org,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Fix early wedge on GuC load failure
Date: Thu, 12 Jun 2025 16:02:01 -0700
Message-ID: <174976929754.4189033.9854520926726389395.b4-ty@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611214453.1159846-2-daniele.ceraolospurio@intel.com>
References: <20250611214453.1159846-2-daniele.ceraolospurio@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 11 Jun 2025 14:44:54 -0700, Daniele Ceraolo Spurio wrote:
> When the GuC fails to load we declare the device wedged. However, the
> very first GuC load attempt on GT0 (from xe_gt_init_hwconfig) is done
> before the GT1 GuC objects are initialized, so things go bad when the
> wedge code attempts to cleanup GT1. To fix this, check the initialization
> status in the functions called during wedge.
> 
> 
> [...]

Applied to drm-xe-next, thanks!

[1/1] drm/xe: Fix early wedge on GuC load failure
      commit: 0b93b7dcd9eb888a6ac7546560877705d4ad61bf

Best regards,
-- 
Lucas De Marchi


