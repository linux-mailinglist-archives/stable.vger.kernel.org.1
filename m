Return-Path: <stable+bounces-19437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F349850A50
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382641C21415
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA05C5F5;
	Sun, 11 Feb 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JurtTMKy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B25C5F3
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707668978; cv=none; b=npwdKUU8OYS6zFfn11Cgx9NyHY9Otg7j9AgpdYlj5DyIf83UOPEd169H8g1HjCKiR+RKULPFN3bAXT5/Rmchm4hua66ve0OzrTdx8EAyVCbkKPriF1VTU+wE3XD4wnD8cxlDS2iGB4DXume5jXlSVTH6CoShPjaOz7nUcYxroDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707668978; c=relaxed/simple;
	bh=qf4T+5slOe0LFu9E/0PlAMug4DJjAT/2WSNXBjuHDrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUf3JlIq6CWInZLwrioox0lHwMUkgddNZSipgO0UR7nGVQAB1EL7D1+3ygvaoS61nDGgknQJgmfkTRe5JceEzE/EI6hgrMueJo7Euc8ZhqmFaP3v8ddiTwZNHwHATq4Nahn9kL7bvVOq6bRhbxBplhmPXfnBFji71FhEp52vToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JurtTMKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284B0C433F1;
	Sun, 11 Feb 2024 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707668977;
	bh=qf4T+5slOe0LFu9E/0PlAMug4DJjAT/2WSNXBjuHDrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JurtTMKyLCx1FXnK9hPtWm6foccwuTzuU4W2x9ulvRGa8APL5myXnMlddLN6p3JeZ
	 BU8liAqUzCkaUj+AK+R5rtfo/t7axYetdW+6qHaECzXv3WYVY+b/BAoZWnrgVXHOpA
	 GWofa7RKD3kcyhIOGXNq67SeCkn5s3OLF2XymOIE/xEDfxvKJj8X1cj8JYMBKtRBWw
	 MPpKRP3+FsKc7keR7g8sdPUYGie1f1CiinMjFGyZt+jiNVlWabUFBHuiYSvJtVYvlv
	 4IQPdl47X5RXstm+X/P4cpM+WMIYMcorY3R6CRBlYjvR2FgPjTO2DsX9/SemTzmsHQ
	 jXHOi8n3Aht1w==
Date: Sun, 11 Feb 2024 11:29:35 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jordan Rife <jrife@google.com>
Cc: stable@vger.kernel.org, ccaulfie@redhat.com, teigland@redhat.com,
	cluster-devel@redhat.com, valentin@vrvis.at, aahringo@redhat.com,
	carnil@debian.org
Subject: Re: [PATCH 6.1.y] dlm: Treat dlm_local_addr[0] as sockaddr_storage *
Message-ID: <Zcj17ysVY9kU8xVs@sashalap>
References: <20240209162658.70763-2-jrife@google.com>
 <ZcZ0Tb13ZG9knz_P@sashalap>
 <CADKFtnROEHN4w8pRz7u1Udjg+Jm3kVb5meJSjGXZQ_=zQp-=qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADKFtnROEHN4w8pRz7u1Udjg+Jm3kVb5meJSjGXZQ_=zQp-=qw@mail.gmail.com>

On Fri, Feb 09, 2024 at 11:08:45AM -0800, Jordan Rife wrote:
>On Fri, Feb 9, 2024 at 10:52 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Fri, Feb 09, 2024 at 10:26:57AM -0600, Jordan Rife wrote:
>> >Backport e11dea8 ("dlm: use kernel_connect() and kernel_bind()") to
>> >Linux stable 6.1 caused a regression. The original patch expected
>> >dlm_local_addrs[0] to be of type sockaddr_storage, because c51c9cd ("fs:
>> >dlm: don't put dlm_local_addrs on heap") changed its type from
>> >sockaddr_storage* to sockaddr_storage in Linux 6.5+ while in older Linux
>> >versions this is still the original sockaddr_storage*.
>>
>> Or we can just take c51c9cd8addc ("fs: dlm: don't put dlm_local_addrs on
>> heap") into the relevant trees?
>>
>> --
>> Thanks,
>> Sasha
>
>Hi Sasha,
>
>Just my 2c, but backporting c51c9cd8addc ("fs: dlm: don't put dlm_local_addrs on
>> heap") feels a bit riskier than just correcting the call to kernel_bind(), as it's a much
>bigger change. Maybe someone more familiar with the dlm codebase can chime in
>and say whether or not they are confident with backporting this change.

It's a bigger change, but in our experience it's the small fixups that
end up carrying the bigger risk.

Backporting the original change also has the advantage of preventing
similar issues from happening in the future.

-- 
Thanks,
Sasha

