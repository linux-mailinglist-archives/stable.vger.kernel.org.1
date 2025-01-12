Return-Path: <stable+bounces-108322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE77A0A881
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 12:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B5C3A75FB
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3719F12A;
	Sun, 12 Jan 2025 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VW+O6VLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89D12C499
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681287; cv=none; b=K6WQtQGUBTTFD6zOnTI8/zVQvbA+VvdqZWOm+GMyBa+NPRbvt+28xFinpOjf/tz11eTbWPfadRbk3w4wQmk+Tp9ywl9RTTj+WAxpBbvheoj4B3qRSFP+MvqLaxEt1bKeDUjBj4KAWjnGd37dlq0rsCkdCRnt5TUsx620VAY1ZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681287; c=relaxed/simple;
	bh=m5X6m+3D09pt31h59o3dZO9Miy7upEoJAUGC95CwHtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWJjCu41HOeP3nIFmWpR3rneDpK2Fhzx5MEBUQOlRQi1uxn1s78zqKT+ibOZir7W8GZArpyeW7bO6z8Gb39O+Who51P1Y7aq5W8zTjYOVuLmgL39An2E/y2zqKPaAb5B66VhpaomH/d6DIgW/Py3NBil5U0oCAwpSi8mEHYMaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VW+O6VLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C0DC4CEDF;
	Sun, 12 Jan 2025 11:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736681286;
	bh=m5X6m+3D09pt31h59o3dZO9Miy7upEoJAUGC95CwHtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VW+O6VLKnqkxqCYBqG9EAKRVTvMCidmsH3lhuE4dANXTnBTcM/NJ84Pvm22o2gXWZ
	 Zu+N2PMySYD1G6Znj22sE7XPvVQ3ttkwG9JPZS/yxmlQAvLM0KZX0vDqdwhIEBRWte
	 NldQ+NvhmYVlKZs7l6H7lk80rLQpGAgDbHTjNb+g=
Date: Sun, 12 Jan 2025 12:28:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: stable@vger.kernel.org, ashutosh.dixit@intel.com
Subject: Re: [PATCH 6.12.y] xe/oa: Fix query mode of operation for OAR/OAC
Message-ID: <2025011249-cherisher-handball-1932@gregkh>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>

On Fri, Jan 10, 2025 at 12:53:41PM -0800, Umesh Nerlige Ramappa wrote:
> commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream

This is not a commit in Linus's tree :(


