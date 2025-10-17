Return-Path: <stable+bounces-186250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42CBE6E55
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038551A67A34
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 07:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEF7310783;
	Fri, 17 Oct 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uWwyv5cW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAE30C61F;
	Fri, 17 Oct 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684977; cv=none; b=A0VaHctKARulc8r5reH5q2sJyK62OmXwRkr1qF12x3mq+8IhVvoZmqn8WyzUVn5ocNhlel+GYwBy5KSRelV9KJL1S8GgQ2XVyNWdWzqsgWjj/pFleAkejrThafoRqNqlWTqc3Z8nwEa0gj89qSQJZgwzcFWfbfnLVVTsgAaYDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684977; c=relaxed/simple;
	bh=jV+TUIskuSaW4PqPLIhhgcZ+dMmdnbPKzrkpZD9Ujmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNwXPTBZAopnrV07hZyByKMQfueYRzfSiDcRaIjtIjZs18ZfveDCnRgWMlvhpAfqKpvPJxCBse7Avi6J9yLMTK7B2ChKDkcqL5djb/G3FBB9tnAq5fHfy1Yj7PwTOqIyhm3ptIo2HPYCwSaUoVAoDpSsqZmKOEWh8Jp2aSCmuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uWwyv5cW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF20FC4CEFE;
	Fri, 17 Oct 2025 07:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760684977;
	bh=jV+TUIskuSaW4PqPLIhhgcZ+dMmdnbPKzrkpZD9Ujmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWwyv5cWRtSUZESQHsSxt0/MxePRymFTASYKjv5ennh9et2DqUSl5g3Fb2Oks1dM7
	 ZIKajvWjbwvIZz6vSk7puZUH456bgWf+4vsYPH5O+Gjqd4krvN7YpunM9vqJkxBkNw
	 pcVHhZXXiuux19HFZI/u6ajs1VA1OsxrpM8Sx92k=
Date: Fri, 17 Oct 2025 09:09:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: Apply 2f13daee2a72 ("lib/crypto/curve25519-hacl64: Disable KASAN
 with clang-17 and older") to 6.12
Message-ID: <2025101729-squatting-resale-9042@gregkh>
References: <20251015003231.GA2336835@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015003231.GA2336835@ax162>

On Tue, Oct 14, 2025 at 05:32:31PM -0700, Nathan Chancellor wrote:
> Hi stable folks,
> 
> Please apply commit 2f13daee2a72 ("lib/crypto/curve25519-hacl64: Disable
> KASAN with clang-17 and older") to 6.12 (and possibly 6.6), as upstream
> commit 6f110a5e4f99 ("Disable SLUB_TINY for build testing") was
> backported to those trees, introducing the warning for at least 6.12. It
> applies cleanly for me. If there are any issues, please let me know.

Now queued up, thanks.

greg k-h

