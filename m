Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA279F98B
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 06:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjINEUu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 00:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjINEUt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 00:20:49 -0400
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625B4E69
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 21:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1819; q=dns/txt; s=iport;
  t=1694665245; x=1695874845;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=UfpRJvqs/QdrBIIbuyC+aeaWNDcg6meDfgFEQIRBTQ8=;
  b=ZtlIZFECJ7sl7iHf7XkDybUBsT1JqapmbZITJOLnb7hzyPDV4qcysgk0
   D2pSdS77TffsegSxVCBtEK/w6Oyyg44Fag5cOM8AgwXNNIFjQu1/Gw9Z1
   Cro3jbE1WOEwRAo9rvLa1+TTMw2VaF9IOcNxK6QzcytH3uOasRHp5PW3W
   U=;
X-CSE-ConnectionGUID: Tp/OJrf/Sdy5uIDHEXDeHQ==
X-CSE-MsgGUID: j8Rb48v/Q9ae2tFEltHRUA==
X-IPAS-Result: =?us-ascii?q?A0AlAAC9iQJlmIENJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZFJ2AlkqEkeIHgOETl+IY5d8KIVaFIERA1YPAQEBDQEBOQsEA?=
 =?us-ascii?q?QGFBwKGdwImNAkOAQICAgEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBA?=
 =?us-ascii?q?QEBAQEeGQUOECeFaAEMhhMWKAYBATcBEQEcIQFCJgEEDgUIGoJcAYJeAwEQB?=
 =?us-ascii?q?qF6AYFAAoooeIE0gQGCCQEBBgQFsmwDBoFIAYgIAYU5FoQ3JxuCDYFYgmg+a?=
 =?us-ascii?q?xoBgVwCgSsBEgEIG4QSgi6JR4VDBzKCJoM1Kol9KoEICF6Baj0CDVQLCzcmg?=
 =?us-ascii?q?RFvgVYCAhEeGxRHcRsDBwOBAhArBwQyIgYJFi0lBlEELSQJExI+BIM4CoEGP?=
 =?us-ascii?q?xEOEYJFIgIHNjYZS4JgCRUMNU52ECsEFBhsJ24fFR43ERIZDQMIdh0CESM6A?=
 =?us-ascii?q?gMFAwQ2ChUECQshBRRDA0gGTAsDAhwFAwMEgTYFDx4CEC4rAwMZUQIRFAM2A?=
 =?us-ascii?q?0QdQAMLbT0UIRQbBQSBPwWgNm6CPjaBIgIhLyGBIgEeAZNCsTcKhAsFi3uVO?=
 =?us-ascii?q?xeEAYxumHBEl2kgjUGVPoR9AgQCBAUCDgEBBoFjOmtwcBWDIhM/GQ+OIAwNC?=
 =?us-ascii?q?RaDQIUUimV2AgE4AgcLAQEDCYtIAQE?=
IronPort-PHdr: A9a23:GnS77Rfw7KSkSyTwGmrBNCC0lGM/fYqcDmcuAtIPgrZKdOGk55v9e
 RWZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NBsdA97wMmXbuWb69jsOAlP6PAtxKP7yH9vRht6r1uS7+LXYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0wbAuHJOZ+VQyCtkJEnGmRH664b48Mto8j9bvLQq8MsobA==
IronPort-Data: A9a23:W9IXDa5O5VswLEzpItQdIQxRtBHHchMFZxGqfqrLsTDasY5as4F+v
 mMWWm2Ea6yKamX3fYhzbom08EpV7JPQmoBkGgdr+SEyZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa/lH1dOG58RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq+aUzBHf/g2QvajNNt/rZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95f7OT+Yk9adiHbKYibx4tlOIXEaMK0hr7Mf7WFmr
 ZT0KRgEahSFwumx2r/+G69nh98oK4/gO4Z3VnNIlG6CS614B8mYBfyQtLe03x9o7ixKNfXXf
 dYYbTNsRB/BeBZIfFwQDfrSmc/x3yWvLmIA9Qn9Sawf4TjpxlAhzv/UYdPYIMCkaMFJvnylj
 zeTl4j+KkhKaIPAodafyVq3mubFmS7TRo0fDvu7++RsjVnVwXYcYCD6TnOypf2/z0W5Qd8ae
 gof+zElqu4580nDosTBswOQnGbDmTwGVZ1rH/xn9SCh6ofkzwu5Pz1RJtJeU+AOuMgzTD0s8
 1aGmdL1GDBi2IF5r1rAqt94ShvvZEAowX8+iTwsFlBdsoOzyG0npleeEIg/TfLdYsjdRGmY/
 tyckMQpa1z/Z+Yi06G2+zgraBrz+8CRFGbZCugrN19JAytwYIqjIoev81WevLBLLZ2SSR+Ku
 31sdymiAAImU8rleM+lGbpl8FSVCxCta2S0bblHQ8NJythV0yT/Fb28GRknTKuTDu4KeCXyf
 GjYsh5L6ZlYMROCNPEmP9zrWpRxlvm5SLwJs8w4iPIQOvCdkyfZpElTibK4gwgBbWB1y/hkY
 MfHGSpSJS9FVv8PIMWKqxc1iO93mX9WKZL7TpHgxBPvyquFeHOQUt843KimMIgEAFe/iFyNq
 b53bpLSoz0GCbGWSneMq+Y7cwtVRUXX8Lir8aS7gMbZfFo/cIzgYteMqY4cl3tNxPoIyb6Zr
 yjjASe1CjPX3BX6FOlDUVg6AJvHVpdkpnV9NispVWtEEVB6PO5DMI93m0MLQIQa
IronPort-HdrOrdr: A9a23:Utjjq6CdV0gm30blHejlsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdvZJhBo7y90KnpewKkyXcH2/huAV7EZnirhILIFvAu0WKG+UyDJ8SQzJ8h6U
 4NSdkYNDSSNyk0sS+Z2njFLz9I+rDum87Y4Ja7854Hd3ATV0gU1XYCNu/tKDwMeOApP+teKL
 OsouB8i36Lf3MRYs6nBn8DcdTiirTw/q7OUFotPTJizBOBow+JxdfBfiRw2C1wbxp/hZMZtU
 TVmQ3w4auu99uhzAXH6mPV55NK3PP819pqHqW3+4koAwSprjztSJVqWrWEsjxwivqo8kwWnN
 7FpAplF9hv6knWYnq+rXLWqkndOXcVmjzfIG2j8D7eSP/CNXYH4g169MVkmy7imggdVRdHoe
 R2NiyixsNq5Fj77VXADpDzJmFXfwyP0DQfeSp5tQ0FbWPYA4Uh9bA37QdbFowNEzn9751iGO
 5yDNvE7PITal+CaWvF11MfiOBEc05DaCtueHJy8/C9wnxThjR03kEYzMsQkjMJ8488UYBN46
 DBPr5znL9DQ8cKZeYlbd1xC/efGyjIW1bBIWiSKVPoGOUOPG/MsYf+5PEw6PuxcJIFwZMukN
 DKUU9et2Q1Z0XyYPf+l6Fj41TIWiGwTD7twsZR69xwvaD9XqPiNWmZRFUng6Kb0oIi6w3gKo
 KO0b5tcorexDHVaPV0NiXFKutvFUU=
X-Talos-CUID: 9a23:nP/XjWPDadzjRu5DZDEg02wOFIcefmyA0Vb8A2KIJWtJcejA
X-Talos-MUID: =?us-ascii?q?9a23=3Any4LTg26Umc6C4/yTifynRBEADUj4fSUAhxdj9I?=
 =?us-ascii?q?/6sCJbzBeFjOBrA6Ka9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 04:20:26 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 38E4KQS8019485
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 04:20:26 GMT
X-CSE-ConnectionGUID: zvQyuugOQO2xQOrQK+7DeQ==
X-CSE-MsgGUID: D/VALttGRwycxb/U8TaVZA==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,144,1688428800"; 
   d="scan'208";a="1477043"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 04:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB4KXNuCegW03m5wlffyW7P4ps3QxArH/+Ce5ru66TyOCy6kEQU5nfwpE5FpVzQNOFfRSq2uPwLXdlkRVmtmlFfrsTUhpRxqMqe9oBHY6uwClo/wnsHjWMIg6qsYh+oFEX4CTHmPtuLfenrcerEjSyw4LmdlxkBHh8CT0KtXfHhU5ctTBsdTQBPqFWHJfjJEBhmmO8VEv5ERmeSB8+7/g7iYIlGOq4nWz1SdhIY8fS3PM3Rv3l2+wZMmWb7G6PN+LePK/R21HG/KAs6JLaeKccMWXIouy/b13Ro4LiUJ68gzRB+9PBnmBZ8kMJBzQnwCIluEagYqP2lCvOdBOhzGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+E06CTrqMLewEinkfTKC9SRzbZSPrnKnL8dGK925GM=;
 b=SlEdq3DKmI+KxDbU7YnM2D6Q+wndUyB3iQ57111TZq3Zulo+YkdgETCDTDCnHQwFV01WRFUbo2vVWeRTuU25T/upE3VRT0IgW0yN2noFKs40DxQgf9zxTXq5XrW6PqX9m2v0ih+QXM8LzFZszPyj4j/avcEWQMnrcQwixbuxnF64CvQGpqFY51IJjt7bpmt1VHZ9kQ0GZdI4QpjdGxQMuvKidzcrEHbVBgYChuBr+rxp7/5ZCs4xLiDzGZ5XOq4hcWRVK7x9mMXXCfI2jp9cPqgYkhGN5HVVMF+y2sUGXITnmj9SSaS3QM2ZMCL32S/UGDK9DSVvY8y/kRM3xS2zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+E06CTrqMLewEinkfTKC9SRzbZSPrnKnL8dGK925GM=;
 b=gftP/wwzHBtzQmX2hulWlpQUKRYvfeSf1HOcVE+yPdCcNZCshSMcyn0/Tcd8iTEqMxz3NygYyV4cmMtw1QKPcgG+HdPiwaV6V6ILvafsyxXyP9bBF0gpm+1R+fKirQQiRJvWpczEZ22bv+1l/U32kEVxzwwB7U0MRhigEPRlZFo=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH0PR11MB5580.namprd11.prod.outlook.com (2603:10b6:510:e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Thu, 14 Sep
 2023 04:20:24 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::4877:8f0b:4cfc:d4f8]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::4877:8f0b:4cfc:d4f8%3]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 04:20:24 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Request to backport commit id:
 15924b0503630016dee4dbb945a8df4df659070b to 6.5/scsi-fixes
Thread-Topic: Request to backport commit id:
 15924b0503630016dee4dbb945a8df4df659070b to 6.5/scsi-fixes
Thread-Index: AdnmwqZNdeSFb8WnQiCx9WZDyFMKyQ==
Date:   Thu, 14 Sep 2023 04:20:24 +0000
Message-ID: <SJ0PR11MB58965FCA74A2B0DD13E965A8C3F7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH0PR11MB5580:EE_
x-ms-office365-filtering-correlation-id: 2dec8e84-45b4-4c5b-76df-08dbb4d9eac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nb9xZ4FCk3WexZqWS6lZwmZs+5WZMf+k5yG2lRmdqiuIXebNWQcfQGskDVuDduf9CifwoV7z9AUxG6rG4gdDwmYlv58NzPvqQWCINBY9Bm7n/EoxXdnBVf20iozYHcZcjSS4ytzNlsCtspO741yvZnXUnEP+1BRzWduECj79O+EjQJbLVVkZqxURyEc/GARt10lWY7frDmPME/1Lq6TRJgKF6OnR/yrxueegkwTPaEJU2emGc5OsLGx27fXXWvEKfCSXGzDV3xJiwJ4P875Z+AERkhsuwmCtdT3yOVbKUd6G9ArKPn22TlA1dBCVG4RZw0ETKdyYmALqvB52SqhXOl98+ysabiSOk3g/D++RuM1jZTelj3TJztOUpNMhzeA7SY6zBEUoFraW+c17S1A3IaFkwyOeKlA0g0AMiXeNrUpB4gFy6oK+lckPAc2xEvVkqxRXFrOOSg1jzEA7JpZJVuTofajCoV2BlXueqwgzFKUDSkIGrMVtlcSf47eTSDtV+eM+KSh5Pvwt+dgGQ4nJz+PEoujdtYrBa9gVv1O8eyC1Mna91wQtOr4gpiYUBGrkuMeZLgLoDkaIFgTv3UbVVTBWXpKpxWcbNWx4aj1VDZ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199024)(1800799009)(186009)(38070700005)(38100700002)(122000001)(33656002)(55016003)(86362001)(66946007)(7696005)(478600001)(5660300002)(6506007)(66476007)(8676002)(54906003)(66556008)(8936002)(66446008)(64756008)(52536014)(71200400001)(2906002)(4326008)(76116006)(966005)(83380400001)(9686003)(41300700001)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V90vZT1PGSRpeZvsQIbM4U8b4cIVpIFrbr2zj0q85/o+AoELNtYAn1LFTPi1?=
 =?us-ascii?Q?uhcQoY41QDiZGXajAeBAFvixUmmlv+DR7xdZZLpMt98kuEWfpTSaFP6X5GHF?=
 =?us-ascii?Q?ux8Fg/3/o1JhCXv3ZvgwumGmOPBMsLRMByLEoN4znhRqSpOzo+mlyimATTME?=
 =?us-ascii?Q?/yEomEAhDHtoQ56hqPgJH/6Z6UzURwHFiLI4Zl9wrg+SaCoLOFsmXHHBzghp?=
 =?us-ascii?Q?yk/pMP3aQ7+1F20ZGxHeww+VHQ6GOQnnECLmGvipJL30NYa6wUpLl7SVqr5H?=
 =?us-ascii?Q?IUUZyH5WGHGnKEZnhOso/2uZTHXfX/aqqDDoR2DVhBHG8wsRxlOdHX/gge+X?=
 =?us-ascii?Q?jqMYr4vBAti2H7COhhFBh7y8dlLbtw7ijRZmrUY4PInH+Zhqn9yowamDml+6?=
 =?us-ascii?Q?TdG9zqHZvg/NhILj9IRurDDCGEOcYm02p1FLhLxeyOxyu2C2vMpkc+ZkGx6g?=
 =?us-ascii?Q?5zPjnKEaA44SS0GlxoiJHVacGSGZAAspSqd4QE+nmwcCHuMJBCFi9oaYib7b?=
 =?us-ascii?Q?bdmopaYI8dFdKUkKLYCnGzCAOY2KOG7nqP9Lp7s7SwACb2kCjqcZS2JWbK3p?=
 =?us-ascii?Q?P/Zpk5YA3BeCquCJ6PPUs75KcWPWJiLkfgrdnig+iwJTqrabLa0DW/Odb8mr?=
 =?us-ascii?Q?r1uEkqIgP1BRhsRpMgzxep/0cSs43iVJX/SqcYzNWOAsx2y0mViCpoARM+7J?=
 =?us-ascii?Q?d2Dnqk7A/yyANwyRe/sgxxIDCFL7vixiWBtYxLcsXHAkLrGoSv0m9PkN4mou?=
 =?us-ascii?Q?UdVRwMntqnc9s306CvCaHGsrcYjGMN9zezmZg1PxB+LIYPTMCZQdXNuq47HV?=
 =?us-ascii?Q?rBAV5tq9rgX9j63ukwv7ygs1CphPdnTslY6JBt2qGJmUDFKwyPsEa+F/Xn9F?=
 =?us-ascii?Q?rvV83dLGLAHCwuSMwUSmAf5tuCaNh46sfSPBPwOSk3cpGtAMvGzvnyts0gJp?=
 =?us-ascii?Q?LMDndHD00uLjuAPusIf1StERO5B7rmu39+M/no5Yg44+ErMWzwYckV+d0qZC?=
 =?us-ascii?Q?kvlagDM++js6gos8uZGMXQOGcgLpH0MjBPMhPFIoQFC8ifqAleV+8k0WkE57?=
 =?us-ascii?Q?PsM4W/Q+eNplWju3H7E4fS2mDnEgiNl+YLxjvp+XSEt3yNIZeU7OJ2K5XsFI?=
 =?us-ascii?Q?E1h4ChrOQfUmDHRw6JgtqX8vuG7SDjVkiaXFfUU1htdS6iya8dI85yvwDmy/?=
 =?us-ascii?Q?NMChgAQDYphS6++jA2Bfg+OewnpRO2wlmzFXwdslKdFBCRh6uEDHrOrd8i/q?=
 =?us-ascii?Q?rFEK9CAbQtauOMV+8DNDX8j5XMpDMN/T+m3wMukjgmXViK8SjYyWl8qLmWU/?=
 =?us-ascii?Q?dj6Qdf7ECBell7MKEfqtB6E4fipzfoA5njEO8iAGRKS7rh8LRiCNOPPLzybE?=
 =?us-ascii?Q?YmcP4dGYhrF30hCyWFmd1DXzzVIV716MID20oHW2Qxo/lEXvbWCoNatOC48z?=
 =?us-ascii?Q?p/7BYpGaCpXbF6fU8rYQAZknikDnKw7Rtrdhrk1LssMVrK1n5wo5+IfT1XLO?=
 =?us-ascii?Q?hyzbZbnpKJpX5OcvRs5o4I/gMu4D1fRPVYkkY7jqBDUfjeWNxQsqk9NwOgHh?=
 =?us-ascii?Q?hzk8ZvVGYOPzq7G3UCikLHRhlwioXrdG7wRWICqgY3Y7LW5Ec12IGY56AZOA?=
 =?us-ascii?Q?vzAK4M4ZgqY26fBia4UJxedQtBi0dvKNqCD/TdzholVr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dec8e84-45b4-4c5b-76df-08dbb4d9eac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 04:20:24.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZo4V7VN6qNPwUWaA9q6CePfs3c3dSU6MXxSzmveUUGvoeBKwRVQM1fooisCA6mjOqCIGArvGUGzuK2nZdnpGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5580
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-9.cisco.com
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

(Re-sending email since the previous email was undeliverable due to HTML co=
ntent)

Hi Team,

This is a request to backport the following fix to 6.5/scsi-fixes. This was=
 merged into Linus' tree.=20

This fix fixes a crash due to a null pointer exception when a lun reset is =
issued from sgreset for a lun.=20
With this fix, there is no longer a crash.

I have another fix, which I have tested, dependent on this fix. It is curre=
ntly in the pipeline.
I'll send out a patch for that fix when the internal review is complete.

Please let me know if you need any more information to backport this fix.

commit 15924b0503630016dee4dbb945a8df4df659070b
Author: Karan Tilak Kumar kartilak@cisco.com
Date:   Thu Aug 17 11:21:46 2023 -0700

    scsi: fnic: Replace sgreset tag with max_tag_id

    sgreset is issued with a SCSI command pointer. The device reset code
    assumes that it was issued on a hardware queue, and calls block multiqu=
eue
    layer. However, the assumption is broken, and there is no hardware queu=
e
    associated with the sgreset, and this leads to a crash due to a null
    pointer exception.

    Fix the code to use the max_tag_id as a tag which does not overlap with=
 the
    other tags issued by mid layer.

    Tested by running FC traffic for a few minutes, and by issuing sgreset =
on
    the device in parallel.  Without the fix, the crash is observed right a=
way.
    With this fix, no crash is observed.

    Reviewed-by: Sesidhar Baddela sebaddel@cisco.com
    Tested-by: Karan Tilak Kumar kartilak@cisco.com
    Signed-off-by: Karan Tilak Kumar kartilak@cisco.com
    Link: https://lore.kernel.org/r/20230817182146.229059-1-kartilak@cisco.=
com
    Signed-off-by: Martin K. Petersen martin.petersen@oracle.com


Thanks,
Karan

