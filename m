Return-Path: <stable+bounces-132763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F54A8A3EC
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6868E189FF20
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2E20FA90;
	Tue, 15 Apr 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J37axF8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DD1F4188;
	Tue, 15 Apr 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733966; cv=none; b=U4LfdMSCc1lQNAN4vcayZ9IZRjxvB1LAc8Hc/IgQvXQN8RUodEdiyUOGK2U5LnaO9QouoS79YBFcK9dycumkuhu0XJUxt+gPeSTH41ZxiG+PAzRlH3qeNDTceO54aZXW88LFqnUu6g+XOrjbHDTC62PdzZfme1B3CxtCaecqoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733966; c=relaxed/simple;
	bh=ZZU+HEFLzUVha5RjZfYMMSbZbRdTihiRbwfO8ZnjQRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8Rtj5j1BFj8JtsbxaZLApPrND+4jRAnmQEtgl4P/vpqanRm9eb20j+6lWmwMRKfs4Wpg5kBWEktN64UBY43COy5UExdEatxvv3KxhvX8DHVsMXtG9/pRBDjiMj/ZoVnU4zqcgDEM+IUaI1V6Y/d/1teIcGHLMFx2ADSBS5F4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J37axF8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B589FC4CEEB;
	Tue, 15 Apr 2025 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744733965;
	bh=ZZU+HEFLzUVha5RjZfYMMSbZbRdTihiRbwfO8ZnjQRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J37axF8IBClP0d4y3lbEAVnpkI6azRXPAkNhp150ui/OB9JZKA3ohLd/rrCRV3IXs
	 0PfbDyVx8yV4IijBEfZMInp4i+w4X0e+N0h+FyR0DPwI1IJftyEQ7sOMFIvh2OKkTW
	 ly9nNNfYKyqtG+8lNYtlBPVpRE7cWE6LLXXI0qLb6AFwtoX7fD0tzBnCOjYf4FEaG+
	 2EBMYGhTRnT9vo++GDixpmBkS76/CVKlTJLMYRUw5qyVD1lnqT7cUPRBxjMYKfMRrA
	 xZ9Bctw9/VJmLDHSdB+HA+iY5qwuRzjxqgFA+kgLTj/A7NkFPXaW+u0VRuCcj6YgQc
	 OABCwj77wO8gQ==
Date: Tue, 15 Apr 2025 09:19:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-bluetooth@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Manish Mandlik <mmandlik@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: vhci: Avoid needless snprintf() calls
Message-ID: <20250415161920.GA1692211@ax162>
References: <20250415161518.work.889-kees@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415161518.work.889-kees@kernel.org>

On Tue, Apr 15, 2025 at 09:15:19AM -0700, Kees Cook wrote:
> Avoid double-copying of string literals. Use a "const char *" for each
> string instead of copying from .rodata into stack and then into the skb.
> We can go directly from .rodata to the skb.
> 
> This also works around a Clang bug (that has since been fixed[1]).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401250927.1poZERd6-lkp@intel.com/
> Fixes: ab4e4380d4e1 ("Bluetooth: Add vhci devcoredump support")
> Link: https://github.com/llvm/llvm-project/commit/ea2e66aa8b6e363b89df66dc44275a0d7ecd70ce [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-bluetooth@vger.kernel.org
> ---
>  drivers/bluetooth/hci_vhci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 7651321d351c..9ac22e4a070b 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -289,18 +289,18 @@ static void vhci_coredump(struct hci_dev *hdev)
>  
>  static void vhci_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -	char buf[80];
> +	const char *buf;
>  
> -	snprintf(buf, sizeof(buf), "Controller Name: vhci_ctrl\n");
> +	buf = "Controller Name: vhci_ctrl\n";
>  	skb_put_data(skb, buf, strlen(buf));
>  
> -	snprintf(buf, sizeof(buf), "Firmware Version: vhci_fw\n");
> +	buf = "Firmware Version: vhci_fw\n";
>  	skb_put_data(skb, buf, strlen(buf));
>  
> -	snprintf(buf, sizeof(buf), "Driver: vhci_drv\n");
> +	buf = "Driver: vhci_drv\n";
>  	skb_put_data(skb, buf, strlen(buf));
>  
> -	snprintf(buf, sizeof(buf), "Vendor: vhci\n");
> +	buf = "Vendor: vhci\n";
>  	skb_put_data(skb, buf, strlen(buf));
>  }
>  
> -- 
> 2.34.1
> 

