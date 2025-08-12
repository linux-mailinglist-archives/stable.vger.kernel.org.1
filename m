Return-Path: <stable+bounces-167153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93BB226C0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C373B845D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AAA1E5B7B;
	Tue, 12 Aug 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzilRiWk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A671DD9AD;
	Tue, 12 Aug 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001736; cv=none; b=C2nAPu/vh+uEZZNy45dgPsY6xTUTtmxf1JYccAPd4iucX/897u/bpAiDbSbFSKpofNe9zEYPe6Nl4ZUrG8eaedO5t9IRfjoWlW8+HlV5sX6iBVDDY4i39NBHf9AmqFXx+iWxENV3SpVI94te7m+z7XgUyUOde3bfS0qJGXLthh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001736; c=relaxed/simple;
	bh=Do8TP74zsTocFwZxbJEBG/WGS4Ap/H1rqwzrryCxk28=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sVIqbPxFNLmxe4OJeLWmzyOs7MCRKbdyhxY+hd5/YneegYcU9ff4oM5pDaolcdJNeQGU/edj+DIzhLlpAnsB691+93wzIR9G/O7lMEmTeR+BRIWlWbru3EiICdJiK3TISxuPwae8R1bKthTTQLHVebqo58rkdxdrRxIVLtGszNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzilRiWk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755001735; x=1786537735;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Do8TP74zsTocFwZxbJEBG/WGS4Ap/H1rqwzrryCxk28=;
  b=KzilRiWkn1z3fw6QbhvtU5gdvRcX6cdjl+o/oJEXyJc5KzAQt+/ee61m
   usbTuI1Oq66k/wzRldlKVgsp3jGgS/G9WvqQBPD0eCLePr3b4BCMxD1gB
   5cRdUx2No5XdjHVEDFovQny2YndJA155zwbbGjm7/HlZ52iQjSV92n5Ts
   BP9gBiSor6SZWyB3blErKxQtSmApXtnLXMSGppn3PcbARAi82mazCr9d5
   Gx8eYQfVGZM+5IydOKA3puAl6snGiJcHHp2dosiabu1BXdL1gDx8p9r0a
   R6fJknNz6E1k1ee9AoSyskaSly2WmuaVGfGsUk7E12OQyJJpsPAgIAuR7
   A==;
X-CSE-ConnectionGUID: aKKKYWnXSVilGyCMYPIDXQ==
X-CSE-MsgGUID: WxPsfgt1Q6yVs4kGepZuCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68648809"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68648809"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 05:28:54 -0700
X-CSE-ConnectionGUID: q3oNydLhQ2S2V0cR6oMVUg==
X-CSE-MsgGUID: ve+5hnwrTjiuylti3+WO+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166472045"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 05:28:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250727210513.2898630-1-srinivas.pandruvada@linux.intel.com>
References: <20250727210513.2898630-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Check write blocked
 for ELC
Message-Id: <175500172739.2252.7473012408128770590.b4-ty@linux.intel.com>
Date: Tue, 12 Aug 2025 15:28:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 27 Jul 2025 14:05:13 -0700, Srinivas Pandruvada wrote:

> Add the missing write_blocked check for updating sysfs related to uncore
> efficiency latency control (ELC). If write operation is blocked return
> error.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Check write blocked for ELC
      commit: dff6f36878799a5ffabd15336ce993dc737374dc

--
 i.


