Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2276B8AF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHAPgh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 11:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjHAPgf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 11:36:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDD719A0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 08:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpaWwlwVcGCziYwwIfOhXcKgJHa0jCNyp/C2YuLeXsnZurl1OEefqN7q1dNOXVp/5aBG3+WroxBd0hXB6IgkEmLpWl9dIoeHLi1/+wuQYmzGD1Ko3zYi6mB2xQvsowo8+Zrt++8F8pDqmKJCA7HrtLMDnvbDeRI5KVankWo0375P5s8DJU2J/XGn5Zk9TuN+yQHopXgltin50RTwIIcVKhW45+SO98w2QlDWLLj+1dpL9BtgqluNwSzXKa0S5OfYa/wF9M9gzDzWWrY+PxVr12mJ/1cUST2RAike/SWZPALgIGalk9uTpb6qSuI3Oj5/DJUfx2PZ3QvdsuBP90e94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BvTOBcS/vwta+1PJd2yy+DiTsPPHr77bv9aYXOGF38=;
 b=FKcMGWjkUXR4RS8FoZHBIBDl6qVeuMMitjoaYdHXzJAqfImji9Wgo9gcR0u58ZvBqxHTmKRl6/VjDE8HKPpnnYvjtQUSFv/PMbLPOleanyzpUVVhwpu80SacUSmw37eIF4d78wbAXny0Ved1JYqbUl2/F6bDjS7Zbz6tmaSWqOrgJf4gHrE12QhgKdZEpefdsfNHih/mrppYn+Li8K4KuR7ixWcgLnyNkevD3CD+LohnSiLmaMrr7+EvCUrzfMd24sIyvTsjr/9dEl/9du/ZclpfKIKigLemKlymPRjYcajvPQ4GDu8kqivpuSEiXKlZ0C44jDGOyOnz/Y0C7+IBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BvTOBcS/vwta+1PJd2yy+DiTsPPHr77bv9aYXOGF38=;
 b=3fj9+97mpvwYbtyOlR4+BQZ5b3xcwBlNmW1A1/fQzMZ2RwlawOwuepX9MviKeg8+8BQnGrA4fVTJEhnxFRzq7IUYVavEdbd17tKWswEksK06kbEgD51l+NpoXzlVznO+7AidKmnQmgeCmR9EcMj+2DurJfTWZxyIgpRwl5taao4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 15:36:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6631.026; Tue, 1 Aug 2023
 15:36:32 +0000
Message-ID: <9b764127-eb41-2070-e399-34a630b041ba@amd.com>
Date:   Tue, 1 Aug 2023 17:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Kernel 6.1.y backports for "dma-buf: keep the signaling time of
 merged fences v3"
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jindong Yue <jindong.yue@nxp.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
References: <GV1PR04MB91833432B91E4ED2F16E63F3FB01A@GV1PR04MB9183.eurprd04.prod.outlook.com>
 <2023080130-perplexed-unbend-e3a6@gregkh>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <2023080130-perplexed-unbend-e3a6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 87eba816-7514-44a0-df83-08db92a514d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqIfgy6xMTMwcosBNiIHEMiWESaPeRouUWt74KVCtxHB9HYT/PJcEj6tt3hzTX5jJtgPWLHhj49OVCBFMKM1h3rf6/Cx3GGjpd+9uzYidT7pk2iXZp2sPAOzVrWV2y0wCvPWUZEapgU1n3708B3rXvSch8lEFfRdwr3RtwxdiVvz9TXgK0AQtVrK69aLuON1Ge51ylaD2Fkr8tjdPFemiWpPHY7PLJ7P+ksvhRZhOJu3iJrDaL1Cl6lCQbQQgy40CPh9TYCrAWxO74695voa0sbADHCQNmstGTpqPt0lpXfFT7IM3nrpyF+vwmSs5FsyrrRP62azFMXSo/WSweOuugoRRxf5mP+HK895PXhpzUPPa6Z+SoT20ZVVqUznlKUzZK9UAQsDQdYrAFMWGSMKF61kRJ+ftGaPVu9ZFXZBcUeVRiQ87+zgZ0P+c39ILy7o+cHm+nsZkNzMlh+bLzWtVGBGE1ru42QUW8eWtqQo+lapu7aeSM/YmPlnA7CHwlA5ZPJbz4A1V9BOdkbxQH5FcliiUVOVnHxB/616TU0xN0DMEyJJUQb6CvvRM4o/Rl+hYjCnaRT3nsHzHc1ss8vj4fcE+tyMJzH6ELYb8Qbbpv/ZjTgjVKtAZRcX7hQvd/gLNK3byGwRkBzmqmVoy42AAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(2906002)(4326008)(2616005)(83380400001)(4744005)(186003)(86362001)(316002)(31696002)(31686004)(478600001)(41300700001)(38100700002)(6512007)(110136005)(54906003)(5660300002)(66476007)(66556008)(66946007)(6506007)(8676002)(6666004)(8936002)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZtZjlLZUxsMGtEQU52eWdsZGlBTUkzSkl1VUlDTmlpT2lvYUNxZlpOamV0?=
 =?utf-8?B?Q0pXTG5NV2NmT0R1ZWxaOCs1UzFPYXk1eHBEa2hpRXp6YUxpTDhVcFh2dzNJ?=
 =?utf-8?B?cllkM1pCZ3RmYzBOazNqOThtanBBQ2Y0R0FOOU1LcDhDSjRFUzVtdnd1ZmdU?=
 =?utf-8?B?Y3Q5NFFPQkdHZ0p2L3lDTytnZUNBUk8wRmwwd3o4VHZ6RFBPVTdqODFuTkFt?=
 =?utf-8?B?djdGZWVaZ3pOWmhmME5UelNBUktPdThoK28yOElXMWhFb1YzWTdSOWZ5bUR1?=
 =?utf-8?B?SXViVG9pK2R2QURCcnQ5aWpZUzNKTzIxYWkrUHJtZm9jQVJjUkFHZzBZVzkw?=
 =?utf-8?B?NStLYU9IVGhRSXJQN0htR3IwZ3VZVXY2eVJrbDZwVHZ0Tzc1LzZ3R2dDTGpT?=
 =?utf-8?B?TkRhNVZrdld6UHZlcHNRTGdaU2txWVJxNExFN1hMb2hoRnRhbWFtSlFpSVpm?=
 =?utf-8?B?YTB0UUg5NlVoN01OeksvMFpORElnVzJCZ1NrQnpYQkhPTHdoeG12a3AwaW11?=
 =?utf-8?B?dFMraHhvYStUK3RXdUFNaGJXd25qd2xPNzVhVHczbWtxa0FJTmhsSE1IcEVG?=
 =?utf-8?B?N0NSQUJNZ3Nza2sybWZmcWZ6OFd3TFlUc1V3K0Z3YnJWUnptZ3JlTlIzV29S?=
 =?utf-8?B?ek1CQlh1YjhVRHZrTy9mZUY2andDNThzWVlCNkJqL3kzRGE1a2g5TUQ5ai92?=
 =?utf-8?B?VnBpRGJwblFJOVlUdDg0Q29keFVmMGNGemYxUUJIQmtOcCthMFdzY1J1K3px?=
 =?utf-8?B?T0JjRzRtdlZEbXp3cUVFR1kydTg1ZXRDOU9Nb2hLVW1iNWl5NHFGcEQ5ZitB?=
 =?utf-8?B?UW5CcTRMT0ZyaXk3YVNlU1M5WmEvV05oUHhBaTRUWEZtYkNHUXcxWGllTXZs?=
 =?utf-8?B?SG9uZFN4aG1ERTdoZ25lekpGTVpaL3ZPQk4vejdVL0IwT2crcTlmREJoQlI2?=
 =?utf-8?B?T2hSU3NyVThQS3YzSmdzdEJGVnFabVdycjBTVWhiNUdPZUFBYzJXWEsralF1?=
 =?utf-8?B?SDlEbngvRjB3bTVGN2x3dDNRcWZraVI0UGJvQ0hNNGJQTStzZHo3bys5SmZ0?=
 =?utf-8?B?QmNMbWtZRlEwWkt2ZkIvL0xBa0kzR0NGSTE2TTdNc3EySUN5QWhrOGRyMFA0?=
 =?utf-8?B?anltRmR3WWlHQktBZE14K2J2TGJkaFVZb1cvT1lKaHVrcHJwUW9XaEVZWlRK?=
 =?utf-8?B?S1ZuTVJXcFhQY3FzYzduSklPNHpLQUltaGRCOU8zQjZ2OHh5cWlHSGhjaDJy?=
 =?utf-8?B?UFkyMFdmUGtFd21GWWV3aDJjNk93TjdiL3pUQzQwY09ONXdzdGs0eHdOR3NQ?=
 =?utf-8?B?bHZOWXZIVWk2ME9WMTNyRFlwZ1VyZldVZDVCc3JDRGE4Wkt3RTBETVNUVEln?=
 =?utf-8?B?R3U2SGRRNUtsNWFlWGREbGpzOG1DTWFTa0xtQ3RCQmpPMzQzUFAyOUdyeDhO?=
 =?utf-8?B?dlhXdW5CRldGRHQ2SE9NL09KdkpqaURlL3lDdjBzNTkybFVobmtkdXMrWTAx?=
 =?utf-8?B?R0NkdFpSNG5yVHRGaVAzVmJKc09XRkluRk5hOVpzLzhFakc0L05sNXhzK2lW?=
 =?utf-8?B?VUM5SURVTGNmOG9uTVVMS2xVNHM4WEF1NTlHTTVwUy90bUh0cFZMcHZTMmhC?=
 =?utf-8?B?NzRyREFHSFRKRmxQNmhSWGptcERuNU4vcGxaVTBUK0VWNEJBWnJTWDRHblFN?=
 =?utf-8?B?VEZrM21aTy9SMFBsbFg4VGs2b2ZVcFVoNGJPWndNcjNYY1ZoTlN3ZHJTdlJQ?=
 =?utf-8?B?Q3k1OE4yUitiV1V2YkhIS0RzOGRDckVoN0ZGNGFjb2JLNm80T1RNaDBLQ0s3?=
 =?utf-8?B?di9nV3NIdEN0QXpseXFncUtGSHRPODJhUDJOR2VjcmxsTXU2dmUyTjlKVHNF?=
 =?utf-8?B?Wlo3alhmUlV5Mml4N2VVVHBaYkY3Zy90MXc0YXBvV0ZHS1FFdU1mN3kwWUtL?=
 =?utf-8?B?TlljQ2NlWnBMSnlwbEFOeUtqLzIwL3RVVGY1dFFRd3BEa2R0Sk51R0NreG1h?=
 =?utf-8?B?Mm9qbzdEdERaSW5OTE0zZkwxN3lnMXR0cmhySExDRDN3U3pFR1JkOFQxWVhu?=
 =?utf-8?B?dklKWmlIMlRuaHQ2cWIzZ0NsMEtaOVRHR1lFQW1YYXlmRERJbnU0WHI0R3dj?=
 =?utf-8?B?a3pjQ0NrNU5COEpPby80ancrVWE5Z2NOT1luZ2VzeVpLblZ6WnY4alFDaUpB?=
 =?utf-8?Q?rgJePbzXehm1NbhkTV33y44mTUxdz+L4zGd5sXG5rIWT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87eba816-7514-44a0-df83-08db92a514d6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:36:32.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkqJOFlTX0KSwVcU/svsIHQX63Bco6Ay0fMXOYxcO/u9QMEc5DKid3zxR3GtLJ1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am 01.08.23 um 09:56 schrieb Greg KH:
> On Thu, Jul 27, 2023 at 03:19:23AM +0000, Jindong Yue wrote:
>> Hi,
>>
>> Please help backport following two commits to 6.1.y
>>
>> f781f661e8c9 dma-buf: keep the signaling time of merged fences v3
>> 00ae1491f970 dma-buf: fix an error pointer vs NULL bug
>>
>> The first one is to fix some Android CTS failures founded with android14-6.1 GKI kernel.
>> 	run cts -m CtsDeqpTestCases -t dEQP-EGL.functional.get_frame_timestamps*
>> The second patch is to fix the error introduced by the first one.
> All now queued up, thanks.

Thanks and please ignore any duplicates. This patch was send out to 
stable by me and Jindong at the same time.

Regards,
Christian.

>
> greg k-h

