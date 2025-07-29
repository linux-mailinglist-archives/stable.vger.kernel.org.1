Return-Path: <stable+bounces-165046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA80B14AF5
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 11:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD553B8A9C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3A1AC88A;
	Tue, 29 Jul 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nc3bgkdj"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1A78C9C
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780547; cv=none; b=S/bMfi3hr4+HMlTZcIiNsukv2zVYI8YpogpCTsFemBllpWKIRC0DCiM6BJFymnbjursNu0W98yfomMKrZfEn2fUOZtqTupYikOdzMpPJawkYXpZM7Z5dNA//pzZoArQLd6+saHajENb7u7kopooPnN2V/EkSYfrvZshNt63nWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780547; c=relaxed/simple;
	bh=UUKUl1DUOM03uN91sckLd3iDrkIM7eEWofAb5ugEhk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0v9C7vc4P0AT5CE/fp0xB5hFPqMYp9xpfu7J8yMOrEm5YsF8soInrGdKFfEKHYZfjI7K8gZ4f8kk1KE4R6jbPuzUvp5f46f8v+Wv/62mrd+OZpecMV9GFBUVXTfXddAUgT6jXb5t+JPwF59fNhE3PhlveogMuoktjElsSUULyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nc3bgkdj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.161.187] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5AADC2117655;
	Tue, 29 Jul 2025 02:15:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AADC2117655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753780539;
	bh=2HMKoqIRS67OFhJDCtUx9a/HxLtvikrWUMLRXJEDWlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nc3bgkdjemUAa9OeAEUHwQaatNsw8/+B/tMsllwwdBUIs0VVSCHd7LwfhpCXL6gcg
	 HDKFPG13wAvQpbv+YNeh8aZaWrzR3YpScEB2Zn/ut4bGgnTRKInTVXlu92/Iyq34ZM
	 EQSTOzo3zf3cj9VmuHcQ6TKLmiIrBPASIHYFqSCo=
Message-ID: <676182d6-78cb-44a5-af99-e1e938ba6e9d@linux.microsoft.com>
Date: Tue, 29 Jul 2025 14:45:34 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] tools/hv: fcopy: Fix irregularities with
 size of ring buffer" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, wei.liu@kernel.org
Cc: stable@vger.kernel.org
References: <2025072131-stage-bundle-b616@gregkh>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025072131-stage-bundle-b616@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/21/2025 2:57 PM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x a4131a50d072b369bfed0b41e741c41fd8048641
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072131-stage-bundle-b616@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h


For 6.6 and older stable kernels, fcopy was not supported via 
uio_hv_generic, so the "Fixes" change is not going to break fcopy
there. So, there is no need to port this change on these kernel
versions.

Regards,
Naman


