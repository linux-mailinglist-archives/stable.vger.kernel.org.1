Return-Path: <stable+bounces-179736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D542B599B5
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 16:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BA71887DF4
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0A3680A9;
	Tue, 16 Sep 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILKVhXbj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5903629A4
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032053; cv=none; b=Y47gv5nLWNDN+csgcMuYnVCbf3tXTg3sZmXI5C126Lj/MIxznsCkdI3VTWrtB/AvuLJKBRqyNSGmCXVUKnGuZvsy6YaTJLURHNAKP5hmsvXJemZCf2fDtsRHzfSjMHDLxsjiM0rQ64K+jH23B23MpnPb8PEZGCIShv9YhnSffNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032053; c=relaxed/simple;
	bh=Zbsdt50Z5fsETLQG+p3y3hX4Pal2szzPL6rZG5xWQTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OxUCkdbey+9XM1Sm+kQDy6GGuSP7hPY5nUXCGvD7QvwS/I6F4tsfgPD8ALnhJl7Q3j/CnypMJd3w5XuXavNf8Ht48Up6HZERbHgNXNrb9nsT/NzWAqwhd1k+KbLViYsfSxvQPdk0HVZjsvo6pdocFQPQTspv5l5cWWJgCfonxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILKVhXbj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758032052; x=1789568052;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Zbsdt50Z5fsETLQG+p3y3hX4Pal2szzPL6rZG5xWQTg=;
  b=ILKVhXbjudszXrQVw0i5KZ2HDT9F3GuNLmzP698jzk/9G5ZHVwGKjd/4
   h81rwgTjLrYtYSjp1YSbGcHKmfzTLZOWARwOigwU7f66a4TIIJaUZZspa
   jemDAigbDOD4aao5sbFlpc5xGmXN8KLYLscAEKyyOt0y2SUzc96PsCTOu
   Jc05dupN2imuNnAqzxWi1uZcYkZX1DHHAZ/35/+WYIkbyEn2+FRCeuw3I
   7NejQ6pR0HiVSmEe+vFeCG+htaEzAAvJ6NzApxGF7KC3lhTVZZH5oGqxJ
   P6rfGbqQEFjtjWjy6tIaFM7xY6n8ixuoEOj654g993KF4AwfhSV7muJjr
   A==;
X-CSE-ConnectionGUID: 3WXpHU2fSMuEuo8sufh4Tw==
X-CSE-MsgGUID: uOPvP2C0SIKBJh6JQm4itQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="63946121"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="63946121"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 07:14:11 -0700
X-CSE-ConnectionGUID: Ic5TUWBuQMaDXpb3ttM06g==
X-CSE-MsgGUID: aPGyoomBRXe8RcweihIGXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174242137"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Sep 2025 07:14:10 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyWRb-0000M3-0c;
	Tue, 16 Sep 2025 14:14:07 +0000
Date: Tue, 16 Sep 2025 22:14:04 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v12] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <aMlwrKpOpTE1WLNm@65c3091165ef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916140259.400285-1-quic_shuaz@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v12] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw
Link: https://lore.kernel.org/stable/20250916140259.400285-1-quic_shuaz%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




