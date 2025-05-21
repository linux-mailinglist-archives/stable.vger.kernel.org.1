Return-Path: <stable+bounces-145727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CB6ABE8D1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14E57B55B8
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEDC1494A8;
	Wed, 21 May 2025 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+rrYzLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEB13D8A0;
	Wed, 21 May 2025 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747789538; cv=none; b=IbUXj4SNmQygeRsub0LD8gZ2KwvIh+F0REq6NS3JNSDR5Tm9M5XjMBFVntqgbBymBPbhK2hdWvqPsP2BzmasYRpkbsa7bMoEqZRKZjNBAPz/zZeDzl0/phxw3YYlgFwRro1hFtH6Znz0bsA6HiHcQi95p/a+L/nfnbf9GnjNb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747789538; c=relaxed/simple;
	bh=mjJH9AG9tTP/Tg3XQixBhGC19W0ImUuio5yB+96LAQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwgFzrJJt7nQbmgD5K5vaHQjOGgpHCofHV1jkJGXPKfsXjdydfDhEA/No4UTqiIL+2GM3djTiWeNjEz1FYzH0amGCaxGas4bmVdwzuyIzGTFVQaEbpUIFI35rgm+My1asnWLiseuNC6dJU8arlW9nsaTVcq34l8qxxjNXg8ykds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+rrYzLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300C9C4CEE9;
	Wed, 21 May 2025 01:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747789537;
	bh=mjJH9AG9tTP/Tg3XQixBhGC19W0ImUuio5yB+96LAQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+rrYzLEBsXkguc601/3H5YSVH5gq41LP1rxyioHMLPqjits9zKP+IMYRr4vd9Bcl
	 dOQvOXL77dyLs8PHV4Z1qJAs4fK0GOTYt3V+OcH6nM3RMMBDwwMaTPR6J/5QQxOkct
	 JQzIQXQ7T0fdsA2YDSbzKeb4dRjcQPHNUf0CjXYvc+h+VilNtM0kstItzVO1dIT2H5
	 XEnx4VK/iYzkOn+4MaZLoGRRbB178sHp8T+a/py9SEV5FliOe/gOnD3SPuFwp1r3zG
	 QI1rJJADyGGoJ2PIqh9/sBK/OOs/+cSaNhp783l7Xv/QomoFqlaNzco68byxLbikzS
	 61heOne/kYzdQ==
Date: Tue, 20 May 2025 18:05:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ste3ls@gmail.com, hayeswang@realtek.com,
 dianders@chromium.org, gmazyland@gmail.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] r8152: Add wake up function for RTL8153
Message-ID: <20250520180531.44930f89@kernel.org>
In-Reply-To: <20250516013552.798-1-vulab@iscas.ac.cn>
References: <20250516013552.798-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 09:35:52 +0800 Wentao Liang wrote:
> In rtl8153_runtime_enable(), the runtime enable/disable logic for RTL8153
> devices was incomplete, missing r8153_queue_wake() to enable or disable
> the automatic wake-up function. A proper implementation can be found in
> rtl8156_runtime_enable().
> 
> Add r8153_queue_wake(tp, true) if enable flag is set true, and add
> r8153_queue_wake(tp, false) otherwise.

Please explain how the problem was discovered and on what HW (if any)
the patch was tested.
-- 
pw-bot: cr

