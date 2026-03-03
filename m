Return-Path: <stable+bounces-222895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCZUBRT1pmmgawAAu9opvQ
	(envelope-from <stable+bounces-222895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:49:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 680351F1C77
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F1753153EEE
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FDA3C2780;
	Tue,  3 Mar 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=guidelinegeo.com header.i=@guidelinegeo.com header.b="BiMa1g1n"
X-Original-To: stable@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022131.outbound.protection.outlook.com [52.101.82.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B93A8739
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549039; cv=fail; b=LTX5r9SJqwVH3PAG6ElOKHkjGKO/lf5pgdlZTEVS/NrTjYapo+GisFVH8E8sJXMxbw6nGQr6EkNMPDoa++OVYnqB/b/i8NwZwOuWTeWn6x6C6gDJ46HVYsr5iNAf4B9T5ab/UZ7lYg5MfR5OHggH/WWvXnIw+ZXjzPDuldqS9gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549039; c=relaxed/simple;
	bh=vZqgWX3o9CbZ9nRKquaNO+aQeSw1XRci7M1brfqbLoc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L7jGxCo0l7c8ae0Mie35Ulup76UbXyFEPaF3jhubuY5YxkHkNo8v2Tf4XOzKgUg5Vz5g+zYINZavaCwl7O5dFsj3NqjIaqQ6KN8jWxtz9xzUeeOgqsBUGTya+YBBjE3/2dKI2/Pkd4rILAk6rrG7/nAPwQIVc1XkPd9xR+g65po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=guidelinegeo.com; spf=pass smtp.mailfrom=guidelinegeo.com; dkim=pass (1024-bit key) header.d=guidelinegeo.com header.i=@guidelinegeo.com header.b=BiMa1g1n; arc=fail smtp.client-ip=52.101.82.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=guidelinegeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guidelinegeo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMVIJlq2odJPNer7WyTlUC2X4axBJCdeocZCWZdSA+Z5irMxgTlcWrB8hkQOu6rWjqAnjgXE/WQ9iFkdvtgMZIyxnKWaeR/GeCXg4vWk2knw0LKhG0cAF2hN6Q9y1ouR8wZf+00BYD+fv7/3E7TD4tfLZcUek7uide8YsqxGZQhZ2yOz85jM6pW8ORD4HoSHTLBMkfKlpCTz+EVE7IJlJCknF1bAhazM/m+PP4tJUfYMGBe6WLJIMdQEyCqpQ3JENj+1mDTl4EE35kECCdHfmVMPDrFGdljpn4uJhEp9+H1RaAKlrgZl5rO5LmNJIygsHB/ekfiQEO1Y2wDcgkN9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEkQ9dNY1XnxCyA9bBuiMFcOlaPpCMruxRKUrc6o1t8=;
 b=Fys4zyETF7V0QPaIKZaXvpO7TyfN0fs+xQEpB4AblRRqKLKOvTdckuI+jnO/INgk667357kCGiCit36cRp9juf/TsxYVA34bEPNqRA9SzMrAytqmx26yX2nPKFlIXNqI3QHwzrw85f/hfZ0JhHh0lLWROOxmOVNOUzCtiCv2FMwBjkRfE8HZHCvaK7QNF3iN7ftHPzU7L+BijJ3WcxpIf9uFpjVzgHzoLFUi5Nq3TTvPz+W3Tuc4DIy1xO+UF72511FzGqdluSrhXdRzYVHa44QVHYlAOyjmHuusSm8WMkZdBUgSKRPm6GbcBfOks7Qy9U/nLWhc/4lKgVtxv/frGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=guidelinegeo.com; dmarc=pass action=none
 header.from=guidelinegeo.com; dkim=pass header.d=guidelinegeo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=guidelinegeo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEkQ9dNY1XnxCyA9bBuiMFcOlaPpCMruxRKUrc6o1t8=;
 b=BiMa1g1nSYEebASDzeTzmCMjkBZ16kO2NiMzElVg0eSECj1HAmQGR/vPqLJ3p9bXiaIvYy20Osr8/vVzWOO/GDifxNAWh5FgXpjnTooZ+uAPnxAmzoWxlYY3rLLRDSK3M35dH91RLJJ76adEQyM4+h/bQNuxJ65shmgXV5WhDew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=guidelinegeo.com;
Received: from GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:14::9) by
 GVZP280MB1117.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:18f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 14:43:30 +0000
Received: from GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5a42:b24d:f94f:a5ec]) by GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5a42:b24d:f94f:a5ec%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:43:51 +0000
From: Christofer Jonason <christofer.jonason@guidelinegeo.com>
To: christofer.jonason@guidelinegeo.com
Cc: stable@vger.kernel.org
Subject: [PATCH] iio: adc: xilinx-xadc: Fix sequencer mode in postdisable for dual mux
Date: Tue,  3 Mar 2026 15:43:31 +0100
Message-ID: <20260303144331.1711532-1-christofer.jonason@guidelinegeo.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0052.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::14) To GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:14::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV3P280MB0065:EE_|GVZP280MB1117:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf42e66-b1c1-41c4-6387-08de79334925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	OAIuEp/q6KPkCimIqOz0I7LQjxYIK2gwY2/HCbbekxhDAhodCnJybMHBqsrWBTDuMvKyy22NcwNvu/mCeGs1rf7ym9aKKAJ9Kgkv9Wdp+OUiFlVR/qoaw6LqXUXDrHMXMvjyan1FPjg2FQZ2eO2RbHT5f92J/o5hmaWrvqtBUbxfztmj+lVXLgCW/d2t6wYULpRsFfzR2XxADaJ8A9CBly45BlTmlXp6g5WJ54u4O4PLIIIR3QOrOvd+ZSI1l4AIjSXXEJjwa8qGjaG0rI3bIKxwkPAJbdbu8eKhtlUTihtme2fYn5kqFuZtrU1rlV3xU6ZDQukRBH36pTC6EPDBtBck6ivTZ8JnZ8eJC5g8yTxdjNhVpzC65LZs3YTspAC2I+LwzNHYXNpEFftSbeamYFnQzjr9EjNb+lAd6g/N7c52YtoQUcaV1DZXDVyjhkVIEEoTkt6j4cQgwPiql7u8dH7s3AAzCFBs7dBaWbaXhVlHFJseY8f4iLKy/jhQm9bGmpIomTINoTpLD1LjmNCj1d7cIlxBU3G+cubY0Ha6qj6j70hSnVh/Z+szC1GecbDD2LZRaehzwf7hG5EtqRZYeIi45F2XmrLUnVnU6zUiw9ybwXpsymvthWWkzSGI3AbLPD4xkUATWDUfYZgh5YP7x96REGToH4TSDFuSpKq6aANivj7/A0gVi6RbL73U03ujjo62ThoO3ECRHEG3ieb5tRwBWfI+lE5Qk6O2QW29q2j1826fZQzcvtmdciXi4n2+ifHttckrVPBnIhEcAr96J61vZNXkb8+q5bUXDsrFSIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HnQ1E/nV0QgUx+ecKgRFoz5XGEypYOelSfQh4nv09C6b2qlIRmHBGdET9Tbm?=
 =?us-ascii?Q?mAgilrhZEveL83G6qkhyuEyD7M5ORx66M3BGgaLpq3wBdjtzZoJM/hAr0tHL?=
 =?us-ascii?Q?LLbQCGxCL70dtbNRYeV/ESeh3vCxzShPE1rfMq2GkYqJq6Gse+WW+PBPKWav?=
 =?us-ascii?Q?sv3fRPmAFDGI1dGJA4JVIPHIiyoDMRHrmOsYapfFr912Fij4fccNljr6rkDG?=
 =?us-ascii?Q?1KIgq+5ibZFrqO6x6vC4obcsgMs7GgMb/C4YA0imJd6FM0R+B0VNO7Z52xNZ?=
 =?us-ascii?Q?3ZFHFc3Mf0ixwbBRd/LXtTfI+Sv0LM5KHH3EzXZCbaQKEjDNOxgQmGBwDWQt?=
 =?us-ascii?Q?2wFMdDkQQOWGEH1aGYTuOkS68cKvi7IE8vDPOdxYbM9SMJG08tE/Az55umXL?=
 =?us-ascii?Q?n2SN0uae2WwmNFep+TwH0sNvDS/aR+1zHbF6c5S95JCY9uQJ0Sg878g1wp6P?=
 =?us-ascii?Q?P0pkpU7y0LP0NXonJC73HadTdIM0WMDPTAqENd989dCEAFEJhbzBWVhtjmry?=
 =?us-ascii?Q?SQX93wh2b/3k2svYExc8U/q1abpPF244qyTWhejI3ePJRnBdXmXSQxGt6/GR?=
 =?us-ascii?Q?JmEo0MxiM4mvcraOKjV6zg58ylEpj+G+yRhmTQuKs4mnPL+1s67w2JsPVcd/?=
 =?us-ascii?Q?q8blZZb1Y6FINRSprpgCLHUq6LWMUtwU5fsfpjjWjRQJTdrICtlUmgPuaLUs?=
 =?us-ascii?Q?7oTFAHIrofJJqHjs0CA45dt96n8mtH3DpwN35ZhWYixG84Y8HLqPgutSmdUc?=
 =?us-ascii?Q?DV/wJD/PUUYgHjeFR5PLX0xH+lDz+2XWf73H1RPwG97exIHo2UlgCgvwOthE?=
 =?us-ascii?Q?uZxkdSK6QRDQbM1oqUHexQClm6uD8jCLTRTC66RR263ElFyZQYUgKv2l208J?=
 =?us-ascii?Q?8IDH/JOJfhRB2iWiPfYtrQapAlZgN9pr7mIzMs4rxYMRyzbRyBqN09LcpblQ?=
 =?us-ascii?Q?YO4PBuS9QR51ER768nvo1dKYj06tnGCJzHhlV6XbWx8HAs033oQ2e+kW58fi?=
 =?us-ascii?Q?s/WRYZyTzQp3jcssfjT11jLjl2pwTJybLLEJ7yVC3LLU66mWMnLg7lMVk5Vh?=
 =?us-ascii?Q?8emJjoR1FkfwEModEqa4VS1ISzvK1dzI5gorv0XbcndvIKddrg+Caod7qYM0?=
 =?us-ascii?Q?9VZHYIefsauimwTWAPjH39psE/3lYh+kQrjAChMtui0q8TGMuNW2R38ATNiw?=
 =?us-ascii?Q?h9Xa9y9W05gfFwN6uZuyBIrPz3j0JwVVCpWbnuZaGo+m+/cgH4U1Yd50JuK0?=
 =?us-ascii?Q?JEDNPFeTu8UZrgV9DHqgoh+M0sCJw5ZVDabvbYHTrZ0rvnMUUAWBmxlR4kiq?=
 =?us-ascii?Q?hp4kx4C9Jt0xF2047ZXwpKEEOjmWL150fLxbhE7yZJgvZFa84atQ7vjg9OKM?=
 =?us-ascii?Q?VVgcC6Ss5U86fJSLe4a4sKuoK0jRioVFMftiB/PEWxaEL3VKMtvFFsBduA8w?=
 =?us-ascii?Q?foA7OgMyyckuBO1QWv3nxnmYAGmw9TcSFTTm2xozAad/wrIwkKWvF2vOLx3E?=
 =?us-ascii?Q?mmDqZBZAhX2skYLeeEq2RP9dvH8cHgut4nsWEy2gZpaaH0l5YqNkhxorS3yw?=
 =?us-ascii?Q?e9ZshcEOSBTCgUDkh88B0DpCtF2G8mHmOBUv592C2g2d0KF8V1+p+dH0l8VF?=
 =?us-ascii?Q?u6Fy+8R+2uE8pP8rMmMUtRDGufGBuP/XofO4hozryC3MNmRReEKiwTEXVzMy?=
 =?us-ascii?Q?XtwQReGcwtz1grqdAqrNz0naM+0Q7p3ifQoAQj6UmpbrPreAQJdAIjYVPaN9?=
 =?us-ascii?Q?nLoVVPU7A3NxN5NW4RPL3M9H7GNR71fJnPzgL+RkYm8KVvW8puXF?=
X-OriginatorOrg: guidelinegeo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf42e66-b1c1-41c4-6387-08de79334925
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:43:51.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f3403a73-63c2-4dc7-b628-287972076881
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCsMVZ4aKLd9bXfhD1x4zN+3O4MfRo3nTHh+MkTiM+Vlc9zYK6bSEuXINYg62F+/oog707jVh5WzkHrt3RRmmcb94NueKUV04JU1VjCtjrHro4jY1j3ThEB04/pBRe1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1117
X-Rspamd-Queue-Id: 680351F1C77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[guidelinegeo.com,none];
	R_DKIM_ALLOW(-0.20)[guidelinegeo.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222895-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[guidelinegeo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christofer.jonason@guidelinegeo.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,guidelinegeo.com:dkim,guidelinegeo.com:email,guidelinegeo.com:mid]
X-Rspamd-Action: no action

xadc_postdisable() unconditionally sets the sequencer to continuous
mode. For dual external multiplexer configurations this is incorrect:
simultaneous sampling mode is required so that ADC-A samples through
the mux on VAUX[0-7] while ADC-B simultaneously samples through the
mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
VAUX[8-15] channels return incorrect data.

Since postdisable is also called from xadc_probe() to set the initial
idle state, the wrong sequencer mode is active from the moment the
driver loads.

The preenable path already uses xadc_get_seq_mode() which returns
SIMULTANEOUS for dual mux. Fix postdisable to do the same.

Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Christofer Jonason <christofer.jonason@guidelinegeo.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e257c1b94..89d435d72 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -817,6 +817,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long scan_mask;
+	int seq_mode;
 	int ret;
 	int i;
 
@@ -824,6 +825,12 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	for (i = 0; i < indio_dev->num_channels; i++)
 		scan_mask |= BIT(indio_dev->channels[i].scan_index);
 
+	/*
+	 * Use the correct sequencer mode for the idle state: simultaneous
+	 * mode for dual external mux configurations, continuous otherwise.
+	 */
+	seq_mode = xadc_get_seq_mode(xadc, scan_mask);
+
 	/* Enable all channels and calibration */
 	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xffff);
 	if (ret)
@@ -834,11 +841,11 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		XADC_CONF1_SEQ_CONTINUOUS);
+		seq_mode);
 	if (ret)
 		return ret;
 
-	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
+	return xadc_power_adc_b(xadc, seq_mode);
 }
 
 static int xadc_preenable(struct iio_dev *indio_dev)
-- 
2.47.3


