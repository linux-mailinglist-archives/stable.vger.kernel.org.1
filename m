Return-Path: <stable+bounces-159210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE02AF0EBE
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 11:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1783BBDA9
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D50C2367C3;
	Wed,  2 Jul 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUJgvhw4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C91F7569;
	Wed,  2 Jul 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446925; cv=none; b=MRowbUA9S+dTEhFiCG/ZuzzYBM2amAq3ucLZLMmVSKSvqBlLMy+A9o0EOGo+oLV79kElVZvN+MrXslBuP2swa2x6azBe7s7SCDYPHFqXVkh9kjqY/+tH4MzNKr6HEwPvS2M1xh/tpZWQgHQTDnsp+GVnRkW7bbX4xmSmT1Tr2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446925; c=relaxed/simple;
	bh=dVN7LRamAB9cwP9nwfv1OV0vvgLCmi985U/7q4xxfY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mIvSYN55OkciCHyZ8Wy46CUai4ucTzXNwmwCWyWQjLztzHGjMaDszWf9Jd7myV20ukkF/C1BtA6w04loxfQB5At3oiwQxn9yEiPipBx+Vs8U8TTvGKk5qPOCnQnmTMTKnYKWEhWCjgqkd0LcNRe9hSQoRZk2XZc96F6ArAn22OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUJgvhw4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751446924; x=1782982924;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=dVN7LRamAB9cwP9nwfv1OV0vvgLCmi985U/7q4xxfY8=;
  b=VUJgvhw4yItY9nNjkCvQplarAZXHu8MeLNy04dzG9S61kkGWsuShUljT
   I5SQQk67TB8YsdA6rlU39w5DaykZlELKx6nDeC1PFc/rPUBbq8HUKM9ak
   CRd8k1zDNL7MczfMrTCPkcxU/8mS5xJTnYCYfhgj+BdQhARZ+PQmU/XyJ
   zKTGddYntd3/0YvvrgrMtcQNtkGgYiMlj4r1kj9LaIaKV/zBI0FD7dxWk
   6Ns/dUNypvrt34qMFbDIJZ82Ro+I45ibSSbRmDuBkEOg2tVVEF/5jpCfO
   5WOSHLzA/5Sz2bIv+jrsPFhGWxBRh/y0LtE69bjoXUWxf0i3FZiVncT1D
   Q==;
X-CSE-ConnectionGUID: IoIkOKU8Qay98rEXzASslw==
X-CSE-MsgGUID: t0dnFwcFRKmg4CFNoxFIJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64780042"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64780042"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:02:04 -0700
X-CSE-ConnectionGUID: 4KAkIXN0TIajIqfzY0a4dA==
X-CSE-MsgGUID: kZf+UOuOR+uCPj7GkVGMaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154171081"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.228])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:02:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 Hans de Goede <hansg@kernel.org>, Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
References: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
Subject: Re: [PATCH v3 0/3] platform/x86: think-lmi: Fix resource cleanup
 flaws
Message-Id: <175144691633.2264.11381075609618544066.b4-ty@linux.intel.com>
Date: Wed, 02 Jul 2025 12:01:56 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 30 Jun 2025 14:31:18 -0300, Kurt Borja wrote:

> First patch is a prerequisite in order to avoid NULL pointer
> dereferences in error paths. Then two fixes follow.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86: think-lmi: Create ksets consecutively
      commit: 8dab34ca77293b409c3223636dde915a22656748
[2/3] platform/x86: think-lmi: Fix kobject cleanup
      commit: 9110056fe10b0519529bdbbac37311a5037ea0c2
[3/3] platform/x86: think-lmi: Fix sysfs group cleanup
      commit: 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a

--
 i.


