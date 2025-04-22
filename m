Return-Path: <stable+bounces-135129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319F8A96CDB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3773B9789
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95DE27D770;
	Tue, 22 Apr 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MVxTCsUq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B9226CE4
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328632; cv=none; b=kAteIT480ci5rgFfHG9iqiRMvOPxsbEgSBODTyLy8E+9qLdbTaf0+mtUUrj2yaJA9G+5dLIFNo39oLHrqgth8cH4K0llNmPZp7I0ER9h8yXM+/TEA641YZ70meQVkHO8u/aAyn/v9zdRMc0NbLf/C21STr1SlmKVkKAiFMhkoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328632; c=relaxed/simple;
	bh=pc9njm15tTUeE88qPiIHUMYGKmxWbHAcfs7B2cbAf0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGWVvCVjCGPJXqgVk8e/vQMRbPzkCiiVYIYsQMl2Mjc9ecml4nT2bhwjZvozYh2ns5iQhQlnYhuntYM1oa3uWcWLV6T7m0IFCM+p532YObD5eAWJzCtAqKgMApcTXlS4ddat5Ydo+LYGsC4KT70tqHdWWZ2R1cfgGhXyrR/15O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVxTCsUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCF7C4CEE9;
	Tue, 22 Apr 2025 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745328631;
	bh=pc9njm15tTUeE88qPiIHUMYGKmxWbHAcfs7B2cbAf0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVxTCsUqBRxSJMhi/0iINxoxhVGKCJxEp0HAH6Uh2Vk9/wV0SINXxQIJURvZzNUsC
	 88UsbHBciqMBPtBp1WdU9x5kMt1B2Pti1AJE2EjR7wy4G0Lntxnj+DQ2GZRq/34Umt
	 b/qAxCQxVn3/rMJj+NrRiPLQKEfefPB3MN6cV3pc=
Date: Tue, 22 Apr 2025 15:30:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@windriver.com
Cc: stable@vger.kernel.org, rtm@csail.mit.edu,
	almaz.alexandrovich@paragon-software.com
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Message-ID: <2025042214-flight-reckless-63d1@gregkh>
References: <20250328091824.1646736-1-bin.lan.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328091824.1646736-1-bin.lan.cn@windriver.com>

On Fri, Mar 28, 2025 at 05:18:24PM +0800, bin.lan.cn@windriver.com wrote:
> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> [ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]
> 
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> Build test passed.
> ---

You didn't document what you changed from the original :(

