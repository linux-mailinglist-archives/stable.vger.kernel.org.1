Return-Path: <stable+bounces-27125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDB4875C5F
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 03:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060E8B21DBE
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 02:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BEC28DB3;
	Fri,  8 Mar 2024 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EvzK9J/n";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cDLl+BPx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="f+cloPI6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836155C8B;
	Fri,  8 Mar 2024 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865683; cv=fail; b=MRPTm+UW2AfhneRl445dTewoQ17pRx8Djw4d/2qbEZa1A8+1PrrTIRL1BGvfvJpntKyME14aOER9eG7V6FLnNFa9ToXYdS6AMLLMc86ciMHqtGgwamPht6epRIWB+3H6e7c0MUaxWy12fDPrRjyUsb0q0h2Orz8TrgMYilNkw6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865683; c=relaxed/simple;
	bh=LndmdE5mjRQ1pPwvPw8AfNt5+/i5sdm2WbFeFs8dV4s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B5xWbTDpoT0ekYAfTgwoOvAujYJv4kPq1r1WtBIxaMtDquGuPQXa//BU5oKFIokhBF1ueXaPb5j26t0U4PB4Mt6p5wVxdB6mUc0gs63TGas4ZDzSJa9uaR8xaonkCU/cQg5CQ7yQYEuxquZGFH37a3Y9JcvCS4BmgAZB7x9fmJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EvzK9J/n; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cDLl+BPx; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=f+cloPI6 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427Kpxok004401;
	Thu, 7 Mar 2024 18:41:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=pQL2
	G3moONdf+8UUNqoLHEKYdqMpnqB1RL9pj375100=; b=EvzK9J/nCW5YTgB6n2/2
	Hf3opyuQuXUwniw2KKR5hD/C7t1kplCVZ01xtYfvFOQCvlIRnqTkh+wb1F/7sW8f
	TEQEtZmjewjOFqyvAc2RhBHl6pOKCrVr4sKG/VKHF1za3JV/3yiXh59C3B6TeOxL
	qgNwXuLOqHMHEuN/Zy9utk31JqoxSetywDAsveiMtod8nI5WaM17G5vN0ONrRze4
	urRNyMQjkJXmDfdB6moWuQMq3Mmk8/kR1rfQgxWZwo9wHaSk+uXO9RDF0ColV/c7
	xz1tJCiTlZwMgjzI2IXOKa6kRbymqq6AKBTLfqGj4MExlqFNEIVoYTPlE1t9P6IM
	fQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wm40qgdt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 18:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1709865631; bh=LndmdE5mjRQ1pPwvPw8AfNt5+/i5sdm2WbFeFs8dV4s=;
	h=From:To:CC:Subject:Date:From;
	b=cDLl+BPxl+j5UtXbA9mQPsaY3e0hRgz7sR23yodpfgfy9R8IbwOiKllAKArz+iC6Y
	 iZDfetL63uZUOZpK0aX1EG9OJTcXC0GUaFBYRBfE8t4POPD8MQPqDwcPM+Pas8Ri9B
	 VJKwNiU4o8b/kzlfEMIJUbyTQOPLFOvGXeG5um7TzAqmWinIaCqO0BBCPwnI7TjUNe
	 QFXv3fVcdG6Rm0kMOc/4hXxwTXrRiL0RujraL7sFSPn65i8cipujAL/642Ew3JOetD
	 ygcnq5YOjNWwANlJHPBdj+KlVRHF8x/5+zKnuHjwRInAPV3Ccr7xTnnCFy9ydMgNG8
	 Ju158h3SEBArA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5BECD4035A;
	Fri,  8 Mar 2024 02:40:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 0BD2CA0071;
	Fri,  8 Mar 2024 02:40:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=f+cloPI6;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2A88440235;
	Fri,  8 Mar 2024 02:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVVnIlHbd9guJb5rBG8t1RoI6in7eDgOUKRwQuMczI2BJ8+MYNieoePT96Yktyc893NeZXiZQGIOQ+EEDV2WRMSVt+YO+y+xS1We8LCZddfSuW7ELOsbbLKD9rd1dUw2VrMKROnBazTUJz26f24HefkH53TOFciq2BJvEaxoVeraWTFZA1EU9mQsbd+bA6D6Gk9CAVnIYMccEioV2BQW9Rg1G9QsOW8xvIVdwiO86ENjdNiZzHxWNFfe3gyHGCNpH71gHCs8Z1raYOJhkiBucUjvqrFcEjTM1YlZYsAeQuXFKLivc1aoUWVth+C/qExC78jPlE1NVsP4CLz/xmtMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQL2G3moONdf+8UUNqoLHEKYdqMpnqB1RL9pj375100=;
 b=RCuqSDGMGRtFcdQaIOzEpMm/qNq16tHpLS6/EAjn6ul1pzfyR6PSfMkhIcoEbWqqMMnXb9x2HsmPa1b6RPjmN8iCSMiR0d1PaFUNol7Od5He2NSqPVnJH7JFNqB9DSH4jTjvyt2kVmP+JXC76kzgMlPjSZuOmIg7P0WAHlCySFcK8/NuNBUpFVxswYdTfUGGR02ddOrppqRxZ105Yexb6947+HmWrYntLqZFWH5dCNMjJrtNIKz46vw9M87Ty1KArwRa9PyRfDo5cDx1SyBkWPszmH58Fzp4ms+w+ZNPqo7+cs18SApef3Wa7gultkK5fBogt8YqVdEwrkwoJnu/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQL2G3moONdf+8UUNqoLHEKYdqMpnqB1RL9pj375100=;
 b=f+cloPI6Bqhp1LqSp47HO+uYIyADQC1+qeNVr8iu44jP7JsYUI9utBuHEwsYWm5c0uHDuGoKypBxdYWsJ8VDzsTRplEVN2m90pNcG559xUicdBq2afMOnfGTHdjpfHO+mA+n4FTiP9l9oUmWoaU8omnqIumKsIjoePENJ96kPVw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 02:40:25 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 02:40:25 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        Guilherme G.Piccoli <gpiccoli@igalia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: Properly set system wakeup
Thread-Topic: [PATCH] usb: dwc3: Properly set system wakeup
Thread-Index: AQHacQH5WA93E3+nbk+4E8/DCd+zxA==
Date: Fri, 8 Mar 2024 02:40:25 +0000
Message-ID: 
 <667cfda7009b502e08462c8fb3f65841d103cc0a.1709865476.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB9047:EE_
x-ms-office365-filtering-correlation-id: 9d9eab1c-c8ea-4289-81e7-08dc3f191bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DtlkYZSpMEQtBmm7fu1kYuo+oKRZe/+XNs7dwriOd/9rE+cYhDtiIq9i3UT4D2iSjC1nsaCirxu0xHUcYwRno5xF8Jr56i6ZnrL5WdmNnx1VHX+Y1JEG2UfQrOTjX4eQIwKlX6tycXk3HXEl5Jr3nro5m5BsCSTFaln/puX3/Wa6LrcDQc1JS+w0ftT3Ns7NmjCh7gXs8+4iGkoun+1BZO+A2CAUN+QTYI5ofoAtin9fzCFHw3LVt7KE7ZW8pfy4pJaLwVE3Rg/zDhjyfLpNKeGLYhZAOcBWopdXg7HmD5Mn6Qw0J62N7kGpZNojBO6W6llSN3raM0GCIWtBovcvi5gZIIxishWOHCxSG71JUNT24Bj4KsdoZiyqGt2pJe2qDPv2q3KUgoj0+X7chd+VVHhdBdD7UBwAul6bVw8WoZhhwRxPnhrTzsSlbY+xiOwoT+Kpknq8WITVeZSf7xJC/z4He7+gLdmDIWyBwR3/c//ZoYuQqKdEWrHw95wO9S3WkArLhfrnTZi7cehuUUy+ivfDjTtNYkSSto4SURul5rq55YTUaTDNzk/ykHwbb4OKpaV8cDDe+OD9XSD2s99YY+9sgLRqulukI/2kqxldeSvTKUD43476pTs1PxUxeUHgtUo35SGicTf4371orQ8h1OiyV5xi6zOp4by2NzjqXus=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?oqs5/34LwxixLgoZ/RTk83o1hbmA30s6WAJKMFkTNc6lmak3RTFvg5XHof?=
 =?iso-8859-1?Q?Znkp7WXc0rfEs0nkruqwaFyS5azYEbhQJy9GzpSsAp9aDjvKjv6CJwhRkh?=
 =?iso-8859-1?Q?DN8H12GJevCngbIIkulCT4Ix+mWo4A5oFsyLm8lc5/5SDeY0eKLY3ABoLv?=
 =?iso-8859-1?Q?gHpU2tstfmyApARAlPKF8DECBsvexs20/PLStwFEBRrv6mGlQ8SLETHsPW?=
 =?iso-8859-1?Q?TgaVDd+z1CeM4jSANiVzc2IU9VgGoktrydq5GYuCDh++WmXzenGSlRQ2eC?=
 =?iso-8859-1?Q?DT5lV8Eruy5Oy5lGPMtIB1Wiph0ai39IVBDbzQt1Af66rBtOJN3tYOzt4Q?=
 =?iso-8859-1?Q?YCUtiMn79MWhA2hJc1yotWne5cZGKuGTabCkdAjrdTUOAWTuq/rc2iLyR/?=
 =?iso-8859-1?Q?4tUCnKP0EjTO4ZJcmxEPlgVoG0t6GcvmeLhMFoKZ8orsjaQ8osIQdy0Jjf?=
 =?iso-8859-1?Q?2usR53rg96ccKjbqPSX/YRNL/uB7Zb5c23y8sQq1YIY2xZbKLg/7+7Za48?=
 =?iso-8859-1?Q?oczFWmUnZNQdwCF8rCD249MHOS4A5ROsYkytgqdtPNShnXT9nJ6jmQHyMT?=
 =?iso-8859-1?Q?eSgo53rOSx12OlcNa1PkN4C/V+OYKkn4x6kRWWwhxM5nvAE+Na17R8zrz+?=
 =?iso-8859-1?Q?Y4Exbtl8xstPCEsZJwqfnWwRpQqIdtu8p/ke3Gh3J/ZM0OhCZ5pwH3A4ii?=
 =?iso-8859-1?Q?PZ7fF2AtQjQLNpjLqORH3yLVE0hDl3lyfCHxLTC2nZtFLrJwFq6uyypk6z?=
 =?iso-8859-1?Q?Y+XcBqCcqbfvfxFTYTBMqnaHQXTx57cNjdvdLsNqzapNSKJDnJkUcNPw6p?=
 =?iso-8859-1?Q?Dew4AR7gCAfX/GgwrhMN34Zw4CGtK2TlNEoUYhu6PJj6Rc5XV6X8Frq7fp?=
 =?iso-8859-1?Q?lsJ6IhoVJ763sLtmhcvo/jLIqyqYSLuzs4sLBPN73g2x35Cg2kx2U12bU2?=
 =?iso-8859-1?Q?lpDcFljFqOlSQ4EJQS6Z9yyOi2dqshG8qs2yTa/1sYbFuN3dgqeUveXbY0?=
 =?iso-8859-1?Q?/nSmt4TtNOVRrnjpEyhKtyafcm1ehyQimhOOVbgce511tYOp5IjdePUZDZ?=
 =?iso-8859-1?Q?GqgHL0oZ+cwKKCN6TDLC6r13ShiOJpcvWUCoPqP4myHT6Z2/Ww4aRHxekQ?=
 =?iso-8859-1?Q?xrj5PXHXPKvKZ30TqF8TWux6GfmF+sYcfa/pHBuexkpTH4uArwvHJi95MP?=
 =?iso-8859-1?Q?ykygNZ678d6c5DfVAlpSRiVZOSVkHkSsEqcERUsHJmQHdGKxGteuGLJUs+?=
 =?iso-8859-1?Q?VeS1EaH9erc/R8GAUyMGck2VuyKJWeGZG2RdbEoc5QYP3eWzXgxJ7/CNBF?=
 =?iso-8859-1?Q?F9zSmEc2VjgK1BO9urJAM4wFwrR09qXnRGKAvERCfgSy8IkYWoq4Hmn7Aq?=
 =?iso-8859-1?Q?sBFwlcseUtLddSIgO/RqZRAOqeB51gVoBkfgZEsR4rJEO//+R9DwVdmQ7j?=
 =?iso-8859-1?Q?Cm5YUX94vjFGkKTekS5Twludcywt6VZK70dTBRtWtADl/YXHWiWfYy/KbL?=
 =?iso-8859-1?Q?Em2PQDhYL7WKUJ6eTPO+Mk8uqaFek0jfL/1/pbREkHcUYAlYhUwpMrUcrH?=
 =?iso-8859-1?Q?eacndHOOG6zAg9t1DPGT+Ziu9NL3JSZlDIxArnItXpl2Q5VQtaqgk3sY8e?=
 =?iso-8859-1?Q?7xiaRcJQTlhFo674Q/r3f4VMPCHaUokD35?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	on4X23MgZyDFq9M5LerIkrT/uYoyeOR00DMFLBsafVKX0ni/df2aVPNYH+WzNuYEu3PqDbrWwIhr2goornZjPf+RgEoRbckPjNgDgWLwM05x6Emvy6S8ep7tR9/CoBIluELMhCf3dOF0ZWe5p1SfUk2VTEFET6dAa5DzxS/D1H8u5Z7EE70L68t+7Y5Jmr5eK6+rEzS0jiIFmCxREDWI58zNcymA9CAgFJFJ0LWzIroYRQPestHPeB2pbxCiY5/m7pXmPPvaIw6hl1HvRZRm92wkqNBX+++6wQhrOvIvXfBx0z84/TmO8rpPPrIl5lgns0H7YZgnfp6hsYz+uKLZtUAHbrChrnozlQQbEUCjo5/btg22GqAG8pLvJmKBOXNVb2CeuB6zEqC0vbrr9GLaYyVBb/tpo9QEyNru914Ot52Z0rutPtNh+YUqZlywVLzKQQH/t/qA3wIJCPFTqw3n3GGrcVDuq0kQn/v5anNWGFjYMvHhhky8a5tOEG1AvDgJvpgMQYDAfXu5ldrmpxp7XVNGHbMK/LjLg7Iovh2hsbnqtuUMFnG1kWMBWfx+BxWDRPB3bxsEZkIsrtOuuIS0WTExG1gqxsvtsI3GIZR4FnaPon7VB7gYGWTOr/mj53trzVe/xljsPr7nswdyuBDO4Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9eab1c-c8ea-4289-81e7-08dc3f191bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 02:40:25.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yS55g848E2GZiddrVmyQSD4GixBJ+vGWPHpKl6IOYGeebyRrXWmoC3mAZcGoHcujX3guZAe6dtJ5FcI93/bRgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
X-Proofpoint-ORIG-GUID: 1KlaKqZ_GTR-OKvm_TkDbAz0_ipvXUn1
X-Proofpoint-GUID: 1KlaKqZ_GTR-OKvm_TkDbAz0_ipvXUn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_01,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=781 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080021

If the device is configured for system wakeup, then make sure that the
xHCI driver knows about it and make sure to permit wakeup only at the
appropriate time.

For host mode, if the controller goes through the dwc3 code path, then a
child xHCI platform device is created. Make sure the platform device
also inherits the wakeup setting for xHCI to enable remote wakeup.

For device mode, make sure to disable system wakeup if no gadget driver
is bound. We may experience unwanted system wakeup due to the wakeup
signal from the controller PMU detecting connection/disconnection when
in low power (D3). E.g. In the case of Steam Deck, the PCI PME prevents
the system staying in suspend.

Cc: stable@vger.kernel.org
Reported-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Closes: https://lore.kernel.org/linux-usb/70a7692d-647c-9be7-00a6-06fc60f77=
294@igalia.com/T/#mf00d6669c2eff7b308d1162acd1d66c09f0853c7
Fixes: d07e8819a03d ("usb: dwc3: add xHCI Host support")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/core.c   |  2 ++
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 10 ++++++++++
 drivers/usb/dwc3/host.c   | 11 +++++++++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3e55838c0001..31684cdaaae3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1519,6 +1519,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	else
 		dwc->sysdev =3D dwc->dev;
=20
+	dwc->sys_wakeup =3D device_may_wakeup(dwc->sysdev);
+
 	ret =3D device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
 	if (ret >=3D 0) {
 		dwc->usb_psy =3D power_supply_get_by_name(usb_psy_name);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e120611a5174..893b1e694efe 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1132,6 +1132,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
@@ -1355,6 +1356,7 @@ struct dwc3 {
=20
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
=20
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 28f49400f3e8..07820b1a88a2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2968,6 +2968,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	dwc->gadget_driver	=3D driver;
 	spin_unlock_irqrestore(&dwc->lock, flags);
=20
+	if (dwc->sys_wakeup)
+		device_wakeup_enable(dwc->sysdev);
+
 	return 0;
 }
=20
@@ -2983,6 +2986,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	struct dwc3		*dwc =3D gadget_to_dwc(g);
 	unsigned long		flags;
=20
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	=3D NULL;
 	dwc->max_cfg_eps =3D 0;
@@ -4664,6 +4670,10 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	else
 		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
=20
+	/* No system wakeup if no gadget driver bound */
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	return 0;
=20
 err5:
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 43230915323c..f6a020d77fa1 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -123,6 +123,14 @@ int dwc3_host_init(struct dwc3 *dwc)
 		goto err;
 	}
=20
+	if (dwc->sys_wakeup) {
+		/* Restore wakeup setting if switched from device */
+		device_wakeup_enable(dwc->sysdev);
+
+		/* Pass on wakeup setting to the new xhci platform device */
+		device_init_wakeup(&xhci->dev, true);
+	}
+
 	return 0;
 err:
 	platform_device_put(xhci);
@@ -131,6 +139,9 @@ int dwc3_host_init(struct dwc3 *dwc)
=20
 void dwc3_host_exit(struct dwc3 *dwc)
 {
+	if (dwc->sys_wakeup)
+		device_init_wakeup(&dwc->xhci->dev, false);
+
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci =3D NULL;
 }

base-commit: b234c70fefa7532d34ebee104de64cc16f1b21e4
--=20
2.28.0

