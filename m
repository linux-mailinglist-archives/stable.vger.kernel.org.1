Return-Path: <stable+bounces-194435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F7FC4B7EA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 06:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 754904E3C7D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176BB1EB193;
	Tue, 11 Nov 2025 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QXncKp42"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022105.outbound.protection.outlook.com [40.107.209.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30034D39C;
	Tue, 11 Nov 2025 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762837727; cv=fail; b=gbdfz3rnehwMuCh4QbXXrIJnqNJ2Sq/11hNPdsU/zhQoNR5uyjqJyVnUi+2rdRBQjren1rczrHgo/3A2fVvwm+OhnEa0VQDz4OXSZtlwWroJCbUkrgDOzEidHtT0Tu5RXrBY7037IGg7qxJph2xXgqQECc4Bcqsm4HPiuARzXCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762837727; c=relaxed/simple;
	bh=a3F9FJzOqAVtRSbMiEQNdNZWtDFO+yhK2QxjqmZGxic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8svPsQMKqEgqM/Gf9SALCIGEExDHv8LwiW1ri0oIDHZWWYry2lJQ23bzO8Y3O1CrCPRvtRwqgunKC1zxJqjNiFSlY2OMSK5CDRp+Y5qBn3PFCAkkWQLKB3uBIECjZGLPQxr2d1iUIXFi/8UkfJxedWmSmo81XHOsDm4I9PEjEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QXncKp42; arc=fail smtp.client-ip=40.107.209.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id+R354KPCzgSP5ZuN0VaJm59Os+yL9eMSoe1cp5YeMqc/S02xQJr9NVbwksDppOrQ/bp7LNd1ImQS5nGK6NVLrRoH9/5O/ewJBs8PAbzLHjC4/pEpxfDdIaY7Ghbp30nJVQrvD7uu0LYYcxxnVd3t+WWouTwrjhUFk+vQ3WM3fYFiSVXQTHcHhjPXuPTgnwrq9j+t3DCPhN8ifV4Be7EF6OXVhMlEz8NptEFOBMOYiLpsbDvsWBLV62iJvtPdvozGYhiC2V0zWl5APkUqk1tnrjw89w9BG0eYK2EiUpEuM6NX+RNoyuaMhgSF9CsvojbsI2yvbWpYu250Fj3c9Fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs/LdFQlLzX5MPBvElIvhH50pQmmbw6lOckrbjnQCYo=;
 b=HICWH90eOwGGycV/t+pV+bt/YBQsvJsFyJwAYTD49xn9q0uxE3pK7go1RbjO4GH/juvxfeqHdaFZ1yP5SmohGrEtxnZUEsnM3zWwmwltzMGt74IDy+CnBHH04BQByParH3kwQFeK9d3M1lA2rXgYNw+/ql/61ghyr0mNb6tf7BzpCKX7VY2Ljfl6MZlDlJDFv+0ayuwendlXUBc+zubnL3N4Yn4fmla9Sm2YY5wENuRiVVjcsoK+OFz4SazqcTGWMmeYwJowMG2ehmEGsRe5mZjDCIGRBcR6nG5OGsnBma+SxAUkVEp0g56mludyKX7zFQilG7b1kUXFJCW/4luzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs/LdFQlLzX5MPBvElIvhH50pQmmbw6lOckrbjnQCYo=;
 b=QXncKp42PVO7j0ocyCvFGqFIu9aITyoiHfrC8Jb6gwTpn29PpQUFcbq5O/9jWsT5ncrhccbgmpkZ3HesSfm/wqhWA+2Fx8k9tz1BL/ew51ydV+E7y3xEMUMx5ti1i2yBLlqcWG/tdsOuyKtG5wSWA1YJPYfGRFEd+I0WZ5ZiGpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB9034.prod.exchangelabs.com (2603:10b6:303:271::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 05:08:43 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:08:42 +0000
Message-ID: <ca628d43-502a-42f1-be57-bcb37103ddf8@os.amperecomputing.com>
Date: Mon, 10 Nov 2025 21:08:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Dev Jain <dev.jain@arm.com>, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com, rppt@kernel.org,
 shijie@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
 <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
 <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
 <aQn4EwKar66UZ7rz@willie-the-truck>
 <586b8d19-a5d2-4248-869b-98f39b792acb@arm.com>
 <17eed751-e1c5-4ea5-af1d-e96da16d5e26@arm.com>
 <c1701ce9-c8b7-4ac8-8dd4-930af3dad7d2@os.amperecomputing.com>
 <938fc839-b27a-484f-a49c-6dc05b3e9983@arm.com>
 <94c91f8f-cd8f-4f51-961f-eb2904420ee4@os.amperecomputing.com>
 <47f0fe70-5359-4b98-8a23-c09ab20bd6d9@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <47f0fe70-5359-4b98-8a23-c09ab20bd6d9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe7a839-2863-45c4-b9b2-08de20e061b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm1hOUJiZE5RM0xMNHJhb3JoaDlkSzJPVUhodDBadEFiUDNYTXBmUW9wUE5F?=
 =?utf-8?B?cms4N0pvTkY1V2diUlVRRkNiVCtCWGxYREV5ZGJacU5EL290T0VGbnhJMWZl?=
 =?utf-8?B?MEh4MnFlVTdBOW5qZHZUejEwbnVoYVVVUlhLTzBweGJBTm1zZUJjMlk2cHlX?=
 =?utf-8?B?M0hUSHgva3RYQy9QUTNQNGN1bnRMdnRRNldwWU1MdUNILzliVFFIMzFmTGw1?=
 =?utf-8?B?VUVZMUR5OFhnMGRLU0hnRExEYURweElvSVd1OWpxL210SldJaWliOXlFOGlo?=
 =?utf-8?B?bDh3ZDdxc0VFZnVoaFpuYXNrKzJXWHpDMUVUVUN1ZHJJd2kvQWxPdENTTFAz?=
 =?utf-8?B?b2JsTlFGdGNtMVYrdkQ0cFFqQW9BOUJWemloUlZuRHhaREx2T0NpN1VjTVI5?=
 =?utf-8?B?b29iK0dDejRzNDdvekF0LzJYNGtsVmc2ekQzOHZibitHYWtxMG5jempmb3JX?=
 =?utf-8?B?dXZ2amtKUzdYQzQrYm45SG5RclRSQWxaQWVYNGh1MlFVZDV1Z28yM01XaFNQ?=
 =?utf-8?B?QTBPU0JNTHNZWkVDdHN6SUw4bFE2eU9uTktHUkZjRGQyYjFtZkhwK3RIdlNt?=
 =?utf-8?B?SnRzZnBtWWp0emtvaWRpbFk5aGFhbXc1WTFSM2M5MGxxZ0xkU0lsUWZES1Yw?=
 =?utf-8?B?MlB0M2VuQ3E1Z2phNEVoMmxHQy9FMFlJbmlyeXVhcjh5VmE0WGhKR0ZSNm8w?=
 =?utf-8?B?Q0cvZmo1cEVmTXZ1aDlUK3JsOUZtdUNrbGlObktQZUVoMlpqdnNnV2tWYUd4?=
 =?utf-8?B?TSs1SHFEdjh1OWV5eTJaSEZSSFNVVDFyMkZPdkNzSmdpdU1OS3ltSUZjSHpF?=
 =?utf-8?B?MU4yRlo5Mmp1ckg5Rmx0TGVhUFl1MUZrNGllcEZQNGhYOUNSWXQxZHRqU3Er?=
 =?utf-8?B?aEhGeVpsZnFuSHkyNDlNeDB5VDJQajVhQ0ttS3FIWGg2dTk5T1hHQ1I2S3hN?=
 =?utf-8?B?VVpPdWh0dkVFb1RLRC9xN3duUmVVWHVGeGd2cmNXazgxdVNKS0ZzWWliaVRH?=
 =?utf-8?B?bTVyS2QwQ3ZvTDBFaW1GMGt2bGRTRzl0ZmdhR08xaXJZVitkV2czcWo0TlV4?=
 =?utf-8?B?R3RrVGRhSEplK2lNb2gzeEl6aXhxRWRDM0grWmZmblRFeHRITy95N2JyK1lu?=
 =?utf-8?B?cXNaMWZXd1R0M1RwWFVDWTcvTWdlVStqMXE3bkpQRE9RUmdEZDhNR3NJeVZP?=
 =?utf-8?B?L25hOWhCYmtCWWsvK2dJU1JXZy8yNld4cVNRTHErOHN5eXNCWDNYQzlhVEVD?=
 =?utf-8?B?bWtsVmdobklFOUJGR1BDRDlQdHFONTFwQ3lkMU9WMUhlNUtVNlFzUDdUdmtp?=
 =?utf-8?B?QXhORkdMVTB3dUJ1bFROWW9ybkl5bm9RL3hsSkEyTzNHWlJUMFViZU1lYXg0?=
 =?utf-8?B?MDRvbDhDZktJdkJLVWNORGVjRnlJZEhkM1QyNVdqamp6YW4rdkEyWnl1aTZ3?=
 =?utf-8?B?STNzUWgwZHk3YjhOY1dBUUdoa1d1bWtXQ1hub3BDZXBTWUJiSVlIdjRadHY4?=
 =?utf-8?B?YWlrc29nK1lNQlFhaXhqUkdHRGZHU1M4ZENFcUpkZkFQd3RVVDRVSFh1elFW?=
 =?utf-8?B?Mkluc1FrVnp5Wk9za1JqSjZueERsYlUxY3IyeTRQbjNZZ0pzbW1ZbnZmUEhG?=
 =?utf-8?B?Zm8zVFk0Rlg1R0p0L1QrbjhJMUpwc0FTQUtWQXJ0Uk8vN0g5N1NjUWMzOWkw?=
 =?utf-8?B?aHl3eW9BbmxhUHRGbHZPNXhKME9sM05DcCs5b1FHMXFYd2NFRDFRUE5zekNO?=
 =?utf-8?B?NTlGeWRIOEtTNWdzNmR3Y01OR3BnRG5RUzM2dTdHWFhveGJNWkZyUkpwUXNS?=
 =?utf-8?B?K2QyTEVra2gyTE9MbEpDYXdVNDFPdGdTdzFFWHF0VXRGUUIvcVJ3ZkRnMTM3?=
 =?utf-8?B?SzJOUEd2eS8yWWlpQVVrZzVacUgwWWhOM3JBWllQdHZ5T0prLzk5ck5Nd3lO?=
 =?utf-8?Q?efe5MAP7waAV3meBKkoKHuiS50nsWR6o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTVRWXUvWDNqbHJId2lZVUJUdFUreVhaQWtDRVBkRUtlWWpKTFpjNURtZmJS?=
 =?utf-8?B?R1prd2NRUmV2dTgvaS9FMmRVVHZzbkRlVVhDV01KSG93S1hkQ1dXUUNTWTlD?=
 =?utf-8?B?TkNpQzhqaHFrb0tIcy96U3d1c3A0VDRDYURSWFlhM25qbnNvU2R6M1ZEb0JS?=
 =?utf-8?B?R2w2UzRmeTFiK256ZVB1bDE0eVVzR1dTOTJReVpzd3BCbjFiSVdJOVZPL09C?=
 =?utf-8?B?bnRPcStTeEtaRWNGNWhCbG5adU5WdVB6NWtLU3hIZStSRDlGUXg0T0xtcTRQ?=
 =?utf-8?B?WGl4ek9HcFlIbFpzUG1xbno3MFhScUVzT0lGdTg4QnRhSm43eFpsd1ZZTEZF?=
 =?utf-8?B?aExkSno5cXhPUWdxYld6NDY4TWVjWEVPOVRHU0M2cERGcUQ5UzZFN1lCbjVT?=
 =?utf-8?B?RmNTWEZxN3kvMkFxRlBTejk1THlTUndtL05mUEdtSlVaTm95VDZKQm9yT2Fn?=
 =?utf-8?B?KzFDS080aTgrZjBRd2tKZ083ZS9uMExFVEppMTF2ZjZyTmNEeFZzWndMd0hJ?=
 =?utf-8?B?VzlSNEJYYVZsOHROL21DK2hmc2NxUnV6bnZCTnBicXNrcHhRN0hmV3o2L2Fn?=
 =?utf-8?B?dUZlWXpyM1pISk1ZSkdtZGhGc3oySTZsOVpCa0VHQzU4Z2hDMmN4QUxwNnBQ?=
 =?utf-8?B?VmY1VFNIUHlNakQ4cmpNeXpockdMVUxiQmU1N0pXZk9HSXowc3dsQWo4Misr?=
 =?utf-8?B?d3lBVjNxSDVDc1VRVWVmb2h2ODdvMm9HZHZEQTV6TmYwYVJHS3dva0ZqSmtJ?=
 =?utf-8?B?d2o1UUNPMGhLZzBsckhIYmhBSFVXN1hLcWRBZHZQMVBnL3VEOCtYVVFnNGE4?=
 =?utf-8?B?NTFaUGdKNnUrRFlCR2lpeUxhRmJ4TWxRYjYxZ2JpVGZNdTJNUDBzWTBnTDlT?=
 =?utf-8?B?S3IwSkRxVzJ3VkE5M2Vod3JjUEhnWXNUalFWSEkzTkZXTGdqU01kNElFVVJK?=
 =?utf-8?B?MGswVTNDaEdkZ2xrT3o0cUFvRmRsUllyQW9zdjkvSDRoUGJ3VmZ4K3B3N0dV?=
 =?utf-8?B?NVdKWjAxYWU3YURyMmt0d2pqYS9JZFk5RG5rZ25WYks1WmtJejRyZUdzQlpM?=
 =?utf-8?B?N2JmUU41clFpUnJObzkvMXdHTDA5eGdNRlAvbTlMNGVpb1A1RzVuRGcrL3Ar?=
 =?utf-8?B?ZVNMUmdNMGpoOFlzVHpZQ0NuRkQzdkJUaWlIVjF3TUh0dkRDKzNBT2xJVU83?=
 =?utf-8?B?TWkyb2kvZm8yeU5tMEpmOXZPZFUyaHdTMHE4eFdQVDZNV3cybmZobnVGblEw?=
 =?utf-8?B?MnhSZTJzZjUyQk9ISHJ6SjQ3bW0xTElZWDdYMGp5YVJVdVUvbTZ3Tk5YbGZL?=
 =?utf-8?B?bnNHeGJ0b2p2eHhDVjRQcW84VzRMWEtsYU0yZVlGdFRLSlJ4anQzamx1L1Ry?=
 =?utf-8?B?TUdtaVBta0VDQXJyWGVHTDJCSWtDWjJVaThZczF4WUtaMDBMVmlqd21iUEtj?=
 =?utf-8?B?YzhGRlpyTzlIbkRCaVVwUDBEUW1zYTdwVWIweXl4d3Bhc3c0YUtZeUhZNm9H?=
 =?utf-8?B?cTVncWpta3ZiQUJCTTdwa3RUbFRvQWh5V0dVS2xrQlRFOE1obEVZOVRNWW5o?=
 =?utf-8?B?K0swZlRJMXdqN2pkbDZTZi9IRXlBMFlUdkVzdzEyV2FUM3l6SVI2S2VYVFlS?=
 =?utf-8?B?allIMmZVSGppb1ZlaURiUFJoUGNzVy9meUxEaVFCdEZuUk5JSzUyMHVCVUpk?=
 =?utf-8?B?UjEvMDdPbEx4OHNKUlRjRDhmNnNhR2phVmVBd1lUbzNKSVFFMXJ3ak1DeEZp?=
 =?utf-8?B?RldpOHNkL1Ntdld0dk50SjVMVTdJNlF4RnYvTHQwOVE2SDh3aWl2cUVjMXp5?=
 =?utf-8?B?OEVKdHplUVBkZG9Kd1R6RjBhM1R4Y3N6SGM5YVd2UFNxeERIb0xVRU5kbWtw?=
 =?utf-8?B?VGtHM2xQRTdnSHh4Tmo1TUgvM0tsS3hYNWpHV3JVM1JQUmFyWGFMR1o3aWp6?=
 =?utf-8?B?SmVZakdFaUYwdHdVSmtBSFpSUEdmeEZmV0NieEFwc2FxZVhiTW9XWFpmdndp?=
 =?utf-8?B?NVhRTHoyT1MxVm1PTHlHMGxIZmlvcGFXbnVxZ3dhdlNURzZyVTI4ajZBemI0?=
 =?utf-8?B?TkkwekxsdlFaSWVPMlUyeS91cVFYZm12eHhWN1pNRG5uUTB3RW1QdEJBVFBM?=
 =?utf-8?B?aVdJM3I4MXE1NisrcEZTZ0t1dHFYWnNiVGNvc1VEYlpKWmlyYnJMN1JqdkZV?=
 =?utf-8?Q?uM8QZf/O/0Xk0FrxUl8acx0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe7a839-2863-45c4-b9b2-08de20e061b6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:08:42.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaB2mWP0OKy2AAYNRCzx12naWj3eI64g9Kizha4CaBfuRS+KG8NwqDq8mHcCYA4L8fR7ve4UdyKduHLEV9kEwuIOPJUdR3JgeEJ6DVb1wlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB9034



On 11/10/25 8:55 PM, Dev Jain wrote:
>
> On 11/11/25 10:14 am, Yang Shi wrote:
>>
>>
>> On 11/10/25 8:37 PM, Dev Jain wrote:
>>>
>>> On 11/11/25 9:47 am, Yang Shi wrote:
>>>>
>>>>
>>>> On 11/10/25 7:39 PM, Dev Jain wrote:
>>>>>
>>>>> On 05/11/25 9:27 am, Dev Jain wrote:
>>>>>>
>>>>>> On 04/11/25 6:26 pm, Will Deacon wrote:
>>>>>>> On Tue, Nov 04, 2025 at 09:06:12AM +0530, Dev Jain wrote:
>>>>>>>> On 04/11/25 12:15 am, Yang Shi wrote:
>>>>>>>>> On 11/3/25 7:16 AM, Will Deacon wrote:
>>>>>>>>>> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>>>>>>>>>>> Post a166563e7ec3 ("arm64: mm: support large block mapping when
>>>>>>>>>>> rodata=full"),
>>>>>>>>>>> __change_memory_common has a real chance of failing due to 
>>>>>>>>>>> split
>>>>>>>>>>> failure.
>>>>>>>>>>> Before that commit, this line was introduced in c55191e96caa,
>>>>>>>>>>> still having
>>>>>>>>>>> a chance of failing if it needs to allocate pagetable memory in
>>>>>>>>>>> apply_to_page_range, although that has never been observed 
>>>>>>>>>>> to be true.
>>>>>>>>>>> In general, we should always propagate the return value to 
>>>>>>>>>>> the caller.
>>>>>>>>>>>
>>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM
>>>>>>>>>>> areas to its linear alias as well")
>>>>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>>>>> ---
>>>>>>>>>>> Based on Linux 6.18-rc4.
>>>>>>>>>>>
>>>>>>>>>>>    arch/arm64/mm/pageattr.c | 5 ++++-
>>>>>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/arm64/mm/pageattr.c 
>>>>>>>>>>> b/arch/arm64/mm/pageattr.c
>>>>>>>>>>> index 5135f2d66958..b4ea86cd3a71 100644
>>>>>>>>>>> --- a/arch/arm64/mm/pageattr.c
>>>>>>>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>>>>>>>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned
>>>>>>>>>>> long addr, int numpages,
>>>>>>>>>>>        unsigned long size = PAGE_SIZE * numpages;
>>>>>>>>>>>        unsigned long end = start + size;
>>>>>>>>>>>        struct vm_struct *area;
>>>>>>>>>>> +    int ret;
>>>>>>>>>>>        int i;
>>>>>>>>>>>          if (!PAGE_ALIGNED(addr)) {
>>>>>>>>>>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned
>>>>>>>>>>> long addr, int numpages,
>>>>>>>>>>>        if (rodata_full && (pgprot_val(set_mask) == 
>>>>>>>>>>> PTE_RDONLY ||
>>>>>>>>>>>                    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>>>>>>>>>            for (i = 0; i < area->nr_pages; i++) {
>>>>>>>>>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>>> +            ret =
>>>>>>>>>>> __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>>>                               PAGE_SIZE, set_mask, clear_mask);
>>>>>>>>>>> +            if (ret)
>>>>>>>>>>> +                return ret;
>>>>>>>>>> Hmm, this means we can return failure half-way through the 
>>>>>>>>>> operation. Is
>>>>>>>>>> that something callers are expecting to handle? If so, how 
>>>>>>>>>> can they tell
>>>>>>>>>> how far we got?
>>>>>>>>> IIUC the callers don't have to know whether it is half-way or not
>>>>>>>>> because the callers will change the permission back (e.g. to 
>>>>>>>>> RW) for the
>>>>>>>>> whole range when freeing memory.
>>>>>>>> Yes, it is the caller's responsibility to set 
>>>>>>>> VM_FLUSH_RESET_PERMS flag.
>>>>>>>> Upon vfree(), it will change the direct map permissions back to 
>>>>>>>> RW.
>>>>>>> Ok, but vfree() ends up using update_range_prot() to do that and 
>>>>>>> if we
>>>>>>> need to worry about that failing (as per your commit message), then
>>>>>>> we're in trouble because the calls to set_area_direct_map() are 
>>>>>>> unchecked.
>>>>>>>
>>>>>>> In other words, this patch is either not necessary or it is 
>>>>>>> incomplete.
>>>>>>
>>>>>> Here is the relevant email, in the discussion between Ryan and Yang:
>>>>>>
>>>>>> https://lore.kernel.org/all/fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com/ 
>>>>>>
>>>>>>
>>>>>> We had concluded that all callers of set_memory_ro() or 
>>>>>> set_memory_rox() (which require the
>>>>>> linear map perm change back to default, upon vfree() ) will call 
>>>>>> it for the entire region (vm_struct).
>>>>>> So, when we do the set_direct_map_invalid_noflush, it is 
>>>>>> guaranteed that the region has already
>>>>>> been split. So this call cannot fail.
>>>>>>
>>>>>> https://lore.kernel.org/all/f8898c87-8f49-4ef2-86ae-b60bcf67658c@os.amperecomputing.com/ 
>>>>>>
>>>>>>
>>>>>> This email notes that there is some code doing set_memory_rw() 
>>>>>> and unnecessarily setting the VM_FLUSH_RESET_PERMS
>>>>>> flag, but in that case we don't care about the 
>>>>>> set_direct_map_invalid_noflush call failing because the protections
>>>>>> are already RW.
>>>>>>
>>>>>> Although we had also observed that all of this is fragile and 
>>>>>> depends on the caller doing the
>>>>>> correct thing. The real solution should be somehow getting rid of 
>>>>>> the BBM style invalidation.
>>>>>> Ryan had proposed some methods in that email thread.
>>>>>>
>>>>>> One solution which I had thought of, is that, observe that we are 
>>>>>> doing an overkill by
>>>>>> setting the linear map to invalid and then default, for the 
>>>>>> *entire* region. What we
>>>>>> can do is iterate over the linear map alias of the vm_struct 
>>>>>> *area and only change permission
>>>>>> back to RW for the pages which are *not* RW. And, those relevant 
>>>>>> mappings are guaranteed to
>>>>>> be split because they were changed from RW to not RW.
>>>>>
>>>>> @Yang and Ryan,
>>>>>
>>>>> I saw Yang's patch here:
>>>>> https://lore.kernel.org/all/20251023204428.477531-1-yang@os.amperecomputing.com/ 
>>>>>
>>>>> and realized that currently we are splitting away the linear map 
>>>>> alias of the *entire* region.
>>>>>
>>>>> Shouldn't this then imply that set_direct_map_invalid_noflush will 
>>>>> never fail, since even
>>>>>
>>>>> a set_memory_rox() call on a single page will split the linear map 
>>>>> for the entire region,
>>>>>
>>>>> and thus there is no fragility here which we were discussing 
>>>>> about? I may be forgetting
>>>>>
>>>>> something, this linear map stuff is confusing enough already.
>>>>
>>>> It still may fail due to page table allocation failure when doing 
>>>> split. But it is still fine. We may run into 3 cases:
>>>>
>>>> 1. set_memory_rox succeed to split the whole range, then 
>>>> set_direct_map_invalid_noflush() will succeed too
>>>> 2. set_memory_rox fails to split, for example, just change partial 
>>>> range permission due to page table allocation failure, then 
>>>> set_direct_map_invalid_noflush() may
>>>>    a. successfully change the permission back to default till where 
>>>> set_memory_rox fails at since that range has been successfully 
>>>> split. It is ok since the remaining range is actually not changed 
>>>> to ro by set_memory_rox at all
>>>>    b. successfully change the permission back to default for the 
>>>> whole range (for example, memory pressure is mitigated when 
>>>> set_direct_map_invalid_noflush() is called). It is definitely fine 
>>>> as well
>>>
>>> Correct, what I mean to imply here is that, your patch will break 
>>> this? If set_memory_* is applied on x till y, your patch changes the 
>>> linear map alias
>>>
>>> only from x till y - set_direct_map_invalid_noflush instead operates 
>>> on 0 till size - 1, where 0 <=x <=y <= size - 1. So, it may 
>>> encounter a -ENOMEM
>>>
>>> on [0, x) range while invalidating, and that is *not* okay because 
>>> we must reset back [0, x) to default?
>>
>> I see your point now. But I think the callers need to guarantee they 
>> call set_memory_rox and set_direct_map_invalid_noflush on the same 
>> range, right? Currently kernel just calls them on the whole area.
>
> Nope. The fact that the kernel changes protections, and undoes the 
> changed protections, on the *entire* alias of the vm_struct region, 
> protects us from the fragility we were talking about earlier.

This is what I meant "kernel just calls them on the whole area".

>
> Suppose you have a range from 0 till size - 1, and you call 
> set_memory_* on a random point (page) p. The argument we discussed 
> above is independent of p, which lets us drop our
>
> previous erroneous conclusion that all of this works because no caller 
> does a partial set_memory_*.

Sorry I don't follow you. What "erroneous conclusion" do you mean? You 
can call set_memory_* on a random point, but 
set_direct_map_invalid_noflush() should be called on the random point 
too. The current code of set_area_direct_map() doesn't consider this 
case because there is no such call. Is this what you meant?

>
>
> I would like to send a patch clearly documenting this behaviour, 
> assuming no one else finds a hole in this reasoning.

Proper comment to explain the subtle behavior is definitely welcome.

Thanks,
Yang

>
>
>>
>> Thanks,
>> Yang
>>
>>>
>>>
>>>>
>>>> Hopefully I don't miss anything.
>>>>
>>>> Thanks,
>>>> Yang
>>>>
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Will
>>>>>>
>>>>
>>


