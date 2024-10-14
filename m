Return-Path: <stable+bounces-84642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B5C99D12D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950BB2857F4
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791D71AB505;
	Mon, 14 Oct 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="VuI2pjDi"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3C1AB6CC;
	Mon, 14 Oct 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918713; cv=none; b=CNjrSMddk3t9Gt9m6/IPQ6nq8aFk1nzhjYJDyT8zdBE3Koa+KvFGQw2zJ1h297GDR4UTaJYe/zMYsM6XUIQSWeNKlpPmzk1DQiD8Xxd8XQzw053wu0m2zP2iyB3iN00GnFB1wXtOFrUBMgpIys+9VoXjFG+4k0eHlQKU8T9WIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918713; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=eq88zo1RJCTikoTevCi1/sxjjvmoL4jkFZeiiOp1Fwk0r9XNFGu6c8tYvi+7lMwK31sKoPsGj4ehzyGB8wuo1dEqc19FrUar1SNwjKWK0AfWuhsRpdd/c8arFhlHhLu5pW6dGtsilLmTJ4u2WwAazcDmecl1k9n0ly+xcClJZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=VuI2pjDi; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728918708; x=1729523508; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VuI2pjDiLh1VO0vf2mu9dcqjwzvjtBAgsa7Abnl17QNrobIKBMbgEQKC+gkEPcK1
	 yXphKkhOwCZ/xAAfNiXawBOdY1tMQP7D83DcsvFfsC6Gj+eFrWgj7o8xCNtqwPW5t
	 Wdz20rAl66ZKX7bqbjjtu09nuNp6i1P/UlQLDbHxik69U/jQM7QLwZSaMfe4dmkX6
	 Xu+hUhCVZwvaxu78dQBo5SVfCAJpKSHtI0bD3FraXOOxyUXT4Wqy+/eCECXBX0FGh
	 k3XBBKtUjcHoHv8oiqK2RiSmA0F+oZ2eeLoFuV92DxrTCulpxpjfsXKq6FMmYZKjY
	 /YaZ8w4Dh4fa+FRzMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.167]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1tfAam0mzc-00qWbO; Mon, 14
 Oct 2024 17:11:48 +0200
Message-ID: <8c0b2d42-d025-43c2-aa00-f240a1464413@gmx.de>
Date: Mon, 14 Oct 2024 17:11:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.11 000/214] 6.11.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rAtgKa0Cb5Bp39H0RxDk/6hhnPB1vV4Z7Z80aoWDd7jqvgQBu8V
 DoJGjELqAfhqORHyKsaZ8MIj4jrapoCDKhnWUo6aCtxk7wYyTDkPcggM6BctjW+uqPKGFB8
 kf7PI3aRGgXtBvtckeK7nApBSY/0KDL8emrwOZ2qbPevyRacliCy/pBi/DkMnrHYLYNssBI
 k55AI//qFBw3w/zelaLmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W71DwxLctPo=;cbfqzQydbMQ9vf7ij3iuxXbKqiB
 /PzVsr04y7nUWILgwBGixNpxHj+sm9pcYFB0L31g2EEzl3WW8uDelUdEYKFRzqG3JGFvJjwvJ
 hI44zw2cZYnfXY+NBqdKkx4vXrNkSZaVX7pyh4Unr10CzlajKUN6y97XnnIFgPbGP6/NxowGC
 uccVgXr7hqUhgUrwcY42fR71ljpp/c8eqH2srusSj8+MxXtwekNs3spvrxfZz8TnYjp918uCD
 +Yig1tlDkbvmE2TOrlNBCYRki4axRPyKtdCCK6A03jfmOo31tCDvLx0fKu5kUALDHZ8omUspg
 Y7XhfL0oLJMSIuSn0m2mQAVHH5hDgYlOW3oPKnWyG6bbl7Vhp8pxwEdFHz/KtrjLA2dJ4etSg
 vNpiUCNRf4HT24bom3JkNCdPOVHOpDcA5+LFAByRSZV7KL2eDMP/McQV/W8gGj+hHsXvo3c1U
 PtK8dQ4+3Ufya4GpN+0SwgZBzceyBDD/p0gx9i4MDxzBlf9a1HlSMWkzgE2Sr2TiusWqP2fe/
 FX2X3rlRXQp/5fyLQPGMilP0bYmfHRCMg1rkARkcmHxoP4SD8XijpmuEFkzXJjI7+L2bnEft7
 1+EfJY1JY4unAcB91ufUraVmdTpNpz8jMv7gzpWeO5XuiH2JRFH59/pJ+Dnv1Ti+J0oFHOZtE
 l53dK1yeI6PPZeJCp0xNjQcKohKAMedEozVZa9mLKEq4uF07PX+eNLMv7wXy7OGi0/dveqn+q
 YQBTyWq4+CkG3sgufvgl+ukTSmFpfInkn4rOZpKbLJNb2YJt+k6KDb13UhShzA0+RwgX3zcdQ
 wMcC8kdkFEMrMg6kLNTtu32w==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

