Return-Path: <stable+bounces-165705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E532B17ACE
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 03:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED05545507
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C617678F5D;
	Fri,  1 Aug 2025 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EKI7t/KE"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B9178F29;
	Fri,  1 Aug 2025 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754011685; cv=none; b=cikmCvTmxGH9P5yfOScCJHXCjBnT3sMb0JyXZ+pfA0/mPOU+CukF2xRnFgih05NL43qXAm5Sta6yQQ6xbeExwWSZwx8x14HA+OHpiO2+SJPRvNoORh+d3orpqWLuF9JKTLdyUsjbusSk7A2tiRr23Yd3su0ok7cXtbzR7MS7ezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754011685; c=relaxed/simple;
	bh=/eUIEFMMUK2svY2crm/P1jkwiyNJ+tSs6gc3iE/Lkls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CDtUmQm0iZ6fP6o6gFoPBquFCHbbP8F1XqfFbaSf2hXqJ439QM0giyl0gCy/NFNukzPDMEsfY+FHIRnJqL6Fg8jmBzy5YgF73GDuCgsSspvz1t7E9xkZIIm5cWUcddYqoz9l6nAsxBsA1seFcWUQnx6y0x1a8dhVdhtwnk9MXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EKI7t/KE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id CD40B21176F5; Thu, 31 Jul 2025 18:28:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD40B21176F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754011683;
	bh=/eUIEFMMUK2svY2crm/P1jkwiyNJ+tSs6gc3iE/Lkls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKI7t/KEWRtGprQvmfCBMv+n3cSaJwtLnw4cny3Jj9nxI8anY+dmFaOgea17rEX0O
	 Bo7luvjR3w38x97VJj23cwdk184c3O8bL7Uyxz3iLVzytW7+3WRcTaeZRC3IK/3G5r
	 rBVkUWRejvz/JE6ywOgTKG/vo8ec7xEoMtBPnvCc=
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
Subject: Re: [PATCH 6.6 00/76] 6.6.101-rc1 review
Date: Thu, 31 Jul 2025 18:28:03 -0700
Message-Id: <1754011683-26666-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.6.101-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

