Return-Path: <stable+bounces-46277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506278CF9CE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1D4B21939
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF91757D;
	Mon, 27 May 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WSgJQJZS"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388222301;
	Mon, 27 May 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794160; cv=fail; b=NDlX6NEz40uMq3dsic7syy48dZWUbVW30DE9iIu7v7vXzlUCrwmClncSydcZ1JlzU1O6zGf+4WbZJ9CC4Pm5FbSnkqATJ9P8CnXlGGOK0aZpDqUBA4kafJavXT3BLCBzncaiw+6POom+ykXoP6FpnwCGU1OkS15jrBXI2l5L0XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794160; c=relaxed/simple;
	bh=IafR2oVM2ZyX3mfUOqthIkiQPruOrkyNLhtCvll7FLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ayRq5TvDKhb2NzPnMaQ5Pycg1bBNsgOfjC5758C49753h1JNfK+srqpTBvMrXe135IQW0QE6wB8DLzBbw4Cd7ceHdO0cHrmalV9DHJhzkXOM9duKcKKfZzjTHMdpvWVYRQNoZZrN9zx5djfErPcPm992wIdfrX+01aaNQscV0Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WSgJQJZS; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgufZ0hOHxoQHXThP3WBcjEpveeeEfvJ36dN6pOG8YgM2IoPIUl9cPqsjPYyzyYPu3nEnJTC/yYiiJmXCk7PuLCuA/aSCXCKaIcog5+3ozSJw/TKsL8C4Z4QE2OQZkgwWVcsWKxJEdVARmBAczbBo2FvSkcYVrpDTL/+o+Zp1jCJBn+aU0mSARg0tHalpUNsSbNeFmy9UEKf6kTkwhAmvm/tFIP6DYyhovpMwcI9yyrna99vnloh6rHFVINOb+2e8nPzeVEJoNXnz7oLU11wgXzCTDFUCn20ykI6o2NaEzibGcefChTCx7b2JK85BfCVrQTBSN+9+/YI+fimjS8DBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IafR2oVM2ZyX3mfUOqthIkiQPruOrkyNLhtCvll7FLk=;
 b=eEZ8V8llrfjSEvYHAieZFIomgWETmhaMJJMTraNinnTF/GKiBEvw4gQ1hTPteikcnuIlMVgGg31bPk7M7a8/C3jRXOnt3YUVzGQy0cpz9q3WErsvLokLZAixnpZo8RQemhPSQkFzyjsrxz88z64U7i9li4kJOJyMyolcQU/5GZWYu2Ee1tAaj6XbU4cgSLGODzSst45Sy8fqE75Sv8aV79Zaqkk3RkOYHumgCc9K4L5KtMvklvFDx3+1vYiV/sKruX4l9QBo6u0g5D8i6GgtIeoUApul02Kj37DUkwGx4ZGHXMSritH1FibUFiKA5K3hKDdd78ReGpBkHPl0imE90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IafR2oVM2ZyX3mfUOqthIkiQPruOrkyNLhtCvll7FLk=;
 b=WSgJQJZSe3AhkVNotySXYDS2m0zuRPHek3gxzYzZmcK/kSjijLul3Dq8xUf4gx9+V9Zpa2mpn+qvwR0AACWPyzuDovWvhJzT+DnYzBYX5+VDxEiRouRVVniW0bygZwHT8SczThm3N9mh0FDlDKAFFuKpiEedcaSNno8a6sSj3/0=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:15:52 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:15:48 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Luke Wang <ziniu.wang_1@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>, Rohit Fule <rohit.fule@nxp.com>, Neeraj
 Sanjay Kale <neeraj.sanjaykale@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Jun
 Li <jun.li@nxp.com>, Guillaume Legoupil <guillaume.legoupil@nxp.com>, Salim
 Chebbo <salim.chebbo@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] Bluetooth: btnxpuart: Shutdown timer and prevent rearming
 when driver unloading
Thread-Topic: [PATCH] Bluetooth: btnxpuart: Shutdown timer and prevent
 rearming when driver unloading
Thread-Index: AQHaqEuDG/cRC2wJ5UWkpTws8vCKuLGquAqw
Date: Mon, 27 May 2024 07:15:48 +0000
Message-ID:
 <DU0PR04MB9496ED073E08FBF57FA2038990F02@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240517111535.856723-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20240517111535.856723-1-ziniu.wang_1@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|GVXPR04MB9928:EE_
x-ms-office365-filtering-correlation-id: 007309c4-debd-4bd6-cef5-08dc7e1cd538
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZXR6NUtVL1VObjk0T3haaGVtNS8yWDVqbGpYeiswM2poR05TQU5NckViZzYx?=
 =?gb2312?B?SG9mbytYamFGbktYMTdsN0cyWjVNUjRlZDZpN3ZuRkxGRHZBbVdPZlFZSUdp?=
 =?gb2312?B?WHdYU2FtWVZEQ1k5K3pBMXZIUGZ4cys5TER3cHBHMUFFUUdwUVhCdkpYU1pp?=
 =?gb2312?B?TkF2TEdwY2pXNGNSelJXRDVjaC9yZ3NUUGFmOEpHR3pSWW8yZ0UrbENFVEtS?=
 =?gb2312?B?djQ3d1d6VDl5VGdSZEpSNGh5Zm5PdUFDSGdoaEFwb3FQU3NJckJqMmpIQ3I1?=
 =?gb2312?B?cEpYaDhPS09nMDI0RmdyRE5rQnJkZXhLb0d5Y3F1aWlaQ3RpWHgzcmlucm0z?=
 =?gb2312?B?UnZpVGF3Yy9MRDJ6V0poRVFoMitla3pxeXg5Yk9Va1VZdWtuZjVsYXprWGFU?=
 =?gb2312?B?ZTVCYzlnUGd1QklubjBWQS9WN01rMHVlVlJsZldycHRWVVhtN3phaGN1Rm9M?=
 =?gb2312?B?UStEU0pZVE81ZVlwbkJsQVZUcFhTakJHWUVVamtxUmNwMU85VEVZSkN2VWdj?=
 =?gb2312?B?UEw2QlVtMGpFU29JYmIza2R3THNncEtzSmpiTStCTnNmSWFSK0tEZ0ZxTU5x?=
 =?gb2312?B?Vi9YQUdvQno5dGt3dUwrMGxoMDA0a1VqVVdxdS9seDhNeEtwdXVWbEZWaFJw?=
 =?gb2312?B?NTFRcHRJT1NtTFM3dzZZZjhuZ2c5cmEyLzBtbFAxYU9oWjJseGlMQ1RDd3BS?=
 =?gb2312?B?c3FKb2F2U1ZIMmNqN0NmREpLL21PdzZiY2U0dFBqaDVMeThhakVQMmtJQXVC?=
 =?gb2312?B?YS9ab3VlVE55OTU4OGJ1ck5HYlZUb2VXZ1hWZGxZQUJZaDRGQjExaHJheFVF?=
 =?gb2312?B?dnZoNkIvb1Z0Vmg2a0hBUkIzNzlmRXNSZjd2emIwczFQM0h4NjFobEtCMHBL?=
 =?gb2312?B?aEFNU21pZFNBTm15V24wM2FHajRjU09jVjErMzRPdlFiM3BHYWRkT1pmWXFN?=
 =?gb2312?B?NmpjRFFPTlpMNzAwNENSY2JvRlVrNjQvanB1cGdMdU1kVisvdTdISisySFh2?=
 =?gb2312?B?RHU1bEdWdllMdnd0cUI4aHhKN05tR0NEYXh3ZFNDOUpCWXhyZ2lTaTZnZGYx?=
 =?gb2312?B?dHNQL2RHd2tMTUxINnRtYnVrVWxMSG5SSjRKejc5dHlNd0JCRTdsdlZLdUVY?=
 =?gb2312?B?MHJXMndUa214MEd2SUl1SDVJWEx3S2UyOWFlK29qMlJObWNvMFJzY29EOEV3?=
 =?gb2312?B?ZnpBMXp2d1kyMlVoOXAybktKbXVNWldFSUM4UWNzYllZRUM1dFc4elJYd3Rt?=
 =?gb2312?B?UVNTMnptblkxVEc1bmlsSTlUVDV3L2kzcDloZGJiTnB6UEFYYWN0V3RMLzZn?=
 =?gb2312?B?NGRYQ3dudmtRcUQ5cHNnelZDODc0Rk1qVU9PQyt5aW95YlNDcU1zSDVveDlB?=
 =?gb2312?B?Mzg1UThpQTk3QWU2eEtka0hqd0pHZ3d2TzRVWDJSN2N2NzZMeEJNVG42NkpB?=
 =?gb2312?B?b3Ezc2NRaUZoVVZGNHFRRG1Zd3JXNzFTc1ZxTUhleVI1T2FLMGhwYXlYaWRt?=
 =?gb2312?B?aGJFbGh4VGdTeG5YaUZsWHlXKzZqUVVNeUhEOWplZUNZT3A3NWFKWDYycVd5?=
 =?gb2312?B?VnNPbmpIUWV6bmlIY2hTSTNtQmdQWXQwM0pYamtMS0I2NHBGVjd4SWkweHNL?=
 =?gb2312?B?U1FSK0FEZzBxSi96d0xVc3hmMm9JUFpvWEgzUXp6elJ1bkczbmtBcXJHSGE4?=
 =?gb2312?B?bnU1M1QzSm1hdGY4UGJUbTEvYSt1Qm1OZDdCODhRN0NaS1hzR2ZHclYra2tO?=
 =?gb2312?B?THFmeFFkbFFFU3U2WURRRTJGQTE4Vm5DYk5GRGkycXd1Tk8xZG5kenU1Mnpa?=
 =?gb2312?B?T3JMNHJjOEFFTFlDek9zQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SWtHQjV3VWhEUlBTUjFEWnJtOXhyZU5VbzFBalRDQTJHWDdTdytuVCtTRHM2?=
 =?gb2312?B?Q1lTMWF5Mm5TRjh0RGdkUEtKOGRxSUhUcndaNlNseVZyS002S2RGdWkzcHhE?=
 =?gb2312?B?T0hxajRLNjBTNFRucDFEQnRGaWNxdS9qdWkxcjBJbFl3TFFLdVkzTVRmK1hy?=
 =?gb2312?B?SUpPVzJiZ2lxb1JnaHBmQTY4MTA3bWRnK0JPRit6TndmeDFueWZkYWJ1Wmlv?=
 =?gb2312?B?UVJ0dm9MUExPbE9wMTllVFJqM2UzKzVVMGc4R3p0WCsxNGYrNVgwWUQybGdB?=
 =?gb2312?B?aUJFRGJRSC9ZU1hhTGVRcDZzSGhXcGwrM09KdkdxWkc4RCs4ZThZLy92Qm95?=
 =?gb2312?B?K2dZQ1JrdmhFM2NWNE1XZi9XeHR2VzEwcmFGTGpwbDV4V3J5TkkrWFM5akdu?=
 =?gb2312?B?R21JTzZKY09MelU2RVo5MDVIZm1VZ1FWaHp4Yk9renUwaXFXMTRlZ1djWjZU?=
 =?gb2312?B?VVdWd1dLTUhsb2tIWHJWcFJCbXR2Q0VsM3FzNjRLelhiajZlRFdrMnRTOFlz?=
 =?gb2312?B?Z1BUR3IvWlI0MUJrajR5ZXR5M3ZCd1dDdVIwV2lNTkZJQ0hnbDB5UFRjSHlL?=
 =?gb2312?B?M28wby8yeFVwdXBRdnQzQk4xMVNPV1ZWS2wydlRKMVZMbkpUQitJZDVPS3My?=
 =?gb2312?B?VWk0TkdBK0hrc3plc3d2UzZxZHR3dGZZcHI2cTYvSkpoSWNoZXpua1FHSE54?=
 =?gb2312?B?WiszMFlBQUZVRmpZd3Q5RU0vZjBaWHB4TS9WUU4xV1VKblUya1dUU0FRQ3BZ?=
 =?gb2312?B?MkNRVjhIRjlFY256YU8rSTBiOFVncnVhT1NQb1RZc0VJNS83WHZNTDl4aktS?=
 =?gb2312?B?eTZqa3ZMWUJ3TWF3ZWZTdUNQMlRNV1BEZ3hDbGhXSEdRS2xRWjMxYk0xUHhT?=
 =?gb2312?B?TmRjSXo4TDlCaDVsa2ZFZGlIV05La2VPRC9VRys2cTJrOHZVbDU3V2VzSklz?=
 =?gb2312?B?TzU0Wm9YbnM3cGh3WTgreFVBa2dOdTRjK1NtLzJwRkNOa1FmUUZKaFVkUUMv?=
 =?gb2312?B?R0xGTmExaFNobk1nYkJvd2NlSm0xS0tmTzVnK1MyWTBKcnhIQU9pTU1YaVBQ?=
 =?gb2312?B?K3JUd1Y1a3hhR0FHNUExYWlHcWlJVjQwTGFqaCtKRDQwelplc0xheEgwZENi?=
 =?gb2312?B?RXpiNFZEL2JuVjhVUkRqVmFRT2JVQjBtLzVkZ2UzMFFXc2IveVRUMzNvTm4z?=
 =?gb2312?B?V25DVEV5Y1prS0kxQlhmZkhaRG5leGxVTGl1OUZLSHZvaGIxZGkxTDd6aU96?=
 =?gb2312?B?a3U2SGNrMUhaTjY1Tjl5RU05dWNHRmJESTRxUnBIUGQ2YlZIejBjZlluMCts?=
 =?gb2312?B?dllEbDJTNTR4V2F4c0h5eVJzVUQ0c2NiemtLQ2FzRXFBTzl1M0hDYVkvVlM5?=
 =?gb2312?B?TUFwVkszQzQ4WE9UZkR0WDZvQ1lLek9CU1drVndHVHEvQlRvaHFUekxFTmJC?=
 =?gb2312?B?b3lvOUdvNmdiUUo1K2UrMkpsZGNhRzNkN0VYT0F6OFNXMmRialVkeHk1amk0?=
 =?gb2312?B?ZUp1dmh5T29SZHBSTEZWYk42Y1k4cHQ2eTNvS0xZTFIvWlpKM0paYjhocEVC?=
 =?gb2312?B?amRWcVI4RjR3djVRaGZvTS9xVVJ5ZEM5WWZPWUlaZXk0SFdhR0dyNTFzVTRi?=
 =?gb2312?B?M3NiemErd1E5U3JxeUNBVlFtSWQ5VkNpOThZckVSd1ZqSEdEaHBORVhuSmVU?=
 =?gb2312?B?N3pGWFA3RDZLTURyNVNzTlJzWEFmOWVkWVppdWp5Z05tNVJvcmRBWC9GS2gy?=
 =?gb2312?B?WjQvS3RPRCtOMHpXMUhFTG1uOFlLYW9YK2xpeHpZR05vQzBIMGhTOEVZNk05?=
 =?gb2312?B?dDNRcnR3VkdCTGQxY1M4WklxVnBvWE5ncHVoZzBOcXdDK0doQTFiVENwWHBO?=
 =?gb2312?B?N1hUcTN6TmtzWkFERjJpbnFzQWUrYzJsT0RTbFdhejBXN2lidUNyVm52b1h4?=
 =?gb2312?B?VkdLVXlUcVlSZ0tmVFpJVG5BU1daQ2p0Ti82V1BianpoSFEyVzJ1OGswS2hL?=
 =?gb2312?B?dVM0UXF3QlB5blRGajVWMmhLbGxtVE1mc09MM2I3Vm9qbkd4YlZSTmkremRZ?=
 =?gb2312?B?bVRTMjN1bVR1ZUtNNzF2MEYxb1d3ZzBhY3k5TVcweGhSR2toaVlYbi9qaTFw?=
 =?gb2312?Q?NWkM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007309c4-debd-4bd6-cef5-08dc7e1cd538
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 07:15:48.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E18ftEUo1qgCkg2RxOvVK9NGK2TyyFb/uRauGCEybEW1k1k3XlSgR94y+8htdWFelQ79slXkFVNY+nHDEE4eyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo11MIxN8jVIDE5OjE2DQo+IFRvOiBtYXJjZWxA
aG9sdG1hbm4ub3JnOyBsdWl6LmRlbnR6QGdtYWlsLmNvbQ0KPiBDYzogbGludXgtYmx1ZXRvb3Ro
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW1pdGt1bWFy
DQo+IEthcndhciA8YW1pdGt1bWFyLmthcndhckBueHAuY29tPjsgUm9oaXQgRnVsZSA8cm9oaXQu
ZnVsZUBueHAuY29tPjsNCj4gTmVlcmFqIFNhbmpheSBLYWxlIDxuZWVyYWouc2FuamF5a2FsZUBu
eHAuY29tPjsgU2hlcnJ5IFN1bg0KPiA8c2hlcnJ5LnN1bkBueHAuY29tPjsgQm91Z2ggQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPjsgSnVuIExpDQo+IDxqdW4ubGlAbnhwLmNvbT47IEd1aWxsYXVt
ZSBMZWdvdXBpbCA8Z3VpbGxhdW1lLmxlZ291cGlsQG54cC5jb20+OyBTYWxpbQ0KPiBDaGViYm8g
PHNhbGltLmNoZWJib0BueHAuY29tPjsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBb
UEFUQ0hdIEJsdWV0b290aDogYnRueHB1YXJ0OiBTaHV0ZG93biB0aW1lciBhbmQgcHJldmVudCBy
ZWFybWluZw0KPiB3aGVuIGRyaXZlciB1bmxvYWRpbmcNCj4gDQo+IEZyb206IEx1a2UgV2FuZyA8
emluaXUud2FuZ18xQG54cC5jb20+DQo+IA0KPiBXaGVuIHVubG9hZCB0aGUgYnRueHB1YXJ0IGRy
aXZlciwgaXRzIGFzc29jaWF0ZWQgdGltZXIgd2lsbCBiZSBkZWxldGVkLg0KPiBJZiB0aGUgdGlt
ZXIgaGFwcGVucyB0byBiZSBtb2RpZmllZCBhdCB0aGlzIG1vbWVudCwgaXQgbGVhZHMgdG8gdGhl
IGtlcm5lbCBjYWxsDQo+IHRoaXMgdGltZXIgZXZlbiBhZnRlciB0aGUgZHJpdmVyIHVubG9hZGVk
LCByZXN1bHRpbmcgaW4ga2VybmVsIHBhbmljLg0KPiBVc2UgdGltZXJfc2h1dGRvd25fc3luYygp
IGluc3RlYWQgb2YgZGVsX3RpbWVyX3N5bmMoKSB0byBwcmV2ZW50IHJlYXJtaW5nLg0KPiANCj4g
cGFuaWMgbG9nOg0KPiAgIEludGVybmFsIGVycm9yOiBPb3BzOiAwMDAwMDAwMDg2MDAwMDA3IFsj
MV0gUFJFRU1QVCBTTVANCj4gICBNb2R1bGVzIGxpbmtlZCBpbjogYWxnaWZfaGFzaCBhbGdpZl9z
a2NpcGhlciBhZl9hbGcgbW9hbChPKSBtbGFuKE8pDQo+IGNyY3QxMGRpZl9jZSBwb2x5dmFsX2Nl
IHBvbHl2YWxfZ2VuZXJpYyAgIHNuZF9zb2NfaW14X2NhcmQNCj4gc25kX3NvY19mc2xfYXNvY19j
YXJkIHNuZF9zb2NfaW14X2F1ZG11eCBteGNfanBlZ19lbmNkZWMgdjRsMl9qcGVnDQo+IHNuZF9z
b2Nfd204OTYyIHNuZF9zb2NfZnNsX21pY2ZpbCAgIHNuZF9zb2NfZnNsX3NhaSBmbGV4Y2FuIHNu
ZF9zb2NfZnNsX3V0aWxzDQo+IGFwMTMweCBycG1zZ19jdHJsIGlteF9wY21fZG1hIGNhbl9kZXYg
cnBtc2dfY2hhciBwd21fZmFuIGZ1c2UgW2xhc3QNCj4gdW5sb2FkZWQ6ICAgYnRueHB1YXJ0XQ0K
PiAgIENQVTogNSBQSUQ6IDcyMyBDb21tOiBtZW10ZXN0ZXIgVGFpbnRlZDogRyAgICAgICAgICAg
Tw0KPiA2LjYuMjMtbHRzLW5leHQtMDYyMDctZzRhZWYyNjU4YWMyOCAjMQ0KPiAgIEhhcmR3YXJl
IG5hbWU6IE5YUCBpLk1YOTUgMTlYMTkgYm9hcmQgKERUKQ0KPiAgIHBzdGF0ZTogMjA0MDAwMDkg
KG56Q3YgZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJUWVBFPS0tKQ0KPiAgIHBjIDog
MHhmZmZmODAwMDdhMmNmNDY0DQo+ICAgbHIgOiBjYWxsX3RpbWVyX2ZuLmlzcmEuMCsweDI0LzB4
ODANCj4gLi4uDQo+ICAgQ2FsbCB0cmFjZToNCj4gICAgMHhmZmZmODAwMDdhMmNmNDY0DQo+ICAg
IF9fcnVuX3RpbWVycysweDIzNC8weDI4MA0KPiAgICBydW5fdGltZXJfc29mdGlycSsweDIwLzB4
NDANCj4gICAgX19kb19zb2Z0aXJxKzB4MTAwLzB4MjZjDQo+ICAgIF9fX19kb19zb2Z0aXJxKzB4
MTAvMHgxYw0KPiAgICBjYWxsX29uX2lycV9zdGFjaysweDI0LzB4NGMNCj4gICAgZG9fc29mdGly
cV9vd25fc3RhY2srMHgxYy8weDJjDQo+ICAgIGlycV9leGl0X3JjdSsweGMwLzB4ZGMNCj4gICAg
ZWwwX2ludGVycnVwdCsweDU0LzB4ZDgNCj4gICAgX19lbDBfaXJxX2hhbmRsZXJfY29tbW9uKzB4
MTgvMHgyNA0KPiAgICBlbDB0XzY0X2lycV9oYW5kbGVyKzB4MTAvMHgxYw0KPiAgICBlbDB0XzY0
X2lycSsweDE5MC8weDE5NA0KPiAgIENvZGU6ID8/Pz8/Pz8/ID8/Pz8/Pz8/ID8/Pz8/Pz8/ID8/
Pz8/Pz8/ICg/Pz8/Pz8/PykNCj4gICAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0t
LS0NCj4gICBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogT29wczogRmF0YWwgZXhjZXB0aW9u
IGluIGludGVycnVwdA0KPiAgIFNNUDogc3RvcHBpbmcgc2Vjb25kYXJ5IENQVXMNCj4gICBLZXJu
ZWwgT2Zmc2V0OiBkaXNhYmxlZA0KPiAgIENQVSBmZWF0dXJlczogMHgwLGMwMDAwMDAwLDQwMDI4
MTQzLDEwMDA3MjFiDQo+ICAgTWVtb3J5IExpbWl0OiBub25lDQo+ICAgLS0tWyBlbmQgS2VybmVs
IHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIGV4Y2VwdGlvbiBpbiBpbnRlcnJ1cHQg
XS0tLQ0KDQoNCkhpIGFsbCwNCg0KVGhpcyBwYXRjaCBpcyBhbHJlYWR5IGFjY2VwdGVkLCBidXQg
SSBub3RpY2UgaXQgbGFjayBmaXggdGFnLCBjYW4gYW55b25lIGhlbHAgYWRkIHRoZSBmb2xsb3dp
bmcgZml4IHRhZz8NCkZpeGVzOiA2ODljYTE2ZTUyMzIgKCJCbHVldG9vdGg6IE5YUDogQWRkIHBy
b3RvY29sIHN1cHBvcnQgZm9yIE5YUCBCbHVldG9vdGggY2hpcHNldHMiKQ0KQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCg0KVGhpcyBwYXRjaCBzaG91bGQgYWxzbyBwdXQgaW50byBzdGFibGUg
dHJlZS4gSSBhZGQgdGhlIHN0YWJsZSB0cmVlIG1haWwgbGlzdCBoZXJlLiANCg0KQmVzdCBSZWdh
cmRzDQpIYWlibyBDaGVuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgYi9kcml2ZXJz
L2JsdWV0b290aC9idG54cHVhcnQuYyBpbmRleA0KPiA3Zjg4YjZmNTJmMjYuLjc3Zjk3NGE1MjUx
YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gKysrIGIv
ZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gQEAgLTMyOCw3ICszMjgsNyBAQCBzdGF0
aWMgdm9pZCBwc19jYW5jZWxfdGltZXIoc3RydWN0IGJ0bnhwdWFydF9kZXYNCj4gKm54cGRldikN
Cj4gIAlzdHJ1Y3QgcHNfZGF0YSAqcHNkYXRhID0gJm54cGRldi0+cHNkYXRhOw0KPiANCj4gIAlm
bHVzaF93b3JrKCZwc2RhdGEtPndvcmspOw0KPiAtCWRlbF90aW1lcl9zeW5jKCZwc2RhdGEtPnBz
X3RpbWVyKTsNCj4gKwl0aW1lcl9zaHV0ZG93bl9zeW5jKCZwc2RhdGEtPnBzX3RpbWVyKTsNCj4g
IH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBwc19jb250cm9sKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB1
OCBwc19zdGF0ZSkNCj4gLS0NCj4gMi4zNC4xDQoNCg==

