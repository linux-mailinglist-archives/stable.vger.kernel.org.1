Return-Path: <stable+bounces-54876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4EA9136A2
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 00:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86F7B24AB7
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 22:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F39DDCD;
	Sat, 22 Jun 2024 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UCLhw/nK"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20145FB9B
	for <stable@vger.kernel.org>; Sat, 22 Jun 2024 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095670; cv=none; b=YJDh7Wq7KFA5TkFAIjBf6+ULTUuZ1Gab5+udXveYrMc19qv8f2INsuCSoDJuOh1XVMQZE4WEoUb+ZUrfLf2Es6XKdCN8/m11+oGWsbRm7kyEQWW0x+HlqLdAplZw9w6F8ZhI+2NN7+hgQv1wrfY344kCUAlCoO9Lf8Uy6x7UaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095670; c=relaxed/simple;
	bh=4tiKZl2zw5vkXkjqOn7hJcQJAj/R5uhilTcoAbs3qXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETKAtdsWZFqHyq2do1WdLf9LgsFWmvkifrvy6xh9P0jfJPrCMWqbeQE+Z6MUijqNE6zbiHeK81jX9pM1onOU/pgNcS5oQW1Mu7cq5Xc/57soAU6hO4Fi97oDNkKq24pjFsmwOytdS3mUK98zV0+K3nqqAZdVpjmbbBMsWEPRLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UCLhw/nK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2B64E0002;
	Sat, 22 Jun 2024 22:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719095660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LIGShAqySxw3ATO7IfMdaO85UyQ5vDAdZfgC2/hd13I=;
	b=UCLhw/nKLkCE005HQ5EKu3Uf6hskMft++8KNqmGUVJwQQsr9B4MDJBappr4ZFq5bTG2gx5
	FW3637ur85CcSKIX72x8btPRhUEG6vBBpkWkTXJKEYsn54CcdsFS8cJ+VYIy3p8EWXx1EW
	TTKttdSBeQuliHLnCVmm+Wm5O9w2FZMNjRUziSeJ/501A1e807WB1ZaDgFDtswp4Wl5lkq
	lAUGfYmCxJPnQSKnKYgNfRNmkzSJDbHpe2wI44MwUn76+yFQuu/x/q2Zdq1XnX1JmpLP3f
	aRMQPV1Xu3GMWxsZAjMiml+FzfNrqSJaqvDVrHxChLBbpHLgizQz3pFCtnhbrw==
Date: Sun, 23 Jun 2024 00:34:20 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for
 HCI versions < 1.1
Message-ID: <171909557751.2164405.4665114035482836727.b4-ty@bootlin.com>
References: <20240617113251.1159534-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617113251.1159534-1-jarkko.nikula@linux.intel.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 17 Jun 2024 14:32:51 +0300, Jarkko Nikula wrote:
> I was wrong about the TABLE_SIZE field description in the
> commit 0676bfebf576 ("i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes").
> 
> For the MIPI I3C HCI versions 1.0 and earlier the TABLE_SIZE field in
> the registers DAT_SECTION_OFFSET and DCT_SECTION_OFFSET is indeed defined
> in DWORDs and not number of entries like it is defined in later versions.
> 
> [...]

Applied, thanks!

[1/1] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI versions < 1.1
      https://git.kernel.org/abelloni/c/17bebfeab08b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

