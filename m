Return-Path: <stable+bounces-188924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210DBBFACFF
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BCA584856
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40630146E;
	Wed, 22 Oct 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BYvK1sp3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44253B1AB
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120536; cv=none; b=W0S70qWaLUkIRcuHJzdi/UEe1NdIlpxeYVkQGcr0R1VgnP8uZRnSxoovL6dvK28CLPgNFvJG/EN6lXtJVCPolIlfr0QIZ3RrMLENK2bB2MTJ+OIFOZ9MUmaN8poDNl5Z2PKYk1eb3yF0zSaQLRHlUneL8jpeKHP9Z0Xr6hytEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120536; c=relaxed/simple;
	bh=yHZI+oRRybgwHU8EgfjqgnH/F8s2S0X03JL8R3MevwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5GRD1Aux/XFoKH4AdpfmVKeKbi06zwXs1TZZG0CjABWWuzx0a+xhPFXO/sUXRbGnKlz/4dulJ5801mNM6rgf88oSLfCnOYNzfbjXvIR04BdA6IP646J5pGCD2Tn1aGJTKgfFpqBmyPe6XHOHeTovIFDClcOYxVwYJW9t0VTYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BYvK1sp3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47114a40161so23168685e9.3
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761120533; x=1761725333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcnB1vPCv4/5O7NSkhwvuNPMqNZtj/H/Vxellyl6lWw=;
        b=BYvK1sp3gR3oz+UQv2uDnEbcVJG9VFJ+2kpOhSYK1voIenIe/TRiRfpDQV4fwdLoRO
         CF3xMkG43+l9h00q6CZdG46OEn0ohf1hgQVdwDzjAPKhTr6d/CKLTG4k/8QaeWaAeyiw
         e298W0SjFOI7CLE88/o9Q5yo94m17xyBd0d89UAo7XXuoWCqsrmTHmYzHtjypihKdoQw
         a1xqITSdtAQwxTISxU2D9RRxcx9BoaoBQp1RttKd6Pd8r++Hvn/4tmlpn+SGAVKjZOnf
         TMsXErKSiP4n1YUlb6KAP4Bw9CJB2s+PbcAsxhWFpcBczFpIEPSjBX+KhJZX88FT5zsR
         jGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120533; x=1761725333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcnB1vPCv4/5O7NSkhwvuNPMqNZtj/H/Vxellyl6lWw=;
        b=QTXPxeRIgjYZ0w8orDtp7IArKiVNwjtntXCrJKMKLWEUqRq5pBZkzxA+JERSQ7B5yg
         iHFhw86ck+4EfjMrkNPhpng+Z8h98X7sJhcPI5iPdHvCazTNwA+MyfMioI2qIc2BEw2C
         Cy7mmN9kyAAEWTjaLLWyiNa4If09l6+Q5LmnQ5Tu6CmAisn4P3iH55RDx9oO/ZESOxca
         xHHTOWn8boH7AfOZYlYOPpaa2oduIJrPTv1Qo5MJWgJqv3qlby/vbbvFBt8W3oa1gbru
         bqD0AvzoZdgSDn0F6VtHxi7AkD6qjzNJdhheh/WN9hUb+3Xe/rQ6kbUHstgI92GvfvOx
         /KTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMRKybXdXqZE2Gv6cGekMfB2BkLBRhLMok/FaaQ0eoTH3jUGEeJqZjrpvaOmY7kpQwxkFgmCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzop4sunY7bFURCwwW4TrN2067Ia6VPSKgduAoJH3dDdSQiotPU
	7E8ejcnhQsSiaWsRbql2AkBhKDZ66V2dlhntqjHjB00IEbcTmkMojTs=
X-Gm-Gg: ASbGncu3QpN30I8lZRXUGFoV3chHMmMUcSg//BZB+utncrnObpQrJJmMOkUPToe5wIW
	QkkP2Ub85OM0HocPQ5bR7UYbonHpEb+3iAHa6qARbaKDMidPX8lKKJdoAt9GIZGREQRQc0amBR6
	WVV1ZBveSf9BLPO3uh34u+AdMpmyDZSRkUYu17OnZ/OzZI8G/bKgiaemaCgMnBTATR7tnYcw7LS
	bnLwniFzohrcb+gmIpjLPdJ6Q5Dwu0Ka5gmR5qwYuWONWY0X5CvkjpeN2U42aC8fz1A56LnS0sp
	M59y+MV3y7IAFJQraRgNXsdWaQK5FRiFVX4/JYFdXgrMHh4qbWctE+38hTBkHF4Qyz1jdtWdNj0
	avCQcBljRdve0gKFVWsyBGOMwiUVFUcH68Jjzym3WzR2WZTDPosxGokV8VdUxW48dldJewzhrPw
	dDeFaLVDeuXHn1/IfPYQSThUDLodKoxyK1A23dCzYAqr955Ty+JJgGXOc4+avBIQ==
X-Google-Smtp-Source: AGHT+IF/cCvzRlFyWOqSA/Xn2hsqVgkC6A23PcoYB3/ncn63CK7+kyxojS9N24qzW1KCsixw1CexVg==
X-Received: by 2002:a05:600c:6085:b0:471:133c:4b9a with SMTP id 5b1f17b1804b1-4711786c79emr171726605e9.6.1761120532780;
        Wed, 22 Oct 2025 01:08:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428a534sm35770345e9.6.2025.10.22.01.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:08:52 -0700 (PDT)
Message-ID: <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
Date: Wed, 22 Oct 2025 10:08:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
Content-Language: de-DE
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

thanks very much for your quick response!

(adding Thorsten to CC)


Am 22.10.2025 um 08:51 schrieb Thomas Zimmermann:
> Hi
> 
> Am 22.10.25 um 05:27 schrieb Peter Schneider:
>> #regzbot introduced: 6f719373b943a955fee6fc2012aed207b65e2854
>>
>> Hi all,
>>
>> I have encountered a serious (for me) regression with 6.18-rc2 on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. After 
>> booting, my console screen goes blank and stays blank. 6.18-rc1 was still fine.
>>
>> The machine has an Asus Z9PE-D16 server mainboard with an onboard ASpeed AST2300 VGA chip with 16MB VRAM. I have 
>> attached an older HP Monitor to it via old VGA jack/cable. It also has a second graphics card in a PCI-E slot; an 
>> older NVidia GTX 560. It is not connected to a monitor, but I have configured it via kernel command line for PCI-pass- 
>> through to VMs running on this server (I use Proxmox VE, i.e. QEMU/KVM virtual machines). Currently, no VMs use this 
>> yet, and also no VMs are autostarting with machine boot. So when this regression occurs, the server is idle. Pressing 
>> a key on the keyboard does not make the screen come alive. The server is running fine though, and I can access it via 
>> SSH. It just has no graphic output anymore. In case this is important, the machine also has a ASMB6 BMC (can be used 
>> via http).
>>
>> I have attached dmesg output from both 6.18-rc1 which is fine, and 6.18-rc2 which exhibits this bug. I have bisected 
>> the issue, please see attached git bisect.log.
> 
> Thanks for the detailed bug report.
> 
> Attached is a patch that partially reverts the broken commit. Could you please apply it on top of the broken kernel and 
> report on the results?
> 
> Best regards
> Thomas


Your patch applied cleanly against 6.18-rc2 and the kernel built fine, but unfortunately it did not solve the issue: my 
console screen stays blank after booting. This is regardless whether I do a soft reboot, press the reset button or power 
cycle and do a cold boot. They are all the same.


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

