Return-Path: <stable+bounces-106666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079BA00100
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 23:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9B7162FFA
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78A81B423C;
	Thu,  2 Jan 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIjKEZ0P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18821A8F8E
	for <stable@vger.kernel.org>; Thu,  2 Jan 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855526; cv=none; b=T0etGkzTKEb/HCCN3NgbHs3V4PIqH4CDvZdYtJ1WUfUqa5Vd5uFdu7U4cvukithnfX+TkbUyr6l2tDrfhaapKYy/E3nKzCL2zau5mulCrhPB2OJU0ITUhhFJP5PvR01PZ0JROVWV8VAknrS2L9HrpeQ/Aq4TE2Mj/4j3XQ+LDvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855526; c=relaxed/simple;
	bh=OIdTf/oMwvBm0dypgDZc9CH9XcIf8ulK+442afiVduo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nBFHRXReS4rMz7NP4W4u0JSNBcwIideGoxN89SvMIwENPNTcdFDwqadLk//zQjwnkzQluBTP8MpY/sdse0T9yCnNQOhj+zWA0vIMHEjCzHo0tDXD99cWBXh5qUzHyqFfG2hkdr1nngEtltSBgqXHUVS/LmOTNv5GDQ50PjtLUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIjKEZ0P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735855525; x=1767391525;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=OIdTf/oMwvBm0dypgDZc9CH9XcIf8ulK+442afiVduo=;
  b=PIjKEZ0PpH0GYeVUuAfjP+RhzkZHOORRPox8Kby8GvoUchVT0CIHxDol
   Ls3gq1IWiUBgbpdIz+KvE47yYSzxdQzn4SPlmpe0RuW3A203oX8gcyqhY
   v3xS5HG1RAvwRmys3mgMLVu+rFPYZRuDNoWc6Qe9eMJ/Yi4Ws0ngwPNQl
   yclOILooXR6p4XKqYKB7T6NKpgdC6SJCS/SPxsfj8zww7v57lIqvA3khy
   x1sgewtiyqsvvLm7Luflqf8BCR/AZJenUzKz9Z7hnDsLoeRPGblvU1Td5
   JZFE2C1zNII+vW8RfqSjGwl5bH6qJHEoT63WOOmv2Wa0dz9/wTErz4M4x
   Q==;
X-CSE-ConnectionGUID: EuowynBhTMaQdkAKu2arjA==
X-CSE-MsgGUID: esiSUdTMTWKJuO0GgfxnjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="61481634"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="61481634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 14:05:24 -0800
X-CSE-ConnectionGUID: 6jneRFoLTFmNTZe44SSMRA==
X-CSE-MsgGUID: p03XMMSTT5eWt49/MzzIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="132536537"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Jan 2025 14:05:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTTJh-0008uB-10;
	Thu, 02 Jan 2025 22:05:21 +0000
Date: Fri, 3 Jan 2025 06:04:27 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [for-linus][PATCH 1/2] fgraph: Add READ_ONCE() when accessing
 fgraph_array[]
Message-ID: <Z3cNawJpV5b4Ob8_@997da2bbb901>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102220309.941099662@goodmis.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [for-linus][PATCH 1/2] fgraph: Add READ_ONCE() when accessing fgraph_array[]
Link: https://lore.kernel.org/stable/20250102220309.941099662%40goodmis.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




