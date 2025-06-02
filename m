Return-Path: <stable+bounces-148945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C9ACADD8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE87196047F
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958C1537C6;
	Mon,  2 Jun 2025 12:15:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550912A177
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866524; cv=none; b=MtCavTZvkWCiIFhw6dwsheKrXFmytRurbbL8UElDBBJztE91AaHzhKQeGmeWhSKd8D+ALL76Kiid0WWm/sLPt1GJ8FNYX17m6AKDOMQuLwLCbqtXR+Wo1aVXBvyWD75FQfnXdz88CSNmLKBbbB6S1U0CZK5pfw3EO0Ki+Cjbx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866524; c=relaxed/simple;
	bh=5TWp4FYSF7IRfRrQXBQs9PjwinMsojelEkGQYjOmt5k=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=Nq36KaahIavARSlnEUXtLAttdv8UJCVHnAoSsOLv/WWJexfCWrvUXuKVNYYnMNIAlKaP6FoeRKNdzzrgp7xvPY2U/vpxJvQDel0CwoLSKZ2HtcNyk31o6lmsSVsb+x9y+zX5GO5+wEPWqugb4WX7/C2aJbHrc3a3MRKIfxjz9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D325D12FC;
	Mon,  2 Jun 2025 05:15:05 -0700 (PDT)
Received: from [10.57.28.79] (unknown [10.57.28.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF6213F59E;
	Mon,  2 Jun 2025 05:15:21 -0700 (PDT)
Message-ID: <1b4c75ab-4e3b-44ff-9737-5d175b95af5b@arm.com>
Date: Mon, 2 Jun 2025 13:15:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
To: stable@vger.kernel.org
Subject: Please pick 0c8e9c148e29 and da33e87bd2bf for linux-6.15.y
Cc: Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg, Sasha,

Please could you pick these commits for linux-6.15.y:

  0c8e9c148e29 ("iommu: Avoid introducing more races")
  da33e87bd2bf ("iommu: Handle yet another race around registration")

which in hindsight should ideally have been merged as fixes during the 
cycle, but for various reasons were queued as 6.16 material at the time.

Thanks,
Robin.

