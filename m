Return-Path: <stable+bounces-185869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85DBE1177
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 02:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69C274EC2B2
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87B364A8F;
	Thu, 16 Oct 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuhhYyqH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5ED1C69D;
	Thu, 16 Oct 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574052; cv=none; b=PAc9JmDhdV4Co7E/rY+lq6exo827yMdwxMB/t6AooEUys1wop8EUBEOSfQK06dkFJLDSspUStWuuDRDqTi8JzLRwo4eTayYEJy+awP51cDOuvOicyMsPI3CvgDw18poIlsCUC+DEZma4OPaKXmrk2XvPUIdxoHczGob7huLjDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574052; c=relaxed/simple;
	bh=mjXQjGcqZW3rSyWGQMi9ntYLHm3rktZp0EcvQaOAXtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZ0sk0zGqsTreUNmJ0CMiT5O5c1lLxEdNBftkl5f33rTkxm638m+bkd/PdP5ZwZLKC9A3BDtFC2sBk1Hi4SsX+mX8axixljHfGAgNR61IgjvVvdwF5xVQzRbWJQv2geTrpk1880JBJXB5nsCZluKjyLiRx8SzGSl4Diy5RpNCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuhhYyqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49ABC4CEF8;
	Thu, 16 Oct 2025 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760574052;
	bh=mjXQjGcqZW3rSyWGQMi9ntYLHm3rktZp0EcvQaOAXtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fuhhYyqHRdvx70nok2XfxxEUbH4Vt55w0F4Il9F6aiN1cpBke3o201smCkcVxryrO
	 J4Nef1kwKphDtiTNJwOxD2Jc3eskdQRnv/Knqrhj4QR0KNV1+3U63Ku1np/T0FSVlX
	 HkrErT+uztNS1cPlTF31EO+5zy+22vvSew5MsbgoKyV1NyHU2HY3nS8xUlDxgLTMey
	 xU/ypjrl7+hH+UXNV2g/E7MUDWiGZ92gR3jwYrJirhzXyHR2rcYohkATshig3CSxKz
	 3/10u1kcJGSXNrwxTlgBegcYKmtuZIVFdatWtVhCeRK+AVX17khHGDO34q7jkcYKGS
	 /Fw3VHHDp5p8w==
Date: Wed, 15 Oct 2025 17:20:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 oneukum@suse.com, horms@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, Yi Cong <yicong@kylinos.cn>
Subject: Re: [PATCH net v3] r8152: add error handling in rtl8152_driver_init
Message-ID: <20251015172051.7d115f5b@kernel.org>
In-Reply-To: <20251011082415.580740-1-yicongsrfy@163.com>
References: <20251011082415.580740-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 16:24:15 +0800 yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> rtl8152_driver_init missing error handling.
> If cannot register rtl8152_driver, rtl8152_cfgselector_driver
> should be deregistered.

This has been (silently) applied on Tue, thanks!

