Return-Path: <stable+bounces-208437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4DD24372
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 12:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6693022A81
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836136D4EC;
	Thu, 15 Jan 2026 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OOYdH0zE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE8361657;
	Thu, 15 Jan 2026 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477129; cv=none; b=b1DCyRJqlNhooxXKzJyvtcwWcX8eACBWhAA8xjwdg2tdR7Tgi4nxQV6B5PgUYj2d7Ck93mE6znYEhuvPkwWgeHmjswdqdyn2Y9bOjj4IhxqSS3jJZcq3jqMRCZW5u4cvBAe2E3PPuOk9Be/Rh9cVIDSsSt37Q1z71uGiRhZFnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477129; c=relaxed/simple;
	bh=j9UOyG607tRm6XAx1xj2PrId2w2Plb51CK6VOrSvAnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgxKu1OlnroYm8VKZZJxwXWO5h9F9vin4pehLiTWXmNVlXonHuxcD7HHBNnAFmjdWhhbJ0QlNkvydo14yGX9G9u36xOVlGFI4131XI+heo2T9a34W4T3ryDwXkMRgP0Xc6lHQomacef6YtxxoHlN6pPcG48y4ikoQgR16AkZ62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OOYdH0zE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5F2C116D0;
	Thu, 15 Jan 2026 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768477128;
	bh=j9UOyG607tRm6XAx1xj2PrId2w2Plb51CK6VOrSvAnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOYdH0zEmwOWbNTs8aSaEe/NjxLG2VhHYljAowqBOBfM3m/bL+NpOLrM3iD5kN+am
	 pkS5/itLnWGEBFddstdkOBrYhWKyvRIpcr7TEyqtptai6s1R2A+Y5CLjP9jNS0Vl3b
	 bj6STvnxsEuxdYawsmk4Zxl3DJTTyyrDlLjkxD0Q=
Date: Thu, 15 Jan 2026 12:38:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable <stable@vger.kernel.org>, chenhuacai <chenhuacai@kernel.org>,
	loongarch <loongarch@lists.linux.dev>
Subject: Re: [PATCH 6.6] Revert "LoongArch: BPF: Sign extend kfunc call
 arguments"
Message-ID: <2026011537-that-theater-3b05@gregkh>
References: <tencent_09063379481F265B19AC7AC7@qq.com>
 <tencent_2AA9934C60F1658F28275258@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2AA9934C60F1658F28275258@qq.com>

On Wed, Jan 14, 2026 at 02:24:15PM +0800, Wentao Guan wrote:
> Hello All,
> 
> I think the best way is backport add28024405ed600afaa02749989d4fd119f9057,
> ("LoongArch: Add more instruction opcodes and emit_* helpers")
> I test when cherry-pick it, it build ok.

Great, I'll do that instead, thanks!

greg k-h

