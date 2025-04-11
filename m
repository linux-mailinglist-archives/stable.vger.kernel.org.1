Return-Path: <stable+bounces-132222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C4A85920
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 12:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F703173678
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576DC1F09AA;
	Fri, 11 Apr 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNaEj7OZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006E29AB0F;
	Fri, 11 Apr 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365799; cv=none; b=SfSlDSbCa+YuqUWNEref0r+uBso04JxZq89ekhhksra0GyteRgUNuFRaMteOIj8QrK8Oqc3v3F2E3PhEaxiwuec0Kssdpv8YlmtBNAJdA9fPEc2yOyXfcmKwB5QLWDmqJBpY/Bps1ORUOH24Ya2fVOB2AJwuFf8c9RReU1IO/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365799; c=relaxed/simple;
	bh=G0ccYDcVmNaW4i7jQrUQm2ImT7AM3+xsmhVnz88nrm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sLGIwCoCB3c69ospAj9zPzmFM62oVorsn6hwH9inTDNtTi8lWahQVVMTdAWBotRokVevpzghJmFkSGNHVI1sWH6QexTn2o57ev1apxuySYjrwbeOtNZ68McmU+pkrRi4BwqRgsLxeXds5pWftzGg7q5SEatqZuxfHmhrNn9fbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNaEj7OZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744365798; x=1775901798;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=G0ccYDcVmNaW4i7jQrUQm2ImT7AM3+xsmhVnz88nrm4=;
  b=QNaEj7OZZJtW4lTrphZPVa4UG5zSfipC0yIRDg0jedz7PrMrDF/fZUAF
   ZoO8DKYzRRpe9Z5CUrtR1XNPbiO34pW9D1AxsK5uIX/MSwnXczgJmvi6t
   wVmZbEYbKjPt9V0+R9YNZlPoTfNkWinUF5v7kl2bq7v8kJMKw+UVGgTQv
   4N8OqWzqkmdYvuvMWZs0mxSfqGbznRqzMjcANJ8/fGjQDKhvhkbt647Jg
   nJJVFyqW7+8Q5+pL/C1EPGpyhW30BTYqAcK4p+/Kq1NJd534YGMzqef95
   L/9SGC0bLynLM2vlEW4l5w9FwjTOD9MR7Ddesv8anIo0IQQayiBMOo8gV
   Q==;
X-CSE-ConnectionGUID: 1iSqPBNQS9iUVIXkeTQVag==
X-CSE-MsgGUID: vcGiFadwSEKskU5QW1TRww==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="68399677"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="68399677"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 03:03:17 -0700
X-CSE-ConnectionGUID: popynGDlS3CoInAuACFg+w==
X-CSE-MsgGUID: /b4cKC+mR+mwwXJ941XPig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="134136122"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 03:03:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Corentin Chary <corentin.chary@gmail.com>, 
 Denis Arefev <arefev@swemel.ru>
Cc: "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, stable@vger.kernel.org
In-Reply-To: <20250403122603.18172-1-arefev@swemel.ru>
References: <20250403122603.18172-1-arefev@swemel.ru>
Subject: Re: [PATCH v2] asus-laptop: Fix an uninitialized variable
Message-Id: <174436578937.2374.8623940315358740853.b4-ty@linux.intel.com>
Date: Fri, 11 Apr 2025 13:03:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 03 Apr 2025 15:26:01 +0300, Denis Arefev wrote:

> The value returned by acpi_evaluate_integer() is not checked,
> but the result is not always successful, so it is necessary to
> add a check of the returned value.
> 
> If the result remains negative during three iterations of the loop,
> then the uninitialized variable 'val' will be used in the clamp_val()
> macro, so it must be initialized with the current value of the 'curr'
> variable.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] asus-laptop: Fix an uninitialized variable
      commit: 6c683c6887e4addcd6bd1ddce08cafccb0a21e32

--
 i.


