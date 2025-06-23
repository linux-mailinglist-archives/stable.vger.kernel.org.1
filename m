Return-Path: <stable+bounces-155326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B89AE399B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FEA1671F4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB042232392;
	Mon, 23 Jun 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TMGbPh7n"
X-Original-To: stable@vger.kernel.org
Received: from mail-m15590.qiye.163.com (mail-m15590.qiye.163.com [101.71.155.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39463A9;
	Mon, 23 Jun 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670038; cv=none; b=qeo7p9To4JvKdYlx+RwpMSK3s+jypSLLaSwp4OjeJc3gyZAmWmpe38/YD1j4/NeOxX40e6xtgn0uaXtBnc457ydDRMp7/xAyHep9GBp0GG18ydAe59ZpnhbaAPfPG/EErKZKhdSfOLXAjd3lnaisTkZo+7nh5mFMsnRw4293zEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670038; c=relaxed/simple;
	bh=rot3WInRgfCoXSQnTjnLS77VTpo+YcJ/anVZEHawAkc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WJyVaPTKzGoR6yVslr8ywZQMvw6FYqony8dIqUE0bhE7KdsbvBP8lseK/Ih6PQR7it9fdFCSvWBzojZOhwcSb7hchqdowk3W2RhLH6UUcXcMVvej+6SrYxTc6oD+G9HU63NGyiRF4EKSnjMldKNqK0hfbAh/39SXEowfix6YEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TMGbPh7n; arc=none smtp.client-ip=101.71.155.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 199b4e06c;
	Mon, 23 Jun 2025 17:13:44 +0800 (GMT+08:00)
Message-ID: <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
Date: Mon, 23 Jun 2025 17:13:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 1108065@bugs.debian.org, stable@vger.kernel.org, net147@gmail.com
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
To: Salvatore Bonaccorso <carnil@debian.org>, regressions@lists.linux.dev,
 Jeremy Lincicome <w0jrl1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <aFW0ia8Jj4PQtFkS@eldamar.lan> <aFXCv50hth-mafOR@eldamar.lan>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aFXCv50hth-mafOR@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpLH1ZJGE1PQhpOSUNKSUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a979c109e6709cckunm166c0bc88900f9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6LAw5ATEwKCM5NzBONh4W
	CSkaCxRVSlVKTE5LTUxLS0lOTkhIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlDSU83Bg++
DKIM-Signature:a=rsa-sha256;
	b=TMGbPh7nh9+DNCdsyZLDiucsAs/DU1OoHkwdIeDhQkX8XS0zJWrFNYMJNXtV6gfFUPNx83cvfprtGA8R8YbYDnbjAG/3jELTxopIJLBdMsl2FtGQXI5LQRtE8qxpOsOifPY5j3Js5bplcPXCLOJ+MZJ20rXn5YYMm1WmuR3Z16E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=rRS7mqba5IZNQaTjq/rzjK6NiA1kw0qdSnaEJwzGxsg=;
	h=date:mime-version:subject:message-id:from;

+ Jonathan Liu

在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
> On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
>> Hi
>>
>> In Debian we got a regression report booting on a Lenovo IdeaPad 1
>> 15ADA7 dropping finally into the initramfs shell after updating from
>> 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
>> shell:
>>
>> mmc1: mmc_select_hs400 failed, error -110
>> mmc1: error -110 whilst initialising MMC card
>>
>> The original report is at https://bugs.debian.org/1107979 and the
>> reporter tested as well kernel up to 6.15.3 which still fails to boot.
>>
>> Another similar report landed with after the same version update as
>> https://bugs.debian.org/1107979 .
>>
>> I only see three commits touching drivers/mmc between
>> 6.12.30..6.12.32:
>>
>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
>> 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
>> 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
>>
>> I have found a potential similar issue reported in ArchLinux at
>> https://bbs.archlinux.org/viewtopic.php?id=306024
>>
>> I have asked if we can get more information out of the boot, but maybe
>> this regression report already rings  bell for you?

Jonathan reported a similar failure regarding to hs400 on RK3399
platform.
https://lkml.org/lkml/2025/6/19/145

Maybe you could try to revert :
28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing 
parameters")

>>
>> #regzbot introduced v6.12.30..v6.12.32
>> #regzbot link: https://bugs.debian.org/1107979
>> #regzbot link: https://bbs.archlinux.org/viewtopic.php?id=306024
> 
> *sigh* apologies for the "mess", the actual right report is
> https://bugs.debian.org/1108065 (where #1107979 at least has
> similarities or might have the same root cause).
> 
> #regzbot link: https://bugs.debian.org/1108065
> 
> Regards,
> Salvatore
> 
> 


