Return-Path: <stable+bounces-169773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A6B28499
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547F73B8D25
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF61F582A;
	Fri, 15 Aug 2025 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QOj1+S+x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F92E5D3B
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277058; cv=none; b=eeYfGq49mz6IzDaq2nsPJ5P5HNXcUDeihnVrmYPI/CIWPzNTCl0Do7q6RqZRly5Yr2JhH1DlvpvXssPLpuBsN7H/mDLTaYTu3TxTdteqV+cFKDAUX9R6w4BKSIHxUMpXrvPf3+pmdljt1fc9T5r9wuqz6a/fyMECLMqYmr8PpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277058; c=relaxed/simple;
	bh=O3oyN2E1VbmH4yCmnDqeTTquVERsIFmRgqULts7JbzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMMiAKnhi2L2zVe9a+Qf6L3+VLFrgqTJQI7lqfrAZQno/uS4OdJBPAF+TaruN+9ognNBknH721BlQR7Fsj5EbhTtj3hT1U8dTv8NHIjjT7+b+COtpZxVhra2WUeZzAQX39i9+VcjNR/PWZ9GfoM9CzR6j+u012kj5dTyUylkXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QOj1+S+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8ABC4CEEB;
	Fri, 15 Aug 2025 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755277056;
	bh=O3oyN2E1VbmH4yCmnDqeTTquVERsIFmRgqULts7JbzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOj1+S+xWEHfv8ee8ySPyNK1U5jt9uyJDCviRzYcnFP0dpXOixNwfoVcwRprlCJLk
	 vhwfA1YYj35pLTzDUpy21Ul29S1jUgAu4i4hzFfkJWdU4IQBZzAUYY8wJQMsnk+Q3g
	 2Z5EapX39k7hIVFQXqpmRmj1MokfVr0aPb7C/YXQ=
Date: Fri, 15 Aug 2025 18:57:33 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6] sched/fair: Fix frequency selection for
 non-invariant case
Message-ID: <2025081504-overplay-unaired-854e@gregkh>
References: <tencent_07D4D9EB5CEA414A085CA5C3@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_07D4D9EB5CEA414A085CA5C3@qq.com>

On Sat, Aug 16, 2025 at 12:48:14AM +0800, Wentao Guan wrote:
> Hi,
>     Please apply the commit e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27,
> it fix the REGRESSION by ada8d7fa0ad49a2a078f97f7f6e02d24d3c357a3
> ("sched/cpufreq: Rework schedutil governor performance estimation") which
> introduced in v6.6.89.

Please provide a working, and tested, backport of that commit and we
will be glad to queue it up.

thanks,

greg k-h

