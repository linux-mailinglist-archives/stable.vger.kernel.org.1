Return-Path: <stable+bounces-196603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7FC7D52E
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27F81351C49
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46768296BC1;
	Sat, 22 Nov 2025 18:09:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA32773D8;
	Sat, 22 Nov 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763834981; cv=none; b=tGFxMF3yCLLf0CakXImeJyrPAIk7uquVuXn0aj5OcTVYj1h5T/wjj6a+goPE2TQULUIZ6sfdmpjgbnPgCfOnulKWbdrrruvnkX8QzfxWADrqhLmRro1G2lgBcoXKyEXPOusAAbbYoZ5JNx6hxMr1g4Zq9VLl7yg1t2k4zq4x/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763834981; c=relaxed/simple;
	bh=60R0tDaDTxHpa+/lsWzmr1XNHWqN6MrhUQ5n3gbB8G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1sjyqtnOSAWL0epvV/IVNv8MHtPkueM7Toy/wlKLQ9fIZ0ItqL99KSZ8zleGpDRUKttKbPs/rTvA7KqW6K/AUIlPtbj5uzZ34JLzc0HYOwdaUt3ZA+M9Exv4tRmmi2GleduvUfz3ga96Tebmn9mhBSdqjozqJuf9Ur4GWx2xzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 40121103FC9;
	Sat, 22 Nov 2025 18:09:26 +0000 (UTC)
Message-ID: <138033cb-fad4-429e-8b8b-a0af29808fe1@enpas.org>
Date: Sun, 23 Nov 2025 03:09:24 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] HID: memory leak in dualshock4_get_calibration_data
Content-Language: en-US
To: Eslam Khafagy <eslam.medhat1993@gmail.com>,
 roderick.colenbrander@sony.com, jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+4f5f81e1456a1f645bf8@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251122173712.76397-1-eslam.medhat1993@gmail.com>
From: Max Staudt <max@enpas.org>
In-Reply-To: <20251122173712.76397-1-eslam.medhat1993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/25 2:37 AM, Eslam Khafagy wrote:
> Function dualshock4_get_calibration_data allocates memory to pointer
> buf .However, the function may exit prematurely due to transfer_failure
> in this case it does not handle freeing memory.
> 
> This patch handles memory deallocation at exit.


Thanks, Eslam!


Reviewed-by: Max Staudt <max@enpas.org>


