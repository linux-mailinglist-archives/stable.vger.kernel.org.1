Return-Path: <stable+bounces-155208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B0AE27F6
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D61179C4E
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEE1CDA3F;
	Sat, 21 Jun 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CtYRMPs3"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757D46B8;
	Sat, 21 Jun 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750493999; cv=none; b=HiyW9OHvKljQKRJqPkFIv3KXp3hCYjS9we3KTuXfntcR1CRbE83O5OvGWc1lgo2VlnYiQaLkzlXbAqHRAjFXhI4kiku+orWFwNGwVz7m35ngpRT85NRJJpoMKqldJRiSi/UOARMbnL5pRc0wguq2o0gyCKaPBgWdbKwnki2y2YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750493999; c=relaxed/simple;
	bh=ExN3PwrTws7D27NKE2PuUIl8NaeHhlK+ItahVxxr9Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvo6h+657k4rlsRFh72K0fDlwblqaaVAuUcev04GYOArWcdrZC2TTVhabcDtZJ07xRb4Y7CeHc8mW4sxUGaNk6BeV1+6ZCcQDjVV4ucb9r4zCcYGk8MI/QY8pKI01CMDMqOTQ2qvu3//6i3ypGnNRiqtJnB0yQE6oj0C21UKhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CtYRMPs3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750493995;
	bh=ExN3PwrTws7D27NKE2PuUIl8NaeHhlK+ItahVxxr9Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtYRMPs34hoW8Q7SSIqNbn5KNbZ8XVouKyi1TmRNyLb8dblczHGtJFVToi5lL6hgG
	 7/bVoEcQqEZb8Exuo5d/1bumzllE44GyLuscMkRuW6weulZDUx0Osp/SGZajyjrpzp
	 eE/E+BJA491/sFf9adychV6a4g3PF5szVGFDv40U=
Date: Sat, 21 Jun 2025 10:19:52 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: fix spelling of FD_SETBITMASK in FD_*
 macros
Message-ID: <e5561bc6-8220-4088-8bc0-0aba62c2cec3@t-8ch.de>
References: <20250620083325.24390-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620083325.24390-1-w@1wt.eu>

On 2025-06-20 10:33:25+0200, Willy Tarreau wrote:
> While nolibc-test does test syscalls, it doesn't test as much the rest
> of the macros, and a wrong spelling of FD_SETBITMASK in commit
> feaf75658783a broke programs using either FD_SET() or FD_CLR() without
> being noticed. Let's fix these macros.
> 
> Fixes: feaf75658783a ("nolibc: fix fd_set type")
> Cc: stable@vger.kernel.org # v6.2+
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

Let me know if I should apply it.

