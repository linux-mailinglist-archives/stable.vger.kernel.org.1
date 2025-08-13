Return-Path: <stable+bounces-169363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2026DB24702
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D133B4409
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5F2F1FDE;
	Wed, 13 Aug 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9eUzIjg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F72ED169;
	Wed, 13 Aug 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080042; cv=none; b=UUPu4/RuOueUZa2I9pH9YPWA+t9vOfixaiCESjvGLNN0JN/uuPU5CxtcDhQYalmnScphm+2lf+rcyNXzAJbDcpgBtCSUHKuYztzzQYtAypmUGJ88DnU+SvGkheEa+FpV01pYtXsnpQDAnTSY49EH34HELsAPYzfhq9PwMopYvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080042; c=relaxed/simple;
	bh=Wot5jXTdnslI5ga52pGH0Mha2rmsP2F8JHtxTwr9np8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8NkBl5I4jdJcc8wwPRGG1MybVxKhioCb3F0aRusL3FTxIZ9SylmUP2ah5KaRlffyqzWmFP7QaDIwjSms6NM0vzJxINEcWVnXPyIlN3JFSqmN6gscPbrOmU4mgvDU2yb4REfWPCBDsyhbLwtUtSHQOAzXHjCXAIdSpXdz+H4ftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9eUzIjg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755080040; x=1786616040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wot5jXTdnslI5ga52pGH0Mha2rmsP2F8JHtxTwr9np8=;
  b=V9eUzIjg0gh40wifMrNOVuTHxLUs2Mxwfr7235YzHPXtZF+m20j4KdpP
   aTbYHXT1pWgxs8wNOy8YO7AukhG2reKGG9192g5da5x9s/7mfFizdAoqW
   GGxmTArd6+Fd+bc07IwdKkPE8+fFv4vHEHFBnevk8zR3HaAV4YLOR+LQo
   eJkhnAzazijb64MVoTb7Lf8guMZesrPuvS4qczMhkiT2p9f58ckj9g4pW
   AS0TQebARyFNJ24hqyHPTS+6JRiW9NeZ9wjnvLn8TItR3cJyP88kNXYCD
   OifchsASYrnaBaHKqXHqar9J5tyPVdT2otzfTQtwLsMtXIu/oYDJuAfi9
   w==;
X-CSE-ConnectionGUID: NweBEj3OR7iOrDwMSQgtIw==
X-CSE-MsgGUID: HSsttAvdQ8aoeRJCiM6I5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57433259"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57433259"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:14:00 -0700
X-CSE-ConnectionGUID: j2v28P2JRbW1qLkmaKanvg==
X-CSE-MsgGUID: u693ITd7Rp6u+bWbvwjvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="197291587"
Received: from mnyman-desk.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa001.fm.intel.com with ESMTP; 13 Aug 2025 03:13:57 -0700
Message-ID: <78e5e182-3051-4937-ac92-d4faefa4b895@linux.intel.com>
Date: Wed, 13 Aug 2025 13:13:56 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
 =?UTF-8?Q?Marcus_R=C3=BCckert?= <kernel@nordisch.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz_Bartosik?=
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
 <fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
 <5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
 <4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
 <20250813000248.36d9689e@foxbook>
 <bea9aa71d198ba7def318e6701612dfe7358b693.camel@nordisch.org>
 <20250813084252.4dcd1dc5@foxbook>
 <746fdb857648d048fd210fb9dc3b27067da71dff.camel@nordisch.org>
 <20250813114848.71a3ad70@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250813114848.71a3ad70@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.8.2025 12.48, Michał Pecio wrote:
> On Wed, 13 Aug 2025 11:14:04 +0200, Marcus Rückert wrote:
>> Jul 24 15:56:34 kernel: usb 1-2: reset full-speed USB device number 14
>> using xhci_hcd
>> Jul 24 15:56:35 kernel: usb 1-2: reset full-speed USB device number 14
>> using xhci_hcd
>> Jul 24 15:56:36 kernel: usb 1-2: reset full-speed USB device number 14
>> using xhci_hcd
>> Jul 24 15:56:37 kernel: usb 1-2: reset full-speed USB device number 14
>> using xhci_hcd
>> Jul 24 15:57:56 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up
>> Jul 31 19:53:02 kernel: usb 1-2: reset full-speed USB device number 50
>> using xhci_hcd
>> Jul 31 19:53:03 kernel: usb 1-2: reset full-speed USB device number 50
>> using xhci_hcd
>> Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
>> using xhci_hcd
>> Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
>> using xhci_hcd
>> Jul 31 19:55:05 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up
>> Aug 06 16:51:34 kernel: usb 1-2: reset full-speed USB device number 12
>> using xhci_hcd
>> Aug 06 16:51:35 kernel: usb 1-2: reset full-speed USB device number 12
>> using xhci_hcd
>> Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
>> using xhci_hcd
>> Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
>> using xhci_hcd
>> Aug 06 16:52:50 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up
>>
>>
>> all HC died events were connected to reset full-speed.
> 
> OK, three reset loops and three HC died in the last month, both at
> the same time, about once a week. Possibly not a coincidence ;)
> 
> Not sure if we can confidently say that reverting this patch helped,
> because a week is just passing today. But the same hardware worked
> fine for weeks/months/years? before a recent kernel upgrade, correct?

This patch also only concerns SuperSpeed and SuperSpeedPlus (USB 3) devices,
so it's unlikely the real cause.

It is possible it reveals some existig race between the SuperSpeed bus and
the slower High- and Full-speed bus. Both those buses are handled by the same
xHCI controller.

In this setup usb1 is the high+fFull speed bus, and usb2 the SuperSpeed bus

Thanks
-Mathias


