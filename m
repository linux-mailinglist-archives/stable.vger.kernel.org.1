Return-Path: <stable+bounces-87712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77C9AA12E
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 13:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643501F233DF
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9619AD73;
	Tue, 22 Oct 2024 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRV6WAyl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075C199FDE;
	Tue, 22 Oct 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596717; cv=none; b=d8rBhadUCnfkQ5pJToNCfYpGSXWZbiTxlFb3LQsKXMu52Y+jqmOA4yO1hvvCtqZENvLBkEQLZTejDO6ReVTXU0IH88f6fOOvD4E3J173KU0B0ITpXv7FR/DjXAYmJxPS5mPK3cULNoHGMaXDcXMqvBNDLPbPGLD/bWfSeCVYX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596717; c=relaxed/simple;
	bh=Wiu8jpqlvHopEX0zCMI49sswBg5XfxfY0ixLSvxZcho=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kVpIPEOB4zii6mL4Fz+ukyC7VBTgFfzbn2gFonsgrNtFteGezLIT4fDi/aqwnRjje55kSIrkIYflWEBkhm9s8+cL9aLiqk9YbdjHToKxmWyA0kEntcldcfetuhMFBz3cDxs90gEbk8pJmoGenRMUQuaZgsZowu59XjCxu8kPW8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRV6WAyl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729596716; x=1761132716;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=Wiu8jpqlvHopEX0zCMI49sswBg5XfxfY0ixLSvxZcho=;
  b=gRV6WAyl8sNPYhHEGRbWTG/9E1ZCQ340rUpahuaW5GfoowmWXH9cb8O2
   +N1QY4tGSUJNpEuJSdhWUjyqEqXL+4dFM6PgDBEblgniySBnzCc93h0gx
   joiL06m3a6ZdHMfOpBtJnysIpAputxs4t2+SOcYC0guH3nw7SB8EKzw1o
   /rJ+l3nMzYNcMFJU8e6MUJrtJ17uNi64o+LVVQPaDTP7NgRQbxbtJbMqT
   6f4Gc7rOEQzSklqaLQ8n2n/0DunGonnAfLJc3KN5mJBOnFjORedsY+3z/
   UGO2QKdUyhQ1v+MLx5NNHho3UvlC7TraTv50VLe6dV5OjT7AXrEjgxE6T
   A==;
X-CSE-ConnectionGUID: FSzmmSBBQzqGJhve+2XkkA==
X-CSE-MsgGUID: a41vnFv1QImCBlrqzl9/gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="16754526"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="16754526"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 04:31:55 -0700
X-CSE-ConnectionGUID: q8dbIADNQwSPzZjZVEEqjA==
X-CSE-MsgGUID: fckb5dgSSF+8yqQEP1YdSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79756833"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.247.108.13]) ([10.247.108.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 04:31:53 -0700
Message-ID: <448a5371-75d5-4016-9e6d-d54252c792b4@linux.intel.com>
Date: Tue, 22 Oct 2024 19:31:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 mstrozek@opensource.cirrus.com, gregkh@linuxfoundation.org,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, bard.liao@intel.com
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
Subject: Request to backport "ASoC: Intel: mtl-match: Add cs42l43_l0
 cs35l56_l23 for MTL"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

commit 84b22af29ff6 ("ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23
for MTL") upstream.

The commit added cs42l43 on SoundWire link 0 and cs35l56 on SoundWire
link 2 and 3 configuration support on Intel Meteor Lake support. Audio
will not work without this commit if the laptop use the given audio
configuration.

I wish this commit can be applied to kernel 6.8.

It can be applied and built cleanly on it.

Thanks,
Bard

