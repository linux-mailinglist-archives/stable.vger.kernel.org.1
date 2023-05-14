Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9AB701C52
	for <lists+stable@lfdr.de>; Sun, 14 May 2023 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjENI1a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENI1a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 04:27:30 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2051.outbound.protection.outlook.com [40.107.12.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F311FFA
        for <stable@vger.kernel.org>; Sun, 14 May 2023 01:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfbiulOTRD1b32BJLR6xSmeqcZUNx23kvMVm/JBO/sQECAY1Jik1d2uMEetp0IwjQgsXoCWvGh1geqnFnUkC+5AobKLsvvfAy7sbA9QPKfndc35deQk5Jk/41DTnVc1Dq+QufnWpYUm2hOLrwhSQn89y2A5vmv2HwTAeAj3hwQcb4R0aQVoDP/I1fvuBGQwgnDvWOxUW8TaUbS11ILlob2+rrOia/xFObO6zC8Ufd+RCmsNP/KCuC2c9QLgORY4zO1tM6wqZ3UHvMoTFC0qigMcpoLIbOr8HLFK6trMPhhoPPEzH/AlbRB0qVay5yaspaJkTbBchsXPvk3Ew3JDdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uumFS7AtNjXJuX2KwH8nHoUa27gJZvpjB3hikqJ7XgE=;
 b=Yjs4M0dJoc9JdNeMfEDdPNNriaMlYnOziyhjlMDw9kUhmur27yNvaReRP3eRi2OFF9pI1KtIZREWEYTFxQ0/dIS8oMb4M/cknmsY53I9gbenZ5aE0DsajqJ3VsP0nrOToRwGA8WfkSU0kRZc4u9uaR+yRjF8WKlHjUmLbOTcGtYu2UtEXU5sO71IJ4jcZTS46Jpr0kbzjc3s70L8hnyQdMRMbJa2VX2mBDqLYBiXxnW3MC4+oICSWgu93IELwYICLmMasVf2WNSKK4F3q0nuKIjy4RV56VejgFagG2KrbO9t2KZM+UNbvOAInafvT1d1vkQ5dA0cXDtpZFCZdjeWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uumFS7AtNjXJuX2KwH8nHoUa27gJZvpjB3hikqJ7XgE=;
 b=MmrZ/RYAk5tzFjLCDxjz1wFMBhQaiisYV907F7cE01yI0hMGsoVhe+SGNg36rKZxhSiXvqI5sjIXjyOhzMRS1GJBzWZEBojWa+/wOXJJoGbBUanq2u81tE8bpKBf0IczDECWsoEBpWrHOuqVsXXWSm2bv4Z406jw5oSujTpunNhTURHA9aw+WCwwOqbwGx3UwU5wbTRX5/r9EQ/peZhTH8W758d1TNmQnMM1b/Cwp5b1luI9KD5l/tlYZgJ5lfe8w90Z5a7C2JUyPmmznUrApzzTdeVZa6TLVJUwWqD4KnTC+axDEsPjfoyoAKxhai5v67gg0VZmQQJyIUd+6yMhzQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2116.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 08:27:18 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 08:27:18 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     linux-stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
CC:     TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>
Subject: v4.14 : Can you apply 78c855835478 ("perf bench: Share some global
 variables to fix build with gcc 10")
Thread-Topic: v4.14 : Can you apply 78c855835478 ("perf bench: Share some
 global variables to fix build with gcc 10")
Thread-Index: AQHZhj3lR2vbaGM4kUqX2hP9GeSlWQ==
Date:   Sun, 14 May 2023 08:27:18 +0000
Message-ID: <bae53ad4-66e2-3ab4-dc40-54a82a1f6e2a@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2116:EE_
x-ms-office365-filtering-correlation-id: 13ff6469-65a5-4ed6-7f24-08db545507bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2UIFaU2eYrubh1/BQHIns2+5V3qkRapPf3ePA9YQs6hr363R6Z2uho8m4t11X2A0Gdd7zUkWbQ8KhR8KWbl/5DKfiOQr0UdcXmkDvIXQZ92mxIyY177quFAIiPAiFPiGUmknOJIUTkpsPZv1RHbR42qZsuLnLjaKG5ICABdtqGXZdUaY7M8q7Ui0FTxKfKeUDrg4zcF4+rGVGU/EpOmVtIoKP9JltBxyiBvOK6GrJOlQnqjH6x+GwwEoguSpIeZ+z91tCLB9neq9KA2Nrj1ByIjlN5SwOfI+iIEQVEACHIhWMt4VKBstF0+HFv6WKD98o4KhnRmlam2GE3F0+La4SDi+DqJwc9FTSA0S+b+4yI1JIZq6iIO+ejD1U9M9vqmNMgtK2bYt4jr5QDBI/JoLUN6D+ksI1ClWhij/KKwpYgGeUARUBo2pISImtjpzWmp2yrSX+YPlhXXL9K5mk2GsL9eBrlxefsZWuSLJaRW1gZYmE7ftuZWX7ugp2A2yYAYXjt+51ExjywO9KLGMQT5DWuUfnDWV6Y49ce1WwOHgJJKYE0oVrNN2otT0v6RatJ5uMeU3ZE2MF0T6iJqCJlbxjyjjgz7Z7vCgtucef8bs2REvXbms0QVeHpyzcFWcPxrD3S8mLaqnEZL/kD16yeoSl7O26BF/re5ytSt/UIesBOz3NnC/o49+YzIIKO/JB7Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39840400004)(366004)(396003)(346002)(451199021)(71200400001)(6506007)(122000001)(38100700002)(107886003)(2616005)(186003)(26005)(6512007)(2906002)(558084003)(5660300002)(41300700001)(8676002)(8936002)(44832011)(36756003)(110136005)(31696002)(478600001)(38070700005)(6486002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(4326008)(86362001)(91956017)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXFXM0dLbUZIREJabkIvcnRKeVUzTlhzVWJDd2xyK2RYRlNuMHhKWk5yUWt0?=
 =?utf-8?B?cS9iTEExUGZueVFrVlV6bzVDOXZ1MVc5ZzlURFAzaDlDbEwyOFJIbE1MM2pj?=
 =?utf-8?B?KzJlbS9EdUVZbDdrNlhyWmlTVk0yQmlWNVcwOTZFMjVJT2xsTFVkTWN3Q1pS?=
 =?utf-8?B?RHMvRlpBTWlCRmdUZW9Ud0VOUXVDSTZoOFkvd3FxNnlnaWxnL3UzMVA4MWt4?=
 =?utf-8?B?YkFETWV2WDN5U2JrVEpoWHBrc3l4c0FpWW52d0hZNU1JKzZJbnFvemtGMGZ0?=
 =?utf-8?B?dmtlTFJuZEZWbDRXSTNsME5IYmF0T2puWHlXNkNJMVN2cytRczYrTHArVmNS?=
 =?utf-8?B?M3RyUURZamFIV1d5Zy9ObnljaDJIT3V1Z1FZc3lIZDF3YVgwV0RaaUE4Kzd4?=
 =?utf-8?B?aWM0QWRXL2Q0bkVrbVlWM3V5Q2ZDQjA1akFKdFE0NURkNysvR0srekwxM3E3?=
 =?utf-8?B?ajlRV3VvR3ByeERBbmZNejlBME9vQXM5eWcrTGJ5WDJvTFRaaktVUDYwTjJW?=
 =?utf-8?B?SkFUZTR5NTBpU0pNdFBQaXhoQUxlQkhYS3hZaFZ2RlYxRW5UL21BdGltZWtL?=
 =?utf-8?B?WDBsLzhhQnh1Q3pxajFRRXRlcDUrajFVYW83TjFmbUxYOVIreUZEVTFNQ0tx?=
 =?utf-8?B?Ym9YTnArN2FXL1J4YVQzSlUrZDBDS3FsR3pBK1JIMWRoU1Znc3h0ckNFcHRV?=
 =?utf-8?B?UTBscjczbEpkM2pVcDBFdWZOZVp0YzBMNllWMEFwMGlQVkJyd0plSklkQW04?=
 =?utf-8?B?elBWTGUvVmZPdTRBdCtpSTV6R1pvZFJoSkJ4cHdiL1pCRHM5YjRPMFJNR2RH?=
 =?utf-8?B?UXVmK3NhYThPc0I0WDU5Zk04c29WdUJjaXIzVW16Y3NKRnRRMVBuQXd2bUI3?=
 =?utf-8?B?TjFLR0Fna1d6NjdmcjdvKzRwVGtKaVlYMlhkNzgwcERvaDVWa0t0dFJzSkFm?=
 =?utf-8?B?N2IxbXV0TExyVHl2eWVadW1vZXZUMDVpV25xdGtDUW53NFZRWkxvM1dOMUth?=
 =?utf-8?B?UU1mQlNRNEo4K2hCTUR5SEUxWHA0WG1iY0tlN3JZVTJhbVlkR2ozdEtJK1hw?=
 =?utf-8?B?Ym1lSDdhSWZ5TDVLcVBVbGx3dFFrbVIya3hXWEtuL0J2YWE2UXhYNkVJc3NW?=
 =?utf-8?B?UGNFaTRicVJRT2FiSk9kQlh6U2FCcVB2Q29teWtmYytMY1QySmttTFAyd0sw?=
 =?utf-8?B?VC83YzhyT0NGR2hVTEhsQW1PaGpMbXVtdU9walk5WkxKSTlHSVJGUk9HRmR0?=
 =?utf-8?B?R1ZiMDB0YWpJSXlpVEY2RUZvNGx6Q25Bdy9KQWhHOVI3cWxkbG5WVnNTMURW?=
 =?utf-8?B?ZlcweThGN1RYOVcxaU9aTkNucXRocUU1WXZHL3k0SGZSTFZDa1JBRjJpM0tB?=
 =?utf-8?B?SWl2ZFhtcEpQMU9HV09ralIzc1ZRcnRrTk0rbHhnNmEzTzBnd1JmOXRNZWhT?=
 =?utf-8?B?RVlFSU51dGRzK2RDYVRzMlFKL0xoaXFlWGtCeHRJWlpwMmdrRldkczBDem1l?=
 =?utf-8?B?RlFxMzVqT25JcEpaZXlCejM3NW9ZY0hJWjZ3Rmw2dnZRWGUxZmJsTGd6emhk?=
 =?utf-8?B?bjlQREhHRld4b05Qc1haeHVROXJkOFd6anVaU1RKelZ3bnZLUFRROUdxcklD?=
 =?utf-8?B?S3pQM0UxbG56U1VCLytOYWQwK0tqTjlIcFVGd0ZCbVY4NDNOcmdkWHNHVHRG?=
 =?utf-8?B?UVdPdVJWNDRrdTlRWGMwQVJKMGNNUUFkOE1DbUdyMmFtcXVJM3RiNEplMXM0?=
 =?utf-8?B?MlN2a09XMmpTTmRXRVlyckYrR0NmeWMvVmkwZWFBYjhheVhwKytvVUVmRkFT?=
 =?utf-8?B?WDl4R25wZUx3amRSbGhGeHBuWXhRRXNKUStMd2FUdmZDL2c2WjdGRmRZT2Jv?=
 =?utf-8?B?blNNZUFCSFhmRTNqSjFwN3orT2pMcXJjdS96cU5LaEhkN0lnNVhmZmdJazVD?=
 =?utf-8?B?dHhRZ295VGxqb3dzMGYybzZXdm50Umx5emNGcjNWZ1lJTEEraUUzSTdBRi9V?=
 =?utf-8?B?RGk3dHZNS29sTUxMMFdlRU9CN2ptY3hrTGt2ek9qL2l3UThyWnBGZnFEUTVC?=
 =?utf-8?B?dlRMZDlqT2Rpc2V5d2RCd2lHTEJoMFVPNCsvWW5kUWZSeEZLa1YveUdnWk0w?=
 =?utf-8?Q?S1jWtLw2GN4PeD0WTrtav1yHq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <283AA2F439EFBD4DABC05970A3A66AEF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ff6469-65a5-4ed6-7f24-08db545507bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2023 08:27:18.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hd6J/C5XnV/qfBzTRZS83lBBTXpbUC4OyHR14AMu8Imnn9FMSpiv+y/z/yuIH1SrH4nbmxkWqiSCNy18qMB3ntoPzRgo4SG5UhbxClJKD1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2116
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGksDQoNCkNvdWxkIHlvdSBwbGVhc2UgYXBwbHkgb24gdjQuMTQgY29tbWl0IDc4Yzg1NTgzNTQ3
OCAoInBlcmYgYmVuY2g6IFNoYXJlIA0Kc29tZSBnbG9iYWwgdmFyaWFibGVzIHRvIGZpeCBidWls
ZCB3aXRoIGdjYyAxMCIpIGZyb20gdjQuMTkuDQoNClVwc3RyZWFtIGNvbW1pdCBpcyBlNGQ5YjA0
Yjk3M2IgKCJwZXJmIGJlbmNoOiBTaGFyZSBzb21lIGdsb2JhbCANCnZhcmlhYmxlcyB0byBmaXgg
YnVpbGQgd2l0aCBnY2MgMTAiKQ0KDQpUaGFua3MNCkNocmlzdG9waGUNCg==
