Return-Path: <stable+bounces-171850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89EB2CF73
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 00:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1592C1C42108
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97121221F0A;
	Tue, 19 Aug 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RJ/5viLu"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B635334A
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643154; cv=none; b=J1AAaXyxJKAsmYnv8vHNd9vlUy5B3cEX9ezi4ig2dKU1qlK8BTU+BtwhrZSVbqB0PJRlbs9CXg1JQ0yW+LBnCOjHkfC5JsvWBzpq/uO+fcV7rV0/7DhGHo2OyqTyKzz1MZ4cXMzM3OBheMckRLd/jLF2zp7/ZzNLN7A7u4s9oi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643154; c=relaxed/simple;
	bh=1mx4yJF+fr0Mgeyiu/+zLBNvdoIQjrQ4nTq1lf0mbC0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AWK/ZuAXMLvYEcAFVGg0qDKkAxGP3Mo7HoH20JoUi45shKsDGxdbI7raIP5VUiLb2ayJvstK/OtcR1jzma5YoP427H8na5AgXrISk0YpwZE8jtCCZs7VzvkNjxruZZ0jud81nO/gdu7S4gHFLncMGbv/e2DacVkpyMJ2CH5H7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RJ/5viLu; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c64JD4PG8z9tFH;
	Wed, 20 Aug 2025 00:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755643148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0CirfeFDW4HmeMmSGS6r5e4XHxSpUX2QokgqBzstre8=;
	b=RJ/5viLuieulHIG2ftgnoHtj1lAjH7WqISEsTyTWOsJVm1O4GZ9rZ/c8pE1eONazAq6JS3
	kpJZUde0fbFbiwyPTZv2wyFbpDHe7lH1wDf2ZuJKbO2LYlMF6UsYBfoKObLHWoaX/jXcMz
	FI9h8zC5qLO+iVjw0CaWu4tN1RhNo6ND8fF0j88J/R4HcW/tTZZ4TbF7HKlG9PqNVHJUom
	SUzIyxu5XM6EXJXIx0AqS91Ll37jSsVQ6UCoK3dNShBGCQEGs8/jx47F3MdscMdaXEQjhM
	lcQaPhE68z9RWJPq7UfZRg39i93Ps4zUL+Fx0JbgrCtJdyduSpq482FaApBKww==
Message-ID: <29e310e4-4ef9-40bf-9570-7b72e0369ce4@mailbox.org>
Date: Wed, 20 Aug 2025 00:39:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-stable <stable@vger.kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link
 up
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: da1f01bfa7dbc0c574a
X-MBO-RS-META: izzsfot8bkwjgha81futtmq8j65hnes4

Please backport the following commit into Linux v5.4 and newer stable 
releases:

80dc18a0cba8dea42614f021b20a04354b213d86

The backport will likely depend on macro rename commit:

817f989700fddefa56e5e443e7d138018ca6709d

This part of commit description clarifies why this is a fix:

"
As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
training completes before sending a Configuration Request.
"

In practice, this makes detection of PCIe Gen3 and Gen4 SSDs reliable on
Renesas R-Car V4H SoC. Without this commit, the SSDs sporadically do not
get detected, or sometimes they link up in Gen1 mode.

This fixes commit

886bc5ceb5cc ("PCI: designware: Add generic dw_pcie_wait_for_link()")

which is in v4.5-rc1-4-g886bc5ceb5cc3 , so I think this fix should be 
backported to all currently maintained stable releases, i.e. v5.4+ .

Thank you

-- 
Best regards,
Marek Vasut


