Return-Path: <stable+bounces-146226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A54AC2C0F
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 01:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C804E4BE9
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 23:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5A821420A;
	Fri, 23 May 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y1yRxISc";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fbWbDM/e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VGthPZM7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EFA1798F;
	Fri, 23 May 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041623; cv=fail; b=sONMCweEc/40vOMIMOMSzbKRq3lzZFPlEoQDj6MhVbdifBoV6LhOluWlQomoyawjWu7A2O7YroBhYQfRNkhZpg67kWwu1iNtCIpOYa4AA/lhn45ZFXSWCJjwCnKNjIM5KNNiFYARQLlbRUWHVXLrYuYbPo2tIKPPl+xnmtUn5M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041623; c=relaxed/simple;
	bh=ueOAVYnHoQkpMIUCaVdLA8Ws6wdoHdaWjYNTNpHOOxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fcN3yvd4XSdA9wVEQtGu8USnNddmKYvi50noBZBzCHVXljc/lCTTHNUM6QMs9d2/R49SzkjZMiFF3TTxKiMEFCqPANFxBY7nKQ1QS0k0RM2/pDl/1eCapIaXanV+7pSWQmRv4K9vDg3Mq3crThR1GGaRPXiEpYEVPIOpYwOwm7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Y1yRxISc; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fbWbDM/e; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VGthPZM7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NKsuxK013965;
	Fri, 23 May 2025 16:06:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ueOAVYnHoQkpMIUCaVdLA8Ws6wdoHdaWjYNTNpHOOxo=; b=
	Y1yRxIScK8S94mhH0ioXP5RRWlOr8tFO4LURxiz6MqN1e6CAAzNjMf88XD1uvqDA
	M4k6A+qex63jFNvvri4ONBCT/R70oND9GyXsme6J1Oqk0vOAcg4ATZpVKs3+TnlW
	1ZlCwYn7gOZjGHuAF0zhSApnMWbd8vqKUwDPXlLmnqyjQCRcOK7T2e/EDIb75KtC
	m/dgPr4eHW2Tv9XbeV2yAnuJ9sY0FB+Odffc8DhVx3UIBLQeuilmvyJ7uBceGI/v
	uC/Ww9hiHmbod0eNh7RR7R+C1RfLDekcdX1/k5ixK4Z6e1ZDrY2kM6KXbt9Txdp1
	auedaDiSEXNiechlRkVVFw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 46rwhttk28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1748041602; bh=ueOAVYnHoQkpMIUCaVdLA8Ws6wdoHdaWjYNTNpHOOxo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fbWbDM/exSQQz8+LbRD5cKy+/Fz9a17VzmskZZbppQzT9g2tE1yxX+B+wyKobmJi0
	 +IZz6SyJfnKo6/Zk+3+SjgUqgP0ATaLa/fdBqZ+ATlWl5SdlEWrF5BC+31EtA24VOp
	 7F23XbXoTBFiK0SNIw/w1+xZESz+A6malDf+eR9xO9FOJ7VrGJRjXsWeeY0KjAFD5W
	 VatJqqPHp8dhm0d4TAmXhCbC8R0VYP1roj1O5ATb57cjuLARCS5u5ejWg9f3++VRay
	 dbyuXXw+zOWcpkF5+xqT1ipv7uAhQ/Y/cz6JZX1cw7NXn8UZ+usTPSIg9X4L51Pjyh
	 GNUuUNedQxHOw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B602540087;
	Fri, 23 May 2025 23:06:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 542EBA006F;
	Fri, 23 May 2025 23:06:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=VGthPZM7;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2B6AC4035A;
	Fri, 23 May 2025 23:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPso97voLxAmmv5VClP3nycJsXZvV5ZQnToubqyh4LKnUGrc/8cASmJec1cwSxjygQwgqQiNunOle5h7kkVNCIFuOt2BowqTrSv0WTiGhRj6Iusz2jaDeaNSX9pFK3VS9apmpzJyc5NzU+Jj3EBQ9pwOm458+Te8se5lKPzeLgVNDNh2r3rz1HTaeQ8QUwhhoBIFF4Z92la14h0Dg4zRmjlirVYewXlNEDI1ROdxW7ripV02AdQV4r2ydVU49346G2b4hAS7hRYbnxfPnSfV6wRrG9qhB7sVdHFDH63gkUboT1VgLQhzqlM3MIPzqizGbiK0zVftDajr5o/8cXWakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueOAVYnHoQkpMIUCaVdLA8Ws6wdoHdaWjYNTNpHOOxo=;
 b=e6/4slv4wUTP6gRRW0TZ+i8lA+/7FAP5uUbyOZhDuvxSWlH4NZf2wytf377xieBzF2tQkodSRZnJWE1JjYv4Khm10h9VNODlLsQjsrYOXVNnRGNL83l65UikWCh19HdImVnqWG/RzmqEgc6zcrW29YbJJgOt5PbjLLfZ0LJ0bWqwaf1Fy5UTDuvVjNorrSiPzcA2NPT2B7cU+Hq91nb2Sbm+vbPA89/I27uC+BSKg2OUhB/0nwcerPsH8HrTkE+7LuzM8k8OK0cd6b55gyiTyAm3RK3GdlLaj1pygpxhkF5XF3G+kAbwLXOsfHzUHiUhn7wZ8YyHhdDqRiGeF1aqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueOAVYnHoQkpMIUCaVdLA8Ws6wdoHdaWjYNTNpHOOxo=;
 b=VGthPZM7ASKKX5PAj+fqovYHeP6htlz9DOcvAhlN0M4ocbKb5fUxT9IinpyFsx3nYhP8c1KmMEpYnnU6arKHM8K6t/kpGAt91t/hTYhfH66IXhA+FD4vtRiyCbk3uVr9xOCaHitPfjAWBIIKGXqTjOiySwwQ1sXeqZg8HBb+K58=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 23:06:37 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%6]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 23:06:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        Roy Luo
	<royluo@google.com>
CC: "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.pecio@gmail.com" <michal.pecio@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
Thread-Topic: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
Thread-Index: AQHby00IO9kpIg0s3ESarCv0vYf2UbPg2AyA
Date: Fri, 23 May 2025 23:06:36 +0000
Message-ID: <20250523230633.u46zpptaoob5jcdk@synopsys.com>
References: <20250522190912.457583-1-royluo@google.com>
 <20250522190912.457583-2-royluo@google.com>
In-Reply-To: <20250522190912.457583-2-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB6888:EE_
x-ms-office365-filtering-correlation-id: 6fd0cd31-ee60-4de6-31b3-08dd9a4e77fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkNBQ2hBYzNteGFNcmxLem5YQUxORU9yRHBiYitKYlNVenVLQWZjKy9rUWN4?=
 =?utf-8?B?OTFYQW1FQjZNK0UxR0VSS3FwNW9nOE02aHkxYnZVdzFaTWoxKyttdUduUUhQ?=
 =?utf-8?B?TFNnTFphNUk2S3BrYlFjRlBHOElUTjhIWWdZTGVQOVBkbjQzQTRkYU1vZHhH?=
 =?utf-8?B?WUw5dXoxNmtvelEwTHZQZlA1MU00T3RjRGYzZkt1SzcrYmlacW5aVWp4U29X?=
 =?utf-8?B?VDA4aHA2VHAvbTAwYUJUSkRmaVg3L2VUMUlFdk5YeU5iQmU4TWV1MC82UGo3?=
 =?utf-8?B?amEzM3UyNnpCM2JUR0FMNnNINkNFNTZhRVlpa0I2NDlJQkxaSksyeHN6ejcx?=
 =?utf-8?B?N3JvSng0K09Sb0FMU04rUlhNYzdXa1AzQlJGK2ROYVBuc3NwQkV1MXJBZDdG?=
 =?utf-8?B?OVBTclY1bE1VcTE2WjRFbHQxZTNaUTdoT3JTb2dKN1BVSmU2ODVXSU45WUtY?=
 =?utf-8?B?ditEWVhmaTlqQ1RtNjdUeW1QaHczbVI4M3dySGtwNGFOa25NYitKY3FXUGpM?=
 =?utf-8?B?UnJzbmtXZjJPakM4VFhMNkl0TmtqS2JxZ204RWpHZk1Eb1BkT1dnU0RIUVZM?=
 =?utf-8?B?MVlVVHZIVDdUMmtlcDNUV1V6dno5eFltbVcyRzVON3dKdmZyWURoZmZyRGdn?=
 =?utf-8?B?ZkJuRjBXdjJ6ZVZ2YVNqVlc0eFdVMG82bzQvNEVsN3RINVpzT0FjdkYrUGJB?=
 =?utf-8?B?K2h6bUg0bG8xZHF2bzE4bzdrOENIZGhNeVp3cVMweEo4WnoxQ3ZwK3RHalF3?=
 =?utf-8?B?SUVrYkZ2Y2RMSVhHMjV3bFhXYkFiZXZqRGtDK0Qremc3M1lQV3E0VlJHY2NM?=
 =?utf-8?B?K2NGQXZiNmRvSGdRclo3OTNTTHVYRkJ5dy94YUl1K0pqOWxlYlYrTk9WNnVD?=
 =?utf-8?B?OWFXY3JaYTZXOVhkRUk4dm9xYlRJMGFNd0lBS05wT0hVWGZvSHVyaEtqVTVx?=
 =?utf-8?B?VlY2elNKN1RFNlF5U3pYdVBrUHpnbzdnQUpGTjZHRTNwL3ZnRUhIWjFLaFNy?=
 =?utf-8?B?RHhROHV6bWVOaHB5cFE2d29NVEdVUEM4eUN6SExHclZvM0RqNGhQaHVkQUlG?=
 =?utf-8?B?bW93dEgwNCsrY1NLbit3dnRJWHNFT1Z3d2Q0ME9mRWtqZUlYM1BvdW1iemVr?=
 =?utf-8?B?d2pObUQ4SFVHM0ZnRTJDZnVIS0RWekV4b0dzNnhxTDlsSnB6UEpiRU03bGdP?=
 =?utf-8?B?RUE5STNwL1NHcmIwM2g1RE5FdkNKN3VTcGZ2TmtFL0VibWFhTUhmWmNyamNs?=
 =?utf-8?B?RzZGdWlON0VwaC9KTmpiQ2tsdVZ0R2IwTmdncTdZOHJpN3J2eUtmdWw3aFdo?=
 =?utf-8?B?eDdvZ09SdzhZLzdSMEJiNlV3TVlMQ0s4cFhaQVRaREUvZW9ZZ2J2aUp0VUU3?=
 =?utf-8?B?NG1PZHI4RVZ2MVBhM2V0VXpLYUVBMDRIT2N4eHhOSExRWGxMZmM3eVV4N05s?=
 =?utf-8?B?SHQzZTBJUSt0cEd1T0FESStTVkxHVkFlSmovMHZDUEY2eTVuOGZWbHFMZG8w?=
 =?utf-8?B?b3JwZjU1NDBmQ25qSmlRK3BCb3M1SWxTT0lyMFUwYmppRVdsM3VZUUU3WU5F?=
 =?utf-8?B?b2tjSlNiVjF2aW9VampPcXBldWVSLzJRNDNXS0R2NDFkdmdFMnRRTEdMNXJZ?=
 =?utf-8?B?NnFzVHdnVVJzMHNyRUZwb21yb24vUXEzZ2s5VmdlbTFselE4RXEvR0pFWE1q?=
 =?utf-8?B?eS9YVi9pT3prZ3hkREJGaC8xOG9LYUZ1YWZRNVRSTHE3VWdHMWI5ZU55ZzZP?=
 =?utf-8?B?S3MxZ1M3NzU2djJ4c1MxaU9pVXRSSGsrVm44OFN5bWQvTDVvK3VNcTY0QlNz?=
 =?utf-8?B?bFBQYTh0SXdqZzhSekU2YkIwTGhtejN1bGlnUUpkdHRaSGFPZUVuUDN6ekpD?=
 =?utf-8?B?aFVVZExCaElZSytDY08zUnNEVUNvWXY3aEFSSEJGN25kUUt2T0dyTjA5KzlR?=
 =?utf-8?B?VEltNndmUG54dkRDV2M4dzlnbElManZEcmRBa25KZnNFUHdzQ252REt4d3Nx?=
 =?utf-8?B?L0RBMlBJS1pnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OE0xU2JOd0JPK3RCRzlQUC9mOUh3TmEwUS9RZ3M3SnlsamZISmdqQjJXRVU2?=
 =?utf-8?B?VGo5ZE1kM3NETndkNUR0Qm85ZFZmNWVobExtMjhJYjF6Q1dTRHNEWFRETk9X?=
 =?utf-8?B?ZktWUGpRQXMzeEF4eTFMaVNEeXcvZ05qd2RpTFE3UlpLajBkL0paQlBwQ3ZQ?=
 =?utf-8?B?RHNObTQ3VkZZaTZVYml5eFdNVU5xRHNwK0MxZ3dHMkpEdkFLQkNpTlZkazJn?=
 =?utf-8?B?RzJySHRIL05Edjk0bG9abGRMU0lYRXNGRForUktZNFk2cTVyRmJVaTlSdTNr?=
 =?utf-8?B?Qzl6UUtsMGVIZ2Q3ZXowKythdlQyM0pWenoveU10bjg0eG5nZjAzRmtoWlZP?=
 =?utf-8?B?Zkl2ZlRmVjdNTHlmYlJrL2NHSmp5dS9MZTF0ZmszVVM5WjVjTzNpSkNSY1Np?=
 =?utf-8?B?THQ3T0w2bzR3cWpUNWdmbGM3MmtXTmlmYXZLVXMydlV3Rk9xVGtON0doemhQ?=
 =?utf-8?B?TnAwcGt0bmNjNXVNTU91T0xsOFJqS2RPRlA2TUdiZW8yQVJ1cmxxL1VKQmUx?=
 =?utf-8?B?dy9ZUEdXbzZaV3lxUUxjbnZGb2VhM1Y3TXcyL0V0WUxGaFBvN2VxY0ZGQ1Vh?=
 =?utf-8?B?VlZDUFlaKzgvai93Z0s4OG5qdlV0UVRJYWs4TlIzT3c2WHlweGluQ0FyOVg5?=
 =?utf-8?B?UUdPOTdPYVY1cEx4SDM1K2xPTCtML0pnNVhIeUhFTUNxVTdIU1kxTkZ3VGpK?=
 =?utf-8?B?SzFFaEd6QkRTcmxzZzN5ZDdQcmhmTnU3a3lQa212M0R0dzZtUEVnb2RWckgx?=
 =?utf-8?B?SG1LZEVlVUh5YXJaZ0FNSTRYUVNjclkxRExTNUdQVlhQMmQrdVNLVVRkeVBU?=
 =?utf-8?B?eXNZaVJxWDFEV1BRQytGUitLeW5rSHpqMHpJTnJ2QkE3T0wxNDJDdmxncFVs?=
 =?utf-8?B?YjdRWHFmSXpmWXpmdmZ6ODJxVnhmRDBML3greC9GREVxVnFod2M2QklROGlq?=
 =?utf-8?B?eXBIdDZwU2dsNHJzcktxaEdNQ1dhV2ZSYk50WGx4dWJOVkN5YzdhK2FCNC9n?=
 =?utf-8?B?WnhreldaS21QRzlVNndLRUppM1lpVHpGZDl5cnNHcmplaUhwYm5RVS9ibG92?=
 =?utf-8?B?Qm1PVVo0bVA0TjhkUTFtdG9pbDY3QjVWRHV1Q3krbkdvdnhvU2lQQlk5b2tp?=
 =?utf-8?B?VWVxaWE3WlJiVzZabzd3SkU5THhzblZIOHdSSERKNU1pYUgxZm9DalQ3T3lm?=
 =?utf-8?B?ZEJHY3BTUFlwdTZNbHkwTTZza1dmOUpuZjk4WGpDRXpRTHUxQk5BSGZUTmF0?=
 =?utf-8?B?VnljTGJjem1XaUFObWMyd2o1R0lKNGt4cXF6MndTQ3hLME9mNXo5aUNnZENn?=
 =?utf-8?B?UGV3bU5uZGhheGdVVTZ2K1hlS2xOQXVkRjJzSFFsdWNxMU5vR3NkVy9aTDNB?=
 =?utf-8?B?U3VyclFtbXlHaDhGVVNxUnhCY2V0UDZ5c2RQL3hVOGdwNzVsUkRhZ3pWYStp?=
 =?utf-8?B?WEJtblBpNUhaeTcyUWxGUkVoT3JwMC8ySnZlaXZvZzJWbWlEYzNOaHBlWUF3?=
 =?utf-8?B?N29YN0xNZC9wUW56NEJ6Sk1VMzhzN2RLVlVRek9UbnNQNDZlcmNDOTZZeU5T?=
 =?utf-8?B?ekpKS3RpOGcrVUhpVzd2WkE0ekQ1RUdsOEszZll5SDBvNERqdDBRaDkxUVlF?=
 =?utf-8?B?dXdCR0o2cnVtUTR1RDlwQnNCSGxSZTVjRUlvYjFvUWRIRFZaQ01ma3pid0Yx?=
 =?utf-8?B?RWpFR0czWUIzeFZsY2dTQTF5eDg0ZmVjckpIR1Zod20vT245Z3dQUlNPS1Nt?=
 =?utf-8?B?RlpDZGJaa2ZuejA5T25nckNkOHpkdC9IQ3NYY2lNODBlMituRnFXTi9jaEhU?=
 =?utf-8?B?dnVqNTRIWGF1NzBHd1BhK2Q5VU9NV1FEbE4xMjZWUU01ZUtrWXRrMkVTczRq?=
 =?utf-8?B?K09FeHFaeWI0dmxjZWowVjhEdTBoaXZqeGJkb0FlU3NrNzJjOTIzb2Y5VFNl?=
 =?utf-8?B?RlZhWUc0UjdJYmFEb2owdi82L0M4a25ZWFkvVis3NVc0RHJ4cERqTkRmaENw?=
 =?utf-8?B?aGV4cjJvdnd5TElnSlhnQWswdXNiMUpHTVpoVGNDYnlFanA2Tk1oQlQ0allv?=
 =?utf-8?B?eEJvaVNRZ0RaSG1na2ZTdElXcy9JS29LekJGSTdTZHZ3Z0tOMDRxK3lHM2tF?=
 =?utf-8?Q?H0lVEAGLeKb5aWdqwdL9OuI5e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <830A9953E7DDA04EBC5E772B3F5F258C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hgSvL/8NwU+UXin2rCaTPmJX+BzuDjGDMOyuYNQkuFJSKKnkleqotFsONiEASbTrdii0+GTD5GpRNwr5u4JAikitmGHnCOiq0vDSQ9afJ6XoKk+bMHpGl0UIgdsW14xablU6J1GVqEkDuyIFJrfLZTKHdRRdtK2OfUn5hRJACtX1QVo50NzP0vgTs5zCPrfX8LW0k1fRq8QmytJoTsXFGVNy0HWJzAgKJeoM0Cm7AFmVWFzggmY+R5X7qkNemRCM3P3hlGL2zw/0Dnvf94M0ljjGhNPA0ChKrEW6xSOiI+jgRX2fxHb1kKdsphXEBUDlLVdN8Kz5qpn0v3zB7LtqcznqSpuBUh00RfeXnuwdhU/5Xu1xYdhujgHVGEblQzrPilcDLfldKDKcu86yqmLja++Hlp7TDK4+hI9NMOImTkCGaVea16ERrNoXrgZpvfr6sE+b0WgBne/Bp/xlKU0k6sOHYKOdfUzWxjVkr97pHM+GbiAKGCWXFM2Uns+6/5iTFHWmYaUQ1Am8Z32dHa29Y6YWPEZQ+myLKpzJlw1wmLiCXJuUsYsxic8ZPim4UyQV06imIlV4cu1ubrP5RxeDMEYnYiBvATUnXo2lPkmocKTOf3+pL3xEkuPay2NQaF/LNMRPcXSUiAmtjkTTLx+SGg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd0cd31-ee60-4de6-31b3-08dd9a4e77fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 23:06:36.7175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nk/mYhqmNAcMOUKPl17kPplQdShuVlqy2nLAkzM3Qmr8nvtzsVdmhY/J/unCM6zFMG0U95wjlxSF010CEMMjog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
X-Authority-Analysis: v=2.4 cv=DOGP4zNb c=1 sm=1 tr=0 ts=6830ff83 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=d-fUgDGQzJdPGn_EEI4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PUKY7BF1JCiWpC83aJqLTRHARnc5zc5K
X-Proofpoint-ORIG-GUID: PUKY7BF1JCiWpC83aJqLTRHARnc5zc5K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDIxMiBTYWx0ZWRfX14BJyPPQY2iO
 5d/h/zDNQWpZXM4b/S2uvvNuBEXeoMX9BtDC2+UQs4eu8BVmovLI6z7rxMKMidWZxdNVzpAhAFX
 Wn6i65FBzR1v1L/W2U1ufCMQBtGDvli1oBVl2wI8rigmZxML4erffOnpBdna2kn7CWaPaObmTyj
 02PtxARXHrygop66ZgvIRiaKjhkZ14zHr7wKxD/DHRhxnT4tZPzrPc8MIrRcX14nuPCq4Nbr/Jc
 C5ECmVx4t4tzk2LPdoabpCq5Pi3qEBXbv5iwcMAPL1gwt8H0ioQa2ZyzSeVMbMWvmQ5KC4aVuyZ
 HkMrv444PCaDg9CLkq3gj9RpSnI6oq2qukS9KN9NTvEUVQjOPF8K/ZmLK06qmHb5Tj2Z8hk2Ute
 Fxe+kilCX+Rw8uFy1px99DwQ2HibX7+X9sZl/nIqsBYWQdsK4UbZWt1Vj2cTgvdiHFmBE36V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000 definitions=main-2505230212

SGkgTWF0aGlhcywgUm95LA0KDQpPbiBUaHUsIE1heSAyMiwgMjAyNSwgUm95IEx1byB3cm90ZToN
Cj4geGhjaV9yZXNldCgpIGN1cnJlbnRseSByZXR1cm5zIC1FTk9ERVYgaWYgWEhDSV9TVEFURV9S
RU1PVklORyBpcw0KPiBzZXQsIHdpdGhvdXQgY29tcGxldGluZyB0aGUgeGhjaSBoYW5kc2hha2Us
IHVubGVzcyB0aGUgcmVzZXQgY29tcGxldGVzDQo+IGV4Y2VwdGlvbmFsbHkgcXVpY2tseS4gVGhp
cyBiZWhhdmlvciBjYXVzZXMgYSByZWdyZXNzaW9uIG9uIFN5bm9wc3lzDQo+IERXQzMgVVNCIGNv
bnRyb2xsZXJzIHdpdGggZHVhbC1yb2xlIGNhcGFiaWxpdGllcy4NCj4gDQo+IFNwZWNpZmljYWxs
eSwgd2hlbiBhIERXQzMgY29udHJvbGxlciBleGl0cyBob3N0IG1vZGUgYW5kIHJlbW92ZXMgeGhj
aQ0KPiB3aGlsZSBhIHJlc2V0IGlzIHN0aWxsIGluIHByb2dyZXNzLCBhbmQgdGhlbiBhdHRlbXB0
cyB0byBjb25maWd1cmUgaXRzDQo+IGhhcmR3YXJlIGZvciBkZXZpY2UgbW9kZSwgdGhlIG9uZ29p
bmcsIGluY29tcGxldGUgcmVzZXQgbGVhZHMgdG8NCj4gY3JpdGljYWwgcmVnaXN0ZXIgYWNjZXNz
IGlzc3Vlcy4gQWxsIHJlZ2lzdGVyIHJlYWRzIHJldHVybiB6ZXJvLCBub3QNCj4ganVzdCB3aXRo
aW4gdGhlIHhIQ0kgcmVnaXN0ZXIgc3BhY2UgKHdoaWNoIG1pZ2h0IGJlIGV4cGVjdGVkIGR1cmlu
ZyBhDQo+IHJlc2V0KSwgYnV0IGFjcm9zcyB0aGUgZW50aXJlIERXQzMgSVAgYmxvY2suDQo+IA0K
PiBUaGlzIHBhdGNoIGFkZHJlc3NlcyB0aGUgaXNzdWUgYnkgcHJldmVudGluZyB4aGNpX3Jlc2V0
KCkgZnJvbSBiZWluZw0KPiBjYWxsZWQgaW4geGhjaV9yZXN1bWUoKSBhbmQgYmFpbGluZyBvdXQg
ZWFybHkgaW4gdGhlIHJlaW5pdCBmbG93IHdoZW4NCj4gWEhDSV9TVEFURV9SRU1PVklORyBpcyBz
ZXQuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBGaXhlczogNmNjYjgzZDZj
NDk3ICgidXNiOiB4aGNpOiBJbXBsZW1lbnQgeGhjaV9oYW5kc2hha2VfY2hlY2tfc3RhdGUoKSBo
ZWxwZXIiKQ0KPiBTdWdnZXN0ZWQtYnk6IE1hdGhpYXMgTnltYW4gPG1hdGhpYXMubnltYW5AaW50
ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSb3kgTHVvIDxyb3lsdW9AZ29vZ2xlLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2kuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9ob3N0L3hoY2kuYyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jDQo+IGluZGV4
IDkwZWI0OTEyNjdiNS4uMjQ0YjEyZWFmZDk1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9o
b3N0L3hoY2kuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KPiBAQCAtMTA4NCw3
ICsxMDg0LDEwIEBAIGludCB4aGNpX3Jlc3VtZShzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksIGJvb2wg
cG93ZXJfbG9zdCwgYm9vbCBpc19hdXRvX3Jlc3VtZSkNCj4gIAkJeGhjaV9kYmcoeGhjaSwgIlN0
b3AgSENEXG4iKTsNCj4gIAkJeGhjaV9oYWx0KHhoY2kpOw0KPiAgCQl4aGNpX3plcm9fNjRiX3Jl
Z3MoeGhjaSk7DQo+IC0JCXJldHZhbCA9IHhoY2lfcmVzZXQoeGhjaSwgWEhDSV9SRVNFVF9MT05H
X1VTRUMpOw0KPiArCQlpZiAoeGhjaS0+eGhjX3N0YXRlICYgWEhDSV9TVEFURV9SRU1PVklORykN
Cj4gKwkJCXJldHZhbCA9IC1FTk9ERVY7DQo+ICsJCWVsc2UNCj4gKwkJCXJldHZhbCA9IHhoY2lf
cmVzZXQoeGhjaSwgWEhDSV9SRVNFVF9MT05HX1VTRUMpOw0KDQpIb3cgY2FuIHRoaXMgcHJldmVu
dCB0aGUgeGhjX3N0YXRlIGZyb20gY2hhbmdpbmcgd2hpbGUgaW4gcmVzZXQ/IFRoZXJlJ3MNCm5v
IGxvY2tpbmcgaW4geGhjaS1wbGF0Lg0KDQpJIHdvdWxkIHN1Z2dlc3QgdG8gc2ltcGx5IHJldmVy
dCB0aGUgY29tbWl0IDZjY2I4M2Q2YzQ5NyB0aGF0IGNhdXNlcw0KcmVncmVzc2lvbiBmaXJzdC4g
V2UgY2FuIGludmVzdGlnYXRlIGFuZCBsb29rIGludG8gYSBzb2x1dGlvbiB0byB0aGUNCnNwZWNp
ZmljIFFjb20gaXNzdWUgYWZ0ZXJ3YXJkLg0KDQpOb3RlIHRoYXQgdGhpcyBjb21taXQgbWF5IGlt
cGFjdCByb2xlLXN3aXRjaGluZyBmbG93IGZvciBhbGwgRFJEIGR3YzMNCihhbmQgcGVyaGFwcyBv
dGhlcnMpLCB3aGljaCBtYXkgYWxzbyBpbXBhY3Qgb3RoZXIgUWNvbSBEUkQgcGxhdGZvcm1zLg0K
DQpUaGFua3MsDQpUaGluaA0KDQo+ICAJCXNwaW5fdW5sb2NrX2lycSgmeGhjaS0+bG9jayk7DQo+
ICAJCWlmIChyZXR2YWwpDQo+ICAJCQlyZXR1cm4gcmV0dmFsOw0KPiAtLSANCj4gMi40OS4wLjEy
MDQuZzcxNjg3YzdjMWQtZ29vZw0KPiA=

