Return-Path: <stable+bounces-158331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061D4AE5E9A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943EB179F5F
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63CD2512D1;
	Tue, 24 Jun 2025 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh10Jv5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F9A945;
	Tue, 24 Jun 2025 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752037; cv=none; b=YaYEkuEWUGKx4+7sB/NuiH10GnPzY7SrbFXjPgQh8mbxn+kHuvnlwXLJ/1nPq9dQGW5a6Vz1rvA8SB1Yzsfd5qG2JilfhbzDps+ZMYkXDFcfk3+L4ct2ctBsHs7N3aoyyEM1fPpah0OJlt3GXNMjMJajkfdoRWglBdrmVl/f16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752037; c=relaxed/simple;
	bh=/3COIW2kBCI+cqtF+kPUQwmKwHunxJ5XXV+BJEx23Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBssLaFSPK+rNKQUbVSvcFV0nYJQd/jwOPGUuuIrgT/CguTLe9r4knu8kkWrU6jXPlOhTj+gIVqj2wHI6iMzZh1WrO3oqvXgQVsQHjYlqi9gDJr+bNIxgRT38Ffd7RaRak9UBozjVLMQ1+B/FyXOwP+Xkfhojt3hcy2CEHQKcsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh10Jv5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424ABC4CEEF;
	Tue, 24 Jun 2025 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750752036;
	bh=/3COIW2kBCI+cqtF+kPUQwmKwHunxJ5XXV+BJEx23Pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sh10Jv5ZknvZ2NIcQa2hoOQ3HNHr87Lyks7QaQjTTLTtNBtgkP+8jub4vVyL+YbXz
	 G7NsSPJqDqnIFZpvMvhbREFzw/xpIootpQDwt+EXqNDVmLf89In/7hsyhmmY+B2Goz
	 9fFqYPRQRmo+56e++yOEBw0H3opw53/QixofHIZQrsFDO12OxL+F7JQv5sf4j/d6WN
	 Ea060xhK48eOonpep3HWoCJej1epZ7eb3XCrHb6aRANoQ8IZ201IQuiWmkUcKvIdbg
	 4Fwsv/d89qkPlzaB2tv59bvFbNznx6yK6i2NGbQ+yUO4JgoDuxcpUgEaYOY1PWgA1+
	 WBkMeUSS3hFCA==
Message-ID: <78c03f67-7677-430b-8c47-c1338797ff0d@kernel.org>
Date: Tue, 24 Jun 2025 16:58:32 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: Use correct DMI identifier for
 ASUSPRO-D840SA LPM quirk
To: Niklas Cassel <cassel@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: stable@vger.kernel.org, Andy Yang <andyybtc79@gmail.com>,
 linux-ide@vger.kernel.org
References: <20250624074029.963028-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250624074029.963028-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 4:40 PM, Niklas Cassel wrote:
> ASUS store the board name in DMI_PRODUCT_NAME rather than
> DMI_PRODUCT_VERSION. (Apparently it is only Lenovo that stores the
> model-name in DMI_PRODUCT_VERSION.)
> 
> Use the correct DMI identifier, DMI_PRODUCT_NAME, to match the
> ASUSPRO-D840SA board, such that the quirk actually gets applied.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Andy Yang <andyybtc79@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/aFb3wXAwJSSJUB7o@ryzen/
> Fixes: b5acc3628898 ("ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard")
> Reviewed-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

