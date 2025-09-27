Return-Path: <stable+bounces-181821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501EABA60A0
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 16:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AE317D18E
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43C2E2EF1;
	Sat, 27 Sep 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dGLq8iqI"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC219C540;
	Sat, 27 Sep 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758983492; cv=none; b=u3JcPfe0Ohs53UflB2p2DBXrX1VbkItjppNIPZYv2UwImt5gkXYhUlOtP0MFfX1zMAohSF5bphFPq+K6RPT8HIDaeV+31fCz8vbJCDedjef7id/2fafNpO50yoC8sHZqZcHmr8mZRzU0btY7P+Fxo6H5eE6zKSZ2srCwXsi66lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758983492; c=relaxed/simple;
	bh=vXTABgwTk52fHmAXgUkZ8YK1uChcVr4A5lzh5g1WjZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trxqQapTn0hhD7+LD2ZnAfRv6PuEP0PPmRFF+cPb6xqzQjvsdF0Dl96Cn6Y6vXZbgb++xBwxtjMlWterkE9oTUUMrok/8DilAWLUHbEg6Ds7FxzRWPwZpgXMt4TVXnwz9kvD1VEjguEHbUVr6ii/yAXT9KaT9SGBP9SYnfmVAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dGLq8iqI; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=vXTABgwTk52fHmAXgUkZ8YK1uChcVr4A5lzh5g1WjZ4=; t=1758983490;
	x=1759415490; b=dGLq8iqIV34qrajGHMc2T/HrZAFKdavDDlfVwzEx8Y+fYWSVd+uEDbYjUMYk7
	baS3Wbf9R76tKCr0IwwGWBjJdV59+YyD9HpNYjSljBlFnXeTbgPcI8EXwR1mq0hQ8vxDB5Hargnie
	eLkrci6OfZlZA5xBX7AinSRMsx4VfJJmWLGrBHuNradNfywCqmZ+ehCPLi9gr2II4wcMNJE4qi/kx
	hg4oMTJmWePCcvcDEQouq8EtBpEsYAT6uqgI4PpjHUH5+MQuhM+HPjBAItoLkuTvXqLiwIALMyqiC
	7A/OcdWJNXQG1eIE2VJKOvueAZRe2OxL9FTA07mpM++DYVcmCw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1v2VxP-00BYar-2d;
	Sat, 27 Sep 2025 16:31:27 +0200
Message-ID: <aa72cb3c-bed3-413d-840d-05aa72a60c5c@leemhuis.info>
Date: Sat, 27 Sep 2025 16:31:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't
 boot with 6.16.9 and Xe driver
To: =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?= <me@iyanmv.com>,
 stable@vger.kernel.org
Cc: regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
 sashal@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
 <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
 <92577e77-3f40-45a3-8e67-d9c6f5ffeb86@iyanmv.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <92577e77-3f40-45a3-8e67-d9c6f5ffeb86@iyanmv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1758983490;754d97fa;
X-HE-SMSGID: 1v2VxP-00BYar-2d

On 27.09.25 16:19, Iyán Méndez Veiga wrote:
> On 27/09/2025 14:52, Thorsten Leemhuis wrote:
>> Does 6.17-rc7 work for you? We need to know if this needs to be fixed in
>> just the stable tree or if it is something that needs to be addressed in
>> mainline as well.
> 6.17-rc7 boots fine, so the issue is just in the stable tree.

Thx. Could you also try if reverting the patch from 6.16.y helps? Note,
you might need to revert "drm/xe/guc: Set RCS/CCS yield policy" as well,
which apparently depends on the patch that causes your problems.

>> Just wondering: why are those parameters needed? Is the hardware not
>> fully supported be the xe driver yet?
> i915 is still the default driver for Meteor Lake integrated GPUs, so
> that's why I need to pass those parameters. Lunar Lake already uses Xe
> by default, though. In my experience, for at least the last two kernel
> release cycles, I've observed better battery life and performance using
> the Xe driver.

Thx for letting us know!

Cia, Thorsten


