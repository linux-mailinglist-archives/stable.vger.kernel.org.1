Return-Path: <stable+bounces-210678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIAFMANMcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:46:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A60508B2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C89DD4EE97F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399E2ECEBB;
	Wed, 21 Jan 2026 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dh2cxVlz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D969313283
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966889; cv=fail; b=J+DjT6oK+Ci5lB8Ia6trypwsPFo9wGVCURiKYsJnLgDxwByHtVJK0cfgYIaQiXRyIilYTbx5L55RapDyWkEIuHQ4ttI/VEeOxYrOu55gEv99B93q7uyw4mKS5oXO0/qPXQj9JENW94pFhtW8CH8mOUyIB1i0g3NO4+O/aD6B8gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966889; c=relaxed/simple;
	bh=ynDnhd1QWkz1R6EuQbXBmRhiudyE6FtbY6JV09A6xVY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ghg92aOj/+++SIt/U3a/2JMAV5XGn46H4H3GFF7ttGZGg05NCKYzKLRmSFMsQyWMJQ3+L22iMuobCg39j7bss4f4x7E+1oZ471g9526iXw6FhJLFd/c4kR2Jj/CWlih2na3Pzjv891j4bcVZSBnTjs07kA5S+ieMTXIkJmdZGMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dh2cxVlz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768966888; x=1800502888;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ynDnhd1QWkz1R6EuQbXBmRhiudyE6FtbY6JV09A6xVY=;
  b=dh2cxVlzVQyG7/YUmrS5/6snYTrvRPmChBrc8ul5LkRlKQo73L5C4yGt
   IkCi9+eZXU2d8Js2fSzbVzuqaNxc9RJyXlobyIEWyQSUlgaH/NkpFwJAI
   QQCsJftnItE9FhYOUruGXIzLfqZrHJ9xavO2mIC22idgbduWddfzK73mz
   4eVmKq0qaygYDZ5E7tyOSTDHyiXNKNVF6uTgLnFRh1jYHrBO9FpbkN6Zp
   O3BPoTyMm2lD/MxXWn5j6z/dHcQNB8IH0LUo7CLVoJP7G+JTiWqdupwAb
   0m022zRmek2Ls7/lvFYSeksrMVImx++sLEDA6x570bJQzLetiwtjlZFk9
   Q==;
X-CSE-ConnectionGUID: VhUR1BYsQhy2//BufS4gyg==
X-CSE-MsgGUID: k3HNC79VSUyz937DiJNj6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70162004"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70162004"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 19:41:27 -0800
X-CSE-ConnectionGUID: 1+w6jfRTTRaj4DMPAyplTA==
X-CSE-MsgGUID: kEQhnE5UR6eo9+23rxJSgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="237566238"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 19:41:26 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 19:41:25 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 19:41:25 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 19:41:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0n31WZNnCt8TyK5gbGdZBdRwKeGbUH3e1KXHfi3gNVucaVEWVDR9tzT049VvnQ3x4viOm4oR0luT06r4QvEcR2YST+yFeJt7uLgYL/VYmLZ1tLTMwPOYWSvp8BIZE0s4NrPnvEQ2+8zzkADWWnFruohbzZbHYNaM86THfizPyEPx8U2p2kEZ1IhzxMzGT8jvzhw/C8IEY4BvJGlfsGFkdoszvrVkO2Bn1lSTPCQJMjqCli+nrCoOY9Ubfe1tUc7+eNkLIwxROQXYKkxSnCT8pIy111TrfhgQSdB3dC6Z3uAF1A9d4g1HGDq5QGP6lLJHegS3Q/TIuv4aw0P/Mj+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynDnhd1QWkz1R6EuQbXBmRhiudyE6FtbY6JV09A6xVY=;
 b=RLlZJINqCn06ZULInTILFwqauVzTj2yFKHiCv9w2ULAG121nB/Rtkz9lxqcvXgDKcRAXxwjE1zfxmJ81rZE1sewkLlUb/4GjJzeKXcsNJUV9Qb8whsduEG4mFDpiIPxN3bAaIYPZ45AnABA9tkfAtYE+h0jeKoL/jikF8qkNd+kAbfySmErhSn0EeRKHsI1JjDKc1LpsTXhvPMTBMy89I9Gaa88IIo/8zjYoVIrhCicZr07PKwHXSIhztv4BzIiq/kO9m/V5zCxT/kL9xeWdi+p6zTFUBep7TGFZx7XSrvJIdy6udfeHU/GOHk+QMcOorOe5xvPMa05qTbch/VJzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by BL1PR11MB5240.namprd11.prod.outlook.com (2603:10b6:208:30a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:41:21 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::615c:ca2f:d093:16a9]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::615c:ca2f:d093:16a9%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 03:41:21 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "nathan@kernel.org" <nathan@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissoires@redhat.com"
	<benjamin.tissoires@redhat.com>, "Wang, Selina" <selina.wang@intel.com>
Subject: [STABLE BACKPORT REQUEST] HID: intel-ish-hid: Fix resume blocking and
 compilation warning
Thread-Topic: [STABLE BACKPORT REQUEST] HID: intel-ish-hid: Fix resume
 blocking and compilation warning
Thread-Index: AdyKhVFRyqKzR9psQ5aW34PA3NfKPA==
Date: Wed, 21 Jan 2026 03:41:21 +0000
Message-ID: <SJ0PR11MB5613A3AD2B49FC9104423D729396A@SJ0PR11MB5613.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|BL1PR11MB5240:EE_
x-ms-office365-filtering-correlation-id: 9f4a0011-6d06-464f-fa98-08de589ef1a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?oENfwyRY/8g9KnOWrrAB70U+3IRx9yI/L9+47dXteDaHAg0BA2CqQH8rqmbJ?=
 =?us-ascii?Q?cO7s+BlnntouCHFlvD38ZV1mK9NHhEbF3m39A8PcuwVGY6OtAZNiu8ECOMPC?=
 =?us-ascii?Q?ReMzHfvjE6TmrAvwalIilQqs30TSTTJmaqlVD0OPbb6UEgX2xP9gU4hY7aNp?=
 =?us-ascii?Q?AiJ0Xpe0zx2pjdXnw5L/7o0BVFJNjNeYNZDOfD3O+6Lyl7sDXcQiXDl64VSH?=
 =?us-ascii?Q?OFiejmOuQhK8rP4dH+5P964aKSUUoAgQvb5rSanx0tOT+h8oO8vYxGChD8X/?=
 =?us-ascii?Q?pu54myQhJqeQa88zpGXxwHTsLMNt/3HoqHMJ4eBKS9jwxjj1yZUovr+0enlp?=
 =?us-ascii?Q?8UZX37Q8raVagGyHYBsTPEwe1mDvII853J5ibuUpHNDgkNsgmwULxBR1g2+Y?=
 =?us-ascii?Q?3BCNkjJQ/rFJ8Zgy6dSXKkTJJ5SXohsvw6v3wyxETglhxpwPQw4vAVZ3ao5m?=
 =?us-ascii?Q?Mv0IwIAh0qiVwRry7v1f8mNlXVSwZBAJpFUTPdWo3ddd7Jybs3wdMrWySPsP?=
 =?us-ascii?Q?JvjfM0SB+NtYI4bwti353iuKS0G3T6ekvHKGbDJvXRUrb+B/K1YuwVVXitrw?=
 =?us-ascii?Q?o0xABMsk7KN0YkaTJPXwbDhJIWtEStAZ6FfeGmKE9oT5PkXS/HFnejlohwW2?=
 =?us-ascii?Q?U+pthJgHE2yJK6ax5ttxz0d4Vfx7KiuEwIF79nN5jNFhEcxHH/ItIruGe2qP?=
 =?us-ascii?Q?pFxOzChTPSkFQ1J80CVZK2JcVrAvqoQhahj8ZR8DtaGUQswU5vlZPqKI2uCY?=
 =?us-ascii?Q?EHL8sNA3qd7LvpBWFITCuRb/42t4UN8mayyKb74BWrd5ll0OhBFjHY+hYpe0?=
 =?us-ascii?Q?E8bI9Q1X3aSXOShGRH/Vyr+z4rqqvjsadlD80nyYq7wglKmg+AAK49aTsRHg?=
 =?us-ascii?Q?SM5CcfrFGO3UKIg3Y16Yp22wwniluYt2pbBjAihziEKy6fR8aI/tltqFVCA0?=
 =?us-ascii?Q?GKMBS5pthIRFIdG2asry/Eh5OXUXtdQ7FrS7BziuGHLsIad00UMBqcgtoba/?=
 =?us-ascii?Q?M6jGsDj7XEPD2MLfIZ4GFWgMhuBXz4o63DBEmGZTGO2nRiozkpExNBgJURWh?=
 =?us-ascii?Q?RmrxXN14ReJnPEvgU8VvfW/D+BVjr9aecAsjmT0lOa4JOWaiiCGXfD9267Yr?=
 =?us-ascii?Q?Fb+52/Tw1hqbf4J1RPjVrR9Lwv5HisF+LSKqXe/mgqIMulw5BQ5lD6MCmaAO?=
 =?us-ascii?Q?ISaFZHh2Wv5tevp8PgfhlrxcPS6XZJl8W9AZNV/z1eNY/oSVxyP5rZDpT2Ei?=
 =?us-ascii?Q?ANWG+KhB9/KcDpRvCvWmLw0xf9t69qMXrnMyXQ4stZ8OAHEWw1i6fW4cpBdA?=
 =?us-ascii?Q?DfcIKaOUB+MPigCORhp+QqooiomyGpPvvYHuWq2FYu36yZk/dSVHCEyYMZEV?=
 =?us-ascii?Q?yt+GBvfyZRXfJ1veUVV2+3RO4N1+1wRDXIWE+Vewh/qkkvcn7/lTvI4RkH7D?=
 =?us-ascii?Q?RNVIHtBb7q7PdUTu71+2dHgFzLdkoOJgM/WWWVO4yRJ8oe1rJiXL155x9cGZ?=
 =?us-ascii?Q?p6Yjs0HX7c9WjetvceEDv7rR2fXMiLgrnU1zlIv/37g74QCNa355AljxSt2Y?=
 =?us-ascii?Q?aF5GUg/6ra9bW0RRPVlWB8T396w3kyw1rh9200v0HFYuRZzrczdN8mpQKQKq?=
 =?us-ascii?Q?gY8uyJza5XNcD6DTF2/o7K4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kNFJ1bG0PGJTobKlChm4GNzqnN+8rKEfB25yYuTXtGkDabGijcHlMCWkYi26?=
 =?us-ascii?Q?L+vx5cDXN4quBuqIhef/dmBdG3JIlk87ruLtzRsX5e9THY0VPat/HBoY1ufk?=
 =?us-ascii?Q?zwXTjq2J7WYdWvDIsscC4q8yVIBKxVXFdSLZLMLCkeG0oFeZ7cFZScbtdGMW?=
 =?us-ascii?Q?6S/88VqOCQoH3NnUc5477k8zsNKmQWCVpFh75j4Ok9xgBus4YcXAaojt/J1O?=
 =?us-ascii?Q?CpiInymPFWrh/fRGswnkTPVIPacXfRDqjiXOXrU4BFuioQCZ+jfTiOm+tUWP?=
 =?us-ascii?Q?UkuZjCkB5bcyXBPRprs4Azmvyh/G3wLtA2C3XSxhKWqPLS+8rAt9cL95aqfY?=
 =?us-ascii?Q?OynHds5lDd7Ws2sPXJ4Tns5OW49Ea8DsRybe/PP8f+r+6Z4PHOU52QQ0dqWv?=
 =?us-ascii?Q?gkgOUTxhENeoPgcpov4QAjcv5B+5x3qvi8qRrG6NM5tvc8M7AcQEmds79Yg6?=
 =?us-ascii?Q?74c7OhbmL0U5qj1WGx0ytPmB4mZZY/1mmfTyn9W9m9MF7RPKJK+9q0rPotKI?=
 =?us-ascii?Q?nshp/6kRzqmhz+UPAN7h2rCsDHWmeJhDDzZpe4reLYQ3srPThsz/eu8NTzNJ?=
 =?us-ascii?Q?bA8c8Kww9n2f2TFJooy0OFmKA6qFm0cePmvtPATZ5Pxs9glEgyWqiiPRZM7q?=
 =?us-ascii?Q?1fwIhGOyVDfWfnN4H7wbXQa0HPLecH1kvBIg8q3Ut8dD9XkEetBTolEhrTAN?=
 =?us-ascii?Q?ktNN6vIAKYCYtov0kl7IqKYGjvLTn0DiDaGSPXQ8KjA3SYbwoAZ1eYoOJ5St?=
 =?us-ascii?Q?oakOxd0utjkdNG3SMG38uwJZ/3RZ4EKfm+jKwWCoaJraAowbHCiEEx0wuy6A?=
 =?us-ascii?Q?HsBCDTZ64Jpuna25D3kS+zDGK+z2ntgnBinsm6tYbNFgcxKO2yJ5u6FB65jH?=
 =?us-ascii?Q?NNhA2O7ChI7HLuWvs2PkghAMMkf7o15lE4VTK94b6/vaAo1uMJdUzrayuM7y?=
 =?us-ascii?Q?eyAKkF2A7B2kww05DjGQE5aG5ZpAi7rrIVEe6xS6LP3eGs6thizBPAkiD3rH?=
 =?us-ascii?Q?2ZBJex6x5zGs+1YP7ZsH4bFA1crgjjEvxz5PrdBjuYn38rUdUFSWib41vPhB?=
 =?us-ascii?Q?Gk/mYmrZKQUtYHBEV4yhA/mn+rYIV2hlu9UkM7XDqoJo7M4osBRnONPuPcmP?=
 =?us-ascii?Q?6qWUKXq4GqG8OGFlnciMb4w8FsYd9uBkCXULxs3GL8yfP8YKascc3T/BzbPo?=
 =?us-ascii?Q?wUFjA9UZtQr0HQPzXLRW97E5aMD58RhBAKVg4z9nsj/3ZhgjJMzpozRJr3RM?=
 =?us-ascii?Q?x7WrDxhVJIZEHDSymakplEMRMBFJ7Vp0sa1J8HXfbzVNRioTZYla/d09qfpO?=
 =?us-ascii?Q?YPbUr25bdHVgGYvNIq7tH6in7JrADMFYvRLbZAfzfxEpM4QgZtOANAjiP4k1?=
 =?us-ascii?Q?kI4YmShbu9p1W1JhN+rtMjxB7uhUDoTZBnW3DxuXqKJv82TUPwB9Tr3NiXQv?=
 =?us-ascii?Q?be8ix1NeA0wyeBys6RfDpvZSxIzc+DdztzDLF+WYfdBCrgWoTjHxmT4ZEHrZ?=
 =?us-ascii?Q?zunKihRYDIwEbqVSoqiVHRBm8WApbnwnFZrD4/MW6k0PdpYJUEs1ta0j1R8a?=
 =?us-ascii?Q?JdtUhO33CDcLxt/g8DrQe+U/A6CrHUKg+jOZ41z/O6BhobAIE7nMm8+cSREh?=
 =?us-ascii?Q?+6+/1VjtQH1RYPQ6P+p+f+jXsyL+dd7oqM0HBckLRl7uQHmVCcg+A7GSrfF6?=
 =?us-ascii?Q?XTG7VbUIRTR6LhdqUg3LRpFMM7/eftRPzPNBCdlSup25+kg64ESHAbGQPeao?=
 =?us-ascii?Q?K2uxOztqQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4a0011-6d06-464f-fa98-08de589ef1a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 03:41:21.4875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZchTR/LXO5Qt8rOxgv/u1EgNrI47cjsVaygzNRxJJj76o43KEEuHrDUDqy6SmTNMOnu2DLqtCYxwHRN4bAO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5240
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210678-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:dkim,SJ0PR11MB5613.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixu.zhang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E8A60508B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi stable team,

I would like to request a backport of the following commits to stable:

Commit 1: 0d30dae38fe01cd1de358c6039a0b1184689fe51
Subject: HID: intel-ish-hid: Use dedicated unbound workqueues to prevent re=
sume blocking

Commit 2: 3644f4411713f52bf231574aa8759e3d8e20b341
Subject: HID: intel-ish-hid: Fix -Wcast-function-type-strict in devm_ishtp_=
alloc_workqueue()

Upstream: Merged in mainline
Target stable: 6.18.x

Reason for backport:
These two commits should be backported together as the second one is a fix=
=20
for the first one.

The first commit (0d30dae) fixes a critical system resume blocking issue in=
=20
the Intel ISH HID driver. During suspend/resume tests with S2IDLE, ISH=20
functional failures were observed due to delays in executing the ISH resume=
=20
handler. The issue occurs because schedule_work() uses system_wq, which can=
=20
be occupied by long-running work items on other unbound workqueues, causing=
=20
the ISH resume handler to be delayed by up to 1 second. This delay causes=20
ISH functionality failures and affects system resume reliability.

The solution creates dedicated unbound workqueues for all ISH operations,=20
allowing work items to execute on any available CPU and eliminating=20
CPU-specific bottlenecks.

The second commit (3644f44) fixes a compilation warning/error introduced by=
=20
the first commit.

Impact:
- Fixes system resume blocking issues on Intel ISH hardware
- Improves resume reliability under varying system loads =20
- Prevents compilation errors with strict warning settings

This affects users of Intel ISH (Integrated Sensor Hub) hardware, which is=
=20
present in many modern Intel-based laptops and devices.

Both patches are relatively low-risk and should apply cleanly to stable=20
branches. I can provide backported versions if there are any conflicts.

Thanks,
-Lixu

