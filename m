Return-Path: <stable+bounces-95736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADE39DBADE
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 16:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D12282037
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB01BD039;
	Thu, 28 Nov 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIQSrSzY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60917C219;
	Thu, 28 Nov 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809166; cv=none; b=ukb5XHP6YuxZQwjML+M/+f1+ncYXcjLIMeSXDG9QV7XKwGAMh7+nAhvSfB1/OMye8F27hXoLuF00Eeeakx7GcDJuOKDJd9cqhNw4mN9XSEPbgJrnNQQIDnWEwN7SjfEHtVZFHyU6nzJyxgi06RMAidCzpUMFUwI1B6ihbH186y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809166; c=relaxed/simple;
	bh=rdG79C/elJq0vGPG1kQF7+OR6KALzUkhER+aDpZe3sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q76DliMqTMTcHbgx53lnZrjjneVxqbEeaoTG6zh7NoZUkd9C8hYaZ7XhKoXGWcRUh1cTpw1mImmvzwxV+yBsRRr5lObE7kdS3Q7z1zxiI4InNwLqpOl932NpOb43cMTL59Wlg7ByX+G5fPvL1z9GZTnrioIZeZBkKpiimMsQCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIQSrSzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63EFC4CECE;
	Thu, 28 Nov 2024 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732809166;
	bh=rdG79C/elJq0vGPG1kQF7+OR6KALzUkhER+aDpZe3sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIQSrSzYQK4zDeCwjpIUHuexk6x4zvEQdZo/aGpNATfEyfud358U8v17NDUUIsZAB
	 tudq82l8hJHu+1U2diqhrNJXiOJ4KiYmHF0d1p6/OKYBpG7uYT/hcjWLzkq/XT7oOI
	 qZ1AucNcyvZUT8ZJSxEdXaS79FN58Moe/1Vk9iO/ZbkThCmKGdFky9QxvenIn+Xu0j
	 xMdpcFotwHvJenLi3rYVXPDTAgNy3WKn1s6BSdbQDgkFbgtJNSBu27CkU/8V4Rtd/p
	 QdI+HISDUoLQmZ1PXljV0Vl4zTzqLXHXOUTF4yGduxo215je04jyH8PgfRZxKzyTpb
	 DmBVtcANoTTkg==
Date: Thu, 28 Nov 2024 10:52:44 -0500
From: Sasha Levin <sashal@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com,
	kim.phillips@amd.com, jmattson@google.com, babu.moger@amd.com,
	peterz@infradead.org, rick.p.edgecombe@intel.com, brgerst@gmail.com,
	ashok.raj@intel.com, mjguzik@gmail.com, jpoimboe@kernel.org,
	nik.borisov@suse.com, aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com,
	Erwan Velu <erwanaliasr1@gmail.com>, pavel@denx.de
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <Z0iRzPpGvpeYzA4H@sashalap>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>

On Thu, Nov 28, 2024 at 12:59:24PM +0100, Borislav Petkov wrote:
>Hey folks,
>
>On Mon, Jan 15, 2024 at 06:26:56PM -0500, Sasha Levin wrote:
>> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>>
>> [ Upstream commit 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5 ]
>>
>> AMD does not have the requirement for a synchronization barrier when
>> acccessing a certain group of MSRs. Do not incur that unnecessary
>> penalty there.
>
>Erwan just mentioned that this one is not in 6.1 and in 5.15. And I have mails
>about it getting picked up by AUTOSEL.
>
>Did the AI reconsider in the meantime?

You've missed the 5.10 mail :)

Pavel objected to it so I've dropped it: https://lore.kernel.org/all/Zbli7QIGVFT8EtO4@sashalap/

-- 
Thanks,
Sasha

