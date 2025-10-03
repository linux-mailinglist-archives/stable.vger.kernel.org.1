Return-Path: <stable+bounces-183306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86220BB7CA4
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C3C1886972
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF02DAFA9;
	Fri,  3 Oct 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0i+gG34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFC83A14;
	Fri,  3 Oct 2025 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513346; cv=none; b=NmraPdvzXfV9bJYDd91Z3KfOOYuiXl3LQawS0u3zlfruGWWMLzcbPMQi8g1RNET1LWm1KuSfBgPNy2dRJaSE1n4NkStl9d6eGNrLky4C9rdsWSItO4zmcvwclFflRkJMtqwMemaqXy6IoWigYF+mrOJcJMzxW3qTnPt5coY+sY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513346; c=relaxed/simple;
	bh=lZYJScLjxlWBkteTLTslow8sxOL7/wctKcsoC1oFGXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgdlJc4DPGr8VfaAiVb7fzXJPrE21QNL7TPTMcFGdguY0MPUwJrqyYFb7t87jiuqOgNwN0nwPZ8U9Zk23MFZ1W+fBliULwRtCTw8kc4Hd7FxRc/M1xrLi9EJu1VipzAwNW8UHLutk5MZy3PVu+uqo6ZgN6hOcQwZQMdyGJP5BV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0i+gG34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCA0C4CEF5;
	Fri,  3 Oct 2025 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759513346;
	bh=lZYJScLjxlWBkteTLTslow8sxOL7/wctKcsoC1oFGXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0i+gG34tQU4kLNulUTica+1jKzCOUPQFRVgAPbR5Qv3FibJvTG8f0fU/kee87Yn4
	 +lPTps4S9A7vlbrANqulX4tI6Ox4nV5EHk4JH1ltDMd79exKfrjskZcmoDfBM0pumS
	 MtgWpi+ouR9tHZpog8goSRlFf76J6MOPFEJT5zJAgp4ZWV9mlfqENSc+RzZLu5qZhn
	 o1RHh9M4bHmmzND5xdk/L80Z79UFFapJewoENyy38tZJIQ7Tg+2hDxpLkwfXqnMYZc
	 EoUcJGmVxJt/zgRxZEACSLE8/6hHPR5D7RNZFWbdF7T9BHQewzdh+7l5AqzXSpt1ca
	 e+n9ymTSmfZIQ==
Date: Fri, 3 Oct 2025 10:42:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Emil
 Tantilov <emil.s.tantilov@intel.com>, Pavan Kumar Linga
 <pavan.kumar.linga@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
 <phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, Anton Nadezhdin
 <anton.nadezhdin@intel.com>, Konstantin Ilichev
 <konstantin.ilichev@intel.com>, Milena Olech <milena.olech@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
 Chittim Madhu <madhu.chittim@intel.com>, Joshua Hay
 <joshua.a.hay@intel.com>, Andrzej Wilczynski
 <andrzejx.wilczynski@intel.com>, stable@vger.kernel.org, Rafal Romanowski
 <rafal.romanowski@intel.com>, Koichiro Den <den@valinux.co.jp>, Rinitha S
 <sx.rinitha@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
Message-ID: <20251003104224.59777107@kernel.org>
In-Reply-To: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Oct 2025 17:14:10 -0700 Jacob Keller wrote:
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

We need your sign-off on the patches.
Sorry for not noticing earlier.

