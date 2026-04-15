Return-Path: <stable+bounces-238055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IODVEAA232lqQAAAu9opvQ
	(envelope-from <stable+bounces-238055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:53:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F54011AF
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03B1C305F778
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D523921C8;
	Wed, 15 Apr 2026 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ceDU4Daj"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FF3921E3
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776236026; cv=none; b=Qz45NHdAYt8L+94Hi2D6MjvpIKfOx8VoLRjU3gq4KwUJLREUysKrpbXa3WAcqk6I06XibfKv6Qi7XNdt35hDuhPVysSRM0XdamdYdwy4ZT/wASsJ4bMOWVWxAXI0+7i5baJgtJgZDZJ/7EPVXPEvcZf4PBl2HHhXMG/8iBKqg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776236026; c=relaxed/simple;
	bh=h06io7gcIU78lOPpiwU/zAiBmWgRW7eARf65dBcgVI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QGFRNr6yPyFwSgHZZvHcFQ4I/STtiqxo8xxiA/7i5oBoOH5RH75p0vusQylGx6QHdyWR3ks2oPCqh56NOwyYiWCn21/6kZZOCK67AlUCiQAr54lm/Jcc9fKRCQoO+G8ZGfssOyJK506bMYh/KGtN/6jFSkhd4E5/dE9MafKBtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ceDU4Daj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260415065336epoutp038b776b32b6153f5267be9fb6fda374ee~mdT8FWDf72549225492epoutp03S
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:53:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260415065336epoutp038b776b32b6153f5267be9fb6fda374ee~mdT8FWDf72549225492epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776236016;
	bh=A2Oe+K6G+so/eNF7+ZZwIvrKnrLwucXjD0QcuG1eQEs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ceDU4DajGDypaXxcPwkaRQaj5Pc+xvQ4HdZ7TkWqhbsPFKnPDSpYgZTgNqspQ2vxo
	 1W5zl4gVzOo1lFA30Ydex0Mpren4gOWwhBpxuJToivwDQ6AzSMkujhpXGMJhsfuWGg
	 rgIdurnX3W1ABjnRolt/SiINeibUsG1TCm0H/7WM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260415065335epcas5p1921d6dbdf504c8df78b9d53d2cf52023~mdT7YQFHv1005610056epcas5p1C;
	Wed, 15 Apr 2026 06:53:35 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fwX0t4pwXz6B9m6; Wed, 15 Apr
	2026 06:53:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260415065334epcas5p3ccec0106ebbf98ae036feab1b762bf9a~mdT52vxcV1892218922epcas5p3Z;
	Wed, 15 Apr 2026 06:53:34 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260415065331epsmtip1ab8cbeb56395313abb9076b4a268a4c1~mdT3kVRLg0303303033epsmtip1d;
	Wed, 15 Apr 2026 06:53:31 +0000 (GMT)
Message-ID: <242b06d2-7785-4728-8286-ff79a8dfaaa6@samsung.com>
Date: Wed, 15 Apr 2026 12:23:29 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Fix GUID register programming order
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"paulz@synopsys.com" <paulz@synopsys.com>, "balbi@ti.com" <balbi@ti.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "akash.m5@samsung.com"
	<akash.m5@samsung.com>, "h10.kim@samsung.com" <h10.kim@samsung.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "thiagu.r@samsung.com"
	<thiagu.r@samsung.com>, "muhammed.ali@samsung.com"
	<muhammed.ali@samsung.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Pritam Manohar Sutar <pritam.sutar@samsung.com>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20260415014620.mjmlt6w3ttlzosr3@synopsys.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260415065334epcas5p3ccec0106ebbf98ae036feab1b762bf9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec
References: <CGME20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec@epcas5p4.samsung.com>
	<20260410064735.515-1-selvarasu.g@samsung.com>
	<20260414010532.sxciijnzak3ldw35@synopsys.com>
	<d2be3f54-5375-4f1b-ab4b-e2ff81c43630@samsung.com>
	<20260415014620.mjmlt6w3ttlzosr3@synopsys.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	TAGGED_FROM(0.00)[bounces-238055-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvarasu.g@samsung.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 392F54011AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/15/2026 7:16 AM, Thinh Nguyen wrote:
> On Tue, Apr 14, 2026, Selvarasu Ganesan wrote:
>> On 4/14/2026 6:35 AM, Thinh Nguyen wrote:
>>> On Fri, Apr 10, 2026, Selvarasu Ganesan wrote:
>>>> The Linux Version Code is currently written to the GUID register before
>>>> dwc3_core_soft_reset() is executed. Since the core soft reset clears the
>>>> GUID register back to its default value, the version information is
>>>> subsequently lost.
>>> This is not right. Soft reset should not clear the GUID register.
>>> Something else must have cleared it. Did you assert Vcc reset (hard
>>> reset) during phy reset/initialization?
>>>
>>> BR,
>>> Thinh
>> Hi Thinh,
>>
>> Thank you for the clarification. Yes, you are correct, this issue is not
>> related to a dwc3 core soft reset. Instead, the GUID value reverts to
>> its default state when the PHY link_sw_reset completes during PHY init
>> sequence.
>>
>> We are using the Synopsys eUSB PHY, this reset is triggered from our
>> downstream driver during the PHY init sequence (invoked through
>> |dwc3_core_init|).
>>
>> Could you please suggest the best way to retrieve the correct linux
>> version information from the GUID?
>> Additionally, would it be feasible to update the GUID register after the
>> PHY init sequence (triggered by |dwc3_core_init|) completes?
>>
> Yes. Just fix up the changelog to properly describe the problem and
> solution.
>
> BR,
> Thinh
Hi Thinh,

Thanks for the confirmation. I have modified the changelog as shown 
below, please review it once then i will post updated patchset.


From: Selvarasu Ganesan <selvarasu.g@samsung.com>
Date: Thu, 9 Apr 2026 18:34:03 +0530
Subject: [PATCH v2] usb: dwc3: Move GUID programming after PHY 
initialization

The Linux Version Code is currently written to the GUID register before
PHY initialization. Certain PHY implementations (such as Synopsys eUSB
PHY performing link_sw_reset) clear the GUID register to its default
value during initialization, causing the kernel version information to
be lost.

Move the GUID register programming to occur after PHY initialization
completes to ensure the Linux version information persists.

Fixes: fa0ea13e9f1c ("usb: dwc3: core: write LINUX_VERSION_CODE to our 
GUID register")
Cc: stable@vger.kernel.org
Reported-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
  drivers/usb/dwc3/core.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 161a4d58b2cec..8b9e9d3e9589a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1341,12 +1341,6 @@ int dwc3_core_init(struct dwc3 *dwc)

         hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);

-       /*
-        * Write Linux Version Code to our GUID register so it's easy to 
figure
-        * out which kernel version a bug was found.
-        */
-       dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
-
         ret = dwc3_phy_setup(dwc);
         if (ret)
                 return ret;
@@ -1374,6 +1368,12 @@ int dwc3_core_init(struct dwc3 *dwc)
         if (ret)
                 goto err_exit_ulpi;

+       /*
+        * Write Linux Version Code to our GUID register so it's easy to 
figure
+        * out which kernel version a bug was found.
+        */
+       dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
+
         ret = dwc3_core_soft_reset(dwc);
         if (ret)
                 goto err_exit_phy;
--
2.34.1

Thanks,
Selva

