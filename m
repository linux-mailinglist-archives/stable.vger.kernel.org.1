Return-Path: <stable+bounces-111740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77822A234D6
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47941884384
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C6C18FDCE;
	Thu, 30 Jan 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="Afii0yMX"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C748143888;
	Thu, 30 Jan 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266653; cv=fail; b=DzrToG7nMv7cgQzl0LdU+DL1C39YVBx/KnI1M0C7/te46nd5tgNTYKroHDbFvECggDrTyrrHP8mC5oGeGp2lNSOH9faAZJ7lydXopyt0BtvwVjhysgz/t2AAtfaZ7sfP6Et3IZcaR3J0iYY4JKB8g79Ikw60Feh+5P0+M/g7lIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266653; c=relaxed/simple;
	bh=Zmu+xtiIwdeGYhT4BoxyfdOji2X1Ro3xI4CrbLJdxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GyQuTUiW4xnTMwy1/MHbsEfu5aj7esaEkRVNxrciXMCv05k1/kLsODSyEYtiwJ6htdjmcxBJEDdEbEg5c6fwXKTyrNyAY9WkFb++ObkTOscNO913PzH+esQyjLaqF/STt0PUPX8ZUHmKEQ5H5lQbtu9F5g8eZFd1swzGwk0Affc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=Afii0yMX; arc=fail smtp.client-ip=40.107.223.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ+jRW45szhj9Em0Y8Tbv+hHrahLquqRuCWcFbuYHKkha6XrNWfx0OuMin9O9rnxB6jxN7DthoP8BcWBF7NNp0+ptEl635mwr1c0B3IFwtPcQ9wPMc3zd688dFCooPfIDJzTAtcNCrWBhZ6MOw5RDdy8J8P5atAQI31W4ZDrkVb5mrsh7KAdHSPdS9yAmaYGDTI390rG4gVAQ8WMAhYyHghblI9LT7dW9X7PAfGL8DOEJaS+5RWfBnN/lRQRQmm7bzOSwCmYIk6ZwjKKJBPB0wYWh/yIBj61wd3uY4IY7qwfZHW/fDzXx3fSIZ19/pmPKuO3RR7jbUYB41nZw525TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ySsSMi75DNN8fgwWraqg7gD7WsihI+Mus0Mtz8HvS0=;
 b=tCbGFmcHSTyeYAv7hwMGpfyGoV3yuF3QMLEdg6c6S83kquH1TFAaVHlEV4nIZFnF6SJXkvv/iZbqIXDMyPMTRwxn7niJaBcJx4kPc9lbgRWfQLQzXNjzNh2LWQlKBtM8ZyeONJ5tXKNhkNFFBOqwk1bsQn/poOy2fA5NcJww/v7oiYV25JsyKYVjmUkCg+ZNkFvgPAQopQGKKczquRbGwSyBJcpBiFL6ccrdIHrNKT0lEQOg/eP6GtK/8iLjv4t50ZBUsxiXsPRqis4y6CuPrNPcwYbI0E84V0oa9ZfSMLG92ukp/P7ueWNVqekJY4pnMFQ5nUqeYqNQapzAUBMR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ySsSMi75DNN8fgwWraqg7gD7WsihI+Mus0Mtz8HvS0=;
 b=Afii0yMXRSvD2pNXyE+rXji+RQuZZ3UIcKrSz7ZgaiRjrUjqnsaAwDKWbFOXAKcPZSxPcQmjYwxucF6CaomO474525KS/xpryAktJZUNZ6GRCFCoRGpbd2kcK0aKxfsM22iPp0v1Fv7cHBq7gwNfLtX/fMg0ioS9vePRyxqCC38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by BN8PR08MB6241.namprd08.prod.outlook.com (2603:10b6:408:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 19:50:48 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 19:50:48 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: linux-usb@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	John Keeping <jkeeping@inmusicbrands.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Abdul Rahim <abdul.rahim@myyahoo.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Daniel Mack <zonque@gmail.com>,
	Felipe Balbi <balbi@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
Date: Thu, 30 Jan 2025 19:50:34 +0000
Message-ID: <20250130195035.3883857-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|BN8PR08MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 813f4e3f-5100-4f91-e216-08dd416764b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AvK3SbTus70zSKbpykgyxIf/yqyMiUlogAmGwEpq1RNF2OWlT2xP+EEKPRvr?=
 =?us-ascii?Q?uXwVXy+1fH1U6QVGSEJ+sS5tnXbLxmxHocN2ZIDL1wzCkkhOL2aN8dNVRf5O?=
 =?us-ascii?Q?DuBrEtgjb7eW8J0hxJKPNHDk61qHLxrGXxAPF1Z9/hnTUJYOv2KbIObaxOS+?=
 =?us-ascii?Q?wzsKyJ1EHjSKYSY+zRM5uEMgggt+Mb+7m0v4QDNncpEK9bEfXGvR4hLQzGC0?=
 =?us-ascii?Q?NqwRhlzXGrnzTjkzn75tkjAwLc0TTTkW1eT4SL9CpsXubuJWcyXNa+nju+kx?=
 =?us-ascii?Q?w4DSiXWfxkdPbdRb0/xrW+/pxxChLQqs0yjeLr8HStRqaQkJ351zfBa6W2Nl?=
 =?us-ascii?Q?rWRTNNOIsaJTQai2d1TT6gq41VsqQpfi4HT4HGXqcgdvGuSDalHJHFvWdQp9?=
 =?us-ascii?Q?nzbnf4VjVZqAAKlUM8HlSbuwqm6M0OjtLW7cl15dbGGuRkytmpx/Aqe5HHn/?=
 =?us-ascii?Q?2wfKzkYcaQIwRjpTCO4qplYE9jtNDuQmixazMN1cMQT0/qrBODQWfrVl+PnO?=
 =?us-ascii?Q?GEZSbFdZpPrfZAKq7oDM04Hy1aikMCOtpJl/gT6sEJozmq+xZ/Rh2RAVSdJV?=
 =?us-ascii?Q?vvpnNP0ensuxllCIPiKr/kXf3Q7CbK6CNTc0EisAta+a+KDe1WAFwdQfjzNT?=
 =?us-ascii?Q?3WVk5+fx6z4Vg7UmtZ2cCPVHo8bZqdpKK6/Zz3lK/rz4GmjXqwqQHf4BVZYS?=
 =?us-ascii?Q?Md0n9mDdrHN55VUB4HUfUSMowmLkUvT0OjPmzmFn9s5RgOMksMI/OZ2ecMBf?=
 =?us-ascii?Q?y4NdgEMzeDXSu6X9eE1N6OdCvcHL55IEYGTmAuNhUJ4Feo4p892kHKC0iECw?=
 =?us-ascii?Q?VgYh+afksB2uGTnsvB7BGRI/cJWxyBv7qqs6+0HXy/ge5yoMrIoxgIFu98kE?=
 =?us-ascii?Q?ox8hw760PJRdOc+7KR/AocazRPi4iM/lFOnmoLvOA8kwguxaIR4ddltmCiTY?=
 =?us-ascii?Q?C/Q6H5Unj28VZ+AGfj/l7pwWalZp9P0hg/BpSxvu+Mq9VUWpgXzqmG4Qovja?=
 =?us-ascii?Q?We8hb4iUGtlD32fKqquXLUqqJANgDa/DiY79CaHHdC2U1Pf2V6GjG7Cnvi/6?=
 =?us-ascii?Q?ORxa0598NdTqmHtCrdnJrcs2rsXZ24mlY73Zff2zktU7GEYqopBZ4WyUTrAY?=
 =?us-ascii?Q?6+PILD149mUChvT/SHsxJnADTicskauV6BWtDHQa59EdzW0GWdIlDzQugNsC?=
 =?us-ascii?Q?vBGRpJmUUoV9JQnmwZ5yvjlVm2R9aw7u0euUKoHUqyUMga4dHW1PT4Dd+R8I?=
 =?us-ascii?Q?zhFugPugE6L/F1rFqfqie8IF7+yU6WMK3pdXS8/bzFaiOq8t3bBX9CnafEWP?=
 =?us-ascii?Q?PxgtGSD0eTD71sxJe4WS2vS9aRWdr1/a/uIywIoSBZT6FgtC/pvFSY37/R3v?=
 =?us-ascii?Q?18FNkCoYuqWs40imF9RR6E+oOopPbDMuxswH+zbXrKPCeaxPTi/Do41M21cu?=
 =?us-ascii?Q?xVFm8pKT05ZR0zAuniAvmDlLubL6Te0D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/krhOhodnR5MUPFZCV7COAdaPold8GsCdj5E7TcDIAy2C9jCE0umnsHxw6J?=
 =?us-ascii?Q?ptG32bo25c6+l4OQOb96ySyZ+g2RdSvb7GZiKbM5MKdPz8HWoeg1yS+zXh2P?=
 =?us-ascii?Q?Ujj0hvr7Ypio6b1d2n0v0UBPsJliR8R/u1eKB1LqCVgzytbazEtoCSwMaXj8?=
 =?us-ascii?Q?x/YQ1HiXUwotbESi4lHAWeoLGmIbwle8aycrQemLnHaiUrKJWJPFIR/fPaEd?=
 =?us-ascii?Q?9EKaCCRBPx89OCS54tjo8tjOP5ZA0yWbJuxSFp7LxLtv+jz5fzCZhAtAbZT/?=
 =?us-ascii?Q?kLnMQTK26uywHkcSV5pjM30q1kFu/iWu/zNRydaOi/JGzJw7wbCMb+UWH1fB?=
 =?us-ascii?Q?LqvqC2cU/WXCr41Alb6FYwPQ6Y/w/aQIr7PDQS6MzRNQuryhZ2qPs3W1EUKj?=
 =?us-ascii?Q?2q6L0Cl6UaCSJNvM8DB03xSex33854bOsTwP2b7pJpQykEEPtCS7AWJvUnr9?=
 =?us-ascii?Q?Bf6moUYVhD/F4S6w82tZA5G200ZNFuMffrlemkNs6iQLmN4jsYLuyJ9aB6pb?=
 =?us-ascii?Q?/u5KqRKlxRuMFM8JsRFOFkSfFiP4c2gymkaNEtAiNYTLPHfu/PWRXD22ZhCZ?=
 =?us-ascii?Q?OekXlmEjDlTXltGccOJpab3GhHaD6l/8DY3AvyKQyR6eYCnx5/plU+Hl3Qbj?=
 =?us-ascii?Q?nuXeNnhwbn275T+Q/XplO0pDxr/4rQV8nLi6jsQY8mFtjL8XdwNnnVJHKM7b?=
 =?us-ascii?Q?ghcf6DricYH6d/rnlPg8t7C7DqFD7moxzTxVYUXqXASW1V8AwaqFCurh6D8U?=
 =?us-ascii?Q?8HlL9Kxisi2tR9GXDWBDAtttxYGsI1q3aUeiJId/oYbXz1iWmLJHEBZ6yFuZ?=
 =?us-ascii?Q?HTggBh5ZLMq2aZi7bS3SXYuGQC7ENLVXuillG9nO3wjDyJrjVMtaAMK/H16g?=
 =?us-ascii?Q?uG8M8TnG7TTyPOoCp9pMtGSjgFDPT/tGsLcSH4uPs7wzH1AzaBB2J9QlFu2G?=
 =?us-ascii?Q?xIcXzMhjs6dm1hRh0lOEhHLjsX3PnvkWas7KTN5xRzvGaEozMgbtpUi0/E8s?=
 =?us-ascii?Q?qq+062ObWQYznNhLkNbrvPGX9zr8xn7GFuIPL2Azr0BOAZ2Zk8E/uQqQ9Qv5?=
 =?us-ascii?Q?BdfKI0QNjZtO+N227ZHnw6gXDwGZxg9I1o+ijkYUtuQrkOFEaSqsn6h5ghgH?=
 =?us-ascii?Q?8/U6OnYfuHTFO8g7ljFSzTbNz3YVX6c1bUxLJDc1T81sNWu4Q98IQLLVbit5?=
 =?us-ascii?Q?rHc07dm24mDgdAdxCRx/UEL8/ADd3nzZX5/o1oIN/EFlhpyeK8tkgH5Iyq6A?=
 =?us-ascii?Q?361WhhpT2mE/vGgMFaYFVmUWfdxvfHlMxHnPgZKstV5D2i9zbX5OAMtOqzSq?=
 =?us-ascii?Q?JZ38R6YIM5+cTnn0pmKq9jE4D+dyJ+zFgZiyknm62TUI5VF82DEX/ek2pu91?=
 =?us-ascii?Q?fLAxq0HYQf7oyaj+dH+DMziiohP2tH5VUQqrWFkN/x1d6UWCGzhqLsUlL9pc?=
 =?us-ascii?Q?prMuAQ7TWM2OjKD/najKV2naJ4gJcL7+K1knC2cPElT9n8NXmcW9Q9rajNvO?=
 =?us-ascii?Q?I59UnDvsJ89FL9rurMbVCKQQM3mKdSQD9pKR7uihJtW6CIz9n8hSzHTaKJK9?=
 =?us-ascii?Q?AN/4lUMyPFTcc6KPI05RmJ6rpU4lEFbkVQNZhXWYY1G82OPdQ7IY1Ctv2TMR?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813f4e3f-5100-4f91-e216-08dd416764b8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 19:50:48.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H00H0Q58vMMsixfFPtvpkYH47bComlq2kq50dP7NJJRt+uJQariFlOvrmjvzpMFc8taIEdV6neheXs7mJbaUdDN4LyVeBtNLMWe8WTKIp20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB6241

While the MIDI jacks are configured correctly, and the MIDIStreaming
endpoint descriptors are filled with the correct information,
bNumEmbMIDIJack and bLength are set incorrectly in these descriptors.

This does not matter when the numbers of in and out ports are equal, but
when they differ the host will receive broken descriptors with
uninitialized stack memory leaking into the descriptor for whichever
value is smaller.

The precise meaning of "in" and "out" in the port counts is not clearly
defined and can be confusing.  But elsewhere the driver consistently
uses this to match the USB meaning of IN and OUT viewed from the host,
so that "in" ports send data to the host and "out" ports receive data
from it.

Cc: stable@vger.kernel.org
Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
v2:
- Rewrite commit message to hopefully be clearer about what is going on
  with the meaning of in/out

 drivers/usb/gadget/function/f_midi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3840f..6cc3d86cb4774 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -1000,11 +1000,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 
 	/* configure the endpoint descriptors ... */
-	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
-	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
+	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
+	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
 
-	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
-	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
+	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
+	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
 
 	/* ... and add them to the list */
 	endpoint_descriptor_index = i;
-- 
2.48.1


