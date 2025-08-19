Return-Path: <stable+bounces-171784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03047B2C37D
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B546218B7
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC323305077;
	Tue, 19 Aug 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="JRz/UpYi";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b="VXQrdDJw"
X-Original-To: stable@vger.kernel.org
Received: from mail180-9.suw31.mandrillapp.com (mail180-9.suw31.mandrillapp.com [198.2.180.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB330507D
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605863; cv=none; b=cbP3mLFKPTdU09wZKoBTVAW5zxerIj5CJ4rlCShA0ivwOFjPtY02TzplcL9sADtapBUU8sH5WL/J6V/H3mWqmKzaqMJI2QDQOGD9V/dAE4bVWbDD9rB/wqypPtcdf/D+p14QayNqYy7NTTA0TzqEuePyJ3kRrzfoSw0Jb5zsm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605863; c=relaxed/simple;
	bh=X48QDKrjatUwUOBAyLY2EBMfcIzaLXjwx+ncEV8kUxE=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=ZSLd4Eer77/C/tlHSveGZ4rc0+udoWfs7Rm+jDHLwfXhrko7ZazDDJoJxz737Tlad8Ikp9bQkW+bZEPoIfreV87zuQBTaFiAaYoZbb0zcOjq1vqTSussREBg/AUf8NbRmlta+jAHLx9wJZnz/mW6Yy3P5PeKqnmVjManHyV9mjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=JRz/UpYi; dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b=VXQrdDJw; arc=none smtp.client-ip=198.2.180.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1755605860; x=1755875860;
	bh=nNVqSU/naRM8SPZEVeMuqYweB2g7v1bY6O00tCv+qAs=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=JRz/UpYizr7o+cAc+in6zZsrSIpEFly/kIx8BubUPUXkIF2y/FulBnKFm8tpd88Im
	 /j5cwhtHrsp3wzHEG7cdjdi2ZF/bQi53Pl8BNOQ/Q1W1mBznzBVfQLf39a5rLkWVOz
	 QxviMUxVCgFdqz4XCwZdYMUrnyqvEfHk87hb6DqFaauYGGBMGXiXOF3YKNCRY0Odt+
	 VpmDo9TzeWcrRwiwP+6zdqFp3MJz92S+CjrQdxi47Qc6ItLa7cDxF+77b0+qlzidtV
	 nmgdCyFFiuSm8dqz1Yya76qLkw36tcQNP47vDwSV1yddAs79cVmirZo1TWT+ezndZk
	 nSXqpcYg1Xqzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1755605860; x=1755866360; i=yann.sionneau@vates.tech;
	bh=nNVqSU/naRM8SPZEVeMuqYweB2g7v1bY6O00tCv+qAs=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=VXQrdDJwtxQuzBnXThBh6xwzMtnkZOb6GICbG5xoc+pIIz+Qj/plNKpFOCYvkeZVw
	 zYAaLNLuHhSJdlVsCYa+Zi8a67rt+CZ9hcLbxXU52MyTmYbrBlJr10hwAfZFMYm7Nl
	 X4jNg5CnHYDrSnjKvHDFGYyWWbWPGQi0CkEXqMPVq9/ClDwuU8Rm0yFtN6K6Rz2rc6
	 zZB+jPMxqxrEYWUcpC3BoKeV8pXbff1yEldd2x2mqcp0upUQI56m7P0k2DRshijvJs
	 wOTovQ1Cw01CgvoIJ1FSPvUYZiVcQ+9ZJQ/lKCN/voOaQ79WyrRj1LXGcq0XKzToQ6
	 ip4Kb///9mtyw==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-9.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4c5pW84x17zK5vqKY
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:17:40 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH]=20ACPI:=20processor:=20idle:=20Check=20acpi=5Fbus=5Fget=5Fdevice=20return=20value?=
Received: from [37.26.189.201] by mandrillapp.com id aecc7414d1bb4e1fb5ef211ffd9872f6; Tue, 19 Aug 2025 12:17:40 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1755605858517
Message-Id: <6f616f3a-a826-489f-860c-9f25fc42736f@vates.tech>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, "Li Zhong" <floridsleeves@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Teddy Astie" <teddy.astie@vates.tech>, "Dillon C" <dchan@dchan.tech>
References: <20250819115301.83377-1-yann.sionneau@vates.tech> <032a8ac9-0554-49b6-a8e4-fdeb467f8327@vates.tech> <2025081900-compost-bounce-f915@gregkh>
In-Reply-To: <2025081900-compost-bounce-f915@gregkh>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.aecc7414d1bb4e1fb5ef211ffd9872f6?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250819:md
Date: Tue, 19 Aug 2025 12:17:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 8/19/25 14:12, Greg KH wrote:
> On Tue, Aug 19, 2025 at 12:03:05PM +0000, Yann Sionneau wrote:
>> On 8/19/25 14:00, Yann Sionneau wrote:
>>> From: Teddy Astie <teddy.astie@vates.tech>
>>>
>>> Fix a potential NULL pointer dereferences if acpi_bus_get_device happens to fail.
>>> This is backported from commit 2437513a814b3 ("ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value")
>>> This has been tested successfully by the reporter,
>>> see https://xcp-ng.org/forum/topic/10972/xcp-ng-8.3-lts-install-on-minisforum-ms-a2-7945hx
>>>
>>> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
>>> Signed-off-by: Teddy Astie <teddy.astie@vates.tech>
>>> Signed-off-by: Yann Sionneau <yann.sionneau@vates.tech>
>>> Reported-by: Dillon C <dchan@dchan.tech>
>>> Tested-by: Dillon C <dchan@dchan.tech>
>>> ---
>>
>> Hello Greg, all,
>>
>> This should be picked for v5.4, v5.10 and v5.15 branches as it's already
>> been backported in v6.0 and v6.1.
>>
>> I already reached out about this a few weeks ago, I just waited for the
>> patch the be tested before sending it.
> 
> What is the upstream git commit id?

Hi Greg,

commit 2437513a814b ("ACPI: processor: idle: Check acpi_fetch_acpi_dev() 
return value"): 
https://github.com/torvalds/linux/commit/2437513a814b3e93bd02879740a8a06e52e2cf7d

Sorry I should have put "[ Upstream commit XXXX ]" I guess... Will do 
next time. Do I re-send?

-- 


Yann Sionneau | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



