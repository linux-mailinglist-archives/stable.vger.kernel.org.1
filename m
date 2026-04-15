Return-Path: <stable+bounces-238153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPa4JiC632mOYQAAu9opvQ
	(envelope-from <stable+bounces-238153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:17:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DBF40651D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D2A3017C00
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A8730FC33;
	Wed, 15 Apr 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+kJeeA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ACD40DFA7;
	Wed, 15 Apr 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269845; cv=none; b=UoOY4eRN8kAwvYcWZmBMErUwjoyRMa3R0b1EZA0j7/Lifu/BtTTeZHkirvSt5oVYN7Ur6fN/uBycc9MQGevLGiNfuKTO8IPJCtGS7Q2urgk2wQcVIkMnqSMUiAkyFvC6S97iBgpzk+xW9CB7UlNSVOXcf7YUUUsIp+2q8EXUBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269845; c=relaxed/simple;
	bh=ObP4Q43FL+RVMu+5SHEP0abI1ltYtBb2y+YqFs2GNog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOkc2Gl2yyeOIdDtTFOETC+kqkVwGEaE5aaWkRq+wUPJlYhTs0mVICyCytwSE8+iEnrLfBqVAMHaylEVIMTEPW4A4enRblKHNzzaqZyI62XvKM93UoVkwl/tSM55clbE+VB5GJC+GSgzQMByZGVFybsQ0rUh+7CfY+u0tx2BGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+kJeeA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9425C19424;
	Wed, 15 Apr 2026 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776269845;
	bh=ObP4Q43FL+RVMu+5SHEP0abI1ltYtBb2y+YqFs2GNog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+kJeeA4kRw6T6Xd5VUPhpj+GBA6M+PwTxrEsPI6gmd8rrwSgPfC2wqw3hPwG3Pox
	 fzaxnFfveEjcbMGKJMZVYE8HdniTTwCAhpTIsaNNagQ8VVFqIJadE3BKtBm3KeRZj2
	 zOB1yCfqRULFsaeBiQRktKEajgJXnASbWFqfLX1KSN2LZNH8frOAq8+JMOrINW1fbM
	 sfBKq2fhACstl3pAZA+QYGETa2ywRCTBGgGLkFTwa/ZvdVfzlWpyIAFLukm1i2jA3b
	 iuYSv9QmKvV5AIkF94KpBXTymzCdgJvaQJ9w/6GecXPgvYoopmNl3aRmHrEe6+NEq2
	 yp4gE3oI6ATuA==
Date: Wed, 15 Apr 2026 17:17:20 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ixgbevf: fix use-after-free in VEPA multicast source
 pruning
Message-ID: <20260415161720.GN772670@horms.kernel.org>
References: <20260413182427.298513-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413182427.298513-1-michael.bommarito@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238153-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09DBF40651D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 02:24:27PM -0400, Michael Bommarito wrote:
> ixgbevf_clean_rx_irq() prunes frames whose source MAC matches the VF's
> own address (VEPA multicast workaround) by freeing the skb and
> continuing to the next descriptor:
> 
>     dev_kfree_skb_irq(skb);
>     continue;
> 
> The skb pointer is declared outside the while loop and persists across
> iterations.  Because the continue skips the "skb = NULL" reset at the
> bottom of the loop, the next iteration enters the "else if (skb)" path
> and calls ixgbevf_add_rx_frag() on the freed skb, dereferencing
> skb_shinfo(skb)->nr_frags — a use-after-free in NAPI softirq context.
> 
> The sibling driver iavf already handles this correctly by nulling the
> pointer before continuing.  Apply the same pattern here.
> 
> I do not have ixgbevf hardware; the bug was found by static analysis
> (scan_drop_continue_loops.py + semgrep drop_continue_in_loop, multi-tool
> corroboration with the highest score in the scan).  The UAF was confirmed
> under KASAN by loading a test module that reproduces the exact code
> pattern (alloc skb, kfree_skb, then read skb_shinfo(skb)->nr_frags):
> 
>   BUG: KASAN: slab-use-after-free in ixgbevf_uaf_test_init+0x100/0x1000
>   Read of size 8 at addr 000000006163ae78 by task insmod/30
>   freed 208-byte region [000000006163adc0, 000000006163ae90)
> 
> QEMU emulates igb (82576) but not ixgbe (82599), and the igbvf VF
> driver does not include the VEPA source pruning path, so a full
> end-to-end reproduction with emulated hardware was not possible.
> 
> Fixes: bad17234ba70 ("ixgbevf: Change receive model to use double buffered page based receives")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko flags a number of issues in the same function that
do not seem related to your patch.

I'd suggest looking over them if you are interested in
follow-up work in this area.

...

