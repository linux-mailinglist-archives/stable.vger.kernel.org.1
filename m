Return-Path: <stable+bounces-169320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EDCB24074
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 07:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F178C170181
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 05:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813D2BE65A;
	Wed, 13 Aug 2025 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mIYkYyfs"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4752BE7DF
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063694; cv=fail; b=ZmDj0qwFBFR1udsxBG902smDczk3wYIZYKKtTEa/Wr4UO8iT2rFlpOUZY1On1498HA7wDF7WTQqlZMpkdfFy6brAI6t/WTmFuD2sUPfROw9XHL/7pNG7BwrHw7kd3dIA5QcFffJ4DSjMTnubLFXKmkiApFzF6g0TtjY9aGWVmfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063694; c=relaxed/simple;
	bh=2YEg+F9I2z751XqWr254uRwc+q2lygP38mTLd8Sc56E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvhtR1oy7uiovRJW6/AM/QNRMWO7T6a8y1z0QZJIkdJgEmYOzEpZrwByFDZ5w2P7NDgPtBsoulE3mc5mbDbyvNq3KX/HYwDlo6GSfIrr2bPjKaNookcdpE+/5ekD/LUW+Q5C2Sw3j4fJxeUWHxXGdDCT+Yz9oujSUtEHsRUEgSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mIYkYyfs; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8bBvEutW4am/TvTWCe9qLGCvKyBJgKSZBZuJ7tGQAcWrGndZh7tGuV6ly/ttBjv3abrWFn6kQaDKBG3FmnQLAKiQVAklOl6YFXv9UJvaN8Kq+knrG2GU4nXi6EgXACfd+fcLRVEV3nGwADAWbNbjMsfSey/9Ze45Rn06rk0pambZg8yT1XDDeecUSMkb9U7CsaUME7EGT+/3lbjzcR6FSHLpdDjDep8nWF5Ew5S2c7JvX50yCQXxOfD2L7EOYh/V2yiKCav098et42o5EkFUkEiIOa53pVGe79N2FnKGHh39cZWXpT9PU53vk/Tu8MzDvUqQxdJRllHcIFcOXxaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyjxiJJL2YMXWhg/dusJrpICXUsL7cj0VayDmXliAbA=;
 b=LsnBQHLaBeB7N5/h09JEgzHOknI1oc/PhszLxxmo2U1RpcuBdmTSAf//tYB+WZQb/5F3prm3ncMcIcbqBQJMkN8B8ZICYCX7pbIM7fUGVikJgSimvulf9Ukj+1XriGgDFD1G+2CkkxTFd8I5bxpHVNjq4rBkNwN7X9QsWedwmCefUJPNA/DbLnz8v0ul+yH4zcNZBoqShYiM6pMJUPaAMtUaa9R4F061lDLB8/3xVo3miz1mBhMZrl9yJFtV8K4Ib55eguUR+FSn6XQ6aZhJtyotgmaopgO2xCJaz+olQzScr6iGZceGWktdGGeiUONXs7DaTnTuzKE9o/Bxr06zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyjxiJJL2YMXWhg/dusJrpICXUsL7cj0VayDmXliAbA=;
 b=mIYkYyfsr7Q1h5Hv8QsW4KftQchm4R4rHXtrxA4KWXxK6GscrlhS6yKOu6JhI3qrW715zBzoUBDjq0Bl/Hxh1AIQNubMjzzgyVEgywOOwTBz3FzW3lRfVuklstH8vkRFvC6Gocgk3W9xKfbcMbgmjLB4vcuLgjyvMPQIIla4u2juJlwVxTeZmjxZbG2WbPdWlN9eU//Q0t14VPbn69h+NAp18aNcXfNRK2mZXDjHIJFc0XVk1zvcOyZeY2wN7uOgO3Tc5HTArc1ArKEK9jOZ01+Q6Z+3o5OUG1SB7+IV2o82WhBx5h9EH1tcDIL6CIG84PTJ+QOhCpQIW7n60fg3mg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9653.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 05:41:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 05:41:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jkosina@suse.com
Subject: [PATCH 6.12.y] HID: apple: avoid setting up battery timer for devices without battery
Date: Wed, 13 Aug 2025 05:41:19 +0000
Message-ID:
 <PN3PR01MB9597957A66A04F2AA0679B56B82AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081201-cupid-custodian-14e8@gregkh>
References: <2025081201-cupid-custodian-14e8@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250813054119.16075-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: b15dda5c-d9d6-4596-c942-08ddda2c0c91
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|15080799012|8060799015|461199028|19110799012|5072599009|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Kbagy50MmgwDs0fM012UsxIVUMWESc7Au90qBJtytWJ3lM+8Otuc/2hpWT5?=
 =?us-ascii?Q?gdyQ4NZnIAel7jBmzpebwJiOmckaa8SksuBrm6Dwo67XA8g9vZJ6Izk7N/3S?=
 =?us-ascii?Q?eI8zJgMZptsQybh3maJ0GFcbUBXPi6B5YPYkT4T/dDMNSg7VL9Jzz7xjbrMW?=
 =?us-ascii?Q?MfO2u1FrV6Lg/sRU2g7+J+zWxYPoGcs32+kY/5VZQAjBD67qDE2ZhjvfWB4d?=
 =?us-ascii?Q?Q7u0jlBFlexrY4p0aUaCtyS36r21Pa23e8LyaK4WhV/jZo3b4CYRGmo7KwWn?=
 =?us-ascii?Q?sh1Ox1ju782100ZLi66yYnuO/FujhxNzZXDkp3YaI5ifIcXR6SW1U6r0YITO?=
 =?us-ascii?Q?VkkU2UWZbdACFe9STbUza690eNOu71NemeV3iEinG2MRotZJqQo/V2OjOVQj?=
 =?us-ascii?Q?BSnrpORmMif5diKG37VQ1Fn5jOKfj5XN1NLUgUFA6pWTBJntzBiOpZ3OE9EO?=
 =?us-ascii?Q?6GA08Sk98E/K6woNcd21gKQf1JooXTnA8l4Ef14dxyG2RHOkkYukyTBgz3PA?=
 =?us-ascii?Q?vHsCmexsE8ybBjZ1iZ1dlVffRbPc2zOpwqU0GjAs2eufa6q1YikWcq5ta94B?=
 =?us-ascii?Q?MQCEs/ViqWz3dPndsFUm48RFgEVzByT6ThYqreHZdsoPvgb8OLTJVMYVKJ7D?=
 =?us-ascii?Q?0H5ycglZd7WAqDhDfCLL1fwH40PIJ1z/P2DCJFoG/6ExsU2dznFkKZLduigN?=
 =?us-ascii?Q?uZOqgHDgZPvfPVr0z9Xn9wTK0MvCI8O/fya0rqm591rUWF9f6UCez69J3t9D?=
 =?us-ascii?Q?6DFIhZ8xhT4WR1qFg+xu3Wbz/21YHEQuT+q7t6wUp9mGAISMp3bCXSRFQXKq?=
 =?us-ascii?Q?oPcNSCBKHX5V1wFcjY5GYpJebsP65DoXI8K0JDYJJCvq5Hjtrp52cyu6Wfcu?=
 =?us-ascii?Q?LrQI04f3hineAU8wMdqDE2vVD4NQ3AVPKk9/kxNY2B8OWoTs45GPsa/dFBus?=
 =?us-ascii?Q?NcM2ax/vre/H/L2agZftrJwkTU0fYXUYVmgn5ej77RJ/DLTp/1wloCQJ8pau?=
 =?us-ascii?Q?dd47YZ2GSMlrsWfCi/0dqFSWqaYilreQcFkGFl4Y+YgCsAKCdTP6vlE2G/+S?=
 =?us-ascii?Q?O+7cv5EYmsOTzNBJXC6hxQM2PioSQpRwhOkccDncNZp0gl09hqiCuME+Xizz?=
 =?us-ascii?Q?J7Qf+DZ1AqiFCrd8theZO7mvSP1ULGX8Nw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ur7kswPvKfzc8FpD7Unn9omY7MpgtLzUfhpyU/2qSHYoGmtgZhW86DXCgzvd?=
 =?us-ascii?Q?7gL4AZIX6sllivPO16JlIN4oR2Ttj3nb7AO+gr2EVKCtNz1dBhOTUjrisZEa?=
 =?us-ascii?Q?1FlgKwPrG0aRjWA0oGPxG9sR8BYwd/5PF4YN0aYjCDuajUhBl88ZA5cRiWZo?=
 =?us-ascii?Q?4kLQ2BVFaHZVmX1Cm4A8BKMC0W4ZPLh2SqEggYucf1HI5hXEArvErdHRVm7X?=
 =?us-ascii?Q?7iZszbvTzs9aay+Vjz5uQIVedr30QlRC1QFw8JXTDrFO5ifO3Hv4XClxeMmn?=
 =?us-ascii?Q?985Hxy9om1pC4K9x+afvOMCAKBytf0QdDefwAvWrrrRiqwAQlAozeP0DeP6P?=
 =?us-ascii?Q?jy9Uqt6K+HRr3fAXbr0eMp1wyu+2loz4ZEJxrR+PqzyGWtFA3JIl9wpnVmg0?=
 =?us-ascii?Q?8Eo5t6ewO+x/i8B8z808GTWA6QLpYiW4Ukc6xBqxg6BCIvJ7G3Cchdlk4Xfv?=
 =?us-ascii?Q?uTaDdByhKcbMR5ImyZYf0iM8OvYbr/38KG5mIDYjfAZKDggqY0nZwajpXdtU?=
 =?us-ascii?Q?TZe8kLCdlVrI8cXlbp99YrY84eKzNVBVpWXvjqeIJT3jh5Vyc8p51u5nR1oB?=
 =?us-ascii?Q?+opf8h4GuXPHWpDTTBI7din9ocjnbtknvGZ2C9ON70hyZaYW/+wyf/EL9jJQ?=
 =?us-ascii?Q?3lA9Atcfwv0KC2TImtIZIZtw5Jn57Exha9id67Kb88j3FpCftjxCgS51+Eaw?=
 =?us-ascii?Q?8KbTs3ArErd53XX1BueY/YvEkLNZiv9DzJB3NaBnvLkjKpH4aitQnsi0RUYw?=
 =?us-ascii?Q?L1hBEmVUFWzwqeSAjrFyeALTXI5162KzVAuG2eP6OEAYAOxSGKJZtGoNAQvs?=
 =?us-ascii?Q?vBzCuTQwZxRIFf0LTet4EmQB0o0zOgTlvNeM1ylCK2IPUoIPZmdXXD0+R6b7?=
 =?us-ascii?Q?pvm6x0HRirh2SCkYewrswS/CJ4Ky57ivxl1mqf+I/PsPDTWt4c9RrIBPWrOb?=
 =?us-ascii?Q?t48iBEsm/wRA99IjXly3pETPNhXve6Dw4wOAaXn/Pk0tPQyNfkRewX9htmOC?=
 =?us-ascii?Q?CzpwSTN+ZkKohM6YHXUpB2xBmue5D28qfzBpndVZ5XRJKufR2Vav2eWr5JHn?=
 =?us-ascii?Q?ADo5WI3avzdw+KwWda0/+i2/5KNmHem9igLbJBi66pMafvRL7XxnMe9u37y5?=
 =?us-ascii?Q?VR6sd/3QkOaxxGOci+VLCTmLNIhV36ipF1spjpko3U0W5OAHwhXlaRcGICmC?=
 =?us-ascii?Q?JB7R0KB7ag6g3iF2BpqvXTIGY0sOPL+PXhQZygO0DDxC1wEMETYeNzM4WsI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b15dda5c-d9d6-4596-c942-08ddda2c0c91
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:41:28.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9653

commit c061046fe9ce3ff31fb9a807144a2630ad349c17 upstream.

Currently, the battery timer is set up for all devices using hid-apple,
irrespective of whether they actually have a battery or not.

APPLE_RDESC_BATTERY is a quirk that indicates the device has a battery
and needs the battery timer. This patch checks for this quirk before
setting up the timer, ensuring that only devices with a battery will
have the timer set up.

Fixes: 6e143293e17a ("HID: apple: Report Magic Keyboard battery over USB")
Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-apple.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index d900dd05c..d7c0e3a2a 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -933,10 +933,12 @@ static int apple_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
-	mod_timer(&asc->battery_timer,
-		  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
-	apple_fetch_battery(hdev);
+	if (quirks & APPLE_RDESC_BATTERY) {
+		timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
+		mod_timer(&asc->battery_timer,
+			  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
+		apple_fetch_battery(hdev);
+	}
 
 	if (quirks & APPLE_BACKLIGHT_CTL)
 		apple_backlight_init(hdev);
@@ -950,7 +952,9 @@ static int apple_probe(struct hid_device *hdev,
 	return 0;
 
 out_err:
-	del_timer_sync(&asc->battery_timer);
+	if (quirks & APPLE_RDESC_BATTERY)
+		del_timer_sync(&asc->battery_timer);
+
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -959,7 +963,8 @@ static void apple_remove(struct hid_device *hdev)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
-	del_timer_sync(&asc->battery_timer);
+	if (asc->quirks & APPLE_RDESC_BATTERY)
+		del_timer_sync(&asc->battery_timer);
 
 	hid_hw_stop(hdev);
 }
-- 
2.50.1


