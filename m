Return-Path: <stable+bounces-87680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A749A9BA0
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0A0B22F8B
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A8154C12;
	Tue, 22 Oct 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FymKgYxp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61290152166
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583910; cv=none; b=kxsGUWbY/S305NL4rztRUnSs3+D02O8lHX3/dcPmokFvrE9Ya8ylrpBCQl8rarbq6sB5IYLWEbIURUXWl8zMexOLxvNvKV+BDvCht/ig7ielqvcH2EKNLqFlTy8GtD2AqIWScJ6Xj5OaAW68SCHn7CAb8dSvijkXOBGs9R85CuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583910; c=relaxed/simple;
	bh=YDkIn0fF7enEXZH3HdUmn9PRINtydm6kP/yjgieISjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erunh80FkqURkIsI9xkuBQ8iwEPRaFfGEspduqtdJupJot7f65SG0sIjmjn+HDRQ/Ux+l8ZsLNYeWZviw47YZQPHGv5RoKNgMYfn9bdsBg+6K8EVt/faETsQ8Rk42dJiH0H9Ke5IP6R1dUsIZRNjwqBfXcB0WNcpWqT6LkgUOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FymKgYxp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729583908; x=1761119908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YDkIn0fF7enEXZH3HdUmn9PRINtydm6kP/yjgieISjM=;
  b=FymKgYxpADxsyT/5E41BGEaZJAPj07YL6sgsFmhvkT/9d3hGT9+r7syd
   y/OT2khoyV7BFBagPIDjQsjWWzcqop6A3ZGE95P7/2UU+FtJ4B225W+Ao
   gWA3nf0qItbMY+twlg8+JJMsgIjvFTXqc1qM2mt1pCicxdpzcFqps8GIh
   sqYhr91xOCmtqVbM4L9qkR6+0cNWWLU8ulfsaXDoVB5uB7X70hxCBGsmL
   3K2VlNCY6GMnZY8Wlk1VZ+ejK/XoKaAr1HUN8EYjKvMoXu5yNn+45HkHt
   d6LiK1tkxy+7c3gNLOEc3MVuV+t+s39uHvL0Ael8xpxdGVuMhPmeZjvmM
   g==;
X-CSE-ConnectionGUID: 91863+BISdSetmfHnYlhcw==
X-CSE-MsgGUID: KywsXojLSfG9FS36WvQU0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="46587863"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="46587863"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:58:26 -0700
X-CSE-ConnectionGUID: sG50FaByR2627X/Ymt61YA==
X-CSE-MsgGUID: BSRNSw8WTiKTb8Y/KTqDoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79954768"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:58:24 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH stable-6.6.x 0/3] ASoC: SOF: ipc4-control: Support for Switch and Enum controls
Date: Tue, 22 Oct 2024 10:58:49 +0300
Message-ID: <20241022075852.21271-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a backport of [1] series for 6.6.x stable kernel.
It is fixing a user reported [2] NULL dereference kernel panic after
updating the SOF firmware and topology files.

While Meteor Lake is not supported by 6.6 kernel, users might need to be
able to use it as a jumping point to update the kernel to a version which
is supporting Meteor Lake (6.7+), a kernel panic should be avoided to
not block the transition.

[1] https://lore.kernel.org/alsa-devel/20230919103115.30783-1-peter.ujfalusi@linux.intel.com/
[2] https://github.com/thesofproject/sof/issues/9600

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: SOF: ipc4-topology: Add definition for generic switch/enum
    control
  ASoC: SOF: ipc4-control: Add support for ALSA switch control
  ASoC: SOF: ipc4-control: Add support for ALSA enum control

 sound/soc/sof/ipc4-control.c  | 175 +++++++++++++++++++++++++++++++++-
 sound/soc/sof/ipc4-topology.c |  49 +++++++++-
 sound/soc/sof/ipc4-topology.h |  19 +++-
 3 files changed, 237 insertions(+), 6 deletions(-)

-- 
2.47.0


