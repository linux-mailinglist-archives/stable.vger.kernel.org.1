Return-Path: <stable+bounces-132093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE5A84372
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD71B8207D
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA743284B4B;
	Thu, 10 Apr 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxpuVsAG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB203284B53;
	Thu, 10 Apr 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288749; cv=none; b=leSZl57ZzKkOro1NDdnkTuu8hnviNrHC5myOWokCIGWF5SFwms83dROdkJJu3u4WjHqQq30jny2AxLtisAH7iUk3nn87ojeL/ly/WXdVgnD0Yt1khr7FDm+zL8jJJQfSh6HaSWpCAoaUe8iK9kcodPxPjAIlg7ZB3ipTRzZzZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288749; c=relaxed/simple;
	bh=D5YjB2GVpRrw1ZnkCsESEUxsq+inna4uxA4zu0NDiZ8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=R+J792FLvROPwjEQqt5Fd8pxG62l0jJYkbcBVTbm5jZcQqgN1yQFHrWgYLheB8Id59RwCYTp+ojvvw0ezC7w4eip2ILa3XvbktNfJNEraGXrU/JbCXpjMGSKyZb64W+6alFyV8AlbtaeDv+rIINz28jm0f/uvQKJ7IQQHCBMauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxpuVsAG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744288748; x=1775824748;
  h=message-id:date:mime-version:to:from:subject:cc:
   content-transfer-encoding;
  bh=D5YjB2GVpRrw1ZnkCsESEUxsq+inna4uxA4zu0NDiZ8=;
  b=cxpuVsAGLRmCeldyNdMCPqe3zXgey7LMwSO6KDi0RB5/ugFUeYVWgaHH
   9efizGLlfZpSlMpjn4RJGTE7Nv3CJJx1q4aX6ypHjBPiTh4axQi4Wnx8i
   +i52Mnzl/AqoyhaTBo+fho7ABMyUHeXklHpxEyNqJpeASqWp2k9akTzaX
   v8HT7of8Cg8rZ0GG2KTpxZsN53lj9Ajnt9Q4t5VfvF7AGOvyPvDw8l+ef
   0lNp7Pthqzc3C6s4Z+mibAO71TLTn7PlQjO/allPMXlNdAmLnnDTwQwaH
   3JLMt7S8H2kXpWn4EBKsgjkI+rvJbzLnajv4yQyjGbWCRDZkOZXp7kbOw
   w==;
X-CSE-ConnectionGUID: LA+5tp3WR12TD0RHj2eSMw==
X-CSE-MsgGUID: IIKSn8lAS26jdS8BZtHlPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56472873"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56472873"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:39:06 -0700
X-CSE-ConnectionGUID: Aw12CSFOQyuKX6n0SyxQWw==
X-CSE-MsgGUID: wf8Wls4YT1qblH5QYpjKsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129836093"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.248.114]) ([10.245.248.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:39:03 -0700
Message-ID: <1e160cc3-8fc5-4fc7-992e-b24980c55c47@linux.intel.com>
Date: Thu, 10 Apr 2025 15:40:01 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Subject: [6.12 LTS / 6.14 stable] Lenovo X1 Fold 16 Gen 1 audio support
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, "Vehmanen, Kai" <kai.vehmanen@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I would like to request a backport of
8b36447c9ae1 ("ASoC: Intel: adl: add 2xrt1316 audio configuration")

to 6.12 LTS and 6.14 stable kernel as we have at least one affected user:
https://github.com/thesofproject/linux/issues/5274

The topology file has been already released.

Thanks,
Péter


