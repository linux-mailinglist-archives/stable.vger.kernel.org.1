Return-Path: <stable+bounces-114608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E758FA2F012
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5695B18811BE
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28868252910;
	Mon, 10 Feb 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d9NVowZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD372528F6
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198596; cv=none; b=cIRumDOywcbQ+nespRJIr3c98K7mWv2sh/mwQyoQ0AyXSiz7VKYm/4rJ0JUL/mAe2GzVHeRiPxi6pKLkih2tojElvQkwqx7y31w2xr9oR4TYsKU+muY1vI6w7ra3vXpLBYbTrTLJn7wnROkmGnGkGo177Eay5z5AtyNVno0sSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198596; c=relaxed/simple;
	bh=AGO9go4jE2S88VVi4UFRRJT0QwivSyIAD7icFbUSvqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFrIhzlL3UUUFKR9YVGD2cGjvf+RGobjRoRJXLqwtw17/uxL0g7kG8+YQ9sUaUF6zLuuriig9OHDgxxJd4V8FtOq/a/zdImB6XvPASGTXdcsWDVKD7q2XicijbAt9mHM5FeRsSiMgJJZLTObLt7Zb5w5Dkv5FmntdL1EmG1pnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d9NVowZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD09C4CED1;
	Mon, 10 Feb 2025 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739198596;
	bh=AGO9go4jE2S88VVi4UFRRJT0QwivSyIAD7icFbUSvqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9NVowZ95FifBBsdY68vA59fk3QN+Xov7li+1W/JB2HkPFQ8/8A8nTJr7oqK7Q3Dy
	 8Qzm4ArkUFiUrU5RTxnodWpEBnTwqt+NgL6HYKixNaacQU2hVd553Sr1WjE2tPydqT
	 QuOJY8cbyqfAdGu3ASokBR7IPYhZ2G5v1gteZQwg=
Date: Mon, 10 Feb 2025 15:43:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: andrii@kernel.org, ast@kernel.org, bruno.vernay@se.com,
	stable@vger.kernel.org, xukuohai@huawei.com
Subject: Re: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to
 different hooks
Message-ID: <2025021026-statute-wound-3651@gregkh>
References: <2025021027-repaying-purveyor-9744@gregkh>
 <20250210142905.220005-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210142905.220005-1-hsimeliere.opensource@witekio.com>

On Mon, Feb 10, 2025 at 03:29:05PM +0100, hsimeliere.opensource@witekio.com wrote:
> Thank you for this information, I will take note of it for our next
> contribution. Does this also apply to more recent kernel versions? 

What information?  Sorry, but I see no context here at all, have you
read Documentation/process/email-clients.rst

Remember, some of us get 1000+ emails a day to deal with, context
matters.

thanks,

greg k-h

