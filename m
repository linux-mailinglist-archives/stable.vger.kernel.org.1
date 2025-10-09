Return-Path: <stable+bounces-183695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EB5BC909F
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70A804F9A95
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265523E334;
	Thu,  9 Oct 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adxxw5cS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0639523A;
	Thu,  9 Oct 2025 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013160; cv=none; b=nsCAx62ZSPCvpsQA+2c71gtNu95RRA44l/SZWhJYJD9n6hdbWLKXAbWZb/u63Ah8KEHSdMyzAScAQ8QZq41ItgX5Ax8hRJA+fLrman1MxMitQ8vJjCKYwSmNbfjUG6jlN6Py7JfVFay9M2k0cYC01DM+hz5rMZqZBi1ngg2K2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013160; c=relaxed/simple;
	bh=kOQ62hzNRfxXQio1GfpBiqLQK3jn8IRfmjGxk4hY4VU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OCUPJn9vzAiQHzogiSvTpD5Vt1AJbYWFuWSWF9XeyMTKH910Rq6UUX8S5E2uAocP+JxQhzT1N2VHi449w3Mu4uIBs59DLEk4KTX2j4RcfqlQSwh8A7P2O2VISYzcuD/g76y36sNZsPfUBS1dU0iiU0Kc2JbDdE+4eMt5dg0IOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adxxw5cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90D3C4CEE7;
	Thu,  9 Oct 2025 12:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760013159;
	bh=kOQ62hzNRfxXQio1GfpBiqLQK3jn8IRfmjGxk4hY4VU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Adxxw5cSBif8CKRrf2tDtkWHUksHyiNwPs25vLmsA2O67zdSIaPgbIjPRROzhwlXB
	 HudRfOjim/m4gPdZ3dEfaAaG7knDiyExo7u4L4FgwjP7cAbfjpim2Mq8KeHU4iWS2X
	 EDRMNBcJvCwoP6eCJ9LEGdXLnKp4NjDZS7OX0s2TemOBOB0FlpQ+Z2a5RxZQ7qbr83
	 tYWz+gsmJLncRLlk5e6SvCL0QnAZEZg/iPyUktIH6SLc2Devy3g1lte5yKGQ4sWU6t
	 +XVJkkOZSB6wad9wyPExg2mVET3HN7LOH1SYVdQG6lAlBa1ZT6e87PERTGIEStOROG
	 qkjR2fzRJ0XBQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250925150219.24361-1-johan@kernel.org>
References: <20250925150219.24361-1-johan@kernel.org>
Subject: Re: (subset) [PATCH] mfd: altera-sysmgr: fix device leak on sysmgr
 regmap lookup
Message-Id: <176001315848.2814183.5153117784242287470.b4-ty@kernel.org>
Date: Thu, 09 Oct 2025 13:32:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-b87af

On Thu, 25 Sep 2025 17:02:19 +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the sysmgr platform device when
> retrieving its driver data.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: altera-sysmgr: fix device leak on sysmgr regmap lookup
      commit: e6ce75fac4a299805939e33f9f104829ba9ffdcc

--
Lee Jones [李琼斯]


