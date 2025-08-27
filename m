Return-Path: <stable+bounces-176449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE97CB376ED
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 03:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D921B6794C
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E281C860B;
	Wed, 27 Aug 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raznhjdS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80013AD26;
	Wed, 27 Aug 2025 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258148; cv=none; b=W2Rm6MMyBpjqX4CI2XADpqA/5Mc8hhaAP2C7d46K8uy5D4ZTBZxE91BHe26jYoAVxzLbXukCCVqtkwygFHIdks0FFqX6nNffBI2rAWTisqQ6UIloQrMH1iWCHoyTLVdqBhOBmNUDEdVdisMTfD4iRGsaeYxxmk7shaPjcdHAt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258148; c=relaxed/simple;
	bh=x6aN7qO9ADVrBrseK7GUxjeEkMMpxPvFqOotLrXJpQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNXo8Tr97qTzCSaKbFArqH0xo3znbpr72Cz+saoycR31+v8UCa9HAq9MF9makUk1H1avN9Uz4twbENVaX1oMA+KFcu8+Cmgdi9s3MiSp9pZtcvufahEhL8NRMfE4lKwJKNORISt1Nu6Ep8FCXFL9IrwcBr9T6b1Wa1TcLJtrWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raznhjdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA818C4CEF1;
	Wed, 27 Aug 2025 01:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756258148;
	bh=x6aN7qO9ADVrBrseK7GUxjeEkMMpxPvFqOotLrXJpQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=raznhjdS6W8w0bSToOYGYqS0Uqgu2FdH6dX5Y5rz7R6QkfCEVk+lgg4FR+Wk4aQ3B
	 w7kljzbC2ivrW5EdFys5G+G9KLINidZ4GYmtnCa1xXyHjAsu7ziKg8pQTVhS5KTl9F
	 sL9ed4/+ZM7NgBhN1AckTEmJd2VL6Wm4Bwkk7IEEkoKNxTmZBpeLx9S45fkBReP601
	 iOs6w23/J9wFfyiszAlKSGWnENLr93ZzMfpOfQnwAwKgw0XvfC4V53LAvJT5vi7Ohc
	 a3Lu3IJzIR3AYpCEOTf7B9+B5w2R453kYOkdWCkNXlBKhrpRSwsdqEdjbpWUr+Nb0F
	 cDKNjPAkutwMg==
Date: Tue, 26 Aug 2025 18:29:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: bacs@librecast.net, brett@librecast.net, davem@davemloft.net,
 dsahern@kernel.org, netdev@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: net: add test for destination in
 broadcast packets
Message-ID: <20250826182907.586b1cc0@kernel.org>
In-Reply-To: <20250826121750.8451-2-oscmaes92@gmail.com>
References: <20250826121126-oscmaes92@gmail.com>
	<20250826121750.8451-2-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 14:17:50 +0200 Oscar Maes wrote:
>  TEST_GEN_FILES += tfo
>  TEST_PROGS += tfo_passive.sh
>  TEST_PROGS += broadcast_pmtu.sh
> +TEST_PROGS += broadcast_ether_dst.sh
>  TEST_PROGS += ipv6_force_forwarding.sh
>  TEST_PROGS += route_hint.sh

This applies to net with a fuzz. Could you respin against net/main?
Please repost as a new thread, you can add a link to the discussion
under ---, use the lore archive.

Also nit: maybe lets try to sort somewhat alphabetically, e before p?

