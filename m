Return-Path: <stable+bounces-2769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA54E7FA51A
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 16:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D12D1F20F03
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D43455D;
	Mon, 27 Nov 2023 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtp.livemail.co.uk (smtp-out-60.livemail.co.uk [213.171.216.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD9019A;
	Mon, 27 Nov 2023 07:46:37 -0800 (PST)
Received: from laptop (host-78-146-56-151.as13285.net [78.146.56.151])
	(Authenticated sender: malcolm@5harts.com)
	by smtp.livemail.co.uk (Postfix) with ESMTPSA id 8A24EC5A54;
	Mon, 27 Nov 2023 15:46:25 +0000 (GMT)
References: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
 <ZWSckMPyqJl4Ebib@finisterre.sirena.org.uk> <87leajgqz1.fsf@5harts.com>
 <08590a87-e10c-4d05-9c4f-39d170a17832@amd.com>
User-agent: mu4e 1.8.15; emacs 29.1
From: Malcolm Hart <malcolm@5harts.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mark Brown <broonie@kernel.org>, Sven Frotscher
 <sven.frotscher@gmail.com>, git@augustwikerfors.se,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, stable@vger.kernel.org
Subject: Re: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
Date: Mon, 27 Nov 2023 15:44:37 +0000
In-reply-to: <08590a87-e10c-4d05-9c4f-39d170a17832@amd.com>
Message-ID: <87h6l72o8f.fsf@5harts.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



From da1e023a39987c1bc2d5b27ecf659d61d9a4724c Mon Sep 17 00:00:00 2001
From: foolishhart <62256078+foolishhart@users.noreply.github.com>
Date: Mon, 27 Nov 2023 11:51:04 +0000
Subject: [PATCH] Update acp6x-mach.c

Added 	ASUSTeK COMPUTER INC  "E1504FA" to quirks file to enable microphone array on ASUS Vivobook GO 15.
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 15a864dcd7bd3a..3babb17a56bb55 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {



Signed-off-by: Malcolm Hart <malcolm@5harts.com>





Mario Limonciello <mario.limonciello@amd.com> writes:

> On 11/27/2023 09:23, Malcolm Hart wrote:
>>  From da1e023a39987c1bc2d5b27ecf659d61d9a4724c Mon Sep 17 00:00:00
>> 2001
>> From: foolishhart <62256078+foolishhart@users.noreply.github.com>
>> Date: Mon, 27 Nov 2023 11:51:04 +0000
>> Subject: [PATCH] Update acp6x-mach.c
>> Added 	ASUSTeK COMPUTER INC  "E1504FA" to quirks file to
>> enable microphone array on ASUS Vivobook GO 15.
>
> You're missing a Signed-off-by: tag.
> Also as this should be going to stable you should have a tag for:
>
> Cc: stable@vger.kernel.org
>
>> ---
>>   sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>> diff --git a/sound/soc/amd/yc/acp6x-mach.c
>> b/sound/soc/amd/yc/acp6x-mach.c
>> index 15a864dcd7bd3a..3babb17a56bb55 100644
>> --- a/sound/soc/amd/yc/acp6x-mach.c
>> +++ b/sound/soc/amd/yc/acp6x-mach.c
>> @@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>>   			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
>>   		}
>>   	},
>> +	{
>> +		.driver_data = &acp6x_card,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
>> +		}
>> +	},
>>   	{
>>   		.driver_data = &acp6x_card,
>>   		.matches = {
>> Mark Brown <broonie@kernel.org> writes:
>> 
>>> [[PGP Signed Part:Undecided]]
>>> On Mon, Nov 27, 2023 at 12:24:59PM +0000, Malcolm Hart wrote:
>>>> Like other ASUS models the Asus Vivobook E1504FA requires an entry in
>>>> the quirk list to enable the internal microphone.
>>>>
>>>> Showing
>>>> with 7 additions and 0 deletions.
>>>> 7 changes: 7 additions & 0 deletions 7
>>>> sound/soc/amd/yc/acp6x-mach.c
>>>> @@ -283,6 +283,13 @@ static const struct dmi_system_id
>>>> yc_acp_quirk_table[] = {
>>>
>>> The patch appears to have been unusably corrupted by your e-mail
>>> software and is also missing a Signed-off-by.  See email-cleints.rst for
>>> some suggestions on configuring things, or it might be worth looking
>>> into b4 and it's web submission endpoint:
>>>
>>>     https://b4.docs.kernel.org/en/latest/
>>>
>>> [[End of PGP Signed Part]]
>> 


