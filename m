Return-Path: <stable+bounces-93741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C19D0645
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6077F1F21558
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D21DDA33;
	Sun, 17 Nov 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r40ZfYGY"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605E1DDC27
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878843; cv=fail; b=TETA9+PqGmLaMMlwBov18yYWS/ZkgW4whLIcAVmT15OX/KGWxtNhAe8365t7FkvCQ3ucAr2LtVgLSgU5DlbGf+21rnufArHdc1w1qeEFBcGH7jXPSboWlQ3rrFE7HTnK4+lFJ6i8aqYA/izdEytdk3MxNQluqokcFKzgUqA/E4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878843; c=relaxed/simple;
	bh=gQ7WPArlFYhAGVm173CFuiimMERcWhDKz1oJHa5m5ms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2J0g7yhy5wFkKfqv8h3dDl7FE0tUGxSDPA/XSoHJGeFR2aDDyxvtKNJud2brDSZIAN9htcgpa5zra47Dms+MSgNtAVsPF6C8dwixUnlDFxO7Foktervk5zSkM5PKe/mLsHi/MhluHdVT9Znwlwp18I57lB3NddeWoJGhy6sHv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r40ZfYGY; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr7ujG5Ozv/GUSmzcsKZQaT5CEdUDUQ6RxyjgeV8jWFip4nB0BjZ45Fa/5k4CWvtiu0pX2Tu0GRoW3X2CMLkl1PfE5fbF94JLJrW277qFFRWhFsez1kdJdjphW58ZsSGNijWvEWH5lAURxXjzgJXQkIoKJgTozXxm1bYZn7cb/BMNXd1i/KooS7xx9cw2RV4RNQmDigPS4td9NeiSKFPYJYd12J+tClkTUQpqkP8uBKnkZE7FuRG71fE6UKeNSirbBLC6N1bkgZEPx+b5+6LrEdGWorbZoQZVfSAqTtqTccoKu34MOT3/gpsZjBbH3ywpieBSLtBF1oNNvDDHBr8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RttGBnwEA+Nu9DaeyHDYo8Ox3Edx5xjoxO8QQY0yjME=;
 b=yvLDDYfmHIOGIjAN5cCkvEXAqrR4Hc3rrgKiX+1cBPGXXjNYTF3hjwP2VL79RyAwuGn+73iFLHRX9XOFjtjeUBTsI4O9pP9ukHX87O7PWrp6CE87wT3wkih+974vfWHu04QxvMkaNFMFHedX/GSq1XBOnLp8BI7ptnKHdEJ21SMWJCLw0WWLEOn5uv+82ekh7hhSHqAeOUjkUZbXtBk3N/Q+l4UY9kxoLvn0WhhngBgTdqoWXwd60Jlrc+a9KoV72Hq8lk+sEl7fmEkV9fENiFILB8IZjwiET341IHT+E7p/zUW1gPiE3oHMVSp/Uo+Wyic0ShVDtdV0gEnTrduN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RttGBnwEA+Nu9DaeyHDYo8Ox3Edx5xjoxO8QQY0yjME=;
 b=r40ZfYGY9G0cVoCb2zbZzcADvefTh/u4DE3UmL8lttm3mvPD+//bOT3Ef1yWfOeX1aRWIlCYCRtCmtuYjQT9s8IXry8Zfbaq64H7toWx1crp0tmt9u68nyCTFyZbjM/npzr6FvS5THlRd4kp+OTWiI/AoZX7zq86wcDhWFcMMlu5NjlWaikdOLdaaMTuBqgaTaPX7PFcDs5u070mnqllmeBvdc+4BBMfj5YHyxOfDn30xE8x84CoYhBZW8uT7J1Qo4bajAF2x3Vh9NbJyQO3k1PrjpRRottLRK5P8rulC9bby6Disvii8DyTZvZ17bAqdrq4OVO4ShtelzCiGbiItg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sun, 17 Nov
 2024 21:27:18 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8158.023; Sun, 17 Nov 2024
 21:27:18 +0000
Message-ID: <406112aa-1909-4075-9e90-ed59cb7b1660@nvidia.com>
Date: Sun, 17 Nov 2024 13:27:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mm/gup: avoid an unnecessary allocation
 call for" failed to apply to 6.11-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: airlied@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
 daniel.vetter@ffwll.ch, david@redhat.com, dongwon.kim@intel.com,
 hch@infradead.org, hughd@google.com, jgg@nvidia.com,
 junxiao.chang@intel.com, kraxel@redhat.com, osalvador@suse.de,
 peterx@redhat.com, stable@vger.kernel.org, vivek.kasireddy@intel.com,
 willy@infradead.org
References: <2024111754-stamina-flyer-1e05@gregkh>
 <b79ed291-ad60-4be7-a2c2-19fedfde74c7@nvidia.com>
 <2024111722-humped-untamed-d299@gregkh>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2024111722-humped-untamed-d299@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 186cf76a-2d04-481b-f9c9-08dd074e9cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajlqOFJiOW1uN2Y4S3FwNEpJeVE4N0FTYjR3K2ZKUUJRN25RNC9Kc0gyZjZr?=
 =?utf-8?B?L2kzYlZkNTdscFNScGUrSTVaYmVzTEJpVFI1amh5ZnFUTEhJK3FYRktmd0Vy?=
 =?utf-8?B?anlna2FqNVVYa0NLQnl4Y25BQlBWalBXV2pvYUxES2dwZERUNm5odzc2dUFM?=
 =?utf-8?B?S01BeGtKWFlFUFdTRXg4SGVPeEp0V3NuQ0poU0RPTmNORzBoQmY1K2xPdW5R?=
 =?utf-8?B?Z1d0dUxpWTUzT2dVVG9RQVNRODZ6TVhZM29GR1IrUEtrcUdNNkNEZ1VyK2ls?=
 =?utf-8?B?VDA0TTlCMStrejdsNkdjSDQzU0diZ1hhWHQ5THlKTytwWDZWczd5R1BRUzdr?=
 =?utf-8?B?Z0hidnpvK2VwaWp1UlJneXFxUFNnbGIwMWlMelh3cmtEajNxMHBmWitDS3Bt?=
 =?utf-8?B?bno2TWdVSjB1ZzhweTZFcitMVnVzNEJOd0tPVlRweEUxajBtdmJpVzdzS2FL?=
 =?utf-8?B?VVhtVHN2RVBTZGtaem5qU1JiRzBENUZvakZIMDlscGRtL2dOUjdPcWhJVE93?=
 =?utf-8?B?SmZpOUlzTlloZFJ0YnVhRktlZkM1NkplUGQvZmtNRnVyd2JxSDJpYlMyMW54?=
 =?utf-8?B?RWVZWHA0L3BKdXAreUs0NHNaenJFUXdKMVBpOUQ3L2lkNXNQKzBZOTdZZ2hu?=
 =?utf-8?B?WDEyYVN0VlllQ1pybnNORGlSdUcwdmtuVlBMT3hqVWV3dTJMeXBVOVB4TE0r?=
 =?utf-8?B?WDM0bHpYdlE0a29wYSs3b1p1cWRCQ0YrQm9NL2RlZHloc0twZ3JUdko1UFNi?=
 =?utf-8?B?ellDVlhkZjUvNjlWMlN1amtUWmNTcGJDajZmVnUySG50TDg3b0Z6MlE3T3Ji?=
 =?utf-8?B?K3l4TWlnNHVvMXNKb1NHMmVUc3diOGR4UGx5MlVCaHdNVXVvSXlxdDh6c2ZK?=
 =?utf-8?B?UU1tQmdZL096cms4dXBzbEZtbDFER3FuVC96dkFxTDlvTHdielVQeWFQaFUv?=
 =?utf-8?B?Lyt6MENURDRwZkF4UUo4Ujd1cXhqbTBoY2dYVXRmaGZvMzg0YmZvcmdJSnhk?=
 =?utf-8?B?ckcwSWVKMlNCYzEzNXdFa0xhNnNLWURzSXF1ZVBlYWdGZ0tGMUQzWUJidGJ2?=
 =?utf-8?B?WHd2NHRuUS9xT3lQS2VMTkdMYk9QbmZKQWE2U1RVV3NYZ2srVHRNaWdOYUw2?=
 =?utf-8?B?bGZZNS8yRjZ3Q2tJcG1ZZHRYekx6elJvMDB1b01YVnRrMVZWSmEvT0toalo2?=
 =?utf-8?B?QnQ3VmIvcXZrYmI2T1Y3KzdSYXE0NzBiRmNjblk3aWZJQTdCaWV1VkFoQlpv?=
 =?utf-8?B?L1hQd29wZGFKQzV4WXpZOUxHNUN4WWw3Y3RXcW5hdWtESHBpbWRsbFpsb01T?=
 =?utf-8?B?UFhOTkg2VFVQVDlFQWN6clV3dVEwT0dFeEk4V0laMW95aisvTkh4c2JxZVR5?=
 =?utf-8?B?citKdy9JNmVLOTNxdGl5eGFnZmtZK2F3cjVpVnZudGtTYkR5MzhTV2RHWk9h?=
 =?utf-8?B?U0NVZTJQYk43bVVjdHg2aDdaNGdLRWxjYVE5L2pBcFRHNUxFeU5zNnJOWGpP?=
 =?utf-8?B?bFhZbmpGclNEZGFSSVluWTg4RlZZazkvNUp0ZXhKajJrb1N6U003NmcyVU1r?=
 =?utf-8?B?djBBSUIwb01uRXlrMXBzTkVJUWpwSWNUWVhObXovRG9vZmx0b3BScmg4S2VV?=
 =?utf-8?B?SlRWMGlLNnRCbDFoTkhmMzRGUVdSd3ZpV1kxZ1pnUExrbndDaVdNdUZsZlBi?=
 =?utf-8?B?R0M4MUUvRDl3NHoxTFkzRnE2WGVBMUZvTzlJYUNkVXk0OUcxa1FMVXJmRDlC?=
 =?utf-8?Q?rLqF+wVrUle8zvUacP+JF8ErHj53N02dYQVbjGm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZsL0o5M0tJQ3FOWWJveWNRcFk1elNSM0xoNy9acjkvRXcvTHFRR1ZrUWVU?=
 =?utf-8?B?Vy8zQkhCbGlyTi9PeTNLYzJaWURFNEF1dTRQTmhLZmtmMGFNMlB4UnpXd3Rv?=
 =?utf-8?B?MUJKSTl6RHVQY2U4MUxkSTNnM3pydktYUVhkQkFubnRJcjFHanZ2N0lPY3BW?=
 =?utf-8?B?T09KYWhKNFBVWGh6RXdMWUErQUM3YXcrR3oySk9oZy9WdXIrM3Bad214aHUy?=
 =?utf-8?B?b2xWRE9ZRHhIUFZjeSt5VUlFdEo5OTkxU2o0YjRnTzZiK0gxZGhUaDJXYkc5?=
 =?utf-8?B?S1dxTCtBVVl3ekxGeDVEVEpIa3pYRHhwU1hmbllZbk9SSmQyOSt6dkZQTzZI?=
 =?utf-8?B?QnBQKzJmUkwrdFE1TkMvOWZwd2hJU2VDYjcrZGk4bGNjaEs3MmhXK2lBU2tr?=
 =?utf-8?B?c2VYeHNNRmtSYUozZW1RRTlkVTFUVnoyQUxNNSs2OWc0L092eUdaL3FXbzQ3?=
 =?utf-8?B?VkZnVStWRmttWVcwRlVKQit6eFBVcldsek52WmZlT1IxZU1STm0vZ24zTkZW?=
 =?utf-8?B?Tyt3L3Y1THV5QkJQNWUrQTY2azMzNTBWUjQzeVU5Qk83bXB1R2VvdXdUYkpQ?=
 =?utf-8?B?MkFSUDVUdWJ0RCtlMFErOVo5SEVkeDd1NFBoU3M2aHNVeUY5WEFhWW4rOGpY?=
 =?utf-8?B?Vkd5VHNMeUhpdkxRLzBNblBPSDljN3JFMTRvcG1DSDl6c0l3NnFRbU91OTBH?=
 =?utf-8?B?c09kU0Q1ZGVZK21sYWlKNWxqbmpNZE1WR3RIbnRRWTFFOVNMZHlyTHc4T24y?=
 =?utf-8?B?aVRaNXpFQkxOMDEzK1F2bUoyOG12M3JvY1dxZzlPRmpUVXM4bG40SmdPVEN3?=
 =?utf-8?B?VVdpY0I3K2FYVjk1bFVpdEUycmRQcUljUWtZMjFnOVR5RFQ0SHA0bTBlaCtp?=
 =?utf-8?B?bk1hdVRmUHFvV21aSHoxTTBMM1RqL1BzZ3FXR3pyUFdZdThxdnB2bFhqYm0w?=
 =?utf-8?B?QW00cHdkMEdmV0hvc0wrdVB5aDA4L3k2UFNleStybXY1M04xQ1h0Y3l3SXBv?=
 =?utf-8?B?Njk1Ykk5T2lhb3NnSCtVMHRrWTJJOElXZXNJVk9BbzFlSG91dldSWVZzbStJ?=
 =?utf-8?B?M1pEVGlWSGhYNlk0RktxWERGdnhwQllXMXgvWVkxZHlyVWRqTldKR2EzT09D?=
 =?utf-8?B?UVpjRHMxVmlvQTVna2h3STE4TSs3WGpiQldQRGlWR0RuN29tYWdrcTgveFh6?=
 =?utf-8?B?VkJEM1VJZVhKc0I1cG1QSUFxWSswUldLaCtMVC9xRzYxQkc5OU5wRHN6Nzlk?=
 =?utf-8?B?WXpKM2VHaVdXMGtld1gzU2gyU05zcmJOWUZ1K05qT2g2a3F6ak1DV2gyNjNP?=
 =?utf-8?B?MWE5KzMwL1ZqUk9QZFlaWDZBbFVOUGduTEVBUXRZb1QzbHZzc2h6c2czdm55?=
 =?utf-8?B?ZGhBTHN3YVJKLzJ1YWlIV3AzYVQxQmlQUUlBdjNTL253Ni9SZEdCTGUwVGh5?=
 =?utf-8?B?QklNbUxjcmRTdjVjSGgycTN2ZDlnUGd5U2R6dGRkcG5hV3Rxb013eHVSMHVy?=
 =?utf-8?B?blZRMUFQd0M0clN4ckhZOG9KMnFZNzUzUmJPd0RiK3lremptS2o5cGl2TVpv?=
 =?utf-8?B?dVJzUlhYRS9lMDVpZUU0b2w2S3cyVElieGJNN1FycVBaYm43TW5TSjZOYmh5?=
 =?utf-8?B?K3UydlJza3VFclJyMHpzMCtKZ1BZcm45VmYvK3UvazE5elZ2Y2NvR0VnOWpa?=
 =?utf-8?B?T3kyNnhNcVNCa1FwZ0lGNENmeGtZTnBnbjdEdFNzUHRMUkVValZyVFdtQm9L?=
 =?utf-8?B?b2xXVThQTWY1aWsvdmthNkt3ckd0U2dQNEpobHA0dG5JbDZGWUUwb2JIMWp5?=
 =?utf-8?B?aDdNSkUwZzlzNklmMkJhU2hWMXlDZTc4em9zeWRidG10aFllM1FGQml3b2pu?=
 =?utf-8?B?SnRkZ3RyM1piWlRIVVhNSjFVWFpsRWxzUHA0aXBCVi9jRkFiRXpFeHVOZFZm?=
 =?utf-8?B?R0FXbVZvSW9CeFZ1eDdWOWo1bjYzS2RwY0JXV09ROTVrMndJZ3hOUUhxd3BD?=
 =?utf-8?B?cVJSN1ZqWllIaGVmOHFNa3hZS1BYNkNLN3ljYTRJcldMOHdoY1dKd0hkcTQ4?=
 =?utf-8?B?S1lKWU8rTkNWVHV2RERYTU1hb01RVzZkTGJwdDlXYkYrNEhRZkN2ZkIwbW1x?=
 =?utf-8?B?SEhadDNqY1UzUndMK1cvdm0zQWQxTU5JbWtZKzVqemYrbXVwSVB6Y1lETnRZ?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186cf76a-2d04-481b-f9c9-08dd074e9cf0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 21:27:17.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9sDA7OsOpqWppsP50+w+Ng97Tyydb0QPblo7gpKhLQ+1GLO74po8UCCLRZ2BiTbk9hz14TtNq5Zgw1nLr3XYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857

On 11/17/24 1:25 PM, Greg KH wrote:
> On Sun, Nov 17, 2024 at 01:19:09PM -0800, John Hubbard wrote:
>> On 11/17/24 12:33 PM, gregkh@linuxfoundation.org wrote:
...
> Patch is line-wrapped :(
> 
> Can you resend it in a format I can apply it in?
> 
> thanks,
> 
> greg k-h

OK, I'm going to use git-send-email after all. Thunderbird is clearly
not The Way here.  Just a sec. :)


thanks,
-- 
John Hubbard


