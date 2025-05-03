Return-Path: <stable+bounces-139542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F63AA82AC
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 22:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22CD7AB237
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E5427E7E5;
	Sat,  3 May 2025 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KwhfIpGT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KwhfIpGT"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E027E7CF;
	Sat,  3 May 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.82
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746303857; cv=fail; b=iUkAJtPnVmt510Ogic/fEVvE4ote9/qZZzFqYLIsxnXf9TNdndve0mDqa9R09dqLvRh0icalP8GdIBDoOkkqrd3TSEP3UepuTZPxPIY9EVWtZJe8ep7UpWxfXqApA3g+Ck8KAuqkbdflJUdb2WfMBYbwVDAujOdPp+/PcVx8Auo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746303857; c=relaxed/simple;
	bh=GT1QV6yNKgbA7XFrP1+lw5C8RsfUyAIILrlDCGdrqCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dv3cwLP1LjS/dwc4kNSIkjZnelleQwCWVHMKqHYY2i6Fmi1v8444rGtwfXec0uxQ6cizefZmTdvMDOOsrE4IcbwjJe81lCZwTvhn4c7vKO3d1wGDQLf+jUaZ8ahudbP+96D5AaAjNHrSO3XYyTpJox8M0aFkuf0llNBy6cjg4Lw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KwhfIpGT; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KwhfIpGT; arc=fail smtp.client-ip=40.107.104.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QALgz3JDCgE8Uz7nrtLc+hn64IPu5JQ/TaaalH0t9ydIS0x/KF2+7nxmAQZroZ93hzyt7IBiLBB3YCBbra//XOatu6kD1hV3XAVpzxGhnqtHWkUZiLLDcc/6QxaP8wnhBxQkKk6A/0MkPjBrnVdeW8A6DZQpQFX2Klp6XrOXXD8IDWmywG2r4dSIJcpU8uJKNvq2SgOMtT6pHDkWYXrcPyP/t7+9lukK4jZ1w3gDuKN+H+9HD58GGS4LvfgzjLp9yEyYRYLlYBOLmimgwnutSwdybhHOYgPBvQI9/6GlD4PtF69PQgabhavEC0/sVb9jLuwElf/l6hBXA6epNqimww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBStQuShIoSufRP9xJ9urAqoxhZq2yu17Gw3FxIxeHU=;
 b=Rjn5ajVikl+OjQa3HfUS9pTevKi6WYw7iHIFndAJHvZ50Awd3dMdiI6q/L8mbpmlc2UNfjxX9GN991qYathAjX80NAZPd6q5a/3noxQTlWF7BUFTKSHHF0SMwnmTY4W/eNMAC7P1T31mFF4CiDnkrgg6EemQYfxcoXm5+e+1TPTyCC9UMcrLa/d4bOZ8eIExhr+KnsZ9Jl188irsQA+5M6uqO0yKLeXRvAqk/SzUhMzUhayis0EwtoWezFJXZIOPX/I2Kvco4UtJRmmH0OJhhVP6Gbj7aiI/Ur2315AG5H93z9kIPpkH44gsL4pFi+GiDrIiGXT3ob0cHTbTrVnK7w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBStQuShIoSufRP9xJ9urAqoxhZq2yu17Gw3FxIxeHU=;
 b=KwhfIpGTLcO+xf59wE+aXs53N7txUVrR6/W8emlhZMWebZM4zvLZUT6ss/zNYOMqkVadjB2bCBR50yLWWNg3++3n6dZ+k9AzvsT4WYu4qdiGBc+EPe8TwVPEJQtshdB7W4dfCikAMEpNbJ52u8r37V2h1diq5MldSdM0/XyIyc4=
Received: from AS4P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::8)
 by AS4PR08MB7808.eurprd08.prod.outlook.com (2603:10a6:20b:51b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Sat, 3 May
 2025 20:24:08 +0000
Received: from AMS0EPF000001B2.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::39) by AS4P250CA0016.outlook.office365.com
 (2603:10a6:20b:5e3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Sat,
 3 May 2025 20:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B2.mail.protection.outlook.com (10.167.16.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.20
 via Frontend Transport; Sat, 3 May 2025 20:24:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI3By4l6U9jMQktEBH1z/bOhp/vyrAcmu2Z0Tk7Y5avZMaDrITr9G6MdKowokL7RrmAlvOrcLG3iIu8sL3NxTUt6tF/2HkHO3WwHc7s2Yfdj++vNe7o0a5EOWt5k9raCq1MK58z0FScz2kMyPgZ6BMxCInXpkOeUqu+P2ijIcEzw6N76FfiuSNd7LayiTgk7qmYaeHAPq5QOTzDHUM0SpX974fM5q8ceQpg++wcqo0GMVVNh/Va8rLpA7WGf5HxW24LwqmH669vgB4RNy0iyxxwMg+a20CA22Uaq25gR2Uh93/fjMh0JShunZz0K7vTSe0ID937SM4lJR9MheCQEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBStQuShIoSufRP9xJ9urAqoxhZq2yu17Gw3FxIxeHU=;
 b=KA5J2lSEbpM4I5ta0hvi6I10qjhHCmKhMLFfzXySWqSgrgmlYETZP71QDNc7RWGihrhl0lkF4Jd2DvLRzqlgFRZ5CS2cFRPAbLqGhBh9oP+hJmBWSMv0rR3eMirh916dtWQs9vE05LZwp5/1oGMg6x5Lgk1yezPJdvFyspMnWQGU502MnabiARKnbOFEILdIiGla3m3aGknNmrtGwKr2TBPLuiZC8yUCzxr5LByMc38aBFbjHf/tEWvjdO7U3IrTKvvzcRcEriGLmTBn9kao/bufrC0OKxC6hO7syWgfPDayBkYiX7vqJcztMstR4HvPmDrYUDb21i1VZB3b8KLrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBStQuShIoSufRP9xJ9urAqoxhZq2yu17Gw3FxIxeHU=;
 b=KwhfIpGTLcO+xf59wE+aXs53N7txUVrR6/W8emlhZMWebZM4zvLZUT6ss/zNYOMqkVadjB2bCBR50yLWWNg3++3n6dZ+k9AzvsT4WYu4qdiGBc+EPe8TwVPEJQtshdB7W4dfCikAMEpNbJ52u8r37V2h1diq5MldSdM0/XyIyc4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB10978.eurprd08.prod.outlook.com
 (2603:10a6:150:1f2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Sat, 3 May
 2025 20:23:32 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8699.024; Sat, 3 May 2025
 20:23:30 +0000
Date: Sat, 3 May 2025 21:23:27 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBZ7P3/dUfSjB0oV@e129823.arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBYkGJmfWDZHBEzp@arm.com>
X-ClientProxiedBy: LO4P123CA0269.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::22) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB10978:EE_|AMS0EPF000001B2:EE_|AS4PR08MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 45eec9ab-92bf-41d5-13a4-08dd8a807429
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?DntnPMp4tFVWK7fZ5jCAk+befijQ66WrvXN4CXb7aYZVh1hZc6i0AvnV1L3S?=
 =?us-ascii?Q?5HR8TLka5A+85ZmI2mDA+JhJ/T+mzcjn6nqfBI25YA7gU0tB3O6KX8LxoHE2?=
 =?us-ascii?Q?KqrrbEZfB7lfFHb/esWG7JZEeI2TWuHRtM9lH08ERR5pFTaCchDHpqZJ+8eC?=
 =?us-ascii?Q?H2oDxIOz4U/iO37xIkI2M6CREmYo9PSq7a8WYKD00cAbZ4mkvVLMDVrvAIA8?=
 =?us-ascii?Q?7SnzplQiQVLQZIEKwAYmcQeQpgz3VuefK0PseiWHYQdXwKAFJvtKUm7dGXCc?=
 =?us-ascii?Q?rUrFaY9k6eXQpMYjKWUWzmUBlz30DcDrYDhSq0NHv0p1SwiTfX1FI+GfHF1+?=
 =?us-ascii?Q?E6o5ZEnQLlLO6IND6K2fNWnUlezpxoJPwqPEhivCBmSFxx1hfB/qYgi8k0qi?=
 =?us-ascii?Q?CWLyqWhH9STAg25PA2cjWqUjpcf+2E5bLG+8KVBWps0jnG7CZ3WVJekTfxiA?=
 =?us-ascii?Q?EYBU/rIXSI0gzVM9hWZgUMkngeA7P6iDsCzzpAi7GbcT/hrQfCsKF807f7WX?=
 =?us-ascii?Q?wdgHdusFiTaa9kPTdSRNqkyc2sxzkZFp4iTPfoD++ABn5h+sOZcbbwPb65te?=
 =?us-ascii?Q?0h8WwlwCqrzkbupwvQfeys5JwkjJ0dmfJA2oxcyBwROqXFAdesgWEiMERBX6?=
 =?us-ascii?Q?D1Jcf3r0G9K3Rzs9yzecXaoeGqL6BJ3j5kKF0GdV4/z9Zxnmo61u+7hsML/8?=
 =?us-ascii?Q?xzgGuxEhLiv6MNrQHw+OOTesyshaGeaVGV26p15kFV5tNvaEpfKH/RcavGI1?=
 =?us-ascii?Q?1rahjJOfeA5B/AJPXkgdTYS/unrl5qHkUgleopellU1tSBxcdJKJS3v0uEuB?=
 =?us-ascii?Q?I+5QknJ7EpAHyW9wnRlf3C7HCbQMG3+b4hXFuMCGcOnPf9vPyvvFiN6mXA4A?=
 =?us-ascii?Q?OkTmcgHO8YZd/4+vIErpjXD9+Vpp1qO3BV+xgZ+V/bmANygWTizroSUL1oCm?=
 =?us-ascii?Q?3ELX28kOBSLn1H4YG9ovAd+MFJapD7zY2hL4BQWkSQUJe7OEUR7jMqVwX7k0?=
 =?us-ascii?Q?K/Dgmh5A0tdrp0MFAnM3F46TLLRgbmAoe61EDFopW6pui5OmxfC/L8FhI2CA?=
 =?us-ascii?Q?TCaULRJmRMhr5Db6XagQ6U4wuoNO6Ze/hygp7Uo8RG+dEtiSS782tckoEDdZ?=
 =?us-ascii?Q?ms0vkS22AMZNRf40FkfO9/rKhGTgziZYGA0IljBt+yuvnurcFiNOMvOsse+y?=
 =?us-ascii?Q?QRFiUvAndfg9vsQTT6dJ4zAorn8G8XDntffPbWMENwzm3roSs0m7uUyq9b6U?=
 =?us-ascii?Q?h62y+Jk5vtV49/QAtLoT8YobJ2PD8iRDJV6Jzvk1vhzfVspWfimoBe0Z24ED?=
 =?us-ascii?Q?BWRPlMpbkkWiY89S519MbX7eOXKzIXzeVTs/Q1p+aDUF5pre5arMXXLTOqTN?=
 =?us-ascii?Q?iLRlIbM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10978
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ab369c44-81a0-4388-e64b-08dd8a805eb2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|14060799003|7416014|35042699022|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8kPZR3QMzCwsSfcRlpdapBid9378abdb6DQ2SHOtzAIw75j3NFKSgiKWVAL?=
 =?us-ascii?Q?waJAm5d9SWPBeq0l4wrOrPuSMmJ9JTMEkrKae2DPqTgpK6q1oO3uuJKjliq+?=
 =?us-ascii?Q?mHEf3lA8Rgs+FGLFw1gm/95YeQO8pSPVUmkUMW6hU6DwDSkFrGomSR87I0R6?=
 =?us-ascii?Q?2PSycSs8qHY2b0f3ugfJX8aI9EYh168ksNPVrG0WavT5s00GzOAlgwYAiIjc?=
 =?us-ascii?Q?p+lrNI+5eFwx8qBp2tBEZe4xeiON1jMgSfoXa6JuPK7DiQPbwvtCi37yGyxi?=
 =?us-ascii?Q?qYLSvFirAC2AAUcviGAc1N/Nwue6Ldvk+7zDfvqJnDNa0yoaNDC1k0xrS47D?=
 =?us-ascii?Q?BuEYZWq0tJ0ej2sdpw8Hl5+fHhs4y7iWUXB7gy5pt+lBogzXcX2uBOnij5pb?=
 =?us-ascii?Q?+XtKglkvukQLxeoxNON3xVsty1g7l19tJOh8JFVEmFcja3k8dJIU8naX+VKm?=
 =?us-ascii?Q?bTxc/u1JZATFIotUX8xyvzxvqi99potJZPTeLDq3fNVAIFSR0X33tLtlGFDI?=
 =?us-ascii?Q?ZmJhwbDNtq9oJrWGh7hNxeeyOtgWTrD4xOuj0ZzD0K+duVs9rPXdUw9qBs8B?=
 =?us-ascii?Q?kBgsLnNHvFnmSPHpRSNwDhIlHsILvOwObe2/o5eDLNuRw8AQaYhSWYEfuO0O?=
 =?us-ascii?Q?mMKS0PtraFIG7EAfr8svD40LDPupRs6KSDWsl8M5YzxDina5GKO/fhAaXFlV?=
 =?us-ascii?Q?Hm4tHV6FhcqlW3aiYDcejf5HnerccFg8nDbf8LOxeo4P6NqyMsrwJWyddorJ?=
 =?us-ascii?Q?s53B8iyA1sFJbKyIdg/S/PZoNTWLqXi/aPjuud+Hn+fZcbjTW8uMMexWRgqJ?=
 =?us-ascii?Q?476juFNtCTnvff9Bwwpdmfw++avBoc4ZZq2H4xouH39gokVn00absTUtE72x?=
 =?us-ascii?Q?HODxTaKLDReYBr46ycS6zz15CPFWPPcgjRVjzEd4td8D73yB2d5cLBoDjOwW?=
 =?us-ascii?Q?lIPr38Szmw/e1uElaw2ujnzPJWpS6HXN+xGHMw7GlKv06UFNbRpvnnNmT0ku?=
 =?us-ascii?Q?OtbGzqM2x0t4+F8Dwq00V6Rr5VwEOH5MZu/bY5bRTH58Soox0CTQWRUZOfa8?=
 =?us-ascii?Q?cHaT7RLg6cPeLyKxV8sU2IpiVIerrAIzMIQGF504wIzDq3gYVti0c9LK24G9?=
 =?us-ascii?Q?qvvGA+aBqAw5OigMnG//QnzeZ3NBovkQ2qEwzE8irSSosHv4d6RuvvJoXEY1?=
 =?us-ascii?Q?nhQI1L3I23bC0nA3oi1flzCaslaViQNfiKvKvfG6gKGZSxFv+IIRPenCescl?=
 =?us-ascii?Q?YKY1tMXwEXST9RpDnO5v9B0XYsWcq9T8qUs/wC1SCmnsaCgujAUTJ9bIZoya?=
 =?us-ascii?Q?E2+qTwQYv+RDlQ3V85vnPRAFVzb6OEjywqgUhEJNaOxVyLXBS+lQWD2pzJKd?=
 =?us-ascii?Q?tADKCzAdWAoxNleHLXGeaVkasjjkjlJqsfd25arTHk4oYRrIEtYa/ULyE+6Z?=
 =?us-ascii?Q?w1i7xUWsFvSkmMRTnQxrtHYiq8bFYraZLfZPiYc58/0iNaZStxvVnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(14060799003)(7416014)(35042699022)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2025 20:24:06.4763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45eec9ab-92bf-41d5-13a4-08dd8a807429
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7808

Hi Catalin,

> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > > create_init_idmap() could be called before .bss section initialization
> > > which is done in early_map_kernel().
> > > Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > >
> > > PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > > and this variable places in .bss section.
> > >
> > > [...]
> >
> > Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > comment, thanks!
> >
> > [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> >       https://git.kernel.org/arm64/c/12657bcd1835
>
> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> version I have around (Debian sid) fails to boot, gets stuck early on:
>
> $ clang --version
> Debian clang version 19.1.5 (1)
> Target: aarch64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/lib/llvm-19/bin
>
> I didn't have time to investigate, disassemble etc. I'll have a look
> next week.

Just for your information.
When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
 - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/

and the default version for sid is below:

$ clang-19 --version
Debian clang version 19.1.7 (3)
Target: aarch64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-19/bin

When I tested with above version with arm64-linux's for-next/fixes
including this patch. it works well.

Thanks

--
Sincerely,
Yeoreum Yun

