Return-Path: <stable+bounces-183380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAABDBB9117
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 20:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A424188968E
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F282737FB;
	Sat,  4 Oct 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYhnvgaS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E91E51EF
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759603289; cv=none; b=aoExqwkOg2xMhnwupiUW3sMvYaVSEmTQrHv9BS1KhsVO9g1Mar7DXUJK4W8JUnTPdfnxyO3/+kyt2hAY/81ol261f4NurhVtZfUtf//od1VdL2mMgFgz7+f4xNoE5n72/UFf4xM9sVkNMNvE+/nHS2Vpqaw+roCaX6n3Bm+D5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759603289; c=relaxed/simple;
	bh=tfnjCEx0sQ+E+0kwMooucESZIA3uU0vY4ALV2gkqkrs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lK0axwpmetrl1Aq5qZQJijEGsGv8Mdw53Tq1W/RxFAdymO8H9I46HlsurTVERb02UZLFOnxLf7UidVjRu6reyVdPnJTH3A7B8DWdgwEK5g7zv6jJ6PlI6nQgmRsnLpmL8UZQhoHICWsF7oEr4GbVi01BGENd9ssdCbxCo2xpe20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYhnvgaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FACEC4CEF1
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759603288;
	bh=tfnjCEx0sQ+E+0kwMooucESZIA3uU0vY4ALV2gkqkrs=;
	h=Date:To:From:Subject:From;
	b=FYhnvgaSPcgoFUX3uifoIwuYMtUQNCUGrja55ScjIdGtE14kEi12PV119iZxZejHl
	 UcmG3qOmoGEGhgz8quw8mRMe+oBY0diobdJqKrmdwvlfzpRHfJZOrY+u+BqA30+qtF
	 2Vr4grCj6YtC89f7bLJBtvxAvFfVRqfoskhmNvtzAuddmKVQVmmOUGSY/Cq0RN1Kc1
	 PRc5Z/JE5QIl+RJFzwu1rcdyOUG1O9nvYCYIEmHvJKc/5r3LNgNa1e/RX2hBCDlJ6w
	 dB4ACeU5rtPzYWQ0gXVZwC21MmFj+yycAjKDXHI0AXi85wh0TGOQTMUuLBoUl571+Q
	 W80ToBU3DJI5g==
Message-ID: <3c147f99-0911-420b-812b-a41a26b4a723@kernel.org>
Date: Sat, 4 Oct 2025 13:41:29 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Subject: LR compute WA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

We have some reports of long compute jobs on APUs hanging the system. 
This has been root caused and a workaround has been introduced in the 
mainline kernel.  I didn't CC stable on the original W/A because I 
wanted to make sure we've had enough time to test it didn't have 
unintended side effects.

I feel comfortable with the testing at this point and I think it's worth 
bringing back to any stable kernels it will apply to 6.12.y and newer. 
The commit is:

1fb710793ce2619223adffaf981b1ff13cd48f17

Thanks,

