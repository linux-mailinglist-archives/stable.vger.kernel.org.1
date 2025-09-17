Return-Path: <stable+bounces-180430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0ECB814B3
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED241C80D39
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 18:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C334BA24;
	Wed, 17 Sep 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uvk5/07s"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673412F9DA1;
	Wed, 17 Sep 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132270; cv=none; b=WjNVlcdva2k5o+lv7BTqu7I00A+T+yrsJoCN/J1sRYLpWhEPhWne/sYvp7rFHuWytrBPUwDFh+nj594EduaAo+4coojO4RHGiMs4F376uSUR9IL7eovba6biGBajIBQ1kFftT5o0rPL7XOZeOzteYvTmQNLBgQF5M3dF3O2sEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132270; c=relaxed/simple;
	bh=gCg8TkFajZESKQxd9ey7P59HEGgTmN9jyrFWv/J+G0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TYdKsNWY3wSkplC3lWBlvImTYIumRcOaWArnby6BphMA1yZKXBIYOgP4b6a01cBfnnXDYORelsuR8C9W0ZSi6U+KbLJRPJsiPuYEErhfC+rS/1ZLJnQvGeWmvNnT6wNnmvgEqu3t84znfjVNcFo9d7APE61ZQy2N1Ak03Ao+pLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uvk5/07s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 0566C20154ED; Wed, 17 Sep 2025 11:04:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0566C20154ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758132269;
	bh=gCg8TkFajZESKQxd9ey7P59HEGgTmN9jyrFWv/J+G0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uvk5/07sEamu4ZR/tHrgEGHHjvVKvGhX3K4Z9KT/AHc1/YTYypFSSZas1apdFbMi7
	 SPD4phpR2uFRffG3eZA7S1js25aAjTEQAW8F1ruME/UVLJIXsJ2ljobMFU9HSeXC2+
	 04ui5LFbdR5tJ1bjbm0gvegDnA2zgV/edVVVF9nw=
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
Subject: Re: [PATCH 6.6 000/101] 6.6.107-rc1 review
Date: Wed, 17 Sep 2025 11:04:28 -0700
Message-Id: <1758132268-17352-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
References: <20250917123336.863698492@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.107-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

