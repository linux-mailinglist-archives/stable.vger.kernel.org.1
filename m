Return-Path: <stable+bounces-69960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5AA95CC61
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54071F22FAE
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A630184552;
	Fri, 23 Aug 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPqHly7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A17376E0;
	Fri, 23 Aug 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416343; cv=none; b=Ebhjugl48nprvN2U5Xg1BdRH/8cjXrTutz3OvLShIWvvPLqpWCCZko1OVKLKdAHrwBENffdt3YXn7SHDpFT5a5S8NnddjJQPAEVrAOwhlVojd8BDQ2p9q2RLjM8+59GgYIXoORC+aGyxsA44blue7UiF2iaIJ2I6oYQcprudh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416343; c=relaxed/simple;
	bh=5YE361IlxGmo4/+oyWKqnbrrcPCjtqIwLiE5se77xzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBv3EIyVEi7mEx4SJjxKgbtB8tgzb+gcAPPMAn9a0QotCxPDdmpYgC2i1zS5coXm7HcFgK/+RTwS6w0RnUjDonUy0AuROEFKKoweKdsBvcGEeltAvGeyNWQwMbU8/oFGqItcrbr9hURO4dY0HHUQO/bNz4tsHyC1ABup2QWstWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPqHly7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6220DC32786;
	Fri, 23 Aug 2024 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724416342;
	bh=5YE361IlxGmo4/+oyWKqnbrrcPCjtqIwLiE5se77xzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPqHly7WWNVtvCPegj6j7m7aZwB6K1rlrCBPa4Dd8rcAE8Cwl9J/uGx5ALTq40i14
	 bdnwCz87cgiKlA8wsSVhTw0kxD5qS3Xf2lgodS6g5viloBGJz6uzPUTYhQF87mR7fs
	 x02ESE8ESSceZmTtiNP8rtOhEMvFP2FpGDAJrqsDxUml9ZpbGPsSJNOjtnGXIhLZBt
	 71jJeQDHgaD6nGygvFazTPhsQnk7jMLSDBHyFkPYGxWyqHEmSAS3gBFzcqC+4Dy2WT
	 8/6xLJ5K5AOT9jIL+BUl1YrCXeelUSthaysF7dgXf1R0NK8JAuCYJsfxkT4cahZrsX
	 ddoPNqcgHb04Q==
Date: Fri, 23 Aug 2024 08:32:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	bigeasy@linutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "serial: pch: Don't disable interrupts while acquiring
 lock in ISR." has been added to the 6.1-stable tree
Message-ID: <ZsiBVay0C9yE0b62@sashalap>
References: <20240821133745.1670922-1-sashal@kernel.org>
 <f7d3abbc-60ec-46d1-8486-cd43121d76cf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f7d3abbc-60ec-46d1-8486-cd43121d76cf@kernel.org>

On Thu, Aug 22, 2024 at 07:03:24AM +0200, Jiri Slaby wrote:
>On 21. 08. 24, 15:37, Sasha Levin wrote:
>>This is a note to let you know that I've just added the patch titled
>>
>>     serial: pch: Don't disable interrupts while acquiring lock in ISR.
>>
>>to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>>The filename of the patch is:
>>      serial-pch-don-t-disable-interrupts-while-acquiring-.patch
>>and it can be found in the queue-6.1 subdirectory.
>>
>>If you, or anyone else, feels it should not be added to the stable tree,
>>please let <stable@vger.kernel.org> know about it.
>
>I feel so. It does not fix anything real. It is a prep for 
>d47dd323bf959. So unless you take that too, this one does not make 
>sense on its own.

Ack, I'll drop it. Thanks!

-- 
Thanks,
Sasha

