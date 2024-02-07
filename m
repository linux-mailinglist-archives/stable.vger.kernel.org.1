Return-Path: <stable+bounces-19077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404484CD92
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 16:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E2B2340A
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741ED7E77F;
	Wed,  7 Feb 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OdeUE72H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pN9lX5M9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF465823C;
	Wed,  7 Feb 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318160; cv=fail; b=dHZp1Uh7F06xQr2490keCWKZzyCB8BExeuBW4k5W8FhqnKdRe8k27v57p/MM0vVQOMH28lGyPXtDYYfld60LR+SaiWzq8GmJG0DtwOiqVnYYUKOMA3o15aqRGmrE1Dx+DUXzkL1s014Q6wysC4O96HXoySNCQhLHeQ4IprIC+W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318160; c=relaxed/simple;
	bh=EaIImOwUk5IFkCAPfa8zZVpzxf3Ezb625U+GimLBX0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N6551JGGNZM0zI0Bj/0gRYBZY+LZb0AJf0q59yA5eSt0/hTs+JA3F0Pu0tiItOykIehnN+BDiWGp5cUYwk5djueZLarrh4EeVV/jBZsyfHSXnTMM3UtLFGT5sS0Qp7TFXMSTtogl7IBO4DMirpL7j9MnJ0QZMeNX9A2RENPHnpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OdeUE72H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pN9lX5M9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417Ep6W3019157;
	Wed, 7 Feb 2024 15:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BSr74XuNNbMEFV27mvOzigrg2dnpTmUYJcN1zpyHSrs=;
 b=OdeUE72HMkjnPHUmzwODZbK3ahi96D6rI1kJxcp5vAN4HTtuIFqvw76JQL2QilRoVApw
 gmFLRPmayAD7zPLNTsUD2QhchG4pQ8jLw3CtE7URO6qljZDp1JE+LYUkPeptBblHTAjf
 yZPEncUENtA8Lzaw5ELzwSEeZ63heUVJmHVqjva8Tr70/JWQstKFbhrJyXW9L/wm72HU
 Dzai+LUZi9/yWtiKpXyV1zClk35WmRWKuYlKSsOQT6uzQ3dx4p+eUhFuqOdRUecFdDO6
 Wny+qQafmmJfgeQUwuJ4/62/2U5SZPI9xsHxsPDv4dQvh+lUIsPOZpIccClWb7WbCl/+ vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd202q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 15:02:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417EG1i9036833;
	Wed, 7 Feb 2024 15:02:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx94bb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 15:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6IEWRAdTyQTxeItP0U5igX91XhG0gM4TCsCyeisEcNdWXPrOFHkqQG3czc8EpIGga36BIe7kTB0M2oYjA7p6wCjaRTQ/DcNnKZX0YAlDNIaPziUDm+lHvveeeCfs/h0r3oz9HrQ7T9le9E9AHBiu7cNsDXkqtfjk5kaODi9Wa04ZOMUFyNnAdBn/aHMADQRKH4gnpu1D1zzgGbu64f7Q5w6TkL6y0ex/Zwfu4DB5CKmGt0z+rH9GpaaiutGHAn47pnAeTtmnWrv2P5sVR44mrXDzp3EUY6ab6i4v1CKT15M93ubnEFQX7oLnjgM46vnG5HVarK1GSJajeoihxdtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSr74XuNNbMEFV27mvOzigrg2dnpTmUYJcN1zpyHSrs=;
 b=YwHO2G839KZHEigszOkOLlLGwYi2OmcuBUuJJ24HSmQ8/p9oiJBFLkLM2zgp7Wl0R4d25pJSCUgxDPbjfI1r03fSLgeTxi1u9PTZdCE7oXtDLlXuzMjq/B/GnEJM3vE/npV/lw/of6Wu9gxa6xls26onZPiNOKiV0eFUiLkmtViKyTPzAAsGUSt/9o6ynaLwvem2r5AayxhNXfHrYWzYVuq5p60TwohcgjL3PyEJNc9wcmxfjpEAoEdvB6t40+Q+WxMnDCRhvmSV3LNyzEyn4tjG3txl/WcyLBAhfI+zL7tzNjYllrouzs9udTc8dEOGlIMSsPLUxfMEMIN3KJgAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSr74XuNNbMEFV27mvOzigrg2dnpTmUYJcN1zpyHSrs=;
 b=pN9lX5M9x+aq16ukqrs/lFI0LyMpt/M260vvvggszKvb93LUyHObCKc47I/Foj3a/2hTMWiOKH7o1DA2LJKz776nyDIwL/Z/4MARVfSWqvVPHNSQXUUPRT5UspgPiuQ0mHPO64jPOaYTZX1Er2PEE6Dlf4H/saRMAmSgS/LMg5w=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 15:02:13 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 15:02:12 +0000
Message-ID: <5e316709-61d1-4c6f-a000-c45d7f9fdd31@oracle.com>
Date: Wed, 7 Feb 2024 16:02:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] docs: kernel_feat.py: fix build error for missing
 files
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        Justin Forbes <jforbes@fedoraproject.org>,
        Salvatore Bonaccorso <carnil@debian.org>, stable@vger.kernel.org
References: <20240205175133.774271-1-vegard.nossum@oracle.com>
 <20240205175133.774271-2-vegard.nossum@oracle.com>
 <8734u5p5le.fsf@meer.lwn.net>
 <bb4493e2-91bb-4238-ab77-b38b16cd2a57@oracle.com>
 <87ttmknxny.fsf@meer.lwn.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <87ttmknxny.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0397.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::29) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SJ0PR10MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b662630-e7c9-426c-dcc1-08dc27edc3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KVomxpqXdOwHUnlzSt8M7Tn4HHpiU1TJzPyNXqyvoktsZRJpgQONFnue4HrFP5EqNj4uTGnYRcVlrF40VSo0jdj3RRDM/sLuIm47QhwfjmxnRxYKE5TJyXhtgC7zhjuHb4JsZTyG7LPj6gM5wc+pCPODTfeTdgNS5YD49EpePzvqiPmGfKBFe0cISFAuZTs8h/Izv6I5BvpRrI5Q1/XWEDPXpoYbN4fvNxgxEiCtCRv4KA7L+KDo0VgIft2FbheeOw3QBOaQEg8TJdheMv8itVzy1x/YI7FFBM1MRbi3P5XLUaUWk85pAoSk7JLDywhjuvkZmXKaDEQMq8d2HqJJbOMXMMe04mE08PvBhwjCDzB3ewtsF6oL4vzIR3zz+1TsGDb9W9mFVQRV1UBocWcH3zUv3pjKJlE5+d118FEvkCc2qc/pn8lhFbGOxFLheHSOcwZ1EJvovkTh1gEeyJ4mbc3xZ1rVVBv20AlOKY+KP9DGiDvgWCAwHTSu7lo8/CZ63oS6CQhkHgri450EaodxBzOtOtyHRjbtCjLqafmI5IlU6rSeg31SUDJuRqcVMJ9gszHUWW4kxE1ZW9BgyKszC0To5GiZPEljuzkcfpPeT8t1XE+vfS23aFJlX5nXdwDY2GuYvSBi5lOpyMGXtxjtbg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(2906002)(38100700002)(41300700001)(66556008)(26005)(6916009)(54906003)(66476007)(316002)(44832011)(31696002)(4326008)(66946007)(8936002)(8676002)(86362001)(6512007)(6506007)(2616005)(53546011)(5660300002)(6666004)(6486002)(36756003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlJ3OWp0dVFJR29mTm5IRFQrT2pvTFpvcnBUS2x1NmN2WWNtT2RHQVdEVndy?=
 =?utf-8?B?VS8vWUR6OHAvQ1BtWEdUMVpqWVRJd0cyNnhzU2ExM2M0UlRzdjVPOUcxdmlO?=
 =?utf-8?B?RUpzY3JEaUZsOC9GWE4wOWpmVTJYV1Jac2hwUVVUZDJDQnk5TktmdEJ1R0sw?=
 =?utf-8?B?WkNudnhKNm5CYVBkZk9KcmJwbmt6VU14Z0tjcTZMSUR3ZTgxT01mbWs3emF3?=
 =?utf-8?B?ZFJURDZhTWZXMmJybkxmY25PcVBRNUtiOHFLMkh4VFJvdjVSYjF5c0xzRzhQ?=
 =?utf-8?B?MSs5c0lvdmhZWXRQTE1kWlFtK0xydmk5REJ0WEZ2K2VsZzdPRndyS1lMeEdM?=
 =?utf-8?B?bkJ6MmNId2dpN2NxQTgxM2dCZG5nTUF1Y3FZb2daejhnOVk2NmxwUXRxc1Fo?=
 =?utf-8?B?b3JOOG40aUxjaFI2UGtPYlJMVURtNDVzdjBtVGJWTlpnb0IxbkxkZ2YxeWxT?=
 =?utf-8?B?RE9YL0NxZEdOWk8xd29Sd1dLRUVKbEZ3SGpCQmhXQjJXOTRBV0RJTU0vV1JZ?=
 =?utf-8?B?MDJhdnI2TWhEZ0FYcDc4YVVlUy82S1ZDaDR4WXJxRGk2eHpyT0xCTC9adllx?=
 =?utf-8?B?ak1NZTVlSmUvb085cE5TT3FEaENEcXREQzlOWVFjQk9tcmxITForMkdxUnJE?=
 =?utf-8?B?SE9rSVhaSm5uSUlhWTZXelNRUjh6bHYrV0c0VXg0YUprOHpyak5IMG0zUkcy?=
 =?utf-8?B?TEVlb0pLY2ZPT1Zwcjcyc1Q1d3JIUGQxQVRiZlFtblJLekkrTWtnbW11V2k2?=
 =?utf-8?B?WHZWOTRIclZQSUxjNWU4eGtWN3BaWHdWZzdiQlM2dzNBR3dSSXRnc0hrYW1X?=
 =?utf-8?B?TFlhS3Zyb21TbXlxdFMvVC9FbTlwTEtYZG9LNTFBUTZobVByWkhWMTF4M2Nw?=
 =?utf-8?B?akNiSmdqbnhNWHVtMUVOMVk2clBLZ0FwUlllUXpRTTdCWU5lQlhteis2bmhh?=
 =?utf-8?B?ZjEzZmVpeldGZXVCT0ZPcmN3SktjbS9UT1pKZldoME96aml4WWJQMFV3dzB2?=
 =?utf-8?B?bUZ6YWZKQkwzTVAwUU9zcHpMWTI5WjJOM3dmcmtGUmd6WEVTc0VIT3Z6alJN?=
 =?utf-8?B?c2RQcE5KOHZNOTZDVjFoSkhYM3VCQnlESE95OXJoMWJjMUo0K0NLRmJ3SHRh?=
 =?utf-8?B?S1lKbFFDUjcvV29yOHlJc1JYN3FpbTNsVVNLeWlUNWZJTGtaQzFkK2F5V2VU?=
 =?utf-8?B?d0kyL1FvVFRkOXhiN2xvRlVlRGZjTitWUUNzd0tDeVNIbHp2UTZ4OUpCRHdO?=
 =?utf-8?B?YjRtT280cVNYcUQzYkE4TXVLNjZWeUVYckVZVlVkVVZzSnd5WmRSTHZoOUhh?=
 =?utf-8?B?QStiNDJDTzdoNjVlbU1SUHJhZGNJMFphTjdqcTRQWks5V2RzRVFFZ3dKdmZP?=
 =?utf-8?B?Z29DSUVJRTVyQmJxamxVUnI4TU9oVmJ4K0lLb3l2YjJQbDltM1h6K1R2VHZJ?=
 =?utf-8?B?WWp3eDZJbVo4azhPMlZRNTVxeVByK1B4bEZKczAxc0lNYUR0UWtUNUt5NGF1?=
 =?utf-8?B?Tit4VkhlZURUMVdMQVluQXRxRml6Tjh0cllzUjhVZjFYSWhPK3h4QUpCdUZE?=
 =?utf-8?B?ZXFjcnVaTHhLS1c4U0wxd0ZoMDh1UTRmNXpYMXIzNjNOUVB5MHJDNUp4VGtO?=
 =?utf-8?B?RTN6YTBWWVFBYkYyN0dqRzJOUjg2RzhjSFdTb1RGR3ZEYzFMZVBYUGZ6VUpF?=
 =?utf-8?B?SFBpYzM5RHlZaWNiQmE4aVhQbGtJRlEvZExWY2xaeG1wUVA0VmRvN1pkWUc4?=
 =?utf-8?B?OUpvdDk1Ky9JUmtCY2ExTDFUcVcxbnR3N3ZZTSs0RXR1R1JwcTFvZ2hsbGpC?=
 =?utf-8?B?MVczTlhQZWZYVWMzaE8rZ1Jpb0FmdmU3ZFVBT0tPdDNXUEpKZE5CTzI2RUNQ?=
 =?utf-8?B?K2M1MTU1OVBpbkd6bWtOMi9OSDQ3NnNmR3NGczF2OENsdDV4Y0dpUDhxSWRK?=
 =?utf-8?B?bmtMU3M4c09EU215ZjZrS2k4SzJ1NGRTeEpOeDlzeFRpRHprd016ZWVkeE9u?=
 =?utf-8?B?M2IxOHhEU2FnMGY0V0NrVDFsM3N5NlovMUxQUmpPZU5LdkdFeWNCMmdlTTRD?=
 =?utf-8?B?WllzZ29KS00vMGE1N3lRVUhlSEdKYUtHSHowNlBuRVFtckw0VmIya3h2anF0?=
 =?utf-8?B?NG9DU3Nzak1EcW5FalNXNXN3QVZZZnJya21GVlpIM3Jxa1dpWHI1Sm1PYUYv?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O1knHnHuJ+Fxx/VyR2s8FuJroQiUxc1XRZvibK6M0HaOPBCwJ9/eA76rrulR1wo3yERRrqybF3GE+l0rv7hVgJkq/C1lS7oUpHLk3Pn5M+rOitY2RHV6r8ydlnVbmmYSxLfDxcWseox4OO5WGHAL1dAQChSCa/AZlgLoa7E8pnkE/rYJoELhTKPNS8sn7MRwMazCoRyglyS/bvV1fbnPFoHyAgiRxTIfZBNQ4t52Pd23ojpUy3/LWAsdWvm5bcUK8pboKedVGpOyBq9xLf+arL4q1jhFSm+anMpdQWsNrNXaxe4PZR2Bv3mNlX3lpfrxeZXzJTK4eQEtl6GsLI6Xjsbg+II5pE0nLRFrVxPpxBXVQvYZnE7VSCdNKYU3vaWzt8+cBiUvRdRAhAeO9JOFJeUr8ofYtBbpX1kbpqGbZwR2yO3wgAeb6+gSJ3kzcJwr+nMf/e6uVGZbJdDH6opRMG+Tj/mDg83Mm/vwlby6Zk9YRBkuLnqSuC1/3FoNa5gZA9RuUj1YFB+gNFtfW1Sbu/xKnttTdi0LJet6CmRl2lJiPGoMSNov11Trk1x8xalKp3R0YoEonk4Z84lYwDE1T0hVH1vM34qVCAM8JLDLGMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b662630-e7c9-426c-dcc1-08dc27edc3db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 15:02:12.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouDwTLe2Io6QxADAZ9ES81yj7UT5qzfMpEeScQ0oghx8w72saZ3XRlyJSNGavwfG0BOpLWRL2Xt0iD7/IqqSxof+zej4+sNqfbOPSduQXwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070111
X-Proofpoint-GUID: 9eJfpd2ypqGH1ehYNyqIu9SwBvXjs5Bs
X-Proofpoint-ORIG-GUID: 9eJfpd2ypqGH1ehYNyqIu9SwBvXjs5Bs

On 07/02/2024 15:42, Jonathan Corbet wrote:
> Vegard Nossum <vegard.nossum@oracle.com> writes:
> 
>> On 06/02/2024 23:53, Jonathan Corbet wrote:
>>> Vegard Nossum <vegard.nossum@oracle.com> writes:
>>>> @@ -109,7 +109,7 @@ class KernelFeat(Directive):
>>>>                else:
>>>>                    out_lines += line + "\n"
>>>>    
>>>> -        nodeList = self.nestedParse(out_lines, fname)
>>>> +        nodeList = self.nestedParse(out_lines, self.arguments[0])
>>>>            return nodeList
>>>
>>> So I can certainly track this through to 6.8, but I feel like I'm
>>> missing something:
>>>
>>>    - If we have never seen a ".. FILE" line, then (as the changelog notes)
>>>      no files were found to extract feature information from.  In that
>>>      case, why make the self.nestedParse() call at all?  Why not just
>>>      return rather than making a useless call with a random name?
>>>
>>> What am I overlooking?
>>
>> Even if we skip the call in the error/empty case, we still need to pass
>> a sensible value here in the other cases -- this value is the file that
>> will be attributed by Sphinx if there is e.g. a reST syntax error in any
>> of the feature files. 'fname' here is basically the last file that
>> happened to be read by get_feat.pl, which is more misleading than
>> self.arguments[0] IMHO.
> 
> The purpose is to point the finger at the file that actually contained
> the error; are you saying that this isn't working?

For kernel_feat.py: correct, it never did that.

See my longer explanation here:

<https://lore.kernel.org/all/d46018a3-3259-4565-9a25-f9b695519f81@oracle.com/>


Vegard

