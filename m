Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A227A6AC3
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjISSgi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 14:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISSgh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 14:36:37 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 11:36:31 PDT
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BF69E
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2235; q=dns/txt; s=iport;
  t=1695148591; x=1696358191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qhoEv6dWLjxYscsxmFKUpiENe7ZMRnGCz4kcYzPUq6U=;
  b=F8Npx216yR9Ymvc/RlTzZVAhnqBhLK2WQhSJwa2/MwVxrWhtSX2Fbt2j
   QkRK/IJg/dReSTMUk5fnvQSXXI8kyAaWd02JoCUggJxcRQdmnQ2uxK0pC
   2Gom3wgr+xMOEw6qdAZoFb0G0vC4KrwMI/K8yzuwO5EQWzihReQZ5HATH
   E=;
X-CSE-ConnectionGUID: Jr3WsgGlQJSM6sH8CdMrrQ==
X-CSE-MsgGUID: ADz7JB1nQl6UacX0VFvRTg==
X-IPAS-Result: =?us-ascii?q?A0ASAABu6QllmIENJK1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRYGAQEBCwGBZFJ3WyoSR4geA4ROX4hjA5d5KIVaFIERA1YPAQEBD?=
 =?us-ascii?q?QEBRAQBAYUHAocAAiY0CQ4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHB?=
 =?us-ascii?q?BQBAQEBAQEBAR4ZBQ4QJ4VoDYZHAQEBAQIBEigGAQE3AQQHBAIBCBEEAQEBH?=
 =?us-ascii?q?hAyHQgBAQQOBQgaglyCPCMDAaN/AYFAAoooeIE0gQGCCQEBBgQFsmwJgUgBi?=
 =?us-ascii?q?AgBhTmETScbgg2BWIJoPmsaAYFcAoErARIBCBtLg0eCL4lKhT0HMoV+ih4qg?=
 =?us-ascii?q?QgIXoFqPQINVQsLNyaBEW+BVQICER4bDwVHcRsDBwOBBBArBwQvGwcGCRYsJ?=
 =?us-ascii?q?QZRBC0kCRMSPgSBZ4FRCoEGPxEOEYJFIgIHNjYZS4JdCRUMNU52ECsEFBhsJ?=
 =?us-ascii?q?wRqBRoVHjYREhkNAwh2HQIRIzoCAwUDBDYKFQQJCyEFFEMDRwZMCwMCHAUDA?=
 =?us-ascii?q?wSBNgUPHgIQGgYOKQMDGVACEBQDPgMDBgMLJgNEHUADC209FCEUGwUEZlkFo?=
 =?us-ascii?q?UWCdoEiBh13QjkfAZNCnFOUZAqEC6E7F4QBjG6YcESXaaMfgWWDGAIEAgQFA?=
 =?us-ascii?q?g4BAQaBYzprcHAVgyJSGQ+OIAwNCRaDQI95djsCBwsBAQMJi0kBAQ?=
IronPort-PHdr: A9a23:voLA7xNZEEwwRF09Ndwl6nfLWUAX0o4cdiYc7p4hzrVWfbvmo9LpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgrDmgKUYAIM/lfBXJp2GqqzsbGxHxLw1wc+f8AJLTi820/+uz4JbUJQ5PgWn1bbZ7N
 h7jtQzKrYFWmd57N68rwx3Vo31FM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:AZcDD6MftUanGLnvrR2Ll8FynXyQoLVcMsEvi/4bfWQNrUpxhGZTx
 mRJCmuFOqyOZjf0etp3Ydm1pxwDup6DzdI1TnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdaphyFjmF/kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/W1nlV
 e/a+ZWFYwf0gm8saQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQNbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WH7cdx6TIDnyGk/e2kVbmI1Dg5u90NRRjVWEY0r4f7WBm/
 PgcLnUGaQqOwrPwy7OgQe4qjcMmRCXpFNpA4Tc7k3eAVrB/G8Grr6bivbe02B8zj9pSHPLXZ
 OISaCFka1LLZBgn1lI/Uc9uwr/12SGhG9FegHu5t/UVyTHV9Qgv7bHmAILrVMKwecoAyy50o
 UqfrzimXXn2Lue30iaM+HahrvHAkDm9W48IErC8sPlwjzWuKnc7ARkSUx6wpuO0zx/4UNNEI
 EtS8S0rxUQvyKC1ZvvnBCKjr1GAhzwnfoRLM70R5CSX0JOBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH7eH9pZW1q+r8kN+iBcQGBTRZPX5eHWPp9/Gm8d9t0k+TJjp2OPPt5uAZDw0c1
 NxjQMIWrrEXgMhjO06Tog2f22jESnQksmcICuj/V2ah6EZyY5SoIt3u4lnA5vEGJ4GcJrVgg
 JTms5bChAztJcjS/MBofAnrNOrxjxpiGGaN6WOD57F7q1yQF4eLJOi8Gg1WKkZzKdojcjT0e
 kLVsg45zMYNbSbyM/YnONPgUJ9CIU3c+TLNC6G8gj1mPMAZSeN71H0GibO4hjq0yxF8zcnTx
 7/CL5v9ZZrlNUiX5GPmG7hCuVPa7is/3mjUDYvq1Aiq1KH2WZJmYeltDbd6VchgtPnsiFyMq
 753bpLWoz0BC7eWSneMruYuwaUicCJT6Wbe8ZIHL4Zu42NORQkcNhMm6ep8JtA5wPsFx7mgE
 7PUchYw9WcTTEbvcG2iQntic7joG514qBoG0eYEZz5EB1BLjV6T0Zoi
IronPort-HdrOrdr: A9a23:9SdrqagpO+kI45l0uBfqP6USX3BQX5923DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sdi9qBPnmaKc4eEqTM6ftXrdyRuVxeZZnMXfKlzbamLDH4tmpM
 VdmsdFeaDN5DRB/KHHCUyDYqgdKbq8geGVbIXlvgtQpGhRAskKgXYde2Km+w9NNXZ77PECZe
 KhD7981kCdkAMsH7+G7xc+Lo7+juyOvqjLJTQBABkq4hSPizSH1J7WeiLz4j4uFxl07fMH62
 bqryzVj5/Pjxi88HDh/l6Wy64TtMrqy9NFCsDJoNMSMC/QhgGhY5kkc6GevRguydvfq2oCoZ
 3pmVMNLs5z43TeciWeuh32wTTt1z4o9jvL1UKYu33+usb0LQhKSfapxLgpNycx2XBQ++2U45
 g7mV5xcKAnVC8oqR6No+QgkSsaznZc70BSytL7xEYvIrf2IIUh37D3unklUKvp2EnBmd0a+C
 4ENrCH2N9GNVyddHzXpW9p3ZilWWkyBA6PRgwYttWSyCU+pgEy86I0/r1Wop47zuN3d7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUPhvAQOAl7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBG+9QTPuwMdD4IURgMyweJP7dSmYDFw+mcqppPsSRsXdRv
 aoIZpTR+TuKGP/cLw5ljEWm6MiX0X2fPdlzerTAWj+1/4jAreawtDmTA==
X-Talos-CUID: 9a23:TxVqs28La7RxQXaqQDGVv2wOQf8+fVLZ9VXrBhGjKTZCRJiPU2bFrQ==
X-Talos-MUID: 9a23:BkZxHwv1VfnzYYYFo82nrR1wa+VCuqKXDB4wmJ424/eqKxZMNGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 18:35:28 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 38JIZRvM009542
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 18:35:28 GMT
X-CSE-ConnectionGUID: 86ZbFwcCS9Gwe0V8ibOK2w==
X-CSE-MsgGUID: vptE6c1VQ8Cg3Um17Q20+Q==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,160,1688428800"; 
   d="scan'208";a="2350824"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 18:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ast6GEAV0/12b2mAc1MFFOJFMTvF835sAGig5wIwmU3lrI1CowIGecA29IpVuXR9EBChHS1IJyEL793CQBN6iDPZ1hdkQLB+UcSTRa0IlNto3/fKkjqoOGvIFAZrAUbs6BSsjIls/xWay8RZy5nOHEdN3U3MalfoU8mey/ZaRfaYvluAYQDne67ZBb2unPli+7qWvcHDpNoaMV7H9y7ozXNoRBGw4VUI5kJIzwT5kJDF3jq6uJkTGERjhBcmUlaqA13mMfRI4fazKz2Pqdg8dJQFBJSFfcwVqsNS0A9I0mC5F+1E8XwQpjT+1NdbedFwWyZaaKD3G1ZxJdMYckwL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FWMeMYwcDERfcxHmjFLbeBX1EQCBihHuYEgZrt4HS8=;
 b=Bk9w5N5LFOKCtZCYEEmCGB7nYMt4V9zcwnqdZgO5tYhOzcaEfNxHmcvK5rEyyqmAMF+li3DH1Ivg+Bc13smzpgJ6IgPbNsp/TnyaUpGj3T495XJ3nSbvlehAIlX7IHE+jCQ2bPf+KJnt/dK1RYchPaEf2DhS1czvWjPYfZTglWYse9PntM1Z39eKig+r527x8zTtPjH/631OinPTGmJpxaDkFKQoqcSb54ZIxu4uTQRjmE6tnCugJfAmiqVPO59iuW6gFRqq7AT/NUleUTc9zgMpNNZCfHCEK7pwyXCWgh4eoeVBaEiFbJbtb20C7pdGlxPuDmRHuTvMOoOlQb66wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FWMeMYwcDERfcxHmjFLbeBX1EQCBihHuYEgZrt4HS8=;
 b=ldCcnAD7a8mFUZP1szidio+NZojo6d39wfxQzHz03H08SYRM2m+4a2BoGTUEfWuMyVLubjr5nJiH7R+su58d099CUx69ekqNUqbsCaHae2c27rdzMXwgtP9e7D/3UBWrwagou3NRM1TG3979ILq9LS8CEp30i1ELAc9BBOeOcaA=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by BN9PR11MB5547.namprd11.prod.outlook.com (2603:10b6:408:104::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 18:35:25 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::d2bf:9fa8:5b6:ddf8]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::d2bf:9fa8:5b6:ddf8%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 18:35:25 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: RE: Request to backport commit id:
 15924b0503630016dee4dbb945a8df4df659070b to 6.5/scsi-fixes
Thread-Topic: Request to backport commit id:
 15924b0503630016dee4dbb945a8df4df659070b to 6.5/scsi-fixes
Thread-Index: AdnmwqZNdeSFb8WnQiCx9WZDyFMKyQBz3cUAAKVFvPA=
Date:   Tue, 19 Sep 2023 18:35:25 +0000
Message-ID: <SJ0PR11MB589600140A9A580DC666CF5EC3FAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <SJ0PR11MB58965FCA74A2B0DD13E965A8C3F7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <2023091622-cryptic-pointless-b2ce@gregkh>
In-Reply-To: <2023091622-cryptic-pointless-b2ce@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|BN9PR11MB5547:EE_
x-ms-office365-filtering-correlation-id: eee8fd89-5bfc-4529-ceb8-08dbb93f30be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHBNDDqWjm0+opbhnhlsLc973UW/7Vktw19e8kcRLr9ePZd0ENPAA1hj7l50V5x96yxJ9tYooIIZ8i1UKs8hySWgfLQbmDIKsL3BbtCtZjirKAxfXPjTXc4FBKit8cDpWAk73xNKQfq63GUFCB1Q6sDwE8JTgWkm2z2Nz0K9DeBwuUNKecGwVkrUd4cyeSXPOVYvimpKRUqq7L7nWAr1Zl9hD/FUFyZszl3zgZM6Kt87RxOBSOM4v3PrQ9AucsDYQ5CctrhiQUbliSi4gk/58sspp2AIFwFc9sq8E4Rxjk5mdpU8sXHRz14THgwaq0Y/JTtZIf0ydgUbC26nKJdZMHvuacHzADQ8pEGYwYqA5iRYI4Wt/PRaoEud/SPzBektBImk4Yqp1IkNvCcO/hG4y3o1dbk2+M+2xh+lKPVugoqUk90p2SZCDMA3vVt1WH9dGirfQ1c87sonRXBXxoP/Z5nmCsbAtn9xbp3pt9cGlSeNCVrGpr62tU2WU7H7llRffGvfB3HixCPXbP1cSGU4qq1uuiXeI280nZNypxswspZwaKQJ1eDuSC2T9IUqVacrH9TE9Fpo1hQ9ORb6UQs9nVhxAyMzOfjn//LcuUxGsEfaBLcNmFa6dWg/GFa6hJQZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(1800799009)(451199024)(186009)(2906002)(5660300002)(52536014)(55016003)(66946007)(66446008)(66556008)(41300700001)(6916009)(316002)(64756008)(54906003)(66476007)(76116006)(478600001)(8936002)(4326008)(8676002)(71200400001)(6506007)(7696005)(53546011)(9686003)(122000001)(38100700002)(38070700005)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A7iPFumdtFIGq6v+U81GjWfTYctSt4eQI3/abYNv41cjCMf3WZixzuLe/aSi?=
 =?us-ascii?Q?8GdrlFHgOLxieaY8JSLhvaZt722QgVG0TmK/TJaCEk+bPr+06cXzAjBWoD2P?=
 =?us-ascii?Q?QoL0fsFV+yJTiiufBSL9i5arWyQhPkP4gb9GWpAW7cHMSYNI52WwOLZnsCD5?=
 =?us-ascii?Q?FmMkF07sLHXO6U2jn19Mn5oVcAle4id9zgGFK9iUrMeuF++70RzAZoHOj4iA?=
 =?us-ascii?Q?RhBnsXvZf5dxrstl+GEbI1ll7f3np9zjjYbVsRaP5wMv+OJLsNFwriORnD0u?=
 =?us-ascii?Q?HRmhiluR/kgCaTC0iWjM8iDK7HJ5hTeuWLSz0WWz24sibvBk/C1aGQO2uuKm?=
 =?us-ascii?Q?yrs6XJqMndspFHK06o+V+bVcS2N33BPGdNLeoiydY2zdS9QKjWu/0OU3W/Ar?=
 =?us-ascii?Q?pXpAByrJ/4ivf90nmiTSyE9/8c01SUYv8XnlLk0OPYy4t7Plhu6AXIU6X4O2?=
 =?us-ascii?Q?PuWL0ZvLUU8/K4ZX+2vXcYUOneL6Xr0NtIOpWHg22W/1Vrrq6gnLtw03crif?=
 =?us-ascii?Q?IWFF8hx3vjgHJfHKkU3PWmsqsxMs+s0Seo75fiz9pdjl2b7oRhRgt7+ekwrw?=
 =?us-ascii?Q?15jqCzt++gww4aJHy8HekUWNH60xCVq6Q0fXj0laEc2Qa4kmDcFAWxuXLDNr?=
 =?us-ascii?Q?lOyfvJl7Usp1GSWrxoNp9RB0jPTh12Y96NNF7xcxv1pdh7t/YkIfOUahGgHO?=
 =?us-ascii?Q?dCvBU5sNUfZ+YVTgY8iVeCKJNgSGFYocXfxjQeDWXC0MESJclPr+vSBzmpfY?=
 =?us-ascii?Q?wIfxE+R+MdWgX/kpapfPtHMdxNpFqd6Pci7qAc7b52LBJfQx3ZSAw8vr7Okn?=
 =?us-ascii?Q?KyGUG08bsLwOt6TvfnSzrVI5qYZkgBN2gpS2JSApLxvRPWQsdb+v9Ey3WCg5?=
 =?us-ascii?Q?LbZgRg6NUOjBio7k/pVHgW/B1MFJR00wC3H5dJgH35VZ7DbOQoRpGe/k+xNQ?=
 =?us-ascii?Q?zvAdK0kNqB/0UmNsYFTmFXC7IHGD1vuD3yPCTUpQ6c9+bMtMEWHj6Ivq+Gt2?=
 =?us-ascii?Q?2XjxsYVtpyTwPxIx840iYhdUHY8zALk9DFDaZMJC2Nr7+4XOXAkstgBYpuZx?=
 =?us-ascii?Q?Ng/W/GR+EbguGUW2EjyqRBc01SN1GHrg1ezUlcBTXxxU88OxFH0keGXeUjej?=
 =?us-ascii?Q?2Xgbd5y8RunoWvLC501+Y6wE7lr1zZcfaTt6pDJw605cakKcQW1Euk/KNM9l?=
 =?us-ascii?Q?p2YZmuMQi7J9P422/fSfoTBCAIZ6Gtk7cJE4Roe1ls4RayLPg4WqUhs8puZs?=
 =?us-ascii?Q?y7AaGUP8dtc4WG+oRNYeT7gEPPUaC+U6CEKU5Ol+Ckdjskqcytx9oT0W0Vag?=
 =?us-ascii?Q?sKw4pgH0tcoGt3AFXG4LsPqnysxwaht4R+islHUfca20WXPGx0+WyTpMiWGP?=
 =?us-ascii?Q?qPegYmmHWpNfUVlTfQjEC2pBa8ZZjBh2uB5hs5ohdNsSqo3zV147CQoeaZuK?=
 =?us-ascii?Q?RyVFCnkMT3oMwU/cI2rWpcyhMfzCUoZWRfHQNrjOegmUBFEXjta9gFUtmTm4?=
 =?us-ascii?Q?UP567ulJA0bvRmL+p8GhfT0zxUUv6BCUrJwPXTZ+1MPUIEl+XpIBUy6WOgPo?=
 =?us-ascii?Q?22VHbGEPzMGTCWswePDAOpIFlyJDmnM8VQZ7ft4ZlSGaRETvYpZLRbSHLpwc?=
 =?us-ascii?Q?7JYE93si/+hjSgOIOCDu52BesmncqpLQxdc/gsKf6iky?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee8fd89-5bfc-4529-ceb8-08dbb93f30be
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 18:35:25.4900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1tHul0ufCd/JTp1xJKlTf4FZfpdtUNaZLvkgmgnJJ7rxFP+e3ZEGEVOK2SNuE0TwaEk76foznIDdXhp2xrd9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5547
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-core-9.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

Thanks for your response.

>> What is "6.5/scsi-fixes"?

6.5/scsi-fixes is a branch on Martin K Petersen's repo. I see now that ther=
e's a new branch: 6.6/scsi-fixes.

>> It doesn't apply as-is so how did you test this on the 6.5 tree?  Please=
 provide a working, and tested, backport and we will be glad to queue it up=
 for the stable trees.

I had previously tested the patch on Martin's 6.5/scsi-fixes tree. However,=
 I saw that there is a new tree: 6.6/scsi-fixes, and the patch has been app=
lied there.
I needed to submit a new patch which was dependent on these changes. So, I =
ported my new patch to 6.6/scsi-fixes and tested it there.=20
So, please ignore this request for a backport. I have submitted my new patc=
h based off the 6.6/scsi-fixes tree.

Regards,
Karan

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Saturday, September 16, 2023 4:37 AM
To: Karan Tilak Kumar (kartilak) <kartilak@cisco.com>
Cc: stable@vger.kernel.org; Arulprabhu Ponnusamy (arulponn) <arulponn@cisco=
.com>; Sesidhar Baddela (sebaddel) <sebaddel@cisco.com>; martin.petersen@or=
acle.com
Subject: Re: Request to backport commit id: 15924b0503630016dee4dbb945a8df4=
df659070b to 6.5/scsi-fixes

On Thu, Sep 14, 2023 at 04:20:24AM +0000, Karan Tilak Kumar (kartilak) wrot=
e:
> (Re-sending email since the previous email was undeliverable due to=20
> HTML content)
>=20
> Hi Team,
>=20
> This is a request to backport the following fix to 6.5/scsi-fixes. This w=
as merged into Linus' tree.=20

What is "6.5/scsi-fixes"?

> This fix fixes a crash due to a null pointer exception when a lun reset i=
s issued from sgreset for a lun.=20
> With this fix, there is no longer a crash.
>=20
> I have another fix, which I have tested, dependent on this fix. It is cur=
rently in the pipeline.
> I'll send out a patch for that fix when the internal review is complete.
>=20
> Please let me know if you need any more information to backport this fix.

It doesn't apply as-is so how did you test this on the 6.5 tree?  Please pr=
ovide a working, and tested, backport and we will be glad to queue it up fo=
r the stable trees.

thanks,

greg k-h
