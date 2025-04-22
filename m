Return-Path: <stable+bounces-135106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F64EA968AC
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E36189C693
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BFA27CB3F;
	Tue, 22 Apr 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N39n80Xd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4A14A4DB
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324052; cv=none; b=RtiXjb/0H2IxqaQdif5L9uzNTktRHUYl5e+vqWFxb2D42NFeUgrHu/PXfeQ28h8I68SOw2dI6gpFtPMpJU6clmbXChIpeHv2Zta0dhJz7OBWpH5H64wjV3idenVlkWBf11pRfjfXF1ow4j2B39we617c57wt+PPOW4clLbAaVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324052; c=relaxed/simple;
	bh=UspZ3BoRYuZw8+/dd4pixLxuPsZrxp9Nr4HHiLTSvJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGwu8Z6z1suJQpdw3G/OF1VeyVyzyQoNniwENjNJ7rBpKvJldB9+c7GgME3VRaESH40Cuv/jofHAI1rat8B/AHOz/F9JRKDcYyrmUtVZFDAkaTrXXDwlY/ednimVX296Q7PAPOwlDKfQe8hSg7uLwGpH46E/VyKwJyU3NYobBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N39n80Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D687EC4CEE9;
	Tue, 22 Apr 2025 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745324052;
	bh=UspZ3BoRYuZw8+/dd4pixLxuPsZrxp9Nr4HHiLTSvJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N39n80XdmM+ZU3HzWYqv/EeVzLXPgdd0Vu0S3uL0lu+oZzchkTLMJTM78HSkMPwVl
	 I86M5Dbs0SZVIRJY0eOEBp+QBm1VMhnhvjNyTQreIcCuJNsOILEaNBzR0cAA1jsF1n
	 Tecutl5yMThyrX15NA4whGaHXJ/2h3KrG8jUDViU=
Date: Tue, 22 Apr 2025 14:14:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 4/4] mmc: sdhci-brcmstb: add cqhci suspend/resume
 to PM ops
Message-ID: <2025042202-profile-worshiper-c2b0@gregkh>
References: <2025032413-email-washer-d578@gregkh>
 <20250324221236.35820-1-kamal.dasu@broadcom.com>
 <20250324221236.35820-4-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324221236.35820-4-kamal.dasu@broadcom.com>

On Mon, Mar 24, 2025 at 06:12:36PM -0400, Kamal Dasu wrote:
> commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream

Not a valid git commit id :(

