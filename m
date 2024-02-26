Return-Path: <stable+bounces-23732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6902D867AD4
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 16:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F7E2892CF
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F5C12D761;
	Mon, 26 Feb 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oeOn/qsy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5D12C7F0
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962775; cv=none; b=AwUrWUeVICrywf//G9/Rf+QvzLOjY7TKI+oysOuQkAF8uqCQ9vuP5Z9iflgRg9cx3Od3+HMOXNUxS9r3IpbMe4wcEIY7WNPzX5lyZF306VLhdNulhEgjGHKAY+pVHq5AHP0dXcIqQBgVl1DACp8W5n50jeGhBX7T3F15JdKx/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962775; c=relaxed/simple;
	bh=7/Tlnj8WtZFpkRZ9esTBPHd8LStIfIfoQK6oPYOq23s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzrV0zKjGrKwl6TkINFlSkVhqaLojyB6DUxf5EheOuDW978UHBw8Y+UlRLObe4RugX6kyeBaSrT6okVyhMNrvG9fipBJ63XZv6WAQpUkdZYUr63j4s6I1BR2k7YPC4Xz84Mhnioy4nAQXJIMswToWG5B/aFYP3jFdqI3oMNszX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oeOn/qsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A098FC43390;
	Mon, 26 Feb 2024 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708962774;
	bh=7/Tlnj8WtZFpkRZ9esTBPHd8LStIfIfoQK6oPYOq23s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeOn/qsy384SQHABFMKBtbCMSPa69fuOJU+c+y5goLdvTXXU/v0eKyKHaCNF1HzcR
	 QZdU0xxiSucXi/vAfNciIFBWj/qIt6ntPhRRS/NDziSq7Qtm4TTuj7zcHtLsVGFcHM
	 DDxFS1SGxe4IVST02yfAwS+G2NZUllZe1/2guhDA=
Date: Mon, 26 Feb 2024 10:52:50 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: 
	=?utf-8?B?0KDQsNC00L7RgdC70LDQsiDQndC10L3Rh9C+0LLRgdC60Lg=?= <stalliondrift@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Kernel 6.6.17-LTS breaks almost all bash scripts involving a
 directory
Message-ID: <20240226-porcupine-of-splendid-excellence-22defc@meerkat>
References: <fa4cd67e-906d-4702-90e2-b9c047320c34@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa4cd67e-906d-4702-90e2-b9c047320c34@gmail.com>

On Mon, Feb 26, 2024 at 05:27:50PM +0200, Радослав Ненчовски wrote:
> Hi. IDK how more clear to write it in the title, so let me explain what the
> problem is.

I'm sending your message to stable instead, because helpdesk is only for
requesting help with kernel.org infrastructure.

Stable folks, please see below.

-K

> In the past 4 or 5 years I've been using this script (with an alias) to
> compress a single folder:
> 7z a "$1.7z" "$1"/ -mx=0 -mmt=8
> 
> I know it doesn't look like much but essentially it creates a 7z archive
> (with "store" level of compression) with a name I've entered right after the
> alias. For instance: 7z0 "my dir" will create "my dir.7z".
> And in the past 4 or 5 years this script was working just fine because it
> was recognizing the slash as an indication that the target to compress is a
> directory.
> However, ever since 6.6.17-LTS arrived (altough I've heard the same
> complaints from people who use the regular rolling kernel, but they didn't
> tell me which version) bash stopped recognizing the slash as an indication
> for directory and thinks of it as the entire root directory, thus it
> attempts to compress not only "my dir" but also the whole root (/)
> directory. And it doesn't matter whether I'll put the slash between the
> quotes or outside of them - the result is the same. And, naturally, it
> throws out an unlimited number of errors about "access denied" to everything
> in root. I can't even begin to comprehend why on Earth you or whoever writes
> the kernel would make this change. Forget about me but ALL linux sysadmins I
> know use all kinds of scripts and changing the slash at the end of a word to
> mean "root" instead of a sign for directory is a rude way to ruin their
> work. Since this change occurred, I can no longer put a directory in an
> archive through CLI and I have to do it through GUI, which is about 10 times
> slower. I have a DE and I can do that but what about the sysadmins who
> usually use linux without a DE or directly SSH into the distro they're
> admins of? With this change you're literally hindering their job!
> 
> I downgraded the kernel to 6.6.15-LTS and the problem disappeared - now the
> slash is properly recognized as a sign for directory.
> 
> The point is: *it is urgent that you undo this change back to the way it
> was! I'm pretty sure sysadmins will begin to email you about this, if they
> haven't already.
> *

