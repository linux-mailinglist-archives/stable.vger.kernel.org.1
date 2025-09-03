Return-Path: <stable+bounces-177609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54F2B41EC9
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DAE17F8B0
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1102FC873;
	Wed,  3 Sep 2025 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akendo.eu header.i=@akendo.eu header.b="EXAHpUCc"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB02F49E2
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902099; cv=none; b=XgBHG0NF+6FBpOeycKS/i4Pg4/qNYxeb1vFZjqpvc4OL7ICWlTz4GqD9eJJnE5CSUnBIdQj3cmaHqJEkLGzIgznz63tczd9xQqpaZvrs9lAEFcz1g41Y2HN311QPM8/stUForpa+YQ4Y7/mRF17p/BX/e1uyP3Vmv9IZdRkK8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902099; c=relaxed/simple;
	bh=bGlETsAzzIANrEh7VlCi1HFV766z1m/nNYMPyT0vmgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLsTOB4iOY6En0Aj3f9D1sK6vdFd2I1xCJA7rSvIbPxs5WaZY3X3B38cB7yavkls1thhWVEZjTpjoYCOG8UGjJVMiuAoyDr2h2mZAsFChu18+E9nnhsAn8MtD04Dl5NTWtsOrwesymNT9jr38Bp+kbSFapbowos/Nf05IdrwW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=akendo.eu; spf=pass smtp.mailfrom=akendo.eu; dkim=pass (2048-bit key) header.d=akendo.eu header.i=@akendo.eu header.b=EXAHpUCc; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=akendo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akendo.eu
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cH1th0hSjz9tFV;
	Wed,  3 Sep 2025 14:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akendo.eu; s=MBO0001;
	t=1756902092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKa3JeqheeiDQRwZ17kpBqHnmqbGK9Y724otQcQUKoA=;
	b=EXAHpUCc0xvHeDLfEwwYNjGBvqR+akyyJ6Tp1Fugpxbte9taoaPrN1lPS+QwVXGqi4bzBq
	u+j8xf3tNxyl9mZRjgyEVu8ALunLeImuB850n7q3WquPZQgmC/IbV+G16lMv1NwMXhdBJi
	hAzuvXB6DZENAb5UVa2ygSU60KZuvJvN8il2CZKzsnHz84vAgx5choGlrtua3fnlBxu1rm
	+wBd9EBOCeWri/ziPhXvGOA5wOVb6uaxd+xyYjA7N3e9+C78IWI+2nD2IzZeZIfzCRIGa5
	YEabNPIlH0INqdlslPi2BuYgOUTXwOyvO3eI02B83YDm86U1zlI4vJr6NtD2ug==
Message-ID: <6c5efc80-9dcc-4943-9840-5e1046182101@akendo.eu>
Date: Wed, 3 Sep 2025 14:21:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net/mlx5: HWS, change error flow on matcher disconnect
Content-Language: de-DE, en-US
To: Greg KH <greg@kroah.com>, "Subramaniam, Sujana"
 <sujana.subramaniam@sap.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20250903083947.41213-1-sujana.subramaniam@sap.com>
 <2025090322-nervy-excuse-289e@gregkh>
From: akendo <akendo@akendo.eu>
In-Reply-To: <2025090322-nervy-excuse-289e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Greg,

Thank you for your responses. We’re in the process of learning the 
process and figuring out how to get the git send-mail out.

This patch aims for the kernel 6.12 and backports the changes for the 
mlx5 from 6.13 to it. We use the 
1ce840c7a659aa53a31ef49f0271b4fd0dc10296 commit from upsteam to do it. 
We had to update the path within the patch to make the patch apply 
that’s the only change we made. We roll this out in our kernel and test 
it already.

I forgot to add my full name to it, we will fix Sujana's Name is 
correct. Please, I apologize for the puzzlement we might have caused.

Best regards,
akendo

On 9/3/25 11:41 AM, Greg KH wrote:
> On Wed, Sep 03, 2025 at 08:40:13AM +0000, Subramaniam, Sujana wrote:
>> From: SujanaSubr <sujana.subramaniam@sap.com>
>>
>> [ Upstream commit 1ce840c7a659aa53a31ef49f0271b4fd0dc10296 ]
>>
>> Currently, when firmware failure occurs during matcher disconnect flow,
>> the error flow of the function reconnects the matcher back and returns
>> an error, which continues running the calling function and eventually
>> frees the matcher that is being disconnected.
>> This leads to a case where we have a freed matcher on the matchers list,
>> which in turn leads to use-after-free and eventual crash.
>>
>> This patch fixes that by not trying to reconnect the matcher back when
>> some FW command fails during disconnect.
>>
>> Note that we're dealing here with FW error. We can't overcome this
>> problem. This might lead to bad steering state (e.g. wrong connection
>> between matchers), and will also lead to resource leakage, as it is
>> the case with any other error handling during resource destruction.
>>
>> However, the goal here is to allow the driver to continue and not crash
>> the machine with use-after-free error.
>>
>> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> Link: https://patch.msgid.link/20250102181415.1477316-7-tariqt@nvidia.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Sasha didn't sign off on this original commit, did they?
> 
>> Signed-off-by: Akendo <akendo@akendo.eu>
> 
> Real name?
> 
>> Signed-off-by: SujanaSubr <sujana.subramaniam@sap.com>
> 
> Correct name?
> 
> What is this being sent for?
> 
> totally confused,
> 
> greg k-h


