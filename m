Return-Path: <stable+bounces-171872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2764AB2D4CE
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECCC14E4970
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF02D63EE;
	Wed, 20 Aug 2025 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ntgtclnx"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C822D5A19;
	Wed, 20 Aug 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674776; cv=none; b=hwzmkbqXAbwOd8kfal9SxHDYw9iLaIfGhxZQN0L5lW6XDGuLTj4rvVJ/arVzgxvzu1Vr+4QaWdDB+fb32DgV3fBgQPAFKonN4ig8m36O9yxZ0CcrLlztoIbS++nFLS9LHNBdCC9NTiqwMejzXB5UFnPt1LGXWJYKk35CADnRnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674776; c=relaxed/simple;
	bh=So/DPdTrEetS+prIB4juTaDi3sd6U8Pwug7hulZEtkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gEzwmOxLFUfrmWxmYyaRBYCTvxlFh8uruA8HoJnZGd3X1Py/8JZVXskgjPLVR6OJttSWL7Premfsj8TQXa+9+aKtqm/APFhkfphrztw+yu080uR+5Dg6rvKkOolbZtnQzSQ7OIqks8fJpLJ7kvQF9tnAw+WYOuI+/axJyYI2XqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ntgtclnx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 7696F2015BC8; Wed, 20 Aug 2025 00:26:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7696F2015BC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755674767;
	bh=So/DPdTrEetS+prIB4juTaDi3sd6U8Pwug7hulZEtkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntgtclnxCDAddTQ1PPTXn1URGH+qWeQBi47Zx8HyMKiUkfaeJI4w1wdub8Z+fA/AE
	 H2AVrMIw2wfJ0zSsnLCjlMZGlpMhz3r3CrxVqo0PfFoz1elAzTM+lbNmUHdEsh45lV
	 ENuIi3ncBu3npSYjdToTWDBkS0lZkZQZtjk3sbIc=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
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
Subject: Re: [PATCH 6.12 000/438] 6.12.43-rc2 review
Date: Wed, 20 Aug 2025 00:26:07 -0700
Message-Id: <1755674767-30118-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>
References: <20250819122820.553053307@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.43-rc2 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

