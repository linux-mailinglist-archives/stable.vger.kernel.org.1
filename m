Return-Path: <stable+bounces-135160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB30A97336
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9031C3B8CDC
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35B296166;
	Tue, 22 Apr 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFBqYEdY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A084A35
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341184; cv=none; b=cu44bA4d0Aqc3hmthSDShWzDhdsU6fZurU+rC68QG1fRUEf23T9S6FNF/8auzMrIWNPAQs6LbFygZMQbhZtjOtq5vowd2TPiLgXxWCUpFxvB6HU90tO1qHQcaIr1ONyofioo1UCHsPilT09QuRpGCWVCpfu26MuQKRg+fDeZXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341184; c=relaxed/simple;
	bh=f+InRCKJ1bfJn6zHbXeT8xJc/8bFxoQGeYQWHYL5J+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maASbDEWpGuEiNxO2Ai3Ns4Ha5qsolGrdys/GqCchi4AnuHfL/TcyA0mL/byiAnFn2Qs/1A/B1KAq+LpKiXr76q8gN743cZuRAq0AbYyb9xK98XNN/lDYIeNP7TKKX01JRfgGQFE6HlLp0iCUFc41LD9nwOQMW/C3exrfsRYNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFBqYEdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C33C4CEE9;
	Tue, 22 Apr 2025 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745341183;
	bh=f+InRCKJ1bfJn6zHbXeT8xJc/8bFxoQGeYQWHYL5J+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFBqYEdY/z6+p6AAwbj3ms0hWRGx/7JH8ze9h+MF4EmEnsla0v06TgN5A7AWepSmh
	 W4mkHYa0P/ZwKm+5Hr9m3HM+dxWu42hrrgx8tbXYYsA5vzY31h6rv+zuZ4hBp1qb5G
	 a8pfr1Wh005bxzqZdjU+hQ+ayyBn67btz+cyObN7tgPEJH2ItbmWMwx5HdN+UMrUKQ
	 cJttCtau3KWjt7rVZcrXPvDQiO/DmJ0w+/vDWCXkeRhpi/kXuz/XWxrlC0/GSNpPCR
	 swFcePArn2V9CztqSs8ds6WNMF+dj1L7UOE97FoDFEvxpHdAj9OtS5SfxFgtOZP4Ww
	 ec4Sgi5FcbLLA==
Date: Tue, 22 Apr 2025 09:59:40 -0700
From: Kees Cook <kees@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.14] lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP
Message-ID: <202504220959.7DAFFC4@keescook>
References: <2025042119-imbecile-greeter-0ce1@gregkh>
 <20250421154059.3248712-1-nathan@kernel.org>
 <2025042230-uncouple-ajar-0ee8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042230-uncouple-ajar-0ee8@gregkh>

On Tue, Apr 22, 2025 at 09:20:41AM +0200, Greg KH wrote:
> On Mon, Apr 21, 2025 at 08:40:59AM -0700, Nathan Chancellor wrote:
> > commit ed2b548f1017586c44f50654ef9febb42d491f31 upstream.
> 
> Wrong git id :(

Should be cdc2e1d9d929d7f7009b3a5edca52388a2b0891f

(ed2b548f1017586c44f50654ef9febb42d491f31 is what was fixed, I assume a
paste-o)

-- 
Kees Cook

