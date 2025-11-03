Return-Path: <stable+bounces-192284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72365C2E50C
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 23:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78C91894DA4
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 22:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1998E2E6CD7;
	Mon,  3 Nov 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jCHygD16"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C91A9F82
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210181; cv=none; b=HYCl9YrkcgjGvhC2VaNogsBTFnoHZZf67Oc4A1fC3a0Sg52kJqBzA+1eSoPj7/XtJh2jjXqakp7mE9JL+IINgHkkUWXxg+m8OhRLAN5nauBuqpLwQoK8rH/+Y1yEm8J/+y3ukYxhs/s+brSyO03bsGNKNiXUGMltVTdaRR0D/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210181; c=relaxed/simple;
	bh=tWBQxkVt80lqwo78yBrNvEeXe7Efzx6wXxFvpz7X/+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTxcT750a93j+fN2127F3lWZ2eh33DIbovxMLSMDQklSFX9RBbZDHhdoGZ0WFFh9vCLQK4CSVCLIOV/Pv6ehJtLYFweHeMAzALfvkjMMo3ibKVVkmLaWJqitfE4JaBos4JYPXmJ1wSLLTSCQFYzyNFqGs+Skiej4PTmT8FimcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCHygD16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133EDC4CEE7;
	Mon,  3 Nov 2025 22:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762210181;
	bh=tWBQxkVt80lqwo78yBrNvEeXe7Efzx6wXxFvpz7X/+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCHygD16+TMbIg+EdShKMzUfJXkT3xIQq38kbJXwF1tHjf+GoyAiL+ltv8YmqPg7Q
	 FohwNzrxZD8mfeLr8LEKqjrGxxkvEzuWJ+qQYzph12AmnvjVs4AgaM5ASzMBw/PivP
	 9ZveMzSSLqgK13LBzO9AF9W7RcA/upGihhbqLaaQ=
Date: Tue, 4 Nov 2025 07:49:39 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Brunner <Michael.Brunner@jumptec.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: For stable: [PATCH v2] mfd: kempld: Switch back to earlier
 ->init() behavior
Message-ID: <2025110429-unmixable-karma-75ef@gregkh>
References: <d63de3930e7df2726de5ef482b6f46b5c69f0154.camel@jumptec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63de3930e7df2726de5ef482b6f46b5c69f0154.camel@jumptec.com>

On Mon, Nov 03, 2025 at 01:54:17PM +0000, Michael Brunner wrote:
> Mainline patch information (included in 6.18-rc):  
> mfd: kempld: Switch back to earlier ->init() behavior  
> Commit 309e65d151ab9be1e7b01d822880cd8c4e611dff
> 
> Please consider this patch for all supported stable and longterm
> versions that include the faulty commit 9e36775c22c7 mentioned in the
> patch description. This includes all Kernel versions starting with
> v6.10.
> 
> Newer Kontron/JUMPtec products are not listed in the kempld drivers DMI
> table, as they are supposed to be identified using ACPI. Without this
> patch there is no way to get the driver working with those boards on
> the affected kernel versions.

Now queued up.

thanks,

greg k-h

