Return-Path: <stable+bounces-60375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9F9335E9
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 05:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD3028210A
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 03:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AE524F;
	Wed, 17 Jul 2024 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTV6lJaV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BD566A
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188721; cv=none; b=YBRTeQ3PHUwM77FHmkYSb99zUQqW9Ru3lgRJn424RrKI4cc4VuIbNmwggiyPLL8DAkF8KnSRpJjpqt2q7w/0U8wszUwEiZnFw3bXTnp2TJtlWxLPL5+kogL1Lr0r/j2Z9wWOS685S/XIZPFCeTAfmbbO95PdKGCgUQr+ZtVUmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188721; c=relaxed/simple;
	bh=iwWtonxYzuOhpYZKeoBBdMSWhddwnOSCDRCqq1RDEWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PSxlme2To8EXeq9Q2cE4O7Xq9zcvqsYNIaTDm+pzO/IzwiT4kNi42WK90D90rV/UaJB1ZeqpStNw41ydBJz4HlG9IdQkynv+h2d45ZRcFgJhOAtmFD7EZrx1E6Czq1Fjtyqa2sX22OcNxyNH/ANbSFHcGgF75z+GbNfNdRzs3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTV6lJaV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721188720; x=1752724720;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=iwWtonxYzuOhpYZKeoBBdMSWhddwnOSCDRCqq1RDEWk=;
  b=cTV6lJaVxJ1oD+VHXfhFYwZo05ldcv43B3esw2fyUwTncc0qOt5hYgJa
   a/UWbWcqv9y3AfUHEFBESj2dsK+/8N6mpCwDM+6QyzrqYILJc+H1To1d5
   S+HymIgNbwIU9mD33Z/krTZHRV7TbQTmSew64FMdcvkqhhTUZBMHrtVKU
   B2Hci5l65SyIA738Mn6STsWMuYVmj35H2Kbykv1V1kE7OuYJ8cHyia967
   ETUjG4LlaHQv00Th8EhECLmbwApzQx5QJnoL+h7XZuawJkQufsqh/5CDb
   i27EhaylLIjyM4r2rC9Tx85/IN7qoOZnZnFSmZAmPcqsmtOH5aTXsQpj5
   w==;
X-CSE-ConnectionGUID: TWkOgOSCQlybvHszXsFhFw==
X-CSE-MsgGUID: qbTfCzf+RpCZpHlNUEf7BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18513631"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="18513631"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 20:58:39 -0700
X-CSE-ConnectionGUID: AsEcgNBsSeOp7Y+orr9U9w==
X-CSE-MsgGUID: 7qRmFMxuTO2+wozxSDDVIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="50178371"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 16 Jul 2024 20:58:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTvoJ-000fx2-2e;
	Wed, 17 Jul 2024 03:58:35 +0000
Date: Wed, 17 Jul 2024 11:58:21 +0800
From: kernel test robot <lkp@intel.com>
To: George Kennedy <george.kennedy@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] serial: core: check uartclk for zero to avoid divide by
 zero
Message-ID: <ZpdBXR-IfbNmFmUl@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721148848-9784-1-git-send-email-george.kennedy@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] serial: core: check uartclk for zero to avoid divide by zero
Link: https://lore.kernel.org/stable/1721148848-9784-1-git-send-email-george.kennedy%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




