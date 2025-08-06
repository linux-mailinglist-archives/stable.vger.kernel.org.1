Return-Path: <stable+bounces-166709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3523BB1C8C4
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A3116D16C
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81828AAE6;
	Wed,  6 Aug 2025 15:31:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D698F48;
	Wed,  6 Aug 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494304; cv=none; b=lyZA2YhMIWt5JGnAqhEgxw//5e979lGnaJC5Xr1B9pqGnjNuJAj0hxBsD4wk+agIr2sGXQ9e6OXPFPX4ZLuBk4xRpeVjtBh1wPiJzesODnqOWPcVYH69qsQndSWDP2luwYliBqhfER/sUbU7aJssLm+odPSy5tN9v9EPY+cI8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494304; c=relaxed/simple;
	bh=q+xTMTotuWMwykrAaOJcLJ41pi/bXRWMhpeZPylbcys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4gTyIv2SG3XzEhHFTFen6xSMCnQjT6STb4PZlTK1TH7pdYxdwCfgz62B+MAqEf/Pd0VSIJKT56zgvnVuq+BdRZVbBw9vGwYxpzhlDWRnHF4T5tQ8062nPdEJw6HC9f2Ycp67X1aIYNGC4A98Z+s2MO28P3leYRnDJ3Lep5WWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 916AB176C;
	Wed,  6 Aug 2025 08:31:33 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CE8B3F5A1;
	Wed,  6 Aug 2025 08:31:40 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:31:37 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: <Markus.Elfring@web.de>, <jassisinghbrar@gmail.com>,
	<linux-acpi@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v4] mailbox: pcc: Add missed acpi_put_table() to fix
 memory leak
Message-ID: <20250806-mole-of-impressive-excitement-6fcea1@sudeepholla>
References: <20250804121453.75525-1-zhen.ni@easystack.cn>
 <20250805034829.168187-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805034829.168187-1-zhen.ni@easystack.cn>

On Tue, Aug 05, 2025 at 11:48:29AM +0800, Zhen Ni wrote:
> Fixes a permanent ACPI memory leak in the success path by adding
> acpi_put_table().
> Renaming generic 'err' label to 'put_table' for clarity.
>

I don't see any point in this unnecessary churn by renaming the label
as there is only one label here. That said, I am not too picky either.
The patch can be as simple as dropping the "else return 0;" part.

Either way,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

