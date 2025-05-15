Return-Path: <stable+bounces-144518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49DAB8558
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDBE18905EC
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0A029899A;
	Thu, 15 May 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bg9ADbY5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82620FA81;
	Thu, 15 May 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309958; cv=none; b=XdnVoi8yAVTDTdFjxqcuOStNBzdpMj+xRqpD3EWBDH2DlVa4KsBAuXAaWqEmM6dxk/xyC9y3j+vmPTfmWAX8OT3uQAaB6rhD6wG3P2Rbt/QEge9qEiY34MCyvVWP9LsQTEEWiQSYjvc/UR0cwuoTBwzI5Z3PR3Eprshpkjg43Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309958; c=relaxed/simple;
	bh=5n4gJIRJlJ40Aio9mAK8B0h/tvNUDSce7R7LVly6O/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FWsU1hTpD9Qvahs95zFB6IYHe7EXEu7mXv3EoEwYrzUj1HCwR9NOMy7sOGM5BQ4EHWyDNKAg6dSKIlpNtb0aar3d5WYM2Fq79Xfq/qJY5qYcxt5+1DAjaZuBoU+oEfS/69OEI7q+uIsst0s02OLAOACO9Hyu85tZq8VPgyZIgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bg9ADbY5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747309957; x=1778845957;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=5n4gJIRJlJ40Aio9mAK8B0h/tvNUDSce7R7LVly6O/E=;
  b=bg9ADbY5dooGrTiRuimfbBRU1I7PhId1IS3quDd/caeVozhHHwWGd3Kt
   XYu+xhyEbTOzIfTgSPYTBTyOz2tBoiBSgZegAYOeW2jKW6UjW0Im5tiJ+
   a5Hyq+YtQmZ7uz1KrHHx7RMyC238+5SKIZEc1Uc1AtxVY0TLmBya1jhVI
   zHQsm/ebN6h/jO5YZR4jKEeEqvDY7GE6y6/qTGBlejdguy/phH+w9LzF2
   ZlaMbTPEz1jEj2eLa65yhc6M06Roi02itjBJPXfU3ykwZfGm8fumAg7rp
   AR5eUfnB1dwJidOrDNDszmiZfaCzsNeRn39JTCkMe/w8qOPgviXvnbuAs
   Q==;
X-CSE-ConnectionGUID: wh8J+/n4TPu5hZxjZFJHUw==
X-CSE-MsgGUID: ++5YLfesRA2G2VpRBKPrYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="53042146"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="53042146"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 04:52:35 -0700
X-CSE-ConnectionGUID: qUyIqUZBTMa39d5PrzXJ3g==
X-CSE-MsgGUID: EK7AgqdqQ0GfhOfahzTjdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138847244"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 04:52:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Prasanth Ksr <prasanth.ksr@dell.com>, 
 Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Mario Limonciello <mario.limonciello@dell.com>, 
 Divya Bharathi <divya.bharathi@dell.com>, Dell.Client.Kernel@dell.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <39973642a4f24295b4a8fad9109c5b08@kaspersky.com>
References: <39973642a4f24295b4a8fad9109c5b08@kaspersky.com>
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: Avoid buffer overflow
 in current_password_store()
Message-Id: <174730994725.2473.3936667480812297322.b4-ty@linux.intel.com>
Date: Thu, 15 May 2025 14:52:27 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 14 May 2025 12:12:55 +0000, Vladimir Moskovkin wrote:

> If the 'buf' array received from the user contains an empty string, the
> 'length' variable will be zero. Accessing the 'buf' array element with
> index 'length - 1' will result in a buffer overflow.
> 
> Add a check for an empty string.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-wmi-sysman: Avoid buffer overflow in current_password_store()
      commit: 4e89a4077490f52cde652d17e32519b666abf3a6

--
 i.


