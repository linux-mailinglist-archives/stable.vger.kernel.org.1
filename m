Return-Path: <stable+bounces-172866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795ECB3459C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 17:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F91B7B0B81
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3FD2FA0FD;
	Mon, 25 Aug 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYwqcOCa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD729AAF3
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135216; cv=none; b=HnHN5t+lsDzpJ/6pPi9ddGm8RziTI2msz4Qg89yVyqBJXdNS7ISXANo7MjVTsbiPu26BZe7Jtr6xmFSwrqjlMnPDxziAdg6GoMdyucFonPYnZffzbOdCDyBCnTmnHVlEL2rYs1PWh3HwjfhcgPdJNyipAKvffUTxQrQi9QwUGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135216; c=relaxed/simple;
	bh=AdWF9cHM9kNYLxrI3+vuaaPoaobJ/mXizODikIYtlSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmELv5QHLoRLnG0zM9Y1yavbakpBc333DnELdfVOLCLbe6EnlTpU1wdwBGqg+2um+L9hmOHc16PqFssVPRl7V/zrNzXQGZLVdCXd2Ooenw6QxZWCZYMxDOeJD7Nhw89CHqmTVr/56gDfqvk2G9jRs1oS3r1MXQ+2xNSY8GmcHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYwqcOCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC76C4CEED;
	Mon, 25 Aug 2025 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756135215;
	bh=AdWF9cHM9kNYLxrI3+vuaaPoaobJ/mXizODikIYtlSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rYwqcOCa6wVYjOSsKb4eM5VvYcVobiZIbK7L7ecae5LcpCn8YLdQvfEfGD92CiNZ5
	 TgMsX5JFsQXP1vixajS/5bxhOzz5dvkAwMRwuKN9jUcK62Lhyk8FqmkiwmMGjEmkUd
	 07NXrrGgrMg/PEl2MbPJpdD8L683baieR03j26+KmfKtoa9CFMLy/iAqI3h2i6oUlg
	 zlUCTLb1KCwU++d7aYwQhBmcHz3Hw54Wv+msd+OYtx+KJvYgSElEfOlnh0OIs6gurI
	 fSuBx5GLARq1UknZGKU8XjCa8rVMmTR+8qoOgTV8M6b8cB96OeJMzs3W6aobc7Ut64
	 ozp8rH1smsQUQ==
Date: Mon, 25 Aug 2025 08:20:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <gregkh@linuxfoundation.org>
Cc: billy@starlabs.sg, ramdhan@starlabs.sg, sd@queasysnail.net,
 <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] tls: fix handling of zero-length records
 on the rx_list" failed to apply to 5.15-stable tree
Message-ID: <20250825082014.0a713fee@kernel.org>
In-Reply-To: <2025082443-caliber-swung-4d8f@gregkh>
References: <2025082443-caliber-swung-4d8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 11:07:43 +0200 gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This is not needed prior to 5.19.

Sorry for not including the kernel version in the stable tag.
I suppose Fixes is not taken into account when identifying where 
to backport the patch?

