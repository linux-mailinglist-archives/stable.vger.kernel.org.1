Return-Path: <stable+bounces-158490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF2AE7859
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 09:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A011E7A8863
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 07:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022F72626;
	Wed, 25 Jun 2025 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="B6T0TvBD"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FC126C05
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835974; cv=fail; b=KYy74bCBYUwpzSU1xSmomx+NTbxoRS4+dAPBd51DUuLVah/outmwEVH4P5kNAbXNOQeKU6FwtZanCC7R08DSEqGAjqp96GA6mSLO1BVZuj60I3Vi1rcpi4iLmAkv/yE1PXzGz4i8FWrK1F7O6EODN4DaXTqW0NgF/8LnuGq//UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835974; c=relaxed/simple;
	bh=A5dpD86BmXGpStBmfurKPB24Clzptl5nCWfOfEzaj0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7SphC/gpyZDdDXy8NpNKisc+gmLd6cZB8WfGynDYPc/GH8xzp4+vwsBdrGeDF2E9OuZpEgpWsTvLBxHrZL7C0UrR162Co4/kuLVS21cbminc14QhSBPofVCUDoG8EUL+ZdmQ18qJqkt8OKopKFaH99Zi0xgKY+H5UGjb069+P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=B6T0TvBD; arc=fail smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750835907;x=1752045507;bh=A5dpD86BmXGpStBmfurKPB24Clzptl5nCWfOfEz
	aj0s=;b=B6T0TvBDsIbQ+YY5mACv9G1P90DD+KyMLTJj+NR2ywjVS6IWeoj3G8ECbDBim8vAFb1gn
	Q2q9Xr0OF7Ed77tgjrc5Ra8NFCE/cp/zxj4Gr+/GPGcNgM/EjuR8lR5dwvyXLDXlkmuZhviTp/rD8
	Xb7KqeDAeVvAmpq7CY5NxG0dahsNMfG1bU0XudzOkXffm0ZHWm7bo2cDqS1iMfz3aNZ7k2n09jkEU
	V0Xa5aQFEX+ZZzTSMYFs5YacxI4JvekF+MKh+OPC0vHpS7f8jZW5Vl+OXPfTp/0+ExLLwa46BvXAX
	73HjsLzVH8I7HgPzSkkQ/FNgs3e0LfsLsNhP/ZogXg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55P7IQ8q1556222; Wed, 25 Jun 2025 16:18:27 +0900
X-Iguazu-Qid: 2rWhWAeBnEWYb9Q9DQ
X-Iguazu-QSIG: v=2; s=0; t=1750835906; q=2rWhWAeBnEWYb9Q9DQ; m=gn3QICnVqlV1bC5BJ5z1hIHdT77spMATbJjQo5oXTyo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 55P7INOG253964
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 16:18:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sS+oA4XVcDCgf92hR/WQtRuGOw2Ii5q+P3zY+XWu1j7FWe9YcBScTqS1T73dMDVvHg2F0kQ8pq35G7pj7HVb6H4dHNZR0aE1hOtBe0EpUwsSGagHLdjT+TArv3cqq0DSzAAiWnaMsga3XJAi3EtpjVX3snuhQGmqfdnQA2zSWlUl6pe85vJ5JgZ1wOANdbQHJBO3c6np2QUFPA46os7nadkWOHGiDjLQZMwcQKrr1uUMTSR1eYL2ihe3RXrhviq0q3Mo8khdHVGt9qFIr0hyiD85Fv+fP8eHksb6Y7HaeYLZ1Gqr3TEu6FitMc/8MQbrFLBF8vCdMvsrGKvHKhGSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4XiCaMBSXgTHC4zFXpyqVVi5U+VUZnxAjan3RejLmw=;
 b=iuviP9RI9ce1Is+j/KAOtSnPCf1DrxQ5Oa61le9PFeG6sessEY7SFBAizCHWfLpyOpjTMyYvuiMT55mA5zgZMOsu0AxeybdwKgTt0RW35XmtaL4nBn8PTGgXv1T66xGAC5EFJ+tL+XqDjQISXuXJOBgJb0BR/zevV1YT4CLRBNq4e6UZOf/CJIl0EfFI1szRSr2/n6UIp4ElzHL/M9O0AF8vK4kdgWyxRj9bKOhV2clidt2OFWrjCpuVJYIstCOB7jq+6uASeJkcTWFXRbO+SvvvH++M/c6BvCQdpTbX6O3oke+hYLNcOXdDWj4iaXBowccD0Q/MUM+0Mthmu1oGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <gregkh@linuxfoundation.org>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>, <pavel@denx.de>,
        <bvanassche@acm.org>, <stern@rowland.harvard.edu>,
        <yi.zhang@redhat.com>, <stable@vger.kernel.org>,
        <martin.petersen@oracle.com>
Subject: RE: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name}
 directory earlier
Thread-Topic: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name}
 directory earlier
Thread-Index: AQHb5XTz5FbjPd/DfEex+j2Da/vn1bQTc/YAgAADGpA=
Date: Wed, 25 Jun 2025 07:18:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818AE41EF3127F74E29873B927BA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <2025062506-thimble-unwieldy-9c6c@gregkh>
In-Reply-To: <2025062506-thimble-unwieldy-9c6c@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11827:EE_
x-ms-office365-filtering-correlation-id: 73c3aa23-5d67-4448-25db-08ddb3b87672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Yys4WUhlMzlaSVlQYUkwRmRORDNKZmYySi82MVRrdFpvcWdiN1BvRmkx?=
 =?iso-2022-jp?B?V09RRGt4c29TNGpkSjZCVzVXUnNZcEN4ZjRxN3FPUUVsZm1vUWFRNWw2?=
 =?iso-2022-jp?B?ZnpsQmI2VTBRdndvS2ZHOSsvYjdFa1g4VW9ZaXJDcUVpTEI4d1A0bnZr?=
 =?iso-2022-jp?B?NjdSQmYvbDVkODlPREZ2NElEUmZWdWFyUTVWdnV6UkYvQ1dzY3B0UWQ5?=
 =?iso-2022-jp?B?RWx2aGtCVXBzZmZ6dmZLdWZzKzlRc3BFNkl2TVowOW1xdks1MEx4NTRQ?=
 =?iso-2022-jp?B?bFBLSzlJOWkvZTA5cWE1aWRFbW9VNXluY3hIcGVRSzZoUkwxYXJpdHVo?=
 =?iso-2022-jp?B?U1hHSitYZ25HT2duOTdFOUVzZlJpODBLVHppY29JQUNFZlhvVHAzaVlD?=
 =?iso-2022-jp?B?VnI5Q01nWlZEZG00cWRZM1JIWlZxRDhqT2xqS2l5bEI4VTU2RkxDZWV1?=
 =?iso-2022-jp?B?TDZjSDhIeGNsb0EzZngwcnVDVUgyVVpOclhXb3l4OGp3TUhJWDFPMHg5?=
 =?iso-2022-jp?B?U3drdjcwSmhrWlI2QVRkUEVoblpDelg3L1JpVnoraFJLTUtUcEwvd25P?=
 =?iso-2022-jp?B?SDM3Z2U4Vm4vb2YrV2lkLzJKR1NzSXEvaExEb3g4ZWozbVdwb3d3K0xk?=
 =?iso-2022-jp?B?VElNUkEvdGtoY256cFIyRmhRUGNuWjhOK3JYdk1XVm5FTzh5VVplSVl1?=
 =?iso-2022-jp?B?Q2RWR0MyR2taL09Qdm5OSlpnTk9jTWs4YXllbGVTMXJjQ1VXTkQ3OFpW?=
 =?iso-2022-jp?B?NUNZZkhJMUE5RUJIKzJwaFJsK3BuRlpMekFMaWFEMXFMMGVsclNnRHUw?=
 =?iso-2022-jp?B?a0E3Sk85VzlOVkRBa0dMVXdvY0R2blhTamc2NjUxbzkzV01QL2pCdlpM?=
 =?iso-2022-jp?B?a3RtSWxtT2R5QUVFZktEb08wNVpHWlRNNUlpalRqS0U1bzMrMVRHS2g5?=
 =?iso-2022-jp?B?a0dIbWVkYUs0OXlzM05QdWJYRG50d3RMKzg5RkZGQ2QwNUVLYlo5TUYx?=
 =?iso-2022-jp?B?ZWJtTDJyNDUwM25vOUo4N2wyVW5Eck9CREsvZkRoVk0ycmZtTEtnbVB6?=
 =?iso-2022-jp?B?NzU1eUQ3KzdYVTZ4QzBZVWpqalJtb1QvelZEUEdOeFhQZFNwQWRpTHFm?=
 =?iso-2022-jp?B?bGM3bGhaaG9YZ0NjcWNYaVRBcVl2T3FzMTFiY3ZRMmNTWHlZdk9VZDNE?=
 =?iso-2022-jp?B?dmdnU0xOYnZoTnRJa0tFamVjZmwyazNHSDJxOXk5NVNQdnBHeUcvZWIy?=
 =?iso-2022-jp?B?UkswTU9CL29mQXJqR25ocG5sUzZMZW5ubXQ4R1lNSFRxZlVkakE1cXE0?=
 =?iso-2022-jp?B?MzJkM2gvMml0U0tYOWFsMlg3RVpER0JWU2J0RHFkdmIySUFCdWUra1Yx?=
 =?iso-2022-jp?B?RFBZRkRDT0w4OUoyL05iZEFFd3VKRkdLZEtmVGt2NjZveTJaaDdkOEJG?=
 =?iso-2022-jp?B?clNWVmgrZ3BXQk5YRFUxTDhkWENlVWNEcUJkMHJnSVZNNjhFcnBRQ3RH?=
 =?iso-2022-jp?B?eU9LeVdRdXNNZzI1VEpIVDRUT2RlaExJeUNIZW5QYWtyeG1IWm9VaFAr?=
 =?iso-2022-jp?B?U0grTUd6SDZwZGt5NDZwV0F0cXhlY2gzNHg4ZVRDRng0QXh3MTM5eklr?=
 =?iso-2022-jp?B?TWlEcHRZUUkxN3BPUFdCZXY2QlUrMHdicGRPY2tmcUpnYnlLSG9uMDVx?=
 =?iso-2022-jp?B?OGN3NExISHhpVG1uOTNLV3FLVzhKcVZqaGIxejMvZDE0dGs4ck12QnN4?=
 =?iso-2022-jp?B?ekFaOXlJV2U3OHBzcjd0ZzdiRWpEU0ExM1JJRVRhdTE0cVlIcnpNcDN5?=
 =?iso-2022-jp?B?d2NKVDJUc2F1cVBWWlNFR2dhcHUvQy8rdzlkd29lU1NBWFk0NlpSOHBB?=
 =?iso-2022-jp?B?WEpuc3REclF4cDBwODlhTDdtbitzSHU2bE83bTJkNURlTDBLdWRRVmt6?=
 =?iso-2022-jp?B?MmdYVDdCeks2M2VKS3Zqb0tRL05DYXFFMG5uVVVxZk5qd2pXQlBnNmdQ?=
 =?iso-2022-jp?B?V2lFb1NXNjRkdHk0eDkzRVRnNnIvODBwU29wYXN6R09sM2ZkaHgvYTFx?=
 =?iso-2022-jp?B?aGFGR2lNOU5mZnpEenNWQnJ2aDkrRkpjOVVDbEtkTzdMcloybGZpdjlK?=
 =?iso-2022-jp?B?SVFOMkVuQ3laNTdwQk9nVzVLYW1ZZkdwM1dGQXZiSkdDTUVDMjhVQ2pD?=
 =?iso-2022-jp?B?dm1BPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WTgrQmJEUnRNczliKzkvbHo2MU1jMkVBUXpZb3NXOVJFRU5zYTR4WWhX?=
 =?iso-2022-jp?B?L1plRGMxOWtQZEFZdjNBYXNEYzRIcEhXY3pJSmNhZzhZeitrMmZaZXNC?=
 =?iso-2022-jp?B?S2Z4a1oxQmVzajAwVHRyV0FXeUxCKzQ5WEFPNFpiN2lQcHgrM2lsM0dS?=
 =?iso-2022-jp?B?bjYzaVdyOE1aRHZ0NGR3UHMwTEozWGtMWWN5SHhJOFU2R2cycTZ1STJI?=
 =?iso-2022-jp?B?SFBIbDZsTUk1TWdzWi9FcmlkZW1RL09nUC9URHlYaTBoYnQrS3lSbnBp?=
 =?iso-2022-jp?B?OWxwZGFPR2E0Mkp0b0ExRkJGM3FSM1F1WGYwa3VhQlR3Vjl1UVh1Q3lL?=
 =?iso-2022-jp?B?TDk0TTY5VFFSaEM2Sk94UnlxYUg4L1Zvd2ZlUFBBaXhUZHluU0xCRUVW?=
 =?iso-2022-jp?B?UmtZZVdpWDdMWkVXQk43QnpVenIyQ3huR09jV3lLODkxaE1aZXBiVlh5?=
 =?iso-2022-jp?B?N0gwOFpZT3hnUVZrcHVWa2N1ZTV4dlNza3RBdTN1UVZnaHFRRFFvRGdS?=
 =?iso-2022-jp?B?ZnRSa3c5aEo0clJVSi84Rkk4aDUzVXk0SlVMMkY1WmJoa2RHUkQxUEdo?=
 =?iso-2022-jp?B?TEdxTkFMTWVoenFtTGR2NndYK1NkeFl2ZGwvYWxqK2tpdHl3eEJrWFhn?=
 =?iso-2022-jp?B?RGo5U2pHYmlySzhrVy8wd1NCNlNKcXFzbmdIYWI1VEJrQkwyWGsxeDhL?=
 =?iso-2022-jp?B?WW5EbnEyNTBVZjl6ZjRzUVZKbDdTbXlacS9WMWcxSXYwOUMyTnpoLzlH?=
 =?iso-2022-jp?B?Z1ovSzBqZ2U0c3ZVdCtEejh6L1MrTDQyK0pscmgrSlN0UmJFZEZ4a3d3?=
 =?iso-2022-jp?B?SVl2aVBNeTNBUEdPeWMvbmNodlUyNFB5RUJJQThUUEZlUlhRaXdubVQ0?=
 =?iso-2022-jp?B?VW1hWFlOSEQrMlBwZXJuRzZjdjZRTjFDUUUyZzUxWHlvVVhjU09hS2pr?=
 =?iso-2022-jp?B?MzBkbXo4eXBBNWYxQzlBV1RzNlBnT0didWxGbmp5SlR5V3RidjFlQWUr?=
 =?iso-2022-jp?B?SjRKTXlBYW9tYWxFeDg4UVkxUFlQcVE4V1VpeGdGbTJhQTE1UXRXR0Nr?=
 =?iso-2022-jp?B?Q25wYnhxUHZqenV6VTA2aUcxSXpEaWdTNHo2blU3SzJOeGlFMS9KMWVu?=
 =?iso-2022-jp?B?WEhrMnYyVjVkYkFPOVpITVlLMTlmZVIzSFdhdGc1dVVPWDhkcmphVWVV?=
 =?iso-2022-jp?B?RjFkbFQ5K2MzNUVpd24zeElWdzAraXd6WDl5TUtadGJzOWhKMG41OXNm?=
 =?iso-2022-jp?B?ZnZyT25XNmJ5cVAwYVphaVM4VS9GNm9rOXEwQ2hlY3VxM2IwQXZydGNP?=
 =?iso-2022-jp?B?K0c2d0dFbm1acW5JeldSM2txQkMzWksvMmplSjNIcWRNc2hINUlhcFVu?=
 =?iso-2022-jp?B?NE5VM0cxNThXNTVPdDNDbzhOMTlsTzdvc0JWRFJwYjdyNGFDU2pXUXpU?=
 =?iso-2022-jp?B?YjlYa3VGS3BrUWFTK3dUdktsM0Z1Mlo2dzQxOGJxdHA0SnNCc3VTcFNR?=
 =?iso-2022-jp?B?QkFId3YrRjUxWVIyWmdOU3dRT0I0VTZCZmcwclVHVW9jdXg3LzBYRk5i?=
 =?iso-2022-jp?B?YTZiQ1ZwbXY2ZWlvelJPUEV2anVHSFYraXM3bkh6V1hlS3V5dXBQYmwv?=
 =?iso-2022-jp?B?WTJnYmJubXh1elBLb1VBZjduUDRENTRad3ZlaFlya0JJcnY3YUljaTVh?=
 =?iso-2022-jp?B?K0dNSW5QQ08xejhOTlV1enNYd1RDOC9MdnRJTG5idEUreGFYMGJYdnFD?=
 =?iso-2022-jp?B?dlRQRGdXVE04bVc4VkN2T1FLQ1M4RmdlMHZvSzJnTm9aZzR1aWQyOHBm?=
 =?iso-2022-jp?B?RVM2OVZnWk1PZCtRTzl2RzRWTXAwNXhzMXhETjFBR3k2WnJvSTgzWEIr?=
 =?iso-2022-jp?B?bUVVa01EYUN1QWxNcnVZSHRQMG5jaUdMYkVHY21PTFZmSFdsRmk2NnFP?=
 =?iso-2022-jp?B?MVFJVVd2QTY0Y3hNVVk4QXNzUi9JY2FSaVdXQWNVK3V3cjJrL0JEL2c4?=
 =?iso-2022-jp?B?ejNhWFJEMFMzWUFBeXdPQ1ZBSzlEalp6OTk5UnNiM21xTHlGaC9QUVI3?=
 =?iso-2022-jp?B?Q3VldEg2WHZOaFdPRjVWN2RDaUN1WE9HMnl2VGViSXgxQjRIK2FrTFdJ?=
 =?iso-2022-jp?B?MXQ1WHJMUXRBNTVVQzNpM0pDTWcvK3hZRkhzWEtVb3AzQWpPUFFMRFVy?=
 =?iso-2022-jp?B?R1VBMzQ5OGtRUkJVRk5XbXArOTBaMlhpSlIrQXlHaHFjOHVXVGhrU0g0?=
 =?iso-2022-jp?B?OFdFdkplalVQbm1ZRHE2U2RBeGNJamZxSzRDLytoYndOL0dUN0VLRnFp?=
 =?iso-2022-jp?B?QTIrUmFWVWN5QmpOSG1YcTVVT0xNRDJFZ0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c3aa23-5d67-4448-25db-08ddb3b87672
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 07:18:19.8549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZwmzqGHIlu1h1evHf4BYUP6eml8fF+ObdZOGDDFom8JSR0jxjyCOrg/qmtJq9CKFoZo2dIZRq6n2sXb54NJGaDYJ8o27ixg4vaEqxtg4ZQs467WD+l3x51J4mhvfmN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11827

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, June 25, 2025 4:05 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org; Ulrich Hecht <uli@fpond.eu>; Pavel
> Machek <pavel@denx.de>; Bart Van Assche <bvanassche@acm.org>; Alan
> Stern <stern@rowland.harvard.edu>; Yi Zhang <yi.zhang@redhat.com>;
> stable@vger.kernel.org; Martin K . Petersen <martin.petersen@oracle.com>
> Subject: Re: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_nam=
e}
> directory earlier
>=20
> On Wed, Jun 25, 2025 at 11:00:26AM +0900, Nobuhiro Iwamatsu wrote:
> > From: Bart Van Assche <bvanassche@acm.org>
> >
> > commit fc663711b94468f4e1427ebe289c9f05669699c9 upstream.
>=20
> 4.4.y is long out-of-support by us, and this is in all activly supported =
kenrnels at
> this time, so why is this sent to us?
>=20

This was also sent to stable due to the processing of the patch's CC tag.
I'm sorry for the confusion.

Best regards,
  Nobuhiro



