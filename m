Return-Path: <stable+bounces-120194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6493A4CFD5
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 01:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035687A2BEB
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 00:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3892AE68;
	Tue,  4 Mar 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sxeLqMMf"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2050.outbound.protection.outlook.com [40.107.103.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B68837;
	Tue,  4 Mar 2025 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047440; cv=fail; b=sJM5UaF2rC+jMnMApPOu9aiqoD9sC6YVPDEhK6tElutsRQ2cV3ijH3X6oj+n7wYSkxbzMH1NxXS9uNFq/sort6CT0TAhiaF3bpzaDDgMbXZpJfnGS3wFLttGgERCSiOjt2QAXXMtIO8Hjh7gZMDUONFHpuBPrnNm02Ah/bNBEBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047440; c=relaxed/simple;
	bh=vkGRRgxpuNLqGb05NXF7QLaV9+PhRkEiu84RvaQYHRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GFoMSNnmLoYcPnGwdQqiqwWKo6L2e4b6upAqnJq49M9uxhx7hoI4bpMliETKhA7541lAhngRPjALzV36MZAsS/DLwKoyXp/eR+k/U2NTNvzgF/MpL49/mUnyw6QPNzjfFzreyv0qJp4UEkC+HLvw4jcXswBsSZUQ3O8dEGdEyVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sxeLqMMf; arc=fail smtp.client-ip=40.107.103.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCKJo+cqqvJQ5jUsrhJCOoUDHmfQhwCxElNQGa2K2sj2ZniJXGYcw0/mmE/uUhNnv8eo+XMX1kuwesjfxI5FWGbiElRppNXXPIeThyheGuxSa223Phhri+HrwW3/vNp1KeX1wFG09Z5FY2q5DSQqx3n7PVMLwijawu9rYQv0ESp4gE35Z5spz76mkPpR/Ty0vg3oHXjVxx8y3lP+wYjv3kGJ8XzXHvUk/Hx11992l7XZNcPb3YdED3N1WUA9+NGgalf91dcIFsGXmkNp/RB2UBKGyMWhvH4wwVIKOKor33EpanDB/mJxoxNro+A/CC5VPk3iRv9lY9/0R5B5UweP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WEnDWKgkB+lTh5nLFPb156f79a8YdfmuXlW8PM1OGA=;
 b=t7hHE0kFeyhf0OQkkzBZy8CJz5rM4AJkv9xJm16bRzcDOw0ld0qvVMbkV02d+oRLz/pnTp/rcHo4xuQZVMD9lTIf0bvM7UziSerNPiVbZEMi3NLcbbsvt3iEqbTs4el6dFzHF4QAqJRMxLR0MrUmAmgEO0AOVwa2vqgPdH5NcWe+xf1KDtt7ACGx8C2Tvaa+ua1rgKgmAkcdusToZ4XD1m7jFva7o8JBtON2VJs1Rf8bnpKxjsCxsFgRtjSUIJypBjXGK2Rh14hVHHwZaJHKAbjivSmIt7hoNdjfHrZN11qiXqlG2QX28owZnJ6ZHkZxWykEzcZkRP69T1GVP+3IiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WEnDWKgkB+lTh5nLFPb156f79a8YdfmuXlW8PM1OGA=;
 b=sxeLqMMfKeQTPVVPcg+uAz8V6S1i9xE6l74yvgpHMySHwawODkJ1DMBvpx83Svv5m08qICHLDZuZB3oGfy6c8vGsJj7Vq6tcFPteUBA4Y3CBFG+3NvKQ6WuETKmXOd29O6BqtE1x98fsxaVZlXc5aGcJbX++lynSEcTHzkE0S+7dMnti1pcXobYtf5VVUhjKivswin32UjMyLJVf6Em3IfSBMCqZkRAFm6MznEYkYvB8TZGeag6qd5+gdFesW/F27Vno0S7L7LipS6iaF7xpQ8yYt+toAPHDbP1qX91YIVzLyIsb8NlzqNVknj4rf8DRyODs7kIU8BBPEy7VN1Ek0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 00:17:15 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 00:17:15 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
Date: Tue,  4 Mar 2025 02:16:27 +0200
Message-ID: <20250304001629.4094176-2-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304001629.4094176-1-andrei.botila@oss.nxp.com>
References: <20250304001629.4094176-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6e5546-6fc7-4199-ba47-08dd5ab1eaca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmVLNXMrRmJBWFl3K29xUGVYSkRhZzM5djgwTEszY2drNi9weVk5ZWFLVStt?=
 =?utf-8?B?SUlUV1E1TUxrNTVmdVh0UEZmRGR4UEp2Zmc3VW1NNk5pV0RTNy9lSEpVOHhD?=
 =?utf-8?B?WXllS28rcm5HQ1NHM0NqQUc5N0Q2WkttbGszNXF5LzlFZzQrV3NGcnI5Szgy?=
 =?utf-8?B?enpFREVRek04aUw5bDdTVm53ajY0VzhHQnZoeEpWdkZ0N0EzMStJK1phaDZ4?=
 =?utf-8?B?ZWtmQmJkZTJiT2F6YW9nQTh1L1JaZzBBM3UyMHp2d085OEZqVStTYmRHMTBY?=
 =?utf-8?B?S3l2MHNKN0FrNVlaMGZTaHhYYUJkYjNUTlErUG1OTVFVbm1vUXJuOURMK0sx?=
 =?utf-8?B?L0psdjlTRlh1MWdzaUx4eWhDVGpocUUvaUE4S1dFeit4aW9JTlFkUFdpa1A3?=
 =?utf-8?B?WlI5QXFFbnpLMG9LcGpxaTk4L2NZeHIyWjBVbWI1TG1zWkR2c1BSUHY2bSth?=
 =?utf-8?B?WWdCdk16YmtLUlZzRzZjZnJXOGczOEI5Q1djeXYvZ3RpZW1vNHpialVCQ3lp?=
 =?utf-8?B?L1ZxVHJGR0doU28wT3dXbitTNmNxZEdlM2o1Q0plclNjaURCWGJqNk5rRVh0?=
 =?utf-8?B?aW9BZkRGNzlZREZMOHhoUElQd2o1czRkeFg3KzByYVBMSlJnNm5DVjJXWUNp?=
 =?utf-8?B?ZHlQUGhVYjU2TXQrV2w5R2FoTm03cEFTY1Z2aXFBZkJwVVJENHhLZm4ybldr?=
 =?utf-8?B?Z2RhN2NNK1o2bUZVRlM2RGVvUEFTZFd6cjAxSkVIK3E5V1lyZytFbEg1VzMr?=
 =?utf-8?B?cHRXVjF2cDhobVlsbTV5bnNvamlpeE9LRkJKTEE1WlVXb200ZGExZkR3TEtS?=
 =?utf-8?B?b3lhQW8yUXpGZXBleVM4MkZBejlpOTFHT2lHRCtvWVdnNFlwdHQ4b09qQlNs?=
 =?utf-8?B?TEhhaEZ1ZjhNNm1rTllqaEhqZmVnUFJyellKV0NLTXZSMFRYaXd2OThMTW41?=
 =?utf-8?B?bnQzTWFNSTRsSFBmM0oycWxTMy8xcUhaZnFhVkNVRVdaY01TWklxdTRMUnBq?=
 =?utf-8?B?RzFYVTVmMnRPSGZBQ3R0alNqZHNNN1lxd2JqVmo3MlQyQkgrNVk5M3ZiVERR?=
 =?utf-8?B?Y1hCWTh1a3RqZC9tWUFQeHpHYzJhbi9rMlZuanpRMVFNMUNJQU9XcUxGTXVB?=
 =?utf-8?B?WmdSeUs0Z0dSQjJxY2hMeHNVZTBGQlJTMVNZOXdKd1VHY2JWcnJnNHFLUmFH?=
 =?utf-8?B?ZXN6NTJWSzNlaFZoMm5iTm04T0Q2N3lrUEFsZHQybVpvY1FVYU9pb1YrODFu?=
 =?utf-8?B?YWtFak9nOUVxdHg3bmluZElaOVI3Rzk4MDY3ei9DbjIrb1plQzlRNG0yNUcy?=
 =?utf-8?B?VnJUT3dRY2JocFdGejNHTUQydkRRSzhuVk5veW1tRU5BV283QlhvOXlneEhs?=
 =?utf-8?B?anZrRlBmeUZubmIrQytYbmpmUWkvY3RDTXNoREs3cTZDVkIwdTcyWG8zVVdL?=
 =?utf-8?B?eGhxdXZScEwwK0Q5bnZIQmF2M0VBYllsVGRzRkhMb1NUVVNsWmJWaWh3dWxF?=
 =?utf-8?B?ei8xeDY0NkZ0TDI0SC9EQStYSnIwU2pJNkk4UlIwUllIbEl6OXpKbm5KNUlY?=
 =?utf-8?B?KzRCMHBZMGNQMmVsMUJ1SytCb3FCUGFVVWpSMVFreStteFRobWRpMWJQY1hY?=
 =?utf-8?B?VFNZL3dNcjE0d2tMZjhwbm9mK3hqS0lqOHFKekY2LzFza2VuWDIrZ3hOR2lP?=
 =?utf-8?B?SlJFNnJTYmVZWVZtanJXN2tQU1dCYXU0dEZyZnVpZDhrMXFiVDVFMnVrdmti?=
 =?utf-8?B?RXdLMGpYZ2ZKSFhZU09nMjd2SHJEQkNZT3pucnJYM0RpY2x6TTBnZk0xdlBZ?=
 =?utf-8?B?aGhrRlJzdGhMaGpUQVBkd0VwYzI2NDl0TDhNVGJhSUxBR2UwTHplS1ZHemhM?=
 =?utf-8?Q?jQLPZW/UpL1Zd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnNtOFNZTXJMcGFSU0xCbWRKOTNINlhpNFBiN3VpaGlMeXQxdTBFamJjc3ZW?=
 =?utf-8?B?RDVlSDY1WjErYTlFeXlUdi9yVGVNR0Yxdnp5YU9UdW1vRTc5cUZnNnJGUjhO?=
 =?utf-8?B?d0x2SHBPTTJzSjNQUkFoOERmUnlEMnIydUVJNzJVQUZlNDlqMmpwbWRLazg5?=
 =?utf-8?B?NkwxNFJwcTBkbTk2YnNPdG5ZbzhUeFdYeTNDY3lUU0RPYTFiQjZZaml2R2VZ?=
 =?utf-8?B?WVJhdVRWR2RERnhPQmNJR09mSHRFcFJZbFVJaW1mYnNTbVMvQWRLNHVGNHVx?=
 =?utf-8?B?eGhFcUdkQ1JTNDRPdktORjdPcWY5dktuam5VSUloREZVSE1PbjZ5citPRkRL?=
 =?utf-8?B?TEhQZURMVjZTMUJQYW1KWUczaTlKSE5YK1V0UEZWeTFQVmVERGRVM01NUnRa?=
 =?utf-8?B?SEptd3lnaVZmWGNxWkhZZXArdHB1WHZ5RFdBdE1sa3I2S1dYNnE5UzN4Kzkr?=
 =?utf-8?B?aGxySHk3QklTNGZZQ2FuVVBETmZucTg1S0RmTHVMM2IrRUpRZWFNMXluaVU3?=
 =?utf-8?B?V1l6ayt1OWFIcElaZlV6NWZldCsxYmtQbWZtaFU2Z1ZKZ2t0b2VQS3BLQU0w?=
 =?utf-8?B?YlUwUmNlRFN4UzJFNnRONHJySSswTk4zMzZBR3lrL3pMdHZ0Q25NV1dqMWc0?=
 =?utf-8?B?VmRrVWlzTWFCL1pkYll2K3d2ZTM0Rm5ueFV4TlVrc0J3N1hiMVBDMHdmYmxk?=
 =?utf-8?B?cWZnMkFHaTV2dVdsQ283Y2pUR05ZTkQ5KzUxZUVUR0FRVmx4WnFHRWJjOUxE?=
 =?utf-8?B?eThFMFFWRVNHR2Jtak1TeUVxOUlyYzVobzJTVWV2OVUzMWN1UTNBalpkb2xL?=
 =?utf-8?B?ZVFvMllIS0htUGhjeVVwbHJQaGtxWWtldXo4UzZ4NGIzMnNLbkdyenY3YWRN?=
 =?utf-8?B?MHZKTzh5Znc5bE1NR1FpR2NsK1JEdGRDNjFma3cyNGx6Sy9CakJIeXJrSjhq?=
 =?utf-8?B?dVNWMjVYaGRiQkwwV2VyVTREeUVpQXRkZHoxeXVpZUN1NSt4T2Z5aERYSG40?=
 =?utf-8?B?aFYvS0d2SkR1MTlNWmdaMGpWY1RCRkZpQm9HMkt2dndheG9aTW5ndDVKRTRq?=
 =?utf-8?B?cXR2TlpzTHNjNURYOHM2OUR0NlFIN3VVbVd4dmI3a3VOdEUvZktvc05ubUQx?=
 =?utf-8?B?WnlHRTZVb3Zmemhhcmc2MUVzRVZrVzRzTTNkd1NrNHYxNHAzNjN1RVZneU5O?=
 =?utf-8?B?aGJ0OUNJNS9XNlI2VXF3UnhZaC80TnM4Q2EzbzRubU5PVzA5TkJFcExXNGlx?=
 =?utf-8?B?VWE2N1dGT0p4TUpBTlVteFBqclU0YTRaSmtkUGNuZXp0dEwyM3hhSGNFL0Jw?=
 =?utf-8?B?eWZ0ZFp3cDdCYkdYN3V5SmFuYy9pVDNCRnA0VG1kQU85bDk4K3ozREd3dktj?=
 =?utf-8?B?NDhJdWttTVJESW9PUmNDOW1JYVM2YitIN3FFbzh3UHpVa09vMEVNd2lPSUUw?=
 =?utf-8?B?Z2dZN1JUaGNEakRBMGlHdGxVNUVzWlRhc3BMM1VDa1o0d2RZSG9Jc1JOZzRY?=
 =?utf-8?B?KzdFM2JnR0ZkWWZQekhLeGUzZk5qbUNPMmZSRDlrTmtWbkl2aHhVT3NWRzlK?=
 =?utf-8?B?NFcxVVYzbG5COXpNUWpzdXlnYk9ZRUY0TU1uWDE3citXSlJDYW1HcDcvWXdW?=
 =?utf-8?B?bDQ4bU4xWFlvSVJsK0pBV1FOMlJFZHBwajl1NWk2RHcxaEcwTmVUWFQ0bXR6?=
 =?utf-8?B?cFp4ekwyWExCbjNsZDdVc01jMWtnMVhIaGF1MGhGWTBJOTBnUGZDTmQ5T2N6?=
 =?utf-8?B?cHJiZnJCVzl6cDVtdUczNHNUSTdKTDcwRWpySmtIMW5MUnJqVm95TldXU29v?=
 =?utf-8?B?cEUzblkzcm5CcTUzZWRnLzREYzdDOTg4RjRmVnVwdVZDOXdLZWloMlEyVjJq?=
 =?utf-8?B?ckN6aDBVOHdpZUR6SStiNnBTaXRCOHQxVU1OTkh5dHBSaFl3Wld1Wmp0c2Nj?=
 =?utf-8?B?UkcrV3liYSt5WGtHOVB4dk85bDBrZkNEcStNRlpiM1dsSS9Hc3M0TFVteEg2?=
 =?utf-8?B?OWt5M1RseURvUmdBdTBjMzJGOGVheXdKZ2ZFUmxKNkpWVmpWSkFuWi9sbU9H?=
 =?utf-8?B?TERLYjJIemt4SXhTa1g0SUFjMm9VRFY2STN1aUhSMzJYN1R3RFdWVENuZ2hK?=
 =?utf-8?Q?eM7ZPYU7gGf19MUYUYa3b0z4u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6e5546-6fc7-4199-ba47-08dd5ab1eaca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 00:17:15.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do8cuTwCzpFCC/3BwauwzAa1C5mN35DAQ7+EIrgy0rue1WT/gNGzN9xDRS4dWTFJ02cNd2M5R9K1SyuTm2jlUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763

The most recent sillicon versions of TJA1120 and TJA1121 can achieve
full silicon performance by putting the PHY in managed mode.

It is necessary to apply these PHY writes before link gets established.
Application of this fix is required after restart of device and wakeup
from sleep.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 34231b5b9175..e083b1a714fd 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -22,6 +22,11 @@
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
+#define VEND1_DEVICE_ID3		0x0004
+#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
+#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
+#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
+
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
@@ -1593,6 +1598,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+static void nxp_c45_tja1120_errata(struct phy_device *phydev)
+{
+	int silicon_version, sample_type;
+	bool macsec_ability;
+	int phy_abilities;
+	int ret = 0;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
+	if (ret < 0)
+		return;
+
+	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
+	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
+		return;
+
+	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
+
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	if ((!macsec_ability && silicon_version == 2) ||
+	    (macsec_ability && silicon_version == 1)) {
+		/* TJA1120/TJA1121 PHY configuration errata workaround.
+		 * Apply PHY writes sequence before link up.
+		 */
+		if (!macsec_ability) {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
+		} else {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
+		}
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
+
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+	}
+}
+
 static int nxp_c45_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1609,6 +1658,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 1);
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 2);
 
+	if (phydev->drv->phy_id == PHY_ID_TJA_1120)
+		nxp_c45_tja1120_errata(phydev);
+
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
 			 PHY_CONFIG_AUTO);
 
-- 
2.48.1


