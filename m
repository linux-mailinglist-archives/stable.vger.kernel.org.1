Return-Path: <stable+bounces-151998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADFFAD1956
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB693A9A6D
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33A281353;
	Mon,  9 Jun 2025 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLxVIuEj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595E280CD1;
	Mon,  9 Jun 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455562; cv=none; b=G2biuE4cw9A4wkAYja2BKQKVJ6RtbJstvpv1Q6cIX2SfPwJyU9lyBJdO2g+UgNs773DQhlOUqFOR4BMHqT6u8vHZJgW+H5iQzStPg+NEYc4z9xo5LUekJ4uEFIGVzqDSQlMWaFOZeO56eHpny3wNWL5iae06jWHyJWYENMyuOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455562; c=relaxed/simple;
	bh=IkiQA8mG2slR0j3r0Z++BM4voJUMrcSuWqIfqOH2mg4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=skb/IZkd7soGLz0ZGxC38101aBTclvZFf4QHXBHPgu4y5mwZFA33KyvSlovjyduN18rSTeiDG/zJ7Ys6KAbQe2RUBK1WhUfrRU3Fc/gltix5Or87ZwGiuseRcP1jJ7F200QilpXlXGWU5OnJpQml+nvIzLVDCQFXzT9DyBy3Kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLxVIuEj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749455561; x=1780991561;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=IkiQA8mG2slR0j3r0Z++BM4voJUMrcSuWqIfqOH2mg4=;
  b=kLxVIuEj4YwYZ49otSNuSYM2KdAt/paguicvgH3iNVjMvKkt5lh4HYCB
   1ao8mzQ0jlQ4n0/j8reAEsFTH3sI9uj1Ez9drAVihszzFhPDuVe4bRsrM
   KcJtmqNp+Eq1dgEeCMdvn5x68HaBpJVDqGCdaW9EHPfcXZXgbnMTfFqF6
   S4ppl0Rbb9yc7WY+PO1r+j8zHHEXQHI8qgBXUzo5ngS04SBFH6BsR09eo
   vX5g9LymVyv5HC3wn6mRY1AhsuBX0jtX9tOHl7NiYyuy5F16s2Ru6megU
   8vF13rqFWQ8NFTv/dCOMezyiDmv+WzkehezTUWup/VMR62K37UzFlMfjn
   Q==;
X-CSE-ConnectionGUID: CAAF4zfmTN6G7IRpXeYn3w==
X-CSE-MsgGUID: it3ICS7DTueJuwOgo/x4vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51669300"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="51669300"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 00:52:40 -0700
X-CSE-ConnectionGUID: NAXS59B8S1yeA/+TWC0mPA==
X-CSE-MsgGUID: thVK/7QqSWuKSD7zQw6TWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="147374750"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 00:52:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 Rong Zhang <i@rong.moe>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Eric Long <i@hack3r.moe>
In-Reply-To: <20250525201833.37939-1-i@rong.moe>
References: <20250525201833.37939-1-i@rong.moe>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: use usleep_range() for
 EC polling
Message-Id: <174945555231.2685.11066907868495600271.b4-ty@linux.intel.com>
Date: Mon, 09 Jun 2025 10:52:32 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 26 May 2025 04:18:07 +0800, Rong Zhang wrote:

> It was reported that ideapad-laptop sometimes causes some recent (since
> 2024) Lenovo ThinkBook models shut down when:
>  - suspending/resuming
>  - closing/opening the lid
>  - (dis)connecting a charger
>  - reading/writing some sysfs properties, e.g., fan_mode, touchpad
>  - pressing down some Fn keys, e.g., Brightness Up/Down (Fn+F5/F6)
>  - (seldom) loading the kmod
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ideapad-laptop: use usleep_range() for EC polling
      commit: 5808c34216954cd832bd4b8bc52dfa287049122b

--
 i.


