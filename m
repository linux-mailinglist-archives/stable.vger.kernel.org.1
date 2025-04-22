Return-Path: <stable+bounces-135104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFCEA96894
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB45A3AD25D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E238C1A317D;
	Tue, 22 Apr 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSM/8uWD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF4221289
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323738; cv=none; b=fQYqw9QLJ9ZGcyETkww4RC01pu5hgh/56tLu5euO6+axXtdj2wbwdeNlxd6CClOyWbN88rpKW5mCKfzCo1ITpoIalFdVtIRthqjjhH3Gt6DquOkptQ9yVJvh7OyLcFPp8A1QlTuN0BJkiSQOhgMfoBRJQzB9tMNihJf59sVJYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323738; c=relaxed/simple;
	bh=Vf/lohAgte8oxHKlaOfU/EMD4a+LZdhrI7bfciw9jLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvPhRWKooAmiKIpFoaE52gFgLG5+AxtVAfFQiIBWdVG1T9+rcQpe5OLy/Mwjpph2sRXfoMU3vVbrDuxJd9ud7sLaMTqE2Wr4doMCkqKsbcq1IFhoaHpC4+KCIWK7OPFCawgaQ7jrGbMLVQA7JKH5XjotG7P7SQcy6lbfH7vh6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSM/8uWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D9DC4CEE9;
	Tue, 22 Apr 2025 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745323738;
	bh=Vf/lohAgte8oxHKlaOfU/EMD4a+LZdhrI7bfciw9jLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSM/8uWD+vzHhdCvne6bGJy8pJms1c/sJ6/42/L2eUd+NCVW8/ECi0B/QhZro8Yho
	 zEvbUh9rMHs7KEHxmR7soHHefm50BIS2RzjeBKVpVs7N0/Rcs5Y7DMcd5Ddz2da5wg
	 mWECGJTZHD9jQ+nf53E9nI61sQ3OtZ7EGpNwA/w8=
Date: Tue, 22 Apr 2025 14:08:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel =?iso-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>
Cc: stable@vger.kernel.org, skhan@linuxfoundation.org,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+9177d065333561cd6fd0@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 6.1.y] ext4: filesystems without casefold feature cannot
 be mounted with siphash
Message-ID: <2025042225-goldmine-cheer-3018@gregkh>
References: <20250419084059.53070-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419084059.53070-1-miguelgarciaroman8@gmail.com>

On Sat, Apr 19, 2025 at 10:40:59AM +0200, Miguel García wrote:
> From: Lizhi Xu <lizhi.xu@windriver.com>
> 
> commit 985b67cd86392310d9e9326de941c22fc9340eec upstream.
> 
> This patch is a backport.

Why?

What about 6.6.y?

And what has been fixed since the last times this has been submitted for
inclusion and rejected?

Please don't ignore past efforts :(

thanks,

greg k-h

