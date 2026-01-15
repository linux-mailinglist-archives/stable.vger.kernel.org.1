Return-Path: <stable+bounces-208434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B807D240D0
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 12:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E31183033985
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99CA36D50A;
	Thu, 15 Jan 2026 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1Dy72NB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65E3624C4;
	Thu, 15 Jan 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475055; cv=none; b=YlEkbckJ0HcEq1HqrFToUmOBOLv57Wd9HJh0njkBIGnzC9FRCYmIoqz6Fg7ZTDVGOrPqKxmMcxZ5S7oAqE1M3CsV8t3HOBTSweBWfklhCzUPyI2YMo1ptwH9XenefJqj5SCZdugoX2wG+gHxE7UrO/369G8c0yMled0eFPp63KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475055; c=relaxed/simple;
	bh=oacaXfNwtgadGbDRtoW9sWVI56vKZfB78SLPD1qvy3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DqwKl4elimwaaOmN9hS9fZj0V5oYWEM9HDr8q1ODJ+/7DQ5rnIwsxQL5/Iz+hITVkb3rFSVoamemeI6vknibL30puQkJd1tQp3wttGp/Nopn+wmwVksi+QYTNgOdKjh8udN0IHV3QQ7sR8JGetNkwkB5MfAidr61Mkj5Zk3F8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1Dy72NB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA77C116D0;
	Thu, 15 Jan 2026 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768475053;
	bh=oacaXfNwtgadGbDRtoW9sWVI56vKZfB78SLPD1qvy3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A1Dy72NBG7kfHUE1aC3X+8Z/Yvm+Zai2Os1nX22iuFFO5AUnO9Z0NWs6pmEPGF1T9
	 u3uel31uVzbQmnRJeXptgI832wPrC+2flkq+v9tW3b03XnUNQH6sWqHhBo3L4wjMgu
	 maeXSkpOy7MqVM0qE3NUzvKL/YBy8l46GeVcggV1uflcJgyUGGwb4OfWvnBAH5ubmS
	 h9iRBdyWzcOai9lGPKl2PYG3laz9GBCxA+ojvbokzN7tVSkKmQ0XEtJeNy1sWhuBeR
	 sk9NcEvV+SofilnLBaHXDBhxxu9xE2vamGE9eLVgszHJNfM4m4ppZA8NfjDyqxg1+G
	 FNh1LZHgtZORA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Michael Walle <michael@walle.cc>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20251231120949.66744-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251231120949.66744-3-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] nvmem: Drop OF node reference on
 nvmem_add_one_cell() failure
Message-Id: <176847505176.52334.6176414458558837392.b4-ty@kernel.org>
Date: Thu, 15 Jan 2026 11:04:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 31 Dec 2025 13:09:50 +0100, Krzysztof Kozlowski wrote:
> If nvmem_add_one_cell() failed, the ownership of "child" (or "info.np"),
> thus its OF reference, is not passed further and function should clean
> up by putting the reference it got via earlier of_node_get().  Note that
> this is independent of references obtained via for_each_child_of_node()
> loop.
> 
> 
> [...]

Applied, thanks!

[1/2] nvmem: Drop OF node reference on nvmem_add_one_cell() failure
      commit: 3bc276e70c0cd66350a9a5d39bd3f638de362941
[2/2] nvmem: Simplify with scoped for each OF child loop
      commit: f28a32e7a5c5eb27679236d0aa20979f0353f52e

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


