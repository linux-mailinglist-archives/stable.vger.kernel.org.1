Return-Path: <stable+bounces-249022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPz8NEa0CGr31wMAu9opvQ
	(envelope-from <stable+bounces-249022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:15:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878055D0AB
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F48301051B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02281EF39E;
	Sat, 16 May 2026 18:15:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021086.outbound.protection.outlook.com [52.101.70.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDF49659;
	Sat, 16 May 2026 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955328; cv=fail; b=IkokiU3FVXIwjYH00+m4MHP1a8UKIvC6u+NQYTk+yw8YltVO+d9n4MfFIm3t8aXe7W3vvs681CSvFugkd5Bd4RhqAogLad5r+w3tzU76/rvl656x4C3kQPVacY1yfkRAs/XiMG9f+1eUrWVr1a4c+W9qeXgqVxKiffI421nAe04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955328; c=relaxed/simple;
	bh=NgkSQDDuzCeUZqAneKnqVT/9+MubmzWESoRfMfjoo/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZnSTAj51kCBL7faelq9hUonzGKQBy/KRjDnz4k5hr+blzaJBWl9nDkZMD5kOPCJ3pJHYgvhmt5sdIKHo/0au5Oo8gzqTDHp3wNpH6pMhSPfUzXeg1q5DEpwD+469z/yBuqY/aeTvoQ7ROxGgMbx3DqMcGOutS6TQ0Net1QvcQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunnix.com; spf=pass smtp.mailfrom=secunnix.com; arc=fail smtp.client-ip=52.101.70.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunnix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunnix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI50Fm6b9GMIZPYYuBUYyIbOgP0x50APuKtdFMAyPP8ck0kUI7H3QHRflQEyb+77eh99qmfq5Hx14ZnbJ9qb0fLbQQmepf3mfoiIp2An31YOiE1HWB/N7Vx4UzxVB7P9Ue8e4fxxnWK23Uus4Z5TAv+93vdcXeMbt9VuOMFbZKG/HWhm05wzgU3M2QEyb5hw6SYgPSidme2NKfmmweI/+y0SkOJ1nd3JLJAcOSYF06PJgKLHP9jh+/mFeS1TEA+WndYD7jd4nvIX7F7QfT9iFyjoA+5w4Gv9OwhPEs+8/tCPGHBePk540aMV3UJZ6OkXgh/eHKlDIh6cq07vAajBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXbhpyoCNZSdFLXirzezQlAL+qFmbY42jpABP813/Dk=;
 b=huIajDJ4jtOa8ZtfLZDpk+GR2CIvnos04HySAEjmeOV3yomu+CcFTgD1e/c/MEnsWxUZxFAqYATmx8oBztonr6VDI2Ur9lYbAM4mxj4OVqKsJb4YB1FJ6TvWHjCX0y59wO/TOHPW6E2Bw9u9QiHNRyXBe2btsaEYVUTNuSwE3rNbFy4FOyR87Cr8eDMBd+LvX6PEHJU6g8WI8V+FZ4M6GZF82CWhpAyiM+R0H73m6LwNp0ynpeR+3et6cbFMCzrqq6DKmvHWvzCyDUdSjf7v2toGWnAcHbM1u26c/5Ef1p1cq0Bmbw/5JjeoV12rOc5oe0Jp3320/r3eJGbKqCA55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=secunnix.com; dmarc=pass action=none header.from=secunnix.com;
 dkim=pass header.d=secunnix.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=secunnix.com;
Received: from AS8P250MB0791.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:570::14)
 by AM7PPFE24A3C47E.EURP250.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::727) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Sat, 16 May
 2026 18:15:23 +0000
Received: from AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
 ([fe80::8627:43f7:324e:6aa1]) by AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
 ([fe80::8627:43f7:324e:6aa1%6]) with mapi id 15.21.0025.020; Sat, 16 May 2026
 18:15:23 +0000
From: =?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>
Subject: [PATCH v4] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
Date: Sat, 16 May 2026 21:15:04 +0300
Message-Id: <20260516181504.3076260-1-safa.karakus@secunnix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516092139.2618159-1-safa.karakus@secunnix.com>
References: <20260516092139.2618159-1-safa.karakus@secunnix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:570::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P250MB0791:EE_|AM7PPFE24A3C47E:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d960a5-8098-42f1-576a-08deb3771886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	eGIju3oribUDBsIZ/V/G6+/J3QqND4H6Uh3e1rFl8ROcONJCshEi+1xMXQWGtnVQVfUCaDzsdqCdmTFHbaU0vsLs3qy6FUSNcvuzpANjRLjuLn/BfO0WYAok6T5pRjZE22+HgJvWIOjJBhFQswg8wCarA207qrAVviro7cJvv06V2WVurfoijIztJiA7nXtX6LpwcD4yB7os0b6+srzkoZyfg3rOxbvS769rQDM3R4vO7zJT0ivGykZr4xvZlZZ/2GPgQMUdXyKuCpn50xYkZV+v7a4zhcfdqKNCx1b0KuVlr/GV7ic9hXAWBghiJs99o0Ae7QcKq7l8/x9c9hFqkp4jky/1+bSvsu8utK2ZH3gvfHO2rYTzYZdwLBzpVMbciqCZtj7rmTomk7xUaSPz0uQUYmog+WfcSNDup6rg8HjA5MPFQYZxAr+eqBBpdg8wjVk1ABT0fPcpIMpg55h1z45ccJIv3bN7hU8btJydgtOl/95NBJsE+vVbAiyNnDRNO7qNZ5amS2SCSJuDL6S4ZfnR/cblpaH8Oc1DnoYJMjrFbtX6eYZcdC23t//nID3M+kJHyzqWWv8u7hw5t5NzgKk9jR9L779OnHsdE/wPj4Ez17Hsv1ts10P8yOWvQeCfVVyVBhDLiwpSTpBl6n70zK+JcNy89b/KnaDl+/auGEUOECql5QQ6qisE4B/pCGD4g/T7Yc55q7HBIJFxfqFasroo2i3NZZ8PNCaD00EF/VlJCzOyW3N0WzagajdY34x0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P250MB0791.EURP250.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFFSUF4SCtVdW9uQ1NqemRPcE1XME4xWU1CeXBmV0ZQZWJSV2JwVG9lanR5?=
 =?utf-8?B?ODl5czFUaG1OZEhHM0NFY2FRSXc3MEdpQnQwUVdYTUZIOWlGaXZkcGpCTGE3?=
 =?utf-8?B?Um1OL0ptWXJLVjFxQzgydkZRVG5FZ1hSWFA0WkZxZG5vcUFXK3R2eVFYRW85?=
 =?utf-8?B?RFdGamNvWk93SUxkK0c2eU1nM09Ua2R4S1Vld3ljSWlQVWIzUlZscTQ3RDFM?=
 =?utf-8?B?M3c4NUpyb3lzdnJNcUVzamZ2ckNEWjZNNVAvRUJweEJOWjRneFFZUEFKTEE0?=
 =?utf-8?B?SXFsNVVPR2ZvOU5IeXZwSDE2WjVuRXRadXR3a1ZrcjVRa2dkV0NuZndQNHow?=
 =?utf-8?B?bmRPTmZzWVJJeEYwOC80QzcxRnZwMitOOVR1dktvSVZBSVdwMTlEazg1NEg4?=
 =?utf-8?B?WUY5dWo1RDNwZlpmbk5CbnQ3MWlnb2hPbGJIQXdiU3J0R2lUNGlmTnJlRk1O?=
 =?utf-8?B?SkJPUXgwVHpSbUxJTWFrb1JPZmhON1RvS1FKallIZTdBSFpZaURickxwb0gr?=
 =?utf-8?B?UzY2M2p3RVpxV2VpVWNaejZicjZzODlzU1BEZ1ZuUnEwMlRRc051aVhLWEJK?=
 =?utf-8?B?UXZSeCtwU0NRQjkwbGw5azFVMHZJeEZ0N3pmQWNlSmFBb2JHT3YxSXBuSzVw?=
 =?utf-8?B?NVBwOXZSeVFaaDF1cjJrM3FXSkV0eTlSSE4wSGZva0t0VS9IVjlaQUVNdjJW?=
 =?utf-8?B?MlFxNVR0RUsyQzFxOVNNNlhzRTJnTUdYdFZ1L042cUhEaHJUU0ZHdjVpVUVu?=
 =?utf-8?B?VVdpVTVTV3dqZWE5QW80UFdhdHlVbmhWbk0yL0ZCN2M5V0FabVVEVkVnMDdh?=
 =?utf-8?B?UkZORzZSZXhWM2hMNWpXNmRFNHlocURYTjY2QSt3elpCZmtHeXJKNlhzUzRW?=
 =?utf-8?B?dUJ4SlZ1LzczaURPZUllREhUUUFwRTF2VWs1Y3ZPZUtYSEt4R3I2S1o1SnpD?=
 =?utf-8?B?WWRHcnpDUzJzRWEwN2M1UGdWVlYxRXkrMnlzN2ZEcUxuYlNIN05OSFZIRis2?=
 =?utf-8?B?MEhUNFRSTmNjdWs2MzhrZ1RmUlQzWDZ3OUZVbTVHb2V0bnVrYzVhZnV4M2VR?=
 =?utf-8?B?MXNRV3Buamt0NkpjNXNDdkxkbWl2VURCSU9saFAySjllWVU4WllEbEpwSzF6?=
 =?utf-8?B?U0lhZGtHNWg2eldvM0hmVjJiN0dLTmdPN0tETmphU3J1RkhQSm0veThscks4?=
 =?utf-8?B?dVRsaW00cUNZUktEZE45MFRmbzA2WnJsaFM2ZVV3dDRtTjdNaWJNbFVQbXBR?=
 =?utf-8?B?amFpbnVyQkh4alU4a0dSSFZqMUdnMDhNU05OR1JpK0pXWlVEeVVkSVVsbkZl?=
 =?utf-8?B?L1JGWWRRZzdqMHIySWtNNnFOTXR0VTlCb1BYVVJIWUk3RUc3bzR2M0psUkph?=
 =?utf-8?B?UDNuOUZKVWtabWpaMHNiTHJCL0xieTh5K1o1MWJnbW9UdWRUWi9mbFl4cmxq?=
 =?utf-8?B?SXRLanpOelJacEF6VHp1eUkyL1N1RWthYnkxSWJHdUtYUm1rcUovVmdhaXpr?=
 =?utf-8?B?bWpJTkZISGtDSGZ4LzBMWjVPMWFJd1A4L0xEU1pCVm1oS2NKNWVoMDdaZy8y?=
 =?utf-8?B?dDh6eUsvcC9tc0xidjNLOUxUZ0M0Rkw5RkpOQ0Z4dW0vL2UxKy8rVzNsWGZO?=
 =?utf-8?B?L1RKVUNNRHZra0FjRE5vc2tmVURIanB2YTliemtob1g2NU5IZmY1ajB2VDRt?=
 =?utf-8?B?aXJjQmFPY0x3U0pWaW90OGJNTWVjNG94ZnRhSUFCWlVYaHV2ejZiMkU4Szl6?=
 =?utf-8?B?WHRma1dhNWg5aGo4OGp4SVhhKzhHUG5WOVBLUmx0cjY3SUh0bWV6Qm5qL2lv?=
 =?utf-8?B?NlI1TWhvUDE3UHowNHVibDlzL3kwRHZ5ZE4zNDJkaVhjMTd0K3NzeDJGMG5j?=
 =?utf-8?B?cEFWRm80TUJUcVBVbWh0N2tHaUJ2dmZic0x0d0dUUzFjYlo2dlMrM3I2MVd2?=
 =?utf-8?B?VHJrazR0NHc1STZVb2hhZGhBcW82U2ppaGU0ME1SV0ZBcHI1ejArWGhETk1m?=
 =?utf-8?B?a3dqNlBHaEVlREdQRTZ2SlU2a3hJQkNjQnpHZnVETEppRXhFVmsydVU4SGwy?=
 =?utf-8?B?ZnpmV1kxOE5KZG83cDNUcjJmd0R2d3pRbUxjclZ2OU9HT0tWbGI3alVpd3Zi?=
 =?utf-8?B?YkVKbnJINjNSSVVpU3VCelBFQmRWdGJjcDRKNU5LSUZBTjBTa2Q3U0dKS0ZC?=
 =?utf-8?B?TTJLUnREU3M0V2xPaWdlWFpUdVZlNzdHSHNuWWRkdHE4MEJJYkdudENTNnA3?=
 =?utf-8?B?dFEwWDd4OGVMR3VCWUhmcXRjaXR6V2Y2Zjc5c3pKYTJKeGdHZng2T3RDU0N5?=
 =?utf-8?B?THdKa2FwVFJCSXhwMTQ3NlVyeExWMWhtYkRjcm9RNFhEcVJyWjdlcGZBTmJY?=
 =?utf-8?Q?3DhOn6h1ylnXDgrA=3D?=
X-OriginatorOrg: secunnix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d960a5-8098-42f1-576a-08deb3771886
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 18:15:23.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2eefc8bf-b417-4556-be78-a3aa096a840e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzCH0HT6yjHcs8BmZNxq4kyCAUe7VGa80BPS7fh20bmxafwjB3E4l/CGsVY1GCFcZ+p0lYRLckcmoMJ8G3oL9cLPT6C5qwbhmBGxIEZ/gAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPFE24A3C47E
X-Rspamd-Queue-Id: 4878055D0AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[secunnix.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249022-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org,secunnix.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safa.karakus@secunnix.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunnix.com:email,secunnix.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

bt_accept_dequeue() unlinks a not-yet-accepted child from the parent
accept queue and release_sock()s it before returning, so the returned
sk has no caller reference and is unlocked.

l2cap_sock_cleanup_listen() walks these children on listening-socket
close.  A concurrent HCI disconnect drives hci_rx_work ->
l2cap_conn_del() which runs l2cap_chan_del() + l2cap_sock_kill() and
frees the child sk and its l2cap_chan; cleanup_listen() then uses both:

  BUG: KASAN: slab-use-after-free in l2cap_sock_kill
    l2cap_sock_kill / l2cap_sock_cleanup_listen / __x64_sys_close
  Freed by: l2cap_conn_del -> l2cap_sock_close_cb -> l2cap_sock_kill

This is distinct from the two fixes already in this area: commit
e83f5e24da741 ("Bluetooth: serialize accept_q access") serialises the
accept_q list/poll and takes temporary refs inside bt_accept_dequeue(),
and CVE-2025-39860 serialises the userspace close()/accept() race by
calling cleanup_listen() under lock_sock() in l2cap_sock_release().
Neither covers l2cap_conn_del() running from hci_rx_work, so this UAF
still reproduces on current bluetooth/master.

Take the reference at the source: bt_accept_dequeue() does sock_hold()
while sk is still locked, before release_sock(); callers sock_put().
cleanup_listen() pins the chan with l2cap_chan_hold_unless_zero() under
a brief child sk lock (serialising vs l2cap_sock_teardown_cb()), drops
it before l2cap_chan_lock(), and skips a duplicate l2cap_sock_kill() on
SOCK_DEAD.  conn->lock is not taken here: cleanup_listen() runs under
the parent sk lock and that would invert
conn->lock -> chan->lock -> sk_lock (lockdep).

KASAN/SMP: an unprivileged listen/close vs HCI-disconnect race produced
12 use-after-free reports per run before this change; 0, and no lockdep
report, over 1600+ raced iterations after it on bluetooth/master.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Safa Karakuş <safa.karakus@secunnix.com>
---
Hi Luiz,

v4 - rebased on current bluetooth/master (after e83f5e24d "serialize
accept_q access"); the af_bluetooth.c hunk now sits in the reworked
bt_accept_dequeue().  This residual (cleanup_listen vs l2cap_conn_del,
not covered by e83f5e24d nor CVE-2025-39860) is unchanged from v3 and
re-verified with KASAN on bluetooth/master: 12 UAF/run -> 0, no
lockdep, over 1600+ raced iterations.

Changes since v3: rebased onto e83f5e24d; commit message notes why
e83f5e24d/CVE-2025-39860 do not cover this path.
Changes since v2: fix at the source in bt_accept_dequeue() + chan
lifetime via l2cap_chan_hold_unless_zero(); no conn->lock (lockdep).
Changes since v1: consistent From/Signed-off-by.

 net/bluetooth/af_bluetooth.c | 10 +++++++
 net/bluetooth/iso.c          |  9 ++++++-
 net/bluetooth/l2cap_sock.c   | 51 +++++++++++++++++++++++++++++++-----
 net/bluetooth/rfcomm/sock.c  |  9 ++++++-
 net/bluetooth/sco.c          |  9 ++++++-
 5 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 9d68dd860..1a6aa3f8d 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -340,6 +340,16 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			if (newsock)
 				sock_graft(sk, newsock);
 
+			/* Hand the caller a reference taken while sk is
+			 * still locked.  bt_accept_unlink() just dropped
+			 * the accept-queue reference; without this hold a
+			 * concurrent teardown (e.g. l2cap_conn_del() ->
+			 * l2cap_sock_kill()) could free sk between
+			 * release_sock() and the caller using it.  Every
+			 * caller drops this with sock_put() when done.
+			 */
+			sock_hold(sk);
+
 			release_sock(sk);
 			if (next)
 				sock_put(next);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7cb2864fe..812f9002d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -751,6 +751,8 @@ static void iso_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		iso_sock_close(sk);
 		iso_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	/* If listening socket has a hcon, properly disconnect it */
@@ -1356,8 +1358,13 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		ch = bt_accept_dequeue(sk, newsock);
-		if (ch)
+		if (ch) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps ch alive from here.
+			 */
+			sock_put(ch);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cf590a67d..b34e7da8d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -349,8 +349,13 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
@@ -1475,22 +1480,54 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	BT_DBG("parent %p state %s", parent,
 	       state_to_string(parent->sk_state));
 
-	/* Close not yet accepted channels */
+	/* Close not yet accepted channels.
+	 *
+	 * bt_accept_dequeue() now returns sk with an extra reference held
+	 * (taken while sk was still locked) so a concurrent l2cap_conn_del()
+	 * -> l2cap_sock_kill() cannot free sk under us.
+	 *
+	 * cleanup_listen() runs under the parent sk lock, so unlike
+	 * l2cap_sock_shutdown() we must NOT take conn->lock here: that would
+	 * establish sk_lock -> conn->lock and invert the established
+	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
+	 *
+	 * Instead, briefly take the child sk lock to fetch and pin its chan.
+	 * l2cap_conn_del() reaches the chan free only via
+	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
+	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
+	 * therefore guarantees the chan cannot be freed while we read and
+	 * pin it (hold_unless_zero() additionally skips a chan already past
+	 * its last reference).  We then drop the sk lock before taking
+	 * chan->lock, so sk and chan locks are never held together.
+	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+		struct l2cap_chan *chan;
+
+		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
+		chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
+		release_sock(sk);
+		if (!chan) {
+			/* l2cap_conn_del() already tearing this child down */
+			sock_put(sk);
+			continue;
+		}
 
 		BT_DBG("child chan %p state %s", chan,
 		       state_to_string(chan->state));
 
-		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
-
 		__clear_chan_timer(chan);
 		l2cap_chan_close(chan, ECONNRESET);
-		l2cap_sock_kill(sk);
-
+		/* l2cap_conn_del() may already have killed this socket
+		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
+		 * double sock_put()/l2cap_chan_put().
+		 */
+		if (!sock_flag(sk, SOCK_DEAD))
+			l2cap_sock_kill(sk);
 		l2cap_chan_unlock(chan);
+
 		l2cap_chan_put(chan);
+		sock_put(sk);
 	}
 }
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index be6639cd6..bd7d959c6 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -180,6 +180,8 @@ static void rfcomm_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		rfcomm_sock_close(sk);
 		rfcomm_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -497,8 +499,13 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index eba44525d..f1799c6a6 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -502,6 +502,8 @@ static void sco_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		sco_sock_close(sk);
 		sco_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -765,8 +767,13 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		ch = bt_accept_dequeue(sk, newsock);
-		if (ch)
+		if (ch) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps ch alive from here.
+			 */
+			sock_put(ch);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
-- 
2.34.1


