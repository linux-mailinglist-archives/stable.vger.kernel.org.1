Return-Path: <stable+bounces-183376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737FBB905D
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DF9189AE33
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1BA281371;
	Sat,  4 Oct 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXDHV94w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A123183F;
	Sat,  4 Oct 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596992; cv=none; b=kj1nrTMujxXs6Rzq79zeQTxGqfqdG4joBzk9vPibVslTLp7gc2BjJJBQ45Stl7Lt2p0jMKP8yoytowBBkjBddMEIbGenpzuKkNeFCSETc15H1Sk2UP7Rh5HVs2R1LN89wIRLcAWGidplTyMlS1NivhqxbJNERadwoFufrJeGBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596992; c=relaxed/simple;
	bh=GbSS2s6Tqj5av7SjOR8btii8CxGfihWeGED030TOZPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDG+7ZAoyYtBJ603+CCtden60Ou6ywsMfBkYMGhW7qnxhk30ct9m+FZ8mpqQstHr94MZ29VK4T0xX9UDKSEVK14fUTKxEXxm/a3pKSNAXTOTVbh0cuohMqWdcb+4On5v/VSaWrDh6wj8/TM/x1o2rBbYnOvo9mA+TeW6hQsURQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXDHV94w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E561C4CEF1;
	Sat,  4 Oct 2025 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596992;
	bh=GbSS2s6Tqj5av7SjOR8btii8CxGfihWeGED030TOZPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXDHV94wJQliGkoUtEzGfwy23uaflGx2iPTuCo317pN41QuZ0nrgwvFgZ9Xbl/jzb
	 BTlr8E2XBPit3Ic5rHDZXOs+YV2FIsG7Bhg2Op8lYbtCIVQSVw/rTJq3X9JbjUic/4
	 Tw8ZNadti46rbO/rdrr30lmf/poX5WQY7xSghT4pN0i/Y9FpZQaR8Lvj76A0cHG5df
	 /MCcTKQ2hHicmUufhxRbPMmQFFeNSSodwUMMiSYBxct3qUzSWKPjNpysZ1Tg1feQyF
	 6IXjgqYNj/OXx6Ev3O8VxEmU5vSWxO5NbAodV6HXF/p2HJW9xoKII4Q4dCWvJS68U1
	 kW4XTNskf2LJA==
Date: Sat, 4 Oct 2025 17:56:23 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Phani Burra <phani.r.burra@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Konstantin Ilichev <konstantin.ilichev@intel.com>,
	Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Andrzej Wilczynski <andrzejx.wilczynski@intel.com>,
	stable@vger.kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH net v2 0/6] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
Message-ID: <20251004165623.GN3060232@horms.kernel.org>
References: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>

On Fri, Oct 03, 2025 at 06:09:43PM -0700, Jacob Keller wrote:
> For idpf:
> Milena fixes a memory leak in the idpf reset logic when the driver resets
> with an outstanding Tx timestamp.
> 
> For ixgbe and ixgbevf:
> Jedrzej fixes an issue with reporting link speed on E610 VFs.
> 
> Jedrzej also fixes the VF mailbox API incompatibilities caused by the
> confusion with API v1.4, v1.5, and v1.6. The v1.4 API introduced IPSEC
> offload, but this was only supported on Linux hosts. The v1.5 API
> introduced a new mailbox API which is necessary to resolve issues on ESX
> hosts. The v1.6 API introduced a new link management API for E610. Jedrzej
> introduces a new v1.7 API with a feature negotiation which enables properly
> checking if features such as IPSEC or the ESX mailbox APIs are supported.
> This resolves issues with compatibility on different hosts, and aligns the
> API across hosts instead of having Linux require custom mailbox API
> versions for IPSEC offload.
> 
> Koichiro fixes a KASAN use-after-free bug in ixgbe_remove().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes in v2:
> - Drop Emil's idpf_vport_open race fix for now.
> - Add my signature.
> - Link to v1: https://lore.kernel.org/r/20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com

Hi Jake,

Maybe I'm missing something simple here.

But this series doesn't seem to apply to net due to the presence of
commit 7a5a03869801 ("idpf: add HW timestamping statistics")

