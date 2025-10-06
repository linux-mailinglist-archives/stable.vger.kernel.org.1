Return-Path: <stable+bounces-183424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0BBBD9A6
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 12:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B07F034A032
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86D221572;
	Mon,  6 Oct 2025 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqrG6tCJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BBA1CF96
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745093; cv=none; b=QMPQfCrz9Uo1HqKcT+DtE5R++A6tjk3Ad/cOtbW+fB9yNwI9LIDfWeOmRXm0eYFoTp/sS1t+2MH1sjpEHQId5m9VTTm3k9pkvMAurvEQ6vTvgy2kJaRtkYtVkSf9PiyO4SNgtYqMWxi/12LdukWiVVC2rOgpZ9mkJZ2Yd8WOrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745093; c=relaxed/simple;
	bh=ZCI1m35M1//vHZ+gdcfN7glpV8B7x/GW9H6C1nYY/Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki7twUpeS5jOWlKIm7YwdJS7tUmxeTEOnS9NQ6Ie0WdLq6YruN5/wBLFGjf8Y4HkE1EVvku78U+/VrjPQU6MxuKc/kCLc+E4z0NLTgx2H5NQzeBffX7jGKB1S5ngDb/L6GtJ1/M4kBl9RkAFKth5u+9mNfGxl+w5rOImQab7QlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EqrG6tCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E2AC4CEF5;
	Mon,  6 Oct 2025 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759745092;
	bh=ZCI1m35M1//vHZ+gdcfN7glpV8B7x/GW9H6C1nYY/Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqrG6tCJGr5XL+/ABC5oQ1voRkd2TsS1/sed/cNQRi6C7cSvBCuzoX5VJrH6sR0zp
	 f0iyMCZbazZvmJSuEaDvezR50lsD2MogdeTfqJdG+RFI/zyAmWi6JN5XE6XvcXfDzQ
	 XCqEWpVHGL5Joiyo0XCoBq3xLKiyI3h7mk/xkF9U=
Date: Mon, 6 Oct 2025 12:04:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: LR compute WA
Message-ID: <2025100627-landfill-helium-d99a@gregkh>
References: <3c147f99-0911-420b-812b-a41a26b4a723@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c147f99-0911-420b-812b-a41a26b4a723@kernel.org>

On Sat, Oct 04, 2025 at 01:41:29PM -0500, Mario Limonciello (AMD) (kernel.org) wrote:
> Hi,
> 
> We have some reports of long compute jobs on APUs hanging the system. This
> has been root caused and a workaround has been introduced in the mainline
> kernel.  I didn't CC stable on the original W/A because I wanted to make
> sure we've had enough time to test it didn't have unintended side effects.
> 
> I feel comfortable with the testing at this point and I think it's worth
> bringing back to any stable kernels it will apply to 6.12.y and newer. The
> commit is:
> 
> 1fb710793ce2619223adffaf981b1ff13cd48f17
 

It did not apply to 6.12.y, so if you want it there, can you provide a
working backport?

thanks,

greg k-h

