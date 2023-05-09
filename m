Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7276FD187
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 23:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjEIVi2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 17:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEIViU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 17:38:20 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D541FCC;
        Tue,  9 May 2023 14:37:59 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349JdoXE029357;
        Tue, 9 May 2023 14:37:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Yf7bckJnCioMuiumioNdTkhUua5sL96aYb4yGG8qupM=;
 b=DVl2y0k//1jycSB1Vrc76e/97E1ai9QEcDPCGUrYrdXDXmCGrFqiKAfiXRranoHHoA31
 /6+rtjkDc0zW8e/C/ZyQXBALRoao2/vSN1+7B0NpUweDcNPf446iSLRhJh5lX6K/3bnB
 BzWxUq53WlASMof/yIYMkQR6vcUE3DlPU9PVkq7SdrJVePzahOvHvrSLlDsZY2pnTa1N
 ZegCOcYmXGWNtzsGA7RugYvyqCQnmWdx51HygSV+DcFwDD6M9bs42cU8YP/k00X4W9dn
 Zfc8yCG8fg0lEjBcpIt4SiH8PqzausLn2syzufAL1gA4sjU1MRj2uSH/xAg9cnc1PhjF Ng== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3qf77ue97t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 14:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683668267; bh=Yf7bckJnCioMuiumioNdTkhUua5sL96aYb4yGG8qupM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OkJxxNxwLTli5DtHXhrmX64aclfaSMDEigr5TPsWJMQK+e2vAv5CdIZAF1+mvBq2l
         uqyY/VmKtrwpOSOA+X72Bl4DnSuNex1+zA+dS9ugwu9hyGxOGscYI9eV/T9MbLOT2z
         UtT2XQjWuSYOrpyUAiI+eCpUviZQeZBovncrI4j8Nv8ZWQTD09VSglGvHKsYpHy4AD
         hkpfo6Wikvte/HVBrFp8uF26Vcwxd/uYquhPHNmUI2fYu7Ju5QMMCEzaEe6yG2/4mG
         kp5Cz5pGE9sGN6NVBu1Ch7WsJfAG+TE6DZswsLIYkuEKbTFGvPwkvsXl/SGmvFfMvp
         bR5mQFQs6uONA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3D0264045D;
        Tue,  9 May 2023 21:37:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C4354A0095;
        Tue,  9 May 2023 21:37:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZQSMuPnI;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5106E40681;
        Tue,  9 May 2023 21:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeSJeEWwAOj+e/5zAl8qAnYH/CoBQ6XojiitXm9SUSR+vBuKO8wQ4XtM/H30TDnU7nWJ0IklnbaBKSbxnqcm7tL0f/GgwPo1OnnO74Iq0/tdF+jRgF8Edeglurbpo/MeT4JzDMH2w6Oum09bSiFP4M8VvDQkjajFED90LjbXi+irYxbKGoXVXlxgngniXPmXWi4G9MiKcadAxXC3Lkb0ivfx8pY2qwBR2xcAG62w2Bx4lHWmSiWphC9zXO7SzZye9+lebMwxVZ/RKO+ZpfMzz9r+u3oOn0HBVFzNG0qkavGwDXfdBrNmJoMLkHCARREss6V6Zbnj/Mf19ALkB+F0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf7bckJnCioMuiumioNdTkhUua5sL96aYb4yGG8qupM=;
 b=V+E8KKx7XYCiJ/FaJbRxqayoXrs6kJIe7oZUpWeN6DKu8lH/qc/hDl5gs2Hq0sZq7BfPP3c4PMoeLC3yag0116+m7E4nPuq0H/OzIkl/15A4jkRGkJNHhV+f/G925FY3ySLHEoIrUYMjTGpepcDEoz7se4/0UM10/fBQX8mueloAC4wUFub46kYxU9fI8jneAMzXkT6evpro6Et6jM9O8Bl16Hb3yPbC7GPbv11e7NFIh3WgX7J0w2TwqNd8MS8g9Kh+FMakUE4bmZsKsy8/6SCWg/2aJabCDGNYXudEmZ97ayyjaaWhML5hOEJcbqyMHY6Tl/wUkQt0IogogHzDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf7bckJnCioMuiumioNdTkhUua5sL96aYb4yGG8qupM=;
 b=ZQSMuPnIogg1kln5Yef4Q6jhWIMLdxLlVOh1E85hh/tUtbRvTlGqul9C421u2NwLXjhTNaQD3irvHiwq8O1ebfzT38EZC9Fwri3FXwO8dXcHqH/uNGAaYGcgu9XMKXV7VDzrqtBB50B/+QsvbjtFhfEP/gFoKASCULrdraGTFZU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 21:37:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 21:37:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Udipto Goswami <quic_ugoswami@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v10] usb: dwc3: debugfs: Resume dwc3 before accessing
 registers
Thread-Topic: [PATCH v10] usb: dwc3: debugfs: Resume dwc3 before accessing
 registers
Thread-Index: AQHZgoVyaE2h0uts70ynv4+ZZpLDL69SCmqAgABthIA=
Date:   Tue, 9 May 2023 21:37:43 +0000
Message-ID: <20230509213743.bh7vbyk2z4lckps3@synopsys.com>
References: <20230509144836.6803-1-quic_ugoswami@quicinc.com>
 <ZFphSUFrUT6dMsQN@hovoldconsulting.com>
In-Reply-To: <ZFphSUFrUT6dMsQN@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB6941:EE_
x-ms-office365-filtering-correlation-id: 9636a347-8d63-464d-2a83-08db50d59f8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YU3IwGOgVUdykwtOPzKZlXOOpYljgoIOuXxttyiLDf88+irjC2HmTYvQM5Sz2zdtvVYMtHW/OYyWu0/5027Kk8XYKMzIrgDgTr4JT5esOUjpnnuaLmKman/GHYoQhzfDo2mYfRm+eSSYC1Odqnc+aCcF4ruytoufSiMaNEZFFyFkmsM3XHJZVyhZvZGpypO5o4P71kdRqb44q2GhagBq9uxvpHqrOjObsfI8GdMGGL6eWAu9izPlHEAUbvmu4PrAWZAzlclyIjkHBKMWofUhdW3AsUsKhIAdYcaypR+g0kaS5woq2XH9rVYvNQnDf57xkwCRNZ8eDmGy5x5HkDoSkLVZnpKQhiT3Q5vMqP3greZqguS/NO61+ek+d4er1qi5d/9vH04ySkVSFDqHAeWVwHDQ54NU+HALyy6hrU+pcGR4hD1kKMpQDj/OP+z6od7Z9K6bNM9MxWH0jGvgJ7t3tujrczO/QltkLS2QLCY/Tgs+DmPLUdoAiUMPMndHd2pWZP+DIluH2e6tNysYdix8tU0sYOnAxjZgsS5vmSYUnsfKG/mW5+pexBhu1t7MQ56jNE7CuKZHqPxsEAU/AsQoFkLVqpOYt2AKbtEL+B4Oy/FVPdYowHvF/3+rscxvwUx4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(6916009)(4326008)(86362001)(478600001)(76116006)(316002)(66946007)(66556008)(6486002)(64756008)(54906003)(66446008)(66476007)(36756003)(2616005)(83380400001)(6506007)(1076003)(26005)(6512007)(71200400001)(8936002)(5660300002)(41300700001)(8676002)(38100700002)(122000001)(2906002)(38070700005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTFqREpvRWZvZUhlNGxNckY3d1ppcmpMejJEYzh4SnZWZHVTeG5CZ0hEaG8y?=
 =?utf-8?B?cUZFR1R3cXNLSG54TkhRS2RsMXYzWHB1ZnBZeCszakt2aEdEQ3NOWUpWcXBu?=
 =?utf-8?B?Njl5bDc0bUtPVWdtQkQ2VU5jMkNzd25mb2hsUXFUVE8wZnBEUGxCbDh0UHYr?=
 =?utf-8?B?ZFRUMWh2SkUwNmxjNTlHZ3FhNXZVcDA5NHp2SUhqRTcrUU4xVktGaHJBWllY?=
 =?utf-8?B?Z2dkUStCRHpWMHBWWFRCVXI1REUrWkdzMjEzb0pXWUlyU3k4b2dBMTNDMng4?=
 =?utf-8?B?VHl1ZHZPblZjcWsrN29yZWcwYUV3WTE1amZXZUg2T3ZGZ01kVDdQR3pnTGo2?=
 =?utf-8?B?S2hYR3gvSFZzYi9IVGRYalNSUSt4TnJMNzhKMCtxRVFtUEhqZy9ydDg0ekha?=
 =?utf-8?B?YVA1Q0tYWURMVEwyTVVxdnpRVEtsM2tSeXFzQjNLUHh2MW5XRFVIRkhXc0pQ?=
 =?utf-8?B?MkF4eUs5SEFLUUoxVkJVdWNUaHFyeGx6K1QvaEFqVFNZTWdCY001eXhJU0h0?=
 =?utf-8?B?bklMMVFYcXMzU1NlRlU5Q05tWUlMQzR4aVVXVzNiYmw5NkR4SXV3a2F6d0pk?=
 =?utf-8?B?OERhbVR1dWkzYUk4bmJWbTNmL1k0NTBFVzVUWlhhRmRFTGttV3JZdVdrNmdG?=
 =?utf-8?B?T1VzQ1IxdFdTRFVuTXAxU004T0pCZk9UNk5mRWluSGZUVFVWTmx2Mi84QTRn?=
 =?utf-8?B?MzJNRGY2SWJDNmZROTlwL2pJV3IzeUFRdkhacmJJK2ZYbDI1WENmWUpPR2V3?=
 =?utf-8?B?RHgzWGRjRVdxZ29PSmhVVlp6Smt4Wm5ZWEtSR2ZobFZqampyOWhicy9RRTkw?=
 =?utf-8?B?RnpLQzZHVTBRbG1MQUJkZHVGNHVHdGsxdVdRVFFKUlV5VXdZeVNObkErUjda?=
 =?utf-8?B?UlhLNDFEM2VheUVCZk1Xa0gvai9lTE1aT01FTjNoaGZVbVVNNnF2aHUvQXY3?=
 =?utf-8?B?WUpWMWJIU1paWWxqQVhGZ1NQT2tMWk4xN3hmL29uSnExempIRFhROFBDLzdH?=
 =?utf-8?B?Y3QwclYxMVJzaUJ4WkVJUE4yY2x5amJlUHQ2d2o2VjJieVRrV09OUHh6RDdT?=
 =?utf-8?B?Q3BSUm5KbUpMY0cvL0hxRWlGUHFqRnJWeEs5T2J2T2M5WU9XOG1Fem9QUXFu?=
 =?utf-8?B?SEZVeXRpa0JDdWRiaFFBYkpKbTJNUGZpRTFpaDZRbUdwRmswQXVVUEZmN2Ir?=
 =?utf-8?B?ZFBBYmNoMVVGMDgrVjIvYUJnOFErR0xEVk9HZk1VbE9KRUd5YkdNaU8veFZ5?=
 =?utf-8?B?WkJxblZWeWYxWjhadVI1M21vRi9RMkw5VVVkVWVnUXlZeXNzN1VSMStadDk1?=
 =?utf-8?B?SWRhRVUwbEN6aVJFaSs4elY1VVo3aVRNTTY5VWN5dDN4RnFFVVFvRXFiSHVh?=
 =?utf-8?B?czRmOGdWdE8vSXpPd01sa3NlMGpObzlQQkpjMXdYUTViZnU3KytRaXJlOHQ1?=
 =?utf-8?B?M21yZ3I0MW0xYkl0V3FKTi9GNGtFS0RocU5BNTR3cG9vR2d3WFNhNlM1ZThx?=
 =?utf-8?B?MjJzUGxJZC83bkZ2TWMwb2JscXRuV1RZWTBPQmEvdnRrdkZmczFQd290RFor?=
 =?utf-8?B?VDVwSXJEbGp1aWYwbkdpYWdlNUlKYzhSUkQydlFmSzQ2MnkzNGgxd3dDelph?=
 =?utf-8?B?eExZdUl4MmhtWXZoSkRLK2trOWhBNmcxTUg2NkNLNUdoSjkzbmdHTkJlN0VB?=
 =?utf-8?B?ZHp1S1RDQ1lvTzdSVGxjNHFhYjAyaGFqeVkycWowRGlxM3pESUFLQjViNjRt?=
 =?utf-8?B?Rm80blROVzZiYWlhdHB2M3g0RGxSUXBPWjNPQmlyWFRTOGdyWVhjdXE1ZEpU?=
 =?utf-8?B?elNUaDBiOVFCSFIzOGtzY3FVcmtvMXhMeEdnV1BYMGdNa1lPaXVud2tRZld4?=
 =?utf-8?B?blp4aytqRHZmWS9JdTZ4bW5McXkzVXN6N3g4NjZPcUtqM2pVSkMzVjRiSVhl?=
 =?utf-8?B?dzZqQ04vdVF4TG1EaUs5eC9SM3pZV3RWam4zU1B3eUkwV0Q3enVFUXgrdy9B?=
 =?utf-8?B?OWRFSFNIcXdsOHdpcWVDWDMvVWhsSm5WMURHQlhuM3dXNDNJWml6aGtIUUFG?=
 =?utf-8?B?dDNySnlybG4rdjJxQWd1Sm1FU2RSaE9waTEvUFRqN0hTT1M4S0c2akV2KzM1?=
 =?utf-8?Q?M7RS2xwbFMoeydPBVSFQaPhXa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FC432C3BA6D5A40B4288865A8D8537D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K0dTTW4vUFk4L1ZvblBPdTliZFl4Qlp5K2hEUUg4Yi9JTCtRbzlKS2VaTU1X?=
 =?utf-8?B?Vm1BZmNFNDRJOGd2dVVPUVM4NWRhbzVXQ3BIMEtaZzdHejkxSXYrWC9IZHZN?=
 =?utf-8?B?U2lKQ3dnZjM4MjZEU0FSM3NVZnJ5N1NJd3I1WGpLaTBmU01Ia1M0M3JuS2Fs?=
 =?utf-8?B?dWUzUVBaMlhHa25INnVIVUc3UVhKbDE1dkxvZ1lDU2trRlhOeW8yTng2b0tN?=
 =?utf-8?B?cXBMSkFEZ2tIaDZFS04rMVVIYjl0ZUFETXdzV1lWYVFFamJUeldKYTFtdGNz?=
 =?utf-8?B?eldHZ1c2SlZGRk5DSGhQVzNBVWEyTDh0RmdicVBreW8wMHg1cyt1bFFjaE9s?=
 =?utf-8?B?YmNMZFU1WGNQaWdFMTAwdzZlN2x1WEZVbVUydTdXdkt2Z3JDTi9XUVRPanB3?=
 =?utf-8?B?TkZFWkRaak42TkZrUVlEbXBNRjJvdUlWZ05BdFhEQ3l6OXh4TXRmZ3lYb0k5?=
 =?utf-8?B?aHVCNHNJNlc1YU9PRXI5UUJNdG5uZUhtcEl6QlI3Z21MUytRWDIwWHIweGtO?=
 =?utf-8?B?bC95VHloQ2s4eXkzS2xyUndvM3AyaDNTU010MGdFV1BDM1BIdVdIb1hEa05l?=
 =?utf-8?B?ejFUYWRPMXZpNE04cFdSRTRQOVgxU1d6WjZWemw3akI2Q0JxNmFKRDJtcWZ5?=
 =?utf-8?B?ZzdPbktpZGdmNnJSOGdVNTQvcW8rL1JEOUxISmhKek90ZzdMbVorZ0U5VzRQ?=
 =?utf-8?B?VnRFUXpBZldndFpENUdZWndyNnFBbXArNURqaDd4b2laNG1rM25qOSsvenZs?=
 =?utf-8?B?TDFMa3hJUUdibzhURVRRcEJZRGpDYjFCZVlEUytrWjlaRXl3V2F3eUlJS1Ru?=
 =?utf-8?B?S3MwZ2dsdXpYTVhCeng3dStBOGMreUdJZzJjQmxwRWE0TkNiYlBrTmpCTFk5?=
 =?utf-8?B?Q2YybDJVZEwwVWxLbk1yalIvVWRSNklzYzVOd2VQU3NoMWlBRHFCNWlhaFpZ?=
 =?utf-8?B?WG1WN2lMZnh3RDk2bHZvTVFqeFVCQ3E0Q056cGdIenVkc1NJQVdSMHNaMEFR?=
 =?utf-8?B?NTRLNlRIZkllVVRsZktvSTBUQlh3NU1XQVBEUXBHMGw5SlY0Z0p6QXVjcGdW?=
 =?utf-8?B?SVhVcmY1RFNJR1BFcEpPN0RjaW5RMU5vcWhjZ2pLbk4xQ3ErOVdJUVFuQ0FZ?=
 =?utf-8?B?SDJON1BIUFdxVFZYNUZhYkVFa1pQWXZ0bm1iZk8xOHBBREdURVYwYkZBbnZM?=
 =?utf-8?B?eUJINzdMaGtlRFNNSE1ZeVBBN3R6end1VUFHa041UFdJWWt3cG9VaGFaaXNs?=
 =?utf-8?Q?zfMpJanRx5xjDUn?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9636a347-8d63-464d-2a83-08db50d59f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 21:37:43.7492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWp9pMruvCuSkP5MAax0lnLTldoFtbJrlrapA2n4DLVhV4W4XKx+1ojNMcaffLfJfbrOGRh5Oh+K5yYbdJlsCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
X-Proofpoint-GUID: gnNgTsGUDQ_0K7Zw3dq6nGYVUts_RbVC
X-Proofpoint-ORIG-GUID: gnNgTsGUDQ_0K7Zw3dq6nGYVUts_RbVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=648 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305090176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gVHVlLCBNYXkgMDksIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gT24gVHVlLCBNYXkg
MDksIDIwMjMgYXQgMDg6MTg6MzZQTSArMDUzMCwgVWRpcHRvIEdvc3dhbWkgd3JvdGU6DQo+ID4g
V2hlbiB0aGUgZHdjMyBkZXZpY2UgaXMgcnVudGltZSBzdXNwZW5kZWQsIHZhcmlvdXMgcmVxdWly
ZWQgY2xvY2tzIGFyZSBpbg0KPiA+IGRpc2FibGVkIHN0YXRlIGFuZCBpdCBpcyBub3QgZ3VhcmFu
dGVlZCB0aGF0IGFjY2VzcyB0byBhbnkgcmVnaXN0ZXJzIHdvdWxkDQo+ID4gd29yay4gRGVwZW5k
aW5nIG9uIHRoZSBTb0MgZ2x1ZSwgYSByZWdpc3RlciByZWFkIGNvdWxkIGJlIGFzIGJlbmlnbiBh
cw0KPiA+IHJldHVybmluZyAwIG9yIGJlIGZhdGFsIGVub3VnaCB0byBoYW5nIHRoZSBzeXN0ZW0u
DQo+ID4gDQo+ID4gSW4gb3JkZXIgdG8gcHJldmVudCBzdWNoIHNjZW5hcmlvcyBvZiBmYXRhbCBl
cnJvcnMsIG1ha2Ugc3VyZSB0byByZXN1bWUNCj4gPiBkd2MzIHRoZW4gYWxsb3cgdGhlIGZ1bmN0
aW9uIHRvIHByb2NlZWQuDQo+ID4gDQo+ID4gRml4ZXM6IDcyMjQ2ZGE0MGYzNyAoInVzYjogSW50
cm9kdWNlIERlc2lnbldhcmUgVVNCMyBEUkQgRHJpdmVyIikNCj4gPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZyAjMy4yOiAzMDMzMmVlZWZlYzg6IGRlYnVnZnM6IHJlZ3NldDMyOiBBZGQgUnVu
dGltZSBQTSBzdXBwb3J0DQo+ID4gU2lnbmVkLW9mZi1ieTogVWRpcHRvIEdvc3dhbWkgPHF1aWNf
dWdvc3dhbWlAcXVpY2luYy5jb20+DQo+ID4gLS0tDQo+ID4gdjEwOiBSZS13cm90ZSB0aGUgc3Vi
amVjdCAmIHRoZSBjb21taXQgdGV4dCBhbG9uZyB3aXRoIHRoZSBkZXBlbmRlbmN5Lg0KPiA+IHY5
OiBGaXhlZCBmdW5jdGlvbiBkd2MzX3J4X2ZpZm9fc2l6ZV9zaG93ICYgcmV0dXJuIHZhbHVlcyBp
biBmdW5jdGlvbg0KPiA+IAlkd2MzX2xpbmtfc3RhdGVfd3JpdGUgYWxvbmcgd2l0aCBtaW5vciBj
aGFuZ2VzIGZvciBjb2RlIHN5bW1ldHJ5Lg0KPiA+IHY4OiBSZXBsYWNlIHBtX3J1bnRpbWVfZ2V0
X3N5bmMgd2l0aCBwbV9ydW50aW1lX3Jlc3VtZV9hbmQgZ2V0Lg0KPiA+IHY3OiBSZXBsYWNlZCBw
bV9ydW50aW1lX3B1dCB3aXRoIHBtX3J1bnRpbWVfcHV0X3N5bmMgJiByZXR1cm5lZCBwcm9wZXIg
dmFsdWVzLg0KPiA+IHY2OiBBZGRlZCBjaGFuZ2VzIHRvIGhhbmRsZSBnZXRfZHluYyBmYWlsdXJl
IGFwcHJvcHJpYXRlbHkuDQo+ID4gdjU6IFJld29ya2VkIHRoZSBwYXRjaCB0byByZXN1bWUgZHdj
MyB3aGlsZSBhY2Nlc3NpbmcgdGhlIHJlZ2lzdGVycy4NCj4gPiB2NDogSW50cm9kdWNlZCBwbV9y
dW50aW1lX2dldF9pZl9pbl91c2UgaW4gb3JkZXIgdG8gbWFrZSBzdXJlIGR3YzMgaXNuJ3QNCj4g
PiAJc3VzcGVuZGVkIHdoaWxlIGFjY2Vzc2luZyB0aGUgcmVnaXN0ZXJzLg0KPiA+IHYzOiBSZXBs
YWNlIHByX2VyciB0byBkZXZfZXJyLiANCj4gPiB2MjogUmVwbGFjZWQgcmV0dXJuIDAgd2l0aCAt
RUlOVkFMICYgc2VxX3B1dHMgd2l0aCBwcl9lcnIuDQo+IA0KPiBJJ3ZlIHZlcmlmaWVkIHRoYXQg
dGhpcyBwcmV2ZW50cyB0aGUgc3lzdGVtIGZyb20gaGFuZ2luZyB3aGVuIGFjY2Vzc2luZw0KPiB0
aGUgZGVidWdmcyBpbnRlcmZhY2Ugd2hpbGUgdGhlIGNvbnRyb2xsZXIgaXMgcnVudGltZSBzdXNw
ZW5kZWQgb24gdGhlDQo+IFRoaW5rUGFkIFgxM3MgKHNjODI4MHhwKToNCj4gDQo+IFJldmlld2Vk
LWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnPg0KPiBUZXN0ZWQtYnk6
IEpvaGFuIEhvdm9sZCA8am9oYW4rbGluYXJvQGtlcm5lbC5vcmc+DQo+IA0KPiBKb2hhbg0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHRlc3QhDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4g
PFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
