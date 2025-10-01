Return-Path: <stable+bounces-182960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB86BB0F64
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4514C7D10
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4531DD9AD;
	Wed,  1 Oct 2025 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngL55oMb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EC274B2B
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330875; cv=none; b=jO5KkpAi/ZzkqtCuuv2OSWpMxfhiAjczXwHeQxL0Fh4J57P1Wfs/xjoZnNJkkKuoKopV1/m1AqNgo6/KojgA1eArVl9Jv+6+sMXM6rA9TRsYWlgGp6ccRvEm3Ws/joy5MxrJcWbM4FypQRwUi92F4kVoCgCVemP4y5g0Hic9uF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330875; c=relaxed/simple;
	bh=AJUBybfoJHAkwjyqZioRdryCnb7qBixUgcJAiZUvD04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bqySnTVvKdFXyeu8JlxkfmnhLFg7oltsEC+v8DKXtwsb+5uIAT3rQN169bKCQNGsvb+jCJJuTlstDG7vW3gMlcfBffE0VoQ4V0m+vbmSG8+nXmdv0jbrNpVmZPLvmce6ug+NUOxIu0jj8X4jmVY4gvha0DZxRRZgF/qLyxo22jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngL55oMb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759330874; x=1790866874;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=AJUBybfoJHAkwjyqZioRdryCnb7qBixUgcJAiZUvD04=;
  b=ngL55oMbbw1gDy+6qwtaZ7fTlX6KX1klLc0YIx3q8j/9oy1E2t2jBFEU
   hQkrqZbwGwT2E+tRZUP7NLdJb3gm5Pm/z/KYqAIGUfptrInECNiJzD9e+
   EHdqpYluMRznxMItjy6Ufmx006xVBN18fx1MfgvdrqTi8Gt2sya5iPC2b
   lG7C3h9ptVxaGJwfwNJdC5I90Xveiim7p/D0d9pmyXzY0NGr51AjmpW6r
   T6NcSy29DGXfLuIpmaOkvZmgHmCzLMRF93Pi44sa/Z8Xi0qu4ESNwMQCw
   CpSFwlKUh/9tLPAIE1BbEz6JNVO7KPnE1z2PRcdb6qMTwGNFe5cVUXccY
   Q==;
X-CSE-ConnectionGUID: GVG0O+pXRyK5oVNbS00fAw==
X-CSE-MsgGUID: HcFySMr1RDa3GhTzP1Nubw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79028521"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="79028521"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 08:01:14 -0700
X-CSE-ConnectionGUID: Q1ESADMrT9i/JW2oUpAEVw==
X-CSE-MsgGUID: nSg5cRdiS5W6+uV0Q1KiFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178420274"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 Oct 2025 08:01:13 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3yKM-000379-1U;
	Wed, 01 Oct 2025 15:01:10 +0000
Date: Wed, 1 Oct 2025 23:00:34 +0800
From: kernel test robot <lkp@intel.com>
To: xu.xin16@zte.com.cn
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH linux-next 1/2] tools: add ksm-utils tools
Message-ID: <aN1CEh_NQeBBr5Oj@6acc96db341b>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510012258194755dOoRXl-9afv5zIk0QwO_@zte.com.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH linux-next 1/2] tools: add ksm-utils tools
Link: https://lore.kernel.org/stable/202510012258194755dOoRXl-9afv5zIk0QwO_%40zte.com.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




