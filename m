Return-Path: <stable+bounces-124180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91BA5E3D1
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D675E7AB31F
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82E81E3DC9;
	Wed, 12 Mar 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Y3cu8llS";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="AMhCPHMJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F51D54CF;
	Wed, 12 Mar 2025 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805207; cv=fail; b=tToxCyT3+bAOzbwO9osNgJ8UZUvd6b87y9M0cI0rexoJoM1kqNEYp8JUMHskYiAfAUzpzIn/nHDMb18mptw+vfpklZKsG4UZ0hLszYqLxSH5bHeCwt4QS6DN9Cg2p1L7QW1rD/WJWG8ndA7ussMgf+hAIrDAXoGESZvrFTt/BqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805207; c=relaxed/simple;
	bh=rNdMRUvoZX/kxWFzzZGNBS4uKa7mJyLmib+X0z2uS4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/yb+FqbRMQzsO+/ZZwqCNAFWGmzNrmIfNgMwpXDefSUUfMLHPBmjPoUSKd6cxGGMXFIIubisa3qqxYZzlilg6maLeS3CBw7a1BbEG2Y75SKfoKGhkxKZCOJ/f1FWg66LXK4dDDUGZJkHmUu6OSU+CCl2JExbMSZqCXHMuV4oeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Y3cu8llS; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=AMhCPHMJ; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CAugCg003426;
	Wed, 12 Mar 2025 11:46:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=rNdMRUvoZX/kxWFzzZGNBS4uKa7mJyLmib+X0z2uS
	4s=; b=Y3cu8llSbLzsgH3aGwztiE6biCiHwrKCDrdGI3XejIIZhF6jOsCnI2XaF
	s/gYh8/jTFAUkiDH1mRr8nUAf/UM+4Y2iS/QMqdoqB6qzfMGyaTLbw4JEAyEgKv6
	NlO51SZw126/OBMagB07U9h3eiU8cctoRGZ5gl5/HyM09xChhrLII+dN4VEhdEws
	hmddxJ9QnorQHGYDBgD0sesMPA2qaylzZp3gupHsOZbGuLTyEbPpkiSGwnzT0RKn
	MCuoeDtWgdbfM8Vp0i0IB9kQEd4pU52Lx8clWzPCvDS00StRpT+i/E64Sxem3V84
	W3LwAlV2apvKsV1I7E1C7v8+JWWgA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010020.outbound.protection.outlook.com [40.93.12.20])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45au9gk66k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 11:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZvggKJiND9trqF015Zp7mJuD2JuCFsmcl8c5b0yAcZJxFBhuYqDnkxmGL2/oGyWUhwq5T5ZAjukCbnAT0Wda4CKHxJFtNPvq5wXbQJPlvAPD/jkdwXDIM20Btj6GpFo+Z7Sh3hD9z33z3eRws4OodS8PSBBWmSB3g6LreASqv3jsHn/c1IO8AxCaV87kfUlrLtyhYJ/skaDzKe2KKE5Lp7mUirnCDzEzXYvhDMkMXNk7pqNNWOxWUpyCZW2djGsFst+5HUNyLtaodur54qaJmQp8PQ9WtMEGOtO3olUlJIJU7Fkanhyzawu5Zgu/VPJusFcCo/toOqT6XUENyL9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNdMRUvoZX/kxWFzzZGNBS4uKa7mJyLmib+X0z2uS4s=;
 b=C0pzCWhVwkrfrW+nBEsP8Tv/vQPu1C7cQ8tk0cGVwbY8A1WSKsE7RmaDDnQ1fT23xTXx9NbHiplhBDygBAf+/jkayZEbs1u5XPmbu7hlsvbfb8Qi4LpDcHQaTYyaYkqbgYv5blewu90p/tnUe/pwtxoFfJ/h8v2CdScHpp192EN21mieA9utYiM/FX1gBcQiF6ak5L5RWgvQeYCUOb4reklrHDB9UxSzMIFmCmo3GttbXF9Drw9OdYcTyGkGSU2z0942TtEe2mFQfL3k/cDiLHY+4Qnv3xhFbNA9dNPUBsHbe9hR/ymoxeVAFdkSkcWSTtYkm8i9FSgjV+hYjd/TyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNdMRUvoZX/kxWFzzZGNBS4uKa7mJyLmib+X0z2uS4s=;
 b=AMhCPHMJ+2QBQS8BOVUn45jBBAHFn573cCCpnoEbPKOvJeGv0cR35zZ3EPyvKzV3MiVqpc1k/f8GIQZyBgvbCaJxM2bf9dXaMGOf+JGdJxXhGo+0dwzL1V7ilBLTooQv5tLMFl9W8loyKc6MsnAVqHjFefBsUlQVr/l0UA25s2+v2lcUpzW/q7PHAsWASDavFZYTBZTTSIuLdKBX1W7343XbsgQ0w50Drjx9DiMnli+B0qN1VcwVdajvWGuuOTYc0FXEFaAZldsImRmGox9/IJRZU7R5uX6X7gD4rg2/tjkKkvX1kdA4/IRq80gIWJP21t/aIalH9OY4ES6bC+GuHg==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by PH0PR02MB7464.namprd02.prod.outlook.com (2603:10b6:510:d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:46:18 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 18:46:18 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider
	<vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] sched/deadline: Fix race in push_dl_task
Thread-Topic: [PATCH] sched/deadline: Fix race in push_dl_task
Thread-Index: AQHbj6GHm67dhCATrkil96yyudrYd7NvRueAgACX3YA=
Date: Wed, 12 Mar 2025 18:46:18 +0000
Message-ID: <8B627F86-EF5F-4EA2-96F4-E47B0B3CAD38@nutanix.com>
References: <20250307204255.60640-1-harshit@nutanix.com>
 <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|PH0PR02MB7464:EE_
x-ms-office365-filtering-correlation-id: 8ecb3778-8d7e-494e-5fb9-08dd61962d07
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlpJd2tLMHl5Wkg4VERkYU1RenJYNEpscjJpK0VTejhEZEJmMHRVaTMyOTJx?=
 =?utf-8?B?bFAzNjgxQ0Zwam54NUdXb01iZEdiSzY0YXlCQmJDVUp0aytnSFU2aWwzRFlh?=
 =?utf-8?B?MTA4WWVCbjlHWE1nbGx1UjJVRU52dVFZRWRiS1NJZXlJY2NHUmxWalFXQkJN?=
 =?utf-8?B?QmdtUEFEV1kwakFrNkZBRlhsazBsQlIyaklYTURQQXp5N1MwQ0VCanA5eXlR?=
 =?utf-8?B?c3F5YWxYSGUyNTFjeml6SmM4NUtDSW9sRlZYUlpqcVdhMXBsYXNFdngzVGl5?=
 =?utf-8?B?Umd6SW8vTEE0amQ4TkRjQ1JLUkRnam10NUdHUUlyRGw3OXVwVExBZEZlMldH?=
 =?utf-8?B?QVN2T0VXR3VJeDRNczRVbytmcW5jNzNYV1VZQ2JZOUJFUEJhSDY5Wjg3NmZ4?=
 =?utf-8?B?Y2w0OGNzMWRZbDJLWVJvTFVCbkhRbVhKUGxnU1lha2hwenRJTEpNaXdlM0g0?=
 =?utf-8?B?Z3pwZldWcFh5QkhxUHRmSzZBbkdtSzIxMjVnckhxbnlOemxBL0RNWkUxOGNP?=
 =?utf-8?B?UmVPaDFkQmdjSzIyRUxISGFGVlhSbVlCdk90MGgrakorbWRVcjIrUS9hMGpS?=
 =?utf-8?B?MVZORDlvVytjVFBkZnp4TXZKNjlEcVFFOWtuM1IwWnpWYVkya0FGM2RybDR0?=
 =?utf-8?B?YWlTU1hlQ0luT3hsb2JSOWd0RFoxNFBKZzZxR0h5RmdOS1h0VHp2M3hXZTZK?=
 =?utf-8?B?dDJKeWRROFU1UnZWS3dHYXhUYmpxc3gwUU44cGtWdml3eDJ6NWhTR0UzZDJa?=
 =?utf-8?B?aDhZSGNPVFg5UzRaMzZJM1RDeUI2WHB4enlhYmdlaGE5YUlJL0Q5YTdNMFNT?=
 =?utf-8?B?TW9yaHZlN3dBbkFGbURUTHl3bE04dVZQdVZjZmZvQUl0aWFuN3BydmJIek95?=
 =?utf-8?B?SDZKdzk4QUprZEhhUnZTdWlaZGhxRm1qeE5jcXJlV21JMzdScVorZXJ0RWt0?=
 =?utf-8?B?aSs5RXhEYjlSZjFiOGl3UXF5RzBZTUhIOXFsRHRVOVBpTzIrbE5QQVJYNC9M?=
 =?utf-8?B?aEEvbkJ5emIxa2NOVndHcHY0ZUlONXM2M1VCKzhkdUMrdGhQdFFsWTlDU2dB?=
 =?utf-8?B?dkVneWplbVNwNjcyNlZEdVRTWjRFZnFzSHFJSkR3UjZ0VHlLclJUdW0zUktB?=
 =?utf-8?B?UkEwN2trTEVGU3VzVDJxTnZJM0Rsb1Y3NmtkRzlNa093UEJVMWNTY3NIckFI?=
 =?utf-8?B?NjFVNEpxK2lBUk9SRzJzcUM3Ty9GcklRWjRJOGtRSVlvbkpBY2MvQlBMUVR4?=
 =?utf-8?B?TEtYUWZ5eXJVenRlYXhtTGppQXRmaG1MQXBvQjYyYS9SVEpxOUFaUjY2VUl4?=
 =?utf-8?B?TXFGNGVPbVNiWTVKd3k3WE1tcXVqOXNjbjJ3YnBKeTdPUDYrWHlHUEdoYXd3?=
 =?utf-8?B?QnVSS2EyYzRCK1BwMGJVcDNKQzhFdmJCb0Q2aEgwWHhGRTluN0JRdTU0OFd3?=
 =?utf-8?B?UmtYWUQ5SjFvRURSb2h4ZC9Eckl5TW5uS2ZKaTFHVzc0SmNPbmc2SG9CV1hN?=
 =?utf-8?B?Sis0aHBBVGRleFU0TGI3SFZndGFiSjhwUHBRZkp2d3RqVHMzQ2NzZm9pRFd4?=
 =?utf-8?B?bEg0eVBMeSt6Wm9jT0xZUkpoOUxCZm1Sblh0WG8vTStkZnNSMjhLNjBOTzFE?=
 =?utf-8?B?Z0owRE8zRDdGQTR4Q2wrZWRwT2tjN3luSUFmd3YzVlBZU1hBd05LZ3dLMmRW?=
 =?utf-8?B?enJ0dXN1Ymo0WjNiN0Z6aXptNXdUUEVYc3pMeXA1c1JkZzQvR3NCaWcxOFM2?=
 =?utf-8?B?MnZ6S2dkYmVadWpKSzJqSGVlWnZsYjYrSUZJcm1HeHRNenRKa3R5bmRSTDhU?=
 =?utf-8?B?cFYxNUhBdVFiZ2FXZ3pJbEs4NjU2RlhOaUlDVlRISkRoalU5Yy9tNzROR2gv?=
 =?utf-8?B?SWM4MWw5a0IzK0hLWGdtYnFMQUNHZzJMeGlFMHN3ZmRIK0N2REkrclQyRktp?=
 =?utf-8?Q?Otc31e9+N81y0C0z501ciK39fzIpXFLr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVExOVZHZGdXMndYYzhOa2dUUzFjenBlcW8zd2JyWG1Ec3F1a3NGZVhXQ29S?=
 =?utf-8?B?SjVWeVFnY01PNmxycjNyWGlPUFVrT2hjWU1Bc0NXeDdpTTdxRTRnY3h2VFFj?=
 =?utf-8?B?dTlMTlFaSmIwWENhbldqOHFaTVJiazBXUFo0b0VGZXFDQ1pGb2ZWeDUzUkla?=
 =?utf-8?B?MXJUL1NXUTlSNmJ3OFZPYUdrK3pCbUNkeWF3UE00RVc3NUJxeHczM1ZHMTVJ?=
 =?utf-8?B?MzEzV1dSV0Y5NGlZWVFUK1VWYzU2M2ljbVBQLy9ObUl1amhnM3lUbmVYaUxi?=
 =?utf-8?B?dHNIYis0bVdGT2k3MlM3MDQ4TWNWN0lFcUdHMUdWWXpJRUNXZnRDQno4V1Fa?=
 =?utf-8?B?Wml0ZnU2YWxDL3NwaWk3ZW5VSm90TEQ0eWkwaW5RQ2tmcmRTSk9DS0VoNG1I?=
 =?utf-8?B?eERweGErV2tJNXNHUFQ3SnJyVDVGelhqWXZLMmVjanM4Vm53Rlk1ZXU0TWJ4?=
 =?utf-8?B?Z2NVZWNMckNXV3BQT2hmQTRZbnBScGxveE9xYnAyZU4zbERJNXp4T09EL045?=
 =?utf-8?B?MnJZd3oxUlc1VzNXY1VYc1dBSzVOQUN5NmJTenFBMXVPUmZoK1ZJS3ErL1Fl?=
 =?utf-8?B?d1JDYk51N0RjUDEvNDNNT3RSazd1TUFVb3ViYS9ZSTRwR3B3Y3Z1bFRLMUIr?=
 =?utf-8?B?Wm9CQXJtZW1mMHgyVVFzb3oxeVUrL3E5QnF4anlxS25kU1JMM1JNazN5ZjBo?=
 =?utf-8?B?czVkTzI4N2JveG5DT2M4eko5OWxkbm9UZENhYWRRdm80elNHNlI0OWY4bGE5?=
 =?utf-8?B?d1hneHVyd29GaU9IWGlXZXppTXdvckNseHZWMUR2RCtKc3owZ000MGxQaTll?=
 =?utf-8?B?b2FLNHBiMDM1bng5YkVyUy8zUG1tT2lmQXE0ZXpsQ21pU21TclMwaWpOakJF?=
 =?utf-8?B?a3luQ3VmV2p2cVBycUlKT3FlM3V1RnNUVjc4WFc0WVFLRFBZNlB0MWU4Q1h5?=
 =?utf-8?B?TGpVVDJFcXBXVWVRd05pZi9td3lXQ055MzhFR0dDNm9qK2VkcC95N1FGcWZa?=
 =?utf-8?B?OXlIV1YyU1QvWUF3ajJYZTU0QnMxb29oMkZpbXRraGpXTkg4WDBsYkhzY0la?=
 =?utf-8?B?ZVgzZkt6eGZqSEdzK0dXSUFaV0NRTkZRTlJhUUpMMWpITDRmWitTMDZpV0lW?=
 =?utf-8?B?SXFXOXI5ZmZGOWxpZzNKRTR5NitESzFVK0pGUkFjUTgxYkFlUFdaMmFTaGJC?=
 =?utf-8?B?NS9QNUJ4WU90QlNhc0Q0M1p2TGg5azc4aFNLNUtoMDM4akNlWlhhMkJ1eHVl?=
 =?utf-8?B?VjNQeXF1dEc0TjByeGRPaGdpcFFKbmFJSzZuRFhrUVRqcjNXSklkd1drYzVG?=
 =?utf-8?B?WkNqVmNNaFVWY2Y4RzFaNnByOWx0MGszV3h0RktHTEZSbXAvYVB1YVhIWjYr?=
 =?utf-8?B?VkpiTWF3WVpnMmNGTlZNK1VtVGdBV1ZRYzk0K3RFcTNBMDdJUUlmS211OUU3?=
 =?utf-8?B?QklHZnBMMHNqZTZJVzM0U25Va2JmQ3pyZWtSSmZBVExwb3JiL2pvZDRhOUlV?=
 =?utf-8?B?UURwRjNGZ2kvQzJNTFAxWXdOVXR0akJ3emNCcEgxYzdlSjV1eTFlTmJmcWox?=
 =?utf-8?B?SFlaRWEwUjU1OFdCb2tmV2g3cXNRQUlicDY5L2ZyK1dHVHFSVlpzSFNaWm9k?=
 =?utf-8?B?bTBtSW83dm1oa0YyL3NBTCszQUtMWG9TblEycmR1RTlmSFVQc3QwSnhWaDVQ?=
 =?utf-8?B?UG1IV3B0NXhndXorVk1VK1k5TXRGMEVtRnBYRjkxdnFWRDJuM2ZNaWdvRlpn?=
 =?utf-8?B?VWxFTHgzWm0yVzgxbTR2Tk1KVmJEdTNqOUdJS3hmdUZhV0R4bENLanJsU25N?=
 =?utf-8?B?d09GVENCV2tpZm5LWlh3U2V2NXVJZGd3MDJacHpjQzV4UGFmVXBiS3IvZUNW?=
 =?utf-8?B?Sjh5UTlIYThXbGE5UDlaT29LRjg3T3FQRWpjaXcyRWR5U2pnTEhJUkRUMG1T?=
 =?utf-8?B?TTZYUHZneUdZT3d0SUtMMkVIcG80OTJCYXlsWHk5T3BTTzhNalJ4c1BkaHNn?=
 =?utf-8?B?RUJIWDBlTUFFak44UC9Hai9wT2E0MjZZQ0o5RU5lNi9kUVg0b1ZrbVBYRUt3?=
 =?utf-8?B?QTFPZk85VVpod0J6dW1OcWs1Qi8rWldUVjlvRjhSbFloWjBjQXFOK1psTGU1?=
 =?utf-8?B?ZjRwSFZPMWhNZG83VDY1bGVTOFZOalQ3NDBoT3k1cjk3QXo4azNwWmhtemND?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB506899F7B08347A73CD729B5F7B412@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecb3778-8d7e-494e-5fb9-08dd61962d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 18:46:18.4359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCbpf8TNs96zbwijRqGH5SUDKHiexi6pixdqB7aFQvBTdrhow1dAUct5kRjGVLO5IKjDgM7mS8U5q18wsVgMEMzcg4bb5sbnzL+Rqdu5ngI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7464
X-Proofpoint-GUID: TlDjdSc-q7nOWixI4no6_J_r_iRQd0pM
X-Proofpoint-ORIG-GUID: TlDjdSc-q7nOWixI4no6_J_r_iRQd0pM
X-Authority-Analysis: v=2.4 cv=RImzH5i+ c=1 sm=1 tr=0 ts=67d1d67e cx=c_pps a=mtz/C3zYIZwjsC0ncApg3Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=VwQbUJbxAAAA:8 a=O4WvZpKilczwWMY8FUQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

VGhhbmtzIEp1cmksIGZvciB0YWtpbmcgYSBsb29rLg0KDQo+IE9uIE1hciAxMiwgMjAyNSwgYXQg
Mjo0MuKAr0FNLCBKdXJpIExlbGxpIDxqdXJpLmxlbGxpQHJlZGhhdC5jb20+IHdyb3RlOg0KPiAN
Cj4gSGkgSGFyc2hpdCwNCj4gDQo+IFRoYW5rcyBmb3IgdGhpcyENCj4gDQo+IEkgZG9uJ3QgdGhp
bmsgd2Ugd2FudCB0aGlzIGtpbmQgb2YgVVJMcyBpbiB0aGUgY2hhbmdlbG9nLCBhcyBVUkwgbWln
aHQNCj4gZGlzYXBwZWFyIHdoaWxlIHRoZSBoaXN0b3J5IHJlbWFpbnMgKGF0IGxlYXN0IHVzdWFs
bHkgYSBsaXR0bGUgbG9uZ2VyDQo+IDopLiBNYXliZSB5b3UgY291bGQgYWRkIGEgdmVyeSBjb25k
ZW5zZWQgdmVyc2lvbiBvZiB0aGUgZGVzY3JpcHRpb24gb2YNCj4gdGhlIHByb2JsZW0geW91IGhh
dmUgb24gdGhlIG90aGVyIGZpeD8NCg0KU29ycnkgYWJvdXQgdGhpcyBhbmQgdGhhbmtzIGZvciBw
b2ludGluZyBpdCBvdXQuIEkgd2lsbCBmaXggaXQgaW4gdGhlIG5leHQgdmVyc2lvbg0Kb2YgdGhl
IHBhdGNoLg0KDQo+IA0KPj4gSW4gdGhpcyBmaXggd2UgYmFpbCBvdXQgb3IgcmV0cnkgaW4gdGhl
IHB1c2hfZGxfdGFzaywgaWYgdGhlIHRhc2sgaXMgbm8NCj4+IGxvbmdlciBhdCB0aGUgaGVhZCBv
ZiBwdXNoYWJsZSB0YXNrcyBsaXN0IGJlY2F1c2UgdGhpcyBsaXN0IGNoYW5nZWQNCj4+IHdoaWxl
IHRyeWluZyB0byBsb2NrIHRoZSBydW5xdWV1ZSBvZiB0aGUgb3RoZXIgQ1BVLg0KPj4gDQo+PiBT
aWduZWQtb2ZmLWJ5OiBIYXJzaGl0IEFnYXJ3YWwgPGhhcnNoaXRAbnV0YW5peC5jb20+DQo+PiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gLS0tDQo+PiBrZXJuZWwvc2NoZWQvZGVhZGxp
bmUuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAy
MSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL3NjaGVkL2RlYWRsaW5lLmMgYi9rZXJuZWwvc2NoZWQvZGVhZGxpbmUuYw0KPj4gaW5kZXgg
MzhlNDUzNzc5MGFmLi5jNTA0ODk2OWM2NDAgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvc2NoZWQv
ZGVhZGxpbmUuYw0KPj4gKysrIGIva2VybmVsL3NjaGVkL2RlYWRsaW5lLmMNCj4+IEBAIC0yNzA0
LDYgKzI3MDQsNyBAQCBzdGF0aWMgaW50IHB1c2hfZGxfdGFzayhzdHJ1Y3QgcnEgKnJxKQ0KPj4g
ew0KPj4gc3RydWN0IHRhc2tfc3RydWN0ICpuZXh0X3Rhc2s7DQo+PiBzdHJ1Y3QgcnEgKmxhdGVy
X3JxOw0KPj4gKyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2s7DQo+PiBpbnQgcmV0ID0gMDsNCj4+
IA0KPj4gbmV4dF90YXNrID0gcGlja19uZXh0X3B1c2hhYmxlX2RsX3Rhc2socnEpOw0KPj4gQEAg
LTI3MzQsMTUgKzI3MzUsMzAgQEAgc3RhdGljIGludCBwdXNoX2RsX3Rhc2soc3RydWN0IHJxICpy
cSkNCj4+IA0KPj4gLyogV2lsbCBsb2NrIHRoZSBycSBpdCdsbCBmaW5kICovDQo+PiBsYXRlcl9y
cSA9IGZpbmRfbG9ja19sYXRlcl9ycShuZXh0X3Rhc2ssIHJxKTsNCj4+IC0gaWYgKCFsYXRlcl9y
cSkgew0KPj4gLSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2s7DQo+PiArIHRhc2sgPSBwaWNrX25l
eHRfcHVzaGFibGVfZGxfdGFzayhycSk7DQo+PiArIGlmIChsYXRlcl9ycSAmJiAoIXRhc2sgfHwg
dGFzayAhPSBuZXh0X3Rhc2spKSB7DQo+PiArIC8qDQo+PiArICogV2UgbXVzdCBjaGVjayBhbGwg
dGhpcyBhZ2Fpbiwgc2luY2UNCj4+ICsgKiBmaW5kX2xvY2tfbGF0ZXJfcnEgcmVsZWFzZXMgcnEt
PmxvY2sgYW5kIGl0IGlzDQo+PiArICogdGhlbiBwb3NzaWJsZSB0aGF0IG5leHRfdGFzayBoYXMg
bWlncmF0ZWQgYW5kDQo+PiArICogaXMgbm8gbG9uZ2VyIGF0IHRoZSBoZWFkIG9mIHRoZSBwdXNo
YWJsZSBsaXN0Lg0KPj4gKyAqLw0KPj4gKyBkb3VibGVfdW5sb2NrX2JhbGFuY2UocnEsIGxhdGVy
X3JxKTsNCj4+ICsgaWYgKCF0YXNrKSB7DQo+PiArIC8qIE5vIG1vcmUgdGFza3MgKi8NCj4+ICsg
Z290byBvdXQ7DQo+PiArIH0NCj4+IA0KPj4gKyBwdXRfdGFza19zdHJ1Y3QobmV4dF90YXNrKTsN
Cj4+ICsgbmV4dF90YXNrID0gdGFzazsNCj4+ICsgZ290byByZXRyeTsNCj4gDQo+IEkgZmVhciB3
ZSBtaWdodCBoaXQgYSBwYXRob2xvZ2ljYWwgY29uZGl0aW9uIHRoYXQgY2FuIGxlYWQgdXMgaW50
byBhDQo+IG5ldmVyIGVuZGluZyAob3IgdmVyeSBsb25nKSBsb29wLiBmaW5kX2xvY2tfbGF0ZXJf
cnEoKSB0cmllcyB0byBmaW5kIGENCj4gbGF0ZXJfcnEgZm9yIGF0IG1vc3QgRExfTUFYX1RSSUVT
IGFuZCBpdCBiYWlscyBvdXQgaWYgaXQgY2FuJ3QuDQoNClRoaXMgcGF0aG9sb2dpY2FsIGNhc2Ug
ZXhpc3RzIHRvZGF5IGFzIHdlbGwgYW5kIHdpbGwgYmUgdGhlcmUgZXZlbg0KaWYgd2UgbW92ZSB0
aGlzIGNoZWNrIGluc2lkZSBmaW5kX2xvY2tfbGF0ZXJfcnEuIFRoaXMgY2hlY2sgaXMganVzdA0K
YnJvYWRlbmluZyB0aGUgc2NlbmFyaW9zIHdoZXJlIHdlIHdvdWxkIHJldHJ5LCB3aGVyZSB3ZSB3
b3VsZA0KaGF2ZSBwYW5pY2tlZCBvdGhlcndpc2UgKHRoZSBidWcpLg0KSWYgdGhpcyBjaGVjayBp
cyBtb3ZlZCBpbnNpZGUgZmluZF9sb2NrX2xhdGVyX3JxIHRoZW4gZnVuY3Rpb24gd2lsbA0KcmV0
dXJuIG51bGwgYW5kIHRoZW4gdGhlIGNhbGxlciBoZXJlIHdpbGwgZG8gdGhlIHNhbWUgd2hpY2gg
aXMgcmV0cnkNCm9yIGJhaWwgb3V0IGlmIG5vIHRhc2tzIGFyZSBhdmFpbGFibGUuIFNwZWNpZmlj
YWxseSwgdHQgd2lsbCBleGVjdXRlDQp0aGUgaWYgKCFsYXRlcl9ycSkgYmxvY2sgaGVyZS4NClRo
ZSBudW1iZXIgb2YgcmV0cmllcyB3aWxsIGJlIGJvdW5kIGJ5IHRoZSBudW1iZXIgb2YgdGFza3Mg
aW4gDQp0aGUgcHVzaGFibGUgdGFza3MgbGlzdC4NCg0KPiANCj4gTWF5YmUgdG8gZGlzY2VybiBi
ZXR3ZWVuIGZpbmRfbG9ja19sYXRlcl9ycSgpIGNhbGxlcnMgd2UgY2FuIHVzZQ0KPiBkbF90aHJv
dHRsZWQgZmxhZyBpbiBkbF9zZSBhbmQgc3RpbGwgaW1wbGVtZW50IHRoZSBmaXggaW4gZmluZF9s
b2NrXw0KPiBsYXRlcl9ycSgpPyBJLmUuLCBmaXggc2ltaWxhciB0byB0aGUgcnQuYyBwYXRjaCBp
biBjYXNlIHRoZSB0YXNrIGlzIG5vdA0KPiB0aHJvdHRsZWQgKHNvIGNhbGxlciBpcyBwdXNoX2Rs
X3Rhc2soKSkgYW5kIG5vdCByZWx5IG9uIHBpY2tfbmV4dF8NCj4gcHVzaGFibGVfZGxfdGFzaygp
IGlmIHRoZSB0YXNrIGlzIHRocm90dGxlZC4NCj4gDQoNClN1cmUgSSBjYW4gZG8gdGhpcyBhcyB3
ZWxsIGJ1dCBsaWtlIEkgbWVudGlvbmVkIGFib3ZlIEkgZG9u4oCZdCB0aGluaw0KaXQgd2lsbCBi
ZSBhbnkgZGlmZmVyZW50IHRoYW4gdGhpcyBwYXRjaCB1bmxlc3Mgd2Ugd2FudCB0bw0KaGFuZGxl
IHRoZSByYWNlIGZvciBvZmZsaW5lIG1pZ3JhdGlvbiBjYXNlIG9yIGlmIHlvdSBwcmVmZXINCnRo
aXMgaW4gZmluZF9sb2NrX2xhdGVyX3JxIGp1c3QgdG8ga2VlcCBpdCBtb3JlIGlubGluZSB3aXRo
IHRoZSBydA0KcGF0Y2guIEkganVzdCBmb3VuZCB0aGUgY3VycmVudCBhcHByb2FjaCB0byBiZSBs
ZXNzIHJpc2t5IDopDQoNCkxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMuDQoNClJlZ2FyZHMsDQpI
YXJzaGl0DQoNCg==

