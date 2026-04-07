Return-Path: <stable+bounces-233561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBmhCvHm1GmeygcAu9opvQ
	(envelope-from <stable+bounces-233561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:13:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 822283AD869
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6632300E707
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC93A5E9B;
	Tue,  7 Apr 2026 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RqFhK0eO"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E225F98A
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560100; cv=fail; b=lcN8XydGOF2XSDZ5VSFxP3e5O6WlfE7IBu1wJym6bajhFL3IK1oFr5HbV/8KhHBph2B8ud3TzDC1sKF3DAhtRdncQV9Dvybs3RL/lah0LzDjdYtqXvqBxhBd2L5/Kz89g1FVVlockM4GuSDcBJhu5ptmedbv/47tGuNdcDuyKaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560100; c=relaxed/simple;
	bh=+2jNHbJgSimPpAvyghrg67kYyICmq1idvgzfBPQJOyE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i6GlmGMDQBB9si2PJAW6dep3CH3qFZjJwTjdYXxV2Y5yPwYmJmYdyaHHLBlH7Ela2C+sZcB5jZEDsHEM6yvSx5ysHXtvUDLsF7mhSZYNLpSBx3/0S522n1lI0kuq4FJhCesX0JNPw/XzjdLNynrKZiWB/Zc2dHk/nlwr7trpTyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RqFhK0eO; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gV9nrs94D3wZaGWb1IUb/zxD8VBJ75x1KmOMpX3x9KBdkW0/6ECeo2FbLJbDgckNEJKTpl81xCelJaxFGgednVJQVrF3XewdnBd/lZI5O4HlDYifQYUApdhnztnOfKWO2laAuoWLO54SF2AjFVpP1Wnep+pkHOolaSIKuu9HR2GieCuv5cSSPResI9I+kwBXVVKUhlzT8Gh8FXIbxAs/6HO0BzUsKP/gMxJbK5zRETMrJJLF+q8oep83nVA6EDnv/1tsp5H8r+fX+AxGAdzYRQTx5VwFBqq+rWQ4FVXHTw5yxBDeZ7zh+UddypOM0eKB+4ANwjfpmjVGFIei5d0p4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMVxN10PDuio2Yzh//096J0cWf2nQ6m8DkjI2goJvyU=;
 b=kO5jKwTZS5woOWj2cGeZ8L5NojDcisRJrlfKPIQI6aa3BGrLa8FkZT0dcWPJpSH88Bfl51pz+kKc7jJLOdBUeuhMu95YG1XsKjIIC4b95tUFY1qhEeCBoi0MDgSiuiTYzTQJZOABRCkqW1JOTPSrp34JfemZ2zHQGjQ5feoNkVSCClwPOslvNho5gfmsXchDeShXgCMKNo0RvVQvFIyYO+naCqTSSMm6EflpmHW3i2tr7gsJ/emHpucflDkMsVtbFtPDXp8mwo5s4DRTHIPZc2mhDzKlDd8rOsdxsiZ8rFUVDjK66Y5iZvoZ5qTYX2QNy+LjIOUc2XSS3rrSvJlnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMVxN10PDuio2Yzh//096J0cWf2nQ6m8DkjI2goJvyU=;
 b=RqFhK0eOnigvQk1+S2Ji/THItrrpIC9FP2xSYIYSjATOuKgZAoDOtcr7VS1J+I0SUq2hf/4F/hTZ8SMiYFIKFmGU4clqraiYNVSG8kf/iScCezcOkm7HeJijYs2jzMyczptUIZK6MIP6aXuBizpy89LIzsTzKrzm0mby1pFVC72BMaYIn1vG/7GfcIyRhrr/BKk8y4k2jyiGxVFSZi7vjVE7KeDY6WDKJbLcCPiIGKBqhxcd71fDDyza/UL1r8yw6nctpjtucxrGzl7pJXJKiYpYOB6/E7wHVsK1lt4aEXQs/D5y4N21SVPRoaOQfBcsY1OV56/FZyawW6PTeJ8OMg==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA0PR01MB5781.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:6e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 11:08:15 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 11:08:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.18.y] HID: appletb-kbd: add .resume method in PM
Date: Tue,  7 Apr 2026 16:38:01 +0530
Message-ID:
 <MAUPR01MB1154611A3C616EBA4F0595F12B85AA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID: <20260407110801.1239-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|MA0PR01MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7c133a-6a5b-446d-3189-08de9495f6d2
X-MS-Exchange-SLBlob-MailProps:
	9qw5+ftluCCm9yoJ9fgtGwzhjjsJDn+qo/nZz477D1xR9kBczXwUfuQUs/8jcy3W4vOit4yKd6ojYAQlrcIS7cRePIXdH7TfKBH2ytBW6I3dbvZWRt4bNkwpKlA9TYTCbYFO/ZhR2Jn1WxOC98m8RdhE8EjojPKqk7TOujLlRGLO8Kik0N0GlxlZhe1TnlS94aEPoWfTN5Emxz7ySHpy2Ib/IdESv7gU8wCYx+80uPlCqKfp2e9fMQ5X6C3dEjAY6EVjQyK7k8ThCzSKo4vzAsyvrznAe0Z/jro1+w2hPqbifCL4sqXP1SOUfyaWrluoRsyhsfa3EbygirxQjpOHW9SehaQU9C2g3DixRBFECkmeIoqaXTabtsFR3Y1+KuI/NtFNUJeu3A9a5Z269wH77oDv8XfvgQvZRw3MswLfu5I0EqtcnWXaqaiOV+h+e+rEHY3fXLla0nhmGlvP+zintiUvsgo0TTqNnvrIWf3D+gmQwSEz/GGk3BBhqZbad/n1Axj/M4bJgtHIGEjUOLG34UIZFLlzqhwHm6LPxmq9ZblTR29IK8BKCn2Rk9F7+TStk5oxz3d6Yad10m7ya9BIiIESEIFceasBokfX8EsfNf4ODXei7VVaBAQCgTMoOgQ68P2bJnhFBAkxd18nhwgN2KGef+OTyv71dlYhwyiqTdDG6T3yFN3Fk6+CMpW4Z+dqCq3VxMUjlCQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|19110799012|51005399006|23021999003|15080799012|8060799015|41001999006|5072599009|5062599005|461199028|40105399003|3412199025|440099028|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04GpNZ7BSnrZxRo7M0rHjtWN+4+vr89Uz6L8ORg9fGHFiOsjBbwb3CE7cmAp?=
 =?us-ascii?Q?N7SJffeR0dyRdzqTiEAdVc7dnpiBGeOdPVO42+h7a4OYDkhFCH9rgob8qtVQ?=
 =?us-ascii?Q?ZwD4LClqUh0ttnRIIityX+mwy5l28oKhuQdlDkTDS2OWhm4H7uZadMYUv9FD?=
 =?us-ascii?Q?1Vxb8MdYwf/xzeUuDaM1OcwYagLS6oX3vQvZzSHkFD39aZ7Q9WrpIqqsbD5l?=
 =?us-ascii?Q?hRxKO79f2YAX4Tv7PHTXj7ADQbFDwysXsnWY48ydbXZDUdKABBMrKWR/nvm2?=
 =?us-ascii?Q?uiHok4hj3scj0kTssSJvmdzGbg8ITilLpvmKvBlqnLeN2x9DX0nnCykLjazg?=
 =?us-ascii?Q?Z8yfFyp5WqmLeGpfdwcEwMJJ9lQz3+6Bei6LkBwq78I4t3yQKvUGmdm7pRel?=
 =?us-ascii?Q?H+cFtsGpoAvL0kkJtoSegS3Lh9hEg4+y8i9FVHJMa1nIhswwL+SC8heYIa91?=
 =?us-ascii?Q?1FZGO7ry+FeStJ3AlEKDY3YX3aI/FbyUZi9fMw+HlW3akMsdm9ZW91qFK2A9?=
 =?us-ascii?Q?5uGAP5aXDybQfeJEIdhUC3JBFTVAINWj7AHozpp35Et0+zhWtxNoFEPK1/im?=
 =?us-ascii?Q?I1oZqKdIgDIXUQQXyNVT9+NDgcj7AC5DNuFr/0tDBXrPSFLo+bWyTnGrYFAw?=
 =?us-ascii?Q?areN7zJHyDbmQWWfKFDawowClV6a3y10bQ5qrrpRHXWWbShPRz1RXJPt7k0F?=
 =?us-ascii?Q?R5+fyEfVdA/rDc959leC5ukgqUNNLESMRITgCaB+lMsoTgXuvSzAePYIckKB?=
 =?us-ascii?Q?++tK+7ojxi39KTf5UfA8oyyu4oJTI9blA0dPXCMyW9igLoMXgGVlQsxvZ6Ft?=
 =?us-ascii?Q?zUTohbIlO5pB3AxXyXGq/d1ToWcutD85TPYaooe2cY8h/Mf+RVg8xGN4Tu7d?=
 =?us-ascii?Q?HfMPTLExwM7bj4p/F2iBSonGNxi3Q/6uwZ5dDMZs9M7S/J/+zj2gw9hZOsxi?=
 =?us-ascii?Q?Wb7vEexX9LfBU7Olzl6DlWwN5rDzI0VfeuH4ETrjEcprwXRYNToHgYKVpxGw?=
 =?us-ascii?Q?ywyQ5k5POwZh2mDfvqrasz6QyWe7oK3irqtuIzsbmmCvo9U=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LM9rt3l0UxsFGMzB4iscfR7VOCeiiEzeQWAy+VpDWxfUKSY6Rq3vYkKlYDNQ?=
 =?us-ascii?Q?C3OQvvkhjjUVItb5QKmggD2X12c/vHSBxX9sjB3x2nXlH1VgoD4ZTFLO+D9k?=
 =?us-ascii?Q?z6S6tvqjjCyrpe1untYxyHebeHz0gwQTMFhDHa0tkmFTpmllBI+75+5bjE6v?=
 =?us-ascii?Q?cTODc2HeGBEAC1u7Qgk3T9WHFxIOtj+LHXkKVmcOR08h7DqhBQt2BGzAeBEM?=
 =?us-ascii?Q?8Uwgkb7vKI7+T00R2jOntRKxT6Mp55Y2ZNaTOGXBo1SlLCI9xTbXoRhUzBKx?=
 =?us-ascii?Q?UbS8Nrh7UiB6bi8oEhK17SrL6IEPqKP09XaS0YnV542ELpWOpiWOt4fGI9sL?=
 =?us-ascii?Q?wP33Ms+kKhtVLsaI+3QTvUL5WKpZixCsBNgwieG5ElDu/TP7ju+mKAIlONR1?=
 =?us-ascii?Q?oWzwkTzSNt66PdP3TO2XRqZdMq+uM/VkPM2Vh8IdS+Jr1/6OEirJC8qOaT5K?=
 =?us-ascii?Q?tLKIe/LYh+F5lv1kxVTzwHiDdy0AAOaBHlIHvLbbrPw0p72yV9QnZ28CcyPH?=
 =?us-ascii?Q?EBqBgTB/E28yiTesVlGh9ym+MXMPbgqCs8OkipWp3yPIjY2+0DVvhQ2LFX6D?=
 =?us-ascii?Q?0Qh4tJ2xU7ZegoFTQKgWHV0iP5UntQ6039pZ/zJ6GjVc8Jyx4H1SUtF+HkYv?=
 =?us-ascii?Q?qnYryJ6eI+hkscL75rOVAYhzCp9qdOR82LkEIecMZdcRqygmU285/eykivOQ?=
 =?us-ascii?Q?/2W/2OnzH7jg7LFX+hUOzpAxbIqNAG9OLkHg85H8SUwcIEhyzjcyRTM2ao8C?=
 =?us-ascii?Q?evlGz1XugDl+pbsREaSPAMzBgLLVJ2uwM0VidyDf5S+0jMoxJcEO3UmXhBc+?=
 =?us-ascii?Q?+qC9wPos1iPgFopUoO14zzswukGcMW+EbaDlDIYOtuwq6CtfpKjspF2G0SFg?=
 =?us-ascii?Q?Js8t0Y7noAEcbf33S8MSw/stQQMD92gBu8e5qvcD0CCoh58e5IY8XDSS+UJs?=
 =?us-ascii?Q?TWRX3PGeLusJp2FFJ4l1w1oc/4Pwk95Gk5z4jtaKhVz08zJopkecIFBi85vm?=
 =?us-ascii?Q?vHz5faPNrYlXAErSpa9CTpuEaC0T08fj+vRQGEuxhEsTsxlxrLCksmwFFnN0?=
 =?us-ascii?Q?PnJOCfM5+DAZiMT0Yn3F290SKdgRSvjvlszAkocCcryWiIosOVgDwUZZd9jR?=
 =?us-ascii?Q?l3e/xLdDKkgDMt5AsCU/3r7eKcpbZN3reTXx0ACIMHug21wikbft1rutnmF2?=
 =?us-ascii?Q?osRhHS3Q8SpD5S1EsHvJ5NegAQyLos8zt+c6Rgrf4QknBzBvieUVWfVOKnwj?=
 =?us-ascii?Q?7616kyi+M1etgl+LX3FJaIowCDRDKU+P8WglQ7YQ56zd9T35E7pPVQpPqK8o?=
 =?us-ascii?Q?YaWRE6FeLEwunDJiTwBuj+hcRzYWF1Si+hoqCdNjLT/biotV54e7Ia2Yo5hX?=
 =?us-ascii?Q?6UsY4LrJ/VG13W2BFI8pI8ri6doR7+hG2gTS+mWe8R2ha8NZwjDbPXHnlIoe?=
 =?us-ascii?Q?7Aur3m/QyWCJYrOWsi5zu6h1dO+YSM3E?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7c133a-6a5b-446d-3189-08de9495f6d2
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:08:14.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5781
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-233561-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[live.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[live.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,live.com:dkim,live.com:email,MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 822283AD869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 1965445e13c09b79932ca8154977b4408cb9610c upstream.

Upon resuming from suspend, the Touch Bar driver was missing a resume
method in order to restore the original mode the Touch Bar was on before
suspending. It is the same as the reset_resume method.

Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-appletb-kbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index b00687e67..0b10cff46 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -477,7 +477,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
 	return 0;
 }
 
-static int appletb_kbd_reset_resume(struct hid_device *hdev)
+static int appletb_kbd_resume(struct hid_device *hdev)
 {
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
 
@@ -503,7 +503,8 @@ static struct hid_driver appletb_kbd_hid_driver = {
 	.input_configured = appletb_kbd_input_configured,
 #ifdef CONFIG_PM
 	.suspend = appletb_kbd_suspend,
-	.reset_resume = appletb_kbd_reset_resume,
+	.resume = appletb_kbd_resume,
+	.reset_resume = appletb_kbd_resume,
 #endif
 	.driver.dev_groups = appletb_kbd_groups,
 };
-- 
2.52.0


