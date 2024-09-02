Return-Path: <stable+bounces-72720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DB96879E
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 14:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D22C1F22AAA
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970D185929;
	Mon,  2 Sep 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ni60zbqu"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258F19E98E
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280631; cv=none; b=VBVke/o0I9Ms23rJNeOp5TAU1imM94vyEfvdkfZW2ZByHe3brdmEzIvI+DGnpmFiGxWF9LtdcUQh1mlJM8Z+PPH+5tqJF4fK5aA6wRdJF7wiba7BiBo2etmh+xA6K+pESzo2NkkAF9ih6VT10esfJKin02LyeiPNa0y60qK7AMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280631; c=relaxed/simple;
	bh=x3VMkYXbuHfdwVH6vUwVtXYde0skuWvWWFtgUjSB8Cc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i59n6e+o/1UwflD0rh8Mus1ljm3OJjY/rNM7QE/Hqx5dLohj2Oovp276o4lZs7oLES8LTESWxS1xbWVW+xyBVaBh26WF2hKDpZB5Ifhc+sieJmTTKIgjFRgqxiJbhCiSaoQvQjI7fWtoGaQqkLP9I3CRgKT6VfwvPPtDpZGOvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ni60zbqu; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0ca0c66e692811ef8593d301e5c8a9c0-20240902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From; bh=x3VMkYXbuHfdwVH6vUwVtXYde0skuWvWWFtgUjSB8Cc=;
	b=Ni60zbquNjeJzyr6tE7Dg0CzSt/xLYeWdeZy5OO7mny2IezkSXEq9y2G5zXL7lplCVE5Kl0QSi0YWENOIJMZQXCkUsYxjZVzKJnCmw9DEjXrT7m+yUf3MMc1BLXqGbl54+wQGtmZ2aQJ/dWo0EGSd/DFObWLDZU3fOm8Cc6CtzY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:744325ef-6993-45ad-b0fb-5db337277767,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:8e6490cf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0ca0c66e692811ef8593d301e5c8a9c0-20240902
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1699633856; Mon, 02 Sep 2024 20:37:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Sep 2024 20:37:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Sep 2024 20:37:00 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 0/1] pm, restore async device resume optimization
Date: Mon, 2 Sep 2024 20:37:00 +0800
Message-ID: <20240902123700.24554-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <2024090220-uncaring-pretext-4391@gregkh>
References: <2024090220-uncaring-pretext-4391@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.983300-8.000000
X-TMASE-MatchedRID: O/y65JfDwws4HKI/yaqRm3a57ruHAnHxBdebOqawiLu67Q3uPo9KI4KO
	HgdS51oIebn5rQJdjFELBuUtVo7wD8tFT6VhpbG+dARARTk4h59Rpe71pI4bhVFFa3XGCWSdLIH
	ZB0nMVDEYzVld32AnFNf8/AhWGke7r78SC5iivxwURSScn+QSXmMVPzx/r2cb+gtHj7OwNO33FL
	eZXNZS4IzHo47z5Aa+g8Fy5UwPKTgPyr4VOMFylzIMcyDwn4bkwtkm7FZ36V95HLhdLyNQ+eyRR
	/voKhHnBYaWE5EoPNzlfj12Nivgy2zm9dF7+VpejaRiIIsdo3aF2gNkHzkVPzYxDXt2x44FGooo
	nKCoGe5WXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.983300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7C707A376D33DB621EA7D981FB410A70DA972F50C00D72B92A0BF08176AF0E8F2000:8

>> From: "yenchia.chen" <yenchia.chen@mediatek.com>
>>
>> We have met a deadlock issue on our device when resuming.
>> After applying this patch which is picked from mainline, issue solved.
>> We'd like to backport to 5.15.y and could you help to review? thanks.
>>
>> [ Upstream commit 3e999770ac1c7c31a70685dd5b88e89473509e9c ]

> For obvious reasons (and as per the documentation), we can't take
> commits that are not also in all newer kernel releases, otherwise you
> would have a regression if you moved to a newer kernel, right?

> Please submit a series for all affected releases if you wish for a patch
> to be applied to the trees.

> thanks,

> greg k-h

Another mail thread for 6.1.y and 6.6.y are created.


