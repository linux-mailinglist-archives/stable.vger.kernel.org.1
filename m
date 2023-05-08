Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655886FBB06
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 00:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjEHW0s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 18:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjEHW0q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 18:26:46 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23711B;
        Mon,  8 May 2023 15:26:45 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348Jnosx030754;
        Mon, 8 May 2023 15:26:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=6K0hYd9N6sWGdWUeR2Tl3e46b7MGBqmkQPli30EbF0c=;
 b=BCpJNuyyhLLjgguhC1dYJpiHsaT/8J8nyEkvWIcNdynoNNm518B89qF5cxdN5OnOideZ
 SsxpopGm68OX9RwfXH5SoMDGvGxy869eVv/ib3AOcyg4KNY2sYiDYBeQclpDm+AvooSN
 MFDVyPF+8UjwuYwqAfZllaGTkciwWPaizT0O5q87KLWZjGKJtifs1/4m2iqQgSdd5jIK
 YS9ixwaEdyOlOwjVvX0O/N6euY0JLos2Gin0nsmnRzkmod8mEPJY3Tf5F2hYPjHPozud
 4r7nCuRtgqz8afeMnsA0swwj7xYi0om6ynSb03FOQE8nvyE2C2Wv+nr/Rjn+0BJv4njP Aw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qf77trnwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 15:26:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683584789; bh=6K0hYd9N6sWGdWUeR2Tl3e46b7MGBqmkQPli30EbF0c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j8b4ZnyG+iGH4KWfzfGUDXyZ5X4scgJodbS2Evbhs7e638A233qvdsP63Hfs+P1Ph
         23B8ocuksHdSFKgazVCfMOmWs+DcPYlkvdJjCfp3Q4ehBmqP1jxJN9iF9Z21hAmtRc
         AVk9cpqV2Pe5+K9AtyCiaEu7Dt3ky64W+5CqAEHLN9JCBHcP1BdDKEcjz2oZy0qbXw
         DYLlKRf4imySbwqmnyRypdwe6ZBiVJe53jL0lxZmtiUAw3MMd6nkDjt0KBY4PEEqcD
         6cqAd3nufX/mdfhU0r2FXeLe78b0qs07DLt/Cew0pfbKz4cGTq+MhjAfHMg3u8COFo
         erRJ/w5p9txGw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7F14940407;
        Mon,  8 May 2023 22:26:29 +0000 (UTC)
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4CE6BA0068;
        Mon,  8 May 2023 22:26:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=gEYho3kE;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E08E340407;
        Mon,  8 May 2023 22:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtDYSfBPLqc4Ocr7DDfVTpIXNF3tC7c1lPGV/cVu8vccSVm94BeuNkYQAZJ4Kqg+GI3kjJa3ktAeP2Y9yL5aI1E4VZO445+JiQWgp/+wEe0owTyBcABlbfH6dxZ7kjtvweaz2dRuW4cGc7jKTgjXhwImVth5NowCHdgT+CSw4CC36g4WRd8uIYjGKH7z+U9BSIuUdFJB9Ij/JjS5I2Xow6nIou3w+RdrmS2WfqbRIcBF/vXsUYg+XdWSR2/gX0RigC/tiZYVbjulQLSPJOkd2HkASacbWU0yoKrf4av74jHVOmAzvXtkVGRpykaEgEDFSVIASDuV7h6LmrSvQjJctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K0hYd9N6sWGdWUeR2Tl3e46b7MGBqmkQPli30EbF0c=;
 b=Tfv2W5NwDBTPkd57lXAFW5Lwfg1arC6GH+oJx4DoZzsPa1YJWnyecIcwnIO/T9IuXN8wNLcCHaJyZ/TBkVhcvGvMgDTenAefIHJu8D8aoA+aCc/vAfx/WuG5H14ef1ml+1zyd5n+F8pOb/R88ffHB+YiKTrV4QVgWR3TdslGfr5dsP35vG1vf++z7QiwFsI/r6Hq27eryx/Cyc/oP65nQbnJ3aaFGN72pz5CFeq29JlVJ8DedgaWof+cMbaHp/rBU9RH+rDdLedCAS0I/J3AAYfbX+iD9muAheRQb71MI3qBSIV2Ol0lqCD8/5VvSHK+zHykdsffxXFmlH0iz5WrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K0hYd9N6sWGdWUeR2Tl3e46b7MGBqmkQPli30EbF0c=;
 b=gEYho3kEbV2oTLpKBD9QEbZ+Mi8JI0Jq1lI7/OaJt7qD9BZr6xF61CsNJeiGSTQsqH9aFBxC7yrMREvvoq2sBVpzqs5y7D/H/8PNnxKH6yWTTJTgmYjzUuHOL2j6z5xtWuSIoVeeLEAuRfWsCqwGPb4IUNYhGZJr6SK40WaydiM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 22:26:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:26:24 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v9] usb: dwc3: debugfs: Prevent any register access when
 devices is runtime suspended
Thread-Topic: [PATCH v9] usb: dwc3: debugfs: Prevent any register access when
 devices is runtime suspended
Thread-Index: AQHZf2l4kcoPHu1YZ0iajCwW37QBSq9MdeQAgAPNWgCAALYpgA==
Date:   Mon, 8 May 2023 22:26:23 +0000
Message-ID: <20230508222621.zjctxk5zhejoully@synopsys.com>
References: <20230505155103.30098-1-quic_ugoswami@quicinc.com>
 <20230506013036.j533xncixkky5uf6@synopsys.com>
 <ZFjePu8Wb6NUwCav@hovoldconsulting.com>
In-Reply-To: <ZFjePu8Wb6NUwCav@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB8244:EE_
x-ms-office365-filtering-correlation-id: 23149959-cda4-4a8c-df9a-08db501341b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c5XN/M6OWEeS1SsMZ1uhMFTKFXnKcgZkSh4//HMQETOtDpQHSW8yyARNN5foC09OeUved5mHolK7A7CyFSXkz6S4kHTbHGy1YxuUpv1oWKK1is8ObL8Zu29BdjVYZQfL5bVRD2HcwSMX3sjoLSV4+Y/eiJ4hRBsrlGUI1rGBJlRGhEWmCwq4WWue6TO7TZx7yGoQJL3taioXsUP29a86Ay30Fqd4VkqiewagZyVvCGm+4kZNvf0uttgXgyWaQjtEKQMvoKhmswkaCBQFEpdK206XP0UnT6/vt4JTWd7ddIV08G9wfy/2aKH15HnwIZnoUHII3GsONNDzW/dJUlrlQZEePKwNN3fySRwWEB6nrGdxdQ+T/U+FCcyRzphAvki3c4Qofac7wT71djxU8xNKnesN3Ebf+UcQdB9MO7I/wsaZImUgiTzqEVlsMfMvwWvJDn+sTvJUwrAowKzuL0VPEK6VV+8esvAu+JyHtiPOv+TgyWsqYNchtvtxueqWv7OlgaWrWByw2wIJW0mzEpX61kUDkTF9s5OMg4h1/H3G7vLOBqPVVJ0EhIxN2ABcj6b7RT58k1W0qE5h7EEdsdC5ePqteZk0/1DrwxFZKLEdvLn747SYcNq1Euz6YT6ZN2Gb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(2906002)(4744005)(54906003)(478600001)(41300700001)(8676002)(8936002)(316002)(71200400001)(66946007)(5660300002)(66556008)(64756008)(66476007)(66446008)(6916009)(4326008)(76116006)(6486002)(6512007)(1076003)(26005)(6506007)(186003)(36756003)(2616005)(38070700005)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkEvVHltLzdRYWw0cmJzRi9CWFJBL2MrSlRlZHkrYTBmZ21MZWM2SGhibnh6?=
 =?utf-8?B?TUJ3M2RSZ1I1VGg5YjBYMHA0MDBQV3gyM3grb1d1NUN4Y0tML05zTWlEc3po?=
 =?utf-8?B?UmR0MVJ4eGtpUHExUmt0SFluZlZoaEFZM0tJc3Jjd3l6NXdPNFVkQTkvc3I1?=
 =?utf-8?B?ZHJpeHVETmRobmYyeGtaNGE2aWY4WFVnTGhYbFFhaTlTMUJpLzZZa3Uva3J2?=
 =?utf-8?B?QzhiTjdKV2hWajlJZkxzYSszeHlzcEhldGw5ZTl0bDBNS01kQ0hUaysyQVV6?=
 =?utf-8?B?cDkrWnIyS2JwNHdYZWRYa3Q0dit5T21TU0YwQ0FxcEcxYllSNWlsbUY1b2FD?=
 =?utf-8?B?R29tQ2c1RmtCRExsRXc1bDg0bWcrYUdUV2U3WTBXN1g3WkxtL21hNnhIUUpr?=
 =?utf-8?B?V0lWbWFTQmZGd0FuRVJxNmpYcm14dk9GRXV5SkZIcSt1YkwyVFVCUXdsQU5n?=
 =?utf-8?B?S241bndsVkxTOEp5Q0ZZc25aRUwxYjNYaWt1T2RkaU94OE5PQktGcjl1WEZZ?=
 =?utf-8?B?WmxObGFocGZpdHZQWWVTUTB1V3pYYjdCcVhCTFVEUVptV3BHK1lVbG9lakoy?=
 =?utf-8?B?enQ3QjFydkZGdm5hYWNKaUNFWmFNcW1RbVYyZlF0dmY5MElYY2xwOGtYRVZr?=
 =?utf-8?B?cE9VU1JYdS94cGJMSWhoakpPUUFEMzBJUVJqTGdpVVV4ZzdOaExzaDZVelVa?=
 =?utf-8?B?SjZ5dUUxVTBXLzY2SzhNM1hOcVNaTXMzM1J2TmVKOXR0Vnh3T2txUnpma1My?=
 =?utf-8?B?UXJ2YWo0eFRXWlFmS04rQWhhVGdmNzIzV0NKVjlDcE5xU2J1RzZWNDVxREVi?=
 =?utf-8?B?YkFwWVZQU0NaSmJwdUtVMFRhMTdBNjd6bjB2WWxVanZqVnBnZ2J4WGNrNFl2?=
 =?utf-8?B?a1p0SGVlRWtuRWRXRE1rczFjalluTHI3bGJqajA3NW8xOWU4Zm0rQXJlcFJC?=
 =?utf-8?B?MitvdFQvZFc2TXNYNGVvQjk5ajFCWFBsd05Ea0RsQmxqOURGamxLMHhQUDFZ?=
 =?utf-8?B?ckNMNG5kNUhNMUdocDlFTUFOdjA2NXBRWi9FcU5XSkFNK2JLZTZxU1dJUTlK?=
 =?utf-8?B?ZUxzS0d0dERxQjlseTFEVzFjRmZFa2hUcFJyeFhwNWdlODFYOEtob2dSaVM1?=
 =?utf-8?B?aFpZaVppeXdoNWdvQkVrWUwwTG9taU10WHJ4MWNHRllPZDlKV1lJSE5aWW91?=
 =?utf-8?B?UEdzWFZyRzZLZVlTYm5wazhtQnhIcU1MY0xUd3dhZ2taaXJWRFRsYlNiUGVX?=
 =?utf-8?B?Y3k2VmIwWUV0QzdUVCtaSFQyNnJPZTZmV1dPeDZGcm1EMytiQ1BPeXRxTGIw?=
 =?utf-8?B?NENrWUdMUllCenAxcnVGQWFIMmtJR0VsdUdDY0VadDZRUC9ycWREbldXdXpt?=
 =?utf-8?B?eE8yWm5UR0FwVzVRN3FjVGN2OHZBRW54a0kyL0NvVU1LNExrUXAxMzlNMjV5?=
 =?utf-8?B?b2xiR0pkM1RFbjNhZEpLc0o5Rkp1RGdnTEJtVXRNM0FoUHdodVZXM0UrMWp0?=
 =?utf-8?B?ejB4Q3FLZ3N4RndzaDE4UzcvMmxyWG9VbytVQU1nWDhEWFNXUmxFdlo4aFl4?=
 =?utf-8?B?OXV5REhoMVY2U2prVE56ME16dWRxcXNPZWZoa2dJakE0ZmdBaUFva09nMGow?=
 =?utf-8?B?bmYwQ2tkRkxvNkI1SmpnaXkwUHlZdEd6aUhveTlsYkVuZDAvNUNIMXEvNysw?=
 =?utf-8?B?ZVA1TFFEem5Oek5od3R1VkpONFl2WEFONkdaNXBYNzlDNTVHdS9GVEtNOHJi?=
 =?utf-8?B?aWtTRDg4SXBpR2M5bTZmdVo0NGZwU2c1cG0yeXN3SVAzWjBHeWp5V0ZMSmlH?=
 =?utf-8?B?WnA4cnBMUEdvd0ttS0diVnRrc3VUMWVoRjZuZW9PNHpyRUV0RkZPOUg4N0dx?=
 =?utf-8?B?bjFmdlY1dlFIaDhnSnJRcDBwaXhac0JxZnBZWEtJa1RWOTJwQTh1MVVlQ2I4?=
 =?utf-8?B?UjNHeHNPVnZtYmthTG50eFFIbVhoR0JUalo1UWszRnVLZjk1N1hHNkhNMnl6?=
 =?utf-8?B?cWt6TUJVRzZBdUZzNUNia0c4emh6ZVJNLzRJY1VVVnVvSmpLV3VTTGwyb0Nh?=
 =?utf-8?B?bTRLdEx1VS9mUVI5K3NGMHBCUjQ2MUhBL2YxYmE3eGdPdStnNURDejY4Wkxy?=
 =?utf-8?Q?Yk0xlDk4BHEPlXoCJgg4mW4Yr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11D06A6A2FAF664CA0628961BB6D8E7A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T2tpSFZ0bWJRam1uMkhGUkl6WWdLMHIvSmMvRld6anZPSzA1MVdzMFp2Z1Bn?=
 =?utf-8?B?bUdJVVhPeDE1ZXNsYzdFUUE4WDFrdkJxbWRSbTRjZ2RDZjlzSGUwSVIrQ1lp?=
 =?utf-8?B?Y3dtNmdzTndiMTgyTHl6Vkh6TE1aTVJkYUUvZXZDZnlMUG5mRXZhM0NqNXpm?=
 =?utf-8?B?UmFmU0VxTi9haWp3R3FwWXFKSTJXUG1jR05zdkk0bTNjVEdqWHR2RDJuNWwr?=
 =?utf-8?B?Yk9RMWMrNHJTcVArNVYvV25TOUh0cjlVNUFrMWdGV1owTzRUZXhLdTAvTktJ?=
 =?utf-8?B?aEwyVkxHekZjc1kvbFFWU0NQMzVFTk42QU8xdENhRzZQYklUSTcrL2hwazdZ?=
 =?utf-8?B?T0xOYmdvaVJ4ek15VWZqNnF1c0FwUzhZZ1N6azBoSC9ROHBWY1phNlFTRkxF?=
 =?utf-8?B?eDdSbWYwTVlValE1SVkwNFYrL2lFWmRIdHlIYlBaSWV5OTM4emFLaUViWk5v?=
 =?utf-8?B?WWRES1kraXR1RS8wUkRmK1RnN0RWSVJUZmIvNVNNVyt3UDB1OEZwWWQvanlr?=
 =?utf-8?B?ZGV3VjhWUTVRZGVROXMveTFWSEhBcGVOVDk0amx0aHMrblQwMkxjdG1sYUc5?=
 =?utf-8?B?V3dsWEhtNTFKOCt2aDJtT3VIdkZmRXBNbVE2U2lERUxodnNrOGRJb1FVRHkw?=
 =?utf-8?B?YVVqMk16TmR3dFpEZm4rSjhQNEViWVZVNDcrMTF2dEs3VUk5UFdTMkdTTTlz?=
 =?utf-8?B?cTJwVm9TNVMvNEFGcm0zK043MDR1VzZjTXluN0VZVjQ5TTRHUTkzRjRYWEp0?=
 =?utf-8?B?a25sa2NXVmN3WEpwT2hickV1UXdKZnhOTkZvazBSSDNtV3lsWVErYUdIM0lW?=
 =?utf-8?B?UUw1SXFFbFBIbHptTTNRdUtwaUtRMW5USnNubTlXSEpsYVRFQU94NGRscjdR?=
 =?utf-8?B?a2hQTEpTUkVQeUNJVEVKSSthOXhsT0lPdEVhSG8xZlNyV1Z0azBvT1dZcm5w?=
 =?utf-8?B?OHV0cHdUQWx2VnE4b1gwUW12eVFHeVBIaWNCTmJXQlJqbC9xOEo0cllqQ2M4?=
 =?utf-8?B?dVF3M0d3bDV6T0tRN2JyU1lPaG1RN0NOWUZEUjVzVDBsdjltZFVZS1JCWjAy?=
 =?utf-8?B?c0NVODN2VWtYaHdGK3BIZTRMV005ZEdQd1h2N3pidklqcHhKM3ZOajdRTjh6?=
 =?utf-8?B?WDlhL3RjaXZXRGVYbkdXNVRiMGJld0NSaURWNHkwMkxSaW4xalBXbFpyM3JR?=
 =?utf-8?B?NlhWRkNWTlZWcVEzL1RNTVpkN3J3d05JUnhYM3U1RnlJemZoZmQ5NVNsaVg4?=
 =?utf-8?Q?yqlXxG2jltUIfTl?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23149959-cda4-4a8c-df9a-08db501341b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 22:26:23.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /mrmgNRD0kApKhQmhiDzaZoWH+5i86e0hY4Mzi+5hpzO0FDlHMPcnwcgLrknZBiVcwXDPNlMporPcUW1xQ27QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Proofpoint-GUID: In9tIfOf9XNjuBjRhToPPpNtBGZu-Ews
X-Proofpoint-ORIG-GUID: In9tIfOf9XNjuBjRhToPPpNtBGZu-Ews
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=460 clxscore=1011 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305080148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gTW9uLCBNYXkgMDgsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gDQo+IFRoZSBzdGFi
bGUgcnVsZXMgYXJlIGZsZXhpYmxlLCBidXQgaXQgbWF5IGFsc28gYmUgcG9zc2libGUgdG8gYnJl
YWsgdGhlDQo+IHBhdGNoIHVwIGluIHBpZWNlcyBhbmQgYWRkIGEgY29ycmVzcG9uZGluZyBGaXhl
cyB0YWcuDQo+IA0KPiBKb2hhbg0KDQpJbiB0aGlzIGNhc2UsIEknZCBwcmVmZXIgdG8ga2VlcCBp
dCBhbGwgaW4gYSBzaW5nbGUgcGF0Y2ggdG8gZWFzaWx5DQp0cmFjayB0aGUgY2hhbmdlLiBBbnlv
bmUgd2hvIG5lZWRzIHRoaXMgZm9yIHRoZSBvbGRlciBrZXJuZWwgY2FuIHJld29yaw0KdGhlIHVw
c3RyZWFtIHZlcnNpb24gZm9yIGJhY2twb3J0Lg0KDQpUaGFua3MsDQpUaGluaA==
