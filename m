Return-Path: <stable+bounces-198057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E09C9AB71
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 09:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D90004E1303
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503F3054F2;
	Tue,  2 Dec 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuLO/Zyi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CF3054C2;
	Tue,  2 Dec 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664639; cv=fail; b=UUeZTL6fGVntibyP7LDvkcr4PkTGe8Pkwej1PPG3pdw54TQKNMeT0b5TOLqdOqjCJshhXTA5tXjpNcsDUFhCSpBanZpXO7/BFOvVnv9eaChKxlwwe8/MUH104j5/AM+iAPzDEMG71QAyNMOTxbl1qOJEWy8zs159EWM/2gG1p2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664639; c=relaxed/simple;
	bh=IM94pd7eJ8tBjgDtt5HWo5vWgLL/PLVkV6GM2QltxI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tblnu6KhIWBW92VDRsgU+eCf8XaxTB9XXGT0k17iMWQOjS0yuLCjt9KhbceTlGuv9aAGcwjOzwi4xYClWE+GLEPm71IBzrKi0KdXVhSB4/J9TPQ1riLEH16vKEIe4u7+POfruFFOhqesleYqgW/8wT9LH6+0bIeXG1CiALlvgto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuLO/Zyi; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764664638; x=1796200638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IM94pd7eJ8tBjgDtt5HWo5vWgLL/PLVkV6GM2QltxI8=;
  b=HuLO/ZyiC8kN4HaA7KFHMi48Q2WE7TH0bd5ede3s+Oz6LNATWE7wPbx8
   2IjwyOq2ADtCHqBE8DPYGbO0FBePWxSnXjlIHoC9XptOVtJL3Ig6lGXTC
   mS8t3zhnAktzYj3+vdgrpazmNjkxAT1R1VtpXmhIP3TgQTsXH9vL/Jpyr
   nzQmrj+GEg+RT7Jgbq9AyeaJYCHPWb8DcsoRTUhJ2FUlFdSzsuyI6GerI
   bvhz3zVHla1F/nQ5oNArDX8/ZwUyN9rAJWvpIpk8nrkFscdY2jKNM7QYR
   lG0gZLyeB/wz51gzm3PusKVdLFf6M52YU23GuH4kyTWfpR2vx1ASUe/y1
   Q==;
X-CSE-ConnectionGUID: bEQmPBkLRxCaTaJ4kdBRdg==
X-CSE-MsgGUID: aNCGEIrjSjKJUTtYV7KxmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66696047"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="66696047"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 00:37:16 -0800
X-CSE-ConnectionGUID: QT6NPDR/RlKdBS5RZ4uQSg==
X-CSE-MsgGUID: iUQuwlfiQs6lL0FifIcI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="195126663"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 00:37:16 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 00:37:16 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 00:37:16 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 00:37:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbvXnVbrRTTeWWp3IV/RO6tv0Jegi7jv9JRL2uSaLpnalUXXAgaZsm+LQsZjaomCN+IPKGz5Q5t8xu/s/TbsxbDLC1593od6wyPronRKhIwzv3kp8bsmqQm3YixjCqf8c3Z9psLv2IJ3gj5HDI5HBnvCwzDvSNsB3hE9WnSnL6sYxEQpxDGkZvVdTD6U5HAiO6Elq9dxUy8Uc+XUEtvhZQ+6B+uvll1SmWfQElIKR7rMxXNSqf9NRjp50QjcfL/bFQ5/WdAFT79bJ6+ZDrutpf6/21vAVrxnHCWckvAzj7RRr7EjuHJLEKrcQiQkqV8V97X0VEZiqJ2FQ72AFXfT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd/7SSpcacgoDNrB5Hp/Wv2h0vUoSkVxNfpjyQ05cRE=;
 b=mbo/uDKrlG/JVOVHgaW4UFjkxehXuy40Imqkasq27stwZNdned4LVEYjhBXt/AYtkcpoU3V3uOtwLk0Np32qqFIxatGXjNFs6Xly+0D36Mj9Mz9V9edJbCADbjZF1VksDIiGGgbpFZOn0qKo6unBgA8bpygU5jcxWunAy50prTrkl9a//hQ5gbu7N4HVbXisfFaQRe/Bfz9YRCHk2NEZ2X41i6fGSZlWWlfxbx0OlGGVkJgHOhsybQKswb4BT3x6fjyfeN7DrMpEehj8I+v2PIMVglTkKbKOmxZXvI9XOeaKKKDMDC6rMghsR1/DBHYaM85uw/DLhnRNNa1YFWshog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 08:37:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 08:37:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Florian
 Westphal" <fw@strlen.de>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Nguyen, Tony"
	<tony.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2] e1000: fix OOB in
 e1000_tbi_should_accept()
Thread-Topic: [Intel-wired-lan] [PATCH v2] e1000: fix OOB in
 e1000_tbi_should_accept()
Thread-Index: AQHcYnRojg/+0kta9E+t0m8yEw/o37UOCLQQ
Date: Tue, 2 Dec 2025 08:37:13 +0000
Message-ID: <IA3PR11MB8986DD6968C0DD094F2E9112E5D8A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251201034058.263839-1-lgs201920130244@gmail.com>
In-Reply-To: <20251201034058.263839-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5022:EE_
x-ms-office365-filtering-correlation-id: 4f0a3e0e-18e9-4b53-90da-08de317dfe1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?rkIfGa2J2EVsp3aXiC3wxK181bRVNyXQ8jTj73U66yrcoxJApTFLltSYpvj6?=
 =?us-ascii?Q?MnrgNl6vRc48vGqU3N9LGnLDGv8x1AoGFPtUcq3n+JskDP2xyzCsa0Qqu32u?=
 =?us-ascii?Q?0idywFMJwvr7gfLCEzFTwY5NSzzhF3TZCs/BfuiPdesDglwmH4ALPB/l3O2y?=
 =?us-ascii?Q?k0fj1F2G3mBxxTqey1rUIE4NFXW/cHxc2zlKIK+0bd3Eb8xWoXCQ2bEsVGy2?=
 =?us-ascii?Q?1K/HdIjkm0T8giX+yBtY44sbCVxp8/ZUafRljvj7HA842p8hJIwuPQuhltoi?=
 =?us-ascii?Q?1MBOmjX+QT7OeUeJ1l6gP6d/82S17+iVQsIMnYdfmmbVEARPK+iLpL+Z7Cqr?=
 =?us-ascii?Q?JlhLSm8VqbXnuJXElJfC81mHjckldH8IzsZy/uau6aZfJM7Eyc/WUiUJwGT+?=
 =?us-ascii?Q?is5JlMyLV31JF/yzkr2l3VmetHlJqSjRHRH3KIaelN7BNoyJ3Yto7xoRPmev?=
 =?us-ascii?Q?qUKVFSGyWziVDYvst3azqMLkql+JgCZKGZ6Bjc9eLo9Kk8e7/W1tCV4ewyhz?=
 =?us-ascii?Q?9WjPm6+h54Yby11fIysk2URWggzPhqBQ+xmMRD0V0/YMut9ncgfcTE43raN5?=
 =?us-ascii?Q?B5VV6rmPhq8bYG+DESQ3zBXul+8SBRzJQ1ynOV11DYIVw7VsFkcZO4zygkVF?=
 =?us-ascii?Q?pwPmdVI0M7uNbQpnj7/vA/i1yL/Fe3CHcDsCqtFQmjFHsfe0YXgFl5ezePOr?=
 =?us-ascii?Q?S8ssmP/kUB+4Nz1hinnyru/xKztHaxiboIaGoxABCOm3cYRvRCJFpr0Uoaq+?=
 =?us-ascii?Q?GV/kv4DQFyADujAPtUT27wTdj+31ewJXkL2cNfntzW87NM/ogwj3nu6GSq84?=
 =?us-ascii?Q?DCWx8D2tnLWWZ35Vkixq/PX4aW123Ja+Y4rHTHSRAoMaRYfsdbAajAXom4oM?=
 =?us-ascii?Q?s288ZVtpWVgeK/Jdin3aJzkhyXBEXfsm4JJVkMUOB/Zr/kLwTlrxFzhe5WL/?=
 =?us-ascii?Q?lqCCdexAViTIyq51LNNF8QQVu6qiyfjhK8DClhIJjXcD90LfaiQl1iV8o3fL?=
 =?us-ascii?Q?DmjDQnLtNUHQ5cI2KQ9UohyaMd+79mNv/2Q1Z6OgAQ29zDs9vYbxzQa/rDn7?=
 =?us-ascii?Q?isrEqvymal5v6VIXEGB9CLKPzWw+tbj50VyWchz43puNlveBfRwA5r8qmsVg?=
 =?us-ascii?Q?iybNze9KTr/tBuOnDggQYfrKvT7BpKQS6EVJ+oImrgHGHYzG1ztTjdScceXv?=
 =?us-ascii?Q?6A9572f+Ztz8BpNAPJEAh+hWyDO1Mewpoc8egYXDHa5/hFftH3D4aV0HTZQA?=
 =?us-ascii?Q?LC/NgNZ16194JPAEwxWwfk5hD/aPUpbMHyqo2uysHNcUzF2H92Ru5JLFWHCG?=
 =?us-ascii?Q?Zgg8u0mV9EYqY1u3HyFifOcGtlZbCsrqRRYC/z+bF9fWWUZA49WhEzYKjPFe?=
 =?us-ascii?Q?og0JosaPNh6oGKFH7KIvw40x0VjGtny5O39dJKrrggbpi2yoqN4bvBowwx7R?=
 =?us-ascii?Q?8S3b81MvP5+effcIiriIDaK37SpZqscpvYaTMwwsVztb12qzSoVDF67OuIpO?=
 =?us-ascii?Q?xgZUcYEyhSPkMawxBXHp7LD8LjV3iqJdyECWZOyJ6gzTVbGTvRUKXovfZA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kfq8tLa1L+LVOzFF+zUg6AWM2kz7V+Jl19i+pXxmU2Kl7naQU1aKb/HQHtsQ?=
 =?us-ascii?Q?RytXMGl50SXZX4Nh1UHtSvi41GVW5A7+lxCktZ5lzQ3qxM0dx3SOhgwZL4fs?=
 =?us-ascii?Q?pu0ogHTVfqfI0j3qOM+VGDTG6alGOCAOMLpPbOyvzwWEKX4Y0F2m4Syoa94C?=
 =?us-ascii?Q?yLheWY7O5oY048k1U5UHDLUGpc5qENgkDdXU0ZPz5rtpBeOamqaSkeCbivAz?=
 =?us-ascii?Q?D6MkOOGpPFTpz0C8Mc3N3R076t/sz4gFtQQnvDUrr1xy9rq0vZnOXRdlx/lZ?=
 =?us-ascii?Q?vj5aztUPwIlwS5cp+mjho9eeFGB0CksWNKb6NizUkOYnvlbdwMbCIsYnjIpU?=
 =?us-ascii?Q?Yblpy8q5YOf/LCo+Xa00S8Ez0maX0a06jEZX9SYHiJVAiNZ4XNqe/lAfYtE0?=
 =?us-ascii?Q?ljxcSC708ukO/GTb+EmVJYduY0v4iSUcxnDXVAAgNM2Q9wM0zaZIZM6zUab2?=
 =?us-ascii?Q?wmkMsKpvu5BL/RfwPJ1MhabtvohYazyx6eVOkK6UDHqMSCcCv0Zd5cNC/TsW?=
 =?us-ascii?Q?KjbRWtNElNLcHs4pJf5fFv3t9DL1Da37uLKx80cWfMAsiVxch4Vrjj4voVAM?=
 =?us-ascii?Q?uh8knB1RLW7BHZN5zcWc9mQJtPmSUzoh7T341B0V5VJDT7CFTka5uzv6Ji6J?=
 =?us-ascii?Q?g73kiRPtLZCwfwKVjlvHE82B0soCVI/23lEv+pqzloZoetd8mSx2R2lLYS+s?=
 =?us-ascii?Q?H2FXmzyKNKa0eKsFj7tEAsc/f3kcBEZTiLOP98lCuIkxXwphFhc1JtCSVr0K?=
 =?us-ascii?Q?AyMqog2tMOXsxBxeV222Aaw+mFBo7p4COID9hKMDsUIAIWksJadM1Akwk4jJ?=
 =?us-ascii?Q?Ge1qAzp6rlXC7AqcQpC3CmLLKf9jjvjIryn0H4ejjuTxQPlx8RfWsIK2YcZX?=
 =?us-ascii?Q?BJquvab5qeCb/ebRNYZhB4kCGL4qS1QdaXZXDzHgehGx60A8hUPHXzYSlWxT?=
 =?us-ascii?Q?aflvDVMPEiXMn5Z2jCDEM6xMrArV/nannhcyiaj8/CAMBcZZ/6RRBCq/s1hk?=
 =?us-ascii?Q?T1cJDpKaSgwfhrJ7lpHUsC1dNPx7fZeh31AMWgZ2jGdt7C/sEbJ0jQTFJTTw?=
 =?us-ascii?Q?wSlE2ps3mSzOOAoiRSbZiwiTuWHwgBszLvLABrJ3L5Mb9WUAyxOP2H4Crkoq?=
 =?us-ascii?Q?OjySIL0L9DmrZQ+8MviMV6AGHzbQ9RtS+GvcXG2O7fwf4Lv2IIH6KuJZr75d?=
 =?us-ascii?Q?/JExXD3D2Zcvv5EHWHGlKAeFb4q7ushTHBZ1OWD4R1y4rKURLFOy5GsmD3bt?=
 =?us-ascii?Q?o95YzmtTc4az30OL1kGiche8CmpKZx7IIUunAZN+QLlRrI8er7F0pu3+Oi+M?=
 =?us-ascii?Q?JZ0oT4YuB4Eq2yzS0dKKOI9kqW8H2ZHKTfuaGAjT+7ap10wAvZygDxfKHFPc?=
 =?us-ascii?Q?oajHRsGN2Yv0TqsFW1XirVRf9WMwSaL/aQoRK3f84F8hpgxz1ojLtL8896A/?=
 =?us-ascii?Q?QLiUeHviN5/HGTGsz5yDr5dqtfbq9HtYPQqlXpB2H4yJqH/AYFk0c6iOfGrp?=
 =?us-ascii?Q?MAgPy80Y/8qD5A+TI8fPAmo2/e3lbj/NAudntyycPrLn4Nse7TFDW/itFBow?=
 =?us-ascii?Q?ekucsr0nkxmOVKJzBNnM0/qXwD+ogwi6ODK/J2Il14kbw1CBcJWSTfQim+Bh?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0a3e0e-18e9-4b53-90da-08de317dfe1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 08:37:13.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /srxd54pAEs96yHCab0MQWmcuxfMsrvJAZDSZ+fWPlK5Jb+RO0fb66d9JVyzUfyQm4QODCbrAMbBAqy3bitfnAN+43p+Jt64vMesEKbNAW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Guangshuo Li
> Sent: Monday, December 1, 2025 4:41 AM
> To: Jesse Brandeburg <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Florian Westphal <fw@strlen.de>; Jeff Kirsher
> <jeffrey.t.kirsher@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Guangshuo Li <lgs201920130244@gmail.com>; stable@vger.kernel.org;
> Nguyen, Tony <tony.nguyen@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2] e1000: fix OOB in
> e1000_tbi_should_accept()
>=20
> In e1000_tbi_should_accept() we read the last byte of the frame via
> 'data[length - 1]' to evaluate the TBI workaround. If the descriptor-
> reported length is zero or larger than the actual RX buffer size, this
> read goes out of bounds and can hit unrelated slab objects. The issue
> is observed from the NAPI receive path (e1000_clean_rx_irq):
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in e1000_tbi_should_accept+0x610/0x790
> Read of size 1 at addr ffff888014114e54 by task sshd/363
>=20
> CPU: 0 PID: 363 Comm: sshd Not tainted 5.18.0-rc1 #1 Hardware name:
> QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-
> gc9ba5276e321-prebuilt.qemu.org 04/01/2014 Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x5a/0x74
>  print_address_description+0x7b/0x440
>  print_report+0x101/0x200
>  kasan_report+0xc1/0xf0
>  e1000_tbi_should_accept+0x610/0x790
>  e1000_clean_rx_irq+0xa8c/0x1110
>  e1000_clean+0xde2/0x3c10
>  __napi_poll+0x98/0x380
>  net_rx_action+0x491/0xa20
>  __do_softirq+0x2c9/0x61d
>  do_softirq+0xd1/0x120
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0xfe/0x130
>  ip_finish_output2+0x7d5/0xb00
>  __ip_queue_xmit+0xe24/0x1ab0
>  __tcp_transmit_skb+0x1bcb/0x3340
>  tcp_write_xmit+0x175d/0x6bd0
>  __tcp_push_pending_frames+0x7b/0x280
>  tcp_sendmsg_locked+0x2e4f/0x32d0
>  tcp_sendmsg+0x24/0x40
>  sock_write_iter+0x322/0x430
>  vfs_write+0x56c/0xa60
>  ksys_write+0xd1/0x190
>  do_syscall_64+0x43/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f511b476b10
> Code: 73 01 c3 48 8b 0d 88 d3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66
> 0f 1f 44 00 00 83 3d f9 2b 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 8e 9b 01 00 48 89 04 24
> RSP: 002b:00007ffc9211d4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000004024 RCX: 00007f511b476b10
> RDX: 0000000000004024 RSI: 0000559a9385962c RDI: 0000000000000003
> RBP: 0000559a9383a400 R08: fffffffffffffff0 R09: 0000000000004f00
> R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc9211d57f R14: 0000559a9347bde7 R15: 0000000000000003
> </TASK> Allocated by task 1:
>  __kasan_krealloc+0x131/0x1c0
>  krealloc+0x90/0xc0
>  add_sysfs_param+0xcb/0x8a0
>  kernel_add_sysfs_param+0x81/0xd4
>  param_sysfs_builtin+0x138/0x1a6
>  param_sysfs_init+0x57/0x5b
>  do_one_initcall+0x104/0x250
>  do_initcall_level+0x102/0x132
>  do_initcalls+0x46/0x74
>  kernel_init_freeable+0x28f/0x393
>  kernel_init+0x14/0x1a0
>  ret_from_fork+0x22/0x30
> The buggy address belongs to the object at ffff888014114000  which
> belongs to the cache kmalloc-2k of size 2048 The buggy address is
> located 1620 bytes to the right of  2048-byte region
> [ffff888014114000, ffff888014114800] The buggy address belongs to the
> physical page:
> page:ffffea0000504400 refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x14110
> head:ffffea0000504400 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0x100000000010200(slab|head|node=3D0|zone=3D1)
> raw: 0100000000010200 0000000000000000 dead000000000001
> ffff888013442000
> raw: 0000000000000000 0000000000080008 00000001ffffffff
> 0000000000000000 page dumped because: kasan: bad access detected
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This happens because the TBI check unconditionally dereferences the
> last byte without validating the reported length first:
>=20
> 	u8 last_byte =3D *(data + length - 1);
>=20
> Fix by rejecting the frame early if the length is zero, or if it
> exceeds
> adapter->rx_buffer_len. This preserves the TBI workaround semantics
> for
> valid frames and prevents touching memory beyond the RX buffer.
>=20
> Fixes: 2037110c96d5 ("e1000: move tbi workaround code into helper
> function")
> Cc: stable@vger.kernel.org
> Suggested-by: Tony Nguyen <tony.nguyen@intel.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> changelog:
> v2:
> - Keep declarations at the beginning of e1000_tbi_should_accept().
> - Move the last_byte assignment after the length bounds checks
> (suggested by Tony Nguyen)
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c
> b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 3f5feb55cfba..cb49ec49f836 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -4091,7 +4091,14 @@ static bool e1000_tbi_should_accept(struct
> e1000_adapter *adapter,
>  				    u32 length, const u8 *data)
>  {
>  	struct e1000_hw *hw =3D &adapter->hw;
> -	u8 last_byte =3D *(data + length - 1);
> +	u8 last_byte;
> +	/* Guard against OOB on data[length - 1] */
> +	if (unlikely(!length))
> +		return false;
> +	/* Upper bound: length must not exceed rx_buffer_len */
> +	if (unlikely(length > adapter->rx_buffer_len))
> +		return false;
> +	last_byte =3D *(data + length - 1);
>=20
>  	if (TBI_ACCEPT(hw, status, errors, length, last_byte)) {
>  		unsigned long irq_flags;
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

