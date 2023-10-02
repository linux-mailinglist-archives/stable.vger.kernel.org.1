Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED277B5AAE
	for <lists+stable@lfdr.de>; Mon,  2 Oct 2023 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjJBS7i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 2 Oct 2023 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbjJBS7h (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Oct 2023 14:59:37 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3B4C9;
        Mon,  2 Oct 2023 11:59:33 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392HD1JR025196;
        Mon, 2 Oct 2023 11:59:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=r/sFX5Ja9DFl+eceV1h39WmJYqsaBludY6CQGgUQxtI=;
 b=ubz4c95Ulr1163DqdrJxrpjlzIs84iR/HWsQM3RZTN1q/rIiiLMzowo8hNqwTDGd5W9P
 DPGquXDsaTIonrVUPxEa7nTFIvAm9q7F88Cm+Vu4m65z2CMlP5U8LRm4YnVtzZ3AOY2O
 g7zgKHOJDOcM1QrqNGu9V6ge+gRNxTJC9cviv1BRKa164x5znp0ROoJQo8ISKRh4rjmE
 girp7Bn2SFBrWdEHl3f0myLKQc5o9TWUN+64G63t+dFvpuRoBV5lBfp3dD0WOk3Y+vUO
 3Ulcz+ix7KETTC2tJkhsGVd81Ov1kgTaMqN/tPmR0lzfQ84ee45tqhpGX4CL0pLtnMX/ 0Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tejkvaequ-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 11:59:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1696273169; bh=r/sFX5Ja9DFl+eceV1h39WmJYqsaBludY6CQGgUQxtI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZkX4EFjqS6DDfYy9x3InU/KTxm5f9wLEanYIAx6jLJgxU5+Zd91ja+F4uQQWhd2bD
         Rw4/GKnvrK0HqRthsZuRvR5zayEHNw7QCiSb0QVSNQPX+ljFayByRTWhZecd3qqvUx
         T92y5pvKH9fWEEziBEryXI0lqmAKrqsn/IGt57GwzNwFJORXhH7bT8z6J8FEmC6eN6
         JinSzAj+A8EFVY5j7FixNqz1fBbvqk9QlGPz3aprv82PEnfGxLv/FBNEegxF7XHS08
         VoBPNgpR4nryY/VEuTigHqmVjD1R4ScPTJabPhXam98QYm/eN4fUQ37uhMdLAfGAT6
         6uaFUSFCipPGg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6F51D4035C;
        Mon,  2 Oct 2023 18:59:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4DFA1A0081;
        Mon,  2 Oct 2023 18:59:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=H0hKyDfj;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 58BD140356;
        Mon,  2 Oct 2023 18:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdD/gDhauRmsT2PWP1rvWqGSXXE+g/ZwHQ2np9LuUqRYXfuMextvDKygpBo9uei4QkyHnDrzcn+OCgPtveXrG8a2VhYqSuAeS1wPzMyocNwhPDTcLvZgCAqZM1i0RT6JwazVZoleYvqrk5Dqxz/letEwtiQV/MYfMT6cOUS8+wHObnnZ7nfMsXQQx9RGdS6NknuzQbIh+jYJzFuSjgkQ5y5Z0khfYcNj24iDNCJCEE2LS38BSzKYtRIXydx2kJU3qap+ZjiVhRInazxWe53WHbRbJa6nmF5BMWqbnZygou94adF5lgUcKsUYWpAghYjJQL/wnkA7rIQVC9mC3iC6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/sFX5Ja9DFl+eceV1h39WmJYqsaBludY6CQGgUQxtI=;
 b=FDTSaOtrBoNFlBksuiVwUkNAkRG5f9OPNNeRFwzP4O0gch/qVnWVwiXc6C9q0Xwcly6gFz6Khthhh2sGYCaRGtOtxYg3c8ESgvEN4hizqesXraQ9XqlVJbWdcdt376cYUYSbWp4aX59kULjVAEbp3WK85JtAlOXEhhLhnj4wx9h/lamV/eOd5aUtIsz1WatdoxHyrt1Lqono7CPi3aSJKSLovHoChEqgXCT/WTKNJRLfz3J2JnPeR1Q3XImYWLN7UaKyHXkPotZQ4KfOgLa5rhNs2OsgZAW2bEIT4yvkOFCFVvAHPwLmrH/fhJcB4cXKfmrzY2pXA4JKZwHSvd5o/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/sFX5Ja9DFl+eceV1h39WmJYqsaBludY6CQGgUQxtI=;
 b=H0hKyDfjDFqqcSUNJ87P+YMKDVwmjWndvyn/Q0/VzlnusHy6QnLczrg8h5gEWI4AdJzmIecSRaOPtsluqdXRyLhVUSi9QlhgxPw5+diXJrTGhtp7Dx5XN44epItAZJj5ziat+g9L3jEEke0IiX8seqFW1Vmu84hJyBMZYMtmIYA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 18:59:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 18:59:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Da Xue <da@libre.computer>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Soft reset phy on probe for host
Thread-Topic: [PATCH] usb: dwc3: Soft reset phy on probe for host
Thread-Index: AQHZ7Ij2zAc4H+lgAU+rGkvhHKkmPLA27AwA
Date:   Mon, 2 Oct 2023 18:59:22 +0000
Message-ID: <20231002185924.uepqjgw2llq66pwa@synopsys.com>
References: <CACqvRUbXK3gNXB5me0OvWy2qkyHU22JjBZaJ8Sxm=KJd8gzM-g@mail.gmail.com>
In-Reply-To: <CACqvRUbXK3gNXB5me0OvWy2qkyHU22JjBZaJ8Sxm=KJd8gzM-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5891:EE_
x-ms-office365-filtering-correlation-id: 2a502989-9bd2-45fe-4278-08dbc379b0b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lNt/4ZrRURQEodMCdNCVEFI7OsDB63SpCnBJFY/2iKbFnnP3pYv3nF7UXmPiR0UbURd6xjpSNTBXhh6lOcKDZ7HO5VJqiFlpU3zMgPV5hYhnXn9hIQEyTqgQ+jecMxqjwV8zyzaTTJqrDu0da850gt7lV67wJkSxun+Gto82y/hd1595G1nCFqVxYEF3x5FD5FRHjS2j0X/u/kk6yk6fAD6VQlSD+uZ9TcvP8RZLLtnOIYEeA+V7MpKY+P2sidHdz66GTB2c5Pyc+07mUEi1ki4y/bNg7zJd5O7ke7qb+97O3g+HuIJKfJuXJEGOFQADHr5QZ3RvXALac+yfgRPmppScq9KyhSZLhJvRUdasapPN6TDgQwwz4OHVF2K31YDFoL9zxNCc3YrL7p0ChR1KbHSAKcFIQSLkMuQY5hngKpHsma+lkcSSpGWeSEywSx72uT6iIriLacwXBNQ9gO1alLiRitrLKLA1/9WtrwFpeNaP71H7w7Yg62Jp2ME4ioXNa88p8C5nbgnlwE0NDnqQ7/yqcJzLzppyEgNcH681CvKAnaZXTormVk1gGLPPdAFTtncDFmJObkDEuRvFlr47i3f+lH4QKLmf495YTeDXAZ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(1076003)(66556008)(6486002)(6506007)(2616005)(122000001)(71200400001)(38100700002)(26005)(83380400001)(2906002)(8936002)(4326008)(8676002)(41300700001)(4744005)(478600001)(5660300002)(36756003)(54906003)(66946007)(66476007)(6512007)(66446008)(966005)(64756008)(38070700005)(6916009)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTIwMHk3VzE2RGd1MmVYOGZwd09YTlRDZVZCbC9FZDh5WEVHYWE0SFJvZzB6?=
 =?utf-8?B?dUZHUGI0Q0JhZ3JxL0tVNFdLaGhIN3l0MDhWZm02ZTFsbVBPcFdlYk5PdU94?=
 =?utf-8?B?S3BLL3hqVVhIK3FSd1VTTkVJbVgrbUlLaW0rMW9Yb056cVEvcG5zUnlqWWxl?=
 =?utf-8?B?cUtZdE8zbUd1bU16OWEzQnNXMWdyWEVXMWlpS2VQTHNJbzJjRUZGMklrL3ZB?=
 =?utf-8?B?cG83amVkYTBvLy9pQi9qVXhXQmJsTDlITWdmZ3pWVDdCY2Z2Rk8vV092cG5L?=
 =?utf-8?B?OENEcW5HWGVrYWFlMmlGMUN2NTJZMmd3S1I3QmlJVUhYWTNrcSswWUt0VnBM?=
 =?utf-8?B?QVF1R1hna3VCd0I4UTl3V0hXeGlidWZMR2F6b2FNUlVhZVRFMnpNeGxpMkt2?=
 =?utf-8?B?RWp5NUNCTUlkcytHSmRpQldQYyt2RURoVDNrc01abGltY2ZvRGtSL1lqcjhr?=
 =?utf-8?B?dzhYb0szMUZETE1DeklZSU9YSW5JQVc3TzFvc1FmL25qSWlYQklSMGJoOGRp?=
 =?utf-8?B?RUxQbkdIN1hBVTJwRC9yVWJXWTBzNUlERWxUemprQ0cvc0l2UGpaMzJRcGtX?=
 =?utf-8?B?TTcvWWtaUEY2cWZKUTJHQkxmZnY4eDJhOGRoT21KazNlVzA2ekk1TTNMckpI?=
 =?utf-8?B?SFBGZHlRTzB2K2tCK01oaDhmZG9nay9XMVZZbXZRQWNqZzBxU1hSMUFCVkE5?=
 =?utf-8?B?amV4UzFockVrY2dQQTllaCt3NFhJVkN0cjJJY29UMERCVDJmdGoyV1FqN1N3?=
 =?utf-8?B?TTQwUGFLTDZaYStvaElFSXk2elR0ejQyamhTbHIzblB0UXhQOWdlb2hKOThx?=
 =?utf-8?B?bkIwWWxPdzJWQ3pheEFUcEUxWUgrNG0wbXRZVGdjTXczZ2lmekxubUY1YzFN?=
 =?utf-8?B?SHFtdWVMRStqSEdEQzR6a0pCbXYySU0zWWd3bitHaDcrb09WK0R6OXBOQlVx?=
 =?utf-8?B?UUthdTNxblMzaWdrUUJndTZLY2lqc3M5SHl2TzlvWDd2d3VFc1J6c2RXRkZz?=
 =?utf-8?B?UDZWNXlsS2JycjdBWERUeHFxeFZsSHJjVVdvZGpRYloxdm1BWVJ3UmtPUTJN?=
 =?utf-8?B?bVlMbjVJWHR3b2FNNkJiRVkxVmptSzBjaWJ6c3REVXN2UDdFS2ZlUkgwd1ha?=
 =?utf-8?B?QTFYY2FHR3hxZjBFblVIeTk3UUdZUk5vUlB3eVJYam5haENZTDFXaTdMM0dX?=
 =?utf-8?B?MSt4TExmeE9jOXhJdXRFalo0QkE2cmNIdW5uK3FocldoSGp1bDZPRStiUlRU?=
 =?utf-8?B?TlhPK2ZmOWs5TFZQemNuOWI5eldvanZXM1h4ZzdSa0ltTUlVczNCVHBQTUdI?=
 =?utf-8?B?QmxxN0F1aVp1a0E4K3AzUFI2NGxlQ1gzbUd3em5qV2VVd0JZMmhhalErVHBh?=
 =?utf-8?B?Nit3dUtxZE04SHFJWmpoejJkaVRXVFpwQWNIeXpXTWJUd0N4UTlLNTl0VHF2?=
 =?utf-8?B?czlER2NGTHNLOGkzQStoeEVMWFhKSEVHK1Z5MUp3dzNrWDQrUWUxV3ZiOUhv?=
 =?utf-8?B?WnZ2U0s0L0ZvRDB1eFFwV2U1aVdna0o4VmZpQ05nR3lyRDRsVEJOVGg2Tno3?=
 =?utf-8?B?TFI0Nm1DejMySzZ3aWF0U3VpVkJ4Q2x4YmM2dkpUT2FvODljdVA1QVU5OGps?=
 =?utf-8?B?SVlFYnR0TFR1SnBMMW5xOE1uZVMzK1Rzd04yNFZCK1FLSVNjdndoZWlmc1RS?=
 =?utf-8?B?MDNwR3h5RkpnazdZRzgwUjEySkJtZjRmMVRWMmE4c0t5amYzZ2ZqKzl0dUtI?=
 =?utf-8?B?dUVZQ25odWU1RWU2U3VsQVFvQzI3VDF5K3QzWEFsNjYxZzVvU0hvUjhaZTdq?=
 =?utf-8?B?K3J5UHIrYitWUmFPZ2l5ZDVYTnAxaW9pRUNxMG1zN1RObDZSNGRzVXY2SFNK?=
 =?utf-8?B?UU56SkRtekJPSVJ6N3JMWDRHMnpwMDBFeTRYM2JBK1cvVWhNUk1LTGdYS1Jl?=
 =?utf-8?B?Yy9pSFZVMTdXVUdWNUJ0TmpEOWJzSWZJSmhUMXl1aG1EVjRCSEsrcStxblBC?=
 =?utf-8?B?SkdMYzdhTklBYmNnT1YyVTU3MmFTREI1V3VkdXJSOFF0UENtOU9IeVNqQ0ZN?=
 =?utf-8?B?a044NzYya2tlTGRnSHRQb05RUy8yUjNRZWJqU1JPVFpwS1NEMlNrMkVzWG16?=
 =?utf-8?B?a0VMcVBEenN3YlhibDNpT05mRVJ3ZnQ5Rlpzb3pFclpKU0JDMU5SVGRWa05T?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446AC0753095C841B90BDB3278378A39@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JKiFLaW2pjIGGBr3XNTNvC5ZRLxPERxv38m1pftmA1cCbcSOgD2QHTwGm0GsrGoLM6JDfLipYij92M0E5WBHHyoECXlb8zBKErXpCg3XMoQgpTgFFhYOB9ONwJH/bO/Cq2KD7qE5IY5JnIiqZ586pxc1te9pUUhetDZ6jSAJoPD/o+K/7rcgXBuQXnPcG5fT3y4sRlxs0FSjfmfd161bj/RTFmt4xPa1i7Ocre5LzVoWOJVSi6a52OmNQDaVJf4N/DfqbBt9Ff9AkUvqXIplv/jqrw2cchWfdFVF1BMjgsq8EkTveQ8cr4cwLFxY+dQPQWsoEb/9+nXSh45SX6sg/8fsWFKuVRsmNl7o+DKmiQ3F0ca6svt+r+sbkqEHFzwj5fHytYEn8xk9lXfn9HmxXcexyw7rSCmLkc2F3pjo35JLD0OuEWcPnMb+3W3ADgWpOeeN5jexJY0Mx6p0n8ufBFuyGMdzqiMldPVHx5KATMEDse3TSXXCBgJYbr0sMIjV3lmhoLjZTSSptqlgun6KRpY3Pp9PxlTAhvfrL7tyfZKoKK99lu8c3IWcY+C5I+oFbNhVGWv7i05nWM05KUAoqg196knhNGN40dW8R63HctiC5Yg0s96Ku9zbBICpue5/DeoqSY4Lrj73dzNKGMDTxVFspGQOK5DbhHkkaq+4yFOofgnbowqEDwAEhxer4e47iD0svn+QyWkpOM/YWusyxvsNBqhjaQu2gI8l2tSfz6kkhaYNF55lGrRd6On6vVXEXcGRw5Yp3Igzd3WIGB2uzSORgu7Oxv3U6e9TKiztUK9fcPUAGSGSn9gcyT2F91WPi/c1rohBg4cuobeDY0GT4ZxoX5Mi/FCtrze8mt2Q45MrTcYxWo0YUgxmYgpmiAMPZYMCXk4TEFDnMMgyR6K1Zg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a502989-9bd2-45fe-4278-08dbc379b0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 18:59:22.6011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUsekmRCsoNht1NtIXkKuEjgiNz4qVgwvF/k0S8Q03/QtcsjjDna/Qsb1lKMKadCv8nj+NIWDLksI0R9wX9H4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
X-Proofpoint-ORIG-GUID: G-83iDs1B6Laf23m34vdkalS-j9FgWQS
X-Proofpoint-GUID: G-83iDs1B6Laf23m34vdkalS-j9FgWQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=629 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGkgRGEsDQoNCk9uIFRodSwgU2VwIDIxLCAyMDIzLCBEYSBYdWUgd3JvdGU6DQo+IEhpIFRoaW5o
LA0KPiANCj4gSSBjYW4gY29uZmlybSB5b3VyIHBhdGNoIGZpeGVkIHRoZSBpc3N1ZSBvbiBSSzMz
OTkgd2hlbiBJIHdhcyBydW5uaW5nDQo+IG9uIExpbnV4IDYuMS41NC4NCj4gDQo+IEknbSBub3Qg
b24gdGhlIE1MIGZvciB0aGlzIHNvIEknbSBzb3JyeSBpZiB0aGlzIGVtYWlsIGNhdXNlcyBhbnkg
aXNzdWUNCj4gYXMgSSdtIG5vdCBzdXJlIGhvdyB0byByZXBseSB0byBhIHRocmVhZCBmcm9tIGEg
TUwgSSBhbSBub3Qgb24uDQo+IA0KDQpUaGFua3MgZm9yIGNvbmZpcm1hdGlvbi4gR3JlZyBqdXN0
IHJlY2VudGx5IHBpY2tlZCB1cCB0aGlzIHBhdGNoIGluIGhpcw0KdXNiLWxpbnVzIGJyYW5jaFsq
XS4gSXQgc2hvdWxkIGdvIG91dCB0byBtYWlubGluZSBhdCBzb21lIHBvaW50Lg0KDQpUaGFua3Ms
DQpUaGluaA0KDQpbKl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvZ3JlZ2toL3VzYi5naXQvY29tbWl0Lz9oPXVzYi1saW51cyZpZD04YmVhMTQ3ZGZkZjgy
M2VhYThkM2JhZWNjYzdhZWIwNDFiNDE5NDRi
