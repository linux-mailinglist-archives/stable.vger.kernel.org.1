Return-Path: <stable+bounces-124783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CAA671E1
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85666188CD85
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F002080C3;
	Tue, 18 Mar 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERUWZcOm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D91DD0C7
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295282; cv=none; b=RIvinJdTKh9doPg9Kv1t5KiJVyXUfIB9dV7GSxTP2dKDeg/QA3GM+krvSgqGRFqMRgsg3/OZ8kQTVHdq3jf09jPgDupHf4hqTekBk8SzaIGC4grRUmGKdas6k67cLD/q9wfs5jku7eYXdefu+nb/+o6yBJmIh+MyDCMn0D0esg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295282; c=relaxed/simple;
	bh=5LpKca33RLGCQwAhD/QZ8uRwS3m9ZK5bFbDXfa5vfow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OauIOo08kGi6yJZkOUdTfZm+IF7OnpmSm1PT15+T/7AbVkP/BwcuSIGbXNq+YWl9AiCk3IJ6OxzKNKxLibd4ns8P3zSW5YGzyYKKYkbiuew6nFLRyC+2axN6l+o0zQHOZ3zv6R7BJkrIGdzh5IA4J/va/ipu85E+cOEwoxXGYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERUWZcOm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742295280; x=1773831280;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=5LpKca33RLGCQwAhD/QZ8uRwS3m9ZK5bFbDXfa5vfow=;
  b=ERUWZcOmxZFm9ln6XN0yMkQUfIMMxur2rQADQk9Y9HQY7QnKDKEgRAe4
   PNPM9IlGeki15CZCWpjU2RnmJ9K4oEYe4QEcxuGjAwZTnKpej/vNZcbgt
   uPCEJ0sckIcX+4KKsZhWiUedpEOAbCuB8uH++CG438qayAGWoAq8umocE
   Z3DGa/9Rx/VFjTFpHpROXdTABAHjid6udmwSp3foqCv/p7dIBZY/9LNVB
   rhzHpwgSxTQzQAE/gEmOWnilIvWw1KmUuqm6WjzOrVoZ3UhB+2nT9zcln
   hz6uil36P3I6hYdOwj4H1kWyRN6/HO9LjI1RW6wIeAOhGaIAX8GyqQYMg
   w==;
X-CSE-ConnectionGUID: BPcEv04RQ0SZA1yZ4dVUGQ==
X-CSE-MsgGUID: Qnj264j7TquadtKvoq2Ekg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43445171"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43445171"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 03:54:39 -0700
X-CSE-ConnectionGUID: UeesAAtKR3+snJU02WPO9g==
X-CSE-MsgGUID: 5487H3JfSrKDHOwHRasahA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122985668"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 18 Mar 2025 03:54:38 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuUai-000DgN-0z;
	Tue, 18 Mar 2025 10:54:36 +0000
Date: Tue, 18 Mar 2025 18:54:35 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1&6.6 1/3] sign-file,extract-cert: move common SSL
 helper functions to a header
Message-ID: <Z9lQ6yCAzqvd7g1x@4d9b5d180ac0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318105308.2160738-2-chenhuacai@loongson.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1&6.6 1/3] sign-file,extract-cert: move common SSL helper functions to a header
Link: https://lore.kernel.org/stable/20250318105308.2160738-2-chenhuacai%40loongson.cn

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




