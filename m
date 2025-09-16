Return-Path: <stable+bounces-179718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A45B59678
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B8F7ACDE1
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6151186294;
	Tue, 16 Sep 2025 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptuA/Ovl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD741AAC;
	Tue, 16 Sep 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026730; cv=none; b=S2XZ5kXNcSjNZ0npoIV8ER9ZQTx8vSk7t4nQH+U/LovmJXY/NJUI4IGvotq61XwdcJos9uUZ31d5nAj97D7UdPBYpvpEUF/UWb/Fy2HMdFbRGlgGKEMmAcwqURSAfK00r2jed5xN+/F9lTiK9f9XLhpgKG0OPbVmOQhcFCkiS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026730; c=relaxed/simple;
	bh=Q8b3LidWHXwy7z60vkFZIq9N/I8zXE5IsO+IFYXOuW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZweR2RO//hmL0fyDvV63XfGF0rhA0SThg/ripac8bnr59EtZJ8bOf0mcGHEK9Tb49UIRvdAYmTHTWJ4jVPgoYtNtOZ8/u3QTZ1dRYzEZg+MeW75d7ebO0DaR0TNQmxDHvJSXNBVAw9Waz3gatn6UDfifFRFUTYANekXm2xAWluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptuA/Ovl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FB2C4CEF0;
	Tue, 16 Sep 2025 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026729;
	bh=Q8b3LidWHXwy7z60vkFZIq9N/I8zXE5IsO+IFYXOuW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptuA/OvltuPdVFVrhaioHbpDtjjM/9DLVoKZRVx29LpT6Lc27PzSLHnMoWj+LabK/
	 eSB+1RL4IAAJL4T1VXQJ5+iYTsn7JXgyGlOH4hzbM11KXJFo6qB4aU5mlTE/iTrs37
	 aPkgsNTYjGHXOq3fe79+sF/CACO/9Myq4aFvNdzvvbjDzHUL52XDc12HUyqe478iBS
	 fXIPutO5ul1uTbTGhX5oNMA15xV/XnW2crYH7vx7LIJdw293p9Y/CN0DlDz2CUlZBd
	 g4BCf7eHVj2CB4TlEPmfSE7rQ80+8IFDAiIdOnz3FV3vdCPukB3fyUoG7YXfQAV+Bb
	 hJlsJninGzF8A==
Date: Tue, 16 Sep 2025 08:45:27 -0400
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Donet Tom <donettom@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	stable@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/3] mm/ksm: Fix incorrect KSM counter handling in
 mm_struct during fork
Message-ID: <aMlb5x0eWA4rpVKe@laps>
References: <cover.1757946863.git.donettom@linux.ibm.com>
 <4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
 <20250915164248.788601c4dc614913081ec7d7@linux-foundation.org>
 <aMjohar0r-nffx9V@laps>
 <20250915214117.5117d339669e091b1d3fa96d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250915214117.5117d339669e091b1d3fa96d@linux-foundation.org>

On Mon, Sep 15, 2025 at 09:41:17PM -0700, Andrew Morton wrote:
>On Tue, 16 Sep 2025 00:33:09 -0400 Sasha Levin <sashal@kernel.org> wrote:
>> On Mon, Sep 15, 2025 at 04:42:48PM -0700, Andrew Morton wrote:
>> >I think the most important use for Fixes: is to tell the -stable
>> >maintainers which kernel version(s) we believe should receive the
>> >patch.  So listing multiple Fixes: targets just causes confusion.
>>
>> Right - there's no way of communicating if all the commits listed in multiple
>> Fixes tags should exist in the tree, or any one of them, for the new fix to be
>> applicable.
>
>So what should we do in this situation?

For us, ideally point to the oldest commit fixed by the new commit with a
Fixes: tag, and then a note along with the stable tag if this is a more complex
scenario that we need to consider.

-- 
Thanks,
Sasha

