Return-Path: <stable+bounces-110903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBAAA1DD32
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 21:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205F27A3BA9
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD8193079;
	Mon, 27 Jan 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hQyhHhou"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020105.outbound.protection.outlook.com [52.101.69.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4553BE;
	Mon, 27 Jan 2025 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738008730; cv=fail; b=OcADurx1JC3pddx9aStM6OlxXgQXj055ZdaAl2WdFuNA4iVJwZfe5oKnrdSPLgd6RxRGLtGjkg5odctnVEKGeayePy0cWDbz2Sx4exnGtOYxpDXvrPuot8R3ZeJsL/JVK0m/cI/3Yd6JXGhnRKduOROi1ppqko4cqLj99FstbUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738008730; c=relaxed/simple;
	bh=9DR0dTX3kaxb09ZNpniaMZP9rMbYrDjIzoEgSaS2uvo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=jElmdukrCaL0+jn9HVYOzHEp8lM/3WK8k61CIBzODozq21iwA8y8Nxa3aENmBIURMsR6NGuurE6dsgRYHXdBI1U8Ylrn2H2IjOHolMKLnTUQNxcaf/YAdHE4yGExr/56n33WMbSGVrCVPW6KzLe/hSFRNzAwMWFYLJT/X8KWcnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hQyhHhou; arc=fail smtp.client-ip=52.101.69.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiaSdZhckgFzflHoc+G0BWW5yTLlQlQsFWLGHFR2Vl0oa8epfY23p4PxACNG2x5Gm/gX624wzcICIUDLuBw2/JMPcpgRv1q337HFiCNX3VIBzvctWVtDZvJJcw//7yhsNUBplNiofL9bPWjsM3sVutZbjR2gXUKIlEFliWZa6gs0QUTXxOyFVltbGQoQUKjJM8t89pI5yQ+Z5tFpS49g47Gpy49GR4Mbn2Z8sDpszMaeUwY2z4zBWufTVb2qLYd1wW7feWcgucUzmXue14jaGKrsrt4xxoPEdbVQsT9F0zm/VR2bqFzuewunQnIv+xHgoPA9WSE8QtVvZiwJJpB9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIrWVxPEV4TELbYR04P5BATIKUwxv6kjlZT3iuB8ZSg=;
 b=y9tW8OR1ItzmReijk+C0PG62uRX/NJOtWMbunOUjtydFBokYCHqHYNC67xXVv05ET7mOvpShFAIHymgPTaH0Q7+V6gXEQ2s2bUZdgS5VP/gfebzdM2iaRQj78wSeeBB95OmMHcVe+B+Hve6HG8zWwfgcPRqNBKsxqCICrLaa3Qui84TsurHJuVtd7Py/MQJGq2aCaz/1wnxHIQOXfqH7un4IbKJywJimXfUr2Uf8Ly0eQLzRd2H64H5f7prxTdbTSSbg1Iox63Mrfv6EfkzAxSCtd9xBk+p8E3QfxtVqGlNBgHrwVjhrUTYPx6qVY9BLpIVj+JYSwxTj6McpmA98jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIrWVxPEV4TELbYR04P5BATIKUwxv6kjlZT3iuB8ZSg=;
 b=hQyhHhou/vc9EKom+nhO4egW7ep3qXaUJ0yodNHc+2WbSEGtkXIeupSQOGxoQznyv3dpCmpEu1w2T54/9NnJXILsIkZkK867T0V1Zu8qVkw7/B6/0CqUYms/wNK81xBgvmYAQrixfF+x6EL9Ax58dmQrcrdbvnI3q23JBq53PzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI2PR04MB11027.eurprd04.prod.outlook.com (2603:10a6:800:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 20:12:06 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 20:12:06 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 27 Jan 2025 21:12:02 +0100
Subject: [PATCH v2] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAJHol2cC/4WNTQ6CMBBGr0Jm7Rha5KeuvIdh0bQDTGKpmSrRE
 O5u4QIu35e8962QSJgSXIsVhBZOHOcM+lSAm+w8ErLPDLrUdal0izY09QVDcCg0CqVdQPK6M0N
 nmtZpyOpTaODPkb33mSdOryjf42VR+/onuChU6LtKDcaqypK5pfhgj/Kezy4G6Ldt+wH6EY+ev
 AAAAA==
X-Change-ID: 20250127-am654-mmc-regression-ed289f8967c2
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rabeeh@solid-run.com, jon@solid-run.com, Judith Mendez <jm@ti.com>, 
 stable@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI2PR04MB11027:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b0cde7-56f8-4371-6a71-08dd3f0edf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czhQWlFCdWdXcUY4WVFTdTdRaTVVOWVvYzRkS2hZTUxvd09vMTBNVHVXK1J5?=
 =?utf-8?B?Qm5NOWNXNThPcXZmQXAwWm1pS3VVNHdRNkNIUjdtN1FueTJoZzZINExJZEhX?=
 =?utf-8?B?eWJQLzVVcjlvVjAyVzRGdFAyNk9JdTJwZnU3azdTM2RUMnMwdEY2UkpBVy9X?=
 =?utf-8?B?dk9XZlZiUVdPdGVBN3dMS2d4Y0U1eXV5VmNmaXJJQWZDSnRhRHFZeXhVNnBK?=
 =?utf-8?B?cUZhdWFUMEZ2S282eGhEVDRJVGtLSFdPNVlZVjBlbUJUaFFKUTNhNUJ1R0RT?=
 =?utf-8?B?SFE4ODNlM1Q4SGM5ZXl5Q2daS2hnY1ptZnZVK3UybXgvRFBEYWZtcG9oYTZr?=
 =?utf-8?B?WTlOZzY3MG8rR1hRSDd1NmRkRTFhY0dRTThuWkYrNG9xTm9PZzZ6cXFjL3VU?=
 =?utf-8?B?UTl3L253blRvc1QvK3dScC9PSmtId0h1R1kvWlU1MlpDS29sQ0REYmhmM2wz?=
 =?utf-8?B?ZzRLTklraHpQWldjNzFuNE0zS2tzd2M0aWJIUzJDcHpvd2tEb2h3RFErYkJF?=
 =?utf-8?B?Mi9tOE5KVWtPZmZCRHdvY1FQWEQyQkNzSjJTZnYrek1Ta3dJcEw5VS9tUlVr?=
 =?utf-8?B?bjhpTHNtcEs2VTZON1ZBTXpMempsTmFLOGJLUzJLbEswRThDakVySVhXSGJZ?=
 =?utf-8?B?a3I1dG1nSytVWk5kT0YyQ2doQnhOMU9hSHp5M3RKYnpqTVJXbUdzdzFtSmF6?=
 =?utf-8?B?WEIxbFVoUzRlQy83MThmODNLNTR1dEtRdVBoV2E0dFRyamRtdGp3dEcrSUp4?=
 =?utf-8?B?ZS8xWmlSRVU2UjZpWW9ZbHh5MVFRRFVWZ3ZLWTg1V0IwY3FZSDViU2ZDUGNC?=
 =?utf-8?B?RGdiaFEzaGpRK1BadFBpRjJiUmd6WFdrem5zelVyQUJnZ0laNmtIU1BSQytz?=
 =?utf-8?B?K04renhOYVpDSUJTUWtzZDNiRzNaMnJ3bVpMQ2JVUVBKaFd2UHZjWkF0anVu?=
 =?utf-8?B?RnNWZWdmc2RFTUFHaEZGdHZPWjZoMkkrNU5mZzhEZXE1cWdyK1BvOWZ6K0dm?=
 =?utf-8?B?RFRkM2N1SHNrMm1URlpXdFY0bkJqcGlSSE0raVZERURFN2lseVJCWm80V2ZT?=
 =?utf-8?B?TW5OaGpRM2ZPdjFjRm5MRVpIelQrNnVnWXUvL3ZUc001VE1RNkRqWHN1S09G?=
 =?utf-8?B?SkVwRkttbFpUL1hDVlUwVHREWWRPSFRPRk1BdHJpaHM4VGUrYjhFMzA4OUw2?=
 =?utf-8?B?a3FPakd1cXYyaTdaME5xT0VDU1hjRlhHVzRHQU5idHlreWNWaUdHTTMxQXhy?=
 =?utf-8?B?S0NKU2NWbVl2cVpra1FjK01NVElhSkZYc3ZyZWhJbE5xTDNaU29UNC92bWZP?=
 =?utf-8?B?anB3bEdlbHlVR3VGcWlHOTFVR2dzVTlleElZSDF5d0p0NGtvNDdwbUZuRjYw?=
 =?utf-8?B?ajlBMFhteFNhQjU2bnZyK1p0d0kvZXdudHZ4c1NQR2hhblNvZWJ1cEhjUTNC?=
 =?utf-8?B?dktPd3NKaUJTL3VBYXRsQkZ5akY0aXN2R3FvTDBrcGZUYzA4YVFQRWdpTVl3?=
 =?utf-8?B?a3RmWVpPMGdsdG5PR29mK3MyUmZ1UXd1TW9XUkpQTVBpcENMMCt1RFo4UHky?=
 =?utf-8?B?WUNRUjAvTnQ4ODJrQXBZdlAzc0ZUTm1WU0JTTEd1elZ2cFBCU0MzYVZGa0Vw?=
 =?utf-8?B?RktGQWwrM3JTZERwSTRFclI2b1RIc0VwM3dTSHI1NUFoKzlnQnZHWWhiOU94?=
 =?utf-8?B?NmxnWlR4bHlPU2NFZkJZZTJEUmpTOXpnMk5LaGlSSU11c2hiM0w3ellrY1RW?=
 =?utf-8?B?aTBydXpMakIxWjJraXVpNDA0aEsxanBBMngyU1BucE1IaktuM1ozclBkUWdl?=
 =?utf-8?B?UDBEY1dueEJPaVc3aGRpbEZLWUhuYmRLRkdhRHdYcXpYL1g2Y0dqSWZ3RjU2?=
 =?utf-8?B?bnpvR1A4WlhCRFUra0QvKzBWN1pITmFQUlVQUjdhdkJkRWxqNjk5WFd1c3Jx?=
 =?utf-8?Q?kP2J8WXivb0PSYmFBW0AnHfxlJUYPoc5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amRCdy9DNENLclBmWWNYRk9QemdaNVlNNVRJZm85MUM4bENJY05VdCt4Skdk?=
 =?utf-8?B?NkI2NTYzSFJoRVNISW9NR09xVk9DK2czeUQ2cmxVMmhrTFRPdW8vbWM1SHI1?=
 =?utf-8?B?eEVFZVhZS0NIbHJHVjNPVDRQU2dnemhteWNWaEVWWUJjUTBPMmFkVkVlTXdR?=
 =?utf-8?B?Y2ZSR1hPck1aUGl0L1JvcHQ5WkhaVEZuT1hRTkZxbXlFSEk0ME4xZ1F5R0I1?=
 =?utf-8?B?MjRsUnd0dXJuUVdNUTBEWEo3dUkzQmg5RkFZU2xNam9kUnF4QmR5UjJ5djdX?=
 =?utf-8?B?c0dwT0VZSUgrYnpqOGthc3ZmdThvbDFNVTQ2RUZvWHhZMlZGWmRkV3M1MkpI?=
 =?utf-8?B?MWJSZGg3aHJGekMzVEorREpRdGZYSTVCeFhIT3ZhRWltajRkWmhXbDUyeHZ0?=
 =?utf-8?B?K1laRXZvWlZJN1Bob2hDdEJwL2twMlJDVWVobkFrMldCaGtyNTVRbnRML0Y1?=
 =?utf-8?B?bytXbXNEL2tIODdWcWVOdnNnbEtZWTlleGRVVEZWOWY5WUQzK0w0TDFwNzlU?=
 =?utf-8?B?UUltVWM1Z0I3c2t6T2NMRVhTU0VMTWtXMmc4SnJXdko2Ny9IRVZxQ1BqdkVJ?=
 =?utf-8?B?cm5oZ3JraHZLSEt6OXJMUDRrbklIaitDS1N2aE8rSldXOEkxTVJIUUFNLzFt?=
 =?utf-8?B?bXVJSVpSaXdQOFQzbmptb2ZpTnhvMHo5ZThLb01teG9iSXVxcm52Zm5UYnZx?=
 =?utf-8?B?K20yRnQ5ejMwYnR4a1dpS0JJV2VYVW04bm1QYXVUaGhUaGoreG1EaEN2TUx4?=
 =?utf-8?B?Yjh4ajdxSk54ckIwMzRlcjYveHhjMUYwY3dsc3owUkc4S01kVDAydDk1emln?=
 =?utf-8?B?WWNuZ2RMU2tsMCtDbTN5bFUya0tZNER4VE8ycllUN3prUFMwV2JMM1NNMHR1?=
 =?utf-8?B?Y1ltQ0hGUXJpZmhzK1hsREcxQTVDSGE2U3RYSVhPb2ViNU05YXZIMk9jNXQ0?=
 =?utf-8?B?ZnJ5Y0FWMDFtMFBEd1hlb1FVWEEyQlNqRjRxZlhOV0c4UXlKdHE4c2tRV3Fv?=
 =?utf-8?B?bnVnSVJvdE0yYVVNQVBRRUFFdWlqUUhmaW1yOTRwRXRyR2FseWhyTHcrT1lI?=
 =?utf-8?B?ejVLbnpGNkp4ZG5qS2VuV0ZrMzR4YzhNSTZQajlYeGxyTFNFa1VncXBlbnpL?=
 =?utf-8?B?VjVOL0xTbzE1RVJGbHh4N2daS3pRV0c1OTE2YXZmS3NTOU1nY0tnMVJrSUJW?=
 =?utf-8?B?NFdZcVI4T3lxZ3hKOGhoRHMvQnJPTHR1ZFZGczRRSHZINlVkWHFhS3RtWW42?=
 =?utf-8?B?NW9mNUc0NVFGTXdCY1g5K0JKSVQrL3dhSEI1VEg5aG9aVDlCNHRrNnp4aHBz?=
 =?utf-8?B?MkRXcnpiZDBEMWtlOHViT1ZCNW5GVTFuUTRsOHc1RWpqeXVycGpDcGcrM0No?=
 =?utf-8?B?YnBDRkRYOElRRGlmUFo1dFdRMW1zdHg1dXpITkRkOFgrQk1RQnRGcFQzOHJs?=
 =?utf-8?B?QmpFM01sSFNYUm9IclZBTjQzcW94VXlkNHBpeGJ3VkdOZ0J5Uk9qV0JENlVp?=
 =?utf-8?B?Q1RLNW9MdDdDR1FKcXVpMnRxTjhSZlM0ZjVHODhYcTB1S0xEMzZjV2RHWGNV?=
 =?utf-8?B?cDA3NVlkdjY1VkNBMkNMN2tiRlM3RFJLbkNxODRhOENDMTEzSldTMDhmSEFZ?=
 =?utf-8?B?bGRrK09NcVQ4WGFhVjRCTTBZUUNWYVVOUjduYTc0S1RZdGlyNXdXYlRVZWVZ?=
 =?utf-8?B?WnA1bFJDcnBPQTVPa215TW8xdE1jdXpCOGlBckpiUDBDR1ZaNkhyb2gwdjM0?=
 =?utf-8?B?NDFMMWxhQTBMdm96OVVqeUEvdDN4NkF3SkticndnWmE5T2ZsUVlMS2REMURU?=
 =?utf-8?B?OExNeFozTkpvSko4bFY3Tzd4cmhmekxZTnc0NUJpTDdwOGtwSVhQVXB0cDkz?=
 =?utf-8?B?aHRZRXJiRXlHNkVROExqaWlvcmRSdU5yaGlzY0RjaS9BRGQ1bkNLSVFxYXo3?=
 =?utf-8?B?SlFCZzl0SzQ1bS9NMHBSNGFlY3lyMnlpUXdIZkd5blBZMkF5d3RhYWVLQTAy?=
 =?utf-8?B?MVBkeURGckRMNXpxRWU2dHBNTHhlZGhSTC96YzdVcytRRUI5RGhQd0tGSGVK?=
 =?utf-8?B?MGxHbjJ4SUwrUzZVdzNGU2N3bmNGRnVZRkNHZVpuZlFzSUJra1FweUdhdUJk?=
 =?utf-8?Q?0vPBJE5oFQfI3i/jC33GVsvbe?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b0cde7-56f8-4371-6a71-08dd3f0edf22
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 20:12:06.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEFiZ0Y+4pgnJ79wbmQq0+JYnvtgiG9AJB+GcvC8carRLZed+nlHF6aDEPFPAYfY/yZevgH0AE5GL/wMD0B22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11027

This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.

This commit uses presence of device-tree properties vmmc-supply and
vqmmc-supply for deciding whether to enable a quirk affecting timing of
clock and data.
The intention was to address issues observed with eMMC and SD on AM62
platforms.

This new quirk is however also enabled for AM64 breaking microSD access
on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
causing a regression. During boot microSD initialization now fails with
the error below:

[    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
[    2.115348] mmc1: error -110 whilst initialising SD card

The heuristics for enabling the quirk are clearly not correct as they
break at least one but potentially many existing boards.

Revert the change and restore original behaviour until a more
appropriate method of selecting the quirk is derived.

Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
Closes: https://lore.kernel.org/linux-mmc/a70fc9fc-186f-4165-a652-3de50733763a@solid-run.com/
Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes in v2:
- Fixed "Fixes:" tag invalid commit description copied from history
  (Reported-by: Adrian Hunter <adrian.hunter@intel.com>)
  (Reported-by: Greg KH <gregkh@linuxfoundation.org>)
- Link to v1: https://lore.kernel.org/r/20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com
---
 drivers/mmc/host/sdhci_am654.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index b73f673db92bbc042392995e715815e15ace6005..f75c31815ab00d17b5757063521f56ba5643babe 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,7 +155,6 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
-#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
 };
 
 struct window {
@@ -357,29 +356,6 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	sdhci_set_clock(host, clock);
 }
 
-static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
-	int ret;
-
-	if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
-	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
-		if (!IS_ERR(mmc->supply.vqmmc)) {
-			ret = mmc_regulator_set_vqmmc(mmc, ios);
-			if (ret < 0) {
-				pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
-				       mmc_hostname(mmc));
-				return -EIO;
-			}
-		}
-		return 0;
-	}
-
-	return sdhci_start_signal_voltage_switch(mmc, ios);
-}
-
 static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
 {
 	writeb(val, host->ioaddr + reg);
@@ -868,11 +844,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
 
-	/* Suppress v1p8 ena for eMMC and SD with vqmmc supply */
-	if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
-	    !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
-		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
-
 	sdhci_get_of_property(pdev);
 
 	return 0;
@@ -969,7 +940,6 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
-	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250127-am654-mmc-regression-ed289f8967c2

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


