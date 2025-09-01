Return-Path: <stable+bounces-176917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C06B3F153
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 01:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2374A485636
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CA7286883;
	Mon,  1 Sep 2025 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fvELgIHp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e/PAGHRN"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4F2820B6
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756768936; cv=none; b=eaQADSUN5TeUKvd6bqifRivZFt9GkHTu9fBrZGW0RFkF4krGdBqCBTxOQEbRgLR/RU2ruD8IeypuBgoTHrK0kiEPWJezxHlgJQjdeWMcZ8YSGtqvIJ+h8l3XNAnIlBYsxL3RtnLBwvLW1+nqOzmB0U7tmqWYZ2/ReFp+SwJKtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756768936; c=relaxed/simple;
	bh=3CpaHgtd2qOvoQOBlxT7d04bgnj8YWGrf+Cex/sfKPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YW+qU58NWd+z65j7ZjCh6SMjn39mHnRshpm4eLfUh/9MHDVb6QadeDluKA+XsPVNn2n/i6eGS8RxjM7jtbFl/e5ZRrXw4r4cuGyKl4v38WKeacZbpYsjMaAhBBgZxlcbiClHWzbPptEa0iNmHXLs+e8TThH8lT03n+xC5RiN2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fvELgIHp; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=e/PAGHRN; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cG4dw6wxBz9tcV;
	Tue,  2 Sep 2025 01:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756768933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5afNqgQ0RIJR4mQGPcJ3hjbeXGchYjXKY5ghY6nuQUg=;
	b=fvELgIHpkbK5L6kmS71c39RxcOURph4KO+Y0vStfwMNc8phwPRXULPAZqhhoOPC+7wWSYf
	z2AzPgvwrYAUzSBam/zg4jwESljeXfkCLPStp5jhAUrjAYxaVjFDsux2Nmc+lXkbiHg299
	HtXsNGQvnQ6mLJ+P5Coheo1R8q9M7gu9y2R9ZnsYR0obrgDaKxF8fW9w5P9yEy/dk+n18p
	NPCmrVoBHs5CtATDx3XvAlv8T6pkjDhEy6NCUUhgcBezqXVomdQpb1HrycGw0anHINiomq
	7pDsrZISDeolSls4Q6oX8QEIOITr8YsdGR4Ha96ThfxDPoAY6WN8Lt7dwgve6A==
Message-ID: <812e6ad9-c95e-4c0c-b088-35bc880a8622@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756768931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5afNqgQ0RIJR4mQGPcJ3hjbeXGchYjXKY5ghY6nuQUg=;
	b=e/PAGHRNCMo8zIPIJMO+cpgvmy9jo2xGv81x1sw17/yQ4H/HHJZg+VrnPiqCDCfdktoE5m
	T5sOk0Z7gPrEu21PAVEcAyKckiA4qMAAAxw3DgKyq2JCRHBStGaLnCQj/YnHhzitwlPiZQ
	OJJMBHhcC8rkk5scUvpzQv2iXckp9Niimd6qxI4ZtNY0H9ykKfJko0HwgmxkPqL13mkSmH
	wu0yJKRRxvrHvk8GsxlgP2gmeF7dmCuK06rF5Gy9FnVXmzrTMueUNswFYmh4h00uOn9Ra+
	VR0FnPioiXk3XAL9R+AXahGaWxWn5d5F8N5NpMMkIG5QL0nnWVqENOpMveTXjQ==
Date: Tue, 2 Sep 2025 01:22:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to
 PCIE_RESET_CONFIG_WAIT_MS
To: Greg KH <gregkh@linuxfoundation.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: stable@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
References: <20250831202100.443607-1-marek.vasut+renesas@mailbox.org>
 <2025090152-dance-malformed-653f@gregkh>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2025090152-dance-malformed-653f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c8b74e9692ac4a9a093
X-MBO-RS-META: pzbk87mstngptit3fz9g4a1kqezfnk3s

On 9/1/25 3:40 PM, Greg KH wrote:
> On Sun, Aug 31, 2025 at 10:20:48PM +0200, Marek Vasut wrote:
>> From: Niklas Cassel <cassel@kernel.org>
>>
>> [ Upstream commit 817f989700fddefa56e5e443e7d138018ca6709d ]
>>
>> Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.
>>
>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
>> Cc: <stable@vger.kernel.org> # 6.12.x
>> ---
> 
> You did not sign off on these patches :(
I hope the V2 is better now.

