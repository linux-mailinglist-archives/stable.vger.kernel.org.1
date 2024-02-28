Return-Path: <stable+bounces-25377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B786B245
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8772E1C231DE
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887815A4B0;
	Wed, 28 Feb 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VtyyEKVq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AA151CD3
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131677; cv=none; b=ppobKS/NBKxf0sTLBM0smQf1kfnQD8DvE2GaGPLZrndaAHv3GCDGTj50JEzwO5NFjrYNP1DBEvwuZ7L86+b0tjI6D1c782iblAXfntttB2dQ2Tp9J+ElmLX5AfsylhVmRuRB2vLo++j35ZofQMBkqUXkCECaRdkmbdnJDTMDfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131677; c=relaxed/simple;
	bh=5MvfFrf1G4ERBN3zHNH5ZYScjoyEnlfETFdY+bUYgoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5yrNHLtPT6FiT9dQdlEs5Vvd9MDRUzb+STQMqQSSyVWZoF/rx2pSPhTdOe8djUH4S/E9Jec850sn0ues+cUtkFem5ejxa6c2pd6s+416lhlS+uwXab265dYJK9+1KLtZ5rOzUxt1vzkTb1FcFKQsne8bFgNDoqNjcRd0D/dVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VtyyEKVq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512e568607aso5695829e87.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709131673; x=1709736473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GbQN37mhhA8J1p486CCanaHeSFjvjlJFFfeli9pCvc=;
        b=VtyyEKVqcz+oaPvzd9GBQBtjhE3sojlgDngsIjNmuHstYjVK6g5rFtmqoLwzqHPfOH
         XOD4+BHv59cejcEiEqhRt36HFso/GMwgsanlXko5pkqV2QURIuLi1WZwmPD37Z4jLY1C
         gCGH+ZJfMhGXpaWns3bmNqd8OQ3QPMALWF8zJQg81xOnoiiaN/Z/EdDvmxmUkuC11snJ
         es0npuccCVih88qi72nwcb/IvqWdOuEkGxyOE+4Q9GkV6aXAGEclH9P2ENVYyxv9hg9q
         EPPzFcdgQ48CLaKPq+yZ9LJl41q1iqqybQb4xRpBv535ay93mGa3/Po8kO8StxxZ3mQT
         GKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131673; x=1709736473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GbQN37mhhA8J1p486CCanaHeSFjvjlJFFfeli9pCvc=;
        b=DTwQZZ23XinhjXOzA9dOWrIxML/YBWjpZdzMyLcj8IsYhoc+pwdetFuwmOqNc2MI2y
         h5Smz/yCxdOOwYzOLJC9Ep8mdNeo2TStoIWxuaJNOZthfNlYAnF1lxmrybiMWeGW+g9+
         /PMe6N3hisIS4Fr5zhoR53EewAbkTxPKuJk2ERC/jbwLmlHS75wwl9ih1L3fc9V5UTff
         0pQGNXMtRopGvcZQh4gDQ0uIh09QFJgDDHBldThi+KL7ubCbM5MTnVmM107K98+cH5fW
         VST1aTPKY6+Ak3Wsion554XB5OR9Ik40URn+DBpgjV9VVGHHyoUZ0Chvf9ROPYFl72hi
         6/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV99prMHHkmSsUYt97DOK9puhVUaGD2S5NWu57yqGKwp3RY8EXU3ZnMcWvbB/QztHEKdSjjRPMyQ4zCKHsHtdDKL7ut+mIC
X-Gm-Message-State: AOJu0Yy4msy6WdLErF0TTQPfxlmavh++vbzeLQXULVjyxKYikZM1orAI
	iw/Aj0PRxLAaMDT3Z5r7xcGLFa3cH6IIvyKNM8etRcGxdVyhr2eSasIGPsOcjWs=
X-Google-Smtp-Source: AGHT+IH91e8k5xsqpA7DNNC9jiLw5SufBWVlhROZKlTXqcqtB2uevW9HcetR8P9jbSkCOV0afMvOzQ==
X-Received: by 2002:a19:750d:0:b0:512:ab46:3de6 with SMTP id y13-20020a19750d000000b00512ab463de6mr7491124lfe.32.1709131672792;
        Wed, 28 Feb 2024 06:47:52 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b00411e3cc0e0asm2351047wms.44.2024.02.28.06.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:47:52 -0800 (PST)
Message-ID: <49a365a7-199a-42cd-b8d3-86d72fe5bca6@suse.com>
Date: Wed, 28 Feb 2024 15:47:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB:UAS:return ENODEV when submit urbs fail with
 device not attached.
Content-Language: en-US
To: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
 Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
Cc: WeitaoWang@zhaoxin.com, stable@vger.kernel.org
References: <20240228111521.3864-1-WeitaoWang-oc@zhaoxin.com>
 <e8c4e8a3-bfc3-463f-afce-b9f600b588b2@suse.com>
 <07e80d55-d766-1781-ffc9-fab9ddcd33e3@zhaoxin.com>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <07e80d55-d766-1781-ffc9-fab9ddcd33e3@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.02.24 23:32, WeitaoWang-oc@zhaoxin.com wrote:

> @@ -602,6 +606,8 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
>           if (err) {
>               usb_unanchor_urb(cmdinfo->data_out_urb);
>               uas_log_cmd_state(cmnd, "data out submit err", err);
> +            if (err == -ENODEV)
> +                return -ENODEV;

This is a generic error code from errno.h

>               return SCSI_MLQUEUE_DEVICE_BUSY;

This is not.

>           }
>           cmdinfo->state &= ~SUBMIT_DATA_OUT_URB;
> @@ -621,6 +627,8 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
>           if (err) {
>               usb_unanchor_urb(cmdinfo->cmd_urb);
>               uas_log_cmd_state(cmnd, "cmd submit err", err);
> +            if (err == -ENODEV)
> +                return -ENODEV;
>               return SCSI_MLQUEUE_DEVICE_BUSY;
>           }
> 
> I'm not sure I fully understand what your mean.
> Whether the above code is more reasonable? If not,could you give me some
> suggestion? Thanks for your help!

You want to change uas_submit_urbs() to return the reason for
errors, because -ENODEV needs to be handled differently. That
is good.
But why don't you just do

return err;

unconditionally? There is no point in using SCSI_MLQUEUE_DEVICE_BUSY

	Regards
		Oliver


