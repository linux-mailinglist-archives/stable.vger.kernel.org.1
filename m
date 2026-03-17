Return-Path: <stable+bounces-226003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JPQEcBSuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:10:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 079AE2AA8B8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27C343050CC6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B03C73DF;
	Tue, 17 Mar 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="fItbnrfp"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021093.outbound.protection.outlook.com [40.107.39.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42E217648
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752761; cv=fail; b=q/hyDylhIBi4l6zVhsPv0I4/V4suMCOCX6V0qmOlunUa6YBUI1JkRwJqcgpcCeyKKc6rsaWkwDGEFyC7JHkEu1Z27c+pyG8fM2cixDBuKiimWPUoOGwMP/tgocK0WB6inIWnP/ZGFbTG8FNFVUa+NCsSDaf13ebv6mlL9cyiPLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752761; c=relaxed/simple;
	bh=ljyddPMNeJM1xI0St2EnDLaNBzK2s/kiqdXyziqVC+U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nk+P17AdoAowLKTAiwfEatfveym7CsMq41BWBUu9Bj4PapZagCmnTW9VygTN3vN/WAtr7+GzxKO6bnP71qMpNyE/t1Uhs5lzEEjlmG0qXZ451J+uzfvnACm8HQQhMfJXP3CFE7ZiRcC6dm+pp4pJFXWjk8lpkdDQcbGSVyEeJ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=fItbnrfp reason="signature verification failed"; arc=fail smtp.client-ip=40.107.39.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaEqTfnxsjhP/U12mwaSL+O1xqjdEeS1yl5vjgELfKaO9QEtVVfnYev1HhVHlcwCQATJ1YShthj0bVSeprIaj0OStxxllwDs7AgYcJNdhssXWo6oi/3P0/3r+hx3n9GugiiebnxcBuNOe7Q0hjwDuf2jiZ6kmg+fI4kkQ03ZqaD6tjyRxLrpJjOWexMkCvbobC6kdK0gn8sziKeI+Aq6iDMjS2gQw+UbnspyJPAUKgTVvdyUUNWBKMhOXXyUzBKs2ifTbnYrXNeiddEv3I2bCT+p1Y3c66tnrv9s7beyo9Ef0EpKJ2LCprKaGdMEy2VZKr8SvyxzpQMQqSACv1ei6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPHRnjByqP1nY3F0jT++TDlSE7+Q0nSxkEL4uH+5nQw=;
 b=S+ahVByzmt9/oBcmRpb9dohw4G7wPrZPi/fjGdvqRvESv5gtwPDg+qKDilEW879fDJDD4ouyr7/V686SZTgL70Y76RppLZuNhfU0Kz/PAtAx967Ehfh8oL4pX2x1iIXFQJerxQ6AIfEhTD5LmBeYruIY/QEYqEzckKYu0WvvEl64jPcEdwUlJP0PSba9lXw2RH5Flnf7y3bAAUuNd7kRjthTXNJ7yYoSrsl2wsHk9Ei2wgej/P4/lRwig2Q/mMw+mIddssXo2B9h6I3LMzdLcB1rBq64el1M0Wt6kCyhmo/uRBmJpMjRy0G6EnuoalPslcDzurmYHUTxiOqv00SOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPHRnjByqP1nY3F0jT++TDlSE7+Q0nSxkEL4uH+5nQw=;
 b=fItbnrfp4a1HNoHSzcW+IFlWhs/UAxcFvSes8rCS5GycyGv0CrqrL8kXmbKntfy/Ph6cZDF+iFh1H1mfpcux6FIbiZNMpjh2FY3tKaWWpXGDXJ9OO4Q4Zp0KGAO2CeP/2eUt65WlqAhPEjLYtS2TbGiare6cYD6aCK3Xlqm1DTyvffoc+LU7VMILiNeVcvRexcDW+X9nyWEZRC3VyrvyYubeO6qZe6jxe21z/8QZtCntXaSoXW2v5iYCWCFu2DpPHTFyr54PxHAgDB2qdFcK1VqCW91Ws8y/MxFuMMjSAxcqr7vOMfqdasPf4Tibvt9k5ldJSrfSEGLKtKT8IDUsnA==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY7P300MB0539.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:287::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 13:05:56 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 13:05:56 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Werner Kasselman <werner@verivus.ai>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] ksmbd: fix use-after-free and NULL deref in
 smb_grant_oplock()
Thread-Topic: [PATCH] ksmbd: fix use-after-free and NULL deref in
 smb_grant_oplock()
Thread-Index: AQHctg7K0kpJc+ByXEmqH2Mqv7dy3A==
Date: Tue, 17 Mar 2026 13:05:56 +0000
Message-ID: <20260317130554.2609496-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY7P300MB0539:EE_
x-ms-office365-filtering-correlation-id: a69258a7-97b0-41b7-d2c0-08de8425ed6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info:
 jh8/OookBxSZrLD+PDyRC2Xlmh+mZy4RTzia0TE64CS/jzK+zouGBKpgTEcKLfok2nOXPQcOOiUaWH9Ue3g6RMkH4dO45FvKPJfZPfDLK4Kh1Z9KABDa3pkCyWOchg3ksMsVJuIh1cX7b+vx8PCwYlsIHWKQt9wbfOiaHWALYaE//lUnfYH7ZHdb5XYr5OD9Zu4yKtMXO8GXlUd9TV18apFQbTarnnkc4cUsJQZ7I5GynlAWoumLSj9TDFMST/f77YcRmn9xaDJuc1VVh1HKWobOlTUynW9FvpzB9r6e5F8F48xnc/JEfonKBWrWX02itBTRj+XWpkbd85THlbNGtv+HLLRR16SGYVU5njjU5rnWi4OaUALzPP/FmRXvzdMl74qfA02FVQ48RSxlfIOczU3fiBFwmKIwfnLQ2hCeHUpBwGL1K9MuxODxx9PtGis/tyn4Rqs2tzl4IPo8q3wB4eVSDzK7tOy7WoyniCrzFDcVe+xQbkbLx7DPQBz4LdcZurbi/3KFAanpbMP0IORLhhHVeZAGjVZTL9cnRUxPfNPjrYLN+7/EqFgXBQwVPtQXLgZPMBH7Xm7OxdQ3AcPhsiyK1VXG8Pfj4P1q89XbQv+FhFihon76nOOOzqiN9xjapxGG0iXt0vMU1PQCUxD68KCtlwFI/zo7W8M1V7RY/JZ3qufRCRQkBG8WsLENAGl2EUbHR7rGv8hOS4122w62egEcWpLV/dFD1NU4+Q0qAwmrGNVcBZKdLGM3c+utoXyi4S852jQ+B+/rHH5S6AMA0FtKjt8WjNFkBjguqKgN5t4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q05tnEzmq1puXW67v5z0tUPuv15I43kxV/+AEc76GxViDtCdiSkSnHflAi?=
 =?iso-8859-1?Q?j4fwee014al4D4e5WSsEea7ri9hc4Os8HONm4vk3p/oM4rvyWwCpmMolji?=
 =?iso-8859-1?Q?NReXAzZ4F2LkL3pi+f4Z59vb4Z3XyHmWTKlywUeZ8/NHF3DeIHy75YDb59?=
 =?iso-8859-1?Q?5MN1HEKFD8Ch3x3U6E55bPkrPXt214WnXNm24xsWZjDM97wNYYFIhBSLGo?=
 =?iso-8859-1?Q?VzIqOKbR1Dzlhzed6WD0KkS5rjPdodkOV7IqROihV1TyOyJsgwLRi53wow?=
 =?iso-8859-1?Q?Nk2ePJy82PwhQ7LSjrhfp+lyJb/e68suXbS/gB6bTpnJ6pq2HdmxzhG0na?=
 =?iso-8859-1?Q?X4EKnWl/LTD8l6lAKmxk3QzboqTZCatzRZTQxdHY0ocpn0aKgjAGEFZ+ev?=
 =?iso-8859-1?Q?8IrJ+6+8zCxzfdtStIJ8uaXN15yyymv53yjRwpVFIrCb5eUThKmO+S/eja?=
 =?iso-8859-1?Q?XVsMAgsLt9d358wx1CLReJDUU9k12IaKkLpAyMe8sxuXU0at96GPwdsLKc?=
 =?iso-8859-1?Q?uE8nb7uEIxctZgXJmYYI2VYiy0xg1hDbwhBhE1LGZTG0VxCIHe6Hv1ShZ3?=
 =?iso-8859-1?Q?H3Nj0LKC2l04Qs7HKJX8qQilgSTPBXH6lcYm8Vm9ld0CMvLHFOj5lq/MXM?=
 =?iso-8859-1?Q?Dnx+1PAef2a+kRlpm6G0u4DRa/wueG5/oOPMapCKCWpNFtCXYAsKsFV3kh?=
 =?iso-8859-1?Q?vn8ipHfzt409omyLT880lo7J1gQCXePpAwTlwb+sbksR2388zfg410MrCC?=
 =?iso-8859-1?Q?CVZPiD3yU0lXA/tpXiq0O/FxoeIfD6YO8QrekjTIJY5KQ8adrlBq6JNnA+?=
 =?iso-8859-1?Q?JqN8OrQwWAZB4Km+MG2lBn/OhgDbXdt5IZdHpeuKqzhmDGMvlUWTbvW4in?=
 =?iso-8859-1?Q?imRkjaT12JkB3KKeDlJSGe72VO+m8ha0cZ5/vukIUt0FQ6c63vo+uaWiKx?=
 =?iso-8859-1?Q?qlvqqiGLwXZRlPSvzUFCP9BjWyQJRN59lhbuz2vSjPQeYedYY+6Kskkkwg?=
 =?iso-8859-1?Q?3sh75ldLFLLL5Ldr1VH0uc/LHQX5YEVf+8ZqDQIaK/szNHJ1OMROhOsUWY?=
 =?iso-8859-1?Q?4TsSvylRkQ6OzTSyhLjbolKQS2AAhfB/dMCy2HzTngzhS3qTtD5Bu0QjGT?=
 =?iso-8859-1?Q?iSoDPhtF/0yV8bBca9Kyp7fFSpL7FTNSl/whi3lQA5zwQIjPzWtsxHd5Ei?=
 =?iso-8859-1?Q?uv/WykMiYwHORL8seKbF5R9noaKe5jljvXrq32MZ8G+5YVh3z4J2CcEDHM?=
 =?iso-8859-1?Q?MMgoN2A3YOZpY0k6+q8dWnq0PETfuno288ayR/hJwTFMaEtiWhH3iSGmca?=
 =?iso-8859-1?Q?S18hVG8dG2bdpS/ooh2Ai2rt2Z2b4/VLAnhMGZ7OO+jTaJ1kxxXOHYi1qi?=
 =?iso-8859-1?Q?TxT3fiNyf+WrEdqdqqTpjVH5Duz0xQhx0RKjhJSDETcJ/Z/OLJxmqCkkfh?=
 =?iso-8859-1?Q?yQrdz4CwuIw4I6ADCh1lBPhBpjXEB8Nkb+0bbOkY1RydiBpfc9J/0Ph2/Q?=
 =?iso-8859-1?Q?12y7WQ2b1L5gAJGDJt4hDMDYHz2BkUK7gPHZAc9tNml2Lmb7OGOmb1pcLT?=
 =?iso-8859-1?Q?LfLB8EpkcwSayaL3uedigEe6QGKW9cXOYiEErzYADaWOocsLLSNwsbp7au?=
 =?iso-8859-1?Q?eWP0nfKtRvXX0DkqgdMPpYQWKbChhjNEkQIOWgzZtTm+5pVlvR3M3otDtf?=
 =?iso-8859-1?Q?MIAm38n36xm8QrJFiD/kTGNak5LUjbjyXQjxPxC7v087Ubt18lN9V39rma?=
 =?iso-8859-1?Q?oo50Ip5ShR7bpdLXUbeIOwHAiSWCwx79m+xgJazouWhKXVziExx0qJdwUy?=
 =?iso-8859-1?Q?OWpeMnTu3g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a69258a7-97b0-41b7-d2c0-08de8425ed6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 13:05:56.4781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pl+eeXyIezXsLvDN0m2SfLw8aJE5nzPtMQUtWlD49zmjre/XqN7nf/sC+NxXw2Qp79JLpY023Z+a7pYSuz2jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0539
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-226003-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.783];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 079AE2AA8B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smb_grant_oplock() has two issues in the oplock publication sequence:=0A=
=0A=
1) opinfo is linked into ci->m_op_list (via opinfo_add) before=0A=
   add_lease_global_list() is called.  If add_lease_global_list()=0A=
   fails (kmalloc returns NULL), the error path frees the opinfo=0A=
   via __free_opinfo() while it is still linked in ci->m_op_list.=0A=
   Concurrent m_op_list readers (opinfo_get_list, or direct iteration=0A=
   in smb_break_all_levII_oplock) dereference the freed node.=0A=
=0A=
2) opinfo->o_fp is assigned after add_lease_global_list() publishes=0A=
   the opinfo on the global lease list.  A concurrent=0A=
   find_same_lease_key() can walk the lease list and dereference=0A=
   opinfo->o_fp->f_ci while o_fp is still NULL.=0A=
=0A=
Fix by restructuring the publication sequence to eliminate post-publish=0A=
failure:=0A=
=0A=
- Set opinfo->o_fp before any list publication (fixes NULL deref).=0A=
- Preallocate lease_table via alloc_lease_table() before opinfo_add()=0A=
  so add_lease_global_list() becomes infallible after publication.=0A=
- Keep the original m_op_list publication order (opinfo_add before=0A=
  lease list) so concurrent opens via same_client_has_lease() and=0A=
  opinfo_get_list() still see the in-flight grant.=0A=
- Use opinfo_put() instead of __free_opinfo() on err_out so that=0A=
  the RCU-deferred free path is used.=0A=
=0A=
This also requires splitting add_lease_global_list() to take a=0A=
preallocated lease_table and changing its return type from int to void,=0A=
since it can no longer fail.=0A=
=0A=
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")=0A=
Fixes: 1dfd062caa16 ("ksmbd: fix use-after-free by using call_rcu() for opl=
ock_info")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 fs/smb/server/oplock.c | 72 ++++++++++++++++++++++++++----------------=0A=
 1 file changed, 45 insertions(+), 27 deletions(-)=0A=
=0A=
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c=0A=
index 393a4ae47cc1..9b2bb8764a80 100644=0A=
--- a/fs/smb/server/oplock.c=0A=
+++ b/fs/smb/server/oplock.c=0A=
@@ -82,11 +82,19 @@ static void lease_del_list(struct oplock_info *opinfo)=
=0A=
 	spin_unlock(&lb->lb_lock);=0A=
 }=0A=
 =0A=
-static void lb_add(struct lease_table *lb)=0A=
+static struct lease_table *alloc_lease_table(struct oplock_info *opinfo)=
=0A=
 {=0A=
-	write_lock(&lease_list_lock);=0A=
-	list_add(&lb->l_entry, &lease_table_list);=0A=
-	write_unlock(&lease_list_lock);=0A=
+	struct lease_table *lb;=0A=
+=0A=
+	lb =3D kmalloc_obj(struct lease_table, KSMBD_DEFAULT_GFP);=0A=
+	if (!lb)=0A=
+		return NULL;=0A=
+=0A=
+	memcpy(lb->client_guid, opinfo->conn->ClientGUID,=0A=
+	       SMB2_CLIENT_GUID_SIZE);=0A=
+	INIT_LIST_HEAD(&lb->lease_list);=0A=
+	spin_lock_init(&lb->lb_lock);=0A=
+	return lb;=0A=
 }=0A=
 =0A=
 static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *=
lctx)=0A=
@@ -1042,34 +1050,27 @@ static void copy_lease(struct oplock_info *op1, str=
uct oplock_info *op2)=0A=
 	lease2->version =3D lease1->version;=0A=
 }=0A=
 =0A=
-static int add_lease_global_list(struct oplock_info *opinfo)=0A=
+static void add_lease_global_list(struct oplock_info *opinfo,=0A=
+				  struct lease_table *new_lb)=0A=
 {=0A=
 	struct lease_table *lb;=0A=
 =0A=
-	read_lock(&lease_list_lock);=0A=
+	write_lock(&lease_list_lock);=0A=
 	list_for_each_entry(lb, &lease_table_list, l_entry) {=0A=
 		if (!memcmp(lb->client_guid, opinfo->conn->ClientGUID,=0A=
 			    SMB2_CLIENT_GUID_SIZE)) {=0A=
 			opinfo->o_lease->l_lb =3D lb;=0A=
 			lease_add_list(opinfo);=0A=
-			read_unlock(&lease_list_lock);=0A=
-			return 0;=0A=
+			write_unlock(&lease_list_lock);=0A=
+			kfree(new_lb);=0A=
+			return;=0A=
 		}=0A=
 	}=0A=
-	read_unlock(&lease_list_lock);=0A=
 =0A=
-	lb =3D kmalloc_obj(struct lease_table, KSMBD_DEFAULT_GFP);=0A=
-	if (!lb)=0A=
-		return -ENOMEM;=0A=
-=0A=
-	memcpy(lb->client_guid, opinfo->conn->ClientGUID,=0A=
-	       SMB2_CLIENT_GUID_SIZE);=0A=
-	INIT_LIST_HEAD(&lb->lease_list);=0A=
-	spin_lock_init(&lb->lb_lock);=0A=
-	opinfo->o_lease->l_lb =3D lb;=0A=
+	opinfo->o_lease->l_lb =3D new_lb;=0A=
 	lease_add_list(opinfo);=0A=
-	lb_add(lb);=0A=
-	return 0;=0A=
+	list_add(&new_lb->l_entry, &lease_table_list);=0A=
+	write_unlock(&lease_list_lock);=0A=
 }=0A=
 =0A=
 static void set_oplock_level(struct oplock_info *opinfo, int level,=0A=
@@ -1189,6 +1190,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req=
_op_level, u64 pid,=0A=
 	int err =3D 0;=0A=
 	struct oplock_info *opinfo =3D NULL, *prev_opinfo =3D NULL;=0A=
 	struct ksmbd_inode *ci =3D fp->f_ci;=0A=
+	struct lease_table *new_lb =3D NULL;=0A=
 	bool prev_op_has_lease;=0A=
 	__le32 prev_op_state =3D 0;=0A=
 =0A=
@@ -1291,21 +1293,37 @@ int smb_grant_oplock(struct ksmbd_work *work, int r=
eq_op_level, u64 pid,=0A=
 	set_oplock_level(opinfo, req_op_level, lctx);=0A=
 =0A=
 out:=0A=
-	opinfo_count_inc(fp);=0A=
-	opinfo_add(opinfo, fp);=0A=
-=0A=
+	/*=0A=
+	 * Set o_fp before any publication so that concurrent readers=0A=
+	 * (e.g. find_same_lease_key() on the lease list) that=0A=
+	 * dereference opinfo->o_fp don't hit a NULL pointer.=0A=
+	 *=0A=
+	 * Keep the original publication order so concurrent opens can=0A=
+	 * still observe the in-flight grant via ci->m_op_list, but make=0A=
+	 * everything after opinfo_add() no-fail by preallocating any new=0A=
+	 * lease_table first.=0A=
+	 */=0A=
+	opinfo->o_fp =3D fp;=0A=
 	if (opinfo->is_lease) {=0A=
-		err =3D add_lease_global_list(opinfo);=0A=
-		if (err)=0A=
+		new_lb =3D alloc_lease_table(opinfo);=0A=
+		if (!new_lb) {=0A=
+			err =3D -ENOMEM;=0A=
 			goto err_out;=0A=
+		}=0A=
 	}=0A=
 =0A=
+	opinfo_count_inc(fp);=0A=
+	opinfo_add(opinfo, fp);=0A=
+=0A=
+	if (opinfo->is_lease)=0A=
+		add_lease_global_list(opinfo, new_lb);=0A=
+=0A=
 	rcu_assign_pointer(fp->f_opinfo, opinfo);=0A=
-	opinfo->o_fp =3D fp;=0A=
 =0A=
 	return 0;=0A=
 err_out:=0A=
-	__free_opinfo(opinfo);=0A=
+	kfree(new_lb);=0A=
+	opinfo_put(opinfo);=0A=
 	return err;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=

