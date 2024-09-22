Return-Path: <stable+bounces-76864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6C97E302
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 21:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C59281241
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BD3A267;
	Sun, 22 Sep 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3QwRqxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D5524C
	for <stable@vger.kernel.org>; Sun, 22 Sep 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727033739; cv=none; b=RYfwyhv4DKq7buRgTqG9GyC0kLJs2Fsogc/1ZyDtsPtcDjobksMiVP0G/1mt4eSMvQD5508+tKQ27hN00MEVDCzgutaYmDS+YwtypmDxb5iYfGZ6F3hYkXQACLxkeuTXlk6sabzmBXxuuTEzqNblq/DI43aYEY7Jg2b8GGXwMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727033739; c=relaxed/simple;
	bh=vmwY6Cal4UvHYO8DryXO44ocd0L4+z5sXx4DpEVwMsg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CNz1mbD2BW5VIIANrAMQGKpCDoP2wKI8+PU+EMeSOYtGO3RC+IORMNjWDsTFMCp7e2mwOVPfCUlkZsIsH9Ta0hPi8BHtEQGM3/72yHccqYoLEQxih8yInMB669pYL6fiWnzaMBo1KAtNinp+p8AVL1MMvoTfwnLSmxnjqVAgRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3QwRqxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC7FC4CEC3;
	Sun, 22 Sep 2024 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727033739;
	bh=vmwY6Cal4UvHYO8DryXO44ocd0L4+z5sXx4DpEVwMsg=;
	h=Date:To:Cc:From:Subject:From;
	b=s3QwRqxwZVdiHKh1jWMhEf/oJYG37ire7rUUCn7bQObhHsBhAOaTDFpxkcDBPCshZ
	 1XmTFScTXFkO00s7y8leq4ujG8C9VzVjl03vW1mXq3XjNDPKWfopJrywxMCm42uSLF
	 rxr2Sr0UaPYOfdRHOnH6claE9zDWSploELB2+btqn4G5V27RbpiT7d1NPo8sRQaxoj
	 fwtSaGNgK3pMfB3T9okrHxvYMS2cXCpSBHiqBl0PtSqBeEDhbso9LMD47UeiU8YQ5Y
	 qTsuZN3jfuGxKlYBpqCLNa78hneNcGIaxkur2lmqoS74vYRZoKGY5nNmUH6iKAM827
	 snmjmj9iLHoow==
Message-ID: <ba9ebc80-301b-4058-988d-02988c54d965@kernel.org>
Date: Sun, 22 Sep 2024 14:35:37 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Peter Jung <ptr1337@cachyos.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: Fix for kernel crash when changing amd-pstate modes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

This commit from mainline fixes a crash found in kernel 6.11 if users 
change modes with amd-pstate.

commit 49243adc715e ("cpufreq/amd-pstate: Add the missing 
cpufreq_cpu_put()")

Please backport to 6.11.y.  Earlier kernels should not be affected.

Thanks!


