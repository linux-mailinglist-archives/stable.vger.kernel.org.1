Return-Path: <stable+bounces-161738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23568B02B6D
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 16:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683B117F169
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1727585F;
	Sat, 12 Jul 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="XZ/Z2KkF"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFD8BEC
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752330915; cv=none; b=QL9x7/z3ocinhwd4b6Ngzdp0FvIVD8qV5GYLzUGu2BCA908BQVDSSxITX8LU6NckSCh3+LcgVzV2nKCZB8JRyCRT9KbxQwBULw7YcBTLYBeng/IWXxQYT+RmjcVO6hurgzo2BMbSUu7isO5TZqlWlYB39W1vFstIHb38FgfdT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752330915; c=relaxed/simple;
	bh=dXKllsM4BF/t12XllpuGZAhEoYr5GOGsusJAuf6LS9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diQxANiLx1d39Ly1HHoG4HyETMJ1jEuQ6gCpJ1FMgyfVSWkeuSNz+ofc4FEPVrV/uyqZVCFcOhZoVRbrgtD2trJdP2hcJOuLnDsE5mlF1zeeVOOzfamAMji2N9Wan/h9mDjF1rjAHwx+U9MoXLYnmdRdS9dkBWTqoSnC76Tl3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=XZ/Z2KkF; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=x0SKRvDE6ZapjT+40A6DALNL86vb98Wp6zO2cfl/34k=;
	b=XZ/Z2KkFHfzS6zjucGnkxcKJfrV5e/jciy7zPCClNvYb0Fq/LwAHHfmcRMcIRe
	eWavCsBYzCV2eYKy5hfPJ6B9I2JAGRfE7MUSCzkvgPDuORzZs5L7EejXxD6Nvjwb
	4eiKiM7pzY1lUxVSnrh37sidwiHHeyXS7eS+t1e1eGNWc=
Received: from [192.168.31.105] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAnJ5FqcnJoPL9uAA--.5057S2;
	Sat, 12 Jul 2025 22:34:21 +0800 (CST)
Message-ID: <d3ee67bf-d825-4ea3-a684-010844ef3db1@yeah.net>
Date: Sat, 12 Jul 2025 22:34:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [stable 6.12+] x86/pkeys: Simplify PKRU update in signal frame
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable <stable@vger.kernel.org>, "Chang S. Bae"
 <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
References: <103664a92055a889a08cfc7bbe30084c6cb96eda.camel@decadent.org.uk>
 <2025062022-upchuck-headless-0475@gregkh>
 <2025062025-requisite-calcium-ebfa@gregkh>
 <38359c8a4f1edce6a44ea55f9f946b4adb39e92f.camel@decadent.org.uk>
 <2025070222-refurbish-aneurism-3f08@gregkh>
Content-Language: en-US
From: Larry Wei <larryw3i@yeah.net>
In-Reply-To: <2025070222-refurbish-aneurism-3f08@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgAnJ5FqcnJoPL9uAA--.5057S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy7KFW8ZFyfGFW8uF4xCrg_yoW8Kr15pr
	18Jr1UXryUJr18Jr1UJr1UJryUJr18Jw1UJr1UJF1UJr1UJF1jqr1UXr1jgr1UJr48Jr1U
	Jr1UJryUZr1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkcT9UUUUU=
X-CM-SenderInfo: xodu25vztlq5hhdkh0dhw/1tbiIg9uqmhycm+7BAAA3R

Thank you all! ❤️ Debian.

Probe URL: https://linux-hardware.org/?probe=070604e5c4
larry@zx2:~/Downloads$ fastfetch
         _,met$$$$$gg.          larry@zx2
      ,g$$$$$$$$$$$$$$$P.       ---------
    ,g$$P""       """Y$$.".     OS: Debian GNU/Linux 13 (trixie) x86_64
   ,$$P'              `$$$.     Host: GDC-1461 (TBD)
',$$P       ,ggs.     `$$b:    Kernel: Linux 6.12.37+deb13-amd64
`d$$'     ,$P"'   .    $$$     Uptime: 27 mins
  $$P      d$'     ,    $$P     Packages: 8774 (dpkg)
  $$:      $$.   -    ,d$$'     Shell: bash 5.2.37
  $$;      Y$b._   _,d$P'       DE: GNOME 48.2
  Y$$.    `.`"Y$$$$P"'          WM: Mutter (X11)
  `$$b      "-.__               WM Theme: Yaru
   `Y$$b                        Theme: Yaru [GTK2/3/4]
    `Y$$.                       Icons: Yaru [GTK2/3/4]
      `$$b.                     Font: Cantarell (11pt) [GTK2/3/4]
        `Y$$b.                  Cursor: Yaru (24px)
          `"Y$b._               Terminal: /dev/pts/10
              `""""             CPU: ZHAOXIN KaiXian KX-6000G/4 (4) @ 
3.30 GHz
                                GPU: Zhaoxin KX-6000G C-1080 GPU
                                Memory: 2.65 GiB / 30.60 GiB (9%)
                                Swap: 0 B / 980.00 MiB (0%)
                                Disk (/): 121.87 GiB / 466.48 GiB (26%) 
- ext4
                                Local IP (wlp5s0): 192.168.31.203/24
                                Battery (BASE-BAT): 100% [AC Connected]
                                Locale: en_US.UTF-8




On 7/2/25 16:06, Greg KH wrote:
> Ok, thanks, will go try that now...


