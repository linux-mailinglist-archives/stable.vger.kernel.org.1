Return-Path: <stable+bounces-53688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793FE90E369
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229D51F2358D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C0C26AC8;
	Wed, 19 Jun 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OOvQF49J"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670B1848;
	Wed, 19 Jun 2024 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778699; cv=none; b=BIN5oVoPfD+Lfc/XsfP8I69ND7k+OH8aGHS5vu5ILZIadzR7iRft9Knlr1S4zvzz8sKeoaWbjk7nmIH6sG5xCQJMSlGyEP8RqoPGNDYEJJvs4f6lUJ/lP+3bHX+Y7kvqYhd7KK0PZ/ffC4rSYCi2lIUq8IzPf2QCsTC9JAYhGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778699; c=relaxed/simple;
	bh=ccbPSRK8qMlCUf6lppX/RuMkzSrq0NUDekMEo6/hpow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jrQMbb0/H1dWqsdFaaJD+yxPZJgrBbo7AADadqjwkEqCbxYjzTzx8GZvBCvpD96TzgKB2rz3DNat2o1JrSvmOFQx5PdSaz1fcgDOZa8sait+wzmmTkxec/QTmhD+YwOW6QOfw5NcRtpE9mr/ArRNlIwuvSVCH5fmXk4MQmC9Wcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=OOvQF49J; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718778692;
	bh=qjyG9jPtAFgV4AUANLc1JylhQQ3I6B14AefyyVdS0kE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OOvQF49JLkPk/HkdhhfpfwAbhCmFRjv4QDDh1Eoj2bWx7tjFiVmjkdY9hsusecYuE
	 OZlkBfSwDFfNWU7d20RR9ANb4nFgj3AwB4m2gc7fqgjxxaxuuxPQCxclTSLNK4z226
	 g7/HrJg6vhclhcBB4Qrd4jf36/IV5SbYnRJV1EFG3P7lM5N4d8Z2kvO0hzkKt7Nvmi
	 26TNXBbUg2Vn0zn0C7I8l9E1LJTirsb1jh9zS0QCZY5nH0RBoz+xvWLpv4kjj996cv
	 uEdJ2WwVLcDnDbCH0UvShf0U35nOVgN2j1PvFZ1hjQ9SjZ5BPVR79MkLKy8LYcMl9l
	 OnwEig59nOQCw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W3v0N4f6Sz4w2R;
	Wed, 19 Jun 2024 16:31:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pavel Machek <pavel@denx.de>, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, hbathini@linux.ibm.com, bhe@redhat.com,
 akpm@linux-foundation.org, bhelgaas@google.com, aneesh.kumar@kernel.org,
 linuxppc-dev@lists.ozlabs.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH AUTOSEL 6.9 18/23] powerpc: make fadump resilient with
 memory add/remove events
In-Reply-To: <ZnFQQEBeFfO8vOnl@duo.ucw.cz>
References: <20240527155123.3863983-1-sashal@kernel.org>
 <20240527155123.3863983-18-sashal@kernel.org>
 <944f47df-96f0-40e8-a8e2-750fb9fa358e@linux.ibm.com>
 <ZnFQQEBeFfO8vOnl@duo.ucw.cz>
Date: Wed, 19 Jun 2024 16:31:30 +1000
Message-ID: <87a5jhe94t.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pavel Machek <pavel@denx.de> writes:
>> Hello Sasha,
>> 
>> Thank you for considering this patch for the stable tree 6.9, 6.8, 6.6, and
>> 6.1.
>> 
>> This patch does two things:
>> 1. Fixes a potential memory corruption issue mentioned as the third point in
>> the commit message
>> 2. Enables the kernel to avoid unnecessary fadump re-registration on memory
>> add/remove events
>
> Actually, I'd suggest dropping this one, as it fixes two things and is
> over 200 lines long, as per stable kernel rules.

Yeah I agree, best to drop this one. It's a bit big and involved, and
has other dependencies.

cheers

