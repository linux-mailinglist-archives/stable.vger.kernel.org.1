Return-Path: <stable+bounces-179254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E9B52EF7
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 12:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C35AA02D72
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3AD2D0C7E;
	Thu, 11 Sep 2025 10:49:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACA1482F2;
	Thu, 11 Sep 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587744; cv=none; b=LAlq4yE9MNetn1OGBVkSdofcsFsr+e7oLzYnMR0yncMUx9Ovl0HNuDmBduRUk6iJAU6m+wYgbn6GI6tMd0KGG0vPXTKBhmDQPLetI+sR54pG54WXPn8GnH44NqdqTEG2QhX2FOzNY1cB1hKWfcalzr3i9cHShCgZsKXf+LVlvIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587744; c=relaxed/simple;
	bh=ITrH6lyOjMzKseNpUrMdJmZBuQriZvDKMVXZV9cGMsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LweV7CTbYL9YcPyPbt4Rsdt6HLSGd0tC30o60QIlnaV0aAhVGrjDTM5eLKciJFGtctIpm4eTTOsV+yPrTOUiLBUjzJJgmTfyOAK1wM/g6AzPBkvsIkuDBxhdikerUrhi/7Cj8eL5ykaEAqbZ/LOKjp7MZLuKFtTQ1hYllCd+ibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6146760213AFC;
	Thu, 11 Sep 2025 12:48:54 +0200 (CEST)
Message-ID: <585a858b-1701-4b05-b36a-a6f1a602324d@molgen.mpg.de>
Date: Thu, 11 Sep 2025 12:48:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 RESEND] Bluetooth: btintel: Correctly declare all
 module firmware files
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
 <8802b5d1-abf1-4ceb-8532-7d8f393f1be6@molgen.mpg.de>
 <bd507f6c-cea9-41aa-98f7-a5cc81dd77e4@molgen.mpg.de>
 <CAO8sHcnTzioN=WMAf35EQ-4iEwuUmmeEPQ9L=WsxzeF1_rn3XQ@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAO8sHcnTzioN=WMAf35EQ-4iEwuUmmeEPQ9L=WsxzeF1_rn3XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Dear Daan,


Am 11.09.25 um 12:27 schrieb Daan De Meyer:

> Was this patch applied in the end? If not, is there anything else I
> should do?
It does not look like it. I cannot find your resent patch in patchwork 
[1], so I believe the maintainers are going to miss it. Maybe resend as 
v6, so Patchwork picks it up? (I have no idea, how Patchwork works.)


Kind regards,

Paul


[1]: 
https://patchwork.kernel.org/project/bluetooth/patch/20221122140222.1541731-1-dimitri.ledkov@canonical.com/

