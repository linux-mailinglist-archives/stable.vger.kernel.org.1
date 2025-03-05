Return-Path: <stable+bounces-120407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F29A4F91B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 09:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544203A4F6B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583141FCD0D;
	Wed,  5 Mar 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN57DOKY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE81A2388;
	Wed,  5 Mar 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164399; cv=none; b=lDw7qVoiOp1IgK3ZqgjgHxngRzQDbqGJCHgAhkBIaXvmQHrhMyWvNWDG4Di2XOnHHwG89SawcoAkGZG3yjfBbuGEbzbK+HJc3SgeNpophjuhMZpOJcW+X3JWfyi1ZYbPL5TsW4E+bopbL8fYoNZlBiMauBmY5PtzqbBN6YNx0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164399; c=relaxed/simple;
	bh=Jz+c5bFhkX9r9NTZTuayVy3zTVqR+oD/k6MtQbMnxYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9tuMONZg/6HxCy78YYSLRc6vUeD7VjB3uC1/bClhEkMXYxP7eiHuszDHu3lJ7FkjdJZcRwmV7jEKQTJO2dteDH8Sdmzg1eQq+9WqOfKyetV7rF+rUxNmUyUDwd+bkzOROzY7rtvQhSNsWbOVVEcKdkxJ0R5+AU0H48PL/GRMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN57DOKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727D4C4CEE2;
	Wed,  5 Mar 2025 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741164398;
	bh=Jz+c5bFhkX9r9NTZTuayVy3zTVqR+oD/k6MtQbMnxYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN57DOKY0w+QpwebWMTtBYNQ2WnuFhP36m/x+PfuJPgsqVMgzhSZ3GQlgePZ7pnTs
	 /0m67N/Na1+8wx3jJXzvrMHTQRmqu3GaILVV2pSRNU0wm4LxRfQlXVE1TFqPMnx8az
	 yodKjSLwNK2vKfcCBgfz+6XcRCmAIlgZ8JCGr7svpfeKWupcCE01zLGnbTIZDtVgID
	 cPy+52G10yZlGIIidBs1cwImrH3rchwoQa1Wdq+WbfjcbYRSWY02r10eKaHSxgpq7M
	 CXpljmiRnh/6KKG2OHV0nadvFZmdVv/4e9nSe7sUeR9j35pXLWkbGkL4/HgMDnWi7E
	 TVNk3xCZJeNfQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tpkOg-000000004rT-1YUU;
	Wed, 05 Mar 2025 09:46:34 +0100
Date: Wed, 5 Mar 2025 09:46:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/8] arm64: dts: qcom: x1e80100-dell-xps13-9345: mark
 l12b and l15b always-on
Message-ID: <Z8gPaoqLiC_b2s3I@hovoldconsulting.com>
References: <20250227081357.25971-1-johan+linaro@kernel.org>
 <20250227081357.25971-5-johan+linaro@kernel.org>
 <CAMcHhXp2im-55KxwSUj0pV_hmrg-HaV5RYB4jvPOoqOYjJuCYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMcHhXp2im-55KxwSUj0pV_hmrg-HaV5RYB4jvPOoqOYjJuCYw@mail.gmail.com>

On Sun, Mar 02, 2025 at 11:04:03PM +0100, Aleksandrs Vinarskis wrote:
> On Thu, 27 Feb 2025 at 09:15, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The l12b and l15b supplies are used by components that are not (fully)
> > described (and some never will be) and must never be disabled.
> 
> Out of curiosity, what are these components?

A host of things, including pull-ups, level shifters, regulators for
(partially) described devices, but also things like the speakers and
wlan.

> > Mark the regulators as always-on to prevent them from being disabled,
> > for example, when consumers probe defer or suspend.
> >
> > Note that these supplies currently have no consumers described in
> > mainline.

Johan

