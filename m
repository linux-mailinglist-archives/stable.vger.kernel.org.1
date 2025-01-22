Return-Path: <stable+bounces-110230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4DA199D9
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 21:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5393A0611
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17F3215F4E;
	Wed, 22 Jan 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hev1E0Vl"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED52144A0;
	Wed, 22 Jan 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577634; cv=none; b=HNXFzLFuUIa7SD6sdM9aKibnb/jrGYiKPFl0GNupF1RoEHARHr9McPpCa4AHx7PVYssDlfP1MW+EIkD7YwVKElCupv7NT5QLy1qWTU7+mHGsIXfPH5hjOh4JEYz7KkHrs4iYIalfZwirLpwgHOYovaJH8otf5RtC6jYcpoRI8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577634; c=relaxed/simple;
	bh=GDZif92V5lGJJKpIIT1pKJQk9MaZGIdKsfYMvhpjcB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j1kLhzlHfe4EvZup5o/bej8B+/QmVvmqAK+X/2PbKJjOBvv/37iv+rbd8DwSPP0iTyHc0UNeGHIREP2YE1/KBdxrDrcW+eUYWmeb1bELqaiUaCU80KJ+G+LFVwqLemhmIfR2v9dIPx2glTkrSN4gU0zL/5to4eipQfCSV8+EvMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hev1E0Vl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id E5E9B20460B2; Wed, 22 Jan 2025 12:27:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5E9B20460B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737577632;
	bh=GDZif92V5lGJJKpIIT1pKJQk9MaZGIdKsfYMvhpjcB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hev1E0VlLny77V4NH8EQNMPvnS4hZLV9vRyeY2fmKtfdouNLvWM2lQPza8qOBXTMA
	 j4RzLRMF/h26e0LgPJnOv8e+8tz2/WEBrAYAe+juA21O29ujfGAPdML2vFP9NA5Om0
	 abzZS0Y3UKUGFymfNQOYT7S4VFVfdzZPtf82JUGA=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.1] 6.1.127-rc2 review
Date: Wed, 22 Jan 2025 12:27:12 -0800
Message-Id: <1737577632-19452-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250122073827.056636718@linuxfoundation.org>
References: <20250122073827.056636718@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, amd kselftest tool builds fine for v6.1.127-rc2 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>

