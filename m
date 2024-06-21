Return-Path: <stable+bounces-54843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C4B912EAA
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50C82816CE
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63F17B424;
	Fri, 21 Jun 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ6iTLsx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1BD16849B;
	Fri, 21 Jun 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002316; cv=none; b=uPoiGQH1iD5yO27HeIgXRH82J/iNJSbAzfcFyJtRMjtL1Sw2SGhP9XdsuVgjM0eui641HRFJc3I2C7LaZzO/COtVjTrvJn9OyvhE1jDPntWo0EaUhWUU2gLRKywC/fFmQ3Y2dRpyYo+Mtgnb1Da8nFGDvfrexoB4r5rDE4E9PSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002316; c=relaxed/simple;
	bh=kxCos6Oo8EnAGNgnS+fpj/XrN6oxAT49kHPVoUghJDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avVtq8Kyk0erJE16ujgtnuP7kWlYQtb0J53rQnPsdmVwNv/ckOhikvT8GpUqvwteTsj0M/+4m1PQfKO1GjdAlu5xx9SxCl94SnshINH7SDok6/bz+QV24xO82gvsUZ4IOGifo+Gtxlf0qW9KsKVsEYFWWBeWCnyrdTmOq59W5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ6iTLsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D602EC2BBFC;
	Fri, 21 Jun 2024 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719002316;
	bh=kxCos6Oo8EnAGNgnS+fpj/XrN6oxAT49kHPVoUghJDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qJ6iTLsxB7cVwFQvU/Z22JgLPPj1J18DR5EFMug4PWch2KbQuPsOaTfjtDsny2rhp
	 MkxG8FDbq9dED7GY+EZfwvkuK/ZK0g14vwLP/Ib/40uPngvO8hKvNN77PKgIQCJ7gf
	 MvkQARwYrTMY3WdmcD+pnTs0hCktWoMo2VpaxOv17gS1WLm9g0vmycGrfJ6XY17TLc
	 rIhuJoD31vV5HTD1nQ7y3dKX0DB4ka07YvKS1qC2oA/JUjZIYZCm8XZG1VE7d249gy
	 5M2xbXxE0i8W4CE+mXhsHWoDG8W+a2i9uZnuKqZPNnkb4J7Ngj2nDGRnPJFWT2/pke
	 ZDmQ7U7vuIz4A==
Date: Fri, 21 Jun 2024 13:38:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ghadi Rahme <ghadi.rahme@canonical.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] bnx2x: Fix multiple UBSAN
 array-index-out-of-bounds
Message-ID: <20240621133835.2a9225f0@kernel.org>
In-Reply-To: <1fee07fd-3beb-4201-9575-5ad630386e2f@canonical.com>
References: <20240612154449.173663-1-ghadi.rahme@canonical.com>
	<20240613074857.66597de9@kernel.org>
	<1fee07fd-3beb-4201-9575-5ad630386e2f@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 17:59:42 +0300 Ghadi Rahme wrote:
> I have tested this approach and it worked fine so I am more comfortable now
> changing the patch an sending in a v3 undoing the changes in v2 and simply
> increasing the array size. I believe now that using FP_SB_MAX_E1x instead
> of FP_SB_MAX_E2 to define the array size might have been an oversight when
> updating the driver to take full advantage of the E2 after it was just
> limiting itself to the capabilities of an E1x.

Sounds good! Just to be clear, please do include the explanations you
provided here in the commit message, with the necessary edits. There's
no limit on the length of the commit message.

