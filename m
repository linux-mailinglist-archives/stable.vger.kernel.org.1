Return-Path: <stable+bounces-94684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E237B9D6974
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C41D161585
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1B1C683;
	Sat, 23 Nov 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwKCfZ0u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C7566A
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372588; cv=none; b=bmolg+l2YgTyoGYxTasrltZBvqONaipBL5NkSu3j3L94c/jnTi+oyTNAAIKc/iq0jr5DNvQ/VraE9uTmT31hUblcMA/cWC6kIHhUxJ+QyOjom8ZRgJ7K8hD9mvFZhB8VI/5QmlIRtQTKMjqH0RaYqwpzKHVBj1WRcJ5qphrmD1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372588; c=relaxed/simple;
	bh=dzXHJhk4PUM8zStmi8vFbtNS+czx2OxJtwNqdc4TY9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqnPTayynkNC3yc++MzuW4JoIcPZPhh84DeAIT+kRpj8um5mjsGWwffM0O4klvrh0lJ/d7f49yXsWlyaK5gCwHT9nqNiBu0ZIp8Z60BBaMWMESjsf+KcFO4d7Pna3xewo6mZEMesAFapHzcMYY0w7p9P8QO9JIpwDzoXx+iYN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwKCfZ0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFA3C4CECD;
	Sat, 23 Nov 2024 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372588;
	bh=dzXHJhk4PUM8zStmi8vFbtNS+czx2OxJtwNqdc4TY9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwKCfZ0ujbaxPqaXPh82nDHNpo0+CeKD4OEb9k/CFH8J0PlND1XvID4EP0cDVd0tN
	 JLYChV210XJzerXzHKQGp0Va2ydjxrZkZwkx5FCGN8Vl7QhnC7xgSfrrzHolBQMMWb
	 4VtRbRVNgD4l6DG7hY0KvYxtcQwf3S+ZZhjlTfPCABEH8IlEtdgnBQe1ond7B4Y8YL
	 EBiA0rBj64CbyzWn0/HmSvitUQAj0VHwYRyu+mV1bbH6npbuhosftal0U5NRZ1NlJ+
	 Z5WXn3hUrmfqHF/0kf3XaFQN8TuQq0U+5ChxA79vB6+CaMvYk89dIs3iSnCDlWzRkD
	 WGiCXAh1EwNUA==
Date: Sat, 23 Nov 2024 09:36:26 -0500
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6 1/3] net: fec: Move `fec_ptp_read()` to the top of
 the file
Message-ID: <Z0HoasOBIo1y_vjc@sashalap>
References: <20241122083920-54de22158a92c75d@stable.kernel.org>
 <30b031c5-b3f4-44e4-9217-c364651ab28e@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30b031c5-b3f4-44e4-9217-c364651ab28e@prolan.hu>

On Fri, Nov 22, 2024 at 02:56:40PM +0100, Csókás Bence wrote:
>Hi,
>
>On 2024. 11. 22. 14:51, Sasha Levin wrote:
>>[ Sasha's backport helper bot ]
>>
>>Hi,
>>
>>Found matching upstream commit: 4374a1fe580a14f6152752390c678d90311df247
>>
>>WARNING: Author mismatch between patch and found commit:
>>Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
>>Commit author: Csókás, Bence <csokas.bence@prolan.hu>
>>
>>
>>Status in newer kernel trees:
>>6.12.y | Present (exact SHA1)
>>6.11.y | Present (different SHA1: 97f35652e0e8)
>>6.6.y | Present (different SHA1: 1e1eb62c40e1)
>
>1/3 and 2/3 of this series was already applied by Greg, only 3/3 was not.
>
>commit: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")

Dare I ask why we need it to begin with? Commit message says:

	Preparation patch to allow for PPS channel configuration, no functional
	change intended.

-- 
Thanks,
Sasha

