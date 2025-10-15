Return-Path: <stable+bounces-185762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0650CBDD6D4
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416301889E62
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571193019C4;
	Wed, 15 Oct 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HY54EBtl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB622F90D3;
	Wed, 15 Oct 2025 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517089; cv=none; b=ALh7qj8ffBfOOCF8sjW/u1404nnv73s/5eh/HXAyABSMEaRMKzaEuwQ9t/J2S7yyunsYvxeaLPoJRx6Pf2KOc68/iEZAM8S90YfTBDvIp/mL1QtcKCl/AjF/ZdJ5u/iX1UT9sU71QUbzXelh8ZnLvKCWHesr70d1MxSpGd1lwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517089; c=relaxed/simple;
	bh=Qc/r5ahK1h8+vrMxkj/owafUAze38x7Yv/AB5X/5ths=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ow5OucMkoRFYHnA5zVITpIYbmJL2qm6fz+iq2C/fKQj3XQ6IZXQCsx13u2RhGDvLxcTlxl11pHUEIfHRYbqv/EueynkGgvUIdS99FkFiWqugBYNknhn/kee66xDDLsddqcYZmIHO3nhmoIQWeFrKbYkTS6c+7FqJCdgQwuPeUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HY54EBtl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760517087; x=1792053087;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Qc/r5ahK1h8+vrMxkj/owafUAze38x7Yv/AB5X/5ths=;
  b=HY54EBtl11qJ9UZzc/gYI305P4SNFlF9qg07drHQLuSkRVEsqk/5Tjvk
   O88gIpu73dlStDjOV02KtyUH9DuWYUnQazoc2f2qQ7Gll0ByNH2P5VF7j
   ABYnQth//ZQf3zwSH0c3spcqUHuPfFPMumF0qtd8sF0BCr39XgPMSkxP5
   n+vnLCcHKtJ/Qgc9WFsMbiSm/VgmFhJxI1IYCB8bVA7Ky+18RsIPrWIuw
   9Pe5eI4XCSfCrCzmsY4RRON0y5Wwya1JUHB0gxxTnP3qcdNfm3Y+y0Ngc
   nBkQOnsNoiPRK/z8FXQgAPllmpljXyN/SJ0OVREUk/7TmY3KtXk2GtPYm
   A==;
X-CSE-ConnectionGUID: 8yMjHWOET4acdmCx0Zuanw==
X-CSE-MsgGUID: omxnCfxKT9WBnPut2WbMFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62578081"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62578081"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:31:25 -0700
X-CSE-ConnectionGUID: 5cujEUzNSVeL3apph9Fi+Q==
X-CSE-MsgGUID: fzbe/LX3TwmRZqwuMoI65g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="186122992"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:31:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gal Hammer <galhammer@gmail.com>
In-Reply-To: <20251014-sleep-fix-v3-1-b5cb58da4638@gmail.com>
References: <20251014-sleep-fix-v3-1-b5cb58da4638@gmail.com>
Subject: Re: [PATCH v3] platform/x86: alienware-wmi-wmax: Fix null pointer
 dereference in sleep handlers
Message-Id: <176051707669.2196.18094468031204884917.b4-ty@linux.intel.com>
Date: Wed, 15 Oct 2025 11:31:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 14 Oct 2025 05:07:27 -0500, Kurt Borja wrote:

> Devices without the AWCC interface don't initialize `awcc`. Add a check
> before dereferencing it in sleep handlers.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: alienware-wmi-wmax: Fix null pointer dereference in sleep handlers
      commit: a49c4d48c3b60926e6a8cec217bf95aa65388ecc

--
 i.


