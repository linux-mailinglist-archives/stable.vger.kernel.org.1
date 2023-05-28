Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5F7139B7
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 15:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjE1Nw5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE1Nw4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 09:52:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A859B8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 06:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anPnKQRPz0PBqVUxMCENG9BFLSJ/xYIDzlQ+gc6IITwdAOZYd4esoVVs++mwN8ElTH4GJtxwzBFYG46zkrzO0kGoyxhYDsxogHf/Nebh0LdmJLGVQv9I/8VB6l2Fy1ACeyfMGa90L2w0Ta39Djya6Gf7AhmF1EXeZzaNQTf+QSw2CzJlwjCRy1qmczDKqb96EPXQUPCLQnCmxmNqrhMvkuVT46hkPxD3AP17u3q0/etrcPqgBhX6pgP2NMqA71rqfZGESexsxn5KJNKrpJQ0KtlQcUIClQYFHER6jJ5xEmbXB2b46oQnnmHN7BGQIm4JGpE/0NQftDuEIi73KNmKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYjHzkoZwexcCaYlq6r9d7LA5nIuHAusXS3Udr1/OtY=;
 b=QSNLphB1dZXMSmsynhZubgIeRz9pjPZo5skd8og2+GMBJqdLKDQdRUV0neJtgY85MXuOGPrlnhWwUFyB05w0lDW0gNtJmKCVpLE86/nC3Uos97KsFwAPsVEpSKoHPWOBFhdJSrYKooJHhw1RVKAqFZeIJouO/c6QALhtrKFvObQTS+QzBoWn7lgNAPw7iFUltosIdPc6gJQCXly3eruMtPKc0F9CyUC2JD2CcDsKwcJ6jxg/glhYlPJ2oW1V9amjHdODmRB2/u6OjUL7SLp5ux4mdHAeAwZ/ZcciC1xSTCmHZSNLvPulA7+FY4pLkY5hkrVhvdWXLvcnZKYytOhJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYjHzkoZwexcCaYlq6r9d7LA5nIuHAusXS3Udr1/OtY=;
 b=z4YmLiXpAong70sqQLHVX6zJJXMVd3YtgBfUhxoUZ2PIUpepQX165DYhpynAIC81DWc5BarSRN7JqJJu2+tICZENqQwJWmmpvYPX3n85cEPN8KQ4PgXpyT17bqSC3Emcm2wHo3HR0fZmjxyYEsZ8iBmVqmfjRJ+4C8xgeDH86Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sun, 28 May
 2023 13:52:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Sun, 28 May 2023
 13:52:52 +0000
Message-ID: <e6601f6e-82eb-c227-3e80-4f73fdf69937@amd.com>
Date:   Sun, 28 May 2023 08:52:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     stable@vger.kernel.org
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Fix for hang with newer GPU F/W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:5:3af::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b602b74-9629-4a54-6f87-08db5f82d49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LydABYaZr7q/ID1pH9w1AHaLxJrXBWG65i506y7ZXgPnWxXMq5R0btZHEXWVSMNSkkkzwKghJ32uqFI+N6J/hqO3aViZNC397HF6hWJtvL2EIbEXL3xUOLcC2obdFvfaiaH5x4VH1NdHR4dZUEvkB7jXARpt0NSdG3qpIa0DQj8DxZCmx9g6JuuS+pptoXryX+MnBfncBMBPHRZUPf13U0Ezz9ILxYV7YfxKBamoOvxzBt/l+0dXfNEi9dNO1QIsR0D+C/bRjy8DvdTasE9mi4M7rXkCX7zg4qs4SSPCB1n+O4evVCz5vdJ0cBRbjxAmYpWIY/ofqAjcjE/HrIdJFhl7VXNxVH3Oc4g8y1M7WUvamr0iC3WA+aTExDK7PBFeeUcivq90qmXVFBeDlLG2SYdPsPVjLuKA+lYrEQGebD40GVWc8AvuaCAUrrjSd+zvHYo0/YtRnMUz5zjJSR0jOIPYaWTzyxadTWFGNa7I0jejSXPF70XNVTK6BePos3YIAcoSqB2ApN3pGfaLJqsk6i2XJO/SmTXBlnydF+EP3qAwQ7Is/mMV3TyPRK+lrVDsIWtL4tC/ER/F6nV2vyavPgzuvQIqoyDFsC8plQoydjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(316002)(41300700001)(6486002)(2906002)(38100700002)(44832011)(8676002)(6512007)(6506007)(5660300002)(83380400001)(36756003)(2616005)(31696002)(8936002)(86362001)(186003)(966005)(558084003)(6916009)(66946007)(66556008)(66476007)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFXZU9rbi9pMWVZYzAzRVZocC81SkdCd3FvMFBkMnRxMzdZWm91MUg1eGk1?=
 =?utf-8?B?MWtaMzJ0R0F3a2cvTmFkU0RPZ0VlN0JYMEk2WnR5SHE5dm9HZFRaQ0R2Zzk3?=
 =?utf-8?B?VTdNMGpYR3VMN0ZFeGVRbWhWSXU3SEZvT3dIVUNjYmREZ0ZlWVBUZGV1R3F3?=
 =?utf-8?B?TXQ0blQ0QXVPT0pudFlsYmIvdEVFU0RBL21oaHhLYWpjeXJwUmtVbkg5ZW93?=
 =?utf-8?B?VVRHVGhDT09tQ1Q5ZXZkb1gyWDlVN2NNK3ZDellWWXExeGNlSy95bSs1YnFT?=
 =?utf-8?B?aEd0Yy9NMFhSMXhoUGRDdFZiZ0ZuZndBUmI3M0dDeVp1bmdidmxKeFBJdXdR?=
 =?utf-8?B?eXRhNFhLaU16ekh0VWtuMHJXVlErcmc2bW42ajdvRmVveGJMTE1DVTNmWXND?=
 =?utf-8?B?M3BucGZnWUNyQ1J1LzA1UXprUk9XbGd3cTNINmFOLzcrNUhCdHB4Qnc5ZmdD?=
 =?utf-8?B?M3QxVWdFR1dLc2NHVlp6anJISVpsS1N5VFRPeE1oa1hQM2RBbnVoeEsxZ2NT?=
 =?utf-8?B?OUlPWHNSS0Z3NWN2U0RneGNocVJ1aFpKbVE0M090ck56aUhEREpXWlZSVURC?=
 =?utf-8?B?aVRrTks0MEdKRm1pUnk3Z1NTSCt1czFlbVZwWCt5ZjZuekZXQ21EYk1uN1Vu?=
 =?utf-8?B?OVh3UXdnRWJkOUVHZThXUzlRZUJIL1gvd3F6bStUU1BzVHE0OTZMK1V5WnZr?=
 =?utf-8?B?K2tkc0JGeWt3V0FQY0R0UDQ0ZjRSbml5ZXE0Y1Z4ZFgyOUxOcDBZTUR2aDdR?=
 =?utf-8?B?U3FFMWZSUXpwbyttcE5scU9pVExSNXZCUmVvcTQxZmEwL25La2pYcEJNZldM?=
 =?utf-8?B?ZjhYS0ZvYkxXRGxBRElkWFJWSnlEYWg3aks2M3hBN2FJRnVTTjNkT0puUG93?=
 =?utf-8?B?L0FERmVzajBkekYyenhxUWRWT3h5QUhvMFdFaFQ5dzZaNklsOTdnWGZzcjlm?=
 =?utf-8?B?UmY4bko2OWM2RjlTd0VHSk5yYkoyMFhMaTBhK0xIWkV0WXJIZ1ZKOHNqN1Ev?=
 =?utf-8?B?UlI1U20rR2Z5V0FlNkdlV0xPUEFvOWVGM3FKUXY1b1JiZWZEeUNmTmhRdjIw?=
 =?utf-8?B?Q3NwVStXMis1K0Q4R1ZicmkyOG83SUFVS1VBYytDTDFTeEZ1bjUwdFdKam5B?=
 =?utf-8?B?V3VxNTZ4SHRpV1MzaGtMUlAyQ2NtY1VVNVRBTE4vdGZmd001S0ZlODAwaUww?=
 =?utf-8?B?WGRqTUoreDgydk1nRURadzRyWjhlVjNSZmM3dU5KMzFzU3JIckVUTVMwbkYy?=
 =?utf-8?B?bnVWaDVvMVE1RHhlQWhueDR4YU8yUWxyZCt2OE51VUIzb2NDZnU3VzhjeXNM?=
 =?utf-8?B?SXRmTWF3dURYeEY3S1RRMTQ1QkNqanZLME1VOVpkbFFpQi9LVlo2UEgxY3JB?=
 =?utf-8?B?UzdQczhCRkM1Z0J2N3hMRGFTbDRTamRyMFZJRmZaWHpIVHhCd2tRc3IycjJX?=
 =?utf-8?B?dWIxT1lvOEdSQk5NTytSZTcrWDFUQjZraXBMdjJjRGdFVFRxV3Z4WDJmRys5?=
 =?utf-8?B?TjBpYnBaaDU3c1FyS2xiRGJWQXE0RUZBRWYwbTlFT28wZmFBelJOS0pEeDdz?=
 =?utf-8?B?c2hKY0FRZHJPRWZQNWZYSXRWWUQzNktLQVVvSmVJc3BCMzRtd0ZxelZ2WENi?=
 =?utf-8?B?dlk0SVd2U2pmQkdUOW03SUNmYUNPaitjeUZFY1I2Q1pNNUpRL0dFODY2VFM0?=
 =?utf-8?B?VjJrQ3kwY2tKVmpxZzRZU1ExVDlUMndZV01lQmRXVlJVenRqRk8vUUM5ZzFB?=
 =?utf-8?B?K1hPSkp4UFh0amEwM0srWVlPaFFFZzM1ZXBObUpnLzhLOFhaLzIxc0N3K3dj?=
 =?utf-8?B?ajZqYVdjTmxoYnJIMVppZXp0NGl3ZTdEaWN3WVZUTWVIYkJzclY3MWwya0li?=
 =?utf-8?B?WkErRjJUcFVBZTlEdWUzOU82TUt2OC9wUVAydy9NMWVPckdRVm5JV2l4S09y?=
 =?utf-8?B?YWwvZG05Qll3WkQ2QytuTzkwSXhOMGlFSSttSEVIRlFqOHdNRG1ldmE1aUxK?=
 =?utf-8?B?TVltSXpodmZZTk9YaVFvdXRSdTAyeDJJR01DK0xWL3A2cGJ0R2UrNWhCRk84?=
 =?utf-8?B?UEhmcy8yb3NJSFhYbUc4QTVpMTNoRk1UK3FQRndqUkl3VFl5ZnRjRmQ4WDlo?=
 =?utf-8?B?TEtXWFFoanB0a2phTlFDMnVpTGJGRnIrNkJVTTRTbTIxTE5wcUVXRUZFd3F0?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b602b74-9629-4a54-6f87-08db5f82d49a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 13:52:52.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50JAaC7sGs9VdoClKo81Lc+gnDKq1aUB7jJCivvku5ZZcun24DRxQmo93DueMpA1aS/GBUWSQ/TSZbs4EyTFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Can you please add

5ee33d905f89 ("drm/amd/amdgpu: limit one queue per gang")

To 6.1.y and later to fix a hang with Navi3x GPUs?

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2585

Thanks
